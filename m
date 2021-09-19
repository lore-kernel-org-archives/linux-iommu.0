Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC219C433FE
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870DB61353
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 870DB61353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6192C60648;
	Sun, 19 Sep 2021 06:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXUYQ-a4jI8C; Sun, 19 Sep 2021 06:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1161B606C2;
	Sun, 19 Sep 2021 06:43:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED226C0011;
	Sun, 19 Sep 2021 06:43:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82584C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6543C401BA
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NmiOhH-fWHk3 for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:43:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A55964024F
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="245397374"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="245397374"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702171"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:43:25 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 18/20] iommu/iommufd: Add IOMMU_[UN]MAP_DMA on IOASID
Date: Sun, 19 Sep 2021 14:38:46 +0800
Message-Id: <20210919063848.1476776-19-yi.l.liu@intel.com>
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

This patch introduces vfio type1v2-equivalent interface to userspace. Due
to aforementioned hack, iommufd currently calls exported vfio symbols to
handle map/unmap requests from the user.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd.c | 104 ++++++++++++++++++++++++++++++++
 include/uapi/linux/iommu.h      |  29 +++++++++
 2 files changed, 133 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
index cbf5e30062a6..f5f2274d658c 100644
--- a/drivers/iommu/iommufd/iommufd.c
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -55,6 +55,7 @@ struct iommufd_ioas {
 	struct mutex lock;
 	struct list_head device_list;
 	struct iommu_domain *domain;
+	struct vfio_iommu *vfio_iommu; /* FIXME: added for reusing vfio_iommu_type1 code */
 };
 
 /*
@@ -158,6 +159,7 @@ static void ioas_put_locked(struct iommufd_ioas *ioas)
 		return;
 
 	WARN_ON(!list_empty(&ioas->device_list));
+	vfio_iommu_type1_release(ioas->vfio_iommu); /* FIXME: reused vfio code */
 	xa_erase(&ictx->ioasid_xa, ioasid);
 	iommufd_ctx_put(ictx);
 	kfree(ioas);
@@ -185,6 +187,7 @@ static int iommufd_ioasid_alloc(struct iommufd_ctx *ictx, unsigned long arg)
 	struct iommufd_ioas *ioas;
 	unsigned long minsz;
 	int ioasid, ret;
+	struct vfio_iommu *vfio_iommu;
 
 	minsz = offsetofend(struct iommu_ioasid_alloc, addr_width);
 
@@ -211,6 +214,18 @@ static int iommufd_ioasid_alloc(struct iommufd_ctx *ictx, unsigned long arg)
 		return ret;
 	}
 
+	/* FIXME: get a vfio_iommu object for dma map/unmap management */
+	vfio_iommu = vfio_iommu_type1_open(VFIO_TYPE1v2_IOMMU);
+	if (IS_ERR(vfio_iommu)) {
+		pr_err_ratelimited("Failed to get vfio_iommu object\n");
+		mutex_lock(&ictx->lock);
+		xa_erase(&ictx->ioasid_xa, ioasid);
+		mutex_unlock(&ictx->lock);
+		kfree(ioas);
+		return PTR_ERR(vfio_iommu);
+	}
+	ioas->vfio_iommu = vfio_iommu;
+
 	ioas->ioasid = ioasid;
 
 	/* only supports kernel managed I/O page table so far */
@@ -383,6 +398,49 @@ static int iommufd_get_device_info(struct iommufd_ctx *ictx,
 	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
 }
 
+static int iommufd_process_dma_op(struct iommufd_ctx *ictx,
+				  unsigned long arg, bool map)
+{
+	struct iommu_ioasid_dma_op dma;
+	unsigned long minsz;
+	struct iommufd_ioas *ioas = NULL;
+	int ret;
+
+	minsz = offsetofend(struct iommu_ioasid_dma_op, padding);
+
+	if (copy_from_user(&dma, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (dma.argsz < minsz || dma.flags || dma.ioasid < 0)
+		return -EINVAL;
+
+	ioas = ioasid_get_ioas(ictx, dma.ioasid);
+	if (!ioas) {
+		pr_err_ratelimited("unkonwn IOASID %u\n", dma.ioasid);
+		return -EINVAL;
+	}
+
+	mutex_lock(&ioas->lock);
+
+	/*
+	 * Needs to block map/unmap request from userspace before IOASID
+	 * is attached to any device.
+	 */
+	if (list_empty(&ioas->device_list)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (map)
+		ret = vfio_iommu_type1_map_dma(ioas->vfio_iommu, arg + minsz);
+	else
+		ret = vfio_iommu_type1_unmap_dma(ioas->vfio_iommu, arg + minsz);
+out:
+	mutex_unlock(&ioas->lock);
+	ioas_put(ioas);
+	return ret;
+};
+
 static long iommufd_fops_unl_ioctl(struct file *filep,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -409,6 +467,12 @@ static long iommufd_fops_unl_ioctl(struct file *filep,
 	case IOMMU_IOASID_FREE:
 		ret = iommufd_ioasid_free(ictx, arg);
 		break;
+	case IOMMU_MAP_DMA:
+		ret = iommufd_process_dma_op(ictx, arg, true);
+		break;
+	case IOMMU_UNMAP_DMA:
+		ret = iommufd_process_dma_op(ictx, arg, false);
+		break;
 	default:
 		pr_err_ratelimited("unsupported cmd %u\n", cmd);
 		break;
@@ -478,6 +542,39 @@ static int ioas_check_device_compatibility(struct iommufd_ioas *ioas,
 	return 0;
 }
 
+/* HACK:
+ * vfio_iommu_add/remove_device() is hacky implementation for
+ * this version to add the device/group to vfio iommu type1.
+ */
+static int vfio_iommu_add_device(struct vfio_iommu *vfio_iommu,
+				 struct device *dev,
+				 struct iommu_domain *domain)
+{
+	struct iommu_group *group;
+	int ret;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -EINVAL;
+
+	ret = vfio_iommu_add_group(vfio_iommu, group, domain);
+	iommu_group_put(group);
+	return ret;
+}
+
+static void vfio_iommu_remove_device(struct vfio_iommu *vfio_iommu,
+				     struct device *dev)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return;
+
+	vfio_iommu_remove_group(vfio_iommu, group);
+	iommu_group_put(group);
+}
+
 /**
  * iommufd_device_attach_ioasid - attach device to an ioasid
  * @idev: [in] Pointer to struct iommufd_device.
@@ -539,11 +636,17 @@ int iommufd_device_attach_ioasid(struct iommufd_device *idev, int ioasid)
 	if (ret)
 		goto out_domain;
 
+	ret = vfio_iommu_add_device(ioas->vfio_iommu, idev->dev, domain);
+	if (ret)
+		goto out_detach;
+
 	ioas_dev->idev = idev;
 	list_add(&ioas_dev->next, &ioas->device_list);
 	mutex_unlock(&ioas->lock);
 
 	return 0;
+out_detach:
+	iommu_detach_device(domain, idev->dev);
 out_domain:
 	ioas_free_domain_if_empty(ioas);
 out_free:
@@ -579,6 +682,7 @@ void iommufd_device_detach_ioasid(struct iommufd_device *idev, int ioasid)
 	}
 
 	list_del(&ioas_dev->next);
+	vfio_iommu_remove_device(ioas->vfio_iommu, idev->dev);
 	iommu_detach_device(ioas->domain, idev->dev);
 	ioas_free_domain_if_empty(ioas);
 	kfree(ioas_dev);
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index f408ad3c8ade..fe815cc1f665 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -141,6 +141,35 @@ struct iommu_ioasid_alloc {
 
 #define IOMMU_IOASID_FREE		_IO(IOMMU_TYPE, IOMMU_BASE + 3)
 
+/*
+ * Map/unmap process virtual addresses to I/O virtual addresses.
+ *
+ * Provide VFIO type1 equivalent semantics. Start with the same
+ * restriction e.g. the unmap size should match those used in the
+ * original mapping call.
+ *
+ * @argsz:	user filled size of this data.
+ * @flags:	reserved for future extension.
+ * @ioasid:	the handle of target I/O address space.
+ * @data:	the operation payload, refer to vfio_iommu_type1_dma_{un}map.
+ *
+ * FIXME:
+ *	userspace needs to include uapi/vfio.h as well as interface reuses
+ *	the map/unmap logic from vfio iommu type1.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct iommu_ioasid_dma_op {
+	__u32	argsz;
+	__u32	flags;
+	__s32	ioasid;
+	__u32	padding;
+	__u8	data[];
+};
+
+#define IOMMU_MAP_DMA	_IO(IOMMU_TYPE, IOMMU_BASE + 4)
+#define IOMMU_UNMAP_DMA	_IO(IOMMU_TYPE, IOMMU_BASE + 5)
+
 #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
 #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
 #define IOMMU_FAULT_PERM_EXEC	(1 << 2) /* exec */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
