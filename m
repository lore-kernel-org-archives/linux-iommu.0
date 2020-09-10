Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC92DC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:44:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92937206B8
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92937206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 656BB87507;
	Thu, 10 Sep 2020 10:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMI58CYgQ4k0; Thu, 10 Sep 2020 10:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 102E6874F7;
	Thu, 10 Sep 2020 10:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A566C0859;
	Thu, 10 Sep 2020 10:43:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46602C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1BCB42E18A
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrJgzCQ5FCTz for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 10:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id E1B4A2E1B5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:36 +0000 (UTC)
IronPort-SDR: u4kpUEzDCI5mRKQe7yUjPoceVyiBq3UUiVDJZwmyHqHeUu9kPI1Km02fElOEkKKB+2xYWzqwSv
 CbYfdk+k7m7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="138024927"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="138024927"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:43:35 -0700
IronPort-SDR: +Z+rKAmPU2v0Ms/6/w9V7+CB+A5Gfv8ltEEGIXPAb4gnZcDBzAA6ws46vA4oOwAgacSwbJO0Cj
 qBmZ1+dvigKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334137226"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:43:35 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v7 16/16] iommu/vt-d: Support reporting nesting capability info
Date: Thu, 10 Sep 2020 03:45:33 -0700
Message-Id: <1599734733-6431-17-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, yi.y.sun@intel.com, jasowang@redhat.com,
 hao.wu@intel.com
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

This patch reports nesting info when iommu_domain_get_attr() is called with
DOMAIN_ATTR_NESTING and one domain with nesting set.

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
v6 -> v7:
*) split the patch in v6 into two patches:
   [PATCH v7 15/16] iommu/vt-d: Only support nesting when nesting caps are consistent across iommu units
   [PATCH v7 16/16] iommu/vt-d: Support reporting nesting capability info

v2 -> v3:
*) remove cap/ecap_mask in iommu_nesting_info.
---
 drivers/iommu/intel/iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 38c6c9b..e46214e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6089,6 +6089,79 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static int intel_iommu_get_nesting_info(struct iommu_domain *domain,
+					struct iommu_nesting_info *info)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	u64 cap = VTD_CAP_MASK, ecap = VTD_ECAP_MASK;
+	struct device_domain_info *domain_info;
+	struct iommu_nesting_info_vtd vtd;
+	unsigned int size;
+
+	if (!info)
+		return -EINVAL;
+
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED ||
+	    !(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
+		return -ENODEV;
+
+	size = sizeof(struct iommu_nesting_info);
+	/*
+	 * if provided buffer size is smaller than expected, should
+	 * return 0 and also the expected buffer size to caller.
+	 */
+	if (info->argsz < size) {
+		info->argsz = size;
+		return 0;
+	}
+
+	/*
+	 * arbitrary select the first domain_info as all nesting
+	 * related capabilities should be consistent across iommu
+	 * units.
+	 */
+	domain_info = list_first_entry(&dmar_domain->devices,
+				       struct device_domain_info, link);
+	cap &= domain_info->iommu->cap;
+	ecap &= domain_info->iommu->ecap;
+
+	info->addr_width = dmar_domain->gaw;
+	info->format = IOMMU_PASID_FORMAT_INTEL_VTD;
+	info->features = IOMMU_NESTING_FEAT_SYSWIDE_PASID |
+			 IOMMU_NESTING_FEAT_BIND_PGTBL |
+			 IOMMU_NESTING_FEAT_CACHE_INVLD;
+	info->pasid_bits = ilog2(intel_pasid_max_id);
+	memset(&info->padding, 0x0, 12);
+
+	vtd.flags = 0;
+	vtd.cap_reg = cap;
+	vtd.ecap_reg = ecap;
+
+	memcpy(&info->vendor.vtd, &vtd, sizeof(vtd));
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
+				(struct iommu_nesting_info *)data;
+		unsigned long flags;
+		int ret;
+
+		spin_lock_irqsave(&device_domain_lock, flags);
+		ret = intel_iommu_get_nesting_info(domain, info);
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return ret;
+	}
+	default:
+		return -ENOENT;
+	}
+}
+
 /*
  * Check that the device does not live on an external facing PCI port that is
  * marked as untrusted. Such devices should not be able to apply quirks and
@@ -6111,6 +6184,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_free		= intel_iommu_domain_free,
 	.domain_set_attr	= intel_iommu_domain_set_attr,
+	.domain_get_attr	= intel_iommu_domain_get_attr,
 	.attach_dev		= intel_iommu_attach_device,
 	.detach_dev		= intel_iommu_detach_device,
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
