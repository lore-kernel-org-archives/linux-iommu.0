Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5E343895
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945493; cv=fail; b=Wmmjrn8vuoUVpgpyufOyAVG9kqqgnTd/JOEJqNa71/tkaG8YSE8H7qVx9c6CFbPFAaXT6JI0Kvt9ue/CYac7chjOgvHM6t4v0dtkgFA5+Os0p71M/1Lxq4pn8bXQ3Y1d2cuWE7Qx8gcAe01yk22RHSMRF5SJK03kIw7hwHv85P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945493; c=relaxed/simple;
	bh=JiF4YXpdEYbNQvBINhISp2RgnOLKlf3HrNpYyzlFqbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K0Mh9gmUJu8WiN2eVGcBaeWxWD7m7gxiGBjavIqW2Mkvy9nqK2BEfqhO0WlT8UU8JKbWhNaqKLMfrmU6VeN3Thq5hm6utJYAC0zxKhxuGF1PUM/4il5FMbmiGS++REZZI5hposH0m/3L8PdhYYarTV2PYbctkhehj2ZwmF13FNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fk2Ue2kn; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fk2Ue2kn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2ZiAyaWkXG0xCacgzxt5//trZ6OGiKJRIFbd1+rcRvuHUCOs0xt2i82IT0SvSrbWdyPPORojsGMAlLPEPt8WSUG6PLCAw1HqpbusAKGx5WPU7qfgo9/LCmvpVvds4PiGw7MmGX4VvbAXAKOiBKYzeinSNZHb9JU5/tTTW8rPy9eHd99NJ8CJfQr7UfW9Wg/ui0PaZ+h4v3lhDd8dCowsZ3dFUzLq10jRie31hAlJESF482yavrNUaeiMSSzVNXbgpCumIXTOu0jQ9dhmaWtFrw0O0kQnteWiqJn7GEnrybrEZucTRiDdEMswh7O+oLS5bONuDYp+zLByPj3+JhesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQpVayTkEB8S7beUYRRdbOACH6Jh1wdO6ymXZtptZfw=;
 b=gTbHB/tXlhbIARTI7iD6dE/3xaaZNaQfQC5hFjFW4KUZYM6A5eeUwK9Cdxbzqc1J4NYAwZfSY7Ox42b8MFi6NqQXeb4wkzren5h6oj/0lRWd0TDXt+ZaNrlw99mLxlrD+7NOEFufDsLLgUVWoDlTG0QbK2zMbGpJAwEzrLQMtR7UwWwg+v5WRIhfzym1yZ0a/tqpCPBQSG3yeQfTK2EafbiMlym2cAapTWr6bQQmBub5Th0Mwni+KxkVyqnUq/C3GGEG9Nv2PjAYVo+1Aehlt9zfiBiBMo7t6JeGHGfnOrM69Wco+f2fpRsYGM0xE6+twJ4u5M9TDhPmPtMTpB4sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQpVayTkEB8S7beUYRRdbOACH6Jh1wdO6ymXZtptZfw=;
 b=Fk2Ue2knZzp/MlOyGYRcezLR0hOJQBguZVwZAiPf/c7TIPSTxMAiN1ovhtl48iqJjrkUQl7zO38MzggURwV0He1jaSSCITurN6SyMxNl6DSiv6VA73Z4d7jKMtPkAMGgU/M/Ls+jzyrQXoTTIs7Hs/5XjKTTLcxrsrxDx6BCSxA=
Received: from PH7PR02CA0016.namprd02.prod.outlook.com (2603:10b6:510:33d::15)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 05:18:03 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::22) by PH7PR02CA0016.outlook.office365.com
 (2603:10b6:510:33d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:18:03 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:17:57 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 00/26] iommu/amd: Introduce AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support
Date: Thu, 28 May 2026 05:17:12 +0000
Message-ID: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: eccaeba3-88ed-42fd-fab9-08debc787e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|13003099007|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	AoaKXoiXhLfDzWptSj9p4DjbnYwhypxvMmGFLvMDhLbrcef9BjoLRuVd/Vh3IhWKPPxgC7SmqXO5aYXI6gFuGYrPbH/M90HqR89pzoOpq/gRCUiRrOphj9ZZQe81j60++ORjQB0Pts31jM7wxzCjG6YghTe4EIhDyxaVa2wEbp1HPt87N6k+Q/ul6VLUpnc9dh4tDThBnNfgPMC+Mn0vXBsmTb/ItmDa1Cc6TlleEG4BC4ztMCuH+zweErM+EPXsFGyNKsOb6EX2BctiUYL6hN+FCHl2Ds9iSK+Gn4BQRvkizeykn+T0OTjOQhoIAxmX+vFjis6rRqbR25vPweTkcCyzhly5NJUuKAkZqlM30uYVcSSnkv6aH70oRAA7+GPrmPamKSxy7dDND/Xrggz+5SBGC+Y0gw48oCsI6lBdj+EgxICbTUtu2+PbbSyEwQcGgirijtbmhBt2hR6u9Az4TFp3uyHI7b3EvPFQDzOdZc5VYxOwa46tUy/7i0/86e/4SQVEcSGBLDUxGAFs7V8E7LW6Ww/vmPZI+9SndQXXDM5VCqDxmam8ljdHuroSJOd0rFRInAjQkMIJr63vIl29lXEgdjW2wFXkbfcCUWY1O7G0vyXqKswK3qMGRjpF8fVgAjSQFcs9qXJCJQu4KPE7BIsfoTzIynqyVwPWyEBkMBAHJGbYCwHMbkQHO+W6KOxy09j3v0eAakdsLFtN4j+1OGRRmCUy3e8ashXZXENTS1M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(13003099007)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NfWOkaAuLTAQ0D4jS/yRTRyBAHBSl2BrQjo4ftQ+vVCFJtpmaSTW0REqwPe+C+4Mhp7d63p+JXyvAeg4lQOmqER20v6so5wGeROry5Ns0fm1BxaMDwwwD87QwIAa1mu6hNHep1uXBbYt1Xs8KYYncVM8/sRHL+Dru19lJ7Lmk1r/7v6fYnsuRdnpl3X1O41PvlCZbkBd0Pbi9p4vx6S/KCwCA7hH2RFxqUwrbpEBCm7foIyluyc+aywDD0ruS84wVEj2eDM8ZBfXBkgUwAT4H5UtP4vxEM3AnorSfGINRbEAdDHueLs+UCpRezS+SWMGbU5sCIsHvwDd+enUSXSqtwxNcJcIZY2CJCRM10m1dUikZhi2sfIHmdGH+bcXCO37GEBZYf1j3Hlx5hrXgX/zPVVt1liEZS+Jggf0UWgwYgVzqZXDK7+W1kJpiM0WudxB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:18:03.2110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccaeba3-88ed-42fd-fab9-08debc787e35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327

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

This is version 2 of the AMD HW-vIOMMU series previously posted as v1[2].
It is implemented on top of the IOMMUFD vIOMMU, vDevice, and hw_queue
framework in Linux v7.1.0-rc4.

The series is organized into the following subsets:

  Patch 1-3   : Preparatory patches
  Patch 4-5   : Introduce IOMMUFD vIOMMU support for AMD
  Patch 6-8   : Introduce AMD vIOMMU VF MMIO and VFCtrl MMIO
  Patch 9-12  : Introduce AMD vIOMMU Private Address support
  Patch 13-16 : Introduce IOMMUFD vDevice support for AMD
  Patch 17-21 : Translation DTE, KVM FD, and translate-device-ID pool
  Patch 22-26 : IOMMUFD hw_queue, VIOMMU_COMMAND ioctl, enable vIOMMU

Changes since v1:
(https://lore.kernel.org/linux-iommu/20260330084206.9251-1-suravee.suthikulpanit@amd.com/)

Rebase and scope:
  * Rebased on Linux v7.1.0-rc4.

Guest ID (GID) - design change (patch 5-6):
  * v1: A single global IDA; each GID is unique across all AMD IOMMUs in
    the system.
  * v2: A per-amd_iommu IDA (gid_ida), initialized when vIOMMU MMIO is
    set up on that IOMMU. GIDs are allocated in amd_iommufd_viommu_init()
    and freed on destroy - one GID per IOMMUFD vIOMMU object, unique within
    that IOMMU only. A VM with guest IOMMUs behind multiple IOMMUs may
    therefore hold multiple GIDs. This is separate from TransDevID, which
    remains one per VM (kvmfd) and is shared across vIOMMUs for that VM.

Translate device ID (TransDevID) - design change (patches 17-21):
  * v1: VMM supplies trans_devid via struct iommu_viommu_amd; driver
    programs translation DTE and VFctrl guest-misc register.
  * v2: Driver allocates trans_devid per VM from a per-PCI-segment pool
    (trans_devid.c), reserves IDs used by real PCI functions on attach,
    and keys allocation to kvmfd so multiple vIOMMU instances for one VM
    share a single GPA->SPA translation DTE.
  * struct iommu_viommu_amd gains kvmfd; trans_devid removed from UAPI.

Userspace vIOMMU control path - design change (patches 24-25):
  * v1: Extended IOMMU_OPTION with IOMMU_OPTION_VIOMMU and
    set_option/get_option ops.
  * v2: New IOMMU_VIOMMU_COMMAND ioctl with set_command/get_command ops
    for indexed read/write of vIOMMU register arrays (e.g. guest MMIO
    shadow). AMD backend moves guest MMIO accessors to vfctrl_mmio.c.

Single-patch / implementation notes:
  * Patch 4: Gate amd_iommufd_get_viommu_size() on HW vIOMMU capability.
  * Patch 8: Reset-vMMIO helper declaration in amd_iommu.h (rebase).
  * Patch 11-12: Per-VM IPA map/unmap via iommu_map/iommu_unmap (was
    pt_iommu_amdv1_map_pages in v1 per-VM helpers).
  * Patch 26: iommu_feature_enable_and_check(); improved error unwind in
    amd_viommu_init(); enable vIOMMU by default when supported.

Upcoming series (in subsequent submission):
  * Extended Interrupt Remapping (guest Event / PPR log interrupts)
  * KVM/AVIC integration and guest event injection support

Testing done:
  * Single/Multiple vIOMMU instances
  * Single/Multiple VFIO devices per vIOMMU instance.

[1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.10_PUB
[2] Linux git tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-viommu_upstream_v2

Thank you,
Suravee

Suravee Suthikulpanit (26):
  iommu/amd: Make amd_iommu_completion_wait() non-static
  iommu/amd: Introduce vIOMMU-specific events and event
  iommu/amd: Detect and initialize AMD vIOMMU feature
  iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
  iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU instances
  iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
  iommu/amd: Add support for AMD vIOMMU VF MMIO region
  iommu/amd: Introduce Reset vMMIO Command
  iommu/amd: Introduce domain for IOMMU Private Address (IPA) region
  iommu/amd: Assign IOMMU Private Address domain to IOMMU
  iommu/amd: Allocate and map vIOMMU private regions
  iommu/amd: Add per-VM private IPA alloc/map helpers
  iommu/amd: Add helper functions to manage DevID / DomID mapping tables
  iommu/amd: Introduce IOMMUFD vDevice support for AMD
  iommu/amd: Introduce helper function for updating domain ID mapping
    table
  iommu/amd: Introduce helper function for updating device ID mapping
    table
  iommu/amd: Pass KVM FD from userspace when initializing vIOMMU
  iommu/amd: Add translation DTE and VFctrl TransDevID helpers
  iommu/amd: Add per-segment translate device ID pool
  iommu/amd: Reserve translate-device-id for PCI requestor aliases
  iommu/amd: Map kvmfd to shared translate device ID for vIOMMU
  iommufd: Add hw_queue_init and split queue alloc paths
  iommu/amd: Add support for vIOMMU HW queues initialization
  iommufd: Introduce vIOMMU command via VIOMMU_COMMAND ioctl
  iommu/amd: Handle set/get command for AMD vIOMMU
  iommu/amd: Introduce logic to check and enable vIOMMU feature

 drivers/iommu/amd/Makefile              |   2 +-
 drivers/iommu/amd/amd_iommu.h           |  46 +++
 drivers/iommu/amd/amd_iommu_types.h     | 129 ++++++
 drivers/iommu/amd/amd_viommu.h          |  73 ++++
 drivers/iommu/amd/init.c                |  33 +-
 drivers/iommu/amd/iommu.c               | 225 ++++++++--
 drivers/iommu/amd/iommufd.c             | 245 +++++++++++
 drivers/iommu/amd/nested.c              |  18 +
 drivers/iommu/amd/trans_devid.c         | 317 ++++++++++++++
 drivers/iommu/amd/vfctrl_mmio.c         | 146 +++++++
 drivers/iommu/amd/viommu.c              | 529 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/main.c            |   3 +
 drivers/iommu/iommufd/viommu.c          | 150 +++++--
 include/linux/iommufd.h                 |  10 +-
 include/uapi/linux/iommufd.h            |  51 +++
 16 files changed, 1909 insertions(+), 69 deletions(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/trans_devid.c
 create mode 100644 drivers/iommu/amd/vfctrl_mmio.c
 create mode 100644 drivers/iommu/amd/viommu.c

-- 
2.34.1

