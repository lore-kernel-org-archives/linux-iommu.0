Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18A343D8F
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827517; cv=fail; b=OSHljU/p3/frskGgzlTr+pVN34y98xONZwGyBXurYZkt8TVG2+92ZaaZhEphbabXMHkwx/HZ5hnZ68u9TrAfLYF4QpmumxpSUz7XhUPQ+TdAaeBiP0gpS4YGPM3HkJERCUgt0u40MjIr45xWas7Sp56/1avTAnIsdbdVxLAYLYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827517; c=relaxed/simple;
	bh=ZFcDdLMvM8dOZzMWrzU+CHT4jW+I8Ll4YeF4/j8YbFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UupIRuD8quD84UaTN5+Nu9vhPcuTagExO+bx5MYZ2ln1fgSW9KoaK6gUYMxoyqdp0dXX7N7H4TitmGPoRWzJjrIxAesQGKrNo+aE/CC+DAt+oyM0cdXtdp9t80M5XX+Tln/jTcu/hOEjv/jaoU7WNGTrTFGJoSdgJdggatl7f7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oTP2phMF; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oTP2phMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1Yis+7kheMRB3iqWdHZRCA3t0YA3zkAT+sL1dNYe5BOU4MMW1N683CAnvJBlkPFZD9CigICXz42ZjXhpSSBIzxJXCvbyH8pu3joBV3I5fYbmn0rO10JU8Gl9cwYaLO6/EqheWoKzN3ryhF562UYfg3ms16GRB0+VC65AvOtFrsF1iNf+7RtdXo/pXB/9y++Mk/C5TgioFbJc4EzaKFVRobB622vHVe45mz3N6v1w8sOm5cTsvwXpKXRNhc3uNt2VBTRfCif62Ie3t25PUGMJMwCv/DwrR2kwEu6sbYFKMW2xSGJC0JNrA7WivKD8wFXytvW2QvOBM5n3VnnOu6zUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCf3tN3svCRRnITGaRoYnrRZ/Zhcbbfseu7QsUBkc1M=;
 b=G0GTnjbNxuNGQ17Lai3ouaOsZV/uelbD/fxR8XIrsBaP7v6aiIenhVFDSju4aEpy4zHB3e4j8tHlVD5TWu4MBheNa2s07EabN5i6kuV82C/8yTkS71nLS1fhyadpBdBuM914zpkAqynf+OOfJuc6YzETNSrHigLj83jHP7eptz39KKDhk6ROV+u2POZp8sowJZLtIIN8ss+EHBUJQZwC7r5Ug9Fj98eVXEQS8GU3cUshjxszm7VE47PWKor4Otbd1eX2EfEoTj7JbHplownPh1hEkoYNv0V7rI7pl1SMlGKmiYAqYdHJaFN7KZ8SZ9b8dNp6D37Z+RbOwNb0/1/fLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCf3tN3svCRRnITGaRoYnrRZ/Zhcbbfseu7QsUBkc1M=;
 b=oTP2phMFr7eW3ji+CybZGYApUlSW4QErpqzeNSWaSWbbevpdjtnRflsoa71UWt2nCbSWpERwdnJ96LlJdcVFPOoqowgJE1+rjNQpDJnDe0YPnL+6qngxURdKFnbg+WQElHQA2vOuPkeE2YnrESCBYID5q5x/ZPLHDkJzJOr+hnR7Q0hGM4hQApwvqqCVZBv3RcHnblQBdveL+3vYln+HxEzHVrbHZ+yDURQZp+6YSRCPnCOvewEU5QZJk0d8nCrGcT43LHpd3qrcclp+4N3uVFr9azWpCM0NDR2o1uyKXaiUj4w3xWDbhXyaIumWJwSLhqgIww69nwzoJN6d5jPYhA==
Received: from SN7PR04CA0095.namprd04.prod.outlook.com (2603:10b6:806:122::10)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 23 Feb
 2026 06:18:31 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::bd) by SN7PR04CA0095.outlook.office365.com
 (2603:10b6:806:122::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:16 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/8] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Sun, 22 Feb 2026 22:18:01 -0800
Message-ID: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb563c8-b606-4002-a59b-08de72a35d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKRy1R+IKOpAUlM4NK5dEKWEIsxvEZW0u/qXld4NNL7frLWFaTSeOgIwN9Nf?=
 =?us-ascii?Q?+5CgsFcplI0r2U7YAK1VZKnecP9PvisWj3dpr9DvYuqlcC4SS3D2PlzF2bw6?=
 =?us-ascii?Q?tNUmdVI0iKZPiLW0N8pCnyOdU9Vhp87D2y2KWky6eY4RI/MvbOJwD8aBRaOz?=
 =?us-ascii?Q?Mz1clLmHA9Qrtz/jcfauZQ+1R9oc0v4srlWimmD4lP/skonVzE+WbvQcnDMH?=
 =?us-ascii?Q?Fvy/ibgudgopfZUEjPIW4ALEAYGJ7JrOEi9wSB8IJIceHcYVNnh5kRK+zfTB?=
 =?us-ascii?Q?1BQQ1voFH776RlcTq3lNIBKoSAZ/dDOt2MALUAGhyHxk0Fibay2XATTi7HQ2?=
 =?us-ascii?Q?O2ThZO/B3uvPJcldJatOo7/G0UVljSDEWTbXJ+7+Zwzw5ciQ4zyrMyEgFMNf?=
 =?us-ascii?Q?IeofySG++QEEnmv9hOePx/j2X6QIgBJK5cYcCjndmetLItSi/RljfBXaz32F?=
 =?us-ascii?Q?P3mFgBSJBYBTyIGEfp+RTDhqKVyD6OfBLSBs2+TnAhMaf9hssgs/UEKsphOU?=
 =?us-ascii?Q?8dOXIdlOjoU70TdUmXONflHWDKvMmjgXfYSB6LiUhDhEAtRISGs+1hUu1Dpq?=
 =?us-ascii?Q?Vi5mfrlgelZjB9w2aNmeBTgnzhl3Ki0GhsaSeyTDUo5K7H0zdGkVEW8VT4uf?=
 =?us-ascii?Q?PxxnBmyE6llbscAYhnopmZj1YPwMaxhmyKQEwUOR4Tie82GfWhMmdaRxEkbW?=
 =?us-ascii?Q?l1mz0Me8LUUxd7SxJMZt+wDANfbCFcAz4ZE0jsUdvD5nwrNf75xUs+UIqzeS?=
 =?us-ascii?Q?DfEkzk8i99ZT7NrvD/Qlkg3B2o6SvZ+z8WqohDkgbdJbRRTdAtNI+1uyG+3V?=
 =?us-ascii?Q?wZNHVt7Ovd5R8eyArTXPb+FVkpDZ1b4NMgsrqIkw49V7NZslXpxeVHrZKV2S?=
 =?us-ascii?Q?uDf9xPh3Oh3F+rl7EfhYF0EkCtAsdKQQzKnJHZU9phFnQJ2RenQvJcrK3lwd?=
 =?us-ascii?Q?34L2zA9aN/Zqg3kut+nbVorveh5jTbOyoB1GivKAMQuXkX82ZE8D6XzAq36h?=
 =?us-ascii?Q?qTe8NeXs6elqGPStFSiT/pKiNxbQNbIMhrn2HHM3NEkYKdeFVrx6IgMcMndP?=
 =?us-ascii?Q?92pZNDOih3fF+tP8+s3LJyzt0MhZ6nKzuDahDODzpW7NiUrpZtKAWpk84RsI?=
 =?us-ascii?Q?wmDzQvepTuoyS9NFHtVajt+U7B0pKTRslot1FsyR4aLyC6SbMPVcI3ecG6e1?=
 =?us-ascii?Q?YkJom+YxiELSfVANCt59uoDjbGATL915UF+WKlHyfYyn+EIsVDDrWg1gCcU+?=
 =?us-ascii?Q?poW8PLJQRLFxQ+nxTRVuccv01z6DUNL8pnMJlwJrDrrQaVa5lE8uy4yE7BKd?=
 =?us-ascii?Q?uxRk8PEE1SeuTi+g+9ivk0dpcpfa8HBma/2HNCvZy/TsrU7lHHWcZecktcxZ?=
 =?us-ascii?Q?43dR15zPvvSh/ETFvJa+0ZHWA/gmZts9XallSfwWGbUO/v+7pgY/qQOg0n40?=
 =?us-ascii?Q?kcJ+qkDLztMw5pOVVMR1RqaKcyD0QNID52eoaAMRG0Ui5BI8N+U0fuJNjVKX?=
 =?us-ascii?Q?8BSrtjw3zH0VhW/o+7VLWZw5bDSDfReLUL5LallgvpbfKEuEk7tV1HslHddV?=
 =?us-ascii?Q?+oWFYIbCnXjIPh1d9sgWDKffQriQTYfJBy2jRzr/v4TqSyVySSvykcyZJ9gS?=
 =?us-ascii?Q?dZtC7yPrpF6qupIFQtAFAzZF3G1QLkY8FnnQWdCiJEFmWvbmBrrxT3FoJE7V?=
 =?us-ascii?Q?hYXqpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fjcsplGazmkSpdl4AyGoH24fdFqz/D+vQ48LDpyoZgZqWhDPvzV6lYLRX3RJGsiS6i5JJ+Aqe1IC4SMvIoqGrlUJqvhup/JE7gvSh477M/6uhDSxikQPoqNum2MIuOJTz06CbO8+mOzc4EwuF6z3qR9PhWK04VC4ibIVsttWRyDZBWL9R+IEaYQgSwM7EcL8NUpNT+1TMT/XfpACBlkNDRmhERMEVkmCe3dAGz7DmyonR/m0prkL5zm/IGdQuX5GShOblddhvax4KZn+3F9v+q5yxAJwH9hl03G+qAhc7KDiUAmcLD1/IXgeyuEQTMhT5kIRKIgBV72AA9F/+/Ai06oMgdwWui3BGWhRyyN1CpeakcLgVPAi4ZoGMwVC7gnrJhdTDbXWtqPNPH+tirZXawDfIb750Bjsoo3r/0i5airdvDgfGRqkY+IcwmRFe8wu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:30.6602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb563c8-b606-4002-a59b-08de72a35d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v12

Changelog
v12:
 * Rebase on v7.0-rc1
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

