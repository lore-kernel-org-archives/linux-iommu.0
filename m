Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA47C433E9
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:45:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D270F64F2C
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 18:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D270F64F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86B7160754;
	Tue,  2 Mar 2021 18:45:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5LD8KbndPqq; Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 891096072C;
	Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5331FC0013;
	Tue,  2 Mar 2021 18:45:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 610D2C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AF5960713
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kH4VHWSVMhFu for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 18:45:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCB7160717
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 18:45:47 +0000 (UTC)
IronPort-SDR: GocPS1n3I5rwy5UwIAs2/TpX9OWWeW2KM8q+mUi5mFBOa0YgnJCYRNW+WqlQrM2Z0dp0e0vpka
 jiRIQxtyz2iA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174575581"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="174575581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 10:45:47 -0800
IronPort-SDR: yctoz7wOsaC6ovQ6iA1L2smLEcz6NgqtoM1gGgSvh2YtEvSBqFMgiDcqP+UMGRUGVzIs8+kC6A
 o4OvWFwrvMCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; d="scan'208";a="406158807"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga007.jf.intel.com with ESMTP; 02 Mar 2021 10:45:47 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <joro@8bytes.org>, "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 2/4] iommu/vt-d: Enable write protect propagation from guest
Date: Tue,  2 Mar 2021 02:13:58 -0800
Message-Id: <1614680040-1989-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>,
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

Write protect bit, when set, inhibits supervisor writes to the read-only
pages. In guest supervisor shared virtual addressing (SVA), write-protect
should be honored upon guest bind supervisor PASID request.

This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP bit.

Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 +++
 include/uapi/linux/iommu.h  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 0b7e0e726ade..b7e39239f539 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -763,6 +763,9 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
 			return -EINVAL;
 		}
 		pasid_set_sre(pte);
+		/* Enable write protect WP if guest requested */
+		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE)
+			pasid_set_wpe(pte);
 	}
 
 	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 35d48843acd8..3a9164cc9937 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
 #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
 #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
 #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
-#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
+#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect enable */
+#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
 	__u64 flags;
 	__u32 pat;
 	__u32 emt;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
