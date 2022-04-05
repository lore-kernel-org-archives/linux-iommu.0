Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C24CC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 14:36:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 175C34161E;
	Tue,  5 Apr 2022 14:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5MvlaQrqTema; Tue,  5 Apr 2022 14:36:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBE86415F6;
	Tue,  5 Apr 2022 14:36:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE80C001D;
	Tue,  5 Apr 2022 14:36:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E712C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2DBC08145F
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:36:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hk8vElQUWYcJ for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 14:36:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2904382F41
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 14:36:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2EF623A;
 Tue,  5 Apr 2022 07:36:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C05F63F5A1;
 Tue,  5 Apr 2022 07:36:04 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: benve@cisco.com,
	neescoba@cisco.com,
	jgg@ziepe.ca
Subject: [PATCH] RDMA/usnic: Refactor usnic_uiom_alloc_pd()
Date: Tue,  5 Apr 2022 15:35:59 +0100
Message-Id: <ef607cb3f5a09920b86971b8c8e60af8c647457e.1649169359.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

Rather than hard-coding pci_bus_type, pass the PF device through to
usnic_uiom_alloc_pd() and retrieve its bus there. This prepares for
iommu_domain_alloc() changing to take a device rather than a bus_type.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 3 +--
 drivers/infiniband/hw/usnic/usnic_uiom.c     | 5 ++---
 drivers/infiniband/hw/usnic/usnic_uiom.h     | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index d3a9670bf971..06aae6a79c3d 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -442,7 +442,7 @@ int usnic_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct usnic_ib_pd *pd = to_upd(ibpd);
 
-	pd->umem_pd = usnic_uiom_alloc_pd();
+	pd->umem_pd = usnic_uiom_alloc_pd(ibpd->device->dev.parent);
 	if (IS_ERR(pd->umem_pd))
 		return PTR_ERR(pd->umem_pd);
 
@@ -706,4 +706,3 @@ int usnic_ib_mmap(struct ib_ucontext *context,
 	usnic_err("No VF %u found\n", vfid);
 	return -EINVAL;
 }
-
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 8c48027614a1..e212929369df 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -40,7 +40,6 @@
 #include <linux/iommu.h>
 #include <linux/workqueue.h>
 #include <linux/list.h>
-#include <linux/pci.h>
 #include <rdma/ib_verbs.h>
 
 #include "usnic_log.h"
@@ -439,7 +438,7 @@ void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr)
 	__usnic_uiom_release_tail(uiomr);
 }
 
-struct usnic_uiom_pd *usnic_uiom_alloc_pd(void)
+struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev)
 {
 	struct usnic_uiom_pd *pd;
 	void *domain;
@@ -448,7 +447,7 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(void)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	pd->domain = domain = iommu_domain_alloc(&pci_bus_type);
+	pd->domain = domain = iommu_domain_alloc(dev->bus);
 	if (!domain) {
 		usnic_err("Failed to allocate IOMMU domain");
 		kfree(pd);
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 9407522179e9..5a9acf941510 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -80,7 +80,7 @@ struct usnic_uiom_chunk {
 	struct scatterlist		page_list[];
 };
 
-struct usnic_uiom_pd *usnic_uiom_alloc_pd(void);
+struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev);
 void usnic_uiom_dealloc_pd(struct usnic_uiom_pd *pd);
 int usnic_uiom_attach_dev_to_pd(struct usnic_uiom_pd *pd, struct device *dev);
 void usnic_uiom_detach_dev_from_pd(struct usnic_uiom_pd *pd,
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
