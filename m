Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916C7C433FE
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560B661051
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 560B661051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36207401BA;
	Sun, 19 Sep 2021 06:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4P9xpq9OVQo; Sun, 19 Sep 2021 06:43:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9227401B1;
	Sun, 19 Sep 2021 06:43:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3EB1C0011;
	Sun, 19 Sep 2021 06:43:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74E30C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 653CD83A7E
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FJm3m6wfIHvo for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:43:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 878DD837AC
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="210232727"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="210232727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702155"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:43:18 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 17/20] iommu/iommufd: Report iova range to userspace
Date: Sun, 19 Sep 2021 14:38:45 +0800
Message-Id: <20210919063848.1476776-18-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
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

[HACK. will fix in v2]

IOVA range is critical info for userspace to manage DMA for an I/O address
space. This patch reports the valid iova range info of a given device.

Due to aforementioned hack, this info comes from the hacked vfio type1
driver. To follow the same format in vfio, we also introduce a cap chain
format in IOMMU_DEVICE_GET_INFO to carry the iova range info.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c           |  2 ++
 drivers/iommu/iommufd/iommufd.c | 41 +++++++++++++++++++++++++++-
 drivers/vfio/vfio_iommu_type1.c | 47 ++++++++++++++++++++++++++++++---
 include/linux/vfio.h            |  2 ++
 include/uapi/linux/iommu.h      |  3 +++
 5 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b6178997aef1..44bba346ab52 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2755,6 +2755,7 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
@@ -2763,6 +2764,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 	if (ops && ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_put_resv_regions);
 
 /**
  * generic_iommu_put_resv_regions - Reserved region driver helper
diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
index 25373a0e037a..cbf5e30062a6 100644
--- a/drivers/iommu/iommufd/iommufd.c
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -19,6 +19,7 @@
 #include <linux/iommufd.h>
 #include <linux/xarray.h>
 #include <asm-generic/bug.h>
+#include <linux/vfio.h>
 
 /* Per iommufd */
 struct iommufd_ctx {
@@ -298,6 +299,38 @@ iommu_find_device_from_cookie(struct iommufd_ctx *ictx, u64 dev_cookie)
 	return dev;
 }
 
+static int iommu_device_add_cap_chain(struct device *dev, unsigned long arg,
+				      struct iommu_device_info *info)
+{
+	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
+	int ret;
+
+	ret = vfio_device_add_iova_cap(dev, &caps);
+	if (ret)
+		return ret;
+
+	if (caps.size) {
+		info->flags |= IOMMU_DEVICE_INFO_CAPS;
+
+		if (info->argsz < sizeof(*info) + caps.size) {
+			info->argsz = sizeof(*info) + caps.size;
+		} else {
+			vfio_info_cap_shift(&caps, sizeof(*info));
+			if (copy_to_user((void __user *)arg +
+					sizeof(*info), caps.buf,
+					caps.size)) {
+				kfree(caps.buf);
+				info->flags &= ~IOMMU_DEVICE_INFO_CAPS;
+				return -EFAULT;
+			}
+			info->cap_offset = sizeof(*info);
+		}
+
+		kfree(caps.buf);
+	}
+	return 0;
+}
+
 static void iommu_device_build_info(struct device *dev,
 				    struct iommu_device_info *info)
 {
@@ -324,8 +357,9 @@ static int iommufd_get_device_info(struct iommufd_ctx *ictx,
 	struct iommu_device_info info;
 	unsigned long minsz;
 	struct device *dev;
+	int ret;
 
-	minsz = offsetofend(struct iommu_device_info, addr_width);
+	minsz = offsetofend(struct iommu_device_info, cap_offset);
 
 	if (copy_from_user(&info, (void __user *)arg, minsz))
 		return -EFAULT;
@@ -341,6 +375,11 @@ static int iommufd_get_device_info(struct iommufd_ctx *ictx,
 
 	iommu_device_build_info(dev, &info);
 
+	info.cap_offset = 0;
+	ret = iommu_device_add_cap_chain(dev, arg, &info);
+	if (ret)
+		pr_info_ratelimited("No cap chain added, error %d\n", ret);
+
 	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 }
 
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c1c6bc803d94..28c1699aed6b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2963,15 +2963,15 @@ static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
 	return 0;
 }
 
-static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
-				      struct vfio_info_cap *caps)
+static int vfio_iova_list_build_caps(struct list_head *iova_list,
+				     struct vfio_info_cap *caps)
 {
 	struct vfio_iommu_type1_info_cap_iova_range *cap_iovas;
 	struct vfio_iova *iova;
 	size_t size;
 	int iovas = 0, i = 0, ret;
 
-	list_for_each_entry(iova, &iommu->iova_list, list)
+	list_for_each_entry(iova, iova_list, list)
 		iovas++;
 
 	if (!iovas) {
@@ -2990,7 +2990,7 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 
 	cap_iovas->nr_iovas = iovas;
 
-	list_for_each_entry(iova, &iommu->iova_list, list) {
+	list_for_each_entry(iova, iova_list, list) {
 		cap_iovas->iova_ranges[i].start = iova->start;
 		cap_iovas->iova_ranges[i].end = iova->end;
 		i++;
@@ -3002,6 +3002,45 @@ static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
+				      struct vfio_info_cap *caps)
+{
+	return vfio_iova_list_build_caps(&iommu->iova_list, caps);
+}
+
+/* HACK: called by /dev/iommu core to build iova range cap for a device */
+int vfio_device_add_iova_cap(struct device *dev, struct vfio_info_cap *caps)
+{
+	u64 awidth;
+	dma_addr_t aperture_end;
+	LIST_HEAD(iova);
+	LIST_HEAD(dev_resv_regions);
+	int ret;
+
+	ret = iommu_device_get_info(dev, IOMMU_DEV_INFO_ADDR_WIDTH, &awidth);
+	if (ret)
+		return ret;
+
+	/* FIXME: needs to use geometry info reported by iommu core. */
+	aperture_end = ((dma_addr_t)1) << awidth;
+
+	ret = vfio_iommu_iova_insert(&iova, 0, aperture_end);
+	if (ret)
+		return ret;
+
+	iommu_get_resv_regions(dev, &dev_resv_regions);
+	ret = vfio_iommu_resv_exclude(&iova, &dev_resv_regions);
+	if (ret)
+		goto out;
+
+	ret = vfio_iova_list_build_caps(&iova, caps);
+out:
+	vfio_iommu_iova_free(&iova);
+	iommu_put_resv_regions(dev, &dev_resv_regions);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_device_add_iova_cap);
+
 static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
 					   struct vfio_info_cap *caps)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index d904ee5a68cc..605b8e828be4 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -212,6 +212,8 @@ extern int vfio_info_add_capability(struct vfio_info_cap *caps,
 extern int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
 					      int num_irqs, int max_irq_type,
 					      size_t *data_size);
+extern int vfio_device_add_iova_cap(struct device *dev,
+				    struct vfio_info_cap *caps);
 
 struct pci_dev;
 #if IS_ENABLED(CONFIG_VFIO_SPAPR_EEH)
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 49731be71213..f408ad3c8ade 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -68,6 +68,7 @@
  *		   +---------------+------------+
  *		   ...
  * @addr_width:    the address width of supported I/O address spaces.
+ * @cap_offset:	   Offset within info struct of first cap
  *
  * Availability: after device is bound to iommufd
  */
@@ -77,9 +78,11 @@ struct iommu_device_info {
 #define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU enforced snoop */
 #define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page sizes */
 #define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /* addr_wdith field valid */
+#define IOMMU_DEVICE_INFO_CAPS		(1 << 3) /* info supports cap chain */
 	__u64	dev_cookie;
 	__u64   pgsize_bitmap;
 	__u32	addr_width;
+	__u32   cap_offset;
 };
 
 #define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE + 1)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
