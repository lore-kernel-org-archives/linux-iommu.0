Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19942C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 01:09:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD49620758
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 01:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD49620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6321D874E3;
	Fri,  4 Sep 2020 01:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNuL6z6Pc6rl; Fri,  4 Sep 2020 01:08:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A1BC2874E0;
	Fri,  4 Sep 2020 01:08:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86BDFC07FF;
	Fri,  4 Sep 2020 01:08:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8905DC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 01:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6C7B32E180
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 01:08:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5-l4iOp7D3M for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 01:08:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id E1A6322843
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 01:08:55 +0000 (UTC)
IronPort-SDR: xMi6gl/g0NYw2Sd41vzFD+j4lcMEjGMYCPhN6rpx7Xh9gO1Te73LdEEfXbpVSnsZ9DMuNoh9lT
 F13g9mQ9fIDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="219233599"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="219233599"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 18:08:54 -0700
IronPort-SDR: Bq9VjQRLBTDcnDw7F07+auyRRqOT7U2CjBVl2t8fb3NONHNDq8VMRg1vWjzu6ptLDqhnMilfs5
 /HmoET/bj4Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; d="scan'208";a="326431226"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2020 18:08:52 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
Date: Fri,  4 Sep 2020 09:03:03 +0800
Message-Id: <20200904010303.2961-1-baolu.lu@linux.intel.com>
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
table, we could default to the device NUMA domain as fall back. This could
also benefit a vIOMMU use case where only single vIOMMU is exposed, hence
no RHSA will be present but device numa domain can be correct.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

Change log:
v1->v2:
  - Add a comment as suggested by Kevin.
    https://lore.kernel.org/linux-iommu/MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1645.namprd11.prod.outlook.com/

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7f844d1c8cd9..69d5a87188f4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -698,12 +698,47 @@ static int domain_update_iommu_superpage(struct dmar_domain *domain,
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
+		/*
+		 * There could possibly be multiple device numa nodes as devices
+		 * within the same domain may sit behind different IOMMUs. There
+		 * isn't perfect answer in such situation, so we select first
+		 * come first served policy.
+		 */
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
@@ -5096,8 +5131,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
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
