Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973B2C28CBC
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 17:49:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F5820663
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dd6f0irr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F5820663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 191C12011B;
	Wed,  6 May 2020 17:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5iAqNEFc-F8r; Wed,  6 May 2020 17:49:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D328120027;
	Wed,  6 May 2020 17:49:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B785FC088B;
	Wed,  6 May 2020 17:49:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F7AC0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 17:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8099C86EEE
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 17:49:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8iDel4v7TfRX for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 17:49:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7F17986EDC
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 17:49:15 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id e16so3233785wra.7
 for <iommu@lists.linux-foundation.org>; Wed, 06 May 2020 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hWHyRKp89JVQR9Wj2q/H7Wn4Rwh+/TR6MPPzYZ0wjPA=;
 b=Dd6f0irrkcgPWqK7bSdzbaR69zH5LEy11m2PBDkF8rr58MdIVe3XqiidJt1QLQOUkd
 OnFIlEIRK1ptPTFYN1mIrjiH8mfZp7bqRXx1nyuPZTBlsbezWVdvP1RndtQehhuoIQL+
 Tn8ROK+nP0nDJgN69aFDSbIwkKrEdN+vs8l2uz/tPMcbBnjlLBLZg3C+cy7FH5OOoA0g
 QZdYe/vNkPVE44XNv7+d5FZVLNRAdWrP4sosF0lVv6YpU+4YdA2w0ZCBxiIz6+XsbKqW
 mgzOQHZV04Fp4+dSUWOoxHvOAeG578UhI88lY+amhvReZZ6Z83+hRxgL1n8qfa2SZLyB
 cVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hWHyRKp89JVQR9Wj2q/H7Wn4Rwh+/TR6MPPzYZ0wjPA=;
 b=FxmSc+homDgR4hyi8tr5sRxwxzRBoK+t1Rmd4bbUDHadLZcezeD/ck5BpRw8+4jEfQ
 /XRSqgpbmZ9r/B1dNO7OL5hr20Yd0yvuB4jfGfD3cqMunOeLsCc/iN984gwzbV3r8Ibl
 WTHhUpe1pQcvA/yyEI6faOCNRViOWVm/++VL2q3fUkpYjAXx5LiWG1lrBrv9wv02Qyyh
 UgDKJAl+C2ypuDmQJVO4oNJlfYA59O10DiwYjCFy5srzX/smPIJTJlFAiRvls39Qq1Hc
 +ej5PwlNQf+T2wl8mzfJl2iv2BQpVEjahQ3ofZVvlu8zXCqsV5nNB0D0KSMv2qNLIydX
 HUWg==
X-Gm-Message-State: AGi0PuaQco1RQX0z2EujWTR7qSpxjd5g9lIQzaqOTnzZ1IXkeHsQU3sH
 MeJOw5OUV9mAd+eFDHx6tTD4Ax1b1tY=
X-Google-Smtp-Source: APiQypIiuuHXkr4RsT4xMD4MRnNE4uCLdKVt7VMRDOvlSsSmryUY3pQdNlr5jSgfb/IfLZSpUF/GQg==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr10706505wrq.61.1588787353314; 
 Wed, 06 May 2020 10:49:13 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id f5sm3762161wrp.70.2020.05.06.10.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 10:49:12 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu/arm-smmu-v3: Don't reserve implementation defined
 register space
Date: Wed,  6 May 2020 19:46:30 +0200
Message-Id: <20200506174629.1504153-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 tuanphan@amperemail.onmicrosoft.com, robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Some SMMUv3 implementation embed the Perf Monitor Group Registers (PMCG)
inside the first 64kB region of the SMMU. Since PMCG are managed by a
separate driver, this layout causes resource reservation conflicts
during boot.

To avoid this conflict, only reserve the MMIO region we actually use:
the first 0xe0 bytes of page 0 and the first 0xd0 bytes of page 1.
Although devm_ioremap() still works on full pages under the hood, this
way we benefit from resource conflict checks.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
A nicer (and hopefully working) solution to the problem dicussed here:
https://lore.kernel.org/linux-iommu/20200421155745.19815-1-jean-philippe@linaro.org/
---
 drivers/iommu/arm-smmu-v3.c | 50 +++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7a1..fc85cdd5b62cca 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -171,6 +171,9 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
+#define ARM_SMMU_PAGE0_REG_SZ		0xe0
+#define ARM_SMMU_PAGE1_REG_SZ		0xd0
+
 /* Common MSI config fields */
 #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
 #define MSI_CFG2_SH			GENMASK(5, 4)
@@ -628,6 +631,7 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_device {
 	struct device			*dev;
 	void __iomem			*base;
+	void __iomem			*page1;
 
 #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
 #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
@@ -733,11 +737,14 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
 						 struct arm_smmu_device *smmu)
 {
-	if ((offset > SZ_64K) &&
-	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
-		offset -= SZ_64K;
+	void __iomem *base = smmu->base;
 
-	return smmu->base + offset;
+	if (offset > SZ_64K) {
+		offset -= SZ_64K;
+		if (smmu->page1)
+			base = smmu->page1;
+	}
+	return base + offset;
 }
 
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
@@ -4021,6 +4028,28 @@ err_reset_pci_ops: __maybe_unused;
 	return err;
 }
 
+static void __iomem *arm_smmu_ioremap(struct device *dev,
+				      resource_size_t start,
+				      resource_size_t size)
+{
+	void __iomem *dest_ptr;
+	struct resource *res;
+
+	res = devm_request_mem_region(dev, start, size, dev_name(dev));
+	if (!res) {
+		dev_err(dev, "can't request SMMU region %pa\n", &start);
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	dest_ptr = devm_ioremap(dev, start, size);
+	if (!dest_ptr) {
+		dev_err(dev, "ioremap failed for SMMU region %pR\n", res);
+		devm_release_mem_region(dev, start, size);
+		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+	}
+	return dest_ptr;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -4056,10 +4085,21 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	ioaddr = res->start;
 
-	smmu->base = devm_ioremap_resource(dev, res);
+	/*
+	 * Only map what we need, because the IMPLEMENTATION DEFINED registers
+	 * may be used for the PMCGs, which are reserved by the PMU driver.
+	 */
+	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_PAGE0_REG_SZ);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 
+	if (arm_smmu_resource_size(smmu) > SZ_64K) {
+		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
+					       ARM_SMMU_PAGE1_REG_SZ);
+		if (IS_ERR(smmu->page1))
+			return PTR_ERR(smmu->page1);
+	}
+
 	/* Interrupt lines */
 
 	irq = platform_get_irq_byname_optional(pdev, "combined");
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
