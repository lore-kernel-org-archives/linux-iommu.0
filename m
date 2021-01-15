Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F712C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2A5206D4
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2A5206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E45DB84F27;
	Fri, 15 Jan 2021 12:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wyRFQ5qneX6a; Fri, 15 Jan 2021 12:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CE7B84C20;
	Fri, 15 Jan 2021 12:14:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 009D8C08A1;
	Fri, 15 Jan 2021 12:14:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E98E2C013A;
 Fri, 15 Jan 2021 12:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E5D7486A37;
 Fri, 15 Jan 2021 12:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dFLLOyiDXHjl; Fri, 15 Jan 2021 12:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DA3F086958;
 Fri, 15 Jan 2021 12:14:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D53313D5;
 Fri, 15 Jan 2021 04:14:27 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 069603F70D;
 Fri, 15 Jan 2021 04:14:22 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 07/15] iommu/virtio: Add table format probing
Date: Fri, 15 Jan 2021 17:43:34 +0530
Message-Id: <20210115121342.15093-8-vivek.gautam@arm.com>
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

The device may provide information about hardware tables and additional
capabilities for each device. Parse the new probe fields.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
[Vivek: Refactor to use "struct virtio_iommu_probe_table_format" rather
        than separate structures for page table and pasid table format.]
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
 drivers/iommu/virtio-iommu.c | 102 ++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 2bfdd5734844..12d73321dbf4 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -78,6 +78,17 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+
+	/* properties of the physical IOMMU */
+	u64				pgsize_mask;
+	u64				input_start;
+	u64				input_end;
+	u8				output_bits;
+	u8				pasid_bits;
+	/* Preferred PASID table format */
+	void				*pstf;
+	/* Preferred page table format */
+	void				*pgtf;
 };
 
 struct viommu_request {
@@ -457,6 +468,72 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	return 0;
 }
 
+static int viommu_add_pgsize_mask(struct viommu_endpoint *vdev,
+				  struct virtio_iommu_probe_page_size_mask *prop,
+				  size_t len)
+{
+	if (len < sizeof(*prop))
+		return -EINVAL;
+	vdev->pgsize_mask = le64_to_cpu(prop->mask);
+	return 0;
+}
+
+static int viommu_add_input_range(struct viommu_endpoint *vdev,
+				  struct virtio_iommu_probe_input_range *prop,
+				  size_t len)
+{
+	if (len < sizeof(*prop))
+		return -EINVAL;
+	vdev->input_start	= le64_to_cpu(prop->start);
+	vdev->input_end		= le64_to_cpu(prop->end);
+	return 0;
+}
+
+static int viommu_add_output_size(struct viommu_endpoint *vdev,
+				  struct virtio_iommu_probe_output_size *prop,
+				  size_t len)
+{
+	if (len < sizeof(*prop))
+		return -EINVAL;
+	vdev->output_bits = prop->bits;
+	return 0;
+}
+
+static int viommu_add_pasid_size(struct viommu_endpoint *vdev,
+				 struct virtio_iommu_probe_pasid_size *prop,
+				 size_t len)
+{
+	if (len < sizeof(*prop))
+		return -EINVAL;
+	vdev->pasid_bits = prop->bits;
+	return 0;
+}
+
+static int viommu_add_pgtf(struct viommu_endpoint *vdev, void *pgtf, size_t len)
+{
+	/* Select the first page table format available */
+	if (len < sizeof(struct virtio_iommu_probe_table_format) || vdev->pgtf)
+		return -EINVAL;
+
+	vdev->pgtf = kmemdup(pgtf, len, GFP_KERNEL);
+	if (!vdev->pgtf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int viommu_add_pstf(struct viommu_endpoint *vdev, void *pstf, size_t len)
+{
+	if (len < sizeof(struct virtio_iommu_probe_table_format) || vdev->pstf)
+		return -EINVAL;
+
+	vdev->pstf = kmemdup(pstf, len, GFP_KERNEL);
+	if (!vdev->pstf)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 {
 	int ret;
@@ -493,11 +570,30 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 
 	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
 	       cur < viommu->probe_size) {
+		void *value = prop;
 		len = le16_to_cpu(prop->length) + sizeof(*prop);
 
 		switch (type) {
 		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
-			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
+			ret = viommu_add_resv_mem(vdev, value, len);
+			break;
+		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
+			ret = viommu_add_pgsize_mask(vdev, value, len);
+			break;
+		case VIRTIO_IOMMU_PROBE_T_INPUT_RANGE:
+			ret = viommu_add_input_range(vdev, value, len);
+			break;
+		case VIRTIO_IOMMU_PROBE_T_OUTPUT_SIZE:
+			ret = viommu_add_output_size(vdev, value, len);
+			break;
+		case VIRTIO_IOMMU_PROBE_T_PASID_SIZE:
+			ret = viommu_add_pasid_size(vdev, value, len);
+			break;
+		case VIRTIO_IOMMU_PROBE_T_PAGE_TABLE_FMT:
+			ret = viommu_add_pgtf(vdev, value, len);
+			break;
+		case VIRTIO_IOMMU_PROBE_T_PASID_TABLE_FMT:
+			ret = viommu_add_pstf(vdev, value, len);
 			break;
 		default:
 			dev_err(dev, "unknown viommu prop 0x%x\n", type);
@@ -899,6 +995,8 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 
 err_free_dev:
 	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
+	kfree(vdev->pstf);
+	kfree(vdev->pgtf);
 	kfree(vdev);
 
 	return ERR_PTR(ret);
@@ -915,6 +1013,8 @@ static void viommu_release_device(struct device *dev)
 	vdev = dev_iommu_priv_get(dev);
 
 	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
+	kfree(vdev->pstf);
+	kfree(vdev->pgtf);
 	kfree(vdev);
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
