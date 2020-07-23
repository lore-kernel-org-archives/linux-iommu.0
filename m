Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628CDC433F1
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 17:19:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413DF2071A
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 17:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413DF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2B86864D8;
	Thu, 23 Jul 2020 17:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHdyk1alWOuu; Thu, 23 Jul 2020 17:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CB0D8885D3;
	Thu, 23 Jul 2020 17:18:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B236BC0050;
	Thu, 23 Jul 2020 17:18:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 027EAC004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 17:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F15188850A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 17:18:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dKOzOrlvEv88 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 17:18:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0638C8881F
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 17:18:56 +0000 (UTC)
IronPort-SDR: 9DFmHzxCav0cHntgeKrdQ0qPO+qarHv4TxFq0C1LOaQERvH9YoED3okdFF9TpgatF2QV2dkspL
 8H3KgMQ3HmWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="151880962"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="151880962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 10:18:55 -0700
IronPort-SDR: 8ssdZmrgyUQZslE6gdIt9RKxi2biCkXCNV+naNyVJtk5qnBzjDZkDw9qV8iinQ46gnuyyKQpRP
 KDs5XGOUnI8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="462933858"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 23 Jul 2020 10:18:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v6 5/6] iommu/uapi: Handle data and argsz filled by users
Date: Thu, 23 Jul 2020 10:25:39 -0700
Message-Id: <1595525140-23899-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

IOMMU user APIs are responsible for processing user data. This patch
changes the interface such that user pointers can be passed into IOMMU
code directly. Separate kernel APIs without user pointers are introduced
for in-kernel users of the UAPI functionality.

IOMMU UAPI data has a user filled argsz field which indicates the data
length of the structure. User data is not trusted, argsz must be
validated based on the current kernel data size, mandatory data size,
and feature flags.

User data may also be extended, resulting in possible argsz increase.
Backward compatibility is ensured based on size and flags (or
the functional equivalent fields) checking.

This patch adds sanity checks in the IOMMU layer. In addition to argsz,
reserved/unused fields in padding, flags, and version are also checked.
Details are documented in Documentation/userspace-api/iommu.rst

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h |  28 ++++---
 2 files changed, 213 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3a913ce94a3d..1ce2a61058c6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1950,33 +1950,219 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+/*
+ * Check flags and other user provided data for valid combinations. We also
+ * make sure no reserved fields or unused flags are set. This is to ensure
+ * not breaking userspace in the future when these fields or flags are used.
+ */
+static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
+{
+	u32 mask;
+	int i;
+
+	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
+	if (info->cache & ~mask)
+		return -EINVAL;
+
+	if (info->granularity >= IOMMU_INV_GRANU_NR)
+		return -EINVAL;
+
+	switch (info->granularity) {
+	case IOMMU_INV_GRANU_ADDR:
+		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
+			return -EINVAL;
+
+		mask = IOMMU_INV_ADDR_FLAGS_PASID |
+			IOMMU_INV_ADDR_FLAGS_ARCHID |
+			IOMMU_INV_ADDR_FLAGS_LEAF;
+
+		if (info->granu.addr_info.flags & ~mask)
+			return -EINVAL;
+		break;
+	case IOMMU_INV_GRANU_PASID:
+		mask = IOMMU_INV_PASID_FLAGS_PASID |
+			IOMMU_INV_PASID_FLAGS_ARCHID;
+		if (info->granu.pasid_info.flags & ~mask)
+			return -EINVAL;
+
+		break;
+	case IOMMU_INV_GRANU_DOMAIN:
+		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check reserved padding fields */
+	for (i = 0; i < 6; i++) {
+		if (info->padding[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-				struct iommu_cache_invalidate_info *inv_info)
+				void __user *uinfo)
 {
+	struct iommu_cache_invalidate_info inv_info = { 0 };
+	u32 minsz;
+	int ret = 0;
+
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
-	return domain->ops->cache_invalidate(domain, dev, inv_info);
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_cache_invalidate_info, granu);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(&inv_info, uinfo, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (inv_info.argsz < minsz)
+		return -EINVAL;
+
+	/* PASID and address granu require additional info beyond minsz */
+	if (inv_info.argsz == minsz &&
+	    ((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
+		    (inv_info.granularity == IOMMU_INV_GRANU_ADDR)))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
+	    inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.pasid_info))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
+	    inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.addr_info))
+		return -EINVAL;
+
+	/*
+	 * User might be using a newer UAPI header which has a larger data
+	 * size, we shall support the existing flags within the current
+	 * size. Copy the remaining user data _after_ minsz but not more
+	 * than the current kernel supported size.
+	 */
+	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
+			   min(inv_info.argsz, (u32)sizeof(inv_info)) - minsz))
+		return -EFAULT;
+
+	/* Now the argsz is validated, check the content */
+	ret = iommu_check_cache_invl_data(&inv_info);
+	if (ret)
+		return ret;
+
+	return domain->ops->cache_invalidate(domain, dev, &inv_info);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-			       struct device *dev, struct iommu_gpasid_bind_data *data)
+static int iommu_check_bind_data(struct iommu_gpasid_bind_data *data)
+{
+	u32 mask;
+	int i;
+
+	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
+		return -EINVAL;
+
+	/* Check all supported format, for now just VT-d */
+	mask = IOMMU_PASID_FORMAT_INTEL_VTD;
+	if (data->format & ~mask)
+		return -EINVAL;
+
+	/* Check all flags */
+	mask = IOMMU_SVA_GPASID_VAL;
+	if (data->flags & ~mask)
+		return -EINVAL;
+
+	/* Check reserved padding fields */
+	for (i = 0; i < 8; i++) {
+		if (data->padding[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int iommu_sva_prepare_bind_data(void __user *udata,
+				       struct iommu_gpasid_bind_data *data)
 {
+	u32 minsz;
+
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(data, udata, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (data->argsz < minsz)
+		return -EINVAL;
+	/*
+	 * User might be using a newer UAPI header, we shall let IOMMU vendor
+	 * driver decide on what size it needs. Since the guest PASID bind data
+	 * can be vendor specific, larger argsz could be the result of extension
+	 * for one vendor but it should not affect another vendor.
+	 * Copy the remaining user data _after_ minsz
+	 */
+	if (copy_from_user((void *)data + minsz, udata + minsz,
+			   min(data->argsz, (u32)sizeof(*data)) - minsz))
+		return -EFAULT;
+
+	return iommu_check_bind_data(data);
+}
+
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+			       void __user *udata)
+{
+	struct iommu_gpasid_bind_data data = { 0 };
+	int ret;
+
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_bind_gpasid(domain, dev, data);
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return domain->ops->sva_bind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-				 ioasid_t pasid)
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			    struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_unbind_gpasid(dev, pasid);
+	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 void __user *udata)
+{
+	struct iommu_gpasid_bind_data data = { 0 };
+	int ret;
+
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return iommu_sva_unbind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2dcc1a33f6dc..4a02c9e09048 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -432,11 +432,14 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
 				       struct device *dev,
-				       struct iommu_cache_invalidate_info *inv_info);
+				       void __user *uinfo);
+
 extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-				      struct device *dev, struct iommu_gpasid_bind_data *data);
+				      struct device *dev, void __user *udata);
 extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-					struct device *dev, ioasid_t pasid);
+					struct device *dev, void __user *udata);
+extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				   struct device *dev, struct iommu_gpasid_bind_data *data);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1054,22 +1057,29 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
-					      struct device *dev,
-					      struct iommu_cache_invalidate_info *inv_info)
+static inline int
+iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+			    struct device *dev,
+			    struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-					     struct device *dev,
-					     struct iommu_gpasid_bind_data *data)
+					     struct device *dev, void __user *udata)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-					       struct device *dev, int pasid)
+					       struct device *dev, void __user *udata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+					  struct device *dev,
+					  struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
