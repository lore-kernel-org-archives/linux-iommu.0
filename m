Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03FDC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 02:21:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D76361989
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 02:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D76361989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C162740431;
	Tue, 30 Mar 2021 02:21:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9kbH2Sld4bc; Tue, 30 Mar 2021 02:21:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CF144042E;
	Tue, 30 Mar 2021 02:21:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1708C000C;
	Tue, 30 Mar 2021 02:21:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A36AEC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 02:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D278607FD
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 02:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cefScms7A5MA for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 02:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4800607DA
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 02:21:16 +0000 (UTC)
IronPort-SDR: a0ybJhpkYB9fI/DvieGaBqm4W+TvVGPvFkWZDFDepm8MR+v0j5+34Fq6XINq4QM6UX8npCDLlm
 0ZahPQSKpI6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191767222"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; d="scan'208";a="191767222"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2021 19:21:15 -0700
IronPort-SDR: thY1xfMfCudyvHP/ptJA+h7xWnv+Pj6Sc/+E9k1g0KfRjBNmUTJC6nd5d0D8fbHgozlg0ZW1i9
 WziO4JM2DcYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; d="scan'208";a="444879565"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga002.fm.intel.com with ESMTP; 29 Mar 2021 19:21:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Report right snoop capability when using FL
 for IOVA
Date: Tue, 30 Mar 2021 10:11:45 +0800
Message-Id: <20210330021145.13824-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The Intel VT-d driver checks wrong register to report snoop capablility
when using first level page table for GPA to HPA translation. This might
lead the IOMMU driver to say that it supports snooping control, but in
reality, it does not. Fix this by always setting PASID-table-entry.PGSNP
whenever a pasid entry is setting up for GPA to HPA translation so that
the IOMMU driver could report snoop capability as long as it runs in the
scalable mode.

Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Suggested-by: Rajesh Sankaran <rajesh.sankaran@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  1 +
 drivers/iommu/intel/iommu.c | 11 ++++++++++-
 drivers/iommu/intel/pasid.c | 16 ++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 079534fcf55d..5ff61c3d401f 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -48,6 +48,7 @@
  */
 #define PASID_FLAG_SUPERVISOR_MODE	BIT(0)
 #define PASID_FLAG_NESTED		BIT(1)
+#define PASID_FLAG_PAGE_SNOOP		BIT(2)
 
 /*
  * The PASID_FLAG_FL5LP flag Indicates using 5-level paging for first-
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7354f9ce47d8..deaa87ad4e5f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -657,7 +657,14 @@ static int domain_update_iommu_snooping(struct intel_iommu *skip)
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
 		if (iommu != skip) {
-			if (!ecap_sc_support(iommu->ecap)) {
+			/*
+			 * If the hardware is operating in the scalable mode,
+			 * the snooping control is always supported since we
+			 * always set PASID-table-entry.PGSNP bit if the domain
+			 * is managed outside (UNMANAGED).
+			 */
+			if (!sm_supported(iommu) &&
+			    !ecap_sc_support(iommu->ecap)) {
 				ret = 0;
 				break;
 			}
@@ -2516,6 +2523,8 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 		flags |= PASID_FLAG_SUPERVISOR_MODE;
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
+	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+		flags |= PASID_FLAG_PAGE_SNOOP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
 					     domain->iommu_did[iommu->seq_id],
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c896aef7db40..b901909da79e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -425,6 +425,16 @@ static inline void pasid_set_page_snoop(struct pasid_entry *pe, bool value)
 	pasid_set_bits(&pe->val[1], 1 << 23, value << 23);
 }
 
+/*
+ * Setup the Page Snoop (PGSNP) field (Bit 88) of a scalable mode
+ * PASID entry.
+ */
+static inline void
+pasid_set_pgsnp(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[1], 1ULL << 24, 1ULL << 24);
+}
+
 /*
  * Setup the First Level Page table Pointer field (Bit 140~191)
  * of a scalable mode PASID entry.
@@ -599,6 +609,9 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		}
 	}
 
+	if (flags & PASID_FLAG_PAGE_SNOOP)
+		pasid_set_pgsnp(pte);
+
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
@@ -677,6 +690,9 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
+	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+		pasid_set_pgsnp(pte);
+
 	/*
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
