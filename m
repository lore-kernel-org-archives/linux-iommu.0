Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8740BC433E1
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 04:05:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267CA2072E
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 04:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267CA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D8916884D9;
	Thu, 11 Jun 2020 04:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLTj0v68MODE; Thu, 11 Jun 2020 04:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AB59E88552;
	Thu, 11 Jun 2020 04:05:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A9E9C0894;
	Thu, 11 Jun 2020 04:05:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 763F0C088C
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 04:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7305D88C87
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 04:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LNV7fdYlb1o4 for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 04:05:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1FE93894BC
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 04:05:53 +0000 (UTC)
IronPort-SDR: GJpJpETZ5phtze+XimNs4nY/EzY1UusX7ZVyoVOvGLlZ/TZHpiOKtn1aYKrbv3nJXpGGglBX3V
 i0J8IhEh0Y/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 21:05:51 -0700
IronPort-SDR: rBcKN0m/zBL0QanZwGU2OGEGNjdvVgKAtPcsxfzchmZobG0b00WQS6uQpcyAvdT3syq41uc+51
 i7EnAUIUGPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; d="scan'208";a="306804398"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Jun 2020 21:05:51 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 3/3] iommu/vt-d: Sanity check uapi argsz filled by users
Date: Wed, 10 Jun 2020 21:12:15 -0700
Message-Id: <1591848735-12447-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

IOMMU UAPI data has an argsz field which is filled by user. As the data
structures expands, argsz may change. As the UAPI data are shared among
different architectures, extensions of UAPI data could be a result of
one architecture which has no impact on another. Therefore, these argsz
santity checks are performed in the model specific IOMMU drivers. This
patch adds sanity checks in the VT-d to ensure argsz passed by userspace
matches feature flags and other contents.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++++++++
 drivers/iommu/intel-svm.c   | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 27ebf4b9faef..c98b5109684b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5365,6 +5365,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	unsigned long flags;
+	unsigned long minsz;
 	int cache_type;
 	u8 bus, devfn;
 	u16 did, sid;
@@ -5385,6 +5386,21 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	if (!(dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE))
 		return -EINVAL;
 
+	minsz = offsetofend(struct iommu_cache_invalidate_info, padding);
+	if (inv_info->argsz < minsz)
+		return -EINVAL;
+
+	/* Sanity check user filled invalidation dat sizes */
+	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
+		inv_info->argsz != offsetofend(struct iommu_cache_invalidate_info,
+					addr_info))
+		return -EINVAL;
+
+	if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
+		inv_info->argsz != offsetofend(struct iommu_cache_invalidate_info,
+					pasid_info))
+		return -EINVAL;
+
 	spin_lock_irqsave(&device_domain_lock, flags);
 	spin_lock(&iommu->lock);
 	info = get_domain_info(dev);
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 35b43fe819ed..64dc2c66dfff 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -235,15 +235,27 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct dmar_domain *dmar_domain;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
+	unsigned long minsz;
 	int ret = 0;
 
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
+	/*
+	 * We mandate that no size change in IOMMU UAPI data before the
+	 * variable size union at the end.
+	 */
+	minsz = offsetofend(struct iommu_gpasid_bind_data, padding);
+	if (data->argsz < minsz)
+		return -EINVAL;
+
 	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
 	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
 		return -EINVAL;
 
+	if (data->argsz != offsetofend(struct iommu_gpasid_bind_data, vtd))
+		return -EINVAL;
+
 	if (!dev_is_pci(dev))
 		return -ENOTSUPP;
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
