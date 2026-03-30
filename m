Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396F3AE1A0
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860171; cv=fail; b=A00t8pf0TRuxm/CSZIeTXhY8wldhATm8x426e4yqgjdTjXfDmb+nTaWRXmwZ0qgdMp4u0cWvL2ZGrCncTwhPW8l+T/AdQb9ZP1wPTNtqL8etwGOaqYcFpsbmA+wM9MyjXfK5qfipsiDi1miYw9EXepvXfxK0RL5s+TPzRzEZ9g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860171; c=relaxed/simple;
	bh=N+ThP0wFChho+WFCY0AgB2CsLl2Jx2vL4hHlb1bvMJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=inUlJr2VmHGusO1qfQA3fDKoVK7gFWZFYbRDEi0+7PPWfH9rzpKOIIP7OoCqiuFAmbKeWotLlH1p4QLtY8lIhSSznUwaIC2xaoqCcaSG8Y9o3+4gVBpZZ08KCDkL0lDYEP+cuhYeovTFrlB70OwODwpu81LwxzShx/CiFKUR2hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bfw9WdMY; arc=fail smtp.client-ip=40.107.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bfw9WdMY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1Erp8edVpYnpC4vVwQA+22IQSuKX0IpOeKhwTS0zf3OlEnjC147GFn/c4KyeeH5+MJ5r2jRzaTtXvY6wWErMENJpaCiIAPrKjh2Nx5v1O3qmt1bmKuorypsMaYGMq43VYLoueYx1dhFqWdtSFPs+WxVhfmu8NZ+mA7bKR/FeP7tTOIx45WHTbOFdrIB5yR5fXkO05Wozx+dNokljl7cGlLUN4NF9LP3m6AGz7t0wQnbKAYt+flZlG4HYfiPGQUCcu+5pzv7BD0jPSR+VyX5zNz3i57iWILBPsey0XRwqjJIxVkqrgHfo6cZYePM6F2P5hqx6GzWrmCVh+6JtXCwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/Fz+wydhdSkxokoLpFGH7waDgw6XXtNQtu3K2m4yhE=;
 b=TJaskBjxoxuHjF6yxSWITHNQA/1Ia95XiC+kFYnZngxgcmjHabsJwwTql5rdWbJTA1CVfJPvHronO6VPjkJYA3HHfUw3kSjJVbgkN0mk4fZC467k6GY9B8A+hY4XFW7PRWPbslV5NAhMcq8FefWyrXa9dS3MjXLtxJCFXfCR8878dPOgxt31Dj+TdkXf5zCCAELFQhtBchMQXVA3X+VqvAyzEPYo+1u6IY6+P8fIiy6WCwpC/Mvm1/i8bcCPEJIKj/ALLXQuKYv/d6ZEZGqD/KaX5tOk1NAsG+3H9YQYLl8wXmP+LvyAFgqy41ARPXJ8zg3SD64/bb2pfRyagk/9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/Fz+wydhdSkxokoLpFGH7waDgw6XXtNQtu3K2m4yhE=;
 b=Bfw9WdMYgh/6S9fltS4dNQ1uxvapvhmnfWBpUHgyJvoC7De3y8tHTnb+rvwX0zBMHYySb67fLGh6nN8E2w9yICq4VfEfij5AtoPJFjpI9tYnlqyVrDPdAHsxOGJKExQ0HndE5+f8WnmJAsyn6fvD1j2WXqo9jd32s6ZpFSRYWSU=
Received: from DM6PR08CA0005.namprd08.prod.outlook.com (2603:10b6:5:80::18) by
 IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:42:40 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::ae) by DM6PR08CA0005.outlook.office365.com
 (2603:10b6:5:80::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:42:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:42:35 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 00/22] iommu/amd: Introduce AMD Hardware-accelerated Virtualized IOMMU (vIOMMU) Support
Date: Mon, 30 Mar 2026 08:41:44 +0000
Message-ID: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: d577c997-5bf0-45e0-74f7-08de8e384dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aEHjyHQkX/F+yJb3IzorEu+jH+Qd+K1+AVyR9Xyjw5Agg07tKlv7AeWsblQVU9tAJKa2kp6WHWN1xDi8wbzRYSz+3QJdydAeNz+j44fBKWp5uVfzXVfvLXbub+bHhQxJTU9zSzEJeOChZMVT/MNeODRYpSbdsRN+fHT0R2FCykmnyadM5wh0Uh1NbE+xDqqFzqdepfQx8oZKCZ23Usi0jeCpn+f636EqAzsxOaYhQMYV+LmTcFsfo8sjqWiVEdMErDDSz7nWSfA3biEnoCEVErMlkd3tRPM5pSWEBPIMa/QWBDBcboSxiN1lILAeZyqDKErhoDaLNZ+cCID6Tm0zJIRt/cuRDWAr6kpPGAPenKxfXYA7T4swiMG052bRGgtZtYsPXP9ONMAo3Uwc9E4c3WxsGxpnNb1i8FRc7qlI13tH/8QnCF7sgK5GhIJQN6R09DIqT46mWRFLvOH/yGD4siOPqH497Mn0WwFOmLnKYyZxWUwB5HZPlKcn+fId/ThK2aGHkBstYStFhMXYQKrNAvCf4sFbuDLQYCW9MdoeU37gh8Eqqqe1wvip9KaCTPCI6jL8MwDbihV1oeN8EWyBz5CnqcDdYEJE/McfeI/KUSZHbccjw9SeGNTUegfG27et5lIk2yOxIgqM0qDobHYKO3wRMj1UHdJmi9jh1qdmt1q6KpNy+e50n97u/STVaCCHC5QKONkVk+5+8JbCuUzdaZPK1OCqEfC0X3z5IKHIMb4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iV0kQpdpiGajLtmjgVc+M/1g4y6HrrHp9VbSg4+Sr2+jYON4PsZcb2/6sFMj/05+rF7ERpyf/B9BORHGZ8HoYEzcNOfUQa58+HMDM+zQlKV5k9WFLlSWJ2yZbSdxD+G2Q5GCYmy2MEKUFbJEZysjpO/RJC13LmKXsKVqhaYTTQvue4B9yeGMqBrYvbD8AcHQTI/nMEvBx7+cavMjThYA9dxDqqqY1pcojrZ2XtrgamuYwK9rr7efUjM86lgzWZp1LaOafogrLH2LjpuZoFuA4EUV+QiwYtCotJmlbD3nZvpqRiGzjcWjb7nF7UoGwUV4AESaLx470uliMhGluNuCr55jleBmaF0WRi+ulzsujU7KGY8Ecfg8AppQNsXz22F+2frz/E+VOb3D70IN6iNJPvAbnxXQD6Cy0baO+fdfTpGMnYoUUYNXlbpq4ORaiIop
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:42:40.6687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d577c997-5bf0-45e0-74f7-08de8e384dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

AMD IOMMU introduces the vIOMMU feature, which provides partial hardware acceleration
when implementing Guest IOMMUs. This feature provides acceleration for guest Command Buffer,
Event Log, and PPR Log. This eliminates the CPU overhead needed for the supporting HV
intercepts and reduces the latency of these operations.

When a guest attempts to access guest IOMMU MMIO registers with offsets between 8KB and 12KB
(i.e. 3rd 4K region) such as the Command Buffer, Event Log and PPR Log head and tail pointer
registers, this is serviced directly by the IOMMU. When the IOMMU accesses a Command Buffer,
PPR Log or a COMPLETION_WAIT store location in memory, it directly accesses guest physical memory.
The HV/VMM continues trap and to emulate the IOMMU configuration MMIO registers between 0KB
and 4KB (i.e. 1st 4K region), which are primarily used during initialization.

Additionally, the HV must initialize the vIOMMU feature, map MMIO resources between
the VMs and the IOMMU, manage additional supporting data structures in memory (e.g. GPA->SPA
translation DTE, Device ID and Domain ID mapping tables), and allocate/map vIOMMU Private Address
region used as backing storage memory for the IOMMU. Support for new IOMMU command and events
specifically for vIOMMU are also added.

Guest IOMMUs are IOMMUs exposed to VMs with additional support from VMM (QEMU) to generate
guest ACPI IVRS table and define guest PCI topology for IOMMU and pass-through VFIO devices,
which are not covered by this series.

For more detail, please section vIOMMU of the AMD IOMMU Specification[1].

This series is implemented on top of IOMMUFD vIOMMU, vDevice, and HW-queue framework.
It is organized into the following subset of patches:

  Patch 1-3   : Preparatory patches
  Patch 4-5   : Introduce IOMMUFD vIOMMU support for AMD
  Patch 6-8   : Introduce AMD vIOMMU VF MMIO and VFCtrl MMIO
  Patch 9-13  : Introduce AMD vIOMMU Private Address support
  Patch 14-16 : Introduce IOMMUFD vDevice support for AMD
  Patch 17    : Introduce AMD vIOMMU Translation DTE
  Patch 18-21 : Introduce IOMMUFD hw_queue support for AMD
  Patch 22    : Enable AMD vIOMMU support

Upcoming Series:
  * Add Extended Interrupt Remapping support (for guest Event / PPR log interrupts)
  * Add Guest Event Injection support

Note:
  * This series is rebased on top of v6.19. See [2] for git repo.

[1] IOMMU Specification: https://docs.amd.com/v/u/en-US/48882_3.10_PUB
[2] GIT Repo: https://github.com/AMDESE/linux-iommu/tree/wip/linux-6.19-amd-viommu_upstream_v1
Thank you,
Suravee

Suravee Suthikulpanit (22):
  iommu/amd: Make amd_iommu_completion_wait() non-static
  iommu/amd: Introduce vIOMMU-specific events and event info
  iommu/amd: Detect and initialize AMD vIOMMU feature
  iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
  iommu/amd: Introduce vIOMMU Guest-ID (GID)
  iommu/amd: Map vIOMMU VF MMIO and VF Control MMIO regions
  iommu/amd: Add support for AMD vIOMMU VF MMIO region
  iommu/amd: Introduce Reset vMMIO Command
  iommu/amd: Introduce domain for IOMMU Private Address (IPA) region
  iommu/amd: Assign IOMMU Private Address domain to IOMMU
  iommu/amd: Allocate and map vIOMMU private regions
  iommu/amd: Add helper functions to manage private address region for
    each VM
  iommu/amd: Add helper functions to manage DevID / DomID mapping tables
  iommu/amd: Introduce IOMMUFD vDevice support for AMD
  iommu/amd: Introduce helper function for updating domain ID mapping
    table
  iommu/amd: Introduce helper function for updating device ID mapping
    table
  iommu/amd: Introduce vIOMMU Translation DTE
  iommufd: Introduce iommufd_viommu_ops.hw_queue_init
  iommu/amd: Add support for vIOMMU HW queues initialization
  iommufd: Introduce vIOMMU option via IOMMU_OPTION ioctl
  iommu/amd: Handle set/get option for AMD vIOMMU hw_queue
  iommu/amd: Introduce logic to check and enable vIOMMU feature

 drivers/iommu/amd/Makefile              |   2 +-
 drivers/iommu/amd/amd_iommu.h           |  26 ++
 drivers/iommu/amd/amd_iommu_types.h     |  78 ++++
 drivers/iommu/amd/amd_viommu.h          |  67 ++++
 drivers/iommu/amd/init.c                |  27 +-
 drivers/iommu/amd/iommu.c               | 204 ++++++++--
 drivers/iommu/amd/iommufd.c             | 170 ++++++++
 drivers/iommu/amd/nested.c              |  18 +
 drivers/iommu/amd/vfctrl_mmio.c         | 145 +++++++
 drivers/iommu/amd/viommu.c              | 498 ++++++++++++++++++++++++
 drivers/iommu/iommufd/ioas.c            |   2 +-
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/main.c            |   6 +-
 drivers/iommu/iommufd/viommu.c          | 143 +++++--
 include/linux/iommufd.h                 |  10 +-
 include/uapi/linux/iommufd.h            |  25 +-
 16 files changed, 1343 insertions(+), 79 deletions(-)
 create mode 100644 drivers/iommu/amd/amd_viommu.h
 create mode 100644 drivers/iommu/amd/vfctrl_mmio.c
 create mode 100644 drivers/iommu/amd/viommu.c

-- 
2.34.1

