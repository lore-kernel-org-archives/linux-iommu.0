Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8EC433E0
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 20:57:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA8964E02
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 20:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA8964E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1E9D83B30;
	Tue, 23 Feb 2021 20:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0PJ4C_x5ww_q; Tue, 23 Feb 2021 20:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A6EC83B2E;
	Tue, 23 Feb 2021 20:57:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5CE1C000B;
	Tue, 23 Feb 2021 20:57:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 427E4C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 20:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27EE683B30
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 20:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VAmg9NLPcPk3 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 20:57:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DBFA683B2E
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 20:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614113819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+ZdO5GWOhsIz+y4lC/TipJ7Ly/JYy1VIwVzuFHqKAw=;
 b=L3PexX5rczOlatrbEzHP9MHU+bDzswyDLAE4BcmIPKR/8uuUK41z8EretjF83cDPT3HvYn
 ZvRd82meWU/KjC2qTKNq3E54gzZ1Pg1s3Bot/j7I1PEWxCWbmBb0ahLOTC5Hd9COYBRFSG
 /rPHVmlvJSf9Avkxkb41x2lEN+F8w7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-DYgyjrFtOYmZLsEzhuEIkw-1; Tue, 23 Feb 2021 15:56:57 -0500
X-MC-Unique: DYgyjrFtOYmZLsEzhuEIkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81CA801989;
 Tue, 23 Feb 2021 20:56:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 889FA5D9D0;
 Tue, 23 Feb 2021 20:56:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v14 01/13] iommu: Introduce attach/detach_pasid_table API
Date: Tue, 23 Feb 2021 21:56:22 +0100
Message-Id: <20210223205634.604221-2-eric.auger@redhat.com>
In-Reply-To: <20210223205634.604221-1-eric.auger@redhat.com>
References: <20210223205634.604221-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 jiangkunkun@huawei.com, vivek.gautam@arm.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org
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

In virtualization use case, when a guest is assigned
a PCI host device, protected by a virtual IOMMU on the guest,
the physical IOMMU must be programmed to be consistent with
the guest mappings. If the physical IOMMU supports two
translation stages it makes sense to program guest mappings
onto the first stage/level (ARM/Intel terminology) while the host
owns the stage/level 2.

In that case, it is mandated to trap on guest configuration
settings and pass those to the physical iommu driver.

This patch adds a new API to the iommu subsystem that allows
to set/unset the pasid table information.

A generic iommu_pasid_table_config struct is introduced in
a new iommu.h uapi header. This is going to be used by the VFIO
user API.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v13 -> v14:
- export iommu_attach_pasid_table
- add dummy iommu_uapi_attach_pasid_table
- swap base_ptr and format in iommu_pasid_table_config

v12 -> v13:
- Fix config check

v11 -> v12:
- add argsz, name the union
---
 drivers/iommu/iommu.c      | 69 ++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h      | 27 +++++++++++++++
 include/uapi/linux/iommu.h | 54 +++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..90bacf000789 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2200,6 +2200,75 @@ int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
+int iommu_attach_pasid_table(struct iommu_domain *domain,
+			     struct iommu_pasid_table_config *cfg)
+{
+	if (unlikely(!domain->ops->attach_pasid_table))
+		return -ENODEV;
+
+	return domain->ops->attach_pasid_table(domain, cfg);
+}
+EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
+
+int iommu_uapi_attach_pasid_table(struct iommu_domain *domain,
+				  void __user *uinfo)
+{
+	struct iommu_pasid_table_config pasid_table_data = { 0 };
+	u32 minsz;
+
+	if (unlikely(!domain->ops->attach_pasid_table))
+		return -ENODEV;
+
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_pasid_table_config, vendor_data);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(&pasid_table_data, uinfo, minsz))
+		return -EFAULT;
+
+	/* Fields before the variable size union are mandatory */
+	if (pasid_table_data.argsz < minsz)
+		return -EINVAL;
+
+	/* PASID and address granu require additional info beyond minsz */
+	if (pasid_table_data.version != PASID_TABLE_CFG_VERSION_1)
+		return -EINVAL;
+	if (pasid_table_data.format == IOMMU_PASID_FORMAT_SMMUV3 &&
+	    pasid_table_data.argsz <
+		offsetofend(struct iommu_pasid_table_config, vendor_data.smmuv3))
+		return -EINVAL;
+
+	/*
+	 * User might be using a newer UAPI header which has a larger data
+	 * size, we shall support the existing flags within the current
+	 * size. Copy the remaining user data _after_ minsz but not more
+	 * than the current kernel supported size.
+	 */
+	if (copy_from_user((void *)&pasid_table_data + minsz, uinfo + minsz,
+			   min_t(u32, pasid_table_data.argsz, sizeof(pasid_table_data)) - minsz))
+		return -EFAULT;
+
+	/* Now the argsz is validated, check the content */
+	if (pasid_table_data.config < IOMMU_PASID_CONFIG_TRANSLATE ||
+	    pasid_table_data.config > IOMMU_PASID_CONFIG_ABORT)
+		return -EINVAL;
+
+	return domain->ops->attach_pasid_table(domain, &pasid_table_data);
+}
+EXPORT_SYMBOL_GPL(iommu_uapi_attach_pasid_table);
+
+void iommu_detach_pasid_table(struct iommu_domain *domain)
+{
+	if (unlikely(!domain->ops->detach_pasid_table))
+		return;
+
+	domain->ops->detach_pasid_table(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 86d688c4418f..c4422975359e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -239,6 +239,8 @@ struct iommu_iotlb_gather {
  * @cache_invalidate: invalidate translation caches
  * @sva_bind_gpasid: bind guest pasid and mm
  * @sva_unbind_gpasid: unbind guest pasid and mm
+ * @attach_pasid_table: attach a pasid table
+ * @detach_pasid_table: detach the pasid table
  * @def_domain_type: device default domain type, return value:
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
@@ -304,6 +306,9 @@ struct iommu_ops {
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	u32 (*sva_get_pasid)(struct iommu_sva *handle);
+	int (*attach_pasid_table)(struct iommu_domain *domain,
+				  struct iommu_pasid_table_config *cfg);
+	void (*detach_pasid_table)(struct iommu_domain *domain);
 
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
@@ -454,6 +459,11 @@ extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
 					struct device *dev, void __user *udata);
 extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid);
+extern int iommu_attach_pasid_table(struct iommu_domain *domain,
+				    struct iommu_pasid_table_config *cfg);
+extern int iommu_uapi_attach_pasid_table(struct iommu_domain *domain,
+					 void __user *udata);
+extern void iommu_detach_pasid_table(struct iommu_domain *domain);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1028,6 +1038,23 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 	return -ENODEV;
 }
 
+static inline
+int iommu_attach_pasid_table(struct iommu_domain *domain,
+			     struct iommu_pasid_table_config *cfg)
+{
+	return -ENODEV;
+}
+
+static inline
+int iommu_uapi_attach_pasid_table(struct iommu_domain *domain,
+				  void __user *uinfo)
+{
+	return -ENODEV;
+}
+
+static inline
+void iommu_detach_pasid_table(struct iommu_domain *domain) {}
+
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index e1d9e75f2c94..40c28bb0e1bf 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -338,4 +338,58 @@ struct iommu_gpasid_bind_data {
 	} vendor;
 };
 
+/**
+ * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry stage 1 related
+ *     information
+ * @version: API version of this structure
+ * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
+ *         or 2-level table)
+ * @s1dss: STE s1dss (specifies the behavior when @pasid_bits != 0
+ *         and no PASID is passed along with the incoming transaction)
+ * @padding: reserved for future use (should be zero)
+ *
+ * The PASID table is referred to as the Context Descriptor (CD) table on ARM
+ * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A) for full
+ * details.
+ */
+struct iommu_pasid_smmuv3 {
+#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
+	__u32	version;
+	__u8	s1fmt;
+	__u8	s1dss;
+	__u8	padding[2];
+};
+
+/**
+ * struct iommu_pasid_table_config - PASID table data used to bind guest PASID
+ *     table to the host IOMMU
+ * @argsz: User filled size of this data
+ * @version: API version to prepare for future extensions
+ * @base_ptr: guest physical address of the PASID table
+ * @format: format of the PASID table
+ * @pasid_bits: number of PASID bits used in the PASID table
+ * @config: indicates whether the guest translation stage must
+ *          be translated, bypassed or aborted.
+ * @padding: reserved for future use (should be zero)
+ * @vendor_data.smmuv3: table information when @format is
+ * %IOMMU_PASID_FORMAT_SMMUV3
+ */
+struct iommu_pasid_table_config {
+	__u32	argsz;
+#define PASID_TABLE_CFG_VERSION_1 1
+	__u32	version;
+	__u64	base_ptr;
+#define IOMMU_PASID_FORMAT_SMMUV3	1
+	__u32	format;
+	__u8	pasid_bits;
+#define IOMMU_PASID_CONFIG_TRANSLATE	1
+#define IOMMU_PASID_CONFIG_BYPASS	2
+#define IOMMU_PASID_CONFIG_ABORT	3
+	__u8	config;
+	__u8    padding[2];
+	union {
+		struct iommu_pasid_smmuv3 smmuv3;
+	} vendor_data;
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
