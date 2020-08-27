Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCA1C433DF
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 06:02:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF2C20786
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 06:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF2C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 52144204C8;
	Thu, 27 Aug 2020 06:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ic0YKsBkuXg2; Thu, 27 Aug 2020 06:02:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E4FD6203E2;
	Thu, 27 Aug 2020 06:02:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0DB7C0890;
	Thu, 27 Aug 2020 06:02:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B37C016F
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 06:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B75F888046
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 06:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QUCcO19abRbx for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 06:02:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E44B387E7B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 06:02:37 +0000 (UTC)
IronPort-SDR: tJRCoCznnYnHZx4VRLunMvrGinKR+buBdgbKTlM9okvPVcvzr97Q4BU6Pj4T4gvaqxpA4VXRt2
 w/1u2v2OU7jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="135976238"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; d="scan'208";a="135976238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2020 23:02:28 -0700
IronPort-SDR: g458IpR5q5Fk5w4SrGst7CMiEYyAC/8cVA3zQox3Z5s+/Q4cI2JgieD4dwA5Qt1ej3VyCAJgtN
 EXdHjEoePllQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; d="scan'208";a="403302698"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 23:02:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
Date: Thu, 27 Aug 2020 13:56:40 +0800
Message-Id: <20200827055640.31408-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
table, we could default to the device NUMA domain as fall back. This also
benefits the vIOMMU use case where only a single vIOMMU is exposed, hence
no RHSA will be present but device numa domain can be correct.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e0516d64d7a3..bce158468abf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -700,12 +700,41 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
 	return fls(mask);
 }
 
+static int domain_update_device_node(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	int nid = NUMA_NO_NODE;
+
+	assert_spin_locked(&device_domain_lock);
+
+	if (list_empty(&domain->devices))
+		return NUMA_NO_NODE;
+
+	list_for_each_entry(info, &domain->devices, link) {
+		if (!info->dev)
+			continue;
+
+		nid = dev_to_node(info->dev);
+		if (nid != NUMA_NO_NODE)
+			break;
+	}
+
+	return nid;
+}
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
 	domain_update_iommu_coherency(domain);
 	domain->iommu_snooping = domain_update_iommu_snooping(NULL);
 	domain->iommu_superpage = domain_update_iommu_superpage(domain, NULL);
+
+	/*
+	 * If RHSA is missing, we should default to the device numa domain
+	 * as fall back.
+	 */
+	if (domain->nid == NUMA_NO_NODE)
+		domain->nid = domain_update_device_node(domain);
 }
 
 struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
@@ -5086,8 +5115,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		if (type == IOMMU_DOMAIN_DMA)
 			intel_init_iova_domain(dmar_domain);
 
-		domain_update_iommu_cap(dmar_domain);
-
 		domain = &dmar_domain->domain;
 		domain->geometry.aperture_start = 0;
 		domain->geometry.aperture_end   =
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
