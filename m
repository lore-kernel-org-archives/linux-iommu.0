Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44DBCCA47C
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 07:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8813A82894;
	Wed, 29 Jun 2022 07:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8813A82894
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ijr7Jg3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpCKSdp3-nnS; Wed, 29 Jun 2022 07:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5FAAA826A8;
	Wed, 29 Jun 2022 07:51:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FAAA826A8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49AB9C0039;
	Wed, 29 Jun 2022 07:51:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9256DC002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6778C416CD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6778C416CD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Ijr7Jg3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hXBx7TJQSDwP for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 07:51:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68C97409A2
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68C97409A2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656489116; x=1688025116;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hkGm7YDPu5xil+VGf8bn6+rNMEI6Bw40A3ib6a6DFDY=;
 b=Ijr7Jg3BrD3Sb0WiVl9c2J+tp40WyAJD3zFc7OUh8e5FEzneSVVzNSgB
 vVXtmLZEJxwji5D46FgFY4rot3AOzm6sVfjICD5SCwpOCf4MXgFqwK3ft
 K/wHVuwPNQaBb+L2ebpyLPI2NIV52Z6PPsBEQPUMT94N2IuJvj0wICuwc
 XtslxF0BouNO8DlZ6rE2n46m51MBXXMSL8gvVciepvetUD34neEEFfmEB
 2pwrB+9tjeTYD3L7LdSy9bHrlaZMLcH9lQOz7CvtQrDn11+AISh2lejXR
 r5xd1vxzIV0m5+kx5Q3yMUjvZJb5e+8n9BvA9oB9Hc16PHlthEDzZ95x5 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="262362917"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="262362917"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2022 00:51:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; d="scan'208";a="588209588"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:51:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v3 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Date: Wed, 29 Jun 2022 15:47:16 +0800
Message-Id: <20220629074725.2331441-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
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
