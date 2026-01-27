Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945733A702
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540136; cv=fail; b=Z8D1kRAjJ4K4dHKd3bSOwJFU/bwyP+r6Jlq6wgtbcXb93L16JAUPC1pbSHP+t3//eYuCsVkdx9M3G48ckEIkDhHp6Kc7nrF3M/lo4iTPMDlk9Stw2Wy5JJCZxCXqoq/fWh6uVfpF9o4ugdjNLVZYU0r/CWif/k94tvPWbtQAmeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540136; c=relaxed/simple;
	bh=thnVHLxbk52/Laoo4ICQXdyw9mjW5nMyuojD0fvemys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vETZgvUw1+ZaoLBdh9qRVsdi/3IXOecAWtaiojoQZZrOQq4Fqug91jNXgZQ1A347xGhhxCSBq/Pcw1Cvyh0KT5dR7d/VCRITa3XAwRWdb2mpPlq9rjP8Noy8QEuSNPhT5w1CSBU3nVkUwPJLkcOdG7iMErPdFkKBrWfSlvbc3bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lWEfISrP; arc=fail smtp.client-ip=52.101.46.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lWEfISrP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/RqzE+hFyIcMf00ot3hq+GNQSfo8F8Y5sPrscYB50Md5wDx6vAwzyXCkHa/glF6wxSlZHlR0cT7xmSSP96TALcWz2jwDCXMWsVIBn28F8b8qoPCJLk0w4sxJzwIZrGvu2+bDyWjbS4ltDXgQSkXCqHyKZf8YWKAi0cn10yd4BMxef6NH4leLTUzDcJVC3kOoLDXLSQfVpcR/cQriqZdX2z4mzMCV7F4L/qpP/8U2ph8uJLCbC8ri9UqH7uVyBhYLkWcSWoC46qS/hBcaQWkJN4oQdg/anC57WvGatpLhAMNjeh1ipYe6ccxmbalUqUdcglmaP/69592iOBLoRa13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1E/cvogoyHb3UckPwxzDKOamoBYfYupIi47Sarf+k4=;
 b=tdV9oabmp1XGStaO36yk/t9GooC4qFdNqAuWWEwRDLJH/mw25s6bZSalavQUoArUTPgQ9VLUVIS8qvyRdbY04stKfkQjBsRbymRhecA2RidroO0Chnn0fsItNuvQfv883mBWPqAMajx0TeMODVs0PMvm2/ugSUGrvOZ41C+xbDzDKHF+OE1p5zCWc1XT/vmUezAS+BQQ3btQFXhBBlDERSuxQ0x31W5ddlKC8AgqehcUa7UExi1IExWxailQ2Zyq/2YlAcAcEtHTS5I+3Glxn4fMCpelzkVpMiBpN9gslgtDPN0FRbxjUJupJeaQ0HIlinARhtVRUCf8EoOW3P4xbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1E/cvogoyHb3UckPwxzDKOamoBYfYupIi47Sarf+k4=;
 b=lWEfISrPy0N/2frTkuPLVEufYtkaXvnQtCOfs3C0Z9P9hRF2vXHZ0m/tyNEWez0hjYRvb53m9tZERwF0FygZF1QmdL2PiyUQZR8g2dfVuD/KSYYInFXdZODFUZcJ9Awyn8e6sPrvb+3GocHifpZStlxLAT+9ac1tFOqdOgzf6DQACZ05JQVp/VfgCRGZ8i2XhiyUZTDjMgXLlW5vLEYsDBl9Uk7iGBkGv5u8wKdGPEU5k362AaQtvgVFxeIn7lunWijgNJHkcZZwL9FBQ8JAzeibMy87AEGT1MfrC5CykrOeuGt3t8Nwif+9u8TO/BCiwnRnbXXHBFD0n0REoAR8OQ==
Received: from BL1PR13CA0236.namprd13.prod.outlook.com (2603:10b6:208:2bf::31)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:55:27 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::14) by BL1PR13CA0236.outlook.office365.com
 (2603:10b6:208:2bf::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:55:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:05 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:55:04 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Tue, 27 Jan 2026 10:54:52 -0800
Message-ID: <cover.1769539310.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff40f1a-b710-4f40-08c1-08de5dd5a2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+qA+/0yoCjGsAMMuXZr0jLzJ5gmsfZ5G/pOJ5ajccyV92lfST/UivzZEUtz?=
 =?us-ascii?Q?r1VS8KWcNrILc44JrlOsqX0HCdUmy3WBVgxjKZv8vPUs2kgTexn0JCd4Y6VL?=
 =?us-ascii?Q?CUgnvT+iRKGXhpCNpjl4sBfTki4iVQKvtpxX2+ydm1NX62J5ayqyh4EWIlfa?=
 =?us-ascii?Q?/VhCzfqcTQKEiRjl7J9t/nnCCGsIJUGro287caDzAthbBHJEikkSx4VA5Tca?=
 =?us-ascii?Q?2rvQexmDLM3IQuIVIS8/TTNO9lJUl7WW7H83NkBmOm4baOBMCZlaNEQOEGf4?=
 =?us-ascii?Q?tVfjbuHFggoRHLjVa5r0kqBfyZy+k4zpiLbSx/0uCVcZul9+MMInLIQXgfcY?=
 =?us-ascii?Q?4GJmCs4oGrzILwbT2kdiVdc4exOQ58ILYQieAkXLFK1voSHA5WFTAFPj5pMa?=
 =?us-ascii?Q?RcL65N/JnRGvM4sJbRl3HJyhGyu25yfIqAmppaT2eyw2CFldEA5Ihu0vAChR?=
 =?us-ascii?Q?daFb+hn1cnia3c8mGkX5cRzB7e9q29MbIwMe/vFReKqvXaOWq0sUnwGnw7xc?=
 =?us-ascii?Q?fFvKAzuNZDc8QgalRl9w7Nh8swzHRjd+Ak1mK6r7cMqiwdCb9t4XDdwdUhBc?=
 =?us-ascii?Q?SpkUZbFcQ1AAnLqKN1c4LpVQK7sTS3qKaX7YcFhpUfgEko7z9hC4DjRnXNeU?=
 =?us-ascii?Q?9S6Gz8otxme2/7WfKmX4EPSsdkKRKN+Y+1WeVz6X5Dg7RFAN6ccdSQ4vhgpY?=
 =?us-ascii?Q?XA0b6QFaSZZd0cWmrz80hi3LS6haMuSNKR++KRCORj/+RtkfMNODH5MF1pMv?=
 =?us-ascii?Q?qT9K8neehbf/OhzfLIShyv+3ahQ/5p3bO3DWZNzfg0rQh5aMbkgOXs01OwTn?=
 =?us-ascii?Q?aFH8pgIRXvKlphFTpOMOtNIxzBDmRULZUINpYrnppnaNihruuU3qq7AWOiRz?=
 =?us-ascii?Q?OoYNni3Z4Km6efv9Qs1idSwUiSaY5n9ur93yNr0/ErWz3DEG4ynbvVs8ysRY?=
 =?us-ascii?Q?apf19OG/Ksys5dtB4DWI+cmrWYiWtGs12HLtfK70dvTfyXnS+ed2Ua3laFZy?=
 =?us-ascii?Q?Deat3cS6W7wVBzkJi67UfUvgqAd+ypjTXj2GBA3FqB7xxI8fwTWXghNOPdIu?=
 =?us-ascii?Q?My1kGyzG871m2tIvdXu8kTdXxULFrf2xVKnxYpygRW//sD+hQ6+7jz0r7+Xa?=
 =?us-ascii?Q?YoGSpnYFU+Omi2Nzlfh8jk8oVwJ9YcDT30/LIcHLz2Ce+q8N54KRYuHFP+FK?=
 =?us-ascii?Q?AkNgUWcXLlvdvjAg5nJ1RBdDDf2iqv9XzIQjWyy7wa/bznNl3NLCLY11yw2b?=
 =?us-ascii?Q?XSFRkxzn9cQKgL6XxFnWGG+CRgg9scG4kjuEXJ3V3IZUKzezjezbXPL0h6dK?=
 =?us-ascii?Q?2N9m5DBpUzy2A8joWk7a5aqP5NUBi5H1or4esvDYRSBHlOIsiusgLzua+TTv?=
 =?us-ascii?Q?op2BwbXb2C+8Lv/j6lYx/htv/JMftx44y3sTssVnoRYUE39NbVXTkBCA7+4Q?=
 =?us-ascii?Q?TkEWKH5j8Bj3Z67eSXSABj4Dt4fPicEy8E/vdxNCkRP9bEiKLaMX1LSYMJRq?=
 =?us-ascii?Q?tNl2LWsfxPrSMLtZJbjcdin3+Io2ct+NTHbVQjIM7+f0o2AyZpMNJ2Ia5XDj?=
 =?us-ascii?Q?cgRFF52N0s2fpT/YYGsQ1G7j69rCM6Qwi767sA04E4iKoapBsyb/FOMTcrgC?=
 =?us-ascii?Q?Ie53cKN3zChDbzZeWMCCBWWzO2BAr6yw05pt2rRoRslzgaEDB2oaWUFarhm8?=
 =?us-ascii?Q?g55FiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:55:27.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff40f1a-b710-4f40-08c1-08de5dd5a2d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219

This is a work based on Jason's design and algorithm. This implementation
follows his initial draft and revising as well.

The new arm_smmu_invs array is an RCU-protected array, mutated when device
attach to the domain, iterated when an invalidation is required for IOPTE
changes in this domain. This keeps the current invalidation efficiency of
a smb_mb() followed by a conditional rwlock replacing the atomic/spinlock
combination.

A new data structure is defined for the array and its entry, representing
invalidation operations, such as S1_ASID, S2_VMID, and ATS. The algorithm
adds and deletes array entries efficiently and also keeps the array sorted
so as to group similar invalidations into batches.

During an invalidation, a new invalidation function iterates domain->invs,
and converts each entry to the corresponding invalidation command(s). This
new function is fully compatible with all the existing use cases, allowing
a simple rework/replacement.

Some races to keep in mind:

1) A domain can be shared across SMMU instances. When an SMMU instance is
   removed, the updated invs array has to be sync-ed via synchronize_rcu()
   to prevent an concurrent invalidation routine that is accessing the old
   array from issuing commands to the removed SMMU instance.

2) When there are concurrent IOPTE changes (followed by invalidations) and
   a domain attachment, the new attachment must not become out of sync at
   the HW level, meaning that an STE store and invalidation array load must
   be sequenced by the CPU's memory model.

3) When an ATS-enabled device attaches to a blocking domain, the core code
   requires a hard fence to ensure all ATS invalidations to the device are
   completed. Relying on RCU alone requires calling synchronize_rcu() that
   can be too slow. Instead, when ATS is in use, hold a conditional rwlock
   till all concurrent invalidations are finished.

Related future work and dependent projects:

 * NVIDIA is building systems with > 10 SMMU instances where > 8 are being
   used concurrently in a single VM. So having 8 copies of an identical S2
   page table is not efficient. Instead, all vSMMU instances should check
   compatibility on a shared S2 iopt, to eliminate 7 copies.

   Previous attempt based on the list/spinlock design:
     iommu/arm-smmu-v3: Allocate vmid per vsmmu instead of s2_parent
     https://lore.kernel.org/all/cover.1744692494.git.nicolinc@nvidia.com/
   now can adopt this invs array, avoiding adding complex lists/locks.

 * The guest support for BTM requires temporarily invalidating two ASIDs
   for a single instance. When it renumbers ASIDs this can now be done via
   the invs array.

 * SVA with multiple devices being used by a single process (NVIDIA today
   has 4-8) sequentially iterates the invalidations through all instances.
   This ignores the HW concurrency available in each instance. It would be
   nice to not spin on each sync but go forward and issue batches to other
   instances also. Reducing to a single SVA domain shared across instances
   is required to look at this.

This is on Github:
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v11

Changelog
v11:
 * Use read_lock_irqsave()
 * Pass in iommu_domain to arm_smmu_attach_prepare_invs() to ease a
   followup series
v10:
 * Rebase on arm/smmu/updates
 * Add Reviewed-by from Pranjal
 * Fix typo in kdoc and update comments
 * Add dma_wmb() in arm_smmu_write_entry()
 * Drop free_fn from arm_smmu_invs_unref()
 * Replace refcount_t users with WRITE_ONCE/READ_ONCE()
 * Verify num_trashes in arm_smmu_v3_invs_test_verify()
v9:
 * Set cur->ssid correctly in arm_smmu_master_build_inv()
 * Add comments for INV_TYPE_S1_ASID in arm_smmu_master_build_inv()
v8:
 https://lore.kernel.org/all/cover.1766013662.git.nicolinc@nvidia.com/
 * Update comments for smp_mb() in arm_smmu_install_new/old_domain_invs()
v7:
 https://lore.kernel.org/all/cover.1765850465.git.nicolinc@nvidia.com/
 * Rebase on v6.19-rc1
 * Fix has_ats in arm_smmu_invs_merge()
 * Fix a re-attach case with a different ats_enabled
 * Constify the inv parameter in arm_smmu_inv_is_ats()
 * Update kunit test data to be closer to real-world use cases
 * Clean up SVA domain's invs in arm_smmu_blocking_set_dev_pasid()
v6:
 https://lore.kernel.org/all/cover.1764119291.git.nicolinc@nvidia.com/
 * Fix typo in kdocs
 * Fix arm_smmu_domain_free() in SVA
 * Add arm_smmu_master_build_inv() helper
 * Add max_invs and __counted_by(max_invs)
 * Return NULL if arm_smmu_invs_alloc() fails
 * Sort master->streams instead of fwspec->ids
 * s/flush_fn/free_fn (prepare for future patches)
 * s/arm_smmu_invs_flush_iotlb_tags/arm_smmu_inv_flush_iotlb_tag
 * Define arm_smmu_invs macros and helpers to reduce duplications
 * Save num_trashes in "struct arm_smmu_invs" (to avoid a re-scan)
 * Move smp_mb() in install() to PATCH-6 that adds the pairing barrier
   and description
v5:
 https://lore.kernel.org/all/cover.1762588839.git.nicolinc@nvidia.com/
 * Add Reviewed/Acked-by from Jason and Balbir
 * Add two inline comments
 * Move cmp after the trash entry validation
 * Batch commands in arm_smmu_inv_size_too_big case
 * Replace kfree_rcu() with kfree() in arm_smmu_domain_free()
v4:
 https://lore.kernel.org/all/cover.1761590851.git.nicolinc@nvidia.com/
 * Fix build errors with CONFIG_KUNIT=n
 * Fix uninitialized cmp in arm_smmu_invs_unref()
 * Add missing "__rcu" in struct arm_smmu_inv_state
 * Add missing rcu_derference_protected() in arm_smmu_domain_free()
 * Bisect two paths for the conditional lock in arm_smmu_domain_inv_range()
   to fix a sparse waring
v3:
 https://lore.kernel.org/all/cover.1760555863.git.nicolinc@nvidia.com/
 * Add Reviewed/Acked-by from Jason and Balbir
 * Rebase on v6.18-rc1
 * Drop arm_smmu_invs_dbg()
 * Improve kdocs and inline/commit comments
 * Rename arm_smmu_invs_cmp to arm_smmu_inv_cmp
 * Rename arm_smmu_invs_merge_cmp to arm_smmu_invs_cmp
 * Call arm_smmu_invs_flush_iotlb_tags() from arm_smmu_invs_unref()
 * Unconditionally trim the invs->num_invs inside arm_smmu_invs_unref(),
   and simplify arm_smmu_install_old_domain_invs().
v2:
 https://lore.kernel.org/all/cover.1757373449.git.nicolinc@nvidia.com/
 * Rebase on v6.17-rc5
 * Improve kdocs and inline comments
 * Add arm_smmu_invs_dbg() for tracing
 * Use users refcount to replace todel flag
 * Initialize num_invs in arm_smmu_invs_alloc()
 * Add a struct arm_smmu_inv_state to group invs pointers
 * Add in struct arm_smmu_invs two flags (has_ats and old)
 * Rename master->invs to master->build_invs, and sort the array
 * Rework arm_smmu_domain_inv_range() and arm_smmu_invs_end_batch()
 * Copy entries by struct arm_smmu_inv in arm_smmu_master_build_invs()
 * Add arm_smmu_invs_flush_iotlb_tags() for IOTLB flush by last device
 * Rework three invs mutation helpers, and prioritize use the in-place
   mutation for detach
 * Take writer's lock unconditionally but keep it short, and only take
   reader's lock conditionally on a has_ats flag
v1:
 https://lore.kernel.org/all/cover.1755131672.git.nicolinc@nvidia.com/

Thanks
Nicolin

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array

Nicolin Chen (7):
  iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
  iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
  iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
  iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
  iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
  iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
  iommu/arm-smmu-v3: Perform per-domain invalidations using
    arm_smmu_invs

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 142 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  35 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  92 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 928 +++++++++++++++---
 4 files changed, 1012 insertions(+), 185 deletions(-)

-- 
2.43.0

