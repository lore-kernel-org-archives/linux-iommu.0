Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF21C4360C
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:28:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317A4207FF
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3NuFBWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317A4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1163C129B;
	Thu, 26 Sep 2019 12:28:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 74F591187
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:05:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C4AAE8A
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:05:25 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id 7so2472350wme.1
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=5nnUa/Si31PTL5dtLPgVx571em/1pS4POdS50m/K5Ds=;
	b=V3NuFBWSJu7xEOXvNeF1piDC1tlhTyi/vK910RcpaIn2zWhzeot+1ei2FnYv/f8kUc
	O51NoIb3sNyHPDnj2zFTngZV4r0wlHwtfZfS/zJh215Lo59zpCTx+TJPKF8fZZJgcaDQ
	NPBXBb7qQfi3xh+kR/2S7NP+/KLKLQuNqiLkwiAA8KDB/vI1G5TlAt4L4LhmgCoDJQ7a
	q27OGxllJCBRf17t3tZUniq/synG/txoGSkUk99LRK15yDnSF7vE8Le21lz/QUpuZdN7
	1TchS1eGR80KMNFnhLZRl+hu1QKnkVrMKlz0MURq8KGXiWe/tMrPFeOghvdGlOf1myAg
	IWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5nnUa/Si31PTL5dtLPgVx571em/1pS4POdS50m/K5Ds=;
	b=ZXw8ij00QpdJ+yNH3AHk2Hj0gY5xn9giKsDf80yWDzVzDCtEMo1d0gA65av/ROp5qp
	w1yP2Z9k5zdWJKjT5UWTTBVDpc4hIjWIlv/RBpMAR1s0PbMjslaCH9iqD1UAgzo5TTpk
	V2M5cuPcefoKxSSuAMtEqORI6gStbPewyycNQ4aRmWGrwBtzbIvn9F4xNVEv4WYwmkCt
	7STqVdrlC44LwV0IBYAxAOXvJEn1/lVgCFPpOunKUo+V7TS8tjqkEqAvb/Lu7qYem6CP
	mA0zSUmLrOF+SjdJZdoTnzw7OSdcqZwcHshXcnrZUV97wHF69jYXPtEOvL0YOVgSYHqD
	9yNQ==
X-Gm-Message-State: APjAAAW2xRspHNeewfsyiuG5cwPlYjvlin31m0kD+cH5t49nM0d17mhu
	NOFXwSBcNYKEe3G21DwdEzA=
X-Google-Smtp-Source: APXvYqyEWOYPa4keiWseUvTvM6yh5wlL+BUNL3hKBl65XKnCQR456P4dLtJCZ7AfGFBeADHVgB350g==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr2934851wmj.6.1569499524282;
	Thu, 26 Sep 2019 05:05:24 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([93.51.16.173])
	by smtp.gmail.com with ESMTPSA id
	d193sm5289584wmd.0.2019.09.26.05.05.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Sep 2019 05:05:23 -0700 (PDT)
From: kholk11@gmail.com
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/6] iommu/qcom: Add support for QCIOMMUv2 and QCIOMMU-500
	secured contexts
Date: Thu, 26 Sep 2019 14:05:16 +0200
Message-Id: <20190926120516.4981-7-kholk11@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926120516.4981-1-kholk11@gmail.com>
References: <20190926120516.4981-1-kholk11@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 26 Sep 2019 12:28:08 +0000
Cc: marijns95@gmail.com, iommu@lists.linux-foundation.org, agross@kernel.org,
	AngeloGioacchino Del Regno <kholk11@gmail.com>
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
index a4dd76b8c566..44676d3221d5 100644
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
   - qcom,ctx-num   : The number associated to the context bank
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 03c68fe9439b..2f65a4cdca78 100644
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
@@ -281,6 +282,12 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
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
@@ -762,10 +769,15 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
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
@@ -807,6 +819,8 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
 static const struct of_device_id ctx_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1-ns" },
 	{ .compatible = "qcom,msm-iommu-v1-sec" },
+	{ .compatible = "qcom,msm-iommu-v2-ns" },
+	{ .compatible = "qcom,msm-iommu-v2-sec" },
 	{ /* sentinel */ }
 };
 
@@ -824,7 +838,8 @@ static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
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
