Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B84C4363D
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 06:15:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F4E23A9B
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 06:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F4E23A9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 32A9B858B5;
	Tue, 22 Sep 2020 06:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X5oJ2wVuuUme; Tue, 22 Sep 2020 06:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9243484E77;
	Tue, 22 Sep 2020 06:15:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75357C0859;
	Tue, 22 Sep 2020 06:15:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04560C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F19EC21543
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hjG5v7Lsmce0 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:14:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 785312226B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 06:14:57 +0000 (UTC)
IronPort-SDR: 1IfZIy+NsacAYpnwJbDJqXSFRj3MQ3REfRqgHb6kB2eJvk52S/gD57QgD9+/+6ZojL+rmIHWlU
 OBHFiVSnneXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="160609885"
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="160609885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 23:14:56 -0700
IronPort-SDR: hNVSZ8xexEfzzKyelh6xRtrSAPwv9XB8PNEV7qPfe2B3D0Ry3nHBKAXSRYfDhh7bXslKEyTYR1
 F73IpZmr+V+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; d="scan'208";a="334876348"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 23:14:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
Date: Tue, 22 Sep 2020 14:08:43 +0800
Message-Id: <20200922060843.31546-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922060843.31546-1-baolu.lu@linux.intel.com>
References: <20200922060843.31546-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
table, we could default to the device NUMA domain as fall back.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20200904010303.2961-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 87b17bac04c2..1b7d390beb68 100644
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
@@ -5095,8 +5130,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
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
