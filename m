Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EA7C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4EA884B4B;
	Fri, 17 Dec 2021 08:38:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uQK-m2eoGGtk; Fri, 17 Dec 2021 08:38:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D2AF283EF6;
	Fri, 17 Dec 2021 08:38:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD99CC002F;
	Fri, 17 Dec 2021 08:38:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C919C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED7EB83F91
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJ6fiBMFHIOn for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 08:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B10683EBD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="325999631"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="325999631"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 00:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="662786059"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 00:38:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/4] iommu/vt-d: Drop duplicate check in
 dma_pte_free_pagetable()
Date: Fri, 17 Dec 2021 16:38:15 +0800
Message-Id: <20211217083817.1745419-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
References: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Kees Cook <keescook@chromium.org>,
 Yury Norov <yury.norov@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 Nick Desaulniers <ndesaulniers@google.com>, iommu@lists.linux-foundation.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

The BUG_ON check exists in dma_pte_clear_range(), kill the duplicate
check.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Link: https://lore.kernel.org/r/20211025032307.182974-1-wangkefeng.wang@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4acc97765209..e59895af952c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1280,10 +1280,6 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 				   unsigned long last_pfn,
 				   int retain_level)
 {
-	BUG_ON(!domain_pfn_supported(domain, start_pfn));
-	BUG_ON(!domain_pfn_supported(domain, last_pfn));
-	BUG_ON(start_pfn > last_pfn);
-
 	dma_pte_clear_range(domain, start_pfn, last_pfn);
 
 	/* We don't need lock here; nobody else touches the iova range */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
