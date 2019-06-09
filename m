Return-Path: <SRS0=fKZg=UI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B05C28EBD
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 13:42:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659E62145D
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 13:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659E62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 006D3C7D;
	Sun,  9 Jun 2019 13:41:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0B807C75
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 13:41:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 53E3776F
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 13:41:20 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2019 06:41:18 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga003.jf.intel.com with ESMTP; 09 Jun 2019 06:41:18 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 11/22] iommu: Introduce guest PASID bind function
Date: Sun,  9 Jun 2019 06:44:11 -0700
Message-Id: <1560087862-57608-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Guest shared virtual address (SVA) may require host to shadow guest
PASID tables. Guest PASID can also be allocated from the host via
enlightened interfaces. In this case, guest needs to bind the guest
mm, i.e. cr3 in guest physical address to the actual PASID table in
the host IOMMU. Nesting will be turned on such that guest virtual
address can go through a two level translation:
- 1st level translates GVA to GPA
- 2nd level translates GPA to HPA
This patch introduces APIs to bind guest PASID data to the assigned
device entry in the physical IOMMU. See the diagram below for usage
explaination.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process mm, FL only |
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                      GP
    '-------------'
Guest
------| Shadow |----------------------- GP->HP* ---------
      v        v                          |
Host                                      v
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.---------------------.
    |             |   |Set SL to GPA-HPA    |
    |             |   '---------------------'
    '-------------'

Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables
 - GP = Guest PASID
 - HP = Host PASID
* Conversion needed if non-identity GP-HP mapping option is chosen.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c      | 20 ++++++++++++++++
 include/linux/iommu.h      | 21 +++++++++++++++++
 include/uapi/linux/iommu.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1758b57..d0416f60 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1648,6 +1648,26 @@ int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
 
+int iommu_sva_bind_gpasid(struct iommu_domain *domain,
+			struct device *dev, struct gpasid_bind_data *data)
+{
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	return domain->ops->sva_bind_gpasid(domain, dev, data);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
+
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			ioasid_t pasid)
+{
+	if (unlikely(!domain->ops->sva_unbind_gpasid))
+		return -ENODEV;
+
+	return domain->ops->sva_unbind_gpasid(dev, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8d766a8..560c8c8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/ioasid.h>
 #include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -267,6 +268,8 @@ struct page_response_msg {
  * @detach_pasid_table: detach the pasid table
  * @cache_invalidate: invalidate translation caches
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @sva_bind_gpasid: bind guest pasid and mm
+ * @sva_unbind_gpasid: unbind guest pasid and mm
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -332,6 +335,10 @@ struct iommu_ops {
 	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
 				struct iommu_cache_invalidate_info *inv_info);
+	int (*sva_bind_gpasid)(struct iommu_domain *domain,
+			struct device *dev, struct gpasid_bind_data *data);
+
+	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
 	unsigned long pgsize_bitmap;
 };
@@ -447,6 +454,10 @@ extern void iommu_detach_pasid_table(struct iommu_domain *domain);
 extern int iommu_cache_invalidate(struct iommu_domain *domain,
 				  struct device *dev,
 				  struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
+		struct device *dev, struct gpasid_bind_data *data);
+extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -998,6 +1009,16 @@ iommu_cache_invalidate(struct iommu_domain *domain,
 {
 	return -ENODEV;
 }
+static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
+				struct device *dev, struct gpasid_bind_data *data)
+{
+	return -ENODEV;
+}
+
+static inline int sva_unbind_gpasid(struct device *dev, int pasid)
+{
+	return -ENODEV;
+}
 
 #endif /* CONFIG_IOMMU_API */
 
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index ca4b753..a9cdc63 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -277,4 +277,62 @@ struct iommu_cache_invalidate_info {
 	};
 };
 
+/**
+ * struct gpasid_bind_data_vtd - Intel VT-d specific data on device and guest
+ * SVA binding.
+ *
+ * @flags:	VT-d PASID table entry attributes
+ * @pat:	Page attribute table data to compute effective memory type
+ * @emt:	Extended memory type
+ *
+ * Only guest vIOMMU selectable and effective options are passed down to
+ * the host IOMMU.
+ */
+struct gpasid_bind_data_vtd {
+#define IOMMU_SVA_VTD_GPASID_SRE	(1 << 0) /* supervisor request */
+#define IOMMU_SVA_VTD_GPASID_EAFE	(1 << 1) /* extended access enable */
+#define IOMMU_SVA_VTD_GPASID_PCD	(1 << 2) /* page-level cache disable */
+#define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
+#define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
+#define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
+	__u64 flags;
+	__u32 pat;
+	__u32 emt;
+};
+
+/**
+ * struct gpasid_bind_data - Information about device and guest PASID binding
+ * @version:	Version of this data structure
+ * @format:	PASID table entry format
+ * @flags:	Additional information on guest bind request
+ * @gpgd:	Guest page directory base of the guest mm to bind
+ * @hpasid:	Process address space ID used for the guest mm in host IOMMU
+ * @gpasid:	Process address space ID used for the guest mm in guest IOMMU
+ * @addr_width:	Guest virtual address width
+ * @vtd:	Intel VT-d specific data
+ *
+ * Guest to host PASID mapping can be an identity or non-identity, where guest
+ * has its own PASID space. For non-identify mapping, guest to host PASID lookup
+ * is needed when VM programs guest PASID into an assigned device. VMM may
+ * trap such PASID programming then request host IOMMU driver to convert guest
+ * PASID to host PASID based on this bind data.
+ */
+struct gpasid_bind_data {
+#define IOMMU_GPASID_BIND_VERSION_1	1
+	__u32 version;
+#define IOMMU_PASID_FORMAT_INTEL_VTD	1
+	__u32 format;
+#define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
+	__u64 flags;
+	__u64 gpgd;
+	__u64 hpasid;
+	__u64 gpasid;
+	__u32 addr_width;
+	__u8  padding[4];
+	/* Vendor specific data */
+	union {
+		struct gpasid_bind_data_vtd vtd;
+	};
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
