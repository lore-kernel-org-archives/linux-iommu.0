Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BDD365A19
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182443; cv=fail; b=XJYmgtfsSDC4vRuPlVbeMFzhpJHuA9bKwAqyG/ExxHUdYgOlcgGNCK0tqV9FwCQYR7u08CrThehsIzp4OaoQFDlsRSpPNbv1Bue74K6ByR3lw9EUscnQ5O7wHoCJxygWKUaDzdg5I7AKIfAydOmvt9BWm4rG6hHPRbxkdDzkz1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182443; c=relaxed/simple;
	bh=ibhAuucKdR1g8du8xhZfUsFKy+6WmvNj4uhgIk++Ib0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sIj5SO/VAGK/Vq6LOUinN06MN/PvBKM7hDgCG6OVBtcw6730KqNPC9AZ/nOkeGx2pwLCxJxK8BEa26CzX8GLcKM8jpwc3kI8STddHgNbpEsksHmYmgJ4vfdH49a2aVoKdEGgo6+/0irr8FzyXmF+rbeGHmN+cwhZqWpKlyDTJY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lnc2zZma; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lnc2zZma"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwvG2qhUk4Xr8yQJMdLuUUpHrH51JxH8NwGfNGTOXKYCA0PoSEXy+OFJ35P+8CNS/JFH1DDvRW5I73m2R73ALndhV6d0DQ/rA84iBWrVnLZQlozdyTeJDJY5bcHFQCrEvGAGUEHBU+PdU6w7WYLvfe8XhmxXztsFjvstia+krb3i2kJUrnfUItb4W7urztvZceCyjrQ2QRO5b8K3TzAzHVbUSx5c/bqpa59Edm8yXuCt++/5liaLIbj9TLC0mSxFQT9YylL1mk/M8YBrjdbb1s6F49ZpZlI4fzR/h9lJT/cTY9HOmHZA7nZsGikh6dfzdZH6PpTV1ByGZ4IMSpjkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvM7MByXrJFG2taEc9TfZZq4wWUIUoKdPVHs+kH/ogk=;
 b=Dh9ETG0x3cVw0JgXYbqOR5L1MRI5ZH7xrHmFzbos+gF4+TBtZlM3qbKbclk6KgLRKZS/14AeK+95AuvfY4vR/vbTeTzqXNe8n8JRZatxHA/vrQRs1GYCvTLNNwPXi9Hs3GVu/fk5JpsU0KEePSjR/CNqYsajh4mrmbwDOCzh38rQY5YiBooFJKsW5XOA8Qx3vreQxZrL9PSNbgVSRLdiknOqlw5myhEdLllBEX5D3fEklhSHLa0XbkblkxfiCaSsFwukCTfn2xpcg92S/84pfp4a9S+HqDq6Ky6unAzobFTGda8mC3BlMcon1fkXo0sythjUJ1Z5OI9nhpsXWxbCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvM7MByXrJFG2taEc9TfZZq4wWUIUoKdPVHs+kH/ogk=;
 b=Lnc2zZmaw8+Cf8tK3hoAQCby577oxwtDlAZ+tN65pbdIWs8w1eVm5y7HliCHkFjA2sdl4Fqmb+vjfokOTfyvDm7yT6tzQRJu+Szomyu8AKsnf0+REYeMu2HGPUNknMgC/PX1TjEqdGPSOHuumDaN8UevmKXOGAZJI/e4dj92YkY=
Received: from SJ0PR05CA0196.namprd05.prod.outlook.com (2603:10b6:a03:330::21)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 06:40:36 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::7a) by SJ0PR05CA0196.outlook.office365.com
 (2603:10b6:a03:330::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 5
 Oct 2026 06:40:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:40:35 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:40:26 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/7] iommu/amd: Implement live update state preservation
Date: Mon, 5 Oct 2026 06:40:10 +0000
Message-ID: <20261005064018.1558-1-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b70e0e7-f2b7-4d03-271e-08df22ab9000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|7416014|36860700016|13003099007|18002099003|5023799004|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	dZIy80wxZSIln+CZEvNvkd5eQFqcgNgLD206VO42WYjPv5BhWyUbJlbifR06YI4nla222TCm+ekzi4epb7ORjucBhb6QiI8vhc5KtItkjIajC/++p3YlZVxg5bQvK7agk2quba5jhB0w55ab4T85QhkgIUdmu8+YoVqYP0UvMrw8Npv5DoGDRbitBvXfid7RA6c47/Nzp6ytWrh7kUnAoRKDMPrenPvGvCEFVJCGxqw+o/Fl6fV6oYikmWB7XLscPXbEGMPORATk5VWEBnhfPTNBIbzT9LrpUUdmaIN1wtTMTHbbrs9L1i3O01evQIk321UOv7pa17fs+f6iBTjSqG2Rz6tzMdZ/2ZTxW1Bbn0IX17HgDNxrjJMKI2jZfPGP+cBYjzSBXWk2vplEDVjk7615z5MlczzREfhiE7APyhFKw924QvluoDGL2M2jU4xZxtEsWUtMCoowO6J7GnI+/o+va4gF+MCO+fN1OAo4o2c4LEK2LLhftY6yuWCEA6PB0pXSKHLWhb0z5gj0eaFcQTtuMyfVCqkSGuK36xGW5JvhSVtH3pyL0AzRMRBz9J/D1odQR+9U+xQMtxcyRNhoVAxh3A7B+i2VVtV023QK8XnT5btb4bHcNU6hE0EnkFgicTzv7EqKrgRsgCFlaFtp+pR+8Zr5y5RJ48Z9sgLCOQs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(7416014)(36860700016)(13003099007)(18002099003)(5023799004)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lic8PUoimXDc8vcWdNoEDHoM/TlBlWKs7vCQB39wBmBZge9++opx1UZHS1EfC1d2TeRlwaq8lQQaKFwNW2D2UeR0R+CZVt68x+rHC834HwjWzx2Hhn4rTEcbOORSAI/cyc04m7OByJ3v0HMtpm8kGKwQjIsHhE11rVKCSuLENvlM7vMu3M6HX/c8UKDDqz0iPdNkepn8Om701vcFQdpZphFK3LgBWgYtjGUkN9foUJo1pqL67suY711VNkhrPM3ZXdIAa7jkKnaggt+uqrTurMPxo/W/HKW52R98KVgMUDCigcFMEzvXGF9/EzzZBIbO4R0EvqZsn7yL7KwtAWIghw4+xYAq8GcPwQAAsbaJlyzxfeM/1Tp04xDCHYxztwvkerRLXFhT+eb7g+D+tJXsSeSEJ+kz6UUXHbbxpc4teSI6zX5ZPr60bkCElZBYP3be
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:40:35.9265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b70e0e7-f2b7-4d03-271e-08df22ab9000
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814

This series adds AMD-Vi support for IOMMU state preservation across a
kexec-based live update, so a passed-through device keeps its translations
and keeps doing DMA while the kernel underneath is replaced.

It applies on top of the IOMMU live update core series v5 [1], currently in
review, and reuses the FLB preservation mechanism that series introduces.

This is an RFC. The reclaim path is not included; it depends on the phase 2
iommufd work and will follow.

What is preserved
=================
The Device Table, adopted by the incoming kernel rather than rebuilt, and for
each preserved device its domain ID, page-table mode, and GCR3 tree if the
device uses PASID.

What is not preserved
=====================
The command buffer, event log, PPR log, GA log, GA tail and cmd_sem, and the
interrupt remapping tables. The incoming kernel allocates all of them fresh.
Interrupts raised during the window are lost, but the data and the completion
records travel by DMA, so a driver finds the completed work when it next
reads its queues.

Disabling the PPR log also disables PPR, so a preserved device cannot
raise a page request across the window. That is safe only because an HWPT
with a fault queue cannot be marked for preservation today; if that is
relaxed for SVA, such a request would go unanswered and, with the event
log stopped, unlogged. Whoever adds PRI preservation needs to revisit
this.

Architectural overview
======================
At preserve time the driver pins the PCI segment's Device Table for KHO and
records each preserved device's domain ID, page-table mode and GCR3 tree.

At shutdown translation stays enabled on any unit carrying preserved devices,
so their DMA never stops. Everything else on that unit is made safe: DTEs of
unpreserved devices are reset to blocked, the interrupt fields of every DTE
are cleared because no DTE may point at a table the next kernel can recycle,
and the command, event, PPR and GA engines are stopped and polled until idle.
That last step matters because the incoming kernel may reuse the pages those
buffers occupied, and an engine still writing after the kexec would corrupt
them with nothing to attribute the damage to. If an engine does not go idle
the driver panics rather than complete the handover.

On the live update boot the driver finds its record by MMIO physical base,
adopts the Device Table, and reserves the domain IDs it describes so a new
domain cannot alias a preserved one. A unit handed over translating is left
translating. When the core probes the preserved devices their domain ID and
GCR3 tree are adopted on attach and verified against the live DTE; a mismatch
fails the attach. A restored domain is immutable, so a preserved device may
only attach to the domain restored for it.

One generic change
==================
Patch 2 moves the LUO handover-tree parse into start_kernel(), immediately
before late_time_init().

AMD-Vi needs this because it is the x86 interrupt remapping provider, so
amd_iommu_prepare() runs from late_time_init() via enable_IR_x2apic(). It
queries preserved state from three sites on that path. LUO parses the tree
from an early_initcall inside rest_init(), so those queries run before the
data exists and cannot tell "nothing was preserved" from "not parsed yet".
The driver then disables a unit the previous kernel left translating.

Note:
ATS and PASID state on the device itself is not adopted. For a preserved
device the attach path still runs the normal enable sequence, so an
ATS-capable device would have its ATS Control register rewritten while it
is doing DMA. Adopting that state is PCI core roadmap item #4 [2], so this
series leaves it alone rather than reprogramming the PCI side here. The
restored DTE's IOTLB bit is checked against the device's ATS state, which
catches a disagreement.

[1] Samiullah Khawaja, "iommu: Add live update state preservation" (v5)
    https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/
[2] David Matlack, "RFC: PCI core Live Update Roadmap"
    https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/

Ankit Soni (7):
  iommu/amd: defer device attach only on a kdump boot
  liveupdate: parse the incoming handover tree before late_time_init()
  iommu/kho/abi: add AMD IOMMU live-update serialisation structs
  iommu/amd: preserve IOMMU and device state for live update
  iommu/amd: clear unpreserved DTEs and quiesce logs at live-update shutdown
  iommu/amd: restore preserved state on a live-update boot
  iommu/amd: reattach preserved devices to their restored domains

 drivers/iommu/amd/Makefile          |   1 +
 drivers/iommu/amd/amd_iommu.h       |  34 ++
 drivers/iommu/amd/amd_iommu_types.h |  14 +
 drivers/iommu/amd/init.c            | 253 +++++++++++--
 drivers/iommu/amd/iommu.c           | 144 +++++++-
 drivers/iommu/amd/liveupdate.c      | 543 ++++++++++++++++++++++++++++
 drivers/iommu/amd/nested.c          |   8 +
 include/linux/kho/abi/iommu.h       |  70 ++++
 include/linux/liveupdate.h          |   4 +
 init/main.c                         |   2 +
 kernel/liveupdate/luo_core.c        |   5 +-
 11 files changed, 1039 insertions(+), 39 deletions(-)
 create mode 100644 drivers/iommu/amd/liveupdate.c


base-commit: 1d195de0e8caf627e93c0a39af1e84bb19e3cc53
-- 
2.43.0

