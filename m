Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75423C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D350521D81
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRvaasQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D350521D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E871877C8;
	Fri, 11 Sep 2020 07:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucBlWbsw+EzN; Fri, 11 Sep 2020 07:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D13DE877CE;
	Fri, 11 Sep 2020 07:19:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B733DC0052;
	Fri, 11 Sep 2020 07:19:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 574FDC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 46C3C86CF4
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cmIIuQRA0Lfo for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B913D86AAA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:18:59 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 5so6009011pgl.4
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IT/Av6WkMGnwscYg5rCYcAHZEDtZ2ZLSfy2TWZBlkOI=;
 b=XRvaasQLXfZi4L/MubCaNLsVOzGgVMgXoHQLOZDXqqE8Z7q9DzDMD312rJuB/cfLBD
 uDkfacySRZUMsBz5WjIVPt/yryNfy6aeldQpBVkEMJNozVVNlYyzXB+FTubsYkKw/3XZ
 n4ze00UNfGHelIaYnuYjcsgqb90jjmVtf48EMm24h3+V9ICn+n8MwW4GSIix4YBFnF6D
 cFLxB1dTA1AboS8W66H0l92LX6AR8NyBFtbpMae1zLfGiEGQRqSs0WFhBGeYyxZpA+7Y
 5tEzLQFlYJBrWeyv+8ICSsew8Vtg0Z3GPzpAPDx7Tebxmi/ANscB4rVUv4G6S8fGZcTA
 TrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IT/Av6WkMGnwscYg5rCYcAHZEDtZ2ZLSfy2TWZBlkOI=;
 b=b9ytlYckbw1qHdC7aekEMqKPcdEhAKwL1E4seSa8DXH7IBAe91WE+A8vJpuB/x/vfD
 bRBrIMK35r0jle7UI4CU0PYHPVLvYSnKaMzV4fKoq6VERZ0K6YONGJYBstz3LgoM5sHx
 NdkvQgCWeNxnPjelauWqDY+f60dr7cmrXprTef2GcMHukBpW++f5j5jiBxKIdJF1xvFg
 po5+sHsg6VSCSxixlFz+S1Jn3KTPTJOWtAXOONb1iCPVGuwBjrmy093wgryLs3nDOZzY
 wCdNW4UQQGe9rhO8C3pjp4pIhauMH8D9IBdSY2q0dXfylbdMCPlNDjqNYeg+GglZrWZc
 z1YQ==
X-Gm-Message-State: AOAM532kvYeCsrhIIL0eUSbj2qvd4wDGgv0HNyxlufJA1i8Vnd6FA2Br
 kkGfp2hUFvyE9yTytqC6nz0=
X-Google-Smtp-Source: ABdhPJyEI6r0AcSE7Kuaf3mASRla3Lliv+I9mZhI5bV7w6vYeD4EbDgqQzjAVldY4rOnokzlfiJzQw==
X-Received: by 2002:a17:902:7fc7:: with SMTP id
 t7mr709678plb.159.1599808739278; 
 Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:18:58 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org,
	thierry.reding@gmail.com
Subject: [PATCH 1/3] iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
Date: Fri, 11 Sep 2020 00:16:41 -0700
Message-Id: <20200911071643.17212-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PAGE_SHIFT and PAGE_MASK are defined corresponding to the page size
for CPU virtual addresses, which means PAGE_SHIFT could be a number
other than 12, but tegra-smmu maintains fixed 4KB IOVA pages and has
fixed [21:12] bit range for PTE entries.

So this patch replaces all PAGE_SHIFT/PAGE_MASK references with the
macros defined with SMMU_PTE_SHIFT.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 046add7acb61..789d21c01b77 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -130,6 +130,11 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PDE_SHIFT 22
 #define SMMU_PTE_SHIFT 12
 
+#define SMMU_PAGE_MASK		(~(SMMU_SIZE_PT-1))
+#define SMMU_OFFSET_IN_PAGE(x)	((unsigned long)(x) & ~SMMU_PAGE_MASK)
+#define SMMU_PFN_PHYS(x)	((phys_addr_t)(x) << SMMU_PTE_SHIFT)
+#define SMMU_PHYS_PFN(x)	((unsigned long)((x) >> SMMU_PTE_SHIFT))
+
 #define SMMU_PD_READABLE	(1 << 31)
 #define SMMU_PD_WRITABLE	(1 << 30)
 #define SMMU_PD_NONSECURE	(1 << 29)
@@ -644,7 +649,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 			       u32 *pte, dma_addr_t pte_dma, u32 val)
 {
 	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset = offset_in_page(pte);
+	unsigned long offset = SMMU_OFFSET_IN_PAGE(pte);
 
 	*pte = val;
 
@@ -726,7 +731,7 @@ __tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		pte_attrs |= SMMU_PTE_WRITABLE;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
-			   __phys_to_pfn(paddr) | pte_attrs);
+			   SMMU_PHYS_PFN(paddr) | pte_attrs);
 
 	return 0;
 }
@@ -790,7 +795,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
@@ -1108,7 +1113,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
-	smmu->pfn_mask = BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
+	smmu->pfn_mask =
+		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
 	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
