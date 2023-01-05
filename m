Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E280F
	for <iommu@lists.linux.dev>; Thu,  5 Jan 2023 08:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672906859; x=1704442859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ldOSn4RJNcTLaRtEAxrO/RtpGFwPKJQdNeOLTmCm9Kc=;
  b=nwVCNcQpovHiwbCDLXJ1B4iKJ9OBXRpKXaqpaQjKvPzUMcGVJjXTmdlq
   nnH2WFfvem2Vkb1KFrED3ryfY6kVSX3XMr7H9GQWsL5fVEWFZzIxtU0Py
   MRrvjOloVU3UFWlG9Y+ecvClBNkQzDShxaZfPRv0sG7XYSjwEvlGAbKuE
   w40h8dBE05RCx1rM/mSXydC5DI87mvFx9ekd+hLKMvJxrFUO7wmxtky+i
   yAGfNBnbHcanr6yRyk/kzJCO6rgCt6PM/dBzovadipNaRSCHq9TbMITDZ
   bAPdAacv5K40Mnxi1nmT5mpWT27R8EyXB29syWoMQ/TTXjszjm9RFHjSe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301843073"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="301843073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:20:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900848238"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="900848238"
Received: from icg-kernel3.bj.intel.com ([172.16.126.100])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2023 00:20:55 -0800
From: bingbu.cao@intel.com
To: linux-kernel@vger.kernel.org,
	stable.vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Cc: baolu.lu@linux.intel.com,
	senozhatsky@chromium.org,
	bingbu.cao@intel.com,
	bingbu.cao@linux.intel.com,
	sangram.k.y@intel.com
Subject: [RESEND PATCH v3] iommu/vt-d: Use passthrough mode for the Intel IPUs
Date: Thu,  5 Jan 2023 16:28:57 +0800
Message-Id: <20230105082857.4180299-1-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bingbu Cao <bingbu.cao@intel.com>

Intel IPU(Image Processing Unit) has its own (IO)MMU hardware,
The IPU driver allocates its own page table that is not mapped
via the DMA, and thus the Intel IOMMU driver blocks access giving
this error:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [00:05.0] PASID ffffffff
      fault addr 76406000 [fault reason 06] PTE Read access is not set

As IPU is not an external facing device which is not risky, so use
IOMMU passthrough mode for Intel IPUs.

Fixes: 26f5689592e2 ("media: staging/intel-ipu3: mmu: Implement driver")
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 drivers/iommu/intel/iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 59df7e42fd53..b9097ef5b8a6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -37,6 +37,15 @@
 #define IS_GFX_DEVICE(pdev) ((pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY)
 #define IS_USB_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_SERIAL_USB)
 #define IS_ISA_DEVICE(pdev) ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
+#define IS_INTEL_IPU(pdev) ((pdev)->vendor == PCI_VENDOR_ID_INTEL &&	\
+			    ((pdev)->device == 0x9a19 ||		\
+			     (pdev)->device == 0x9a39 ||		\
+			     (pdev)->device == 0x4e19 ||		\
+			     (pdev)->device == 0x465d ||		\
+			     (pdev)->device == 0x462e ||		\
+			     (pdev)->device == 0xa75d ||		\
+			     (pdev)->device == 0x7d19 ||		\
+			     (pdev)->device == 0x1919))
 #define IS_AZALIA(pdev) ((pdev)->vendor == 0x8086 && (pdev)->device == 0x3a3e)
 
 #define IOAPIC_RANGE_START	(0xfee00000)
@@ -287,12 +296,14 @@ int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
 
 static int dmar_map_gfx = 1;
+static int dmar_map_ipu = 1;
 static int intel_iommu_superpage = 1;
 static int iommu_identity_mapping;
 static int iommu_skip_te_disable;
 
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
+#define IDENTMAP_IPU		8
 
 const struct iommu_ops intel_iommu_ops;
 
@@ -2584,6 +2595,9 @@ static int device_def_domain_type(struct device *dev)
 
 		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
 			return IOMMU_DOMAIN_IDENTITY;
+
+		if ((iommu_identity_mapping & IDENTMAP_IPU) && IS_INTEL_IPU(pdev))
+			return IOMMU_DOMAIN_IDENTITY;
 	}
 
 	return 0;
@@ -2973,6 +2987,9 @@ static int __init init_dmars(void)
 	if (!dmar_map_gfx)
 		iommu_identity_mapping |= IDENTMAP_GFX;
 
+	if (!dmar_map_ipu)
+		iommu_identity_mapping |= IDENTMAP_IPU;
+
 	check_tylersburg_isoch();
 
 	ret = si_domain_init(hw_pass_through);
@@ -4799,6 +4816,18 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 	dmar_map_gfx = 0;
 }
 
+static void quirk_iommu_ipu(struct pci_dev *dev)
+{
+	if (!IS_INTEL_IPU(dev))
+		return;
+
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
@@ -4834,6 +4863,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1632, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163A, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
 
+/* make IPU dmar use identity mapping */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_ANY_ID, quirk_iommu_ipu);
+
 static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
 	if (risky_device(dev))
-- 
2.39.0

