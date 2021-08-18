Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15FCC432BE
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:51:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8918F61058
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 13:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8918F61058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5ACC960701;
	Wed, 18 Aug 2021 13:51:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1GzFRO6saXY; Wed, 18 Aug 2021 13:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8BD5F605F7;
	Wed, 18 Aug 2021 13:51:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76700C001A;
	Wed, 18 Aug 2021 13:51:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86A2BC000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 695CB402DF
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WWB9BAlmtqEm for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 13:51:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A22B402C6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 13:51:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="214478856"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="214478856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 06:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="449729224"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2021 06:51:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/9] iommu/vt-d: Refactor Kconfig a bit
Date: Wed, 18 Aug 2021 21:48:46 +0800
Message-Id: <20210818134852.1847070-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
References: <20210818134852.1847070-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, iommu@lists.linux-foundation.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Put all sub-options inside a "if INTEL_IOMMU" so that they don't need to
always depend on INTEL_IOMMU. Use IS_ENABLED() instead of #ifdef as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210720013856.4143880-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 13 ++-----------
 drivers/iommu/intel/Kconfig | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 36ce79c55766..acb91ddf32d0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -327,17 +327,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova);
 
-#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
-int dmar_disabled = 0;
-#else
-int dmar_disabled = 1;
-#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
-
-#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
-int intel_iommu_sm = 1;
-#else
-int intel_iommu_sm;
-#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
+int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
+int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 43ebd8af11c5..c1a92c3049d0 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -25,9 +25,11 @@ config INTEL_IOMMU
 	  and include PCI device scope covered by these DMA
 	  remapping devices.
 
+if INTEL_IOMMU
+
 config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
-	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+	depends on IOMMU_DEBUGFS
 	select DMAR_PERF
 	help
 	  !!!WARNING!!!
@@ -41,7 +43,7 @@ config INTEL_IOMMU_DEBUGFS
 
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
-	depends on INTEL_IOMMU && X86_64
+	depends on X86_64
 	select PCI_PASID
 	select PCI_PRI
 	select MMU_NOTIFIER
@@ -53,9 +55,8 @@ config INTEL_IOMMU_SVM
 	  means of a Process Address Space ID (PASID).
 
 config INTEL_IOMMU_DEFAULT_ON
-	def_bool y
-	prompt "Enable Intel DMA Remapping Devices by default"
-	depends on INTEL_IOMMU
+	bool "Enable Intel DMA Remapping Devices by default"
+	default y
 	help
 	  Selecting this option will enable a DMAR device at boot time if
 	  one is found. If this option is not selected, DMAR support can
@@ -63,7 +64,7 @@ config INTEL_IOMMU_DEFAULT_ON
 
 config INTEL_IOMMU_BROKEN_GFX_WA
 	bool "Workaround broken graphics drivers (going away soon)"
-	depends on INTEL_IOMMU && BROKEN && X86
+	depends on BROKEN && X86
 	help
 	  Current Graphics drivers tend to use physical address
 	  for DMA and avoid using DMA APIs. Setting this config
@@ -74,7 +75,7 @@ config INTEL_IOMMU_BROKEN_GFX_WA
 
 config INTEL_IOMMU_FLOPPY_WA
 	def_bool y
-	depends on INTEL_IOMMU && X86
+	depends on X86
 	help
 	  Floppy disk drivers are known to bypass DMA API calls
 	  thereby failing to work when IOMMU is enabled. This
@@ -83,7 +84,6 @@ config INTEL_IOMMU_FLOPPY_WA
 
 config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	bool "Enable Intel IOMMU scalable mode by default"
-	depends on INTEL_IOMMU
 	help
 	  Selecting this option will enable by default the scalable mode if
 	  hardware presents the capability. The scalable mode is defined in
@@ -92,3 +92,5 @@ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	  is not selected, scalable mode support could also be enabled by
 	  passing intel_iommu=sm_on to the kernel. If not sure, please use
 	  the default value.
+
+endif # INTEL_IOMMU
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
