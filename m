Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300D21CA0F
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748600758; cv=fail; b=cpzWPd8egTWB1WA+sppXtw2WnUszwv8p++CK/0kJM/MdTUIkUtx8/IB86tDmbLf5nuDRBK/u8VxuUhkDnu4VlP7ifcuUSFraC+WzIALQo6GR/pjQYcFsrWLe/VsRdui+ZVqekQJ+1QrbM00M3APUY5jxRw4vd8EwwUs3gbYAlhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748600758; c=relaxed/simple;
	bh=nOylb3TVy1FySQ470NzjbOmYCm5UD4O+B9dutD5Jy1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3BZwnf+yBU1x3YXOxUuqb9BQ2IWB5A0UVraUUEsiQXqpjUayT4lbFiumpsq9VbIriQHDAI378zJ2vkRP8GmCX6JP0aXB7mmbiHvJ8mpEZEPGHa9e+z6YKvNhmXYzEV1jin/6PqwTvnQAmpxPyEVYdGQN55eNNyyo5em2pXALHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lVgaR2eA; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lVgaR2eA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpGsfGFEjZNRRIeXQx25Hs0/W2q4s4KCZIoxeuG67e2O09YS24NhIZPSz5JxN0bWxdgHVf6ys1RO4P2wouL5BaC5l9ijmPoesN++I1f5Bjkd4cefE0MX3+Uc+/0ghrf6kJpCMTe6wR2lhpFNR3TIsYR2L+Oo816PaYOEgywh6BCzUgs7kl5WNBEkGXz3I1HJ0SxzoFacYNVbS+Jcec2l6tmm5Ur/LWPPaWZoyidGg4h4uPKUK+lGmz3MRYaQ5UOFe69hHGQJdNNnXgjkl9TYmE7R6XIz3o3B27qMivGC6xUEA8oznUHMNjvdYqT88e/Mk2Hl1f64dKNxwqkxF17vLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ba+ogmcyckqTFz7iGPn7zSRXlwXY2qHJosyLN3Udf8=;
 b=GMvNTSdW+tGeOToz1cdOh1sIZ8XKvg45HJxxeHOmIirBkDzoB4fGI8RyAyCOVnEgi2AqRNcgP2GtCUM0j+H5hU+7F149M/Vbyk974Q+MOEdqyPPzOFLgvFKYT7qHQZRp7VXRkEVQrSBulcPmGCJi02k7VWi1v2q30eH2DqUWNJOYFKYE2r1tePpYaUeTsn7FH2FLhALy/Um6ECj3hv+RO0UbbDPdOR6q6dawdjydJT24qqIqMD77VE/Obs8KFZv6/kQD6qPWc9k9SjPHHazcrJ6NJ+1yF7JH1fPwgAb8dFYkWEuMXZCkD9GfGvpUK8XP+11e5JqjGg2tGQ9DVVwMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ba+ogmcyckqTFz7iGPn7zSRXlwXY2qHJosyLN3Udf8=;
 b=lVgaR2eAxfvIk2VOd0N8+UXygLbPc8lqHSDaM+JnCfwnyHUzBhG4CaSZcmLFUA+Y05XL8hzNVcDEb2ZD0sD4Ff4Y1373RsnmFmA9INt9A9gHjYDUcxoFK7vNeeqkRooenWrpe6/GPPpbAFQgCTWidtcg3lAnvYe+YIvMi59VBO8=
Received: from SA1P222CA0049.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::26)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 30 May
 2025 10:25:52 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::7b) by SA1P222CA0049.outlook.office365.com
 (2603:10b6:806:2d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 30 May 2025 10:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 10:25:51 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 05:25:48 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] iommu/amd: Support for HATdis and HATS features
Date: Fri, 30 May 2025 10:25:38 +0000
Message-ID: <cover.1748599144.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: a244236d-dbd9-45d3-2d57-08dd9f645a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vg9fYkYpSlzMjGcGM7Y9Npgp3A5HMuoMcDazFQrq+cduk0QfIWn5KTj6O+39?=
 =?us-ascii?Q?sETzOTShWT1g0x2yg/pKYr7cm+o7NJIv70buxr6LLMtMmZAzjHtHaAmYG4QA?=
 =?us-ascii?Q?LTwrt8kQAuCDlcbYRVHPmgZ04bLQWSwztL9g/Kr2i06K/UZxtQl/NDTWZ9mN?=
 =?us-ascii?Q?/BP8mB9xuhRpbhEMnZf2yRwCfDiki4ZQcGnWk9EWmgvNbeFhckOp8QCnvvgH?=
 =?us-ascii?Q?n0L/Eia0qOO2b9g67q+EizDtxzxJ9DZ9yAIVRWvxODJSkqm12uqtrmTVd7Vj?=
 =?us-ascii?Q?3IkBzpLpyNuoHrlgDpAw3+VmAE4fNVxp0Y2FmFoVmq9P1h27I/d1/YejZped?=
 =?us-ascii?Q?wWbwMuYcplyHBLp1ljAqbdvShKHtRjxWiWFzou2/Ncsg0AyVGKsLP1pKhmf+?=
 =?us-ascii?Q?GIqjxsFPN+NJnjjZmursOYRVzGA28sMIKyf5oF70+9jrokx3bX20DbxmEeUN?=
 =?us-ascii?Q?dcvz7fQyAQOLU3+HuDVCvvD1sNF0v6xM3o9rQTTFlJPoIVTXlIbn8LuTJwGz?=
 =?us-ascii?Q?6/T+eSWNyorG7rBaaIA66XAXzx0Argzdg+QY+KqlwaGeRS12VpJ0vKOM8sDP?=
 =?us-ascii?Q?bi2RD2/tncq+OVDpcVWIhEIUFs6C2ApBNL7SkBnkZPYklNmys6sfSfWQ5Kos?=
 =?us-ascii?Q?CQSfYdEaIXEX7XPvKr6qIbHU70pxPr396EfTjkis3PQwjH2WfeOI3UG6U2qZ?=
 =?us-ascii?Q?5EzzMDtS/02Fwj4/KqfdU+1rDmBZp+DSU4Rzed47Yx3YroPyz508y2CTGv27?=
 =?us-ascii?Q?DuJIqyiNvBTF+zdyMDXYzw3TScDtSvmNW1zqhzMbYWnp4DRTwoyLaM4dk4He?=
 =?us-ascii?Q?heu7GrT1fznuwWIasBC/WeVVRI0OGt4FFcbbR9kxYf6jT2VKjSd9r5nMSlBw?=
 =?us-ascii?Q?Rv802Gc3jA/v13FliL77c9mptIVjXuklF7+UwLNoabma4ahlUCUpmRQwQczb?=
 =?us-ascii?Q?HYpYMDPabltEaHaDj8oQ3xy9xWBDnrgvE4nFAGYoAoNzwkHJEulFdzhULAED?=
 =?us-ascii?Q?G7LnsoHoVzLkiD0sQH4wyL4olOr0vy8LYEhffk/OGAiHyiFXdCHR11zmSA8R?=
 =?us-ascii?Q?ifBIaLmZoJStqsByVQ8A8RH03JUWcF2qv4CbL94OcwkYYhGVifXw27p5o9/g?=
 =?us-ascii?Q?x2hXjaHPE1h8Bb2Ii7P93CElNKUPWdnAmykqe7cp2wbaw/OOq85Dclw54tlT?=
 =?us-ascii?Q?G9ecxDMBscxxnY+kZcWuKVxZOJOrrxrgy9kICnCuEEmAZR2YGOiyly/zglPv?=
 =?us-ascii?Q?bWuPt6ZWiyRW4fLkywQ+mYYV4r4fUcDi9C0d5pKO+uR9ecJxx6ZxqJxsHqG1?=
 =?us-ascii?Q?Kme4dqoxSEdzVCZOr0apOU6kBlmwN+kU6zGgW1uKHzvjBUxEwfgCLNvhujok?=
 =?us-ascii?Q?bcsi/MyqS1z84noG7Ch1HTt4P3Cu9HonWWEb8rDWJaYv/3O4I195riyy9sLU?=
 =?us-ascii?Q?HJCjXhZW+xNtRBWThCJUFngtIQavsOFcbJQ6m9i2c79SrdOIKvQWsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 10:25:51.4787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a244236d-dbd9-45d3-2d57-08dd9f645a36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797

This series comprises two features:

HATDis: When host address translation is not supported by the IOMMU,
the IVHD->attr[HATDis] bit is set. For instance, QEMU emulated vIOMMU
does not support dma tranlation for VFIO passthrough device.
Support has been added to check this bit and switch to guest page table 
mode, if supported. This feature is useful for cases where only interrupt
remapping is required.

EFR[HATS]: These bits indicate the maximum level supported for host page table
by the IOMMU. Modifications have been made to adjust the maximum host page table
level, starting with level 4. If these bits are set to 11b, the driver will
attempt to use the guest page table.

If guest page table mode is not supported, the driver will fail to probe
devices for DMA translations.
The interrupt remapping will continue to be supported.

---
v3:
- Add check before populating sysfs entries for iommu groups.
v2:
- Addressed comments from Vasant:
	- Added/Modified comments and logs.
	- Removed v1 page table assignment hunk.
- Link: https://lore.kernel.org/linux-iommu/cover.1745389415.git.Ankit.Soni@amd.com/T/#t

Ankit Soni (2):
  iommu/amd: Add HATDis feature support
  iommu/amd: Add efr[HATS] max v1 page table level

 drivers/iommu/amd/amd_iommu.h       |  2 ++
 drivers/iommu/amd/amd_iommu_types.h |  7 ++++-
 drivers/iommu/amd/init.c            | 47 ++++++++++++++++++++++++++---
 drivers/iommu/amd/io_pgtable.c      |  4 +--
 drivers/iommu/amd/iommu.c           | 15 ++++++++-
 5 files changed, 66 insertions(+), 9 deletions(-)

-- 
2.43.0

