Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D9DC43460
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC79613C3
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC79613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8476B606B9;
	Fri, 23 Apr 2021 09:52:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wmRaWguCIN97; Fri, 23 Apr 2021 09:52:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 284EF60674;
	Fri, 23 Apr 2021 09:52:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06B6AC000F;
	Fri, 23 Apr 2021 09:52:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2FC9C000F;
 Fri, 23 Apr 2021 09:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E85360674;
 Fri, 23 Apr 2021 09:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TeidhnEpXftB; Fri, 23 Apr 2021 09:52:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86CC560A56;
 Fri, 23 Apr 2021 09:52:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E92FD1597;
 Fri, 23 Apr 2021 02:52:21 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0CA23F774;
 Fri, 23 Apr 2021 02:52:17 -0700 (PDT)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 05/11] iommu/virtio: Add SVA feature and related
 enable/disable callbacks
Date: Fri, 23 Apr 2021 15:21:41 +0530
Message-Id: <20210423095147.27922-6-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, Vivek Gautam <vivek.gautam@arm.com>, robin.murphy@arm.com
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

Add a feature flag to virtio iommu for Shared virtual addressing
(SVA). This feature would indicate the availablily path for handling
device page faults, and the provision for sending page response.
Also add necessary methods to enable and disable SVA so that the
masters can enable the SVA path. This also requires enabling the
PRI capability on the device.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c      | 268 ++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_iommu.h |   1 +
 2 files changed, 269 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3da5f0807711..250c137a211b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -18,6 +18,7 @@
 #include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/pci-ats.h>
 #include <linux/platform_device.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
@@ -26,6 +27,7 @@
 
 #include <uapi/linux/virtio_iommu.h>
 #include "iommu-pasid-table.h"
+#include "iommu-sva-lib.h"
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -37,6 +39,9 @@
 /* Some architectures need an Address Space ID for each page table */
 DEFINE_XARRAY_ALLOC1(viommu_asid_xa);
 
+static DEFINE_MUTEX(sva_lock);
+static DEFINE_MUTEX(iopf_lock);
+
 struct viommu_dev_pri_work {
 	struct work_struct		work;
 	struct viommu_dev		*dev;
@@ -71,6 +76,7 @@ struct viommu_dev {
 
 	bool				has_map:1;
 	bool				has_table:1;
+	bool				has_sva:1;
 };
 
 struct viommu_mapping {
@@ -124,6 +130,12 @@ struct viommu_endpoint {
 	void				*pstf;
 	/* Preferred page table format */
 	void				*pgtf;
+
+	/* sva */
+	bool				ats_supported;
+	bool				pri_supported;
+	bool				sva_enabled;
+	bool				iopf_enabled;
 };
 
 struct viommu_ep_entry {
@@ -582,6 +594,64 @@ static int viommu_add_pstf(struct viommu_endpoint *vdev, void *pstf, size_t len)
 	return 0;
 }
 
+static int viommu_init_ats_pri(struct viommu_endpoint *vdev)
+{
+	struct device *dev = vdev->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!dev_is_pci(vdev->dev))
+		return -EINVAL;
+
+	if (pci_ats_supported(pdev))
+		vdev->ats_supported = true;
+
+	if (pci_pri_supported(pdev))
+		vdev->pri_supported = true;
+
+	return 0;
+}
+
+static int viommu_enable_pri(struct viommu_endpoint *vdev)
+{
+	int ret;
+	struct pci_dev *pdev;
+
+	/* Let's allow only 4 requests for PRI right now */
+	size_t max_inflight_pprs = 4;
+
+	if (!vdev->pri_supported || !vdev->ats_supported)
+		return -ENODEV;
+
+	pdev = to_pci_dev(vdev->dev);
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_pri(pdev, max_inflight_pprs);
+	if (ret) {
+		dev_err(vdev->dev, "cannot enable PRI: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void viommu_disable_pri(struct viommu_endpoint *vdev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(vdev->dev))
+		return;
+
+	pdev = to_pci_dev(vdev->dev);
+
+	if (!pdev->pri_enabled)
+		return;
+
+	pci_disable_pri(pdev);
+}
+
 static int viommu_init_queues(struct viommu_dev *viommu)
 {
 	viommu->iopf_pri = iopf_queue_alloc(dev_name(viommu->dev));
@@ -684,6 +754,10 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	if (ret)
 		goto out_free_eps;
 
+	ret = viommu_init_ats_pri(vdev);
+	if (ret)
+		goto out_free_eps;
+
 	kfree(probe);
 	return 0;
 
@@ -1681,6 +1755,194 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static bool viommu_endpoint_iopf_supported(struct viommu_endpoint *vdev)
+{
+	/* TODO: support Stall model later */
+	return vdev->pri_supported;
+}
+
+bool viommu_endpoint_sva_supported(struct viommu_endpoint *vdev)
+{
+	struct viommu_dev *viommu = vdev->viommu;
+
+	if (!viommu->has_sva)
+		return false;
+
+	return vdev->pasid_bits;
+}
+
+bool viommu_endpoint_sva_enabled(struct viommu_endpoint *vdev)
+{
+	bool enabled;
+
+	mutex_lock(&sva_lock);
+	enabled = vdev->sva_enabled;
+	mutex_unlock(&sva_lock);
+	return enabled;
+}
+
+static int viommu_endpoint_sva_enable_iopf(struct viommu_endpoint *vdev)
+{
+	int ret;
+	struct device *dev = vdev->dev;
+
+	if (!viommu_endpoint_iopf_supported(vdev))
+		return 0;
+
+	if (!vdev->iopf_enabled)
+		return -EINVAL;
+
+	if (vdev->pri_supported) {
+		ret = iopf_queue_add_device(vdev->viommu->iopf_pri, dev);
+		if (ret)
+			return ret;
+	} else {
+		/* No other way to handle io page fault then */
+		return -EINVAL;
+	}
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		iopf_queue_remove_device(vdev->viommu->iopf_pri, dev);
+
+	return ret;
+}
+
+static void viommu_endpoint_sva_disable_iopf(struct viommu_endpoint *vdev)
+{
+	struct device *dev = vdev->dev;
+
+	if (!vdev->iopf_enabled)
+		return;
+
+	iommu_unregister_device_fault_handler(dev);
+	iopf_queue_remove_device(vdev->viommu->iopf_pri, dev);
+}
+
+static int viommu_endpoint_enable_sva(struct viommu_endpoint *vdev)
+{
+	int ret;
+
+	mutex_lock(&sva_lock);
+	ret = viommu_endpoint_sva_enable_iopf(vdev);
+	if (!ret)
+		vdev->sva_enabled = true;
+	mutex_unlock(&sva_lock);
+
+	return ret;
+}
+
+static int viommu_endpoint_disable_sva(struct viommu_endpoint *vdev)
+{
+	mutex_lock(&sva_lock);
+	viommu_endpoint_sva_disable_iopf(vdev);
+	vdev->sva_enabled = false;
+	mutex_unlock(&sva_lock);
+
+	return 0;
+}
+
+int viommu_endpoint_enable_iopf(struct viommu_endpoint *vdev)
+{
+	int ret;
+
+	mutex_lock(&iopf_lock);
+	if (vdev->pri_supported) {
+		ret = viommu_enable_pri(vdev);
+		if (ret)
+			return ret;
+	}
+	vdev->iopf_enabled = true;
+	mutex_unlock(&iopf_lock);
+	return 0;
+}
+
+int viommu_endpoint_disable_iopf(struct viommu_endpoint *vdev)
+{
+	if (vdev->sva_enabled)
+		return -EBUSY;
+
+	mutex_lock(&iopf_lock);
+	viommu_disable_pri(vdev);
+	vdev->iopf_enabled = false;
+	mutex_unlock(&iopf_lock);
+	return 0;
+}
+
+static bool viommu_dev_has_feature(struct device *dev,
+				   enum iommu_dev_features feat)
+{
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	if (!vdev)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return viommu_endpoint_iopf_supported(vdev);
+	case IOMMU_DEV_FEAT_SVA:
+		return viommu_endpoint_sva_supported(vdev);
+	default:
+		return false;
+	}
+}
+
+static bool viommu_dev_feature_enabled(struct device *dev,
+				       enum iommu_dev_features feat)
+{
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	if (!vdev)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return vdev->iopf_enabled;
+	case IOMMU_DEV_FEAT_SVA:
+		return viommu_endpoint_sva_enabled(vdev);
+	default:
+		return false;
+	}
+}
+
+static int viommu_dev_enable_feature(struct device *dev,
+				     enum iommu_dev_features feat)
+{
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	if (!viommu_dev_has_feature(dev, feat))
+		return -ENODEV;
+
+	if (viommu_dev_feature_enabled(dev, feat))
+		return -EBUSY;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return viommu_endpoint_enable_iopf(vdev);
+	case IOMMU_DEV_FEAT_SVA:
+		return viommu_endpoint_enable_sva(vdev);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int viommu_dev_disable_feature(struct device *dev,
+				      enum iommu_dev_features feat)
+{
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+	if (!viommu_dev_feature_enabled(dev, feat))
+		return -EINVAL;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		return viommu_endpoint_disable_iopf(vdev);
+	case IOMMU_DEV_FEAT_SVA:
+		return viommu_endpoint_disable_sva(vdev);
+	default:
+		return -EINVAL;
+	}
+}
 static struct iommu_ops viommu_ops = {
 	.domain_alloc		= viommu_domain_alloc,
 	.domain_free		= viommu_domain_free,
@@ -1695,6 +1957,9 @@ static struct iommu_ops viommu_ops = {
 	.get_resv_regions	= viommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.of_xlate		= viommu_of_xlate,
+	.dev_feat_enabled	= viommu_dev_feature_enabled,
+	.dev_enable_feat	= viommu_dev_enable_feature,
+	.dev_disable_feat	= viommu_dev_disable_feature,
 };
 
 static int viommu_init_vqs(struct viommu_dev *viommu)
@@ -1811,6 +2076,8 @@ static int viommu_probe(struct virtio_device *vdev)
 		goto err_free_vqs;
 	}
 
+	viommu->has_sva = virtio_has_feature(vdev, VIRTIO_IOMMU_F_SVA);
+
 	viommu->geometry = (struct iommu_domain_geometry) {
 		.aperture_start	= input_start,
 		.aperture_end	= input_end,
@@ -1902,6 +2169,7 @@ static unsigned int features[] = {
 	VIRTIO_IOMMU_F_PROBE,
 	VIRTIO_IOMMU_F_MMIO,
 	VIRTIO_IOMMU_F_ATTACH_TABLE,
+	VIRTIO_IOMMU_F_SVA,
 };
 
 static struct virtio_device_id id_table[] = {
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 53aa88e6b077..88a3db493108 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -17,6 +17,7 @@
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
 #define VIRTIO_IOMMU_F_ATTACH_TABLE		6
+#define VIRTIO_IOMMU_F_SVA			7
 
 struct virtio_iommu_range_64 {
 	__le64					start;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
