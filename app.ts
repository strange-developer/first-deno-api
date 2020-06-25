import { Application } from 'https://deno.land/x/oak@v5.2.0/mod.ts';
import router from './controllers.ts';

// const { PORT, CERT_FILE, KEY_FILE } = Deno.env.toObject();
const PORT = 8000;
const CERT_FILE = './.ssl/certificate.crt';
const KEY_FILE = './.ssl/certificate.key';

const app = new Application();

app.use(router.routes());
app.use(router.allowedMethods());

console.log(`Listening on port ${PORT} ...`);

await app.listen({
  port: Number(PORT),
  secure: true,
  certFile: CERT_FILE,
  keyFile: KEY_FILE,
});

// secure: true,
// certFile: CERT_FILE,
// keyFile: KEY_FILE,
