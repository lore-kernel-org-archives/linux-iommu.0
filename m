Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A14C2D0E9
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152252076A
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 23:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152252076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ECD7986D8D;
	Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zscs3qFkHImb; Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3229186D92;
	Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21420C1D89;
	Wed, 25 Mar 2020 23:11:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9BF2C0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D506587EF6
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dazh9fLQPGqE for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 23:11:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BA58A87EBE
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 23:11:25 +0000 (UTC)
IronPort-SDR: ruA4U15EsCs7so2pjYoF3WFl4CXHPVuvgvLBH9uYOVmfxodrtcwcDi2qdG6g4LEWkVZCfDAOOH
 /2fRo6iTwVQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 16:11:24 -0700
IronPort-SDR: cG6G9YYUY/6fnfQdw6vs5f/KoIe33IafXZ914Y+tHIbu33Mb1CLBqNqSjQeCnVtXQjjiYcWLVr
 Ls8xP2suSyYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; d="scan'208";a="236083693"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 16:11:24 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v2 2/3] iommu/uapi: Use unified UAPI version
Date: Wed, 25 Mar 2020 16:17:06 -0700
Message-Id: <1585178227-17061-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

Reuse UAPI version for each UAPI data structure.
This is to avoid supporting multiple version combinations, simplify
support model as we bump up the versions.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 drivers/iommu/intel-svm.c   | 2 +-
 drivers/iommu/iommu.c       | 3 ++-
 include/uapi/linux/iommu.h  | 9 +++------
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c1c0b0fb93c3..0304f7626a38 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5779,8 +5779,9 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
 	int ret = 0;
 	u64 size = 0;
 
+	/* Support current or older UAPI versions */
 	if (!inv_info || !dmar_domain ||
-		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		inv_info->version > IOMMU_UAPI_VERSION)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 47c0deb5ae56..67ac95eb5e33 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -239,7 +239,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
+	if (data->version > IOMMU_UAPI_VERSION ||
 	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
 		return -EINVAL;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3e3528436e0b..c476b58e0ffb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1113,7 +1113,8 @@ int iommu_page_response(struct device *dev,
 	if (!param || !param->fault_param)
 		return -EINVAL;
 
-	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
+	/* Support current or older UAPI versions */
+	if (msg->version > IOMMU_UAPI_VERSION ||
 	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
 		return -EINVAL;
 
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 25dba9198d7f..e9532c747dbd 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -188,7 +188,7 @@ enum iommu_page_response_code {
 
 /**
  * struct iommu_page_response - Generic page response information
- * @version: API version of this structure
+ * @version: IOMMU_UAPI_VERSION
  * @flags: encodes whether the corresponding fields are valid
  *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
  * @pasid: Process Address Space ID
@@ -196,7 +196,6 @@ enum iommu_page_response_code {
  * @code: response code from &enum iommu_page_response_code
  */
 struct iommu_page_response {
-#define IOMMU_PAGE_RESP_VERSION_1	1
 	__u32	version;
 #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
 	__u32	flags;
@@ -271,7 +270,7 @@ struct iommu_inv_pasid_info {
 /**
  * struct iommu_cache_invalidate_info - First level/stage invalidation
  *     information
- * @version: API version of this structure
+ * @version: IOMMU_UAPI_VERSION
  * @cache: bitfield that allows to select which caches to invalidate
  * @granularity: defines the lowest granularity used for the invalidation:
  *     domain > PASID > addr
@@ -299,7 +298,6 @@ struct iommu_inv_pasid_info {
  * must support the used granularity.
  */
 struct iommu_cache_invalidate_info {
-#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
 	__u32	version;
 /* IOMMU paging structure cache */
 #define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
@@ -343,7 +341,7 @@ struct iommu_gpasid_bind_data_vtd {
 					 IOMMU_SVA_VTD_GPASID_PWT)
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
- * @version:	Version of this data structure
+ * @version:	IOMMU_UAPI_VERSION
  * @format:	PASID table entry format
  * @flags:	Additional information on guest bind request
  * @gpgd:	Guest page directory base of the guest mm to bind
@@ -360,7 +358,6 @@ struct iommu_gpasid_bind_data_vtd {
  * PASID to host PASID based on this bind data.
  */
 struct iommu_gpasid_bind_data {
-#define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
