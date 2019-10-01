Return-Path: <SRS0=VD3v=X2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F8ECE587
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 22:02:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C46C21906
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+1nwzMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C46C21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CE3F1234E;
	Tue,  1 Oct 2019 22:02:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C42241A88
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 22:02:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 194A63D0
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 22:02:17 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id r3so17300768wrj.6
	for <iommu@lists.linux-foundation.org>;
	Tue, 01 Oct 2019 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hNjIRfETItHrHAwc5fX92U90M7+/WUq/4UckUIkwrKY=;
	b=U+1nwzMbMPc/wlXMV6DiSSz53/4/4mwteHm8yEycRl5mxcLwxtiJRo8Dcl6mYiPd1D
	V4AkUvBKbcnvgxht9/xzkC1cRDopvdZYfQnW8FXCSErthMJUMhMBBd7bsyq4fhTvfys6
	HV4mzO9ps51gnhycq8L7iy5PhV1MHSHtCBOLlA25jMNyb8Y714VQNxoXbI/KLOLG+oAi
	XGXM5s0rLzn/Odgq+eTdoA9PSOXwcoVuN2LC94unk6i+k1/zHWGhu1zyQpz92AQhjvib
	jJ2h6YhVNRKtgm3Nz6bydQ3F2s6+BJ54ARw7MWtAC5MynMhr9C8RMq+cSK7rloWlow/Y
	CEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hNjIRfETItHrHAwc5fX92U90M7+/WUq/4UckUIkwrKY=;
	b=QOsGRMqvjy4uPN7jGpW6H2/t8DPrZ3hHYB5NosOFTx8tukjtIZR+CKZ5PZ/EpPhGdX
	lgmEpIoz4DG2PX7NnMp4MqKoxsUw81ibaq+BbasjsyNeBRlPCE4LKzZuDes9tHaCCLai
	BG+zQHETKbPpFtQQZ8TxbcbFPnIveUs0nQXhKcAtoB5N2yqyXa2+nLceTAI+jKOTAXAs
	7Nnnr05YQNrGNqGN6x+iN17yJzB9HIvtSws0ey+ZQ4eh8fUNkL+DFa2L/RS3bTBX5+Ub
	FqWz13FYYKvjsLJstH4Vx5BTN6EecxStIV6pdSRoJoFLCbB4Uai5wWKsCPCtTM2fsqTw
	IE0w==
X-Gm-Message-State: APjAAAWtr4IyNarOc2CC4t8gXgQ6zgbCfBJFBMGzAfT9K3jj95GOPn9I
	LJ1TGmGvk58gPHjVcZnD/aQ=
X-Google-Smtp-Source: APXvYqxJYqkrRsARbbE+u7tKld5m6pET9Cw3dddqIrJXkIp4h9SjQ2YmBeS1wqdmJkNWAKkeTVYR6A==
X-Received: by 2002:adf:dc41:: with SMTP id m1mr1445wrj.46.1569967335495;
	Tue, 01 Oct 2019 15:02:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	v16sm21811219wrt.12.2019.10.01.15.02.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Oct 2019 15:02:15 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 7/7] iommu/qcom: Add support for QCIOMMUv2 and QCIOMMU-500
	secured contexts
Date: Wed,  2 Oct 2019 00:02:05 +0200
Message-Id: <20191001220205.6423-8-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001220205.6423-1-kholk11@gmail.com>
References: <20191001220205.6423-1-kholk11@gmail.com>
MIME-Version: 1.0
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	kholk11@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

This IOMMU is yet another Qualcomm variant of known IOMMUs, found in
Family-B SoCs, such as MSM8956, MSM8976, MSM8953, MSM8917 and others,
and that firmware perfectly adheres to this driver logic.
This time, though, the catch is that the secure contexts are also
secured, meaning that these are programmed by the bootloader or TZ
and their "interesting" registers are locked out, so the hypervisor
disallows touching them from the non-secure world: in this case
the OS is supposed to blindly trust the secure configuration of
these contexts and just use them "as they are".

For this reason, it is necessary to distinguish between the v1 and
500/v2 secure contexts in this driver in order to adhere to this
specification. To do this, add a new DT compatible, named
"qcom,msm-iommu-v2-sec" that will trigger the new behavior.

For the sake of completeness, also add a "qcom,msm-iommu-v2-ns" so
that the human eye gets pleased with it when reading the contexts
in the final SoC DT. Of course, the latter is just cosmetic.

Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 .../devicetree/bindings/iommu/qcom,iommu.txt  |  2 ++
 drivers/iommu/qcom_iommu.c                    | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
index 72ae0595efff..861c0cd9c512 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
@@ -36,6 +36,8 @@ to non-secure vs secure interrupt line.
   - compatible     : Should be one of:
         - "qcom,msm-iommu-v1-ns"  : non-secure context bank
         - "qcom,msm-iommu-v1-sec" : secure context bank
+        - "qcom,msm-iommu-v2-ns"  : non-secure QSMMUv2/QSMMU500 context bank
+        - "qcom,msm-iommu-v2-sec" : secure QSMMUv2/QSMMU500 context bank
   - reg            : Base address and size of context bank within the iommu
   - interrupts     : The context fault irq.
 
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 555cbc55b073..eaecb009849c 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -56,6 +56,7 @@ struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
 	bool			 secure_init;
+	bool			 secured_ctx;
 	u8			 asid;      /* asid and ctx bank # are 1:1 */
 	struct iommu_domain	*domain;
 };
@@ -303,6 +304,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 			ctx->secure_init = true;
 		}
 
+		/* Secured QSMMU-500/QSMMU-v2 contexts cannot be programmed */
+		if (ctx->secured_ctx) {
+			ctx->domain = domain;
+			break;
+		}
+
 		qcom_iommu_reset_ctx(ctx);
 
 		tcr[0] = pgtbl_cfg.arm_lpae_s1_cfg.tcr;
@@ -788,10 +795,15 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
+	if (of_device_is_compatible(dev->of_node, "qcom,msm-iommu-v2-sec"))
+		ctx->secured_ctx = true;
+
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
 	 */
-	iommu_writel(ctx, ARM_SMMU_CB_FSR, iommu_readl(ctx, ARM_SMMU_CB_FSR));
+	if (!ctx->secured_ctx)
+		iommu_writel(ctx, ARM_SMMU_CB_FSR,
+			     iommu_readl(ctx, ARM_SMMU_CB_FSR));
 
 	ret = devm_request_irq(dev, irq,
 			       qcom_iommu_fault,
@@ -833,6 +845,8 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 static const struct of_device_id ctx_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1-ns" },
 	{ .compatible = "qcom,msm-iommu-v1-sec" },
+	{ .compatible = "qcom,msm-iommu-v2-ns" },
+	{ .compatible = "qcom,msm-iommu-v2-sec" },
 	{ /* sentinel */ }
 };
 
@@ -850,7 +864,8 @@ static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 	struct device_node *child;
 
 	for_each_child_of_node(qcom_iommu->dev->of_node, child)
-		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec"))
+		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec") ||
+		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec"))
 			return true;
 
 	return false;
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
