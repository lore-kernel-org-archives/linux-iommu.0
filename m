Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC20C433E8
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED942064B
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED942064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1802688263;
	Fri, 24 Jul 2020 01:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PrnuLGOCxU-k; Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A3C287EDD;
	Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 638C4C004F;
	Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91900C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8E91D87ECF
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7QwTD5WaLlZC for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E7A0387E84
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:33 +0000 (UTC)
IronPort-SDR: Q2VDkWYn2s93wzwL8fHMvJVZTCwtWdCO6ThdqU8q+k5dRPO0AOGutoSrZhf4x41XiNXUp3czyf
 bwfEf6ga+3RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778780"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:33 -0700
IronPort-SDR: W2iC4/DRpvL/qD6dDwDSdVhn6FtI6l99mtdszxdWQvSHyb/369iegNKl0HClzZxCRhVnBwZvlT
 04d6utujmSRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576733"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 05/12] iommu/vt-d: Fix devTLB flush for vSVA
Date: Fri, 24 Jul 2020 09:49:18 +0800
Message-Id: <20200724014925.15523-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724014925.15523-1-baolu.lu@linux.intel.com>
References: <20200724014925.15523-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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

From: Liu Yi L <yi.l.liu@intel.com>

For guest SVA usage, in order to optimize for less VMEXIT, guest request
of IOTLB flush also includes device TLB.

On the host side, IOMMU driver performs IOTLB and implicit devTLB
invalidation. When PASID-selective granularity is requested by the guest
we need to derive the equivalent address range for devTLB instead of
using the address information in the UAPI data. The reason for that is,
unlike IOTLB flush, devTLB flush does not support PASID-selective
granularity. This is to say, we need to set the following in the PASID
based devTLB invalidation descriptor:
- entire 64 bit range in address ~(0x1 << 63)
- S bit = 1 (VT-d CH 6.5.2.6).

Without this fix, device TLB flush range is not set properly for PASID
selective granularity. This patch also merged devTLB flush code for both
implicit and explicit cases.

Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 888697dd240a..281b32b233d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5422,7 +5422,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	sid = PCI_DEVID(bus, devfn);
 
 	/* Size is only valid in address selective invalidation */
-	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
+	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
 		size = to_vtd_size(inv_info->addr_info.granule_size,
 				   inv_info->addr_info.nb_granules);
 
@@ -5431,6 +5431,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 IOMMU_CACHE_INV_TYPE_NR) {
 		int granu = 0;
 		u64 pasid = 0;
+		u64 addr = 0;
 
 		granu = to_vtd_granularity(cache_type, inv_info->granularity);
 		if (granu == -EINVAL) {
@@ -5470,24 +5471,34 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
 					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
 
+			if (!info->ats_enabled)
+				break;
 			/*
 			 * Always flush device IOTLB if ATS is enabled. vIOMMU
 			 * in the guest may assume IOTLB flush is inclusive,
 			 * which is more efficient.
 			 */
-			if (info->ats_enabled)
-				qi_flush_dev_iotlb_pasid(iommu, sid,
-						info->pfsid, pasid,
-						info->ats_qdep,
-						inv_info->addr_info.addr,
-						size);
-			break;
+			fallthrough;
 		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
+			/*
+			 * PASID based device TLB invalidation does not support
+			 * IOMMU_INV_GRANU_PASID granularity but only supports
+			 * IOMMU_INV_GRANU_ADDR.
+			 * The equivalent of that is we set the size to be the
+			 * entire range of 64 bit. User only provides PASID info
+			 * without address info. So we set addr to 0.
+			 */
+			if (inv_info->granularity == IOMMU_INV_GRANU_PASID) {
+				size = 64 - VTD_PAGE_SHIFT;
+				addr = 0;
+			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR) {
+				addr = inv_info->addr_info.addr;
+			}
+
 			if (info->ats_enabled)
 				qi_flush_dev_iotlb_pasid(iommu, sid,
 						info->pfsid, pasid,
-						info->ats_qdep,
-						inv_info->addr_info.addr,
+						info->ats_qdep, addr,
 						size);
 			else
 				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
