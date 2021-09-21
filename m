Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D785C433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200F46105A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 200F46105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0158B607D7;
	Wed, 22 Sep 2021 05:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ya5GdwS3DzNX; Wed, 22 Sep 2021 05:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A0C461397;
	Wed, 22 Sep 2021 05:13:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F6C5C002A;
	Wed, 22 Sep 2021 05:13:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12553C0025
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1EA940245
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KcB8aOiXUvBk for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:13:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78C69400F5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:14 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287187656"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="287187656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="550107690"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: [RFC 5/7] iommu/vt-d: Add support for KVA PASID mode
Date: Tue, 21 Sep 2021 13:29:39 -0700
Message-Id: <1632256181-36071-6-git-send-email-jacob.jun.pan@linux.intel.com>
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

To support KVA fast mode, the VT-d driver must support domain allocation
of IOMMU_DOMAIN_KVA type. Since all devices in fast KVA mode share the
same kernel mapping, a single KVA domain is sufficient. This global KVA
domain contains the kernel mapping, i.e. init_mm.pgd.

The programming of the KVA domain follows the existing flow of auxiliary
domain attachment.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 59 ++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cbcfd178c16f..0dabd5f75acf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -293,6 +293,9 @@ static inline void context_clear_entry(struct context_entry *context)
  *	3. Each iommu mapps to this domain if successful.
  */
 static struct dmar_domain *si_domain;
+
+/* This domain is used for shared virtual addressing with CPU kernel mapping */
+static struct dmar_domain *kva_domain;
 static int hw_pass_through = 1;
 
 #define for_each_domain_iommu(idx, domain)			\
@@ -1989,6 +1992,10 @@ static void domain_exit(struct dmar_domain *domain)
 	/* Remove associated devices and clear attached or cached domains */
 	domain_remove_dev_info(domain);
 
+	/* There is no IOMMU page table for KVA */
+	if (domain->pgd == (struct dma_pte *)init_mm.pgd)
+		return;
+
 	/* destroy iovas */
 	if (domain->domain.type == IOMMU_DOMAIN_DMA)
 		iommu_put_dma_cookie(&domain->domain);
@@ -2533,6 +2540,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	int agaw, level;
 	int flags = 0;
 
+	if (domain->domain.type == IOMMU_DOMAIN_KVA) {
+		flags |= PASID_FLAG_SUPERVISOR_MODE;
+		goto do_setup;
+	}
 	/*
 	 * Skip top levels of page tables for iommu which has
 	 * less agaw than default. Unnecessary for PT mode.
@@ -2554,7 +2565,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 
 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
 		flags |= PASID_FLAG_PAGE_SNOOP;
-
+do_setup:
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
 					     domain->iommu_did[iommu->seq_id],
 					     flags);
@@ -2713,7 +2724,28 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
+#ifdef CONFIG_INTEL_IOMMU_SVM
+static int __init kva_domain_init(void)
+{
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
 
+	kva_domain = alloc_domain(0);
+	if (!kva_domain) {
+		pr_err("Can't allocate KVA domain\n");
+		return -EFAULT;
+	}
+	kva_domain->pgd = (struct dma_pte *)init_mm.pgd;
+	domain = &kva_domain->domain;
+	domain->type = IOMMU_DOMAIN_KVA;
+	/* REVISIT: may not need this other than sanity check */
+	domain->geometry.aperture_start = 0;
+	domain->geometry.aperture_end   =
+		__DOMAIN_MAX_ADDR(dmar_domain->gaw);
+	domain->geometry.force_aperture = true;
+	return 0;
+}
+#endif
 static int __init si_domain_init(int hw)
 {
 	struct dmar_rmrr_unit *rmrr;
@@ -3363,6 +3395,11 @@ static int __init init_dmars(void)
 			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
+			/* For in-kernel DMA with PASID in SVA */
+			ret = kva_domain_init();
+			if (ret)
+				goto free_iommu;
+
 		}
 #endif
 		ret = dmar_set_interrupt(iommu);
@@ -4558,6 +4595,9 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		domain->geometry.force_aperture = true;
 
 		return domain;
+	case IOMMU_DOMAIN_KVA:
+		/* Use a global domain for shared KVA mapping */
+		return &kva_domain->domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
 	default:
@@ -4583,7 +4623,8 @@ is_aux_domain(struct device *dev, struct iommu_domain *domain)
 	struct device_domain_info *info = get_domain_info(dev);
 
 	return info && info->auxd_enabled &&
-			domain->type == IOMMU_DOMAIN_UNMANAGED;
+		(domain->type == IOMMU_DOMAIN_UNMANAGED ||
+			domain->type == IOMMU_DOMAIN_KVA);
 }
 
 static inline struct subdev_domain_info *
@@ -4693,8 +4734,8 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	if (ret)
 		goto attach_failed;
 
-	/* Setup the PASID entry for mediated devices: */
-	if (domain_use_first_level(domain))
+	/* Setup the PASID entry for devices do DMA with the default PASID */
+	if (domain_use_first_level(domain) || domain->domain.type == IOMMU_DOMAIN_KVA)
 		ret = domain_setup_first_level(iommu, domain, dev,
 					       domain->default_pasid);
 	else
@@ -4761,6 +4802,10 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if (domain->type == IOMMU_DOMAIN_KVA) {
+		pr_info("TODO: KVA dom check if device can do full 64bit DMA");
+		return 0;
+	}
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5588,6 +5633,12 @@ static int intel_enable_pasid_dma(struct device *dev, u32 pasid, int mode)
 		ret = domain_setup_first_level(info->iommu, info->domain, dev,
 						pasid);
 		break;
+	case IOMMU_DMA_PASID_KVA:
+		/*
+		 * KVA mode should be handled in the aux domain attach where the default
+		 * PASID of the aux domain is used for setting up PASID FL.
+		 */
+		fallthrough;
 	default:
 		dev_err(dev, "Invalid PASID DMA mode %d", mode);
 		ret = -EINVAL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
