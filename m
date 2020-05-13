Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541B8CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 11:07:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3EF20740
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 11:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEil9n0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3EF20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E726C88994;
	Wed, 13 May 2020 11:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p0AbQWUMaGxf; Wed, 13 May 2020 11:07:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 29BF6887C7;
	Wed, 13 May 2020 11:07:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 083A8C0178;
	Wed, 13 May 2020 11:07:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18481C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 11:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 00582204A6
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 11:07:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hr9dFfy7U-AW for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 11:07:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 19D4E2048E
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 11:07:43 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id l17so6800268wrr.4
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 04:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4kyjTfTHMVUTV+THehJYOS1UTUTs5x0t0xpjX4MdtCY=;
 b=DEil9n0gXHGymALBWdas81BFDTL11HXaPejLvIufToKD+XdRHMpgiczE8uCg/IJKMk
 o+Ho9++LbXsr35XpyqX4c4IJQFeMtyCfa25Z+NkqaczakuaLa1cgb/SuqfBlyqu6uIZt
 LuAyrWw70W+TIUDw0tnkwSVEv8E3TEmZkifC9tCH35x+lsGOxkCmABqxj5LnZh0orEl9
 nIEnrm4QxZoTh+mfb2TigA02rRa6ecGNneaJNG7znMXL4WYPOgGsciE2XnqqPHj7XGU2
 UeDj3pweIS0VsnlznSbC/qYmY0zQMH4uf5UCs32Q0qeQG+QL0cM0f9w0i2oc2ys7GVnv
 XfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4kyjTfTHMVUTV+THehJYOS1UTUTs5x0t0xpjX4MdtCY=;
 b=BHTUcCKqL0FW27tHfHYEJO6giN9yDfSwS49SMI4LmpDYEqphVxKBQB0gNY9Xt0rGgT
 ZFlDv3Hn4xklNL3p/X9mjV7rgsgJ1yyBug11kuHodVRQYfu+EuYndjC4T5EueDZ9X0Cc
 ED61UitH4a1XEb7Y7w2ow2edlJacMDQXjEYLzTRpLm03paNUBCl77pX2dSdpiq5JYVCm
 W/uEUUGunuGSp6x8IqmqM02YvIRLtNJVHaYgHYoB8OkfcPYsItje8ZgnQXGaw3ReRBX/
 3KcdbcEnHIjO7rGKIXda2uGizWPzoxK+hkTbK4VnWq7jaLyWLisELr1cDKvpzD+QD5jR
 YnOg==
X-Gm-Message-State: AGi0PuYh3cbv2Ln6OlVHqxvAqM1sLCBJDY7OhPq4HLrv11sDpEJJdas3
 xFEimNGfbBNrDHJUkhNDgkd1v9CpMfA=
X-Google-Smtp-Source: APiQypKgqLRpEdbQmb0PocsKhfcvRtSmsH2tuQKK5KGLEZF0EGrIVAw4HabuB3b2XrZh4uTNbgbGow==
X-Received: by 2002:adf:fa44:: with SMTP id y4mr17940958wrr.135.1589368061182; 
 Wed, 13 May 2020 04:07:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id q144sm3023804wme.0.2020.05.13.04.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 04:07:40 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] iommu/arm-smmu-v3: Don't reserve implementation defined
 register space
Date: Wed, 13 May 2020 13:02:57 +0200
Message-Id: <20200513110255.597203-1-jean-philippe@linaro.org>
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

To avoid this conflict, don't reserve the MMIO regions that are
implementation defined. Although devm_ioremap_resource() still works on
full pages under the hood, this way we benefit from resource conflict
checks.

Fixes: 7d839b4b9e00 ("perf/smmuv3: Add arm64 smmuv3 pmu driver")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: simplify following Robin's comments
https://lore.kernel.org/linux-iommu/20200506174629.1504153-1-jean-philippe@linaro.org/
---
 drivers/iommu/arm-smmu-v3.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 82508730feb7a1..af21d24a09e888 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -171,6 +171,8 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
+#define ARM_SMMU_REG_SZ			0xe00
+
 /* Common MSI config fields */
 #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
 #define MSI_CFG2_SH			GENMASK(5, 4)
@@ -628,6 +630,7 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_device {
 	struct device			*dev;
 	void __iomem			*base;
+	void __iomem			*page1;
 
 #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
 #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
@@ -733,9 +736,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
 						 struct arm_smmu_device *smmu)
 {
-	if ((offset > SZ_64K) &&
-	    (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY))
-		offset -= SZ_64K;
+	if (offset > SZ_64K)
+		return smmu->page1 + offset - SZ_64K;
 
 	return smmu->base + offset;
 }
@@ -4021,6 +4023,18 @@ err_reset_pci_ops: __maybe_unused;
 	return err;
 }
 
+static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
+				      resource_size_t size)
+{
+	struct resource res = {
+		.flags = IORESOURCE_MEM,
+		.start = start,
+		.end = start + size - 1,
+	};
+
+	return devm_ioremap_resource(dev, &res);
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -4056,10 +4070,23 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	ioaddr = res->start;
 
-	smmu->base = devm_ioremap_resource(dev, res);
+	/*
+	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
+	 * the PMCG registers which are reserved by the PMU driver.
+	 */
+	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 
+	if (arm_smmu_resource_size(smmu) > SZ_64K) {
+		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
+					       ARM_SMMU_REG_SZ);
+		if (IS_ERR(smmu->page1))
+			return PTR_ERR(smmu->page1);
+	} else {
+		smmu->page1 = smmu->base;
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
