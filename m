Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7629EC43460
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 07:05:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189FF61289
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 07:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189FF61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1B41404E2;
	Wed, 12 May 2021 07:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uc-wV3j43K4g; Wed, 12 May 2021 07:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A3D5404DE;
	Wed, 12 May 2021 07:05:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5511AC000D;
	Wed, 12 May 2021 07:05:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBF7CC0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 07:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDCCC83B47
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 07:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYgImdLwNpu2 for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 07:05:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0E5B83B07
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 07:05:17 +0000 (UTC)
IronPort-SDR: LVMsGmxjJEN0K7SgaGlY+og92XCuxEytSktNceRteVzdUWW4T1MJr/x2IIJQfZx6EfKEiGTz/1
 suRG5Udv3AVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199685230"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="199685230"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 00:05:16 -0700
IronPort-SDR: xNTaDUQC4qr8uwbmMVTq+jb6mwNY80ju4g1kFNfVCI+VvbMlpGq8fSsxYfdjzXmv0lAeRt2xT7
 DRfkbUk2DBCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="455448336"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 12 May 2021 00:05:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested capabilities
Date: Wed, 12 May 2021 15:04:21 +0800
Message-Id: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com
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

Current VT-d implementation supports nested translation only if all
underlying IOMMUs support the nested capability. This is unnecessary
as the upper layer is allowed to create different containers and set
them with different type of iommu backend. The IOMMU driver needs to
guarantee that devices attached to a nested mode iommu_domain should
support nested capabilility.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f1742da42478..1cd4840e6f9f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4755,6 +4755,13 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
+	    !ecap_nest(iommu->ecap)) {
+		dev_err(dev, "%s: iommu not support nested translation\n",
+			iommu->name);
+		return -EINVAL;
+	}
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
@@ -5451,11 +5458,21 @@ static int
 intel_iommu_enable_nesting(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool has_nesting = false;
 	unsigned long flags;
-	int ret = -ENODEV;
+	int ret = -EINVAL;
+
+	for_each_active_iommu(iommu, drhd)
+		if (ecap_nest(iommu->ecap))
+			has_nesting = true;
+
+	if (!has_nesting)
+		return -ENODEV;
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	if (nested_mode_support() && list_empty(&dmar_domain->devices)) {
+	if (list_empty(&dmar_domain->devices)) {
 		dmar_domain->flags |= DOMAIN_FLAG_NESTING_MODE;
 		dmar_domain->flags &= ~DOMAIN_FLAG_USE_FIRST_LEVEL;
 		ret = 0;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
