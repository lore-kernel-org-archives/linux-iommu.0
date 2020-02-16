Return-Path: <SRS0=EPxn=4E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E50C76199
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 22:02:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8375B20729
	for <iommu@archiver.kernel.org>; Sun, 16 Feb 2020 22:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8375B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 65237204B2;
	Sun, 16 Feb 2020 22:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ekAk8XXjEMFT; Sun, 16 Feb 2020 22:02:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C18CF20456;
	Sun, 16 Feb 2020 22:02:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEB67C07FF;
	Sun, 16 Feb 2020 22:02:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2932C013E
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E212285A49
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iXwopBHq0sFs for <iommu@lists.linux-foundation.org>;
 Sun, 16 Feb 2020 22:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7093685A00
 for <iommu@lists.linux-foundation.org>; Sun, 16 Feb 2020 22:02:35 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Feb 2020 14:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400"; d="scan'208";a="268200657"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by fmsmga002.fm.intel.com with ESMTP; 16 Feb 2020 14:02:35 -0800
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2 1/5] iommu: Add dev_def_domain_type() call back function to
 iommu_ops
Date: Sun, 16 Feb 2020 13:57:24 -0800
Message-Id: <297e01568e24d1537e0d7d6c088e363552b8ea49.1581619464.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

When user requests kernel to change the default domain type of a group
through sysfs, kernel has to make sure that it's ok to change the domain
type of every device in the group to the requested domain (every device may
not support both the domain types i.e. DMA and identity). Hence, add a call
back function that could be implemented per architecture that performs the
above check.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 include/linux/iommu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d1b5f4d98569..3f4aaad0aeb7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -248,6 +248,7 @@ struct iommu_iotlb_gather {
  * @cache_invalidate: invalidate translation caches
  * @sva_bind_gpasid: bind guest pasid and mm
  * @sva_unbind_gpasid: unbind guest pasid and mm
+ * @dev_def_domain_type: Return the required default domain type for a device
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
@@ -318,6 +319,8 @@ struct iommu_ops {
 
 	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
+	int (*dev_def_domain_type)(struct device *dev);
+
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
