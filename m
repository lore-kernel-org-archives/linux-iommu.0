Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C70C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CF2205F4
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CF2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9799786A37;
	Fri, 15 Jan 2021 12:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Aue4EGNwQ_hc; Fri, 15 Jan 2021 12:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F06C486AA5;
	Fri, 15 Jan 2021 12:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7D44C08A1;
	Fri, 15 Jan 2021 12:14:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F01AAC013A;
 Fri, 15 Jan 2021 12:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DF5C086A37;
 Fri, 15 Jan 2021 12:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tducdHHdyYo0; Fri, 15 Jan 2021 12:14:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C63D186AA5;
 Fri, 15 Jan 2021 12:14:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE1C14BF;
 Fri, 15 Jan 2021 04:14:42 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC5FA3F70D;
 Fri, 15 Jan 2021 04:14:37 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 10/15] iommu/virtio: Prepare to add attach pasid table
 infrastructure
Date: Fri, 15 Jan 2021 17:43:37 +0530
Message-Id: <20210115121342.15093-11-vivek.gautam@arm.com>
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

In preparation to add attach pasid table op, separate out the
existing attach request code to a separate method.

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
 drivers/iommu/virtio-iommu.c | 73 +++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 12d73321dbf4..ae5dfd3f8269 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -52,6 +52,8 @@ struct viommu_dev {
 	/* Supported MAP flags */
 	u32				map_flags;
 	u32				probe_size;
+
+	bool				has_map:1;
 };
 
 struct viommu_mapping {
@@ -60,6 +62,11 @@ struct viommu_mapping {
 	u32				flags;
 };
 
+struct viommu_mm {
+	struct io_pgtable_ops		*ops;
+	struct viommu_domain		*domain;
+};
+
 struct viommu_domain {
 	struct iommu_domain		domain;
 	struct viommu_dev		*viommu;
@@ -67,12 +74,20 @@ struct viommu_domain {
 	unsigned int			id;
 	u32				map_flags;
 
+	/* Default address space when a table is bound */
+	struct viommu_mm		mm;
+
+	/* When no table is bound, use generic mappings */
 	spinlock_t			mappings_lock;
 	struct rb_root_cached		mappings;
 
 	unsigned long			nr_endpoints;
 };
 
+#define vdev_for_each_id(i, eid, vdev)					\
+	for (i = 0; i < vdev->dev->iommu->fwspec->num_ids &&		\
+		({ eid = vdev->dev->iommu->fwspec->ids[i]; 1; }); i++)
+
 struct viommu_endpoint {
 	struct device			*dev;
 	struct viommu_dev		*viommu;
@@ -750,12 +765,40 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	kfree(vdomain);
 }
 
+static int viommu_simple_attach(struct viommu_domain *vdomain,
+				struct viommu_endpoint *vdev)
+{
+	int i, eid, ret;
+	struct virtio_iommu_req_attach req = {
+		.head.type	= VIRTIO_IOMMU_T_ATTACH,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	if (!vdomain->viommu->has_map)
+		return -ENODEV;
+
+	vdev_for_each_id(i, eid, vdev) {
+		req.endpoint = cpu_to_le32(eid);
+
+		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
+		if (ret)
+			return ret;
+	}
+
+	if (!vdomain->nr_endpoints) {
+		/*
+		 * This endpoint is the first to be attached to the domain.
+		 * Replay existing mappings if any (e.g. SW MSI).
+		 */
+		ret = viommu_replay_mappings(vdomain);
+	}
+
+	return ret;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	int i;
 	int ret = 0;
-	struct virtio_iommu_req_attach req;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -790,25 +833,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (vdev->vdomain)
 		vdev->vdomain->nr_endpoints--;
 
-	req = (struct virtio_iommu_req_attach) {
-		.head.type	= VIRTIO_IOMMU_T_ATTACH,
-		.domain		= cpu_to_le32(vdomain->id),
-	};
-
-	for (i = 0; i < fwspec->num_ids; i++) {
-		req.endpoint = cpu_to_le32(fwspec->ids[i]);
-
-		ret = viommu_send_req_sync(vdomain->viommu, &req, sizeof(req));
-		if (ret)
-			return ret;
-	}
-
-	if (!vdomain->nr_endpoints) {
-		/*
-		 * This endpoint is the first to be attached to the domain.
-		 * Replay existing mappings (e.g. SW MSI).
-		 */
-		ret = viommu_replay_mappings(vdomain);
+	if (!vdomain->mm.ops) {
+		/* If we couldn't bind any table, use the mapping tree */
+		ret = viommu_simple_attach(vdomain, vdev);
 		if (ret)
 			return ret;
 	}
@@ -1142,6 +1169,8 @@ static int viommu_probe(struct virtio_device *vdev)
 				struct virtio_iommu_config, probe_size,
 				&viommu->probe_size);
 
+	viommu->has_map = virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP);
+
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
 		.aperture_end	= input_end,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
