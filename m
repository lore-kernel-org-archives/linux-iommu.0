Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B92CA9064
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229132051A
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 14:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wj3SSPBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229132051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A89286E09;
	Thu, 30 Apr 2020 14:40:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjjHVlWOJ3o0; Thu, 30 Apr 2020 14:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3CC9C86E3C;
	Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24B36C088D;
	Thu, 30 Apr 2020 14:40:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57FD7C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4CD41251AE
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Rwp-QSYBK5b for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 14:40:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 1765825067
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 14:40:43 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id i10so7210340wrv.10
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZadwRE38IWIhaFQo0YVkHBPD8BeJdD1SqF7b7sjhqXs=;
 b=Wj3SSPBpi9BxJeSf2iIofL9VA5F9WntpxEFfh1WMHTPJiDCKe8+5ygnbzYWkBMPZUX
 pWea64rFN/BaEPpyzbULOsXmjtrQgwA8V1FbdVgXUVZQbCukvXsL9x8DaZmfXBa7u2pu
 G6fpXjl2kQ1jzO0qppuyhBYmcQNQ/aQ3+OKRvDxMzRS0K6zHw23SfF4rSucq/yQU5uSE
 6zL/USMwc69CQnClYQFWiUHG+RutYJuqjI1ESyKWrRD9orf/IZZbggEJTNwjXxq4o9Wx
 LQm8WwWxxYVT2G1HlO9Jcr1h4lkHYE8ykXrB4inPRVlL8IVPIBLOLdMsqYrkTLyCTmfL
 8EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZadwRE38IWIhaFQo0YVkHBPD8BeJdD1SqF7b7sjhqXs=;
 b=AvGfWP2NaJh4t2xL+6PQ+k5FJdRwvBTex9rHBUr0hASndvgNp01dvjO9KoSROXv34x
 kWC4kFCzEjLvMuMM3V/Z5+b7YhRi050yiraTpjNw4B1TxAtqVNVmhgPA/4la21k7639F
 5UkZYO9RWbvfQmvVu0pua8QD/GjpgHR1PLPPJsGlkSpH43clKi7Y3ucWFVwqeOHLuPbI
 JtxBSzeHtQbXDA2nozi1QgyY4MQPoUzI0gcUsBCxqiMonI8HX6VxK5FyC6k9fefUVMf9
 vlrZ9yZxZaxexamEQbtTwQvKtzpuxwQX8r6LVRD48KiHlNmVcF84dtBYg6wMfx1YcOUL
 ViKg==
X-Gm-Message-State: AGi0PuZLzSg16P8WZGzPBKB57yWWgr0OaSRKtFmMqLn9BE4By7ZNMh+g
 EyB8ZdJsBX1Fu3+MY2Zjhzwew7oBnLc=
X-Google-Smtp-Source: APiQypJSVyg1VR6sFhtwHuHRRh8dnOdKGBzgx/I0C6D8dHpNyzKcNfJ7Zj6HuK3s9OYL8E8aOHwxjQ==
X-Received: by 2002:a05:6000:8b:: with SMTP id
 m11mr4355479wrx.168.1588257641304; 
 Thu, 30 Apr 2020 07:40:41 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 07:40:40 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v6 19/25] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
Date: Thu, 30 Apr 2020 16:34:18 +0200
Message-Id: <20200430143424.2787566-20-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, kevin.tian@intel.com, jgg@ziepe.ca,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 felix.kuehling@amd.com, will@kernel.org, christian.koenig@amd.com
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

If the SMMU supports it and the kernel was built with HTTU support, enable
hardware update of access and dirty flags. This is essential for shared
page tables, to reduce the number of access faults on the fault queue.

We can enable HTTU even if CPUs don't support it, because the kernel
always checks for HW dirty bit and updates the PTE flags atomically.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index c65937d953b5f..240cd0bc00e62 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -58,6 +58,8 @@
 #define IDR0_ASID16			(1 << 12)
 #define IDR0_ATS			(1 << 10)
 #define IDR0_HYP			(1 << 9)
+#define IDR0_HD				(1 << 7)
+#define IDR0_HA				(1 << 6)
 #define IDR0_BTM			(1 << 5)
 #define IDR0_COHACC			(1 << 4)
 #define IDR0_TTF			GENMASK(3, 2)
@@ -309,6 +311,9 @@
 #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
 #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
 
+#define CTXDESC_CD_0_TCR_HA		(1UL << 43)
+#define CTXDESC_CD_0_TCR_HD		(1UL << 42)
+
 #define CTXDESC_CD_0_AA64		(1UL << 41)
 #define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
@@ -660,6 +665,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 16)
 #define ARM_SMMU_FEAT_BTM		(1 << 17)
 #define ARM_SMMU_FEAT_SVA		(1 << 18)
+#define ARM_SMMU_FEAT_HA		(1 << 19)
+#define ARM_SMMU_FEAT_HD		(1 << 20)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -1715,10 +1722,17 @@ static int __arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		 * this substream's traffic
 		 */
 	} else { /* (1) and (2) */
+		u64 tcr = cd->tcr;
+
 		cdptr[1] = cpu_to_le64(cd->ttbr & CTXDESC_CD_1_TTB0_MASK);
 		cdptr[2] = 0;
 		cdptr[3] = cpu_to_le64(cd->mair);
 
+		if (!(smmu->features & ARM_SMMU_FEAT_HD))
+			tcr &= ~CTXDESC_CD_0_TCR_HD;
+		if (!(smmu->features & ARM_SMMU_FEAT_HA))
+			tcr &= ~CTXDESC_CD_0_TCR_HA;
+
 		/*
 		 * STE is live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
@@ -1726,7 +1740,7 @@ static int __arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 		 */
 		arm_smmu_sync_cd(smmu_domain, ssid, true);
 
-		val = cd->tcr |
+		val = tcr |
 #ifdef __BIG_ENDIAN
 			CTXDESC_CD_0_ENDI |
 #endif
@@ -1965,10 +1979,12 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 		return old_cd;
 	}
 
+	/* HA and HD will be filtered out later if not supported by the SMMU */
 	tcr = FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, 64ULL - VA_BITS) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0, ARM_LPAE_TCR_RGN_WBWA) |
 	      FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS) |
+	      CTXDESC_CD_0_TCR_HA | CTXDESC_CD_0_TCR_HD |
 	      CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 
 	switch (PAGE_SIZE) {
@@ -4461,6 +4477,12 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_E2H;
 	}
 
+	if (reg & (IDR0_HA | IDR0_HD)) {
+		smmu->features |= ARM_SMMU_FEAT_HA;
+		if (reg & IDR0_HD)
+			smmu->features |= ARM_SMMU_FEAT_HD;
+	}
+
 	/*
 	 * If the CPU is using VHE, but the SMMU doesn't support it, the SMMU
 	 * will create TLB entries for NH-EL1 world and will miss the
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
