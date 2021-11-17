Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC9C4332F
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:52:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2385961B4C
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2385961B4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8DD5605F8;
	Wed, 17 Nov 2021 14:52:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llh7jPJiM87f; Wed, 17 Nov 2021 14:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F07E60670;
	Wed, 17 Nov 2021 14:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4423DC0037;
	Wed, 17 Nov 2021 14:52:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF7EBC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A01064040D
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gfKdCUmd9LV for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 14:52:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF18A402CB
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id z10so12242267edc.11
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 06:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jqVNNzLQfZFMm9T0Ib+FdeXKGDJ/YUZsGGIsBRM+Cmg=;
 b=bqwCM7JgZZ07zSsk3K2Xrlf91noWxlvCOW5wvJUoTK8t6dYhg6c/W8jcW9SIvxFzVc
 +umgW36friR/RPIaCX0Sl/vT9LPXAhuFKt88gHA9BzDkEYrIUbUh0Mrp4+gaMEChKBCH
 tpiazOQm2MovHH3f5Hbw+R4cIKHaSIdM8Uqgbvd/BWj1gDYS14BXrsme2BQUTa733X4y
 DarpTagh/vumiPE3/HTrTqiwkeRQELgSshaz5PNRFtnYbb+k1ve4a4K3EUWQfP7twxgb
 OdaPplKdnlUoe4UzpXRQcAPWITxVSUs95AYOSUzCosFm2Biy5quvNAAVKvuqp2fVJKmC
 z31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jqVNNzLQfZFMm9T0Ib+FdeXKGDJ/YUZsGGIsBRM+Cmg=;
 b=mD5S2+pBLGVr2Zle83qo+lCqjNWJ1vNakUOwWZ+VtlUzh5BhxpZgWbECEPaeUBz/v4
 QV3CkfbFIxTxxY0cov4YDYWclUEvyDJ0Vu7E2wp3pguEy3e58b06sL0TpW9tiuUX9NTk
 quK8b2fD2BLObQK9AJQkvqu7Z5mvWOpDo5/lJZ7MN42WuJ5W0WfwfgvyDqFe55dV/i+o
 3N1LRj68xL2rIrEqS0Fbrvbfj+LtcTwYMfgwHLxwTd51pzh5wCr3FtOY++AljrvsMWGz
 2HEBKSYOgkKTFr3h7Z9P6V1FdcHBOJLC6/6MF/+cfLMhd+e7AfMVT7kdUCuJphgIXz/P
 kE3Q==
X-Gm-Message-State: AOAM532J/svZiGI+KQZl3rl42IMb+QgLBG1wFqK1+p+j/TbvtaTeVr7e
 30QLslH27e/2j8bu9MofGtU5Wg==
X-Google-Smtp-Source: ABdhPJyTqJmr6Aa39fh4WLBhW8g73puWWy3pIo0FXWd0YPuiRAy0BtvSlaKkOf5iRgrfCWs6kyp4zg==
X-Received: by 2002:aa7:c943:: with SMTP id h3mr22592072edt.233.1637160759080; 
 Wed, 17 Nov 2021 06:52:39 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id gs15sm63917ejc.42.2021.11.17.06.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 06:52:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org
Subject: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Date: Wed, 17 Nov 2021 14:48:45 +0000
Message-Id: <20211117144844.241072-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117144844.241072-1-jean-philippe@linaro.org>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

From: Robin Murphy <robin.murphy@arm.com>

The SMMU_PMCG_IIDR register was not present in older revisions of the
Arm SMMUv3 spec. On Arm Ltd. implementations, the IIDR value consists of
fields from several PIDR registers, allowing us to present a
standardized identifier to userspace.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/perf/arm_smmuv3_pmu.c | 55 ++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 19697617153a..598d6978280d 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -76,6 +76,10 @@
 #define SMMU_PMCG_CR                    0xE04
 #define SMMU_PMCG_CR_ENABLE             BIT(0)
 #define SMMU_PMCG_IIDR                  0xE08
+#define SMMU_PMCG_IIDR_PRODUCTID        GENMASK(31, 20)
+#define SMMU_PMCG_IIDR_VARIANT          GENMASK(19, 16)
+#define SMMU_PMCG_IIDR_REVISION         GENMASK(15, 12)
+#define SMMU_PMCG_IIDR_IMPLEMENTER      GENMASK(11, 0)
 #define SMMU_PMCG_CEID0                 0xE20
 #define SMMU_PMCG_CEID1                 0xE28
 #define SMMU_PMCG_IRQ_CTRL              0xE50
@@ -84,6 +88,20 @@
 #define SMMU_PMCG_IRQ_CFG1              0xE60
 #define SMMU_PMCG_IRQ_CFG2              0xE64
 
+/* IMP-DEF ID registers */
+#define SMMU_PMCG_PIDR0                 0xFE0
+#define SMMU_PMCG_PIDR0_PART_0          GENMASK(7, 0)
+#define SMMU_PMCG_PIDR1                 0xFE4
+#define SMMU_PMCG_PIDR1_DES_0           GENMASK(7, 4)
+#define SMMU_PMCG_PIDR1_PART_1          GENMASK(3, 0)
+#define SMMU_PMCG_PIDR2                 0xFE8
+#define SMMU_PMCG_PIDR2_REVISION        GENMASK(7, 4)
+#define SMMU_PMCG_PIDR2_DES_1           GENMASK(2, 0)
+#define SMMU_PMCG_PIDR3                 0xFEC
+#define SMMU_PMCG_PIDR3_REVAND          GENMASK(7, 4)
+#define SMMU_PMCG_PIDR4                 0xFD0
+#define SMMU_PMCG_PIDR4_DES_2           GENMASK(3, 0)
+
 /* MSI config fields */
 #define MSI_CFG0_ADDR_MASK              GENMASK_ULL(51, 2)
 #define MSI_CFG2_MEMATTR_DEVICE_nGnRE   0x1
@@ -755,6 +773,41 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
 }
 
+static bool smmu_pmu_coresight_id_regs(struct smmu_pmu *smmu_pmu)
+{
+	return of_device_is_compatible(smmu_pmu->dev->of_node,
+				       "arm,mmu-600-pmcg");
+}
+
+static void smmu_pmu_get_iidr(struct smmu_pmu *smmu_pmu)
+{
+	u32 iidr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_IIDR);
+
+	if (!iidr && smmu_pmu_coresight_id_regs(smmu_pmu)) {
+		u32 pidr0 = readl(smmu_pmu->reg_base + SMMU_PMCG_PIDR0);
+		u32 pidr1 = readl(smmu_pmu->reg_base + SMMU_PMCG_PIDR1);
+		u32 pidr2 = readl(smmu_pmu->reg_base + SMMU_PMCG_PIDR2);
+		u32 pidr3 = readl(smmu_pmu->reg_base + SMMU_PMCG_PIDR3);
+		u32 pidr4 = readl(smmu_pmu->reg_base + SMMU_PMCG_PIDR4);
+
+		u32 productid = FIELD_GET(SMMU_PMCG_PIDR0_PART_0, pidr0) |
+				(FIELD_GET(SMMU_PMCG_PIDR1_PART_1, pidr1) << 8);
+		u32 variant = FIELD_GET(SMMU_PMCG_PIDR2_REVISION, pidr2);
+		u32 revision = FIELD_GET(SMMU_PMCG_PIDR3_REVAND, pidr3);
+		u32 implementer =
+			FIELD_GET(SMMU_PMCG_PIDR1_DES_0, pidr1) |
+			(FIELD_GET(SMMU_PMCG_PIDR2_DES_1, pidr2) << 4) |
+			(FIELD_GET(SMMU_PMCG_PIDR4_DES_2, pidr4) << 8);
+
+		iidr = FIELD_PREP(SMMU_PMCG_IIDR_PRODUCTID, productid) |
+		       FIELD_PREP(SMMU_PMCG_IIDR_VARIANT, variant) |
+		       FIELD_PREP(SMMU_PMCG_IIDR_REVISION, revision) |
+		       FIELD_PREP(SMMU_PMCG_IIDR_IMPLEMENTER, implementer);
+	}
+
+	smmu_pmu->iidr = iidr;
+}
+
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
@@ -826,7 +879,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	smmu_pmu->iidr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_IIDR);
+	smmu_pmu_get_iidr(smmu_pmu);
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
 			      (res_0->start) >> SMMU_PMCG_PA_SHIFT);
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
