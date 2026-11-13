Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588038;
	b=DNBtT8tN7Jge3lkaNb7qc/CBIjo12vblbMpc/WHvIYI4CM1Y+xUMmub5Lxzub2uqzIjI
	 u5YV7qJJGa8Iz4mWKdILfcYuBoC0H8OFMzX2ku/sJOBuEjNOrj8kg/eRwZvZyuMnUPazQ
	 fxrWZvWeYfAcz9BgXIQ0WNtdQnLoH/BUyIOKEg4RRfidjRsZP0JMF1JYvLyJLZy9suGGL
	 QPnrlnoN6G2fnjVYxuBCBljGVKbco4CyJAjBdzQ+i+KkPBfpLUcDpFmXALJ0plhqwnXxs
	 XL4ZRMkBbpnFJIezf5KVfC0yLB3ksQX/Ea63J5UbmzEDjCN4YMpusHds/Imf3yJLIKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588038;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BVzq2TVxNl7sAlgFnyFmzccAIM4zI5WuCQ9eRu5l8NU=;
	b=qd1aSgqIjFdMdJ4suyp0GJ1a9W7SiKPITVaNYJKUgeqvXlc6UiXE0IcLJasvQn46D9+Y
	 a3UIV5UjJZ1SMNLJSna9wmZ1tChat4RYyVoKjbLW3GR/aHGjN9jXWC3PBHmo3XUN/cKkj
	 wqrnUhcGith86ovhN/t/lPuCrC3U+P0vHXLtUH7NRfV7sLkf5ZK5QPyubzpkUKS4gCJSm
	 Fa7j1v3/7Ubi59uyFAR1Y1MiUJaNTksk5Uncqh6iXdpPKDR8NMMN6PdMFqWqMMrWJLCBX
	 40pESHLPu2/aTFzCHWZ43COb2/SIgV/Cx/vCcLFM9Qhz8D7QCwr0wD1/SjGURNZF98Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHXM3yd2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E549606EBE2;
	Fri, 13 Nov 2026 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JHXM3yd2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588038;
	b=ikXZaXta1x22eFw9lMLSvVqrKKspEzjRVMmGJkQ/1c8R2er6CeJHQVejLwnCCpRd65As
	 j+3/jhDNDJxy9syFa0gy+HZk0xaVp1ZzwfnwoQDpGwR8nbXLB/qS9X4xYw7oRtrwZm6J9
	 8yUhf5R9CI5JGnDomHw4B2dw/+VRH9oFIyt68MKI3ol52vTlo/cruSh4Nkh6ZQc7ioYAa
	 qTcil7qxfNjr/7UuvW9t2CBZJUf4nx5J7YWoUcC47HdqnUrEr69pSvj89lRcWajESA1lR
	 9HOiwhnu15pJT23Z0YuS3oATVtZZ+wTYY8MAim/UAXwBRQztfokdMoT0C8PCYjItNLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588038;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=BVzq2TVxNl7sAlgFnyFmzccAIM4zI5WuCQ9eRu5l8NU=;
	b=vKElS6mPK+gxf3dwfpdsEHY+Ng0KuT6Tbwm96c2uUby+/LdO8iLIwevOP0l+QRQ4yhRs
	 sSZ60gU8lJedpKaA9Ia5Cqlf6tRjluTyas5OLIbaBq/5RER3cwZuEnXg2QLnEtC65RMVv
	 K1echYFveaS3I7/E10s6eX7q2VzCnzVbqTy/yNWC1d5V3CQHbR7ooDZkNea1hzFQjQhlW
	 FfaFZSV3qGurD+SDxKCn9trjZ/NcRXm/F19scP92sbhY8HMQoSOgL6gdtHNUaVXLFv+hQ
	 focK3f1xo6y6xRp6Vkj+Kixizs9/oSAjBFS/E10E/IIG2ecTS3A1q9eL8ouJ/9ihN5g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D68E1F00925;
	Fri, 13 Nov 2026 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588038;
	bh=BVzq2TVxNl7sAlgFnyFmzccAIM4zI5WuCQ9eRu5l8NU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JHXM3yd2uZ9GqcR/axW2ErnRfSCSl8FZ1IBwQ4oE/ObWwM819FBrThOhtysV6l7X9
	 gMfOgpI68hw7LN1kDPyQSyUHfKdh4eLhQEvG2wdhD7+RZpi7ngUDDTfWA8WdFcGcNC
	 IjdsRzKgbPLT6tPK/ORZYDmlPCQdqqyenbKF/H8JlShq744ci8l3ZrTMrHwqZAUptu
	 8S524S6WEG3uXkaRL8a9+UnVfoja6isdg1YY2xjMBGHWgJwJByQtU1ilw4YptuO0dZ
	 HK3baPZ/wBuI7/UPPmkwIfZMdoP/CePVKzA8p6S+daxvYXvJ1qnfT/YuhJuQX9x0b7
	 rpNTgw3o3PKdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 53483499EF;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:38 +0000
Subject: [PATCH v3 07/12] media: verisilicon: Reinitialize the IOMMU after
 resetting an encoder core
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
Message-Id: <20261113-hantro-robust-v3-7-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=6191;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=jnOaMXXkqIdF/W+aQDFv26f6KiRw45A2/C/Mdhu62GA=;
 b=E4l1drfEiAJSnLdl7T1rjptWqXeyJxfVf8LWkzKBpQsl0eMJm3v7Ft2xmP0KSV33xJ3HB+flB
 wrhXSrVghzjB5HwZj+B+UJIj5sxF23fny1XAmR69NlLHTdNujLTd272
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A Rockchip encoder core that faulted on an unmapped IOVA leaves its
IOMMU with the fault pending, and the reset pulse of the previous patch
can reset the IOMMU behind its driver. The IOMMU is only reprogrammed
on runtime resume, which doesn't happen between back-to-back jobs.

Do like rkvdec: allocate an empty paging domain at probe and, after the
reset pulse, attach and detach it. The IOMMU driver reprograms the
IOMMU on each domain change, and the default domain keeps its mappings.

Only do this for a device with reset lines whose domain is a DMA
domain. If the attach fails, the IOMMU may be left without translation
(rockchip-iommu falls back to its identity domain), so refuse all
further jobs.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/media/platform/verisilicon/hantro.h        |  5 ++
 drivers/media/platform/verisilicon/hantro_drv.c    | 62 ++++++++++++++++++++++
 drivers/media/platform/verisilicon/hantro_hw.h     |  1 +
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |  6 ++-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
index 0353de154a1e..e3881ca21c56 100644
--- a/drivers/media/platform/verisilicon/hantro.h
+++ b/drivers/media/platform/verisilicon/hantro.h
@@ -193,6 +193,9 @@ hantro_vdev_to_func(struct video_device *vdev)
  *			shared with interrupt handlers.
  * @variant:		Hardware variant-specific parameters.
  * @watchdog_work:	Delayed work for hardware timeout handling.
+ * @empty_domain:	Empty IOMMU domain, used to reinitialize the IOMMU after
+ *			a reset of the core. NULL if not needed.
+ * @iommu_lost:		The IOMMU couldn't be reinitialized, no job can run.
  */
 struct hantro_dev {
 	struct v4l2_device v4l2_dev;
@@ -213,6 +216,8 @@ struct hantro_dev {
 	spinlock_t irqlock;
 	const struct hantro_variant *variant;
 	struct delayed_work watchdog_work;
+	struct iommu_domain *empty_domain;
+	bool iommu_lost;
 };
 
 /**
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index daec9f1ea968..9bb4d1582622 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -113,6 +114,30 @@ void hantro_irq_done(struct hantro_dev *vpu,
 	}
 }
 
+/*
+ * Pulsing the reset lines of a core can reset its IOMMU behind the IOMMU
+ * driver. Attaching and detaching the empty domain makes the driver reprogram
+ * it; the default domain keeps its mappings. A failed attach may leave the
+ * IOMMU without translation, so no further job may run.
+ */
+void hantro_iommu_restore(struct hantro_dev *vpu)
+{
+	int ret;
+
+	if (!vpu->empty_domain)
+		return;
+
+	ret = iommu_attach_device(vpu->empty_domain, vpu->dev);
+	if (ret) {
+		dev_err(vpu->dev, "Failed to reinitialize the IOMMU (%d), refusing further jobs\n",
+			ret);
+		vpu->iommu_lost = true;
+		return;
+	}
+
+	iommu_detach_device(vpu->empty_domain, vpu->dev);
+}
+
 void hantro_watchdog(struct work_struct *work)
 {
 	struct hantro_dev *vpu;
@@ -175,6 +200,9 @@ static void device_run(void *priv)
 	src = hantro_get_src_buf(ctx);
 	dst = hantro_get_dst_buf(ctx);
 
+	if (unlikely(vpu->iommu_lost))
+		goto err_cancel_job;
+
 	ret = pm_runtime_resume_and_get(vpu->dev);
 	if (ret < 0)
 		goto err_cancel_job;
@@ -1074,6 +1102,36 @@ static struct v4l2_m2m_dev *hantro_get_v4l2_m2m_dev(struct hantro_dev *vpu)
 	return v4l2_m2m_init(&vpu_m2m_ops);
 }
 
+static void hantro_free_empty_domain(void *data)
+{
+	iommu_domain_free(data);
+}
+
+static int hantro_alloc_empty_domain(struct hantro_dev *vpu)
+{
+	struct iommu_domain *domain;
+
+	/*
+	 * Only needed if the core can be reset, and only possible with a DMA
+	 * domain to return to.
+	 */
+	if (!vpu->resets)
+		return 0;
+
+	domain = iommu_get_domain_for_dev(vpu->dev);
+	if (!domain || !iommu_is_dma_domain(domain))
+		return 0;
+
+	domain = iommu_paging_domain_alloc(vpu->dev);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+
+	vpu->empty_domain = domain;
+
+	return devm_add_action_or_reset(vpu->dev, hantro_free_empty_domain,
+					domain);
+}
+
 static int hantro_probe(struct platform_device *pdev)
 {
 	struct hantro_dev *vpu;
@@ -1134,6 +1192,10 @@ static int hantro_probe(struct platform_device *pdev)
 	if (IS_ERR(vpu->resets))
 		return PTR_ERR(vpu->resets);
 
+	ret = hantro_alloc_empty_domain(vpu);
+	if (ret)
+		return ret;
+
 	num_bases = vpu->variant->num_regs ?: 1;
 	vpu->reg_bases = devm_kcalloc(&pdev->dev, num_bases,
 				      sizeof(*vpu->reg_bases), GFP_KERNEL);
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 13e573f1f19d..aa610dd5beef 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -427,6 +427,7 @@ extern const struct hantro_postproc_ops rockchip_vpu981_postproc_ops;
 extern const u32 hantro_vp8_dec_mc_filter[8][6];
 
 void hantro_watchdog(struct work_struct *work);
+void hantro_iommu_restore(struct hantro_dev *vpu);
 void hantro_irq_done(struct hantro_dev *vpu,
 		     enum vb2_buffer_state result);
 void hantro_start_prepare_run(struct hantro_ctx *ctx);
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 1467ae2bed1a..113b6977031d 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -490,8 +490,12 @@ static void rockchip_vpu_enc_hw_reset(struct hantro_dev *vpu)
 	udelay(5);
 
 	ret = reset_control_deassert(vpu->resets);
-	if (ret)
+	if (ret) {
 		dev_err(vpu->dev, "Failed to deassert resets: %d\n", ret);
+		return;
+	}
+
+	hantro_iommu_restore(vpu);
 }
 
 static void rockchip_vpu1_enc_reset(struct hantro_ctx *ctx)

-- 
2.55.0


