Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69940C07548
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:43:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C80206B8
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C80206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CAF99870D0;
	Thu, 10 Sep 2020 10:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s28EzaU-zkGf; Thu, 10 Sep 2020 10:43:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E60A185D3D;
	Thu, 10 Sep 2020 10:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5690C0894;
	Thu, 10 Sep 2020 10:43:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89667C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 826688742F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M9ymqD9Ml1U4 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 10:43:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A143A8747C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:43:36 +0000 (UTC)
IronPort-SDR: kKjBOIUUvpg0gBHlihYerW1arT/tvFXK8tVfU7Z/pMeNby7MbRIwpKIgmfnMrBsDdBH4kuPwVE
 X5JjRUi6UThA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243323839"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="243323839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:43:35 -0700
IronPort-SDR: AJSAoAe8J/v4IYsTisio5eeg99esw7VnpbfAIX6Ns8DQro0L+nV+BqlMIhxKWm2LXBdcg4ZTqy
 dFUUNZVJQ2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334137222"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:43:35 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v7 15/16] iommu/vt-d: Only support nesting when nesting caps
 are consistent across iommu units
Date: Thu, 10 Sep 2020 03:45:32 -0700
Message-Id: <1599734733-6431-16-git-send-email-yi.l.liu@intel.com>
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

This patch makes change to only supports the case where all the physical iommu
units have the same CAP/ECAP MASKS for nested translation.

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
v6 - > v7:
*) added per comment from Eric.
   https://lore.kernel.org/kvm/7fe337fa-abbc-82be-c8e8-b9e2a6179b90@redhat.com/
---
 drivers/iommu/intel/iommu.c |  8 ++++++--
 include/linux/intel-iommu.h | 16 ++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 95740b9..38c6c9b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5675,12 +5675,16 @@ static inline bool iommu_pasid_support(void)
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
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index db7fc59..e7b7512 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -197,6 +197,22 @@
 #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
 #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping Control */
 
+/* Nesting Support Capability Alignment */
+#define VTD_CAP_FL1GP		BIT_ULL(56)
+#define VTD_CAP_FL5LP		BIT_ULL(60)
+#define VTD_ECAP_PRS		BIT_ULL(29)
+#define VTD_ECAP_ERS		BIT_ULL(30)
+#define VTD_ECAP_SRS		BIT_ULL(31)
+#define VTD_ECAP_EAFS		BIT_ULL(34)
+#define VTD_ECAP_PASID		BIT_ULL(40)
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
