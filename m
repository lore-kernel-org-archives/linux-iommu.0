Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD69C433E4
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 23:37:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3AB20773
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 23:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3AB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4D71885932;
	Tue,  7 Jul 2020 23:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQidMOgk25t7; Tue,  7 Jul 2020 23:37:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04E0B85FB6;
	Tue,  7 Jul 2020 23:37:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E58ADC08A5;
	Tue,  7 Jul 2020 23:37:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAB3EC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 23:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A6928894D3
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 23:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lpmqisSNSSHc for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 23:37:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B66FD894D9
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 23:37:19 +0000 (UTC)
IronPort-SDR: jorXEe3j/G0PPCqSD0SXGRxvRQLNkSMgvn2KxQrnWjZsXU+ZxNK36eBbjaGhM9ImGGO/27ebz+
 X/+junWwT9Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135949001"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="135949001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 16:37:13 -0700
IronPort-SDR: KIjvJ/1xAlC7SHlR//qEoNmZs0Ldh4/Si7p5jMmsf8zAdyboXyFrI4t0JpkaTq0bsO2MGiKZ9j
 ZKWbaXuz1IzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="323693920"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 07 Jul 2020 16:37:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v4 4/5] iommu/uapi: Handle data and argsz filled by users
Date: Tue,  7 Jul 2020 16:43:48 -0700
Message-Id: <1594165429-20075-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

IOMMU UAPI data has a user filled argsz field which indicates the data
length comes with the API call. User data is not trusted, argsz must be
validated based on the current kernel data size, mandatory data size,
and feature flags.

User data may also be extended, results in possible argsz increase.
Backward compatibility is ensured based on size and flags checking.

This patch adds sanity checks in the IOMMU layer. In addition to argsz,
reserved/unused fields in padding, flags, and version are also checked.
Details are documented in Documentation/userspace-api/iommu.rst

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h |   9 ++-
 2 files changed, 206 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d43120eb1dc5..7910249f5dd7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1950,33 +1950,225 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+/*
+ * Check flags and other user privided data for valid combinations. We also
+ * make sure no reserved fields or unused flags are not set. This is to ensure
+ * not breaking userspace in the future when these fields or flags are used.
+ */
+static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
+{
+	int ret = 0;
+	u32 mask;
+
+	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	mask =  IOMMU_CACHE_INV_TYPE_IOTLB |
+		IOMMU_CACHE_INV_TYPE_DEV_IOTLB |
+		IOMMU_CACHE_INV_TYPE_PASID;
+	if (info->cache & ~mask) {
+		pr_warn_ratelimited("Invalid cache types %x\n", info->cache);
+		return -EINVAL;
+	}
+
+	if (info->granularity >= IOMMU_INV_GRANU_NR) {
+		pr_warn_ratelimited("Invalid cache invalidation granu %x\n",
+				info->granularity);
+		return -EINVAL;
+	}
+
+	switch (info->granularity) {
+	case IOMMU_INV_GRANU_ADDR:
+		mask = IOMMU_INV_ADDR_FLAGS_PASID |
+			IOMMU_INV_ADDR_FLAGS_ARCHID |
+			IOMMU_INV_ADDR_FLAGS_LEAF;
+
+		if (info->granu.addr_info.flags & ~mask) {
+			pr_warn_ratelimited("Unsupported invalidation addr flags %x\n",
+					info->granu.addr_info.flags);
+			ret = -EINVAL;
+		}
+		break;
+	case IOMMU_INV_GRANU_PASID:
+		mask = IOMMU_INV_PASID_FLAGS_PASID |
+			IOMMU_INV_PASID_FLAGS_ARCHID;
+		if (info->granu.pasid_info.flags & ~mask) {
+			pr_warn_ratelimited("Unsupported invalidation PASID flags%x\n",
+					info->granu.pasid_info.flags);
+			ret = -EINVAL;
+		}
+		break;
+	}
+
+	if (info->padding[0] || info->padding[1]) {
+		pr_warn_ratelimited("Non-zero reserved fields\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-			   struct iommu_cache_invalidate_info *inv_info)
+			   void __user *uinfo)
 {
+	struct iommu_cache_invalidate_info inv_info;
+	unsigned long minsz, maxsz;
+	int ret = 0;
+
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
-	return domain->ops->cache_invalidate(domain, dev, inv_info);
+	/* Current kernel data size is the max to be copied from user */
+	maxsz = sizeof(struct iommu_cache_invalidate_info);
+	memset((void *)&inv_info, 0, maxsz);
+
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
+	/*
+	 * User might be using a newer UAPI header which has a larger data
+	 * size, we shall support the existing flags within the current
+	 * size.
+	 */
+	if (inv_info.argsz > maxsz)
+		inv_info.argsz = maxsz;
+
+	/* Copy the remaining user data _after_ minsz */
+	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
+				inv_info.argsz - minsz))
+		return -EFAULT;
+
+	/* Now the argsz is validated, check the content */
+	ret = iommu_check_cache_invl_data(&inv_info);
+	if (ret)
+		return ret;
+
+	return domain->ops->cache_invalidate(domain, dev, &inv_info);
 }
 EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-			   struct device *dev, struct iommu_gpasid_bind_data *data)
+
+static int iommu_check_bind_data(struct iommu_gpasid_bind_data *data)
 {
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
+	for (i = 0; i < 12; i++) {
+		if (data->padding[i]) {
+			pr_warn_ratelimited("Non-zero reserved field\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int iommu_sva_prepare_bind_data(void __user *udata,
+				       struct iommu_gpasid_bind_data *data)
+{
+	unsigned long minsz, maxsz;
+
+	/* Current kernel data size is the max to be copied from user */
+	maxsz = sizeof(struct iommu_gpasid_bind_data);
+	memset((void *)data, 0, maxsz);
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
+	 */
+	if (data->argsz > maxsz)
+		data->argsz = maxsz;
+
+	/* Copy the remaining user data _after_ minsz */
+	if (copy_from_user((void *)data + minsz, udata + minsz,
+				data->argsz - minsz))
+		return -EFAULT;
+
+	return iommu_check_bind_data(data);
+}
+
+int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+						void __user *udata)
+{
+
+	struct iommu_gpasid_bind_data data;
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
 EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
 
-int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-			     ioasid_t pasid)
+int __iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_unbind_gpasid(dev, pasid);
+	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
+}
+EXPORT_SYMBOL_GPL(__iommu_sva_unbind_gpasid);
+
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			void __user *udata)
+{
+	struct iommu_gpasid_bind_data data;
+	int ret;
+
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return __iommu_sva_unbind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..7ca9d48c276c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -432,11 +432,14 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_cache_invalidate(struct iommu_domain *domain,
 				  struct device *dev,
-				  struct iommu_cache_invalidate_info *inv_info);
+				  void __user *uinfo);
+
 extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-		struct device *dev, struct iommu_gpasid_bind_data *data);
+				struct device *dev, void __user *udata);
 extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
-				struct device *dev, ioasid_t pasid);
+				struct device *dev, void __user *udata);
+extern int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				struct device *dev, struct iommu_gpasid_bind_data *data);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
