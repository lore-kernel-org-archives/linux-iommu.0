Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF76C433FE
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 03:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2477983134;
	Fri, 11 Feb 2022 03:07:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkK27mDv17c5; Fri, 11 Feb 2022 03:07:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F3448315C;
	Fri, 11 Feb 2022 03:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE295C0011;
	Fri, 11 Feb 2022 03:07:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B388C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76E6A83168
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M2LUDffjL6vG for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 03:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0235283123
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644548818; x=1676084818;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EkJfB7vhORyeNDzWL4R0G1atL9YTI01FB+mAIw3VUYg=;
 b=DebwYDIOgdpy1g+PFBf2xUOKhnNqGo0ht7iuo5P5XxyYxY4BRGdmyuOD
 7poi9vBbwOh41J+zA8nYHpZYK8v9nO5RYwEkhghYJuCWySOi5RJ4ntahs
 NWMC6/XByVB4MQjdmWUePHahRhdwv8AdnBDpiRfshnv82diompu2tDbs6
 jt78dhjSOUs212yZYBhlAq9Z4d9bFf/5nYSGbMt2myfL4MxXbPyDVUsAs
 dF3O5RdNut0kuUIfTnLYcHislXCqcQ2wdiSHqGrXQ5hCq2ff2JRQrWj3t
 n4aShkzjEQ1Fq9nvahKbumH8VjwWTet662tUoBn06WzRzLMUZYIDqXyYr w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="274202604"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="274202604"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 19:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="483062861"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 19:06:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Chris Wilson <chris@chris-wilson.co.uk>,
 Nathan Myers <ncm@cantrip.org>
Subject: [PATCH 2/2] iommu/vt-d: Remove unnecessary exported symbol
Date: Fri, 11 Feb 2022 11:05:31 +0800
Message-Id: <20220211030531.2398789-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
References: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

The exported symbol intel_iommu_gfx_mapped is not used anywhere in the
tree. Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h | 1 -
 drivers/iommu/intel/iommu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2f8a4517c929..b8b8be58cb6b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -789,7 +789,6 @@ extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
-extern int intel_iommu_gfx_mapped;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4b06f2f365bd..88a53140c7f1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -311,9 +311,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-int intel_iommu_gfx_mapped;
-EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
-
 static DEFINE_XARRAY_ALLOC(device_domain_array);
 
 /* Convert device source ID into the index of device_domain_array. */
@@ -4070,9 +4067,6 @@ int __init intel_iommu_init(void)
 	if (list_empty(&dmar_satc_units))
 		pr_info("No SATC found\n");
 
-	if (dmar_map_gfx)
-		intel_iommu_gfx_mapped = 1;
-
 	init_no_remapping_devices();
 
 	ret = init_dmars();
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
