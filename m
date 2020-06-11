Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E6C433E4
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4276320760
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4276320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2659887A30;
	Thu, 11 Jun 2020 12:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 35TuZ49Evuia; Thu, 11 Jun 2020 12:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67BB887A5F;
	Thu, 11 Jun 2020 12:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62FE9C0894;
	Thu, 11 Jun 2020 12:09:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D896C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 49275879F9
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Q242IHfV3gq for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 12:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2EB0087A5E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:09:11 +0000 (UTC)
IronPort-SDR: y3R/3AhJGaetFSR+r9NIa8jXxvangjgtj2bHQWbTBukTbA3ai88fEy8DKh9sQOYeq5/3mpaTUO
 aem/9+4Q7IKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2020 05:09:10 -0700
IronPort-SDR: vVlAQjgH2fTyZqTw8raZsfKSfA+L2MfciHnbuXYROz3fYsIC5nBSL7G5d2mhaPQPblhMUXd2jI
 9VWOFYNd1bHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; d="scan'208";a="419082489"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 11 Jun 2020 05:09:09 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v2 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Date: Thu, 11 Jun 2020 05:15:28 -0700
Message-Id: <1591877734-66527-10-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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

When an IOMMU domain with nesting attribute is used for guest SVA, a
system-wide PASID is allocated for binding with the device and the domain.
For security reason, we need to check the PASID passsed from user-space.
e.g. page table bind/unbind and PASID related cache invalidation.

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
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 drivers/iommu/intel-svm.c   |  6 ++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2d59a5d..25650ac 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5433,6 +5433,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		int granu = 0;
 		u64 pasid = 0;
 		u64 addr = 0;
+		void *pdata;
 
 		granu = to_vtd_granularity(cache_type, inv_info->granularity);
 		if (granu == -EINVAL) {
@@ -5452,6 +5453,15 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 (inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
 			pasid = inv_info->addr_info.pasid;
 
+		pdata = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
+		if (!pdata) {
+			ret = -EINVAL;
+			goto out_unlock;
+		} else if (IS_ERR(pdata)) {
+			ret = PTR_ERR(pdata);
+			goto out_unlock;
+		}
+
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
 			/* HW will ignore LSB bits based on address mask */
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index bf55e2f..49059c1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -332,7 +332,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
+	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
 	if (IS_ERR(svm)) {
 		ret = PTR_ERR(svm);
 		goto out;
@@ -450,6 +450,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
 			    struct iommu_gpasid_unbind_data *data)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct dmar_domain *dmar_domain;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = -EINVAL;
@@ -464,9 +465,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
 		return -EINVAL;
 
 	pasid = data->pasid;
+	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
+	svm = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
 	if (!svm) {
 		ret = -EINVAL;
 		goto out;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
