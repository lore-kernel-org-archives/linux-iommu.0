Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0167C433F5
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 02:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9078460DFD;
	Thu,  6 Jan 2022 02:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5oj9IV51fFQ6; Thu,  6 Jan 2022 02:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 605BE60D8C;
	Thu,  6 Jan 2022 02:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22D4CC002F;
	Thu,  6 Jan 2022 02:22:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B544BC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9421840582
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHGNvT9Nks7r for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 02:22:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C17B640017
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641435771; x=1672971771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AR5i2NMwGfSOdi+HLgKnhlt3tjHftmsXmPOft4wFOHU=;
 b=goOwz0FsPCDiwKiIIRNd6XvrIt+KHMOZuKcd5wpTo3Fpo/ZrRFpiseln
 aifPXPlKhCWy034PriWEDuE3hBwdjCLM99DSYNYAh2nAydLqcUdD2EXI1
 ak7U4h35oU3PYjaDW9dQW0N/JVyXX6NgiHSJuU0MBbsNWTW//A9YgXLMa
 AZ7uOG1T3iIyhAx9bM1sG5yN85WTRMEvfHlKlFsEIU7t3vvzzucD6rTfp
 EH5dgsXLGVcDhqKQ6ce3Es213mVkJjJ6S3sYaKsKpxTcK7gWdUrWgvbwT
 L9DtOribYaY3aCJj+/jolE2guCSWdZ0rR2eLoUarzJ71iXy60NmAfuLPi w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223259112"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="223259112"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 18:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526794556"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 18:22:40 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1 8/8] iommu: Remove iommu_attach/detach_group()
Date: Thu,  6 Jan 2022 10:20:53 +0800
Message-Id: <20220106022053.2406748-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

The iommu_attach/detach_group() interfaces have no reference in the tree
anymore. Remove them to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 15 ---------------
 drivers/iommu/iommu.c | 20 --------------------
 2 files changed, 35 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 66ebce3d1e11..2568ab0d0872 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -457,10 +457,6 @@ iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
 
-extern int iommu_attach_group(struct iommu_domain *domain,
-			      struct iommu_group *group);
-extern void iommu_detach_group(struct iommu_domain *domain,
-			       struct iommu_group *group);
 extern struct iommu_group *iommu_group_alloc(void);
 extern void *iommu_group_get_iommudata(struct iommu_group *group);
 extern void iommu_group_set_iommudata(struct iommu_group *group,
@@ -818,17 +814,6 @@ static inline bool iommu_default_passthrough(void)
 	return true;
 }
 
-static inline int iommu_attach_group(struct iommu_domain *domain,
-				     struct iommu_group *group)
-{
-	return -ENODEV;
-}
-
-static inline void iommu_detach_group(struct iommu_domain *domain,
-				      struct iommu_group *group)
-{
-}
-
 static inline struct iommu_group *iommu_group_alloc(void)
 {
 	return ERR_PTR(-ENODEV);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2c9efd85e447..33f7027e677f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2308,18 +2308,6 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 	return ret;
 }
 
-int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
-{
-	int ret;
-
-	mutex_lock(&group->mutex);
-	ret = __iommu_attach_group(domain, group);
-	mutex_unlock(&group->mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_attach_group);
-
 static int iommu_group_do_detach_device(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
@@ -2357,14 +2345,6 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 		group->domain = group->default_domain;
 }
 
-void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
-{
-	mutex_lock(&group->mutex);
-	__iommu_detach_group(domain, group);
-	mutex_unlock(&group->mutex);
-}
-EXPORT_SYMBOL_GPL(iommu_detach_group);
-
 phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	if (domain->type == IOMMU_DOMAIN_IDENTITY)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
