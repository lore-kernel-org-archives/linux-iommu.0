Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882EC1FCB
	for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687706282; x=1719242282;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j4LsgGtbcDlEquzSrXQqZtax80fRhe6Atz2zhoKJYhU=;
  b=A+ZpNcw9gMqjGy5GX+WT+sWPyPUNPVGcjeRWZ/Zz2Z6UF3jn/kcJG7s4
   /DN7tOIJohUiOhrK3+JLkcPRTvRueZLWDz26fVX9WG1jHX0NTW6It0RfE
   i8JHON/eiZouKpo06Z12we8gdSRG7P4QCjufKtXgh/ScNz0OAkp82mZ29
   wRkMDtl8dQfoKT9mjS3p3tmR50vu/b9FEbLZ5ZP/odQ1RXuy6VCASe198
   m+6ewkrFV3zUcK+fSnB3fcIdKsDI9/KPXN6JR+/Fx6v5IaA+lhLoN6TDJ
   EJkO3AMDZx905RnvHCpTl8UjioUxgltar7mVHkVBMmgHfg3VUG8yUMfCh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="391255041"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="391255041"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 08:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="840004511"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="840004511"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by orsmga004.jf.intel.com with ESMTP; 25 Jun 2023 08:17:58 -0700
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian Kevin <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Date: Sun, 25 Jun 2023 23:04:37 +0800
Message-Id: <20230625150442.42197-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original debugfs only dumps all IOMMU page tables without pasid
supported. It traverses all devices on the pci bus, then dumps all page
tables based on device domains. This traversal is from software
perspective.

This series dumps page tables by traversing root tables, context tables,
pasid directories and pasid tables from hardware perspective. By
specifying source identifier and PASID, it supports dumping specified
page table or all page tables in legacy mode or scalable mode.

For a device that only supports legacy mode, specify the source
identifier, and search the root table and context table to dump its
page table. It does not support to specify PASID.

For a device that supports scalable mode, specify a
{source identifier, PASID} pair and search the root table, context table
and pasid table to dump its page table.  If the pasid is not specified,
it is set to RID_PASID.

Switch to dump all page tables by specifying "auto".

Examples are as follows:
1) Dump the page table of device "00:1f.0" that only supports legacy
mode.

$ sudo echo 00:1f.0 >
/sys/kernel/debug/iommu/intel/domain_translation_struct
$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
Device 0000:00:1f.0 @0x105407000
IOVA_PFN                PML5E                   PML4E
0x0000000000000 |       0x0000000000000000      0x0000000105408003
0x0000000000001 |       0x0000000000000000      0x0000000105408003
0x0000000000002 |       0x0000000000000000      0x0000000105408003
0x0000000000003 |       0x0000000000000000      0x0000000105408003

PDPE                    PDE                     PTE
0x0000000105409003      0x000000010540a003      0x0000000000000003
0x0000000105409003      0x000000010540a003      0x0000000000001003
0x0000000105409003      0x000000010540a003      0x0000000000002003
0x0000000105409003      0x000000010540a003      0x0000000000003003

[...]

2) Dump the page table of device "00:0a.0" with pasid "2".

$ sudo echo 00:0a.0,2 >
/sys/kernel/debug/iommu/intel/domain_translation_struct
$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
Device 0000:00:0a.0 with pasid 2 @0x1083d7000
IOVA_PFN                PML5E                   PML4E
0x0000000000000 |       0x0000000000000000      0x0000000106aaa003
0x0000000000001 |       0x0000000000000000      0x0000000106aaa003
0x0000000000002 |       0x0000000000000000      0x0000000106aaa003
0x0000000000003 |       0x0000000000000000      0x0000000106aaa003

PDPE                    PDE                     PTE
0x000000010a819003      0x000000010a7aa003      0x0000000129800003
0x000000010a819003      0x000000010a7aa003      0x0000000129801003
0x000000010a819003      0x000000010a7aa003      0x0000000129802003
0x000000010a819003      0x000000010a7aa003      0x0000000129803003

[...]

3) Dump all page tables:
$ sudo echo "auto" >
/sys/kernel/debug/iommu/intel/domain_translation_struct
$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
[...]

Device 0000:00:02.0 @0x103072000
IOVA_PFN                PML5E                   PML4E
0x000000008d800 |       0x0000000000000000      0x0000000103073003
0x000000008d801 |       0x0000000000000000      0x0000000103073003

PDPE                    PDE                     PTE
0x0000000103074003      0x0000000103075003      0x000000008d800003
0x0000000103074003      0x0000000103075003      0x000000008d801003

[...]

Device 0000:00:0a.0 with pasid 2 @0x10a0b6000
IOVA_PFN                PML5E                   PML4E
0x0000000000000 |       0x0000000000000000      0x00000001072d2003
0x0000000000001 |       0x0000000000000000      0x00000001072d2003

PDPE                    PDE                     PTE
0x0000000107d6e003      0x00000001161d4003      0x00000001bdc00003
0x0000000107d6e003      0x00000001161d4003      0x00000001bdc01003

[...]

Thanks,
Jingqi

Jingqi Liu (5):
  iommu/vt-d: debugfs: Define domain_translation_struct file ops
  iommu/vt-d: debugfs: Support specifying source identifier and PASID
  iommu/vt-d: debugfs: Dump the corresponding page table of a pasid
  iommu/vt-d: debugfs: Support dumping a specified page table
  iommu/vt-d: debugfs: Dump entry pointing to huge page

 drivers/iommu/intel/debugfs.c | 361 ++++++++++++++++++++++++++++++----
 1 file changed, 326 insertions(+), 35 deletions(-)

-- 
2.21.3

