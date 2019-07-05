Return-Path: <SRS0=qSbQ=VD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C7C0650E
	for <iommu@archiver.kernel.org>; Sat,  6 Jul 2019 11:27:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFD320989
	for <iommu@archiver.kernel.org>; Sat,  6 Jul 2019 11:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFD320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B3B951C47;
	Sat,  6 Jul 2019 11:27:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B0BE21C2F
	for <iommu@lists.linux-foundation.org>;
	Sat,  6 Jul 2019 11:23:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C60C87F
	for <iommu@lists.linux-foundation.org>;
	Sat,  6 Jul 2019 11:23:21 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jul 2019 04:23:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="158693792"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
	by orsmga008.jf.intel.com with ESMTP; 06 Jul 2019 04:23:18 -0700
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC v1 3/4] vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
Date: Fri,  5 Jul 2019 19:06:11 +0800
Message-Id: <1562324772-3084-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324772-3084-1-git-send-email-yi.l.liu@intel.com>
References: <1562324772-3084-1-git-send-email-yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
	jean-philippe.brucker@arm.com, iommu@lists.linux-foundation.org,
	yi.y.sun@intel.com, jun.j.tian@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Liu Yi L <yi.l.liu@intel.com>

This patch adds VFIO_IOMMU_PASID_REQUEST ioctl which aims
to passdown PASID allocation/free request from the virtual
iommu. This is required to get PASID managed in system-wide.

Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 125 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  25 ++++++++
 2 files changed, 150 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6fda4fb..d5e0c01 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1832,6 +1832,94 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
 	return iommu_cache_invalidate(dc->domain, dev, &ustruct->info);
 }
 
+static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
+					 int min_pasid,
+					 int max_pasid)
+{
+	int ret;
+	ioasid_t pasid;
+	struct mm_struct *mm = NULL;
+
+	mutex_lock(&iommu->lock);
+	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	mm = get_task_mm(current);
+	/* Jacob: track ioasid allocation owner by mm */
+	pasid = ioasid_alloc((struct ioasid_set *)mm, min_pasid,
+				max_pasid, NULL);
+	if (pasid == INVALID_IOASID) {
+		ret = -ENOSPC;
+		goto out_unlock;
+	}
+	ret = pasid;
+out_unlock:
+	mutex_unlock(&iommu->lock);
+	if (mm)
+		mmput(mm);
+	return ret;
+}
+
+static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu, int pasid)
+{
+	struct mm_struct *mm = NULL;
+	void *pdata;
+	int ret = 0;
+
+	mutex_lock(&iommu->lock);
+	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	pr_debug("%s: pasid: %d\n", __func__, pasid);
+
+	/**
+	 * TODO:
+	 * a) for pasid free, needs to return error if free failed
+	 * b) Sanity check: check if the pasid is allocated to the
+	 *                  current process such check may be in
+	 *                  vendor specific pasid_free callback or
+	 *                  in generic layer
+	 * c) clean up device list and free p_alloc structure
+	 *
+	 * Jacob:
+	 * There are two cases free could fail:
+	 * 1. free pasid by non-owner, we can use ioasid_set to track mm, if
+	 * the set does not match, caller is not permitted to free.
+	 * 2. free before unbind all devices, we can check if ioasid private
+	 * data, if data != NULL, then fail to free.
+	 */
+
+	mm = get_task_mm(current);
+	pdata = ioasid_find((struct ioasid_set *)mm, pasid, NULL);
+	if (IS_ERR(pdata)) {
+		if (pdata == ERR_PTR(-ENOENT))
+			pr_debug("pasid %d is not allocated\n", pasid);
+		else if (pdata == ERR_PTR(-EACCES))
+			pr_debug("Not owner of pasid %d,"
+				 "no pasid free allowed\n", pasid);
+		else
+			pr_debug("error happened during searching"
+				 " pasid: %d\n", pasid);
+		ret = -EPERM;
+		goto out_unlock;
+	}
+	if (pdata) {
+		pr_debug("Cannot free pasid %d with private data\n", pasid);
+		/* Expect PASID has no private data if not bond */
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	ioasid_free(pasid);
+
+out_unlock:
+	if (mm)
+		mmput(mm);
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static long vfio_iommu_type1_ioctl(void *iommu_data,
 				   unsigned int cmd, unsigned long arg)
 {
@@ -1936,6 +2024,43 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 					    &ustruct);
 		mutex_unlock(&iommu->lock);
 		return ret;
+
+	} else if (cmd == VFIO_IOMMU_PASID_REQUEST) {
+		struct vfio_iommu_type1_pasid_request req;
+		int min_pasid, max_pasid, pasid;
+
+		minsz = offsetofend(struct vfio_iommu_type1_pasid_request,
+				    flag);
+
+		if (copy_from_user(&req, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (req.argsz < minsz)
+			return -EINVAL;
+
+		switch (req.flag) {
+		/**
+		 * TODO: min_pasid and max_pasid align with
+		 * typedef unsigned int ioasid_t
+		 */
+		case VFIO_IOMMU_PASID_ALLOC:
+			if (copy_from_user(&min_pasid,
+				(void __user *)arg + minsz, sizeof(min_pasid)))
+				return -EFAULT;
+			if (copy_from_user(&max_pasid,
+				(void __user *)arg + minsz + sizeof(min_pasid),
+				sizeof(max_pasid)))
+				return -EFAULT;
+			return vfio_iommu_type1_pasid_alloc(iommu,
+						min_pasid, max_pasid);
+		case VFIO_IOMMU_PASID_FREE:
+			if (copy_from_user(&pasid,
+				(void __user *)arg + minsz, sizeof(pasid)))
+				return -EFAULT;
+			return vfio_iommu_type1_pasid_free(iommu, pasid);
+		default:
+			return -EINVAL;
+		}
 	}
 
 	return -ENOTTY;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 055aa9b..af03c9f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -798,6 +798,31 @@ struct vfio_iommu_type1_cache_invalidate {
 };
 #define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)
 
+/*
+ * @flag=VFIO_IOMMU_PASID_ALLOC, refer to the @min_pasid and @max_pasid fields
+ * @flag=VFIO_IOMMU_PASID_FREE, refer to @pasid field
+ */
+struct vfio_iommu_type1_pasid_request {
+	__u32	argsz;
+#define VFIO_IOMMU_PASID_ALLOC	(1 << 0)
+#define VFIO_IOMMU_PASID_FREE	(1 << 1)
+	__u32	flag;
+	union {
+		struct {
+			int min_pasid;
+			int max_pasid;
+		};
+		int pasid;
+	};
+};
+
+/**
+ * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 27,
+ *				struct vfio_iommu_type1_pasid_request)
+ *
+ */
+#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 27)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
