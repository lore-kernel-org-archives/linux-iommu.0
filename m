Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C69EC4332F
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 06:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA27240B51;
	Fri, 17 Dec 2021 06:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Erl4GKA8zkjf; Fri, 17 Dec 2021 06:38:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61F7D404BB;
	Fri, 17 Dec 2021 06:38:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35D9DC002F;
	Fri, 17 Dec 2021 06:38:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FE12C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F27761083
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sYX48yydVtN2 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 06:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E66D61080
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="226552187"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="226552187"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 22:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="519623238"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 22:38:09 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v4 05/13] iommu: Add security context management for assigned
 devices
Date: Fri, 17 Dec 2021 14:37:00 +0800
Message-Id: <20211217063708.1740334-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/iommu.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5439bf45afb2..573e253bad51 100644
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
@@ -2323,7 +2328,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -2360,7 +2365,12 @@ static void __iommu_detach_group(struct iommu_domain *domain,
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
@@ -3373,6 +3383,16 @@ static int iommu_group_set_dma_owner(struct iommu_group *group,
 	group->owner_cookie = owner_cookie;
 	group->owner_cnt++;
 
+	/*
+	 * We must ensure that any device DMAs issued after this call
+	 * are discarded. DMAs can only reach real memory once someone
+	 * has attached a real domain.
+	 */
+	if (owner == DMA_OWNER_PRIVATE_DOMAIN_USER &&
+	    group->domain &&
+	    !WARN_ON(group->domain != group->default_domain))
+		__iommu_detach_group(group->domain, group);
+
 unlock_out:
 	mutex_unlock(&group->mutex);
 
@@ -3391,6 +3411,15 @@ static void iommu_group_release_dma_owner(struct iommu_group *group,
 
 	group->dma_owner = DMA_OWNER_DMA_API;
 
+	/*
+	 * The UNMANAGED domain should be detached before all USER
+	 * owners have been released.
+	 */
+	if (owner == DMA_OWNER_PRIVATE_DOMAIN_USER) {
+		if (!WARN_ON(group->domain) && group->default_domain)
+			__iommu_attach_group(group->default_domain, group);
+	}
+
 unlock_out:
 	mutex_unlock(&group->mutex);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
