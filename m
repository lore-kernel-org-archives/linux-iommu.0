Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566DCC433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E95A60F51
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E95A60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1339B404FB;
	Sun, 19 Sep 2021 06:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tLzWIsWRKrG; Sun, 19 Sep 2021 06:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BC8E9404FC;
	Sun, 19 Sep 2021 06:42:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 978FEC0011;
	Sun, 19 Sep 2021 06:42:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB660C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 99A1C401B1
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMKssHeFKG2v for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A1284018F
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="245397270"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="245397270"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702041"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:42:38 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Date: Sun, 19 Sep 2021 14:38:39 +0800
Message-Id: <20210919063848.1476776-12-yi.l.liu@intel.com>
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

This patch adds IOASID allocation/free interface per iommufd. When
allocating an IOASID, userspace is expected to specify the type and
format information for the target I/O page table.

This RFC supports only one type (IOMMU_IOASID_TYPE_KERNEL_TYPE1V2),
implying a kernel-managed I/O page table with vfio type1v2 mapping
semantics. For this type the user should specify the addr_width of
the I/O address space and whether the I/O page table is created in
an iommu enfore_snoop format. enforce_snoop must be true at this point,
as the false setting requires additional contract with KVM on handling
WBINVD emulation, which can be added later.

Userspace is expected to call IOMMU_CHECK_EXTENSION (see next patch)
for what formats can be specified when allocating an IOASID.

Open:
- Devices on PPC platform currently use a different iommu driver in vfio.
  Per previous discussion they can also use vfio type1v2 as long as there
  is a way to claim a specific iova range from a system-wide address space.
  This requirement doesn't sound PPC specific, as addr_width for pci devices
  can be also represented by a range [0, 2^addr_width-1]. This RFC hasn't
  adopted this design yet. We hope to have formal alignment in v1 discussion
  and then decide how to incorporate it in v2.

- Currently ioasid term has already been used in the kernel (drivers/iommu/
  ioasid.c) to represent the hardware I/O address space ID in the wire. It
  covers both PCI PASID (Process Address Space ID) and ARM SSID (Sub-Stream
  ID). We need find a way to resolve the naming conflict between the hardware
  ID and software handle. One option is to rename the existing ioasid to be
  pasid or ssid, given their full names still sound generic. Appreciate more
  thoughts on this open!

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd.c | 120 ++++++++++++++++++++++++++++++++
 include/linux/iommufd.h         |   3 +
 include/uapi/linux/iommu.h      |  54 ++++++++++++++
 3 files changed, 177 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd.c b/drivers/iommu/iommufd/iommufd.c
index 641f199f2d41..4839f128b24a 100644
--- a/drivers/iommu/iommufd/iommufd.c
+++ b/drivers/iommu/iommufd/iommufd.c
@@ -24,6 +24,7 @@
 struct iommufd_ctx {
 	refcount_t refs;
 	struct mutex lock;
+	struct xarray ioasid_xa; /* xarray of ioasids */
 	struct xarray device_xa; /* xarray of bound devices */
 };
 
@@ -42,6 +43,16 @@ struct iommufd_device {
 	u64 dev_cookie;
 };
 
+/* Represent an I/O address space */
+struct iommufd_ioas {
+	int ioasid;
+	u32 type;
+	u32 addr_width;
+	bool enforce_snoop;
+	struct iommufd_ctx *ictx;
+	refcount_t refs;
+};
+
 static int iommufd_fops_open(struct inode *inode, struct file *filep)
 {
 	struct iommufd_ctx *ictx;
@@ -53,6 +64,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filep)
 
 	refcount_set(&ictx->refs, 1);
 	mutex_init(&ictx->lock);
+	xa_init_flags(&ictx->ioasid_xa, XA_FLAGS_ALLOC);
 	xa_init_flags(&ictx->device_xa, XA_FLAGS_ALLOC);
 	filep->private_data = ictx;
 
@@ -102,16 +114,118 @@ static void iommufd_ctx_put(struct iommufd_ctx *ictx)
 	if (!refcount_dec_and_test(&ictx->refs))
 		return;
 
+	WARN_ON(!xa_empty(&ictx->ioasid_xa));
 	WARN_ON(!xa_empty(&ictx->device_xa));
 	kfree(ictx);
 }
 
+/* Caller should hold ictx->lock */
+static void ioas_put_locked(struct iommufd_ioas *ioas)
+{
+	struct iommufd_ctx *ictx = ioas->ictx;
+	int ioasid = ioas->ioasid;
+
+	if (!refcount_dec_and_test(&ioas->refs))
+		return;
+
+	xa_erase(&ictx->ioasid_xa, ioasid);
+	iommufd_ctx_put(ictx);
+	kfree(ioas);
+}
+
+static int iommufd_ioasid_alloc(struct iommufd_ctx *ictx, unsigned long arg)
+{
+	struct iommu_ioasid_alloc req;
+	struct iommufd_ioas *ioas;
+	unsigned long minsz;
+	int ioasid, ret;
+
+	minsz = offsetofend(struct iommu_ioasid_alloc, addr_width);
+
+	if (copy_from_user(&req, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (req.argsz < minsz || !req.addr_width ||
+	    req.flags != IOMMU_IOASID_ENFORCE_SNOOP ||
+	    req.type != IOMMU_IOASID_TYPE_KERNEL_TYPE1V2)
+		return -EINVAL;
+
+	ioas = kzalloc(sizeof(*ioas), GFP_KERNEL);
+	if (!ioas)
+		return -ENOMEM;
+
+	mutex_lock(&ictx->lock);
+	ret = xa_alloc(&ictx->ioasid_xa, &ioasid, ioas,
+		       XA_LIMIT(IOMMUFD_IOASID_MIN, IOMMUFD_IOASID_MAX),
+		       GFP_KERNEL);
+	mutex_unlock(&ictx->lock);
+	if (ret) {
+		pr_err_ratelimited("Failed to alloc ioasid\n");
+		kfree(ioas);
+		return ret;
+	}
+
+	ioas->ioasid = ioasid;
+
+	/* only supports kernel managed I/O page table so far */
+	ioas->type = IOMMU_IOASID_TYPE_KERNEL_TYPE1V2;
+
+	ioas->addr_width = req.addr_width;
+
+	/* only supports enforce snoop today */
+	ioas->enforce_snoop = true;
+
+	iommufd_ctx_get(ictx);
+	ioas->ictx = ictx;
+
+	refcount_set(&ioas->refs, 1);
+
+	return ioasid;
+}
+
+static int iommufd_ioasid_free(struct iommufd_ctx *ictx, unsigned long arg)
+{
+	struct iommufd_ioas *ioas = NULL;
+	int ioasid, ret;
+
+	if (copy_from_user(&ioasid, (void __user *)arg, sizeof(ioasid)))
+		return -EFAULT;
+
+	if (ioasid < 0)
+		return -EINVAL;
+
+	mutex_lock(&ictx->lock);
+	ioas = xa_load(&ictx->ioasid_xa, ioasid);
+	if (IS_ERR(ioas)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* Disallow free if refcount is not 1 */
+	if (refcount_read(&ioas->refs) > 1) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	ioas_put_locked(ioas);
+out_unlock:
+	mutex_unlock(&ictx->lock);
+	return ret;
+};
+
 static int iommufd_fops_release(struct inode *inode, struct file *filep)
 {
 	struct iommufd_ctx *ictx = filep->private_data;
+	struct iommufd_ioas *ioas;
+	unsigned long index;
 
 	filep->private_data = NULL;
 
+	mutex_lock(&ictx->lock);
+	xa_for_each(&ictx->ioasid_xa, index, ioas)
+		ioas_put_locked(ioas);
+	mutex_unlock(&ictx->lock);
+
 	iommufd_ctx_put(ictx);
 
 	return 0;
@@ -195,6 +309,12 @@ static long iommufd_fops_unl_ioctl(struct file *filep,
 	case IOMMU_DEVICE_GET_INFO:
 		ret = iommufd_get_device_info(ictx, arg);
 		break;
+	case IOMMU_IOASID_ALLOC:
+		ret = iommufd_ioasid_alloc(ictx, arg);
+		break;
+	case IOMMU_IOASID_FREE:
+		ret = iommufd_ioasid_free(ictx, arg);
+		break;
 	default:
 		pr_err_ratelimited("unsupported cmd %u\n", cmd);
 		break;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 1603a13937e9..1dd6515e7816 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/device.h>
 
+#define IOMMUFD_IOASID_MAX	((unsigned int)(0x7FFFFFFF))
+#define IOMMUFD_IOASID_MIN	0
+
 #define IOMMUFD_DEVID_MAX	((unsigned int)(0x7FFFFFFF))
 #define IOMMUFD_DEVID_MIN	0
 
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 76b71f9d6b34..5cbd300eb0ee 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -57,6 +57,60 @@ struct iommu_device_info {
 
 #define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE + 1)
 
+/*
+ * IOMMU_IOASID_ALLOC	- _IOWR(IOMMU_TYPE, IOMMU_BASE + 2,
+ *				struct iommu_ioasid_alloc)
+ *
+ * Allocate an IOASID.
+ *
+ * IOASID is the FD-local software handle representing an I/O address
+ * space. Each IOASID is associated with a single I/O page table. User
+ * must call this ioctl to get an IOASID for every I/O address space
+ * that is intended to be tracked by the kernel.
+ *
+ * User needs to specify the attributes of the IOASID and associated
+ * I/O page table format information according to one or multiple devices
+ * which will be attached to this IOASID right after. The I/O page table
+ * is activated in the IOMMU when it's attached by a device. Incompatible
+ * format between device and IOASID will lead to attaching failure in
+ * device side.
+ *
+ * Currently only one flag (IOMMU_IOASID_ENFORCE_SNOOP) is supported and
+ * must be always set.
+ *
+ * Only one I/O page table type (kernel-managed) is supported, with vfio
+ * type1v2 mapping semantics.
+ *
+ * User should call IOMMU_CHECK_EXTENSION for future extensions.
+ *
+ * @argsz:	    user filled size of this data.
+ * @flags:	    additional information for IOASID allocation.
+ * @type:	    I/O address space page table type.
+ * @addr_width:    address width of the I/O address space.
+ *
+ * Return: allocated ioasid on success, -errno on failure.
+ */
+struct iommu_ioasid_alloc {
+	__u32	argsz;
+	__u32	flags;
+#define IOMMU_IOASID_ENFORCE_SNOOP	(1 << 0)
+	__u32	type;
+#define IOMMU_IOASID_TYPE_KERNEL_TYPE1V2	1
+	__u32	addr_width;
+};
+
+#define IOMMU_IOASID_ALLOC		_IO(IOMMU_TYPE, IOMMU_BASE + 2)
+
+/**
+ * IOMMU_IOASID_FREE - _IOWR(IOMMU_TYPE, IOMMU_BASE + 3, int)
+ *
+ * Free an IOASID.
+ *
+ * returns: 0 on success, -errno on failure
+ */
+
+#define IOMMU_IOASID_FREE		_IO(IOMMU_TYPE, IOMMU_BASE + 3)
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
