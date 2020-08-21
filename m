Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD09C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473D320732
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 11:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473D320732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 214E086D3C;
	Fri, 21 Aug 2020 11:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOyf8pFLTvkz; Fri, 21 Aug 2020 11:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67D3986CFD;
	Fri, 21 Aug 2020 11:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54C36C0889;
	Fri, 21 Aug 2020 11:37:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF48C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 11:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7B83786D23
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 11:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eYRbmKGpl6Wv for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 11:37:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CB30C86D37
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 11:37:06 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6EB9571D0E991F6D9C19;
 Fri, 21 Aug 2020 19:37:04 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.129) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 19:36:58 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
 <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
 <catalin.marinas@arm.com>, <akpm@linux-foundation.org>
Subject: [PATCH v7 3/3] mm: cma: use CMA_MAX_NAME to define the length of cma
 name array
Date: Fri, 21 Aug 2020 23:33:55 +1200
Message-ID: <20200821113355.6140-4-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.126.200.129]
X-CFilter-Loop: Reflected
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, prime.zeng@hisilicon.com,
 huangdaode@huawei.com, Roman Gushchin <guro@fb.com>,
 linux-arm-kernel@lists.infradead.org, Mike Kravetz <mike.kravetz@oracle.com>
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

CMA_MAX_NAME should be visible to CMA's users as they might need it to set
the name of CMA areas and avoid hardcoding the size locally.
So this patch moves CMA_MAX_NAME from local header file to include/linux
header file and removes the magic number in hugetlb.c and contiguous.c.

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 this patch is fixing the magic number issue with respect to Will's comment here:
 https://lore.kernel.org/linux-iommu/4ab78767553f48a584217063f6f24eb9@hisilicon.com/

 include/linux/cma.h     | 2 ++
 kernel/dma/contiguous.c | 2 +-
 mm/cma.h                | 2 --
 mm/hugetlb.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 6ff79fefd01f..217999c8a762 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -18,6 +18,8 @@
 
 #endif
 
+#define CMA_MAX_NAME 64
+
 struct cma;
 
 extern unsigned long totalcma_pages;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 0383c9b86715..d2d6b715c274 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -119,7 +119,7 @@ void __init dma_pernuma_cma_reserve(void)
 
 	for_each_online_node(nid) {
 		int ret;
-		char name[20];
+		char name[CMA_MAX_NAME];
 		struct cma **cma = &dma_contiguous_pernuma_area[nid];
 
 		snprintf(name, sizeof(name), "pernuma%d", nid);
diff --git a/mm/cma.h b/mm/cma.h
index 20f6e24bc477..42ae082cb067 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -4,8 +4,6 @@
 
 #include <linux/debugfs.h>
 
-#define CMA_MAX_NAME 64
-
 struct cma {
 	unsigned long   base_pfn;
 	unsigned long   count;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a301c2d672bf..9eec0ea9ba68 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5683,12 +5683,12 @@ void __init hugetlb_cma_reserve(int order)
 	reserved = 0;
 	for_each_node_state(nid, N_ONLINE) {
 		int res;
-		char name[20];
+		char name[CMA_MAX_NAME];
 
 		size = min(per_node, hugetlb_cma_size - reserved);
 		size = round_up(size, PAGE_SIZE << order);
 
-		snprintf(name, 20, "hugetlb%d", nid);
+		snprintf(name, sizeof(name), "hugetlb%d", nid);
 		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
 						 0, false, name,
 						 &hugetlb_cma[nid], nid);
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
