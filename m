Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A58EC433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 17:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8C5440331;
	Wed,  9 Feb 2022 17:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j1fF9HdkWx_d; Wed,  9 Feb 2022 17:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB1DD4033D;
	Wed,  9 Feb 2022 17:49:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79FFBC0011;
	Wed,  9 Feb 2022 17:49:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED5A6C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 17:49:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB36E4033D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 17:49:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P2QhBL1k6hCP for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 17:49:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C389640331
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644428957; x=1675964957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UOUACCmc6ZSeIBWc/lGIpGPqTjbY/sikTiknQS2V6T8=;
 b=EAIJ7FCsLtxW9chPLH774Djbn6aXhDhtnQV5o3xqS73CBNi0QIrNjYvt
 wD+x9V62xhFa9Zz0u6WRSgAHBdVPVLV6fCBhSLgTq8mUeCxcrmU8vOU7p
 zfC/VQdWQjO+oGFzfjAyfVZnjqXp2MfiPZY5EItsTJlbS0AD8v4RbwWCh
 5EvcbE2fCjZUbbZmhe0U8/T3FER1+y0FGpNFErdsai1cuKcB9iha2Kc32
 x6fx6hAuQ7hRUIeX1FRLgUNZlES73GmgUeXwOVv1ZI7hg+ChOPeMqi1i3
 uxcVWArNFQe3JAgrMZCFt3H1O7PLc20V73l5eRK+Us28PxVTyjHCeMIV6 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249034335"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; d="scan'208";a="249034335"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 09:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; d="scan'208";a="633310153"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga004.jf.intel.com with ESMTP; 09 Feb 2022 09:49:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 9BD17107; Wed,  9 Feb 2022 19:49:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>, Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] iommu/vt-d: Don't cast parameter in for_each_set_bit()
Date: Wed,  9 Feb 2022 19:49:13 +0200
Message-Id: <20220209174913.4319-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

While in this particular case it would not be a (critical) issue,
the pattern itself is bad and error prone in case the location
of the parameter is changed.

Don't cast parameter to unsigned long pointer in for_each_set_bit().
Instead copy to a local variable on stack of a proper type and use.

Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..777e81b8f4f5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4973,6 +4973,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
+	unsigned long cache_bits;
 	unsigned long flags;
 	int cache_type;
 	u8 bus, devfn;
@@ -5008,9 +5009,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
 				   inv_info->granu.addr_info.nb_granules);
 
-	for_each_set_bit(cache_type,
-			 (unsigned long *)&inv_info->cache,
-			 IOMMU_CACHE_INV_TYPE_NR) {
+	cache_bits = inv_info->cache;
+	for_each_set_bit(cache_type, &cache_bits, IOMMU_CACHE_INV_TYPE_NR) {
 		int granu = 0;
 		u64 pasid = 0;
 		u64 addr = 0;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
