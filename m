Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B942231F
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297483; cv=none; b=gBzj1EA2vicRdJPO8dDOYtjZoo8n6xLie5z9hHocUpt1VC7IvHombk/qH5aHiRUO0feBUHinsVHeCopABovtYmf1yN4addVrQHYwSBp0VX42sPOlgAAZm+PNwZBEg0A+At1wI6SnrGAv5xCjiSdCouJOLrrPYgSQ8nUVt52g15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297483; c=relaxed/simple;
	bh=xxqwmCtdSOQ8HwhQdcaUMV68d83/A1sp/EE2WLfT7EY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Do1SNRmeU7zFaZlVDZqtLftsD5YUd3z0IHrcX735rQwRurxdQwMtaDTmPcrWOS44g4iOVW9hVuUg9BHwKRBeAuorKJG6wd7//nzRj1Uvgdct/j+GtZC0fQ8RXK9nBYWRq0z+y9BhzaYsTe+T/oguzZ7zggqBi3IcTWoI7Ltep5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2FRDo8z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2FRDo8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707297482; x=1738833482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xxqwmCtdSOQ8HwhQdcaUMV68d83/A1sp/EE2WLfT7EY=;
  b=P2FRDo8z8F1Bl4a+JLT2JXIHX8LVdewA9lodqQgiymo6VIT2B2S5Gibf
   CWnD/SfKzR5J8E44w9zlYheMZoMQexExOlqP1Q+f8LfIDJOekPYaUPU2C
   cdkaIqqbN5gdoQ+MxX5L692gt4tBqoQfiIDGFBadmfzr8wd5ZHajd8qXD
   6iR+uLPpb0TSL/9wKtTwCtlIq1EE2rX1n3KYRUxKSedyfLx/aaKbC5wdE
   sIvtT04e4v0zqFYJtmCR3KYNcbn4xxE3zi60D3EnGv1lOFxxlhcwx9+9u
   2R9hgNIMkASAayVz6Y7hvuods+E3qtqD414VMpkUgqgyqRLF8OIMFRzjZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1102852"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1102852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 01:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="38701838"
Received: from cascade.sh.intel.com ([10.239.48.35])
  by orviesa001.jf.intel.com with ESMTP; 07 Feb 2024 01:17:58 -0800
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PACTH v3] Documentation: iommu/vt-d: Add the document for Intel IOMMU debugfs
Date: Wed,  7 Feb 2024 17:07:42 +0800
Message-Id: <20240207090742.23857-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This document guides users to dump the Intel IOMMU internals by debugfs.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
Change log:
 v3:
  - Add this change log per Baolu's comments.
 v2: http://lore.kernel.org/lkml/20240126064704.14292-1-Jingqi.liu@intel.com
  - Remove the use of private data field according to VT-d specification
    changes in v4.0.
 v1: http://lore.kernel.org/lkml/20231220132519.11077-1-Jingqi.liu@intel.com
---
 Documentation/ABI/testing/debugfs-intel-iommu | 276 ++++++++++++++++++
 1 file changed, 276 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-intel-iommu

diff --git a/Documentation/ABI/testing/debugfs-intel-iommu b/Documentation/ABI/testing/debugfs-intel-iommu
new file mode 100644
index 000000000000..2ab8464504a9
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-intel-iommu
@@ -0,0 +1,276 @@
+What:		/sys/kernel/debug/iommu/intel/iommu_regset
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps all the register contents for each IOMMU device.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/iommu_regset
+
+		 IOMMU: dmar0 Register Base Address: 26be37000
+
+		 Name                    Offset          Contents
+		 VER                     0x00            0x0000000000000010
+		 GCMD                    0x18            0x0000000000000000
+		 GSTS                    0x1c            0x00000000c7000000
+		 FSTS                    0x34            0x0000000000000000
+		 FECTL                   0x38            0x0000000000000000
+
+		 [...]
+
+		 IOMMU: dmar1 Register Base Address: fed90000
+
+		 Name                    Offset          Contents
+		 VER                     0x00            0x0000000000000010
+		 GCMD                    0x18            0x0000000000000000
+		 GSTS                    0x1c            0x00000000c7000000
+		 FSTS                    0x34            0x0000000000000000
+		 FECTL                   0x38            0x0000000000000000
+
+		 [...]
+
+		 IOMMU: dmar2 Register Base Address: fed91000
+
+		 Name                    Offset          Contents
+		 VER                     0x00            0x0000000000000010
+		 GCMD                    0x18            0x0000000000000000
+		 GSTS                    0x1c            0x00000000c7000000
+		 FSTS                    0x34            0x0000000000000000
+		 FECTL                   0x38            0x0000000000000000
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/ir_translation_struct
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps the table entries for Interrupt
+		remapping and Interrupt posting.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/ir_translation_struct
+
+		 Remapped Interrupt supported on IOMMU: dmar0
+		 IR table address:100900000
+
+		 Entry SrcID   DstID    Vct IRTE_high           IRTE_low
+		 0     00:0a.0 00000080 24  0000000000040050    000000800024000d
+		 1     00:0a.0 00000001 ef  0000000000040050    0000000100ef000d
+
+		 Remapped Interrupt supported on IOMMU: dmar1
+		 IR table address:100300000
+		 Entry SrcID   DstID    Vct IRTE_high           IRTE_low
+		 0     00:02.0 00000002 26  0000000000040010    000000020026000d
+
+		 [...]
+
+		 ****
+
+		 Posted Interrupt supported on IOMMU: dmar0
+		 IR table address:100900000
+		 Entry SrcID   PDA_high PDA_low  Vct IRTE_high          IRTE_low
+
+What:		/sys/kernel/debug/iommu/intel/dmar_translation_struct
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps Intel IOMMU DMA remapping tables, such
+		as root table, context table, PASID directory and PASID
+		table entries in debugfs. For legacy mode, it doesn't
+		support PASID, and hence PASID field is defaulted to
+		'-1' and other PASID related fields are invalid.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/dmar_translation_struct
+
+		 IOMMU dmar1: Root Table Address: 0x103027000
+		 B.D.F   Root_entry
+		 00:02.0 0x0000000000000000:0x000000010303e001
+
+		 Context_entry
+		 0x0000000000000102:0x000000010303f005
+
+		 PASID   PASID_table_entry
+		 -1      0x0000000000000000:0x0000000000000000:0x0000000000000000
+
+		 IOMMU dmar0: Root Table Address: 0x103028000
+		 B.D.F   Root_entry
+		 00:0a.0 0x0000000000000000:0x00000001038a7001
+
+		 Context_entry
+		 0x0000000000000000:0x0000000103220e7d
+
+		 PASID   PASID_table_entry
+		 0       0x0000000000000000:0x0000000000800002:0x00000001038a5089
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/invalidation_queue
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file exports invalidation queue internals of each
+		IOMMU device.
+
+		Example in Kabylake:
+
+		::
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
+
+		 Invalidation queue on IOMMU: dmar0
+		 Base: 0x10022e000      Head: 20        Tail: 20
+		 Index          qw0                    qw1                     qw2
+		     0   0000000000000014        0000000000000000        0000000000000000
+		     1   0000000200000025        0000000100059c04        0000000000000000
+		     2   0000000000000014        0000000000000000        0000000000000000
+
+				qw3                  status
+			 0000000000000000        0000000000000000
+			 0000000000000000        0000000000000000
+			 0000000000000000        0000000000000000
+
+		 [...]
+
+		 Invalidation queue on IOMMU: dmar1
+		 Base: 0x10026e000      Head: 32        Tail: 32
+		 Index           qw0                     qw1                   status
+		     0   0000000000000004        0000000000000000         0000000000000000
+		     1   0000000200000025        0000000100059804         0000000000000000
+		     2   0000000000000011        0000000000000000         0000000000000000
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/dmar_perf_latency
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file is used to control and show counts of
+		execution time ranges for various types per DMAR.
+
+		Firstly, write a value to
+		/sys/kernel/debug/iommu/intel/dmar_perf_latency
+		to enable sampling.
+
+		The possible values are as follows:
+
+		* 0 - disable sampling all latency data
+
+		* 1 - enable sampling IOTLB invalidation latency data
+
+		* 2 - enable sampling devTLB invalidation latency data
+
+		* 3 - enable sampling intr entry cache invalidation latency data
+
+		Next, read /sys/kernel/debug/iommu/intel/dmar_perf_latency gives
+		a snapshot of sampling result of all enabled monitors.
+
+		Examples in Kabylake:
+
+		::
+
+		 1) Disable sampling all latency data:
+
+		 $ sudo echo 0 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 2) Enable sampling IOTLB invalidation latency data
+
+		 $ sudo echo 1 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 IOMMU: dmar0 Register Base Address: 26be37000
+				 <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms
+		 inv_iotlb           0           0           0           0           0
+
+				 1ms-10ms      >=10ms     min(us)     max(us) average(us)
+		 inv_iotlb           0           0           0           0           0
+
+		 [...]
+
+		 IOMMU: dmar2 Register Base Address: fed91000
+				 <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms
+		 inv_iotlb           0           0          18           0           0
+
+				 1ms-10ms      >=10ms     min(us)     max(us) average(us)
+		 inv_iotlb           0           0           2           2           2
+
+		 3) Enable sampling devTLB invalidation latency data
+
+		 $ sudo echo 2 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
+
+		 IOMMU: dmar0 Register Base Address: 26be37000
+				 <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms
+		 inv_devtlb           0           0           0           0           0
+
+				 >=10ms     min(us)     max(us) average(us)
+		 inv_devtlb           0           0           0           0
+
+		 [...]
+
+What:		/sys/kernel/debug/iommu/intel/<bdf>/domain_translation_struct
+Date:		December 2023
+Contact:	Jingqi Liu <Jingqi.liu@intel.com>
+Description:
+		This file dumps a specified page table of Intel IOMMU
+		in legacy mode or scalable mode.
+
+		For a device that only supports legacy mode, dump its
+		page table by the debugfs file in the debugfs device
+		directory. e.g.
+		/sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct.
+
+		For a device that supports scalable mode, dump the
+		page table of specified pasid by the debugfs file in
+		the debugfs pasid directory. e.g.
+		/sys/kernel/debug/iommu/intel/0000:00:02.0/1/domain_translation_struct.
+
+		Examples in Kabylake:
+
+		::
+
+		 1) Dump the page table of device "0000:00:02.0" that only supports legacy mode.
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/0000:00:02.0/domain_translation_struct
+
+		 Device 0000:00:02.0 @0x1017f8000
+		 IOVA_PFN                PML5E                   PML4E
+		 0x000000008d800 |       0x0000000000000000      0x00000001017f9003
+		 0x000000008d801 |       0x0000000000000000      0x00000001017f9003
+		 0x000000008d802 |       0x0000000000000000      0x00000001017f9003
+
+		 PDPE                    PDE                     PTE
+		 0x00000001017fa003      0x00000001017fb003      0x000000008d800003
+		 0x00000001017fa003      0x00000001017fb003      0x000000008d801003
+		 0x00000001017fa003      0x00000001017fb003      0x000000008d802003
+
+		 [...]
+
+		 2) Dump the page table of device "0000:00:0a.0" with PASID "1" that
+		 supports scalable mode.
+
+		 $ sudo cat /sys/kernel/debug/iommu/intel/0000:00:0a.0/1/domain_translation_struct
+
+		 Device 0000:00:0a.0 with pasid 1 @0x10c112000
+		 IOVA_PFN                PML5E                   PML4E
+		 0x0000000000000 |       0x0000000000000000      0x000000010df93003
+		 0x0000000000001 |       0x0000000000000000      0x000000010df93003
+		 0x0000000000002 |       0x0000000000000000      0x000000010df93003
+
+		 PDPE                    PDE                     PTE
+		 0x0000000106ae6003      0x0000000104b38003      0x0000000147c00803
+		 0x0000000106ae6003      0x0000000104b38003      0x0000000147c01803
+		 0x0000000106ae6003      0x0000000104b38003      0x0000000147c02803
+
+		 [...]
-- 
2.21.3

