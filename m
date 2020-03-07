Return-Path: <SRS0=5+/2=4Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829FFC10F26
	for <iommu@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604A02070A
	for <iommu@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604A02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E2C5E203CE;
	Sat,  7 Mar 2020 06:23:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Su4ciT3JT0Gu; Sat,  7 Mar 2020 06:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F3B9A2037E;
	Sat,  7 Mar 2020 06:23:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E10B1C18D3;
	Sat,  7 Mar 2020 06:23:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2732AC013E
 for <iommu@lists.linux-foundation.org>; Sat,  7 Mar 2020 06:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 15A8B203A0
 for <iommu@lists.linux-foundation.org>; Sat,  7 Mar 2020 06:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJfeLXGelKyE for <iommu@lists.linux-foundation.org>;
 Sat,  7 Mar 2020 06:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 3E6AF20119
 for <iommu@lists.linux-foundation.org>; Sat,  7 Mar 2020 06:23:13 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 22:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; d="scan'208";a="352915146"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2020 22:23:10 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/6] iommu: Add dev_def_domain_type() callback in iommu_ops
Date: Sat,  7 Mar 2020 14:20:09 +0800
Message-Id: <20200307062014.3288-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200307062014.3288-1-baolu.lu@linux.intel.com>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Some devices are reqired to use a specific type (identity or dma)
of default domain when they are used with a vendor iommu. When the
system level default domain type is different from it, the vendor
iommu driver has to request a new default domain with
iommu_request_dma_domain_for_dev() and iommu_request_dm_for_dev()
in the add_dev() callback. Unfortunately, these two helpers only
work when the group hasn't been assigned to any other devices,
hence, some vendor iommu driver has to use a private domain if
it fails to request a new default one.

This adds dev_def_domain_type() callback in the iommu_ops, so that
the special requirement of default domain for a device could be
aware by the iommu generic layer.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..0c1e95e6b263 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -248,6 +248,10 @@ struct iommu_iotlb_gather {
  * @cache_invalidate: invalidate translation caches
  * @sva_bind_gpasid: bind guest pasid and mm
  * @sva_unbind_gpasid: unbind guest pasid and mm
+ * @dev_def_domain_type: device default domain type, return value:
+ *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
+ *		- IOMMU_DOMAIN_DMA: must use a dma domain
+ *		- 0: use the default setting
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
@@ -318,6 +322,8 @@ struct iommu_ops {
 
 	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
+	int (*dev_def_domain_type)(struct device *dev);
+
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
