Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225D436375
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747714; cv=fail; b=YIVg6xgaGZa4rtHA5V0PkPmYViQQyTMT2jOFgGmBzeloDaOmO1P/CSexd65Y9Ac1KG3CSWbpriCnATVKwyTQS0NuDaXnR/Xto2BsI+k3152c52E+NeLxvqwfoTheLos4nsIp97xbIqGn5KrGOzJI8K3nPH2V1Pb139tI/4BCIUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747714; c=relaxed/simple;
	bh=B3dXFP0W1aevsZTYXpouzsonMKBSRFc/EAAMrwSahHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uf+fDVLqWQ06KP2q2PXaS2g7nUc8BPhq7TnRzc0zemQuh91o5nWMrk/x4Zw31VQKxUtIY1WzYpUWvbhA3hWOYpfg/apROB0k9172JYTgl7x1NXISRXy9py5HXwAjiPfocrBuntV5d+1fN2hxao1koXPlHxBDq34WpdgS2dbGwD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=428JnXVT; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="428JnXVT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJQdk3SFFT+tachV6lxc7QVtYEDJybcZUqt3x8GYbFUyr6VcUPxeXDLl6jpyWDDezbEE/XN23RTc9qqeihrU78oLlKf6WbhOtMqdNlQZMZM+yxHm1I8VQCkw+S3rnOVlD1e+Pf3wCAunEg54miyOpERRH0Fud7/41wEhsGd7dV0YFCcUV+2u+ZFyzPCvJoE5qkT75FlwWSMpB2iTati1e9EbwO6TMLhKZVrttwcjyRrV4Yh2ZSTlm3YKVrqSgezgpE54n3bNv9W0RDNan++aaliVg/0zPIIfJL579GnSCCboKZt7cC/jhIujsGYPCXa3mUFH+XAL0Yfy52VFdeNK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsUXtstWFtZ8jOoDpJb7LX4NRp4SZtgjkD5iLmna94g=;
 b=VuML5KlsSeGwPSZlJtB/ycZMIeXL6jQUUtTooe4MjmqDrm+4XvCWHbS/lJFKYpsSs4lG7vlFZqMGQS3LqiKP0UgdBYB+whjMwfYoPWJPJicQCqDnnmTDzGjhCQFmM5kaQk93YhRsKhYs2WtZPiszYA1OPK9GwFbDvPVWeg6cFHw+5dyh5r9nKEhgMEy210GtvXE8qBxnlxYWQTV3/XR9Gr93KQrZ1eo7OoeLplFxeVNnklesdAU45V3HWAmLXMRe8uezsl4TMTHH4aDsV1VAThSDodN2euOiqzurH4sYlRQpFnWhEgZTTPGeFhXT35IZS8xOXROOvuJ5flSg2c1vFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsUXtstWFtZ8jOoDpJb7LX4NRp4SZtgjkD5iLmna94g=;
 b=428JnXVTKJ9D9cS7iIUP/ruO0klieNGNO0GI583a0n6w94EOCS6KpHq7sKfr/9/uOgoR6TJ5aM/a4JObSx7ZXSIZD7U1ShukEvbBgVt72WbDue4KzZ74Fixu0BjkSbco/KkfOtxDycEZIMaH2wiOgyutYkzHBB+eBY55XIZQ7AE=
Received: from SJ0PR13CA0151.namprd13.prod.outlook.com (2603:10b6:a03:2c7::6)
 by PH7PR12MB6634.namprd12.prod.outlook.com (2603:10b6:510:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:41:46 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::36) by SJ0PR13CA0151.outlook.office365.com
 (2603:10b6:a03:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 15:41:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:32 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:35:52 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 00/22] iommu/amd: Introduce AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support
Date: Mon, 29 Jun 2026 15:35:13 +0000
Message-ID: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH7PR12MB6634:EE_
X-MS-Office365-Filtering-Correlation-Id: feb57709-cdcf-486d-b0f9-08ded5f4ed54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+keVep9k25wgQkKcitguotNMl00+45ZeqGxdM1/Wd/4iPn2Qw7z+79QW3R904HLisNpylxPTtz4Fydn9pzrEnJKDesU+hfJBp92Dg+6LJudL3AjHXG5XhSspDhMNYKsoxQYpvCPOKjF1aPA1kkZr2wsU8Wh6uVmCN/iqaoC4EdrsYa0l3zV1pQBOhldFPEUsfBozpF7ejr8vOyCOgrDFmIUCCroL6i61Gu9Ql9v5sKPRDABkHIajyS30KhUxr6xzruMtjeQp/+b31zUX1LxsVG3P9cmBD9fDQCwLBjqW+Z5zl3aRjhhztVTDaQfzthiulauciXoDK+i/HQqo6elp+Cj6hSAavb6/MMA5YtughW9Fh5pP9KmuOuRYg4JqqKYM9WfXFceeXLDZEerHz/GPrbdGZ7TOtlrn468zDsBcPnCmAH862NsMYzcMf+9g7iD00ql+XQG/vEBDb/oJG4xLFpraZpTH39UzRTNDnIq2KW06VMn3pqOvempDDG7Ttl6q5t7M50y9U4MNf9Bpy/6wNRNGBJB6RDS8uIQfdmgF2HJbidA8pafOY93Mq3Sjpvx2dpe13EsGW29Y/StMdhYCtOp9vFwclG5QKP/gPvAGnp1o/+61d6ITPLmoRgGNbN+u8j9YRWhKbDrwqEFihg/rU9XoW8/l68bUprNnzeABlgqWSGlwhnn2FuY/r2j7V0d3jLAE+lq1r+zG6Ciuvq+Ztg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y/uNlhOjVunK6Nk6A1bAtHRe4Y2MIRDmqvTfitFQZ8U43bsbCrFu/stlAYt7R1M0HCrLytTrgARW1ZBPADNTubp+73qzosdU1+GVrcvqAE2DQxqCZ8j1S++pNP865E+Js+1NEYsCVL3ceGlHzbhOtSbzj/2brEcO8mG9+fumkhrLgWQRCvIvtPyDwE1BrVj3NslIlOCuvjqSrJy/9ipeKPfYbIZL6oRBYEee9/dftYFv/Csz0V7TGrDL0iMzQr9Zje9bC8tiBMipyleR2ScrHUkRDjm4t4sUJTZiJIE4kM6YMOYtwdQvw2mKnbEj8mLrEuiihXT47fV1NEoOh486Zj647Kaa110zINE0NlYWA6GLgS4ZyGxdLfg6u5+ZWaxwMDqLqJqEMzvyKAuW3c8lojJu+FDdK6qzaeQYDgoE9nivBtHVlchjY7BnT5dr6Z+9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:46.2671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feb57709-cdcf-486d-b0f9-08ded5f4ed54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6634

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

This is version 3 of the AMD HW-vIOMMU series. It is implemented on top of
the IOMMUFD vIOMMU, vDevice, and nested-domain framework in Linux
v7.1.0-rc4.

The series is organized into the following subsets:

  Patch 1-3   : Preparatory patches
  Patch 4-8   : Introduce IOMMUFD vIOMMU support and VF MMIO setup
  Patch 9-14  : Introduce and map vIOMMU Private Address (IPA) region
  Patch 15-18 : Introduce IOMMUFD vDevice support for AMD
  Patch 19-22 : Translate-device-ID pool and per-vIOMMU translation DTE

Changes since v2:
(https://lore.kernel.org/linux-iommu/20260528051738.596013-1-suravee.suthikulpanit@amd.com/)

Series scope:
  * Reduced from 26 to 22 patches by deferring hw_queue, extended interrupt
    remapping ioctl, and vIOMMU hardware-enable patches to a follow-on
    series.

IOMMUFD vIOMMU support
  * Patch 4: update struct iommu_viommu_amd to include vfmmio_mmap_offset
    field.
  * Patch 7: Fix casting when calling iommufd_viommu_alloc_mmap().

IPA / DTE infrastructure (patches 9-14):
  * Merged domain creation and private-region alloc/map into one
    patch (9). Added preparatory patches to pass iommu explicitly to
    device_flush_dte(), export amd_iommu_alloc_dev_data(), and pass
    iommu/devid to amd_iommu_make_clear_dte(). IOMMU IPA DTE assignment
    (13) now allocates viommu_dev_data and uses the standard DTE update
    path.
  * Patch 9:
    - In viommu_priv_alloc_map_flush(), clarify the need for
      set_memory_uc() for vIOMMU backing storage memory, and Remove
      unnecessary amd_iommu_flush_private_vm_region().
    - In viommu_private_space_uninit(), add logic to properly flush after
      unmap.
  * Patch 14: Remove unnecessary struct iommu_domain_ops::iotlb_sync.

IOMMUFD vDevice support (patches 15-18):
  * Patch 15: Call amd_viommu_uninit_one() before freeing the gid.

Translate device ID (TransDevID) - design change (patches 19-22):
  * Driver allocates one trans_devid per IOMMUFD vIOMMU instance.
    Each vIOMMU owns its translation DTE independently.
  * Remove kvmfd so multiple vIOMMU instances for one VM share one
    GPA->SPA translation DTE.
  * struct iommu_viommu_amd no longer carries kvmfd; KVM FD handling
    removed entirely from this series.

Translation DTE helpers (patch 21):
  * Allocates iommu_dev_data per trans_devid, programs through
    amd_iommu_set_dte_v1() / amd_iommu_update_dte(), and frees on clear.
    clone_aliases and PCI alias flush are skipped for trans_devid entries
    without a struct device.

Testing done:
  * Single/Multiple vIOMMU instances
  * Single/Multiple VFIO devices per vIOMMU instance.

[1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
[2] Linux git tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-viommu_upstream_v3

Thank you,
Suravee

Suravee Suthikulpanit (22):
  iommu/amd: Make amd_iommu_completion_wait() non-static
  iommu/amd: Introduce vIOMMU-specific events and event
  iommu/amd: Detect and initialize AMD vIOMMU feature
  iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
  iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
  iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
  iommu/amd: Add support for AMD vIOMMU VF MMIO region
  iommu/amd: Introduce Reset vMMIO Command
  iommu/amd: Introduce and map vIOMMU private IPA region
  iommu/amd: Pass iommu to device_flush_dte()
  iommu/amd: Export amd_iommu_alloc_dev_data() helper
  iommu/amd: Pass iommu and devid to amd_iommu_make_clear_dte()
  iommu/amd: Assign IOMMU Private Address domain to IOMMU
  iommu/amd: Add per-VM private IPA alloc/map helpers
  iommu/amd: Add helper functions to manage DevID / DomID mapping tables
  iommu/amd: Introduce IOMMUFD vDevice support for AMD
  iommu/amd: Introduce helper function for updating domain ID mapping
    table
  iommu/amd: Introduce helper function for updating device ID mapping
    table
  iommu/amd: Add per-segment translate device ID pool
  iommu/amd: Reserve translate-device-id for PCI requestor aliases
  iommu/amd: Add translation DTE and VFctrl TransDevID helpers
  iommu/amd: Assign per-vIOMMU translate device ID

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  51 ++-
 drivers/iommu/amd/amd_iommu_types.h | 100 +++++
 drivers/iommu/amd/amd_viommu.h      |  58 +++
 drivers/iommu/amd/init.c            |  23 +-
 drivers/iommu/amd/iommu.c           | 292 +++++++++++---
 drivers/iommu/amd/iommufd.c         | 120 ++++++
 drivers/iommu/amd/nested.c          |  19 +-
 drivers/iommu/amd/trans_devid.c     | 186 +++++++++
 drivers/iommu/amd/viommu.c          | 566 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  10 +
 11 files changed, 1374 insertions(+), 53 deletions(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/trans_devid.c
 create mode 100644 drivers/iommu/amd/viommu.c

-- 
2.34.1

