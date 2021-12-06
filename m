Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FD0C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 02:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D83EE82EA1;
	Mon,  6 Dec 2021 02:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UfhzrQL2JlDd; Mon,  6 Dec 2021 02:00:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BE85082E5F;
	Mon,  6 Dec 2021 02:00:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5F9DC001E;
	Mon,  6 Dec 2021 02:00:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 032F2C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6C2940486
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tCud0X91be_e for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 02:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53A5940473
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237041103"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="237041103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 18:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514542441"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 18:00:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 10/18] iommu: Add security context management for assigned
 devices
Date: Mon,  6 Dec 2021 09:58:55 +0800
Message-Id: <20211206015903.88687-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206015903.88687-1-baolu.lu@linux.intel.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

When an iommu group has DMA_OWNER_PRIVATE_DOMAIN_USER set for the first
time, it is a contract that the group could be assigned to userspace from
now on. The group must be detached from the default iommu domain and all
devices in this group are blocked from doing DMA until it is attached to a
user controlled iommu_domain. Correspondingly, the default domain should
be reattached after the last DMA_OWNER_USER is released.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1de520a07518..0cba04a8ea3b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -292,7 +292,12 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
 
-	if (group->default_domain) {
+	/*
+	 * If any device in the group has been initialized for user dma,
+	 * avoid attaching the default domain.
+	 */
+	if (group->default_domain &&
+	    group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER) {
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
@@ -2324,7 +2329,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -2361,7 +2366,12 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (!group->default_domain) {
+	/*
+	 * If any device in the group has been initialized for user dma,
+	 * avoid re-attaching the default domain.
+	 */
+	if (!group->default_domain ||
+	    group->dma_owner == DMA_OWNER_PRIVATE_DOMAIN_USER) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
 		group->domain = NULL;
@@ -3371,6 +3381,23 @@ static int __iommu_group_set_dma_owner(struct iommu_group *group,
 	}
 
 	group->dma_owner = owner;
+
+	/*
+	 * We must ensure that any device DMAs issued after this call
+	 * are discarded. DMAs can only reach real memory once someone
+	 * has attached a real domain.
+	 */
+	if (owner == DMA_OWNER_PRIVATE_DOMAIN_USER) {
+		if (group->domain) {
+			if (group->domain != group->default_domain) {
+				group->dma_owner = DMA_OWNER_NONE;
+				return -EBUSY;
+			}
+
+			__iommu_detach_group(group->domain, group);
+		}
+	}
+
 	group->owner_cookie = owner_cookie;
 	refcount_set(&group->owner_cnt, 1);
 
@@ -3387,6 +3414,15 @@ static void __iommu_group_release_dma_owner(struct iommu_group *group,
 		return;
 
 	group->dma_owner = DMA_OWNER_NONE;
+
+	/*
+	 * The UNMANAGED domain should be detached before all USER
+	 * owners have been released.
+	 */
+	if (owner == DMA_OWNER_PRIVATE_DOMAIN_USER) {
+		if (!WARN_ON(group->domain) && group->default_domain)
+			__iommu_attach_group(group->default_domain, group);
+	}
 }
 
 /**
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
