Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041632A3E7
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788844; cv=none; b=rpYrFylNYqWb0ZZeFIdWj4hEumaCVvvhQd1k5YCrVnagntQEAksL4R6O7eBRjl1w9solgKhYkd+hxlOeQFgTvLmAvwzDirCjTFngqK/fR3sOTlX529wIRuhRySdZW1ywkxtNeyOSYPYDSQshEGWxUmcOrUQRgafuGvY2sqMLVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788844; c=relaxed/simple;
	bh=eRnEvjh2q0SJ1Tg1mygUFwm603wsxCDIEZ3pEp2Tr80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggH2K5OSxMU2hdHxLX4OY/9NO1y3nz/+gSwNPQcJwrsii+nUcqAGnx6zoERdMwoSu7NcHhVIRcnLAW5N3c9ZdC8G0J7U8wvZCOh1+P13goe53STzlg/dk0/RnX/Z55hAP5TSV9wFJ7PREOxEl0UAt/UDrCNPcmGKnN1nxREtmR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WULtIqpz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WULtIqpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765788838;
	bh=eRnEvjh2q0SJ1Tg1mygUFwm603wsxCDIEZ3pEp2Tr80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WULtIqpzXb7kyp4msQmiZqtbhI97nPFoup0q3fbiZzeO+JjiT0ZPVNerF8/crRanC
	 ZgT8s/K1xbo2zZsIEEJJWDAkWhn6+Y/bi9TRQbYy2KrkNDLOAK6OP+6aVBpjkbUuXi
	 xrlf/0S3uXoKy8H4HZdEORxfF+OtErjqU0Im0QsyePDqIqt8T/+JDGsri1BgULp+8+
	 jl8mesumAvlIsD/ba8r+h2Wxe0Tke7EU8nw/8725PU5GskZv1lsCOCrdoE9eZ9Rno4
	 oeDUCPooRLSA9vIiRYbrdhfHAb4h/hAAMGFz4A30InYiDpKOknxZLVbxPbrq8aslan
	 KBTNeiIi9wW/g==
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c17e:135b:5095:83a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BB1717E1513;
	Mon, 15 Dec 2025 09:53:58 +0100 (CET)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v10 5/7] media: verisilicon: AV1: Restore IOMMU context before decoding a frame
Date: Mon, 15 Dec 2025 09:53:42 +0100
Message-ID: <20251215085349.10155-6-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215085349.10155-1-benjamin.gaignard@collabora.com>
References: <20251215085349.10155-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AV1 is a stateless decoder which means multiple AV1 bitstreams could be
decoded at the same time using the same hardware block. Before decoding
a frame it is needed to restore the iommu tables to avoid mixing decode
contexts.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
changes in version 10:
- Fix build as module issue when Verisilicon video decoder is built-in.

 drivers/media/platform/verisilicon/Kconfig        |  1 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/platform/verisilicon/Kconfig b/drivers/media/platform/verisilicon/Kconfig
index 3272a24db71d..e64bc8b55235 100644
--- a/drivers/media/platform/verisilicon/Kconfig
+++ b/drivers/media/platform/verisilicon/Kconfig
@@ -49,6 +49,7 @@ config VIDEO_HANTRO_ROCKCHIP
 	bool "Hantro VPU Rockchip support"
 	depends on VIDEO_HANTRO
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	select VSI_IOMMU
 	default y
 	help
 	  Enable support for RK3288, RK3328, and RK3399 SoCs.
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
index e4703bb6be7c..d9e68e0ded68 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
@@ -5,6 +5,9 @@
  * Author: Benjamin Gaignard <benjamin.gaignard@collabora.com>
  */
 
+#include <linux/iommu.h>
+#include <linux/vsi-iommu.h>
+
 #include <media/v4l2-mem2mem.h>
 #include "hantro.h"
 #include "hantro_v4l2.h"
@@ -2095,12 +2098,24 @@ rockchip_vpu981_av1_dec_set_output_buffer(struct hantro_ctx *ctx)
 	hantro_write_addr(vpu, AV1_TILE_OUT_MV, mv_addr);
 }
 
+static void rockchip_vpu981_av1_restore_iommu(struct hantro_ctx *ctx)
+{
+	struct iommu_domain *domain;
+
+	/* Before decoding any frame iommu context need to be restored */
+	domain = iommu_get_domain_for_dev(ctx->dev->v4l2_dev.dev);
+	if (domain)
+		vsi_iommu_restore_ctx(domain);
+}
+
 int rockchip_vpu981_av1_dec_run(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *vb2_src;
 	int ret;
 
+	rockchip_vpu981_av1_restore_iommu(ctx);
+
 	hantro_start_prepare_run(ctx);
 
 	ret = rockchip_vpu981_av1_dec_prepare_run(ctx);
-- 
2.43.0

