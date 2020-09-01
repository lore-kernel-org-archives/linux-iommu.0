Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF68DC433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 20:37:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFD72071B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 20:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNQ0tAP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFD72071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B49F85487;
	Tue,  1 Sep 2020 20:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M4IEOLQ2EkRq; Tue,  1 Sep 2020 20:37:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7BBE85625;
	Tue,  1 Sep 2020 20:37:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADA7EC0052;
	Tue,  1 Sep 2020 20:37:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E46C4C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E0BF385625
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNTirNvS29VD for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 20:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3769285487
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:37:48 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id c2so3165800ljj.12
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vO5riVGJIq/jxWJeztPKNQ8H6lN7SjOM4tRFMoi/sX0=;
 b=uNQ0tAP66OlqR1Ij2+/EidCAhIAvpJ7swbdTx5QaOQ+8eT0th69s6oHoZLtVrpVjxc
 G5m4CeKKv35gSVjiHZGGuFWJS+/FDqd1XRQzEglajIhXxHUm0C9bY2sD/85y+bONhsbW
 RGvyhnR47/xFQpbjW/NTOt1J40swIfB+igHf32cNdCD2oHjfKSS47nbaXByPrF4yIUQN
 CAonnmfZTCePyoBJ+tKC1/Jms8qBzYr+SheYglWg6SRR8TP2YBU2XHmeIMQ184mBrldf
 o8gRz2CzwBM4M/F1cqZFLcr5bd/GNE0QlScob7eai/5cUdykTHZ2bGgZKsgKkwXBfXeT
 jXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vO5riVGJIq/jxWJeztPKNQ8H6lN7SjOM4tRFMoi/sX0=;
 b=CbjezlujBHjC7eEunLxNcZFDxULIhFJj9QbBgQN31o3Ahp3Lt57ScnHsyJH9eLzN1K
 Bc70TPqqPz/8dglscVN1sgxF1T4vj1qgJoFKFst1wDeOCAxYrGIdsYNXPwSI2rlfVGTr
 aO9MdElw/VoD1GF0vpDAFF8fhvyIz9VTtfziZw/z89LmIci+ofzE7hcGphWNWT22kJGH
 WiZFapraQh0mkhIuzuTGI620YbcG0FbXVvHNMyWV82BuzPqWlj0jOenpKsjFC+ppSDp3
 qvTrA1Bx+ylPq0+eKWDLO26EmanlJGkmmnalHO8K44f0r4RCbtIOJQ0U4b5GC9gcL2YN
 FQdA==
X-Gm-Message-State: AOAM532hYKCEE8f0TVUJ9WUHZpaLjtvINiIz6WHukzvnYTr0NJQBiOZk
 8/G7cEFfjVJacSeVemIi300=
X-Google-Smtp-Source: ABdhPJw2c3CxKYGo5eYERK/6aLmsizaDqVjFuUsaVzNVwLQF8SYg4XRTbJB4FUSfPEHROcnB+Yin1A==
X-Received: by 2002:a2e:9bc2:: with SMTP id w2mr1379211ljj.236.1598992666106; 
 Tue, 01 Sep 2020 13:37:46 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.gmail.com with ESMTPSA id z7sm520164lfc.59.2020.09.01.13.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 13:37:45 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v5] iommu/tegra-smmu: Add locking around mapping operations
Date: Tue,  1 Sep 2020 23:37:30 +0300
Message-Id: <20200901203730.27865-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

The mapping operations of the Tegra SMMU driver are subjected to a race
condition issues because SMMU Address Space isn't allocated and freed
atomically, while it should be. This patch makes the mapping operations
atomic, it fixes an accidentally released Host1x Address Space problem
which happens while running multiple graphics tests in parallel on
Tegra30, i.e. by having multiple threads racing with each other in the
Host1x's submission and completion code paths, performing IOVA mappings
and unmappings in parallel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v5: - Replaced GFP_NOWAIT check with __GFP_ATOMIC to fix "sleep in
      atomic context" warnings, NOWAIT != ATOMIC.

v4: - Returned to use spinlock, but now using a smarter allocation
      logic that performs allocation in a sleeping context whenever
      possible.

    - Removed the stable tag because patch isn't portable as-is
      since the arguments of map/unmap() callbacks changed recently.
      Perhaps we could just ignore older kernels for now. It will be
      possible to fix older kernels with a custom patch if will be needed.

v3: - No changes. Resending for visibility.

 drivers/iommu/tegra-smmu.c | 95 +++++++++++++++++++++++++++++++++-----
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 124c8848ab7e..4853a2f8dc7b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
 
 #include <soc/tegra/ahb.h>
@@ -49,6 +50,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	spinlock_t lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +310,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	spin_lock_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -569,19 +573,14 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 }
 
 static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
-		       dma_addr_t *dmap)
+		       dma_addr_t *dmap, struct page *page)
 {
 	unsigned int pde = iova_pd_index(iova);
 	struct tegra_smmu *smmu = as->smmu;
 
 	if (!as->pts[pde]) {
-		struct page *page;
 		dma_addr_t dma;
 
-		page = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
-		if (!page)
-			return NULL;
-
 		dma = dma_map_page(smmu->dev, page, 0, SMMU_SIZE_PT,
 				   DMA_TO_DEVICE);
 		if (dma_mapping_error(smmu->dev, dma)) {
@@ -655,15 +654,61 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static struct page *as_get_pde_page(struct tegra_smmu_as *as,
+				    unsigned long iova, gfp_t gfp,
+				    unsigned long *flags)
+{
+	unsigned int pde = iova_pd_index(iova);
+	struct page *page = as->pts[pde];
+
+	/* at first check whether allocation needs to be done at all */
+	if (page)
+		return page;
+
+	/*
+	 * In order to prevent exhaustion of the atomic memory pool, we
+	 * allocate page in a sleeping context if GFP flags permit. Hence
+	 * spinlock needs to be unlocked and re-locked after allocation.
+	 */
+	if (!(gfp & __GFP_ATOMIC))
+		spin_unlock_irqrestore(&as->lock, *flags);
+
+	page = alloc_page(gfp | __GFP_DMA | __GFP_ZERO);
+
+	if (!(gfp & __GFP_ATOMIC))
+		spin_lock_irqsave(&as->lock, *flags);
+
+	/*
+	 * In a case of blocking allocation, a concurrent mapping may win
+	 * the PDE allocation. In this case the allocated page isn't needed
+	 * if allocation succeeded and the allocation failure isn't fatal.
+	 */
+	if (as->pts[pde]) {
+		if (page)
+			__free_page(page);
+
+		page = as->pts[pde];
+	}
+
+	return page;
+}
+
+static int
+__tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+		 phys_addr_t paddr, size_t size, int prot, gfp_t gfp,
+		 unsigned long *flags)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
+	struct page *page;
 	u32 pte_attrs;
 	u32 *pte;
 
-	pte = as_get_pte(as, iova, &pte_dma);
+	page = as_get_pde_page(as, iova, gfp, flags);
+	if (!page)
+		return -ENOMEM;
+
+	pte = as_get_pte(as, iova, &pte_dma, page);
 	if (!pte)
 		return -ENOMEM;
 
@@ -685,8 +730,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+__tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+		   size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +748,33 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&as->lock, flags);
+	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp, &flags);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&as->lock, flags);
+	size = __tegra_smmu_unmap(domain, iova, size, gather);
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
