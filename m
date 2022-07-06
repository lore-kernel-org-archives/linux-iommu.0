Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF29CCA47F
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 03:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0F8B83312;
	Wed,  6 Jul 2022 02:59:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0F8B83312
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WiK35u5w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHAiqynXudKq; Wed,  6 Jul 2022 02:59:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9CD8D832E7;
	Wed,  6 Jul 2022 02:59:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CD8D832E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E89FC0071;
	Wed,  6 Jul 2022 02:59:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E204C007F
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AF64405BA
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AF64405BA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WiK35u5w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oyZXjDTsMGNs for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 02:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E3A5402E8
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E3A5402E8
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 02:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657076396; x=1688612396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hkGm7YDPu5xil+VGf8bn6+rNMEI6Bw40A3ib6a6DFDY=;
 b=WiK35u5weMHc1cTY1s6U9peoIsqMY1oNvwRd6eu7bwMR8CiHn0McM8K8
 0QiHJW2hKwQbtoOJ46hdVKwyzeYZXHEicLQ/Tuxk49ZEuGqLcilDQaQuY
 sZ/okp3CmDd9dsp0HBbcSwT3ejwCPsPLEXMUfpgdbJ21n5ceiZ0Y4ZKAK
 fr3AfNG6T1FzJHrctLKs2/3aYHpimt50DXoNw+u4qDT8S/0rLX+GkK3iq
 t3p3iDnVEQ6/S2hGV57YY7HRyh0nyuDeJo5qX24VjEVhxF3hWehpHnx/6
 3huoxA7sU5syVkSH/045cpCr4kL24TWMgGA3KM6UfnnZyNr1VKG+oPiqQ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409531"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="272409531"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 19:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="567874772"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 19:59:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Date: Wed,  6 Jul 2022 10:55:15 +0800
Message-Id: <20220706025524.2904370-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

The disable_dmar_iommu() is called when IOMMU initialization fails or
the IOMMU is hot-removed from the system. In both cases, there is no
need to clear the IOMMU translation data structures for devices.

On the initialization path, the device probing only happens after the
IOMMU is initialized successfully, hence there're no translation data
structures.

On the hot-remove path, there is no real use case where the IOMMU is
hot-removed, but the devices that it manages are still alive in the
system. The translation data structures were torn down during device
release, hence there's no need to repeat it in IOMMU hot-remove path
either. This removes the unnecessary code and only leaves a check.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h |  1 +
 drivers/iommu/intel/iommu.c | 21 +++++++--------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index bf5b937848b4..20c54e50f533 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -39,6 +39,7 @@
  * only and pass-through transfer modes.
  */
 #define FLPT_DEFAULT_DID		1
+#define NUM_RESERVED_DID		2
 
 /*
  * The SUPERVISOR_MODE flag indicates a first level translation which
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3b6571681bdd..43aaec5bdd84 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1716,23 +1716,16 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
 	if (!iommu->domain_ids)
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
-		if (info->iommu != iommu)
-			continue;
-
-		if (!info->dev || !info->domain)
-			continue;
-
-		__dmar_remove_one_dev_info(info);
-	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
+	/*
+	 * All iommu domains must have been detached from the devices,
+	 * hence there should be no domain IDs in use.
+	 */
+	if (WARN_ON(bitmap_weight(iommu->domain_ids, cap_ndoms(iommu->cap))
+		    > NUM_RESERVED_DID))
+		return;
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
