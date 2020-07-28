Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5831C433F8
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 06:21:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36EB22B3F
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 06:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36EB22B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F9598690E;
	Tue, 28 Jul 2020 06:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1s5_qgEqf_HO; Tue, 28 Jul 2020 06:21:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4F85C86978;
	Tue, 28 Jul 2020 06:21:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B0F9C0733;
	Tue, 28 Jul 2020 06:21:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 931B7C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7C33822CC7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gu1PCwETjhQH for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 06:20:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 84D4422812
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:20:57 +0000 (UTC)
IronPort-SDR: S+1ftEQIMAj+xnpwqAA/4ju6h9s+oAtFdm3Bq12PqIQcCNmZGfQ3ZtBgo+3dlyWJy4lDytzxhX
 UaLn1SiMXYnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152411234"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="152411234"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 23:20:56 -0700
IronPort-SDR: VyiBPr0vNrmCxDGcQ4QUdenaeG+1yPbpJCBMsRehXlNnm35WfPyqKxQLtiAyFNi/MAWs+5uP1I
 7ICjs52dC6Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="320274409"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2020 23:20:55 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v6 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Date: Mon, 27 Jul 2020 23:27:38 -0700
Message-Id: <1595917664-33276-10-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
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

When an IOMMU domain with nesting attribute is used for guest SVA, a
system-wide PASID is allocated for binding with the device and the domain.
For security reason, we need to check the PASID passed from user-space.
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
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 drivers/iommu/intel/svm.c   |  7 +++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b2fe54e..88f4647 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5436,6 +5436,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		int granu = 0;
 		u64 pasid = 0;
 		u64 addr = 0;
+		void *pdata;
 
 		granu = to_vtd_granularity(cache_type, inv_info->granularity);
 		if (granu == -EINVAL) {
@@ -5456,6 +5457,15 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 (inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
 			pasid = inv_info->granu.addr_info.pasid;
 
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
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index c85b8d5..b9b29ad 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -323,7 +323,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
+	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
 	if (IS_ERR(svm)) {
 		ret = PTR_ERR(svm);
 		goto out;
@@ -440,6 +440,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
 			    struct device *dev, u32 pasid)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct dmar_domain *dmar_domain;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = -EINVAL;
@@ -447,8 +448,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
 	if (WARN_ON(!iommu))
 		return -EINVAL;
 
+	dmar_domain = to_dmar_domain(domain);
+
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
