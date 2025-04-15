Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E560270EBF
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693108; cv=fail; b=GoMNs9WtmyZx9ehCubFZrghbFVNoQIw38HmPCuotAhS2BoP9xdzvt2+EbqCFGwCKsasY1ZXioAgan5P0n8ljgOlDGzCMK9fozp6WA6eaGFxfo4DuM/kw7O9rH4qMFo+z2izGcThVP4EOCsraPNJB5sykAkPhshbXiSLNtzvlrv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693108; c=relaxed/simple;
	bh=Xk1vtdWd9+kxCeDJtl001zGF6jOXQi/1OWKkKGDYvCY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q25sKg/vEVApALaMNwCdhWcptvmMUpKqGpiwYlYxT+a/QjFr7VJhlwbe8tpeFNPW+OcmN8WevOVFnBcgSGwcTZe8tVQdiG4UKE3EY0BhDZRR9EqSj74WTxRZF4fsUf75ZTRSSj1nwc96UiUHsoZF8ax85HzVqHc3wy60Ayws1qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tw0tFUDU; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tw0tFUDU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwYwVOgF1Uhgt3u3JgktJwDPMLb1zKWZtlfVdZxqRHPG/s47iwUHS+qyVJ1HHBvPbid7E7eRX+J5VXkwGSo1ZDIZMjX1KOnG6Aji7TEF6b0NID+9Y/BEtcOR+Y2d2quWzwsCkaVs5SAp9frtyglfqZu3VHIurNQpURKJmPzKrosQgFBLTXPp3JjlKdzQTB1xGJvr5H6ZxwH5UQItyg3bFv9d37Dvzy1+0UtsP8I4mAAmQFPWR6eKS2Cl3im1QBpjUgjqEMWYwZofGMqDaLHQgBZbhVeHrBAQIZW+aZ1E7rBsOgc0XTiN6I5D1o0lToMLH5gB+xGAlFrul6wJHj0iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dW0RygsTVIZwoD0ru0GeEp1DFhq2Qlk92KpuXdV5KA=;
 b=uPdNWY0uItC7x8HJ20MQzSaikAGMIk8iVF3q2CRViea6dwdat49C3Y7BXtYqkQHdXDbCLxNj5Daa09JGhzmmJKDoVF9o9MwivcX3/3XblsdOejYKeckglAW7JS7fXi5QPAzDYM8mP4x327OSX28SH/6gEiGltjSS21OmIYlBk2S1gPedLH/34+R1jEypSlzXNJrBZzLduX4DNGbMsJ8gyHc3zjwPhACAfFIy1H+Md1t4jHWDV4aaUWib172fxV6gToz6MwBeyJSq6Qqfx4G9IKRkVMkpDJHA0EoCzDDppc9hDy0mRVNL6Al/+h1c88ykPlzPQj+LbSwYF90GVtEkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dW0RygsTVIZwoD0ru0GeEp1DFhq2Qlk92KpuXdV5KA=;
 b=tw0tFUDUXWtIHtpXt89/V/wCJtUrCUaOQ9IHIzgyM66U59BeuuKLSiQI2XFsDBqtmo4cr/NiCwMigU0ej5FxBaW5WChi7dWBI965nuzxzfdwn6cxJBEvUx0HVnrYFt3PBiS8cz160vccshzrV1dtUtOcVqAiKvWm0HBzhouAROdfTPISB3bojYJQQ7pbdmuW2Qg1nEO/W1SVHB3QnJ5+Dg6gcyjJe/z/68r+i/ALw1Yoru14EeLSqcgHWoIuo2aFUIgYhFWBRCeo1Zf38+RVsmW4+9y6mpf01XBsPtbJxLd0h67/9IvKp9TFS4E3jYM1nx14ty864S0PGKTudOaYHg==
Received: from BN9PR03CA0236.namprd03.prod.outlook.com (2603:10b6:408:f8::31)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 04:58:22 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::e) by BN9PR03CA0236.outlook.office365.com
 (2603:10b6:408:f8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Tue,
 15 Apr 2025 04:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 00/11] iommu/arm-smmu-v3: Allocate vmid per vsmmu instead of s2_parent
Date: Mon, 14 Apr 2025 21:57:35 -0700
Message-ID: <cover.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b7f93e-6a62-4ac2-d211-08dd7bda259b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6D6SlpyrH9OcEbVCpBG+mDyKIa9ghC//xkbdy88Ht/SxRixSP+megBvxViU?=
 =?us-ascii?Q?68q53eETbIPEMPwlCoAnOx9acTSgGou+A6Lxht3mSlMv+uALS7PY3B9rLfnX?=
 =?us-ascii?Q?AkTL2WtQln54t9QGLjRm0DNlBixn/K+0zvzfy4COD8+aZ64IoZxc7BMSOl4Q?=
 =?us-ascii?Q?JQVuqBj0C08Wk2V71f/n2y6MTiprQu2KCe3bUrPAE/TU7NUi2HjloiskY664?=
 =?us-ascii?Q?Fa93KYTZW2SmnWmpwUQdzRqAsSobRW1J55jpAzlyftSDgBP5CZ1h2Qz3WHnL?=
 =?us-ascii?Q?i3B1TrdEOl+lbF8l2p8TPf644v1xY3Ric7vk5B3eF05L6ZzFHrA/1nhsw6g7?=
 =?us-ascii?Q?IMRvWoVvtB4rSuWXjURXnh0agiDAcnDbwZRjWEXHI+YCLjkvZ5E17yDu6pWi?=
 =?us-ascii?Q?SElp6TYWn7AdBYu/Te4iBkPiKhruBlcHMYmc7P4ZRUT8F6rRgIMYvS596BxY?=
 =?us-ascii?Q?nZ7NWYsJOh9oTJYGUKkom+ScWIAlrZte/x3/YZW6LjunhCRYFR14Y+xBLHO/?=
 =?us-ascii?Q?r5hLTZexpnGnvUY9Ywy8A/AvheiPSfgjn6Ok//p+DP6ZCDt9PcaRNjhvvnQ1?=
 =?us-ascii?Q?2mkp+F6g5NHvYwAkhGTToYh2Qrc12NyXk915i9gUO/ieuS25alOAyhZLWZPT?=
 =?us-ascii?Q?a188HHZBfV0GJ9YlAayLQ/pAbAPVA7zO7rPIFEhKMBwTZZk0Ec9iMtORg3X+?=
 =?us-ascii?Q?dQ0N5ywzizkeq0tcnrAWE7jxpry9eNUO++HxgN8NIHswpaqQ9VxGSHpUuvvB?=
 =?us-ascii?Q?McqDIsOfUh57ek9VuPKs2+DeA9EF9TqWgeIBtGdocICFam8Zv0wqqflnCrJs?=
 =?us-ascii?Q?BndKENOfYkPWpIuJjViD6E/hcav3QscOZJcD3MbxezlUuOwiEMePqWjuyHAo?=
 =?us-ascii?Q?NKEJaf9OT2bxby9IkdCbIkBZVbacRI/HtfCBTWaYqmhF3KKCch+YETwASUb/?=
 =?us-ascii?Q?y3qpceQEr3IjqOLQAUH+iiEUpcsOzmWqxUdUaGnzKkkyf3GlVHQmr9MHCZij?=
 =?us-ascii?Q?+C5WMzeURf7rbgvxGLt0Ab28Un5OIC3kieK8dBMgksYd5W/Q/A90VbjLcO9G?=
 =?us-ascii?Q?NOKM5xZHQWMyBPERh8iy33rn8pQuFoQFQkiNMG9X9BXqmcp6zMogay6zvXDB?=
 =?us-ascii?Q?Ju6A6ZaBl6lHrUrGlKPX7T+HPfxX6IV5yNsa6PRQyT0mo3hUyx1LAzGxPjW+?=
 =?us-ascii?Q?/C0/TtCTB4FcgJ62w5zXPPTg7/D+e02vWg9rWzdkb56dfoogj2X7xDTf4IC+?=
 =?us-ascii?Q?d/GiE0ehGIPb1/8zOPb+0hp5y7RtfwnR/8c6AHRiCNelOA+adgCWutJNHvtO?=
 =?us-ascii?Q?aJKj2qIuLmkgTS0Rz3tj4C7edtTORrZI8ep/QAZKJBLNCntqhPfP0AxzOcl+?=
 =?us-ascii?Q?l5QXQAjiN9uD3Zp3m6SRlvfWs9M8iS3h/Fwkf1ztexbFaORSlRGORRlEGzwP?=
 =?us-ascii?Q?bt5JNWf5rnQj7vzDwnbOBkek6eBQuuq/avZZyB05o1+n8TFMU1vEH0fweyP6?=
 =?us-ascii?Q?ZSzp3SONv5QpETEP5mwDEL73gm/ZoLKl/LWseQf5Ufhqh+9v4Gud33Ku2w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:21.8659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b7f93e-6a62-4ac2-d211-08dd7bda259b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

With a system having multiple SMMU physical instances, multiple vSMMUs can
be allocated for a VM that deivces behind different SMMUs are assigned to.
In such a use case, the IPA->PA mappings (i.e. the stage-2 I/O page table)
can be shared across the vSMMU instances.

With a shareable S2 parent domain, it is more natural to store a vmid per
vSMMU instance v.s. a shared S2 domain, since each physical SMMU instance
maintains its own vmid bitmap.

Have a few patches to get the functions ready for the vmid migration. And
decouple the vmid from S2 parent domains and move its allocation to vSMMU
instances. Note that a regular S2 domain (!nest_parent) has to retain the
s2_cfg and vmid for non-nesting use cases, if the SMMU HW doesn't support
stage 1. Maintain a per-S2-domain vsmmus list and a per-vSMMU ats_devices
list to iterate for S2 cache invalidation cmds and ATC invalidation cmds.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_vmid-v2

Changelog
v2
 * Add Reviewed-by from Jason and Pranjal
 * Add WARN_ON_ONCE(!vmid) in arm_smmu_make_s2_domain_ste()
 * Add arm_smmu_s2_parent_can_share() for a compatibility check
 * Introduce arm_smmu_s2_parent_tlb_inv_* helpers replacing the non-nesting
   routines
 * Introduce arm_vsmmu_atc_inv_domain() using a per-vSMMU ats_devices list,
   replacing the nested_ats_flush in struct arm_smmu_master_domain
v1
 https://lore.kernel.org/all/cover.1741150594.git.nicolinc@nvidia.com/

Thanks
Nicolin

Nicolin Chen (11):
  iommu/arm-smmu-v3: Pass in vmid to arm_smmu_make_s2_domain_ste()
  iommu/arm-smmu-v3: Pass in smmu/iommu_domain to
    __arm_smmu_tlb_inv_range()
  iommu/arm-smmu-v3: Share cmdq/cmd helpers with arm-smmu-v3-iommufd
  iommu/arm-smmu-v3: Add an inline arm_smmu_tlb_inv_vmid helper
  iommu/arm-smmu-v3: Rename arm_smmu_attach_prepare_vmaster
  iommu/arm-smmu-v3: Introduce arm_smmu_s2_parent_tlb_ invalidation
    helpers
  iommu/arm-smmu-v3: Introduce arm_vsmmu_atc_inv_domain()
  iommu/arm-smmu-v3: Use vSMMU helpers for S2 and ATC invalidations
  iommu/arm-smmu-v3: Clean up nested_ats_flush from master_domain
  iommu/arm-smmu-v3: Decouple vmid from S2 nest_parent domain
  iommu/arm-smmu-v3: Allow to share S2 nest_parent domain across vSMMUs

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  77 +++++++-
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 175 ++++++++++++++++--
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 139 +++++++-------
 4 files changed, 297 insertions(+), 97 deletions(-)

-- 
2.43.0

