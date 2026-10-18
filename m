Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846853F870C;
	Sun, 18 Oct 2026 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341524; cv=none; b=Smqj77ZpNcgw7ImV8OLUlyZYrEf2mXFgMWM2rMkgjv5pkpP+ETVClepRiC9G3hGVK5ECm7hRTKvdZqJ4SX205hcG/vnyj2sOXsTMib+UY7pjVo5EI1gRt7dfEMz9l+K/6fTpySwfdiIx0UnMDyQL9iALgXXNrunUBXs85nF8b2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341524; c=relaxed/simple;
	bh=cMLgis0vl52FH1lrUn4n2uHj+JQJAEOjLoA+uxXj340=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKl1t7JO7854b5mb9op30c81fohtbwuxR+W0I0ct902nODB8oUveoDtdjFmztAkDrFpFAa8dny2k5z1kQh9WLChyHhv3rZbPAqKxkQLnlnsgGFwYq1Peydo+1LiFss48+gCjadKz0s2vPe69uMRGANf4PONTRb2en+b25XBRlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=VFuol8Ds; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="VFuol8Ds"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1792341506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nu+Z7N/SsNbt+Rp62m67VzIkJ72Dt95OB9SPRFq2jcU=;
	b=VFuol8DsFV5KTwLNNvKXHLJFpF36BUETx362coC+B0ZcAMv69EIgkBH44z1sv5Nrdd4iYP
	W9znWq7BELJopzJ6WA4bgsALNTZHwFO7dywF5li3F7UHmwx150wnnlTImZ8WFQmRw0NMU3
	Ou0qk1+gV+6aiq2GbDoDyILMZtu/daQ=
Date: Sun, 18 Oct 2026 18:38:11 +0200
Subject: [PATCH 2/2] soc: apple: sart: Add SART4 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-apple-sartv4-v1-2-1eaa5d63f6a2@cyberchaos.dev>
References: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
In-Reply-To: <20261018-apple-sartv4-v1-0-1eaa5d63f6a2@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Add support for SART4 found on Apple M5 Pro/Max (t6050) SoCs.
This mirrors the SART3 implementation but with offsets adapted to the
new capacity.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 drivers/soc/apple/sart.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index 66b99955b395..3be8e358248a 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -61,6 +61,18 @@
 
 #define APPLE_SART3_FLAGS_ALLOW 0xff
 
+/* SARTv4 registers */
+#define APPLE_SART4_CONFIG(idx) (0x00 + 4 * (idx))
+
+#define APPLE_SART4_PADDR(idx)	(0x60 + 4 * (idx))
+#define APPLE_SART4_PADDR_SHIFT 12
+
+#define APPLE_SART4_SIZE(idx)  (0xc0 + 4 * (idx))
+#define APPLE_SART4_SIZE_SHIFT 12
+#define APPLE_SART4_SIZE_MAX   GENMASK(29, 0)
+
+#define APPLE_SART4_FLAGS_ALLOW 0xff
+
 struct apple_sart_ops {
 	void (*get_entry)(struct apple_sart *sart, int index, u8 *flags,
 			  phys_addr_t *paddr, size_t *size);
@@ -177,6 +189,35 @@ static struct apple_sart_ops sart_ops_v3 = {
 	.size_max = APPLE_SART3_SIZE_MAX,
 };
 
+static void sart4_get_entry(struct apple_sart *sart, int index, u8 *flags,
+			    phys_addr_t *paddr, size_t *size)
+{
+	phys_addr_t paddr_ = readl(sart->regs + APPLE_SART4_PADDR(index));
+	size_t size_ = readl(sart->regs + APPLE_SART4_SIZE(index));
+
+	*flags = readl(sart->regs + APPLE_SART4_CONFIG(index));
+	*size = size_ << APPLE_SART4_SIZE_SHIFT;
+	*paddr = paddr_ << APPLE_SART4_PADDR_SHIFT;
+}
+
+static void sart4_set_entry(struct apple_sart *sart, int index, u8 flags,
+			    phys_addr_t paddr_shifted, size_t size_shifted)
+{
+	writel(paddr_shifted, sart->regs + APPLE_SART4_PADDR(index));
+	writel(size_shifted, sart->regs + APPLE_SART4_SIZE(index));
+	writel(flags, sart->regs + APPLE_SART4_CONFIG(index));
+}
+
+static struct apple_sart_ops sart_ops_v4 = {
+	.get_entry = sart4_get_entry,
+	.set_entry = sart4_set_entry,
+	.flags_allow = APPLE_SART4_FLAGS_ALLOW,
+	.size_shift = APPLE_SART4_SIZE_SHIFT,
+	.paddr_shift = APPLE_SART4_PADDR_SHIFT,
+	.size_max = APPLE_SART4_SIZE_MAX,
+};
+
+
 static int apple_sart_probe(struct platform_device *pdev)
 {
 	int i;
@@ -352,6 +393,10 @@ static void apple_sart_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id apple_sart_of_match[] = {
+	{
+		.compatible = "apple,t6050-sart",
+		.data = &sart_ops_v4,
+	},
 	{
 		.compatible = "apple,t6000-sart",
 		.data = &sart_ops_v3,

-- 
2.55.0

