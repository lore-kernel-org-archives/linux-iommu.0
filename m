Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB27C433E4
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE33B20885
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE33B20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9D33788496;
	Sat,  4 Jul 2020 11:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9xE5X8d84d6; Sat,  4 Jul 2020 11:20:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5BC9E884BB;
	Sat,  4 Jul 2020 11:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43862C08A2;
	Sat,  4 Jul 2020 11:20:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C0B9C1798
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3E7C489177
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cgZPaWHkIV4i for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 11:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BBD2489357
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:55 +0000 (UTC)
IronPort-SDR: mQt2zlwuW7aW70vIFYAcVWSIsFqK56g/1V+uXyq8HerJX8LS1ARuJG15wuvWUYzB9GYAzaCrFd
 MHooWZn4BXkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="134701886"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="134701886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2020 04:19:53 -0700
IronPort-SDR: h1ON9ETzssuBh2NUHeKx3XWaxFJYgjZnBju22b4lJCMGJch1c4hNBI03NqOWz88xQEFNWlU7ri
 JlOT6KXhzlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="282521463"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 04 Jul 2020 04:19:53 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v4 15/15] iommu/vt-d: Support reporting nesting capability info
Date: Sat,  4 Jul 2020 04:26:29 -0700
Message-Id: <1593861989-35920-16-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v2 -> v3:
*) remove cap/ecap_mask in iommu_nesting_info.
---
 drivers/iommu/intel/iommu.c | 81 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/intel-iommu.h | 16 +++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7bebf82..4c10f4f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5659,12 +5659,16 @@ static inline bool iommu_pasid_support(void)
 static inline bool nested_mode_support(void)
 {
 	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
+	struct intel_iommu *iommu, *prev = NULL;
 	bool ret = true;
 
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
-		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap)) {
+		if (!prev)
+			prev = iommu;
+		if (!sm_supported(iommu) || !ecap_nest(iommu->ecap) ||
+		    (VTD_CAP_MASK & (iommu->cap ^ prev->cap)) ||
+		    (VTD_ECAP_MASK & (iommu->ecap ^ prev->ecap))) {
 			ret = false;
 			break;
 		}
@@ -6073,6 +6077,78 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int intel_iommu_get_nesting_info(struct iommu_domain *domain,
+					struct iommu_nesting_info *info)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	u64 cap = VTD_CAP_MASK, ecap = VTD_ECAP_MASK;
+	struct device_domain_info *domain_info;
+	struct iommu_nesting_info_vtd vtd;
+	unsigned long flags;
+	u32 size;
+
+	if ((domain->type != IOMMU_DOMAIN_UNMANAGED) ||
+	    !(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
+		return -ENODEV;
+
+	if (!info)
+		return -EINVAL;
+
+	size = sizeof(struct iommu_nesting_info) +
+		sizeof(struct iommu_nesting_info_vtd);
+	/*
+	 * if provided buffer size is not equal to the size, should
+	 * return 0 and also the expected buffer size to caller.
+	 */
+	if (info->size != size) {
+		info->size = size;
+		return 0;
+	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	/*
+	 * arbitrary select the first domain_info as all nesting
+	 * related capabilities should be consistent across iommu
+	 * units.
+	 */
+	domain_info = list_first_entry(&dmar_domain->devices,
+				      struct device_domain_info, link);
+	cap &= domain_info->iommu->cap;
+	ecap &= domain_info->iommu->ecap;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	info->format = IOMMU_PASID_FORMAT_INTEL_VTD;
+	info->features = IOMMU_NESTING_FEAT_SYSWIDE_PASID |
+			 IOMMU_NESTING_FEAT_BIND_PGTBL |
+			 IOMMU_NESTING_FEAT_CACHE_INVLD;
+	info->addr_width = dmar_domain->gaw;
+	info->pasid_bits = ilog2(intel_pasid_max_id);
+	info->padding = 0;
+	vtd.flags = 0;
+	vtd.padding = 0;
+	vtd.cap_reg = cap;
+	vtd.ecap_reg = ecap;
+
+	memcpy(info->data, &vtd, sizeof(vtd));
+	return 0;
+}
+
+static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
+				       enum iommu_attr attr, void *data)
+{
+	switch (attr) {
+	case DOMAIN_ATTR_NESTING:
+	{
+		struct iommu_nesting_info *info =
+				(struct iommu_nesting_info *) data;
+
+		return intel_iommu_get_nesting_info(domain, info);
+	}
+	default:
+		return -ENODEV;
+	}
+}
+
 /*
  * Check that the device does not live on an external facing PCI port that is
  * marked as untrusted. Such devices should not be able to apply quirks and
@@ -6095,6 +6171,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_free		= intel_iommu_domain_free,
 	.domain_set_attr	= intel_iommu_domain_set_attr,
+	.domain_get_attr	= intel_iommu_domain_get_attr,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 18f292e..a5728d7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -197,6 +197,22 @@
 #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
 #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
 
+/* Nesting Support Capability Alignment */
+#define VTD_CAP_FL1GP		(1ULL << 56)
+#define VTD_CAP_FL5LP		(1ULL << 60)
+#define VTD_ECAP_PRS		(1ULL << 29)
+#define VTD_ECAP_ERS		(1ULL << 30)
+#define VTD_ECAP_SRS		(1ULL << 31)
+#define VTD_ECAP_EAFS		(1ULL << 34)
+#define VTD_ECAP_PASID		(1ULL << 40)
+
+/* Only capabilities marked in below MASKs are reported */
+#define VTD_CAP_MASK		(VTD_CAP_FL1GP | VTD_CAP_FL5LP)
+
+#define VTD_ECAP_MASK		(VTD_ECAP_PRS | VTD_ECAP_ERS | \
+				 VTD_ECAP_SRS | VTD_ECAP_EAFS | \
+				 VTD_ECAP_PASID)
+
 /* Virtual command interface capability */
 #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
