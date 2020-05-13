Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31691C433E5
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 22:55:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0A620659
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 22:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0A620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F3FB685D8D;
	Wed, 13 May 2020 22:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FH0Ya8UT_85u; Wed, 13 May 2020 22:55:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7EA385FA3;
	Wed, 13 May 2020 22:55:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6652C088B;
	Wed, 13 May 2020 22:55:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2CE3C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E9F1D88569
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oJm7EhPqRlkv for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 22:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ECC4B88550
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:55:41 +0000 (UTC)
IronPort-SDR: PF3mqlZJnjICEzPU8qh1riiIJIOlKX7nj56ANkdt18JBocgxTYnjZA8EqdJmgsV8ky0GljFLCU
 abrzxszETi5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2020 15:55:41 -0700
IronPort-SDR: UCh0zLXbqqnmNcmBCNQofwCcKNMGSFJXr70N2cJIeeeqWUDsUTd2JHESo+wTWF5covrMbxBz2b
 qKSGwe526trQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="437682668"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 13 May 2020 15:55:40 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v13 8/8] iommu/vt-d: Add custom allocator for IOASID
Date: Wed, 13 May 2020 16:01:49 -0700
Message-Id: <1589410909-38925-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>
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

When VT-d driver runs in the guest, PASID allocation must be
performed via virtual command interface. This patch registers a
custom IOASID allocator which takes precedence over the default
XArray based allocator. The resulting IOASID allocation will always
come from the host. This ensures that PASID namespace is system-
wide.

Virtual command registers are used in the guest only, to prevent
vmexit cost, we cache the capability and store it during initialization.

Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

---
v12     - squashed virtual command register caching patch with its user
        - reduce indentation
---
---
 drivers/iommu/dmar.c        |  1 +
 drivers/iommu/intel-iommu.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  7 ++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 34ee8f28555f..66af08ad10fb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -963,6 +963,7 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		warn_invalid_dmar(phys_addr, " returns all ones");
 		goto unmap;
 	}
+	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
 
 	/* the registers might be more than one page */
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 17072442ceae..b28a84a9fca3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1732,6 +1732,9 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 	}
+	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
+		ioasid_unregister_allocator(&iommu->pasid_allocator);
+
 #endif
 }
 
@@ -3266,6 +3269,85 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	return ret;
 }
 
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static ioasid_t intel_vcmd_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
+{
+	struct intel_iommu *iommu = data;
+	ioasid_t ioasid;
+
+	if (!iommu)
+		return INVALID_IOASID;
+	/*
+	 * VT-d virtual command interface always uses the full 20 bit
+	 * PASID range. Host can partition guest PASID range based on
+	 * policies but it is out of guest's control.
+	 */
+	if (min < PASID_MIN || max > intel_pasid_max_id)
+		return INVALID_IOASID;
+
+	if (vcmd_alloc_pasid(iommu, &ioasid))
+		return INVALID_IOASID;
+
+	return ioasid;
+}
+
+static void intel_vcmd_ioasid_free(ioasid_t ioasid, void *data)
+{
+	struct intel_iommu *iommu = data;
+
+	if (!iommu)
+		return;
+	/*
+	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
+	 * We can only free the PASID when all the devices are unbound.
+	 */
+	if (ioasid_find(NULL, ioasid, NULL)) {
+		pr_alert("Cannot free active IOASID %d\n", ioasid);
+		return;
+	}
+	vcmd_free_pasid(iommu, ioasid);
+}
+
+static void register_pasid_allocator(struct intel_iommu *iommu)
+{
+	/*
+	 * If we are running in the host, no need for custom allocator
+	 * in that PASIDs are allocated from the host system-wide.
+	 */
+	if (!cap_caching_mode(iommu->cap))
+		return;
+
+	if (!sm_supported(iommu)) {
+		pr_warn("VT-d Scalable Mode not enabled, no PASID allocation\n");
+		return;
+	}
+
+	/*
+	 * Register a custom PASID allocator if we are running in a guest,
+	 * guest PASID must be obtained via virtual command interface.
+	 * There can be multiple vIOMMUs in each guest but only one allocator
+	 * is active. All vIOMMU allocators will eventually be calling the same
+	 * host allocator.
+	 */
+	if (!ecap_vcs(iommu->ecap) || !vccap_pasid(iommu->vccap))
+		return;
+
+	pr_info("Register custom PASID allocator\n");
+	iommu->pasid_allocator.alloc = intel_vcmd_ioasid_alloc;
+	iommu->pasid_allocator.free = intel_vcmd_ioasid_free;
+	iommu->pasid_allocator.pdata = (void *)iommu;
+	if (ioasid_register_allocator(&iommu->pasid_allocator)) {
+		pr_warn("Custom PASID allocator failed, scalable mode disabled\n");
+		/*
+		 * Disable scalable mode on this IOMMU if there
+		 * is no custom allocator. Mixing SM capable vIOMMU
+		 * and non-SM vIOMMU are not supported.
+		 */
+		intel_iommu_sm = 0;
+	}
+}
+#endif
+
 static int __init init_dmars(void)
 {
 	struct dmar_drhd_unit *drhd;
@@ -3383,6 +3465,9 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
+#ifdef CONFIG_INTEL_IOMMU_SVM
+		register_pasid_allocator(iommu);
+#endif
 		iommu_set_root_entry(iommu);
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fd641af55494..1d03aa42bf2d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -19,6 +19,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/ioasid.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -195,6 +196,9 @@
 #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
 #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
 
+/* Virtual command interface capability */
+#define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
+
 /* IOTLB_REG */
 #define DMA_TLB_FLUSH_GRANU_OFFSET  60
 #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
@@ -288,6 +292,7 @@
 
 /* PRS_REG */
 #define DMA_PRS_PPR	((u32)1)
+#define DMA_VCS_PAS	((u64)1)
 
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
@@ -563,6 +568,7 @@ struct intel_iommu {
 	u64		reg_size; /* size of hw register set */
 	u64		cap;
 	u64		ecap;
+	u64		vccap;
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
 	raw_spinlock_t	register_lock; /* protect register handling */
 	int		seq_id;	/* sequence id of the iommu */
@@ -583,6 +589,7 @@ struct intel_iommu {
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
+	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
 #endif
 	struct q_inval  *qi;            /* Queued invalidation info */
 	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
