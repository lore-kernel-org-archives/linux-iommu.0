Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC882D3ECA
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765945593; cv=fail; b=A9K6NLpZ2DXq216RWSb8Njr1pPiPlgCGCb5DYQjLgFFYzktmWJxY5FmQ4S0wdWifySGff6LkltjzRyAhbzaxP63VcWlsFsZX5XIc212ipWn07ZC8nBW40b9qyj3oN7W+h1PikpnxBwADVc1Tk7kdmT328ck/IJZez9KXSYoLnII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765945593; c=relaxed/simple;
	bh=+HB8nkKoH/HlQxcv9sZz65c2HGm5yJ2biBuWEnXn2YA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OgRgZLIFWlfcVvtKG2OYMWRMkgvhL4MomS9qsj6iB01URM/0cI029VNRcQCDz0i87iKToTk6pkw9sWrHG/JgsM4RetBvfUSxlS4jLie0FZP+/6ym2K74ylKoB3dx1AZ9NRJ/aJTAV5GhMaazZQdBjot2Ldek1mFfc6Wz1AGUgrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kp7qp9sm; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kp7qp9sm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phxy0tyWLeDcCTvc2lK52IJ6g2RhFfDRAklG2Vg1fZOmOf04mTZWPlkS9zi87WqaxgcJ8dRhEjJx2BuGHUqKVw/CB5ivLeATor69SvrZZx41+4OPxoiKBmyI9SAo5RvMYIfQgKVlmTrgvA8kCIpVnmQJfKU8n2wLgG/RSNn/EyPNp9mLl+NjctF7I1/6ojQYuF/JOSwR2yr9emGQqOAnNjl4SUm/JJdIxyd7l34WllUM/NqNlAeMahQ+pgUwy/D6DrM2FMVVe4FrrUTLU54gsDSOEr1RaFK8z3rIe6ohdejSZhbiFTLxVU1Nm1raLQcTc1WGbspR3cY4P1bIR8yr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN4x8eN8q67VGhqmn4NdVfdtKNEP1XvN+IKhZtsMFOo=;
 b=oIVo4v+9lBWG9CgRzcziLi+Jl3fEiWxI312MBBjtMY3U0LISaUyYdrAI5QCFNN1YfUqKZy5WMg5nHWrJ5YCWi2MgPmU3GHMYkZIC3IQjPuJEq7Jr6Uuy/pjgIK1RT6puLUyJrHlqTV09AfGbOIAT6c3XLPd/8CAYo0A2LD7b+8EtMxgeOjSi7T2THGmryEmJOUnEbJ/0NdIsdU9r5ZB6X61uUyKt7/fGFzstL2HdIvQRyveocMl1xn1d77r3yuVfmUw9nQtJb6ahqp237HucP4pi/isqhg8uKntsUH0zqgYSvkLiqH7mMuHDcTtbbxOSUlXaqU7lIQNLAFCHGhmldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN4x8eN8q67VGhqmn4NdVfdtKNEP1XvN+IKhZtsMFOo=;
 b=Kp7qp9smxawp0bI1bnjlEd5adeJDM6seuj0KY0y2ye14hbYxujPyAz1/Air/aDw0Iu0Fav3hdAfItMcwVX+OQCfM+45l8NXHrfArMZzCzEsl9siwe9EOf/iZCeXHoEUDLWGUxuC/7+VvUROm/CWKg5hsPH9aApf1VBaHdVjETMva8YIbwSWuyWc38ZYjS61pbXNpc2MQHPowe2fC8RAD/wEjwCcWpL8WSwLoiGbA5O+hK6arpauvU26IjN40ES3302uYsACaV20j+6gwJ/cpCUWUFgTDpuuLVlacDyW9LNasqUxaj7KXoUfWDj2cNQI7sD+ixt2y9xX4bRmQDj4chw==
Received: from CH0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:610:b3::19)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 04:26:24 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::7d) by CH0PR03CA0044.outlook.office365.com
 (2603:10b6:610:b3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 04:26:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 04:26:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 20:26:14 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Dec
 2025 20:26:13 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Dec 2025 20:26:12 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <smostafa@google.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v4 0/4] iommu/arm-smmu-v3: Fix hitless STE update in nesting cases
Date: Tue, 16 Dec 2025 20:25:58 -0800
Message-ID: <cover.1765945258.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 137b730d-2dac-47fa-3a03-08de3d247025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yPS7eQWvw6VmxPFKOrbJUE8Z+6uWvhNEvYaMXSM8+pDfGmYtIhsbHq4vFeW?=
 =?us-ascii?Q?cgmOWL9+NLHVZnwL/d+dXYB2j7ZAlE241jYBgd1PTCD0m2jdBTjfRSV5vFqD?=
 =?us-ascii?Q?aIDhpH+yxSvtMrtkD5Prh7HB1/BLXaCsQjVAxeCKL2YVPPRnuByOeNwjk3qq?=
 =?us-ascii?Q?0CNNvoF+V392P5suqxKholuLBjTKD2lOObazzy5TlzW9l+QJTxy1dTJBXy8C?=
 =?us-ascii?Q?N9co3DmxFbpbWYcEcgFhdI9rX/vIS6I0rpHrcuvr4I7LfSXMEIBNhgylf4dW?=
 =?us-ascii?Q?vF3un5s7h3a5gWjwZMwmA8LhK8aMOvYc4WpcUT17SQLbp7twkcaretqmg6EC?=
 =?us-ascii?Q?DNfws+rPEPTLCYzzEJ+ZwjIKET3fj0wn8ox/XEnsj6VVb7GF1bEFnhOJlC4P?=
 =?us-ascii?Q?b4IUoya4BxfmnKFO11s4EZjDKFHzmlFdtfuSiuRlK3SXBA+QHRP29pN6e8xv?=
 =?us-ascii?Q?qQkjjMTW8pxkFviALSjw/IddM6+jRRMzq8KyV330UT+Q5qELefH6qT5dY8wr?=
 =?us-ascii?Q?uTvlceoDm4obs4gZug57UYwa6PQI2xpr9aEeC5ppCCTKuduqhU+Rs36m3YsM?=
 =?us-ascii?Q?p3AR/uPxAPEBWYZdnyb5f7foNRKAr/1eawKR6On6zyz1mCfXZwjp4UUl/6T9?=
 =?us-ascii?Q?XzPBLwVEK4VtnuY4i6QCZPamrvcqEyo9AnyZbRXWXJnJYtFrjhUj8eXbKHJ2?=
 =?us-ascii?Q?FxYoQVKEx/C8kr4A0JXkZ+6Cr+9D5grtl4OpNfSM0Ht7bOnvb9qFxTJ2irxD?=
 =?us-ascii?Q?8YBAc6cmw9CGWMWNb/Ik5PXrUmUakLmeHJN3ZYyjVnupRa+djlOGmblzqBtK?=
 =?us-ascii?Q?vGbkQvnpGFwLytKarZFM6Faggmiq0HYzL+1wMKTAN4UTF+WOEG4pw42YhomH?=
 =?us-ascii?Q?byRtrdLbyMm+Sh1x0TxHzutg744z1GHW9rR44uMNgYLA1wuwDzCxUYL84JXb?=
 =?us-ascii?Q?/mlpbaatuQiekI9hTP6ueS87LnS75NI0XGoasSTyNj7Ei75m6sgZVKoRT4qh?=
 =?us-ascii?Q?gRgWqv6q+wvsVaSSxqsCYavAYaMn/UBS63YZxNKOTJ0qYJz3WDBmT0kEuWHf?=
 =?us-ascii?Q?76yZ+CmGNHExDc8p8LlOyAoeTOiFCEkd5LMmMjz5agAO1o2O1jKi/LUOrcLU?=
 =?us-ascii?Q?INFvstd0GREKKgv7GbcHGvqMreUhc74Gcw3mIQLQn7wBffufDfzoIzUMu/EH?=
 =?us-ascii?Q?HvzVlj4OrzFqY0BCI3/7m81rGk1DE7o6iF/Tku7OkxXGR74FzlWyWhDmsz58?=
 =?us-ascii?Q?AV4EmEEKxKQrAtyRmnnkxT3Gn5M4g69XljuOjxUTh7z/8N+nEslF9IDGZNCh?=
 =?us-ascii?Q?oH9NpSWhmR7YJZgoIYpp6w+8h5RJJAtobV2Flh2Alp2lMYu5hglfLqnfMldf?=
 =?us-ascii?Q?mpBcrfEQG8cmuPuIvYegb1pDkE6vRzlQ7V2B/JgBvATEZljrJbwWlEKDActP?=
 =?us-ascii?Q?DYrQebVS1V+yJ3qO2kkNFNOqUmo6s3ZVo7u/NqxNu1CaMdsYwhrHSUCZCiDI?=
 =?us-ascii?Q?QIcC98bmFkb0IyqzSyTqZAJNGp8yscynbhF4NtsTSHO0J/KHNdmIXU4iMNuH?=
 =?us-ascii?Q?WElK8hF/srT6LkgUCFE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 04:26:24.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137b730d-2dac-47fa-3a03-08de3d247025
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262

Occasional C_BAD_STE errors were observed in nesting setups where a device
attached to a nested bypass/identity domain enables PASID.

This occurred when the physical STE was updated from S2-only mode to S1+S2
nesting mode, but the update failed to use the hitless routine that it was
supposed to use. Instead, it cleared STE.V bit to load the CD table, while
the default substream was still actively performing DMA.

It was later found that the diff algorithm in arm_smmu_entry_qword_diff()
enforced an additional critical word due to misaligned MEV and EATS fields
between S2-only and S1+S2 modes.

Both fields are either well-managed or non-critical, so move them to the
"ignored" list to relax the qword diff algorithm.

Additionally, add KUnit test coverage for these nesting STE cases.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_ste_fixes/

A host kernel must apply this to fix the bug.

Changelog
v4:
 * s/ignored/update_safe
 * Change entry_set to void
v3:
 https://lore.kernel.org/all/cover.1765334526.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Shuai
 * Add an inline comments in nested test cases
 * Reuse arm_smmu_test_make_cdtable_ste() for nested test cases
v2:
 https://lore.kernel.org/all/cover.1765140287.git.nicolinc@nvidia.com/
 * Fix kunit tests
 * Update commit message and inline comments
 * Keep MEV/EATS in used list by masking them away using ignored_bits
v1:
 https://lore.kernel.org/all/cover.1764982046.git.nicolinc@nvidia.com/

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
  iommu/arm-smmu-v3: Mark STE MEV safe when computing the update
    sequence
  iommu/arm-smmu-v3: Mark STE EATS safe when computing the update
    sequence

Nicolin Chen (1):
  iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 64 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 46 +++++++++++--
 3 files changed, 102 insertions(+), 10 deletions(-)

-- 
2.43.0

