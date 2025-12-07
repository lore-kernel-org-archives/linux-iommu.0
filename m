Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A21A5B8A
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765140600; cv=fail; b=C5ybpFKOKf/AcYYg4Qq/2qsuaWH4V30F76T5FVJ4GzZs8fjBGBJV2kol3Qxh+t+InzypTL6Q5t7KCZc5aHXvl4boQSmEfc6FDmzr/qKYstCQnNpO3Me0ASCdL4xUSYFxM4TM8p0+REjdoG5JTJvllc+5z4VELXUr7xK3upCCdtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765140600; c=relaxed/simple;
	bh=JRfX5zc1feac9tk+SLgrBv7qqUTokQrUqOGvZk4dH2g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MxyrsfdKwDF15Ca4z9pA01of6SszRfupAnrJdEn2sNXfGfueD0aMq7L5vAmob8QIMbjuZiEJxEjEZoLI0V2YIVuTejAfJcyVYltjQ4Xky1yku+EDFuwaIMfFbCdfuH3kPlMIG6N1+ih7Ap0wy0fQ6RVFAx99tFbPMWQRnbbvreY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sG4TkNKu; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sG4TkNKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBk/6f4//CYrqsqdjAvi4+hupwpzbz7oKZjKrTocMgzfgWlpVKurygzSrwgYMQ1gEDBOyP1rJEA57U9SbNr3U5+DOzg5tt61iQ8dwnwZPvd/txpI582zNtvcC66ym99WaXWaQp5jdytmOc4GrcaWGPsEgs4BsRYg7ns9XZztWybgTYehYMwPMG5xfGKJM78rdap8nv9rxHJ3Vp8YZ+3blg2lESQayaMGJtA7ur5Oyb2aAY+IURmsp4vq+xSZp4rQruHAGhsXXTe/bE2fSfDEFVuuQPEnUXgyWRDvl+Xw9O2xiTz0F5DKsarf/evfBZPMGuW/nfnHzGmgHZn1g9Akjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85supT5IucQM+S9V9xo5V6WF0Re7oaOptwZFU7VRjak=;
 b=Mx0ymw9PznML05BvGOyoXl4CX4vEHWuOOQaOwDNEQIrV2eFuhD1uHoOjFUTKv1SRquNTPoFVNhMv82u62Waf/cR3KAc88GV7CObVvrr32MX1yqooMxKEIbbYl4ktjsnd4Rr8S8tubhJRgkI3B3LGnUZ9VFEa1G8vP6P4+pVrcZ6JGZYDF2fZjHsYB+Uz8spx6HUbc9y4twgq8VsFFIASbQdGKmVePD3kPIkZ5aWe6iTE/N2YHNfka0Z0l7/SjkAohmIU/YYCVJbsUmGVlF6JMDOX2roQIYF0n71+NJQIFsLARWDNpyWz1M+k/OtPDajhwXGcMpEOGF3EYjEb8iK+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85supT5IucQM+S9V9xo5V6WF0Re7oaOptwZFU7VRjak=;
 b=sG4TkNKulDoKMUzVtvS9sLpoJrbV9T8s9ZLmMQ4tu6fLvFeHujoxPgTP6cSQ0ntqQL9RmRaOJqPRsGJzl1VaZ3Ej80gTTmtPZQ+rtTPrIBpuCn/o2E7qnp3ndOYUYRbPjIVRVij3QpIDL8aE56lDkpOsEdgkH3ziNrk7LP9KQJtIHdeWFTL8NO/SN3Ppt0BJNNQ+jGZWFsC/A2sGi1almKJ5OWSAxSdwRRtKvH5vb8qxD/82nHcMbL1t6sXZ7T6HHNJt9et12trNqDf5g4TeRPo2MQHLs/QI/vTC2rZeZVwLUwj0+EVzf6OmT4KpYDoULN0102yHWqpA9mPvoDnG3Q==
Received: from CY5PR13CA0088.namprd13.prod.outlook.com (2603:10b6:930:a::43)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 20:49:55 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:a:cafe::94) by CY5PR13CA0088.outlook.office365.com
 (2603:10b6:930:a::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Sun, 7
 Dec 2025 20:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 7 Dec 2025 20:49:54 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:45 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 7 Dec 2025 12:49:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v2 0/4] iommu/arm-smmu-v3: Fix hitless STE update in nesting cases
Date: Sun, 7 Dec 2025 12:49:12 -0800
Message-ID: <cover.1765140287.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: c2164bbc-c370-4b85-e94a-08de35d22d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vkh60jYnL7y4nTHmjq6konMdUa0rct0ljI3kmtfOZ1TB90inKls9EdpD6B2m?=
 =?us-ascii?Q?CKbqxEgAf157P4zMQvdKOjYzuWNx6joZwj2dezcyleUw5StbUtDRLoMebs5t?=
 =?us-ascii?Q?ELgjLniPFEevgRB19E66h1fpAYt9jjhFo7J9/BRUrz8AqjDnkfSI7npcE0RF?=
 =?us-ascii?Q?/mMeAc8SmO85laHTOgx+30n+JWxAsKZ1EvpvxDI6smn76oaBX6fZE4J62X9S?=
 =?us-ascii?Q?bhQiq8pkk6PYIZsWvAuWvZTLNsMwx8pzfhMl68G3LgwPIQBxgLoSuev0nM8y?=
 =?us-ascii?Q?Hmub0xf1j2eD9PbXwCny6fxHpPzIT7hZ4rclHtUbsd8vtY7YehRrOhBQdxGR?=
 =?us-ascii?Q?EuJW9XgiaixouFyWX2Ej2s6rztNrUxntFhnFWnG8lhvyi0bY02EhSHBtCzes?=
 =?us-ascii?Q?1pD6xjpq4FryKFqahxfAkoOdqU0MgDECp8OJRREQlFa4QJNzVOpLGBBnf1in?=
 =?us-ascii?Q?2fJVlqsFDhfewO0b67ujDLCiSWfJXqyqB01qJ5YV3rFGWy0rmbP82r0qd0BZ?=
 =?us-ascii?Q?i7xO6CR9V3loddtubb7PKx50i5hKWgtj/twrSsdBXeHRfmoM0vFW+y43ZAwC?=
 =?us-ascii?Q?afuc7j8pv2slls3bEgqEa4IkowsZqR66iiOuNeFcV/Vntw96xFtsWnezt+pV?=
 =?us-ascii?Q?JO0ywoktW6Wb0ur3BAJo2+pa/YBfb2FYgyNi4Txr/85uBkaW0ESl/d5jF88E?=
 =?us-ascii?Q?rN6gU9gKVXtV1Exx0pJwR4wAu6IJS8vbeOvRBSZ5mz8jLCW6tC2UX4QtR0LB?=
 =?us-ascii?Q?Gp4hG1Mvuprh6GzsI1dNxu+P+VXiswFYTqPentYdLEg7FN4zSDOBmFAmfifj?=
 =?us-ascii?Q?y93I8nwheIGaKMkLBY0BtIx4FuSObVYbcFQQy4I3Uwd1RqsV9zuReuMaaDxn?=
 =?us-ascii?Q?JfagvcBzBzq8+mwRQVUarp7iZCMCVIAGvmrR/5I6y5AwU4Njayvlykvlgnlj?=
 =?us-ascii?Q?wbwpQ/5Jng/3jUcALYxx6KeRh6SbeEhYaCWzvFGAraUHC/SRZihtXNkLzD49?=
 =?us-ascii?Q?6gohDVsXrC4ZTgfPrRiZl73lbDK2UGE8BuZrBL47ZdsDw3Pme3rlf0Dx+MQz?=
 =?us-ascii?Q?Zde1+2VydjxaNriZSqAcoK8b1FIq9XaPOVE1fySeD8bFR12rGCIEOHiBHdSV?=
 =?us-ascii?Q?E5xjW1oYNlBYK+qpIKdLaEF7MqPq167GOr0qfR9zVWVKzVrUNvhow+Pv/VKQ?=
 =?us-ascii?Q?shY6XTzwkwxNZI4DWBAUYhSld1tYJBw8/bXvth6tdBtsoMaw77N+YQzhMoZv?=
 =?us-ascii?Q?8OOsiZCH5gezNsZ4OwnqaDQ+U27MlieaaksbDyrZtGI42ptHNCFjL3soZO5r?=
 =?us-ascii?Q?PIXomnXXnQWNJUt/UAa9Ku6JmLDYpmNInlTZ/A/WvL1QpeKggxUit+J4VYgS?=
 =?us-ascii?Q?irv3zqB7kcZHkG8a069UdE1fWutUlDu3Xnm03Yf7ZWeGofxMql50fdTHveB4?=
 =?us-ascii?Q?z58wSDj20f7ouHtPF9Z4D54vsfdPAtPo8v5fAUGvbYt7msqMO1lYBNuCbSKJ?=
 =?us-ascii?Q?KkEceoFyVk8/6mbSohumfUumZUkj8yAPLm4FGIXLx2zfIaKkRvei1OyKye9R?=
 =?us-ascii?Q?M0T4tackIYWudadlFHY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 20:49:54.8525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2164bbc-c370-4b85-e94a-08de35d22d1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099

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
v2:
 * Fix kunit tests
 * Update commit message
 * Keep MEV/EATS in used list by masking them away using ignored_bits
v1:
 https://lore.kernel.org/all/cover.1764982046.git.nicolinc@nvidia.com/

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Add ignored bits to fix STE update sequence
  iommu/arm-smmu-v3: Ignore STE MEV when computing the update sequence
  iommu/arm-smmu-v3: Ignore STE EATS when computing the update sequence

Nicolin Chen (1):
  iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 80 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 43 ++++++++--
 3 files changed, 117 insertions(+), 8 deletions(-)

-- 
2.43.0

