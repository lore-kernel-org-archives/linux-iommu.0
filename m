Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F410299943
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 21:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152718; cv=fail; b=cOdyS4ATzTAYd8FXeANI1vagcCxLstvNGyg99NnySJVQCrXZXy3OyD8zY4Cw7KUpUGrqc5AxbSXrdyxVResNN3SgmkOtvqGeGkBkbBs2nwroLQRs6QdEnPHULn+MTmlEDvuWg2x0x4HiiToClMhCd99zXT8CyRTL/7F82mK9fEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152718; c=relaxed/simple;
	bh=mTSkNjISZLmbbdc6csW8rILLC9BWayMTIWX/1/bLr9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kUn+w4RePVcMKV6kzeMxW95nypkG93Ncu0mLCvSMhAqcd9aqA4U2iWpOagAjDN9Odc40SNFpjDXN0rY1/koWHRO3mRFSAefc8EcnAP35NbmRWeuLXoUiU9uxa1AOtAzwZh7GY0BzwcEMt3LEyeye2C2zywMJbh/wAFg8VcZADw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YhgbXGJM; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YhgbXGJM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lx+JBnqwh5qGGLN77jFYkbt0kBIyBQVV+J7ZAoIae1PUylyo0WHTurQ0Fr+Lj4EceWugMZAVyUsUNiDZ9vcudmwyH1Uaz2ZRnlVIAu0GGBpeBdH1Fi0bRrWycI6vE2lXwr4lyocS5EzmxciNiigphqAZ0STGhwpD5vlB39HnarRqUjycZSdQdnU4307oaZJfwZAtMZZs/9lAxWxtbtsBOw37sL3ydh2eByJc8Fwb4hq7bRnLW76BoTV1FmUWsk92B9xYSzflAC3XioPdZgTrS3JYhwRVkkhcbT9tsLY7jHXDfuZxtWGs9oPPYMQh/bL+udypBI+D0f6ApGNAbCY+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrnCyTJeLXMtVV0zOBWz9CO7ESxh0TpqucRAORxcEDE=;
 b=eNU+eHZ7wtRD8KApke7IdJRPZDif95q1WYreWp0gl0C1bFbwpJ6dp6vedXx3OdEklEPZFGQEC/axeDDnf1mT4uCs8tH2A3/saS2+w0/0R/J8BoM7Wll4AFrjjvm0t5KG8PJEKQB8ZAX8q4cBEqSLDt9xsxVBC7WDPDtwPnI+T7hbeUPluYtbzGKNvf6gppTMTBCJKZXAYdHvC3WBdqRB0j9XeZ6t31zeRvqkmlZSv6wtbNo+G3g7Uz/SHTNAL/vFeOe5s2ylC2CdSOKN0sPSvnuS/gJM7v+0S7i0vOdhNccPO7lSh11fHtVZJ0tWSRPtL/Ic0+0MR9Z9JAs4/1StLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrnCyTJeLXMtVV0zOBWz9CO7ESxh0TpqucRAORxcEDE=;
 b=YhgbXGJMsN370kbXle+FZ1Dl6/lxoNsNBIqRzyBpe46YPTVQs+epT9nWN3og4N/haAWbk5u7bTSY5N1udmn2L3ij3VyoCGdZOHoHtpoU3j/a5l7AkMHPvIsRvkv2BThYSqNXKTw3zdTFrUadmc+6476LYjC0v5FDa81UKG47F3mLujRULg0L2QdqioRpXXbLCdepiXNZFPmE1M31UP1aMwCGMiIkm/S0ZlFQoa1b3sa06v695vQlGEVS3aYewsgasUtCYlON/CJ3gu3Rtl1LzMK8B1o28ptyDd4+IvnVaCDcqb1UYapNPdFu/pVgIlvudogg0bkqOYwa45iUBVMjfA==
Received: from MW4PR03CA0152.namprd03.prod.outlook.com (2603:10b6:303:8d::7)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 21:31:49 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::6f) by MW4PR03CA0152.outlook.office365.com
 (2603:10b6:303:8d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.24 via Frontend Transport; Sat,
 25 Apr 2026 21:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sat, 25 Apr 2026 21:31:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:38 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:38 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 14:31:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v3 0/5] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Sat, 25 Apr 2026 14:30:45 -0700
Message-ID: <cover.1777150307.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: c31c98fc-4d86-476c-9c01-08dea3120f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TEeIPzX5hO5t40yZtHn1eEs5QNge88/W9EUStU8cAoUqTSQ87tjbW2mwc0jwJ0Qgm7PKTRRSSszLt/4d1IzsxA0vjiZgW5yNnSQ8XJlgojsioolXYFOaWeO5oHrBhL29kiI6BzOVKkC+7VsUyOgtqYy2gw0LHhfkjoc+I/MmFSFKWLVLUH29A9xwht/2ZQzgROkcPGOXlVn3I4pA2X6Tujq7ErsYFEeAEGAVNoBv86lMDbsVez6mYvTohrGPHmYWXMJDwNUPAnXBKVWdqTTrf4pSbiaJGeYP0uIrT9TrS4WkdzgB8tUH/vy7q40RSrmhLCcsrKiumVNjPEzFtqIaFbriGhjQ4yWNC3LhHKbw7jD9hkfCqDtkIr6YRnzgIQIquYVIqsTDtFOEvYJQj8Fg6Qo4dqF28rou3Jsp57vhcjp5Y6T7aNyKWXs7oMq0T88x4yhBkq6VLbIzj2SYQgdEP+/oVlb/j7F+z0se/MwpGL8dfCMBBA+ce9gcuUuxpXrQq3ciIOejGyLYxmIjwBnuo7sNFH4EKbjqMPtDlYUIUM1qoTo5cMAFoGcccIXOqLvqsgBX343P6h6iNNU0t1kyfJFQe9lkd3ecvOj0F+AY0jv03qSZDk5SU0fdmfMiYTQiPYwBxrUpWoPEC8uhabOfBn7qp3GqaISlHTX/wcJErn0A/MVMdUXL5xWf2T6LsYB2BcqmTbhwSVLS0OF7CSdSaM7S3kTdxgGResTEhEQVMO4lXCW3GTHpeniZMPN1RlJEcIC1DXq5gRLYJcTi38dlFA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l2iV2ViYcQTd8IRtDval+zVbTTzw1XrrcPgPSCzE1P0axFzm4/djfWWaKzgvV72NU+whEfr+i4IY4JplWiWfr/L4lVwLoZ1y+vY5SQR8+jnlKnNHzD0tvAbXFLrjKkKYfyIl0hZ4m+Xj3pZPl1d+o4E63JGqqG/I2V31T9XGt3qXhgTAPfgkase8PkSHlRtT44R+04IrI7LdokDxYzJj7QMRkCffTkWeFozXPr67KGdnNjhz+AcMY0A7E/Wyokf14iF7AcprL6kSZ6EDThUlXFlW9BTgHIG85SWFlO62h2tm2leulMtZjgcCiMcYQK5N+5fCX3zZokTm0+wnNUAQnxbNsXjDhRlZ2eT0lyKOJPw1z3MXlwpVygObbTxLbCBZ83QEQJkomnvTb6AiwsYv+Cgzbo1E1j0oabw59m81+kCN6RqJ2WYUaybNs8ETDOQD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:31:49.6448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c98fc-4d86-476c-9c01-08dea3120f7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
flight DMA using the crashed kernel's page tables until the endpoint device
drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

In this series:
 - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
 - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
 - Skip EVENTQ and PRIQ setups including interrupts and their handlers
 - Memremap the crashed kernel's stream tables into the kdump kernel [*]
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.

[*] This only works on a coherent SMMU.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that the series requires Jason's work that was merged in v6.12: commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
I have a backported version that is verified with a v6.8 kernel. I can send
if we see a strong need after this version is accepted.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v3

Changelog
v3
 * s/OPT_KDUMP/OPT_KDUMP_ADOPT
 * Do not adopt if GERROR_SFM_ERR
 * Retain CR0_ATSCHK beside CR0_SMMUEN
 * Clear latched GERROR bits (e.g. CMDQ_ERR)
 * Assert ARM_SMMU_FEAT_COHERENCY in adopt functions
 * Add STE.Cfg check in arm_smmu_is_attach_deferred()
 * Fix validations on return codes from devm_memremap()
 * Sanitize crashed kernel register values in adopt functions
 * Drop unnecessary l2ptrs guard in arm_smmu_is_attach_deferred()
 * Don't enable PRIQ/EVTQ irqs and guard the irq functions for combined
   irq cases
v2
 https://lore.kernel.org/all/cover.1776286352.git.nicolinc@nvidia.com/
 * Add warning in non-coherent SMMU cases
 * Keep eventq/priq disabled v.s. enabling-and-disabling-later
 * Check KDUMP option in the beginning of arm_smmu_device_reset()
 * Validate STRTAB format matches HW capability instead of forcing flags
v1:
 https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/

Nicolin Chen (5):
  iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab() for kdump
  iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 358 ++++++++++++++++++--
 2 files changed, 338 insertions(+), 21 deletions(-)

-- 
2.43.0

