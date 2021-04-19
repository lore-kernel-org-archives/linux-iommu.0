Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC622C43600
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 07:07:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5042361165
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 07:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5042361165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12DAF83653;
	Mon, 19 Apr 2021 07:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dDgnDNvUsgZQ; Mon, 19 Apr 2021 07:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C624C836C3;
	Mon, 19 Apr 2021 07:07:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C543C0024;
	Mon, 19 Apr 2021 07:07:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31774C000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1341E82D49
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBXNlEOsUcI8 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 05:04:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E6E6A8247F
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:04:09 +0000 (UTC)
IronPort-SDR: Un3qZUhhAA1AE0wxO3RY1FH0sQvVzKZvJTVHXdS4vWg8vGRqsKZO0r+4HU3f75pfq+OnD4gnht
 hKwyWX5xLTWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174757667"
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; d="scan'208";a="174757667"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2021 22:04:09 -0700
IronPort-SDR: rkZj+7hpAC8/mdIwqVQn6To9VCOggQ+nIpMBxtXDzNt0u6AIaYQ1nRC+efjUqWKyjFqLK045kP
 CZMBbEOccwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,233,1613462400"; d="scan'208";a="426366037"
Received: from ipu5-build.bj.intel.com ([10.238.232.202])
 by orsmga008.jf.intel.com with ESMTP; 18 Apr 2021 22:04:04 -0700
From: Bingbu Cao <bingbu.cao@intel.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: Use passthrough mode for the Intel IPUs
Date: Mon, 19 Apr 2021 12:57:05 +0800
Message-Id: <1618808225-10108-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Mon, 19 Apr 2021 07:07:20 +0000
Cc: andriy.shevchenko@linux.intel.com, grundler@chromium.org,
 dwmw2@infradead.org, senozhatsky@chromium.org, bhelgaas@google.com,
 bingbu.cao@intel.com, rajatja@google.com, will@kernel.org,
 bingbu.cao@linux.intel.com
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

Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
The IPU driver allocates its own page table that is not mapped
via the DMA, and thus the Intel IOMMU driver blocks access giving
this error:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
      fault addr 76406000 [fault reason 06] PTE Read access is not set

As IPU is not an external facing device which is not risky, so use
IOMMU passthrough mode for Intel IPUs.

Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/iommu/intel/iommu.c       | 35 +++++++++++++++++++++++++++++++++++
 drivers/staging/media/ipu3/ipu3.c |  2 +-
 include/linux/pci_ids.h           |  5 +++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ee0932307d64..59222d2fe73f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -55,6 +55,12 @@
 #define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
 #define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
+#define IS_IPU_DEVICE(pdev) ((pdev)->vendor == PCI_VENDOR_ID_INTEL &&		\
+			     ((pdev)->device == PCI_DEVICE_ID_INTEL_IPU3 ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6 ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6SE ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6SE_P ||	\
+			     (pdev)->device == PCI_DEVICE_ID_INTEL_IPU6EP))
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
 #define IOAPIC_RANGE_START	(0xfee00000)
@@ -360,6 +366,7 @@ int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
 static int dmar_map_gfx = 1;
+static int dmar_map_ipu = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
@@ -368,6 +375,7 @@ static int iommu_skip_te_disable;
 
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
+#define IDENTMAP_IPU		8
 
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
@@ -2839,6 +2847,9 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
+
+		if ((iommu_identity_mapping & IDENTMAP_IPU) && IS_IPU_DEVICE(pdev))
+			return IOMMU_DOMAIN_IDENTITY;
 	}
 
 	return 0;
@@ -3278,6 +3289,9 @@ static int __init init_dmars(void)
 	if (!dmar_map_gfx)
 		iommu_identity_mapping |= IDENTMAP_GFX;
 
+	if (!dmar_map_ipu)
+		iommu_identity_mapping |= IDENTMAP_IPU;
+
 	check_tylersburg_isoch();
 
 	ret = si_domain_init(hw_pass_through);
@@ -5622,6 +5636,15 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 	dmar_map_gfx = 0;
 }
 
+static void quirk_iommu_ipu(struct pci_dev *dev)
+{
+	if (risky_device(dev))
+		return;
+
+	pci_info(dev, "Passthrough IOMMU for integrated Intel IPU\n");
+	dmar_map_ipu = 0;
+}
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);
@@ -5657,6 +5680,18 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1632, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163A, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
+/* disable IPU dmar support */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU3,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6EP,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6SE_P,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6,
+			 quirk_iommu_ipu);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IPU6SE,
+			 quirk_iommu_ipu);
+
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
 	if (risky_device(dev))
diff --git a/drivers/staging/media/ipu3/ipu3.c b/drivers/staging/media/ipu3/ipu3.c
index ee1bba6bdcac..aee1130ac042 100644
--- a/drivers/staging/media/ipu3/ipu3.c
+++ b/drivers/staging/media/ipu3/ipu3.c
@@ -16,7 +16,7 @@
 #include "ipu3-dmamap.h"
 #include "ipu3-mmu.h"
 
-#define IMGU_PCI_ID			0x1919
+#define IMGU_PCI_ID			PCI_DEVICE_ID_INTEL_IPU3
 #define IMGU_PCI_BAR			0
 #define IMGU_DMA_MASK			DMA_BIT_MASK(39)
 #define IMGU_MAX_QUEUE_DEPTH		(2 + 2)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a76ccb697bef..951315892608 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2716,6 +2716,7 @@
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE  0x1576
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577
 #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_BRIDGE  0x1578
+#define PCI_DEVICE_ID_INTEL_IPU3	0x1919
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_QAT_C3XXX	0x19e2
 #define PCI_DEVICE_ID_INTEL_QAT_C3XXX_VF	0x19e3
@@ -2982,6 +2983,8 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
+#define PCI_DEVICE_ID_INTEL_IPU6EP	0x465d
+#define PCI_DEVICE_ID_INTEL_IPU6SE_P	0x4e19
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
@@ -3032,6 +3035,8 @@
 #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
 #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
 #define PCI_DEVICE_ID_INTEL_VMD_9A0B	0x9a0b
+#define PCI_DEVICE_ID_INTEL_IPU6	0x9a19
+#define PCI_DEVICE_ID_INTEL_IPU6SE	0x9a39
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 
 #define PCI_VENDOR_ID_SCALEMP		0x8686
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
