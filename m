Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19638C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45D120691
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45D120691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD899873E0;
	Fri, 15 Jan 2021 12:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4b0yjNBMNkid; Fri, 15 Jan 2021 12:14:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 728D087323;
	Fri, 15 Jan 2021 12:14:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E3BDC08A1;
	Fri, 15 Jan 2021 12:14:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCD46C013A;
 Fri, 15 Jan 2021 12:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA45C86A39;
 Fri, 15 Jan 2021 12:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VeVhUA6NlsNK; Fri, 15 Jan 2021 12:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C7C686958;
 Fri, 15 Jan 2021 12:14:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C4214F6;
 Fri, 15 Jan 2021 04:14:52 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D41F23F70D;
 Fri, 15 Jan 2021 04:14:47 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 12/15] iommu/virtio: Add support for INVALIDATE request
Date: Fri, 15 Jan 2021 17:43:39 +0530
Message-Id: <20210115121342.15093-13-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, vivek.gautam@arm.com,
 robin.murphy@arm.com
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Add support for tlb invalidation ops that can send invalidation
requests to back-end virtio-iommu when stage-1 page tables are
supported.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Refactoring the iommu_flush_ops, and adding only one pasid sync
        op that's needed with current iommu-pasid-table infrastructure.
	Also updating uapi defines as required by latest changes]
Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/virtio-iommu.c | 95 ++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index ae5dfd3f8269..004ea94e3731 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -13,6 +13,7 @@
 #include <linux/freezer.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
+#include <linux/io-pgtable.h>
 #include <linux/module.h>
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
@@ -63,6 +64,8 @@ struct viommu_mapping {
 };
 
 struct viommu_mm {
+	int				pasid;
+	u64				archid;
 	struct io_pgtable_ops		*ops;
 	struct viommu_domain		*domain;
 };
@@ -692,6 +695,98 @@ static void viommu_event_handler(struct virtqueue *vq)
 	virtqueue_kick(vq);
 }
 
+/* PASID and pgtable APIs */
+
+static void __viommu_flush_pasid_tlb_all(struct viommu_domain *vdomain,
+					 int pasid, u64 arch_id, int type)
+{
+	struct virtio_iommu_req_invalidate req = {
+		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
+		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
+		.flags		= cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID),
+		.inv_type	= cpu_to_le32(type),
+
+		.domain		= cpu_to_le32(vdomain->id),
+		.pasid		= cpu_to_le32(pasid),
+		.archid		= cpu_to_le64(arch_id),
+	};
+
+	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
+		pr_debug("could not send invalidate request\n");
+}
+
+static void viommu_flush_tlb_add(struct iommu_iotlb_gather *gather,
+				 unsigned long iova, size_t granule,
+				 void *cookie)
+{
+	struct viommu_mm *viommu_mm = cookie;
+	struct viommu_domain *vdomain = viommu_mm->domain;
+	struct iommu_domain *domain = &vdomain->domain;
+
+	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
+}
+
+static void viommu_flush_tlb_walk(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+	struct viommu_mm *viommu_mm = cookie;
+	struct viommu_domain *vdomain = viommu_mm->domain;
+	struct virtio_iommu_req_invalidate req = {
+		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
+		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_VA),
+		.inv_type	= cpu_to_le32(VIRTIO_IOMMU_INV_T_IOTLB),
+		.flags		= cpu_to_le32(VIRTIO_IOMMU_INVAL_F_ARCHID),
+
+		.domain		= cpu_to_le32(vdomain->id),
+		.pasid		= cpu_to_le32(viommu_mm->pasid),
+		.archid		= cpu_to_le64(viommu_mm->archid),
+		.virt_start	= cpu_to_le64(iova),
+		.nr_pages	= cpu_to_le64(size / granule),
+		.granule	= ilog2(granule),
+	};
+
+	if (viommu_add_req(vdomain->viommu, &req, sizeof(req)))
+		pr_debug("could not add invalidate request\n");
+}
+
+static void viommu_flush_tlb_all(void *cookie)
+{
+	struct viommu_mm *viommu_mm = cookie;
+
+	if (!viommu_mm->archid)
+		return;
+
+	__viommu_flush_pasid_tlb_all(viommu_mm->domain, viommu_mm->pasid,
+				     viommu_mm->archid,
+				     VIRTIO_IOMMU_INV_T_IOTLB);
+}
+
+static struct iommu_flush_ops viommu_flush_ops = {
+	.tlb_flush_all		= viommu_flush_tlb_all,
+	.tlb_flush_walk		= viommu_flush_tlb_walk,
+	.tlb_add_page		= viommu_flush_tlb_add,
+};
+
+static void viommu_flush_pasid(void *cookie, int pasid, bool leaf)
+{
+	struct viommu_domain *vdomain = cookie;
+	struct virtio_iommu_req_invalidate req = {
+		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
+		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
+		.inv_type	= cpu_to_le32(VIRTIO_IOMMU_INV_T_PASID),
+		.flags		= cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID),
+
+		.domain		= cpu_to_le32(vdomain->id),
+		.pasid		= cpu_to_le32(pasid),
+	};
+
+	if (leaf)
+		req.flags	|= cpu_to_le32(VIRTIO_IOMMU_INVAL_F_LEAF);
+
+	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
+		pr_debug("could not send invalidate request\n");
+}
+
 /* IOMMU API */
 
 static struct iommu_domain *viommu_domain_alloc(unsigned type)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
