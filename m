Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8EEC433E1
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 16:57:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC79C20781
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC79C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76FA588EE9;
	Tue, 23 Jun 2020 16:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6G24u0m0QF9l; Tue, 23 Jun 2020 16:57:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 842BC88A87;
	Tue, 23 Jun 2020 16:57:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EEE2C088E;
	Tue, 23 Jun 2020 16:57:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C29ADC016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 16:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 99C26260AD
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 16:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h00M6bb5tigI for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 16:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 2F6C9203A6
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 16:57:29 +0000 (UTC)
IronPort-SDR: njT+UbAGh5p3jzXapW8TyY7BcpfSE+I9bgfIROXx2MS03Gtg9JWa3X0N7La3kZxaax5mDfUGsx
 +jJ+vVfR0CwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132541403"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="132541403"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 09:57:28 -0700
IronPort-SDR: gGl+vfJLsDZerAtB00Ng5Oi0UslNesAb+AmtqDSv7qYGZNCKjsrRiPTN14Ze1wbvFN8qJOJEO3
 9sr4/WilAZTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; d="scan'208";a="452290903"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 09:57:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 4/5] iommu/uapi: Handle data and argsz filled by users
Date: Tue, 23 Jun 2020 10:03:56 -0700
Message-Id: <1592931837-58223-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
Details are documented in Documentation/userspace-api/iommu.rst

This patch adds sanity checks in both IOMMU layer and vendor code, where
VT-d is the only user for now.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c |  3 ++
 drivers/iommu/iommu.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/iommu.h     |  7 ++--
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 713b3a218483..237db56878c0 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -244,6 +244,9 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
 		return -EINVAL;
 
+	if (data->argsz != offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
+		return -EINVAL;
+
 	if (!dev_is_pci(dev))
 		return -ENOTSUPP;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d43120eb1dc5..4a025c429b41 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1951,22 +1951,108 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-			   struct iommu_cache_invalidate_info *inv_info)
+			void __user *uinfo)
 {
+	struct iommu_cache_invalidate_info inv_info;
+	unsigned long minsz, maxsz;
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
+	/*
+	 * User might be using a newer UAPI header, we shall let IOMMU vendor
+	 * driver decide on what size it needs. Since the UAPI data extension
+	 * can be vendor specific, larger argsz could be the result of extension
+	 * for one vendor but it should not affect another vendor.
+	 */
+	/*
+	 * User might be using a newer UAPI header which has a larger data
+	 * size, we shall support the existing flags within the current
+	 * size.
+	 */
+	if (inv_info.argsz > maxsz)
+		inv_info.argsz = maxsz;
+
+	/* Checking the exact argsz based on generic flags */
+	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
+		inv_info.argsz != offsetofend(struct iommu_cache_invalidate_info,
+					granu.addr_info))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
+		inv_info.argsz != offsetofend(struct iommu_cache_invalidate_info,
+					granu.pasid_info))
+		return -EINVAL;
+
+	/* Copy the remaining user data _after_ minsz */
+	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
+				inv_info.argsz - minsz))
+		return -EFAULT;
+
+	return domain->ops->cache_invalidate(domain, dev, &inv_info);
 }
 EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
 
-int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-			   struct device *dev, struct iommu_gpasid_bind_data *data)
+int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+						void __user *udata)
 {
+
+	struct iommu_gpasid_bind_data data;
+	unsigned long minsz, maxsz;
+
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_bind_gpasid(domain, dev, data);
+	/* Current kernel data size is the max to be copied from user */
+	maxsz = sizeof(struct iommu_gpasid_bind_data);
+	memset((void *)&data, 0, maxsz);
+
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(&data, udata, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (data.argsz < minsz)
+		return -EINVAL;
+	/*
+	 * User might be using a newer UAPI header, we shall let IOMMU vendor
+	 * driver decide on what size it needs. Since the guest PASID bind data
+	 * can be vendor specific, larger argsz could be the result of extension
+	 * for one vendor but it should not affect another vendor.
+	 */
+	if (data.argsz > maxsz)
+		data.argsz = maxsz;
+
+	/* Copy the remaining user data _after_ minsz */
+	if (copy_from_user((void *)&data + minsz, udata + minsz,
+				data.argsz - minsz))
+		return -EFAULT;
+
+
+	return domain->ops->sva_bind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..a688fea42ae5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -432,9 +432,10 @@ extern void iommu_detach_device(struct iommu_domain *domain,
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
 				struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
@@ -1062,7 +1063,7 @@ iommu_cache_invalidate(struct iommu_domain *domain,
 	return -ENODEV;
 }
 static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
-				struct device *dev, struct iommu_gpasid_bind_data *data)
+				struct device *dev, void __user *udata)
 {
 	return -ENODEV;
 }
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
