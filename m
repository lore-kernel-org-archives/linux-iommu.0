Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B12F8BD1
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591299; cv=fail; b=C+3gKNgmTMqfBZJBWK/abDB2vjeAnllT4w2Wz2JFe1q1C6rFzdMA/RS+pypkWEKhUASdmA32J+R9G6jnyPCPC3m3E99vSsS+6VH3++A9AXkfjHqZAWtTgpFqXfIWmi5xNyPqPbFP4AqHtGmlsm3xogauQQC/XM/C7qiD7C93XpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591299; c=relaxed/simple;
	bh=HPqxBhJ9Bs5osG9NkNeRyUvuDHco35LJ301J6gg27qE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mCTCx8R0SzgVqcMneKzCujJJad9IAHSk77LPixp+YRKSms7TTaBt5uACFWURR4oF/4iFb/7xgc+BIRrno8zzXf3NOkqaG5+DrUX3/XVWM5/rIMBKwys5Y4cQXdtH/VpfUrlxJlmbPlkA04JfZaO/ikYnqVSNXCdRkcbGn0FYS0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBDYP+zK; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBDYP+zK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpV4mGZvJFXrtrV2maw951v7CGopgchcyoYUUjwNuH80j4kbOu4QrgaI86Zj3iWmZmy5l+NfbnZtEQnoy+L8IEx82rAqJASiW8qhYxE3H4mnNp2JJ3UkLXnuliqP19/HUV77vNl57ycrXgJCUz52D8Fs7XhEGkaHSM1bA5/3ttNGcF1tgbTNT+GMRLuXZXJGdLsQFmiKD2GpBYMchVRmR9Hlf7rNecxTt4h0dHVua+PoKjCtpDaMObgb5pYQVhmLHGrCNDGOpHjb+bRO8dswSgSIiSEndkZyXhY1q8Nc17ka8R7O5TifTtMTk4HRTHucwfsdBcgGme5Odcd/lFoyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQR2WApQK266UdIg+Q3jm+v8qkR+TmAEiu2duj34bDw=;
 b=hnOhBPasdJ5QkXtwK8GI9c88aSlBxX9gbMsVmmP/d04zUnrAIpQZtLLK0wTQzNepsQgyXkXlObh/cn0QbUIBh9NTP6p3YGJ6ia+PmEF7zbEnEEw2ebhcAwoOYZ5JWSlafxCaeMkwZx8qrhXSICdCE3m6lNBc5kv7CZMRxUjLWpeVn+Egxc/FrFDl4jYFJjpxWB19wQ9eeHm0PJHOj44LYwmit8beOLs4s+wOO0kaOZpkXZJMqcW/RQgfzRI+jmfZ9QVHlbask5+uke29yRYQCeCEzvVAfpuGDtAui0Bpp4jC2JlFfPTgiP2EW0QSa+68EpoxEEMQVmDy8ihMsNGTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQR2WApQK266UdIg+Q3jm+v8qkR+TmAEiu2duj34bDw=;
 b=eBDYP+zKPgTwEG3RG9lFWQ4zBwvVh/23XadWELDEaPVMSVVni9WXSw1FQHCthjtokbSV5Sd/TuOdA4u9u3aNUKvNL7bHPy0/ucbLVf/zrbzGWOA3KTi8xdqFRRGLFHOb9LPJwcDxMq1LC9AU22+9K0tOBYNu/8wDv65NeMyAktPGpb9iZc55bjOOSeYUnTbv6okg33XkYW4qD7V6X7Ifs8ovexZGKgU/nNLbsX/bmN+if2TrjVsU4Nia05NVZb9OWlzCpcYGEPnqiN2abuWY66r1hVDPlBvmvsyATpRt7r770YsewNWgTY6bq4GKlyXLIVO1Ah92ILm4TnJ6luAwxQ==
Received: from SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::13)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:54:50 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::1a) by SA9P221CA0008.outlook.office365.com
 (2603:10b6:806:25::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Mon,
 27 Oct 2025 18:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 11:54:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:32 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/7] iommu/arm-smmu-v3: Introduce an RCU-protected invalidation array
Date: Mon, 27 Oct 2025 11:54:14 -0700
Message-ID: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd244ca-29b9-4f8b-579e-08de158a4ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EraZSZQzqWSoyDrNovRc5+RZk14+L7+JNaGUmsVTBWb/8JHCn4vOWFnhTSoP?=
 =?us-ascii?Q?nAQnuHMn90VxOLLOuCSQg8rmthhX224VOvZYQDVjayeO7KgshxRe6fkp/7QE?=
 =?us-ascii?Q?JQ644fS2o3j57oSaa5phM1syvLKaD4S3NXs4o9872WIgT2e/uZTWadi99iE5?=
 =?us-ascii?Q?uslxVeKSwvVq8gcsit65kTRbtyF0J4eGiCJy7ys9qQqY4EEQ6NEKQxnUHarY?=
 =?us-ascii?Q?OJpUAGSqMA5tNIWcmVxcEYnxz6kTRUSjn2fkWbVsspOb6Y6asAnrTgdk8vii?=
 =?us-ascii?Q?XbEEV1PK+cpd0hYFejefzxdE3aoua71xy2hQnABbyHK+lqpwQCvDEppoTvTa?=
 =?us-ascii?Q?YUmyIxckciT63iXXGpktCQBi/kbHd6agSUOXKJwP0Qyx3WUzh/M8qIReu7FZ?=
 =?us-ascii?Q?y8juHVNs20jLKPF6Mx4bvEsCBdppJSXo8mUCDYB0jt654CZ66jc0z40UVZ6l?=
 =?us-ascii?Q?lPTEUiA+gJgByNtaW2gFqiUw0Xgy8zfNmwXdRoODyOyxZqP/fQWRUecaX0Kw?=
 =?us-ascii?Q?r4N21l07NLgldCeA//c5bwE5LE227Wi4lJgTIJGyBt2ouGIu8XdnLyiPW0PF?=
 =?us-ascii?Q?87DZEp6SMht+3hL72hRHCNg5t+DBT0Mp4Ii15YWnKWeVQHiNdRbih3c4j5/z?=
 =?us-ascii?Q?ibVBErFAdvKDShrkYXDeXfXS/hIsYsk9DQtyQv3SVJ9mLTXEaGDhJbnBPxmL?=
 =?us-ascii?Q?gYc8BCnttNLOFz5uR5OiNVbTG7KKPrshFkWi0S/FfmhJm68i2oQOku09/Lqa?=
 =?us-ascii?Q?QW6rRdFTXMekP6mYmG0AmqfHVn+UMX9snAHv8b40D+Chr+Juq5TAIe2mnKuD?=
 =?us-ascii?Q?XGfvXkNPBfZ3g14bIqStHU1OPYSX3OKXg9ueyF1ooRzU7rQN1YgP7AcT0/fQ?=
 =?us-ascii?Q?qjRTS00h+DZUsV44K3dmdSdmNouEiMXxebIf9+5lbO5CPdE59+HU2+/ODChW?=
 =?us-ascii?Q?ZaF/dNISEwiMrI6GVtGXCuXNnWF8O9P+wbY5iOiooquGKZuQqzIcp2M/yv77?=
 =?us-ascii?Q?SsshKHUhroxfTTQjr5hvco8EvUKhtWwomXYYLmC8idKR5VmNFaDi9s4cTHVr?=
 =?us-ascii?Q?XhMg4BcTa16cyoT0Kw7T7EsITeMQ/Pb8cHRLCwma56H+dn+n+y1l53Btbof+?=
 =?us-ascii?Q?2Fl2u+kpjzjGXPUUg89fwha76vSBoZKOmfFhTFvAOSqbc5Av3VakjFQS4c9G?=
 =?us-ascii?Q?5fqvHs6jRBHNFtaWkDTa9+YuMa3AQ1OsxEtXLZq28hnFKFw3Nc+uoYOY4h9L?=
 =?us-ascii?Q?QDYRXdUyf1Vt1JUl3Ym//4PxTn/AX399fqYnuHH8hHmyWRTF86/rV6eynB2+?=
 =?us-ascii?Q?vMBk80Yrq8xHwaZw5Gcax87M+lN6p7AEfnpp28OdFbZyAmDFAZDdlt1OdVP8?=
 =?us-ascii?Q?Q8B2GheGR516U6uPnh7FZHXOz47TVAnzIb9tM/rYLR4eQe3lgswUck5t/Jv4?=
 =?us-ascii?Q?ST1tG5H0GkPYkHauteHN7vUp5V4xO+WGSmD9TiVslr+axQUc3dXCqYdfHWfK?=
 =?us-ascii?Q?IITE0b32kAuW3STFS8QcMagK+j2u7WeIrSyM751FI//DFYC/vLffMIirtkuo?=
 =?us-ascii?Q?y9dw9pjjx0KT1/ti1sbgCXKu3EtV3b+whDVoNBBS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:50.5561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd244ca-29b9-4f8b-579e-08de158a4ee9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338

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
https://github.com/nicolinc/iommufd/commits/arm_smmu_invs-v4

Changelog
v4:
 * Fix build errors with CONFIG_KUNIT=n
 * Fix uninitialized cmp in arm_smmu_invs_unref()
 * Add missing "__rcu" in struct arm_smmu_inv_state
 * Add missing rcu_derference_protected() in arm_smmu_domain_free()
 * Bisect two paths for the conditional lock in arm_smmu_domain_inv_range()
   to fix a sparse waring
v3:
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

Nicolin Chen (6):
  iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
  iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
  iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
  iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
  iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
  iommu/arm-smmu-v3: Perform per-domain invalidations using
    arm_smmu_invs

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 135 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  32 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |  93 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 845 +++++++++++++++---
 4 files changed, 930 insertions(+), 175 deletions(-)

-- 
2.43.0

