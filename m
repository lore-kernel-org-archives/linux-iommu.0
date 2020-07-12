Return-Path: <SRS0=M77+=AX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA3C433E6
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53222070B
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 11:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53222070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3D8788B70;
	Sun, 12 Jul 2020 11:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hW8xI0c3qdQa; Sun, 12 Jul 2020 11:14:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DBEDA88869;
	Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7516C08A9;
	Sun, 12 Jul 2020 11:14:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C88DC0733
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 992BD893CC
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GfZMCrxgGoi1 for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8BEB3893E7
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:14:31 +0000 (UTC)
IronPort-SDR: E/h9Z2P8PUFEH2g0TQj0830d3diQvFyRqV3RY9MrFDSCJgSCuFCPmA/YbjiiDxa8uBj0fSfz83
 tkJv8yzMW8nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148489868"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="148489868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:14:30 -0700
IronPort-SDR: zd0ixL4Ch8prpJIg88cIj349IBmI83xKpIWi+Oa/xxVLeikQxmUYM/SW39IlKix08eq4FBwvU6
 ospZSiv31P8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="315788576"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 12 Jul 2020 04:14:30 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Date: Sun, 12 Jul 2020 04:21:04 -0700
Message-Id: <1594552870-55687-10-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
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
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 drivers/iommu/intel/svm.c   |  7 +++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d54198..a9504cb 100644
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
index d2c0e1a..212dee0 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -319,7 +319,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
+	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
 	if (IS_ERR(svm)) {
 		ret = PTR_ERR(svm);
 		goto out;
@@ -436,6 +436,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
+	struct dmar_domain *dmar_domain;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	int ret = -EINVAL;
@@ -443,8 +444,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain *domain,
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
