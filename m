Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049E3F39D7
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158983; cv=fail; b=YNnNycwMzWyp0ckBACssHnRy3uhnVWj2ZOxIH1M2kn45Dk28q75fqzf1kWJilaq6UXvw5CF+4KDsUSv1JaCyhgKiNJfwwg/JPXoDvciTbW1lWqPVWalMqypTVSQ6XTkZOASjkIVmcVTmF9kQvoQiWJtttqFRAUJgI7XIAQCUg4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158983; c=relaxed/simple;
	bh=/ryQYIFUTHzpYuV9sox8nHApKeVCGCR77vTbdrQkA6Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZwadV27QxRZ2+ufIHRqnOOOphyDnI3JtfuwYzYL2ZynMCLV8zDMebtn16F/Caz/3ddTVTU/NcDL/ZTpZvpMiyNEeQ5+GTvUzoBqYutJNEUhjNSWzbau8WOZ0FJjWmcORQ7VCWXVo+eTVt7f7D2x6skiwoqewwUIDMeHPfPTGOuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KV8tWa+Y; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KV8tWa+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyncjzYNZbMKxQgo+xteENLFqxzjpRE+lOSjfBp/lUcm9fe0ZwEqm8S0YyIsLPv3r6RnL/CwSKd3gqkWMo6RiXWru9R8PDbDQZcLUzphL1RBAdro8/N8M6YR8wEvYl72Wby79QX/bWLZF2Jg6LvUH76ZJhuB/diUOOR/yuie5FSs4svUEwc814WZUhlbHUPP1kAhILStSEa2iB1tSLTb9U1p4Goo10+J+sdjZmrm+0Z+qbm917ro3JHmE6Mp2utINyHcVDox63mkoGNj59cVGlCf3fRQj9IVFPri6egtbY1v/Hp/zGj6pJMGi0kbG+ULpCvQXKofOctHxtN2owE3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9OVhW05jvoqUZNW2fVJ2tVNNzjDkaNr5pZGCyCDRR8=;
 b=BMbBDzwZbVSP3XPwda0uF55/nfmbLT3LVnKLYIfEScfovnmjznxSASztLi1mvyo9UZXJuZr/BjRk2X9Hooc28n85qoPz8wKr49Kvm2I95A5Ijzx4VaHeY+CbQsPPoT3sFlXKeXyqUjNaouFixEj5XZpbezquvG8cMmjaOVGMXLLKhfjj/nF/Mzg+DF21lNkqVYhFf3W41ICk33K7eXJE6rBjSew++oQiuBpOpxoek3K2TqvvMBY8ehGj4U5Q9JI8gDO/bgSVXx5sWv6ZXpPeOx4cVeuIb0chcF1GmbVn0YOzW07WAuepVJ725qmD93sSDbFbgauv7M73VF1sc5hyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9OVhW05jvoqUZNW2fVJ2tVNNzjDkaNr5pZGCyCDRR8=;
 b=KV8tWa+YdLLs+Fxzy6JOofr8A/JEmN/CyJ7ejSZHiyRM6DlMfRoC56gLOhYMObQ0eqcm11IGzXT5Oray3jZ912y83p2f2ezx4XnkMKaPxXvq82dTvEm17fRtBrBYDMeC1U9LadznkbUekzAPU6ydIIRzSPaq7d5ffgYIvozLOcI=
Received: from PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::13)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:29:36 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::73) by PH8P220CA0029.outlook.office365.com
 (2603:10b6:510:348::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:29:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:29:29 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 00/24] iommu/amd: Introduce AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support
Date: Mon, 27 Jul 2026 13:28:49 +0000
Message-ID: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a4adee-f8ae-4697-8bb4-08deebe319ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|82310400026|376014|36860700016|13003099007|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UktY9BmqZ+Eb9BsNq7zTHqWJMpnHT7YkNbvifPREmwaBd4z85J04yj++syLeO4JMjxqQipNdnh8z6J9bNYzdE3wWLPCcfhO48YAUbBYFunu00Qqn2FxNmVQw7GuujPsaYDhMVOwNVvvfZX9xAwTB1ggK0FIF9MTNI9a6f+yKdU9vhrl11dRhZ/E50cJAJT7pHiQdO4ArgNML4fYnG0YRSiZWKEJO6yGj0qLW7UryNBjPXTY/75Wmv/2fNbgitPRLzWtCNR6y+r4kDqvtYuimqMo3MM0rZ4ysMJEaxeQkT2XEQm+v9S0TNTP1TAjP/BwDH+slHv/xv7r4vzJ5U5+SAYieDHK1IxrbPTd5xLJ47Xyh5+dqgJYMtJFNNpfNdbIcWhPlqa13SIgbwlid1Iiap0dSCEk+/jou0TCiCFqLWwkdA2CM8dsLEYismXwie+yvk36+dBby6DNm4sEL3uKea1FXLIN3Bz7ffBjv+VLy11eqZ5a9QddpFBqvd+Fyrg12zz6Q/sNIWNmB9LqsESeh+l9oW6ZmJ/GPHcHwVASed3FuUSWlbbxlhkjMkSIThrcloUHTlmHqJszhT9Tt78ObfTMh8GvbHKr99413Eo0DS7SEfy3gYdkTig4U+SAB/VnfZei1ey8upTYqfeoqKbQOwA58s6Z0Q9OP/hxuRI7i0hdDPrHE+zxedDdFYyOK9PyBHMGqtfPgbQLoBjmfI24BpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(82310400026)(376014)(36860700016)(13003099007)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tvrmceG00r/mymaHl+SCZMHe/06mQBf7+90PJV5xD38vAHBsC8BXKdMZbkAbytz/zcgtBZHNsCwrYiUH7mYDxk1J2oXQIc2TQx5uLIlxCGoJ8Viy+zhahXUA7uynpDgw7qaYZvkYyK8PCajvVzqyrcvqN0Ref43EgTYxKSEeoXQzgrv5IOGkE8iWwq0/LSVq+N1aP8cRidVR0EhLpwxoOhBwjvw7MRgx6reDcM7v2N9BAC9h7vW1Rhh+MsKd3YvqbCkN3c6ucsF0xWDK+RHDMypI+WHqZIN5yLIDx9MjsXAhC2FVGsJsx/rMnO1PDIAOmkq0ijkxra5IPdJ/D4lZo8fxvOuSpwISjoVh4BiGYkDSoInRsZiObNqeGtHxCK0N2zZaFQZl8PNo80uLBW/rBuqjILylDF1I67nj/SN73FYroDfiyHB+oiXuekB4WXWT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:29:35.3298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a4adee-f8ae-4697-8bb4-08deebe319ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

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

This is version 4 of the AMD HW-vIOMMU series. It is implemented on top of
the IOMMUFD vIOMMU, vDevice, and nested-domain framework in Linux
v7.1.0-rc4.

The series is organized into the following subsets:

  Patch 1-3   : Preparatory patches
  Patch 4-8   : Introduce IOMMUFD vIOMMU support and VF MMIO setup
  Patch 9-14  : Introduce and map vIOMMU Private Address (IPA) region
  Patch 15-18 : Introduce IOMMUFD vDevice support for AMD
  Patch 19-24 : Translate-device-ID pool, per-vIOMMU translation DTE, and
                PCI-reserve relocation

Changes since v3:
(https://lore.kernel.org/linux-iommu/20260629153535.15775-1-suravee.suthikulpanit@amd.com/)

Series scope:
  * Grows from 22 to 24 patches with split of the per-vIOMMU
    translate-device-id work into three patches plus PCI-reserve
    relocation.

IPA / DTE infrastructure (patches 9-14):
  * Patch 9: Register the owning IOMMU in viommu_pdom->iommu_array via
    amd_iommu_pdom_bind_iommu() so map/unmap use domain_flush_pages_v1().
    Remove amd_iommu_flush_private_vm_region().

IOMMUFD vDevice support (patches 16-18):
  * Drop gid/gDevId from struct iommu_dev_data; obtain guest device ID
    via iommufd_viommu_get_vdev_id() when programming nested DTEs.
  * Use ndom->viommu->gid for domain and device ID mapping table
    updates.
  * Validate vDevice virt_id against VIOMMU_MAX_GDEVID.

Translate device ID (TransDevID) - pool and relocation (patches 19-24):
  * Track allocated pool slots as pointers to the owning struct
    amd_iommu_viommu instead of a separate ALLOCATED state enum.
  * Move translate DTE / VFctrl helpers to patch 21;
    amd_iommu_set_translate_dte() takes struct iommufd_viommu * and reads
    trans_devid from struct amd_iommu_viommu.
  * Patch 22: add amd_iommu_trans_devid_alloc/free() with vIOMMU owner
    tracking in the per-segment xarray.
  * Patch 23: assign one translate-device-id per vIOMMU on init; program
    translation DTE and VFctrl TransDevID; add trans_devid_lock.
  * Patch 24: when PCI attach reserves a BDF already allocated to a
    vIOMMU, relocate that vIOMMU to a new translate-device-id before
    marking the BDF reserved.

Testing done:
  * Single/Multiple vIOMMU instances
  * Single/Multiple VFIO devices per vIOMMU instance.

[1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
[2] Linux git tree: https://github.com/AMDESE/linux-iommu/tree/linux-7.1.0-rc4-amd-viommu_upstream_v4

Thank you,
Suravee

Suravee Suthikulpanit (24):
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
  iommu/amd: Add translate-device-id alloc/free with vIOMMU owner
  iommu/amd: Assign per-vIOMMU translate device ID
  iommu/amd: Relocate vIOMMU translate-device-id on PCI reserve

 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  51 ++-
 drivers/iommu/amd/amd_iommu_types.h | 105 ++++++
 drivers/iommu/amd/amd_viommu.h      |  60 +++
 drivers/iommu/amd/init.c            |  23 +-
 drivers/iommu/amd/iommu.c           | 290 ++++++++++++---
 drivers/iommu/amd/iommufd.c         | 134 +++++++
 drivers/iommu/amd/nested.c          |  38 +-
 drivers/iommu/amd/trans_devid.c     | 329 ++++++++++++++++
 drivers/iommu/amd/viommu.c          | 558 ++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        |  10 +
 11 files changed, 1543 insertions(+), 57 deletions(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/trans_devid.c
 create mode 100644 drivers/iommu/amd/viommu.c

-- 
2.34.1
