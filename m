Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8461AC4332F
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 02:01:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44E1360B1E;
	Mon, 16 May 2022 02:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uo0BfjDEnbgI; Mon, 16 May 2022 02:01:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CF8860B50;
	Mon, 16 May 2022 02:01:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD72DC0032;
	Mon, 16 May 2022 02:01:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E852FC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D355A41517
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8yhSWl8yoLSi for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:01:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B965409DE
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652666487; x=1684202487;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Hgd203HC0g1TyuguE1zfaQq4/xIrHOAw15KA4w3UCI=;
 b=MZ2WG9sSWyzQF+Iwt2SwXQ3NVDnIQZCzKUuxtR3LniPfvKh+vaMQknOV
 8lQKqR3vQs0Z5sxmyxHSVNTN2w1P7Vaw14xc3uNe+RcQBnqBPq0fLLFeJ
 QLoVhvlO08hP57MLItcUQLj+GJd11QgYI/WSOPV/XiUMui9TiYhK7J0q7
 aExsa+HjNyp8KnCRAlXW8LrZCTkKk1t6gwImYlcuCygB1TlZpJjVMLk3L
 szzC/t/aN7vckoehBSJZT7HU5ht60YXEJrAkwSyuDydnEgIjOxbQveoiZ
 Z1y96I86rOo2nm09tT+AcWUb350Lj8WGT1TPZgo+PmrAV0V2rf9sd7IbU g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270829263"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="270829263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2022 19:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="713172191"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:24 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 4/5] iommu: Use blocking domain for empty domain attaching
Date: Mon, 16 May 2022 09:57:58 +0800
Message-Id: <20220516015759.2952771-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

If a NULL domain is about to set to a device, let's set the blocking
domain instead.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dcbc55c9d8d7..ba0f427c2823 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2058,16 +2058,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
-static void __iommu_detach_device(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	if (iommu_is_attach_deferred(dev))
-		return;
-
-	domain->ops->detach_dev(domain, dev);
-	trace_detach_device_from_domain(dev);
-}
-
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2160,15 +2150,6 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_detach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	__iommu_detach_device(domain, dev);
-
-	return 0;
-}
-
 static int __iommu_group_set_domain(struct iommu_group *group,
 				    struct iommu_domain *new_domain)
 {
@@ -2177,19 +2158,9 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 	if (group->domain == new_domain)
 		return 0;
 
-	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
-	 * platform specific behavior.
-	 */
-	if (!new_domain) {
-		if (WARN_ON(!group->domain->ops->detach_dev))
-			return -EINVAL;
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_detach_device);
-		group->domain = NULL;
-		return 0;
-	}
+	/* The NULL domain represents some platform specific behavior. */
+	if (!new_domain)
+		new_domain = group->blocking_domain;
 
 	/*
 	 * Changing the domain is done by calling set_dev() on the new
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
