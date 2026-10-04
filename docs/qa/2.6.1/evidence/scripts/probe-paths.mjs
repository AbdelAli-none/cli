import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { createGeneratorPlan } from "../../bin/generator.mjs";
import { configureProject, normalizeProjectConfig } from "../../bin/project-config.mjs";

const cwd = fs.mkdtempSync(path.join(os.tmpdir(), "fsd-probe-"));
for (const layer of ["app", "pages", "widgets", "features", "entities", "shared"]) {
  fs.mkdirSync(path.join(cwd, "src", layer), { recursive: true });
}
fs.writeFileSync(path.join(cwd, "package.json"), JSON.stringify({ dependencies: { react: "latest" } }));
fs.mkdirSync(path.join(cwd, "src/app/routing"), { recursive: true });
fs.writeFileSync(
  path.join(cwd, "src/app/routing/index.tsx"),
  "// fsd-cli:route-imports:start\n// fsd-cli:route-imports:end\nexport const routes = [\n  // fsd-cli:routes:start\n  // fsd-cli:routes:end\n];\n"
);
const config = normalizeProjectConfig("react-vite");
configureProject(cwd, config);
const plan = createGeneratorPlan({ cwd, type: "page", name: "account", config });
console.log(JSON.stringify(plan, null, 2));
fs.rmSync(cwd, { recursive: true, force: true });