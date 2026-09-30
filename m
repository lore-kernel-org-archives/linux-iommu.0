Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8E647987C
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760257; cv=fail; b=EQgtSbMswmEClRz5WTj/wwb/YyrZe39EoG6G+UL6mBqOyP0KdOaOYeTYKQm2Pa3EnZBoFyq99Z08JSEVwzREq9kyOTudfxADefgclIP7CtRuBrAAPP/cRGK6hJYsr1JCJ9tE+npZC21CW0fP0UR7rxssMWNVoKe4mYVTljbLWgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760257; c=relaxed/simple;
	bh=VRluFHVTeu9RFAa6pLwYxmEPGf9KVkKolIIcgkEdr+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZtmPsRq0TSojm7lp9Of9yV1UCNkiYmco79rDr5jzS884vo6ClaoVTTEDeLq7cD5+USuiVUm0NMZlUbKSLr3sDB/N8LkNuSJvbIF6UpEffHiwIcBOyECarF0RG/yXSvrlsunWIL0mTWm2JtD2VyGozFM2u9M0e0FuwkTfR5WAKyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Du3uYcgS; arc=fail smtp.client-ip=40.107.200.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Du3uYcgS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAhwd3asBnoNVUnMFGJzHNeyataJMZMLskcpRWPoBNbvczy1qlEOo2D2m2e3uDeu/SUMJnDgEL9DqgsSsQapwxst855EYBEY13tDOALEmtAtl40hdf72gJyKLqn3hu5WaA+DDcoEdMKG2hnh6ZtiG+SOORst0O9AW7DBsPXfc3hGVu8qbCOFDUjm1qAKQtqUbpL5ED3/t7vnQhc8cQDSi6r/Pwl/vmVT1rRhE1/IPqrpHglx8j1ttxgyLOyCWxzRRvLnTnA3crgbT/4yXYnouB1MpzzXmd4uvldBpba0z9VC5MKl+efEiKkyrvbgcxAtehWZP1A3IoGVx4qI69Oikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99Rf01HqDLn2CT6n95u1Z1xMVmDD+iV5m25nGvo1mLk=;
 b=wLyVWTZS9/q3D9/FDiZCoY77vdxa/vqyv1zeleFnnIVMjL1rGD9vepRckEVnIlgEvZGAEWOBtX2xB7Rh83CgfqoqtF7w8dGkrFoIr2NEby8tDnTVPcl5zxkgRYlfIq/hFMfiawmYp69iZnVMOfTLna7/1VIK1IAnj2cek0nLYzRuIg8cdl+5tXKAH9BMKZnN8tFAIU7hhamIeCL20//En0ip/9UMRh7YtSz14dbT5WfhRl1k3EwhvAjkIYzUOSeNXP4Es/qOt+rXbMMc1of//YJATSLG//C6OyC+SHVi7gfWauKKWv6+pHRJ484JiGwi9iuHg+OUdyDH1lj1D4E1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99Rf01HqDLn2CT6n95u1Z1xMVmDD+iV5m25nGvo1mLk=;
 b=Du3uYcgSbkwZhwq0nGiPiD0vieiNmRgQohSpfHKu5D2EgWL0SXSYfs56urdJBgezvM48Qo78crcgqmywUpP1tzUFtQEY/t3asA451hlqH/uM+3ukGxxlZFiSbjLH779yi2FyxU17uWyuot9S7Y91Z9x6PuDaUikXv9Y7jvKBR5I=
Received: from CY5PR19CA0121.namprd19.prod.outlook.com (2603:10b6:930:64::26)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 09:24:06 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:930:64:cafe::65) by CY5PR19CA0121.outlook.office365.com
 (2603:10b6:930:64::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:23:58 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 00/24] iommu/amd: Introduce AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support
Date: Wed, 30 Sep 2026 09:23:20 +0000
Message-ID: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: bf503376-ada8-4bfd-9ee8-08df1ed492c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|56012099006|11063799006|6133799003|10067099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	qRLckIJsGnc1TruvbIkaBfFluqL28zi4GCBq2QMO5+O5ATyQFKxwgQFcuwfWRv7FbkbXtKg5aMS3F3KTC3HuvD3ohqlApBVcmbijRojiKg04kcpJb//oMy97K9Khwe6/1Y4JJg/rNVieOa9FRaTPhGfHrrzfWFQcyu3Sl0CNuLthe7dQ6aeI1QQgAyFVxczW5DE/3YrWQ444XDgXlW41GxirCb8i6HK02iO8Zyzh7zLQbJAXzFutVToMGdOyt+I+yD/w3a6iXBrHCbIiI2dPpFVOx6knHunpl/SI5wPb8melPOssuGFsR73w4bOk4boCNU9/ZZBPejiX0hTCufaUDelH37fUCeBfbJhCBymsbBrlBEuw8IgjR/NpSqC23KUqj+useXWUKB5DKjrpncfokI1uapOiHH4DZwV7t10Mjepfnb9oOJPVH8S0CsKf1zNaBSVp72tnzGlAN0HTAGeqt1NOKv2VxCNUuAk/53nlmLP6huwVHyPMtUG7m4vP2+ggdYOTPJWNHhsaJ6OtdeahhIEbZRbfEieJzw+l+LhWVTgl+F8HDwpreEY4I2Z2azc5TqBFZGDCxEKjVmsCT68wzn4CuEz8caH1CNtn9Jatt/1f1ZxfvaC+jUTHqDaBOVS+8kRTqBO+WVTBWG78pts0MkLknQIVOBuxpFK6G2iSLPE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KyOqdSx9fRl7SA3q5BLNLJmIZ99B2l5hxS+WW2xkcViunmhqP5V4JfA3U/8M5Aa/YUPuLKySoGzmJ2h+A3Hox0FeHx1Er83gANZHgJsn9G3mvyECgyeoCtxU6Gal4/9VPoVo6G7sOIvdBRygRN0mGx3zhgbZM8IjedzhGf1CkDw2S0lBkZo88CyjwXnOZ1cNtjTQ5RIsR2Q8idALvI0VngbYTjUh3irDldpUmQRNxZ2TMlIpRKmmQw4kyfTM8BRsWqnNSnT5ksY4PBxvLQflN8yfvUjjNH/GA0/qe2+gIJWnehv556tMkkLCx+x3ihmJlp5Zpz3YF33RpTNFWrKs+lcSm8XqSmUlYW4vB7BvrZPPQBSpugN1c6wuCJhYGY5EEorwakk0CJIoEWrVO/zmRfCgUP66IctxzVT6VxtcVfYNksdCbFRQJOSmKBi4c6YX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:05.3092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf503376-ada8-4bfd-9ee8-08df1ed492c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

OVERVIEW
========

AMD IOMMU introduces the vIOMMU feature, which provides partial hardware
acceleration when implementing Guest IOMMUs. This feature provides
acceleration for guest Command Buffer, Event Log, and PPR Log. This
eliminates the CPU overhead needed for the supporting HV intercepts and
reduces the latency of these operations.

When a guest attempts to access guest IOMMU MMIO registers with offsets
between 8KB and 12KB (i.e. the 3rd 4K region) such as the Command Buffer,
Event Log and PPR Log head and tail pointer registers, this is serviced
directly by the IOMMU. When the IOMMU accesses a Command Buffer, PPR Log
or a COMPLETION_WAIT store location in memory, it directly accesses guest
physical memory. The HV/VMM continues to trap and emulate the IOMMU
configuration MMIO registers between 0KB and 4KB (i.e. the 1st 4K
region), which are primarily used during initialization.

Additionally, the HV must initialize the vIOMMU feature, map MMIO resources
between the VMs and the IOMMU, manage additional supporting data structures
in memory (e.g. GPA->SPA translation DTE, Device ID and Domain ID mapping
tables), and allocate/map vIOMMU Private Address region used as backing
storage memory for the IOMMU. Support for new IOMMU command and events
specifically for vIOMMU are also added.

Guest IOMMUs are IOMMUs exposed to VMs with additional support from VMM
(QEMU) to generate guest ACPI IVRS table and define guest PCI topology for
IOMMU and pass-through VFIO devices, which are not covered by this series.

For more detail, please see the vIOMMU section of the AMD IOMMU
Specification[1].

ABOUT SERIES V6
===============

This is version 6 of the AMD HW-vIOMMU series [2]. It is implemented on top
of the IOMMUFD vIOMMU, vDevice, and nested-domain framework in Linux
v7.3.0-rc3 (base 704340f1cd0d).

Note: This series is a partial implementation of AMD hardware-accelerated
vIOMMU. Subsequent series will add hardware-queue and extended interrupt
remapping support, which are needed to fully support AMD IOMMU
virtualization in the guest VM. The fully supported version is available
in a GitHub repository [3].

The series is organized into the following subsets:

  Patch 1-3   : Events and vIOMMU feature detect/init
  Patch 4-8   : Introduce IOMMUFD vIOMMU support and VF MMIO setup
  Patch 9-14  : Introduce and map vIOMMU Private Address (IPA) region
  Patch 15-18 : IOMMUFD vDevice, DevID/DomID maps, and nested attach
  Patch 19-24 : Translate-device-ID pool, per-vIOMMU translation DTE, and
                PCI-reserve relocation

CHANGES FROM V5
===============

V5: (https://lore.kernel.org/linux-iommu/20260914184750.222939-1-suravee.suthikulpanit@amd.com/)

IOMMUFD vIOMMU and VF MMIO (patches 4-8):
  * Patch 6: In iommu_unmap_mmio_space(), release the host MMIO
    reservation only when mmio_base is set. iommu_map_mmio_space()
    already drops the reservation when ioremap() fails, so a failed
    map is not released twice.

IPA / DTE infrastructure (patches 9-14):
  * Patch 13: Clear the self DTE only while CONTROL_CMDBUF_EN is
    set. disable_iommus() clears that bit before teardown, and
    INV_DTE would time out. dev_data is still freed.

IOMMUFD vDevice and DevID/DomID maps (patches 15-18):
  * Patch 16: Program QueueID (bits 45:30) in the DevID table entry.
    Callers pass 0. QueueID is not supported yet.
  * Patch 17: Drop amd_viommu_domain_id_update(). Callers hold
    vfctrl_lock and use amd_viommu_domain_id_update_locked().
  * Patch 18: Prefill each gdev_id with hdev_id 0 and QueueID 0.

Translate device ID (patches 19-24):
  * Patch 19: Reserve the IOMMU function devid from
    init_iommu_one_late(). Clearing rlookup keeps that function off
    probe_device(), while the vIOMMU self DTE still occupies the slot.
  * Patch 23: Destroy trans_devid_lock on init error and on vIOMMU
    destroy, after the last unlock, the same way as vfctrl_lock.

[1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
[2] Series v6 tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.3.0-rc3-amd-viommu_upstream_v6
[3] Fully supported tree (work-in-progress): https://github.com/AMDESE/linux-iommu/tree/wip/v7.3.0-rc3-viommu_20260930

Thank you,
Suravee

Suravee Suthikulpanit (24):
  iommu/amd: Introduce vIOMMU-specific events and event
  iommu/amd: Introduce EVENT_TYPE_GUEST_EVENT_FAULT
  iommu/amd: Detect and initialize AMD vIOMMU feature
  iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
  iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
  iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
  iommu/amd: Add support for AMD vIOMMU VF MMIO region
  iommu/amd: Introduce Reset vMMIO Command
  iommu/amd: Introduce and map vIOMMU private IPA region
  iommu/amd: Pass iommu to device_flush_dte()
  iommu/amd: Pass iommu and devid to amd_iommu_make_clear_dte()
  iommu/amd: Store per-segment iommu_dev_data in an xarray
  iommu/amd: Program IOMMU DTE with the private IPA domain
  iommu/amd: Add per-VM private IPA alloc/map helpers
  iommu/amd: Add helper functions to manage DevID / DomID mapping tables
  iommu/amd: Add IOMMUFD vDevice and DevID mapping
  iommu/amd: Program nested DTE and DomID map on attach
  iommu/amd: Init and clear vIOMMU DevID and DomID maps
  iommu/amd: Add per-segment translate device ID pool
  iommu/amd: Reserve translate-device-id for PCI requestor aliases
  iommu/amd: Add translation DTE and VFctrl TransDevID helpers
  iommu/amd: Add translate-device-id alloc/free with vIOMMU owner
  iommu/amd: Assign per-vIOMMU translate device ID
  iommu/amd: Relocate vIOMMU translate-device-id on PCI reserve

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  34 +-
 drivers/iommu/amd/amd_iommu_types.h | 125 ++++-
 drivers/iommu/amd/amd_viommu.h      |  90 ++++
 drivers/iommu/amd/init.c            |  84 +++-
 drivers/iommu/amd/iommu.c           | 496 +++++++++++++++++---
 drivers/iommu/amd/iommufd.c         | 185 +++++++-
 drivers/iommu/amd/nested.c          |  76 ++-
 drivers/iommu/amd/trans_devid.c     | 376 +++++++++++++++
 drivers/iommu/amd/viommu.c          | 698 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  10 +
 11 files changed, 2090 insertions(+), 86 deletions(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/trans_devid.c
 create mode 100644 drivers/iommu/amd/viommu.c

-- 
2.34.1

