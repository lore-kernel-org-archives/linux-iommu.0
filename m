Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794608496;
	b=odJ1gJzKmxfpnCKYIO5PY33AZZG5rdJ++HLM8DuUuCIRod66NV3PTlC9LHF5+cwP/I9M
	 E/D8B3r2VmPtNqd6xIUvl5l6b9VPrk0StMdg7lEuoR88T4G0PLe9YKUf446blherWcM4B
	 7aYSS1O9SK/IUKYzh2TQUlo5WeczDQ2J8hheIb6WnOuoZLQihgsQLXtNkxdlxAB454uop
	 biMRL5tkQE7artYMj+1fEpGK5wRZIdTkObBwpw4TbMrszBnN66Lw4L77ApQu81jrnyqY4
	 Be3x7oKcP8GiBXSEBOAGZ7Hdf1lHpa44yGaTNbXhNjnf2HuXZ6ZGYsOq34Gw2GoaedQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608496;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NM+WHKCC3xvJM0QYhS9cDObbL+6VtF3LXo9nejQ5V1k=;
	b=QkEhn5POaNli/XMRMsYUyrt5708lk+AeSuMOOp8arcfk0FHv/hKPpf5WGDnVtQIeC2wx
	 ucuRFCvy656EZMUoNrjXqbXb9zSV5dMYRhXgdjfkdl4FmvL4NR2nmU9l+YiW6DfCx1XVm
	 b/8qDC+u5tubx0hbvktHKmVcpxI0lhTW3lmjiF6Y3YCIjbQHYeGWPftsveaq0QYDET04o
	 mXcgaHNrmyX1N7GCRgAt53jug7G/iUJMbeaHV4G4/tnpqFQSJ316C+1b+h2tnPey89Wge
	 Cxsz1CS9cDP6wLXi0EIZwh+29syXninrt7FWfWUjKUAP/Q/vcnmePv9vpJ4bHdXMycw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A4rV2/pT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8CD606A8AB;
	Fri, 13 Nov 2026 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4rV2/pT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794608496;
	b=ewN0ntKT5lh0ACT6bDPfXguDsi65MwLDsFP/6fWkF/DIHwIOnix4b+PrjPJTnRIFf9dq
	 wmUCtzsOUmmetGVg6zf/dQtnf7jrM7lI7lQy/bwyZZRxLWJfhjecH2w8UJBUu171m9frl
	 GLk2wHFMFMZSAJWMyr9KRJ6SWQxuTUsrnlAAKNO8IT9jS+y4mNTg5NwAlx1IFTrgP3ytj
	 AD4Anwl8XYvnqvKy6r2FDUTH9d95qr1v2xF+AL/EPMeDUhKR/8EkmjBZynHb+FFJNSyka
	 6o8B7hPFbekdRLcbjih4AdrtcyAdYxpaOwzkvkaz4iOp4SZf8X90ZaIYL0RTsKj/siQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794608496;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NM+WHKCC3xvJM0QYhS9cDObbL+6VtF3LXo9nejQ5V1k=;
	b=PeA9HeKT3rt76RzRT28OneCUeNM0o0NryeOphAhSk6gf6JdF9nI2X1e9/CZRZ+zMBAQ6
	 5mnR9K1X1x1T3UfM+Cy90ebh6wOBzFA9MotUgR52+2Iv5/77kZjOMDVXXc9ppF1exEJfk
	 pNpdEcp78jYKjwhEsnC9eeDQG1YFqHahI80cX36F4JEPDuyflMHxqtoaEfs9BfZFVl0Li
	 GmA+hV4PZs7To5U3Unk5/HwczFXVbdYoVzXc/9G600Etct470BwirYDPvbIK7BcHL4t76
	 HDr8kXnNFATS506XTzfxvKWNnClIqomEj3tYXCm5upV/v8FaDxNWQ+UCZF38RrZ4Omw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E719B1F000C4;
	Fri, 13 Nov 2026 22:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794608496;
	bh=NM+WHKCC3xvJM0QYhS9cDObbL+6VtF3LXo9nejQ5V1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A4rV2/pTR/o5tj8tgDPX2mFhjhe2p0JhsYavPoqUhvTCuQG0DYl9DBZ/kaKFdhXM8
	 vsLJKgPWZerJVniKaynFPfRQlwZr2uoefBiBTRAfK8igRKUdtofDLo6wWA7FDAcBv9
	 EM1fhX/B2gHPv0l6DvzPOojxuUcojMZgqhbH56SbOcidcCN1zUrqJxpHgnM7gxZvS0
	 Y3bYH0PLtq9xvrhLpMtIU7sdtYrIgmn1pCVGC5kx1aSRgBYyhhJYuhCWgFvUGNOFvH
	 lFWbZ4eJZ3jTM7UgfBHuujzLv8EYtA7pKErHbOjAowiRTp+PASs3OZGtyVQWP/Zplp
	 K3K3lR9k2ZBow==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 56DBD49B4C;
	Fri, 13 Nov 2026 22:21:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 22:21:33 +0000
Subject: [PATCH RFC 2/3] media: verisilicon: Pick the hardware core for
 each job
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-hantro-multicore-v1-2-43811eea14c4@gmail.com>
References: <20261113-hantro-multicore-v1-0-43811eea14c4@gmail.com>
In-Reply-To: <20261113-hantro-multicore-v1-0-43811eea14c4@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, 
 =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794608492; l=9150;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=9jWn2Gigd2wOwask/FFepVbUYfj7D/TpLOUOJvXCMTw=;
 b=r5PrlOXvvc8lwpCY2Qqeq30CFBTVyIZ+JOpHn8bsD5t0SNYqAEvdz505CHX/2u8wcphsXES8m
 A1IfiGTY7wZBowJpTao3uOYhSzPU1ByHClzcbvqqrgGrsaPsFW8/iHq
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The driver assumes that the hardware instance running a job is the one
that owns the mem2mem device, and finds the context of the running job
with v4l2_m2m_get_curr_priv(). Neither holds once jobs can run on
several identical cores in parallel.

Give each hantro_dev a list of cores its jobs can run on, and pick an
idle one in device_run(). The chosen core is stored in the context for
the duration of the job, and the context in the core, so that the
interrupt handler and the watchdog of a core find the job they belong
to. The JPEG encoder of the VEPU2 now accesses the registers of the core
running the job.

For now the core list only contains the device itself, so no functional
change intended.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro.h        | 18 ++++++
 drivers/media/platform/verisilicon/hantro_drv.c    | 73 +++++++++++++++++++---
 .../verisilicon/rockchip_vpu2_hw_jpeg_enc.c        |  4 +-
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |  2 +-
 4 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0353de154a1e..eceaa74a634b 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -193,6 +193,14 @@ hantro_vdev_to_func(struct video_device *vdev)
  *			shared with interrupt handlers.
  * @variant:		Hardware variant-specific parameters.
  * @watchdog_work:	Delayed work for hardware timeout handling.
+ * @curr_ctx:		Context whose job is running on this instance, or NULL
+ *			if the instance is idle. Protected by @cores_lock of
+ *			the device the job was scheduled on.
+ * @cores:		Hardware instances the jobs of this device can be
+ *			scheduled on. The first entry is the device itself.
+ * @num_cores:		Number of entries in @cores.
+ * @cores_lock:		Spinlock protecting @cores, @num_cores and @curr_ctx
+ *			of each core.
  */
 struct hantro_dev {
 	struct v4l2_device v4l2_dev;
@@ -213,12 +221,21 @@ struct hantro_dev {
 	spinlock_t irqlock;
 	const struct hantro_variant *variant;
 	struct delayed_work watchdog_work;
+
+	struct hantro_ctx *curr_ctx;
+	struct hantro_dev **cores;
+	unsigned int num_cores;
+	spinlock_t cores_lock; /* protects the core list and curr_ctx */
 };
 
 /**
  * struct hantro_ctx - Context (instance) private data.
  *
  * @dev:		VPU driver data to which the context belongs.
+ * @core:		VPU instance running the current job of this context,
+ *			only valid while a job is running. Codec operations
+ *			must access the hardware through it. It is the same
+ *			as @dev unless the variant has multiple cores.
  * @fh:			V4L2 file handler.
  * @is_encoder:		Decoder or encoder context?
  *
@@ -248,6 +265,7 @@ struct hantro_dev {
  */
 struct hantro_ctx {
 	struct hantro_dev *dev;
+	struct hantro_dev *core;
 	struct v4l2_fh fh;
 	bool is_encoder;
 
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index d02988fc19ae..ab76251627fb 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -59,11 +59,51 @@ static const struct v4l2_event hantro_eos_event = {
 	.type = V4L2_EVENT_EOS
 };
 
+/*
+ * Pick an idle core for the job of @ctx. The mem2mem framework never runs
+ * more jobs in parallel than there are cores, so this only fails if the
+ * core accounting is broken.
+ */
+static struct hantro_dev *hantro_acquire_core(struct hantro_ctx *ctx)
+{
+	struct hantro_dev *vpu = ctx->dev;
+	unsigned int i;
+
+	guard(spinlock_irqsave)(&vpu->cores_lock);
+
+	for (i = 0; i < vpu->num_cores; i++) {
+		struct hantro_dev *core = vpu->cores[i];
+
+		if (!core->curr_ctx) {
+			core->curr_ctx = ctx;
+			ctx->core = core;
+			return core;
+		}
+	}
+
+	return NULL;
+}
+
+static void hantro_release_core(struct hantro_ctx *ctx)
+{
+	struct hantro_dev *vpu = ctx->dev;
+
+	guard(spinlock_irqsave)(&vpu->cores_lock);
+
+	if (ctx->core) {
+		ctx->core->curr_ctx = NULL;
+		ctx->core = NULL;
+	}
+}
+
 static void hantro_job_finish_no_pm(struct hantro_ctx *ctx,
 				    enum vb2_buffer_state result)
 {
 	struct vb2_v4l2_buffer *src, *dst;
 
+	/* Make the core available to the next job before scheduling it. */
+	hantro_release_core(ctx);
+
 	src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 
@@ -88,17 +128,20 @@ static void hantro_job_finish_no_pm(struct hantro_ctx *ctx,
 static void hantro_job_finish(struct hantro_ctx *ctx,
 			      enum vb2_buffer_state result)
 {
-	struct hantro_dev *vpu = ctx->dev;
+	struct hantro_dev *core = ctx->core;
 
-	pm_runtime_put_autosuspend(vpu->dev);
+	pm_runtime_put_autosuspend(core->dev);
 	hantro_job_finish_no_pm(ctx, result);
 }
 
+/*
+ * Called from the interrupt handler of the VPU instance @vpu, which is the
+ * core the job was running on.
+ */
 void hantro_irq_done(struct hantro_dev *vpu,
 		     enum vb2_buffer_state result)
 {
-	struct hantro_ctx *ctx =
-		v4l2_m2m_get_curr_priv(vpu->m2m_dev);
+	struct hantro_ctx *ctx;
 
 	/*
 	 * If cancel_delayed_work returns false
@@ -106,6 +149,7 @@ void hantro_irq_done(struct hantro_dev *vpu,
 	 * and will take care of finishing the job.
 	 */
 	if (cancel_delayed_work(&vpu->watchdog_work)) {
+		ctx = vpu->curr_ctx;
 		if (result == VB2_BUF_STATE_DONE && ctx->codec_ops->done)
 			ctx->codec_ops->done(ctx);
 		hantro_job_finish(ctx, result);
@@ -119,7 +163,7 @@ void hantro_watchdog(struct work_struct *work)
 
 	vpu = container_of(to_delayed_work(work),
 			   struct hantro_dev, watchdog_work);
-	ctx = v4l2_m2m_get_curr_priv(vpu->m2m_dev);
+	ctx = vpu->curr_ctx;
 	if (ctx) {
 		vpu_err("frame processing timed out!\n");
 		if (ctx->codec_ops->reset)
@@ -160,21 +204,27 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
 				   &ctx->ctrl_handler);
 
 	/* Kick the watchdog. */
-	schedule_delayed_work(&ctx->dev->watchdog_work,
+	schedule_delayed_work(&ctx->core->watchdog_work,
 			      msecs_to_jiffies(2000));
 }
 
 static void device_run(void *priv)
 {
 	struct hantro_ctx *ctx = priv;
-	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *src, *dst;
+	struct hantro_dev *core;
 	int ret;
 
 	src = hantro_get_src_buf(ctx);
 	dst = hantro_get_dst_buf(ctx);
 
-	ret = pm_runtime_resume_and_get(vpu->dev);
+	core = hantro_acquire_core(ctx);
+	if (WARN_ON_ONCE(!core)) {
+		hantro_job_finish_no_pm(ctx, VB2_BUF_STATE_ERROR);
+		return;
+	}
+
+	ret = pm_runtime_resume_and_get(core->dev);
 	if (ret < 0) {
 		hantro_job_finish_no_pm(ctx, VB2_BUF_STATE_ERROR);
 		return;
@@ -1285,6 +1335,7 @@ static int hantro_probe(struct platform_device *pdev)
 	vpu->pdev = pdev;
 	mutex_init(&vpu->vpu_mutex);
 	spin_lock_init(&vpu->irqlock);
+	spin_lock_init(&vpu->cores_lock);
 
 	match = of_match_node(of_hantro_match, pdev->dev.of_node);
 	vpu->variant = match->data;
@@ -1302,6 +1353,12 @@ static int hantro_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "%s compatible is deprecated\n",
 			 match->compatible);
 
+	vpu->cores = devm_kcalloc(&pdev->dev, 1, sizeof(*vpu->cores),
+				  GFP_KERNEL);
+	if (!vpu->cores)
+		return -ENOMEM;
+	vpu->cores[vpu->num_cores++] = vpu;
+
 	ret = hantro_hw_init(vpu);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
index 61621b1be8a2..f7550470b43d 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu2_hw_jpeg_enc.c
@@ -131,7 +131,7 @@ rockchip_vpu2_jpeg_enc_set_qtable(struct hantro_dev *vpu,
 
 int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
 {
-	struct hantro_dev *vpu = ctx->dev;
+	struct hantro_dev *vpu = ctx->core;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 	struct hantro_jpeg_ctx jpeg_ctx;
 	u32 reg;
@@ -188,7 +188,7 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
 
 void rockchip_vpu2_jpeg_enc_done(struct hantro_ctx *ctx)
 {
-	struct hantro_dev *vpu = ctx->dev;
+	struct hantro_dev *vpu = ctx->core;
 	u32 bytesused = vepu_read(vpu, VEPU_REG_STR_BUF_LIMIT) / 8;
 	struct vb2_v4l2_buffer *dst_buf = hantro_get_dst_buf(ctx);
 
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 02673be9878e..f1f7f95b2652 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -488,7 +488,7 @@ static void rockchip_vpu2_dec_reset(struct hantro_ctx *ctx)
 
 static void rockchip_vpu2_enc_reset(struct hantro_ctx *ctx)
 {
-	struct hantro_dev *vpu = ctx->dev;
+	struct hantro_dev *vpu = ctx->core;
 
 	vepu_write(vpu, VEPU_REG_INTERRUPT_DIS_BIT, VEPU_REG_INTERRUPT);
 	vepu_write(vpu, 0, VEPU_REG_ENCODE_START);

-- 
2.55.0


