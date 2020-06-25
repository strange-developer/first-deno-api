import { Router } from 'https://deno.land/x/oak@v5.2.0/mod.ts';

const router = new Router();

router.get('/', (context) => {
  context.response.body = 'Hello World hahahaha';
});

export default router;
