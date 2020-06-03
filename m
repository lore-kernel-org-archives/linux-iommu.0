Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C487C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD602077D
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD602077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89313863BB;
	Wed,  3 Jun 2020 02:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sFUcnuSNy1sl; Wed,  3 Jun 2020 02:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A608286371;
	Wed,  3 Jun 2020 02:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93863C0865;
	Wed,  3 Jun 2020 02:44:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 511C2C016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 02:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4DA2A86371
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 02:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWcbadF8DOtw for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 02:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 087B786366
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 02:44:36 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id B0F23B592F9065344E8F;
 Wed,  3 Jun 2020 10:44:33 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.193) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 10:44:24 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <catalin.marinas@arm.com>
Subject: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
Date: Wed, 3 Jun 2020 14:42:30 +1200
Message-ID: <20200603024231.61748-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
References: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.201.193]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
 Roman Gushchin <guro@fb.com>, linux-arm-kernel@lists.infradead.org
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

hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
done yet. so all reserved memory will be located at node0.

Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 arch/arm64/mm/init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e42727e3568e..8f0e70ebb49d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -458,11 +458,6 @@ void __init arm64_memblock_init(void)
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 
 	dma_contiguous_reserve(arm64_dma32_phys_limit);
-
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-#endif
-
 }
 
 void __init bootmem_init(void)
@@ -478,6 +473,11 @@ void __init bootmem_init(void)
 	min_low_pfn = min;
 
 	arm64_numa_init();
+
+#ifdef CONFIG_ARM64_4K_PAGES
+	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
+#endif
+
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(), so must be
 	 * done after the fixed reservations.
-- 
2.23.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
