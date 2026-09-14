Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D3381E9C
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411715; cv=fail; b=AE5ZmkeAnHvG4gQkux7GAuKZ0Vl22N4YINgVsbd2ZzF/wvsTkIut8EMlw24jZz0TMw/HCtYL11BvzrclFSxdlsS2nQ/qgRDIfb0eJofk4B9c61G6NTrxIE2O/MwmYZahV5i4/uUx5uCge783BfZYJqPKGeZ6oqEs1RuPm8mxyoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411715; c=relaxed/simple;
	bh=V422ubCPD4YcozulXc0qyqG5Jp9Wtf+oDX1qezv0dYk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/rvsm8NZOENrGhNxBm/kW+uifIoN5wycXlekdMm4I4m7sZEbFQG9pBugTuU8n2E/y8AK256BWiXYHYJSSy6aiWouz28Wb4t90M9PggD7xghu84KoDMZMZ8CBWjxOgNM9PDbtONRtaYqT99HBmpfitTC4TmILo9WFy0D5KNwUXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CuWGzNJ2; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CuWGzNJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3g3iZQzjZvLBWeG+UIaTGqGgm7XaL1K2nk5YuRXuyxJ593XydVy7K0doje9c+cVbOmMHCNpP+JNJRKtQKvwoFPY6hYwaJQtRlFKalnkPbsg2K2SV/ZzVq8Uyt6vMdhFrIKy0GI8xCa1uWVG0Dz5ZP4SKAWOB/pCR57ZNSNrpqkk4pZRkYsS7SG0kJR7Pr0k0X5hRPQyD60ps8S+FZH1Uc/QM35aJZ5gUhSAaVC9LpuNafdPIYfM9PNlIuldjOgVinyNPTsVnLmqdSaF69C0JtXXkaLKGHV3XqdpKOKT5DE//mOwvhsYVRSV/o/WMKzsy5g366Hn9ngb65eLFCpWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5DbOz7mYJIDlzv3J/gzwVzGtfOzFbPOHCSQCwRxzyI=;
 b=qL2Juej2HASrAJiI86QuYjnHCMkKEh6qcRIvx1+Yp85zCvA8jlFcdP22iY+ecHIVDInI6oagVL0DVrcJF4/G5gtAUFmITYHuRh/OlryG6xn8v0Jizp5s5Zqrl4mHkKwz4iQhnzJmCWt15H7vfPybkacuG1osRslCtuYtZwl3T9mcBRgYXMV1IvvyM8U5M6pMcVsDerH6FNatD1gvqa39TxqPMq4kpLyWJOyqE2yBy/R8wg1JYhYHyfQ+6tZ9hbLd2yCfcMpYIR3bCqazyBDrf90WFPKcJqVPFSTjqTNGXJNx4BOsQOM8UX2EpYMqjpqFPKn6bwZJX30C6nMB0S87HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5DbOz7mYJIDlzv3J/gzwVzGtfOzFbPOHCSQCwRxzyI=;
 b=CuWGzNJ2g0bBDELjgd7huzqJKLemK6vo2uSnz0O8D5mx8rVPx4nayuMrCs4u8BrTyxoYQhzmIlbKDm8u0BEtlStTCxcK+JFIRRo/0vyeHJX1g/GroxkVp15uR25uZT6yxJOXzm3e9pRJgW4jXhpGhtL7gSaCi6BzAQ+0FuG8oGM=
Received: from BN9PR03CA0174.namprd03.prod.outlook.com (2603:10b6:408:f4::29)
 by CH2PR12MB4150.namprd12.prod.outlook.com (2603:10b6:610:a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:20 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::44) by BN9PR03CA0174.outlook.office365.com
 (2603:10b6:408:f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:20 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:09 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 00/24] iommu/amd: Introduce AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support
Date: Mon, 14 Sep 2026 18:47:26 +0000
Message-ID: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|CH2PR12MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: b5665693-7ca2-45f9-5737-08df1290bf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YpS1Biw064WRikTNNVEcm0he+QQFhR+sGnby0NMpKhDO/QGdK2SkrVdr+xKr27/dvzMebeoK1f+6XFOArf5ubx0shSgpRWj6Np5hnKpVV3fPmKvJiEMV+ju00L8ynwapohkEWp+sN4ewDwmnYyUt0KqAECREYhCTxEtPdy2Yqh4SBZyqWzYMUNibpkH0HzDWxgTmV4sVUab/1WwaIH1CeFfdtNc0S8lg79KGH2Lf8OVuWx72BBxhjcnRkswbImvNYy4XWcYQmglVBkn9JSffdTfgIrV/Lk1J02Jz1WduUOOijrOnENYPBZRhLbnCKHcNRrUpWVQbq8pRuxhdwpocA/5N2IIbIEgWF0xuWC4m7jjt2zmrG9fV/1dwUWrvO6yaOSGn2sfKCZXiawFKE1mXeQRai6VuLReXZDnNktiY6HCWd7OKZCCY51QWuC/OEzSGQYcSjmR9n3tdgf8AYPS0YToyxYBTsOuz44kVLxlKC9UQsJa9UJ+TXmMp/RPsUOdNnREA6RUqnG0fNayNn9cPiVfjU4QjtBOm6r1bdnQxMpF83YnUbgA2XUE8hJi2PBzgl8Opja9GvP9eCTUUAt00yK82FCyBCWjXf26EWCTYHEP2sMXnHXblnhHWMAhiqa1WdOrT+25ckgmAoKrVEx5KrL8h2erAZE5/0b9tSA1F73L4bXhjMqpIA2IQVL9jiAuSwwf0gy9Zq3UlbREtim6RHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5PgV/Ty3Tn/LlcQYtzq5s0qj27oMTYY7egXHamyM5mVl5koLE6PFzbBBleWAGa/I4c0v0Z377+0QQ4JvwcuCJ9RqMXJxudMCe/t0qkRXDrVfcEt4HfoSCr71bPx59/tiC4EYMNWShrhDzhG3TIqe9q+0sbVfJnJphUeH9XYXfENrZQ/fcgymt2T6YFQHTdgoNXqHEr7aAnmmYCSxLHLQBfVOBEN32UKIfPsSM/WRr9j9PuoSAh3Odlr8Sh6UvgUghklvm0g3U+UonzS5Ga28tvZJFpQ3hwmg36wuAntKDir/58ORj8BguSilNLjdykc5JnZcXqGIO5vqiO6/YqjqXrsa5dSr1/KIsuvM05/JAUUtnRP9Z4xGmWVz6Q+3ZAU/+VCq8TMT21nujYZeABGggB+YRkudvRECI3I843m4WVhswop/N48l62cOhRV6MYlT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:20.1901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5665693-7ca2-45f9-5737-08df1290bf34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4150

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

ABOUT SERIES V5
===============

This is version 5 of the AMD HW-vIOMMU series [2]. It is implemented on top
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

CHANGES FROM V4
===============

V4: (https://lore.kernel.org/linux-iommu/20260727132913.22475-1-suravee.suthikulpanit@amd.com/)

Rebase / series scope:
  * Rebased onto 704340f1cd0d (Linux v7.3.0-rc3 plus x86 urgent
    for v7.3-rc4).
  * Drop "Make amd_iommu_completion_wait() non-static"; the helper is
    already available, and VFCTRL CONTROL0/CONTROL1 doorbells are not
    command-buffer operations.
  * Drop "Export amd_iommu_alloc_dev_data() helper".
  * Add EVENT_TYPE_GUEST_EVENT_FAULT as patch 2.
  * Replace the vDevice mapping helpers (v4 16-18) with vDevice+DevID
    mapping, nested DTE+DomID attach, and DevID/DomID table prefill.

Events and init (patches 1-3):
  * Patch 2: INSERT_GUEST_EVENT with reserved bits logs GUEST_EVENT_FAULT
    then the original guest event; consume both event-log slots.
    Wait until occupancy is at least two entries; re-read the event-log
    tail each poll iteration so a return of 2 cannot walk empty type-0
    slots. Return 2 only when the pair is in [head, live_tail); return
    1 if the pair never appears. Rate-limit guest-triggered logs.
  * Patch 3: Gate amd_viommu_init() on this IOMMU's EFR[VIOMMUSup]. Set
    AMD_IOMMU_FLAG_VIOMMU_EN on success. When CONFIG_AMD_IOMMU_IOMMUFD
    is off, the stub returns 0 so a missing build is not logged as an
    init failure.

IOMMUFD vIOMMU and VF MMIO (patches 4-8):
  * Patch 4: Report a non-zero viommu size only for AMD when
    amd_iommu_viommu_enabled() is true.
  * Patch 5: Initialize gid_ida with the IOMMU object; reject vIOMMU
    init without AMD_IOMMU_FLAG_VIOMMU_EN.
  * Patch 6: Reject a disabled or zero VSC VF/VFCTRL BAR; set
    VIOMMU_EN after the BARs are mapped; uninit before
    free_iommu_buffers(); release the reserved MMIO region if ioremap()
    fails.
  * Patch 7: Return -EINVAL if the VF-MMIO page_base is zero.
  * Patch 8: Always program RESET_MMIO_ALL_FLAG and RESET_MMIO_VCMD_FLAG;
    propagate completion_wait errors.

IPA / DTE infrastructure (patches 9-14):
  * Patch 9: Tear down the 8MB IPA mapping from amd_viommu_uninit();
    pass GFP for backing pages so failed init can unwind. The private
    IPA domain skips iommu_domain_init(), so set IOMMU_DOMAIN_UNMANAGED
    so set_dte_entry() programs v1 when increase_top() rewrites the
    self DTE.
  * Patch 12: Store per-segment iommu_dev_data in an xarray instead of
    exporting amd_iommu_alloc_dev_data().
  * Patch 13: Program the IOMMU's own DTE with the private IPA domain
    (off pdom->dev_list); rewrite it from amd_iommu_change_top() when
    the table grows.
  * Patch 14: Charge DevID/DomID backing with GFP_KERNEL_ACCOUNT.

IOMMUFD vDevice and DevID/DomID maps (patches 15-18):
  * Patch 16: vdevice_init programs DevID via VFCTRL. Idle entries keep
    V=1 with host device ID 0. Serialize CONTROL0 with vfctrl_lock.
    Destroy restores the idle mapping. Poll CONTROL0 WRITE until it
    clears; iommu_completion_wait() is not a barrier.
  * Patch 17: Program nested DTE and DomID map on attach. Last
    nested_domain_free() for a gdom_id restores the idle DomID map
    (nest parent, V=1) before freeing hdom_id. Poll CONTROL1 WRITE
    the same way as CONTROL0.
  * Patch 18: Prefill DevID/DomID tables on init only; yield
    vfctrl_lock every 256 doorbells. Destroy drains WRITE then unmaps
    and does not rewrite 0..0xFFFF. Skip VFCTRL when CONTROL_CMDBUF_EN
    is already clear.

Translate device ID (patches 19-24):
  * Patch 19: Initialize the pool when pci_seg is allocated; reserved
    RIDs stay reserved for the segment lifetime (including after
    release_device).
  * Patch 21: Own trans_dev_data on the vIOMMU. Sample the nest-parent
    top and commit the DTE under pdom->lock; publish on viommu_list
    before dropping that lock. Keep trans_dev_data->devid as the live
    TransDevID; clear programs an explicit slot id.
  * Patch 23: trans_devid_lock; do not write VFctrl TransDevID from
    amd_viommu_uninit_one(); own the synthetic DTE on the vIOMMU, not
    in the per-segment xarray. INIT_LIST_HEAD(pdom_list) before
    set_translate_dte(); drop the late list_add; list_del_init() on
    init error.
  * Patch 24: Mark from_id reserved with a raw xa_store so
    ALLOCATED->RESERVED does not WARN. On MMIO failure, restore
    from_id the same way. Reuse the vIOMMU trans_dev_data object.

[1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
[2] Series v5 tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.3.0-rc3-amd-viommu_upstream_v5
[3] Fully supported tree (work-in-progress): https://github.com/AMDESE/linux-iommu/tree/wip/v7.3.0-rc3-viommu_20260915

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
 drivers/iommu/amd/amd_viommu.h      |  91 ++++
 drivers/iommu/amd/init.c            |  62 ++-
 drivers/iommu/amd/iommu.c           | 486 +++++++++++++++++---
 drivers/iommu/amd/iommufd.c         | 183 +++++++-
 drivers/iommu/amd/nested.c          |  76 ++-
 drivers/iommu/amd/trans_devid.c     | 373 +++++++++++++++
 drivers/iommu/amd/viommu.c          | 688 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  10 +
 11 files changed, 2046 insertions(+), 84 deletions(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/trans_devid.c
 create mode 100644 drivers/iommu/amd/viommu.c

-- 
2.34.1

