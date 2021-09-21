Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA20C433FE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9FF61166
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D9FF61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DC7860EDD;
	Wed, 22 Sep 2021 05:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ud0cR4ezJPz5; Wed, 22 Sep 2021 05:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7198460AC2;
	Wed, 22 Sep 2021 05:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47E63C001D;
	Wed, 22 Sep 2021 05:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFCAC0025
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0F1840428
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZ056jEQ4ZCY for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:13:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF080403E8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287187652"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="287187652"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="550107679"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: [RFC 3/7] iommu/vt-d: Add DMA w/ PASID support for PA and IOVA
Date: Tue, 21 Sep 2021 13:29:37 -0700
Message-Id: <1632256181-36071-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, mike.campin@intel.com
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

For physical address(PA) mode, PASID entry for the given supervisor
PASID will be set up for HW pass-through (PT). For IOVA mode, the
supervisor PASID entry will be configured the same as PASID 0, which is
a special PASID for DMA request w/o PASID, a.k.a.
RID2PASID. Additional IOTLB flush for the supervisor PASID is also
included.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 95 ++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  7 ++-
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..cbcfd178c16f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1631,7 +1631,11 @@ static void domain_flush_piotlb(struct intel_iommu *iommu,
 	if (domain->default_pasid)
 		qi_flush_piotlb(iommu, did, domain->default_pasid,
 				addr, npages, ih);
-
+	if (domain->s_pasid) {
+		pr_alert_ratelimited("%s: pasid %u", __func__, domain->s_pasid);
+		qi_flush_piotlb(iommu, did, domain->s_pasid,
+				addr, npages, ih);
+	}
 	if (!list_empty(&domain->devices))
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
 }
@@ -5535,6 +5539,93 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int intel_enable_pasid_dma(struct device *dev, u32 pasid, int mode)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct device_domain_info *info;
+	unsigned long flags;
+	int ret = 0;
+
+	info = get_domain_info(dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!dev_is_pci(dev) || !sm_supported(info->iommu))
+		return -EINVAL;
+
+	if (intel_iommu_enable_pasid(info->iommu, dev))
+		return -ENODEV;
+
+	spin_lock_irqsave(&iommu->lock, flags);
+	switch (mode) {
+	case IOMMU_DMA_PASID_BYPASS:
+		dev_dbg(dev, "%s PT mode", __func__);
+		/* As a precaution, translation request should be responded with
+		 * physical address.
+		 */
+		if (!hw_pass_through) {
+			ret = -ENODEV;
+			goto exit_unlock;
+		}
+		/* HW may use large page for ATS */
+		pci_disable_ats(pdev);
+		ret = intel_pasid_setup_pass_through(info->iommu, info->domain,
+						      dev, pasid);
+		if (ret)
+			dev_err(dev, "Failed SPASID %d BYPASS", pasid);
+		break;
+	case IOMMU_DMA_PASID_IOVA:
+		dev_dbg(dev, "%s IOVA mode", __func__);
+		/*
+		 * We could use SL but FL is preferred for consistency with VM
+		 * where vIOMMU exposes FL only cap
+		 */
+		if (!domain_use_first_level(info->domain))
+			return -EINVAL;
+		/* To be used for IOTLB flush at PASID granularity */
+		info->domain->s_pasid = pasid;
+		ret = domain_setup_first_level(info->iommu, info->domain, dev,
+						pasid);
+		break;
+	default:
+		dev_err(dev, "Invalid PASID DMA mode %d", mode);
+		ret = -EINVAL;
+		goto exit_unlock;
+	}
+	info->pasid_mode = mode;
+exit_unlock:
+	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	return ret;
+}
+
+static int intel_disable_pasid_dma(struct device *dev)
+{
+	struct device_domain_info *info;
+	int ret = 0;
+
+	info = get_domain_info(dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!dev_is_pci(dev) || !sm_supported(info->iommu))
+		return -EINVAL;
+
+	if (intel_iommu_enable_pasid(info->iommu, dev))
+		return -ENODEV;
+
+	if (!dev->iommu) {
+		dev_err(dev, "No IOMMU params");
+		return -ENODEV;
+	}
+	dev_info(dev, "Tearing down DMA PASID %d",  info->domain->s_pasid);
+	intel_pasid_tear_down_entry(info->iommu, info->dev, info->domain->s_pasid, false);
+
+	info->domain->s_pasid = 0;
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5573,6 +5664,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
 #endif
+	.enable_pasid_dma	= intel_enable_pasid_dma,
+	.disable_pasid_dma	= intel_disable_pasid_dma,
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 03faf20a6817..8940759f759e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -21,6 +21,7 @@
 #include <linux/dmar.h>
 #include <linux/ioasid.h>
 #include <linux/bitfield.h>
+#include <linux/dma-iommu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -571,7 +572,10 @@ struct dmar_domain {
 					 * The default pasid used for non-SVM
 					 * traffic on mediated devices.
 					 */
-
+	u32		s_pasid;	/*
+					 * Supervisor PASID used for in-kernel
+					 * DMA request with PASID.
+					 */
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
@@ -652,6 +656,7 @@ struct device_domain_info {
 	struct intel_iommu *iommu; /* IOMMU used by this device */
 	struct dmar_domain *domain; /* pointer to domain */
 	struct pasid_table *pasid_table; /* pasid table */
+	enum iommu_dma_pasid_mode pasid_mode; /* DMA PASID address mode */
 };
 
 static inline void __iommu_flush_cache(
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
