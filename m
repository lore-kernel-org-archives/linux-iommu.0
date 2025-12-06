Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DD24729A
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982353; cv=fail; b=m5Rzl1RaLnjbwSrXnFowL/YNi0WhVIaXZOQGPORWE0OEpe4iV6baXngJGo/T6x4IuWe8ycOGQAvLQjVUbvlaeo5exjinFBLhMgPXrd2c5Mdnu9lhJpRPU5/Cz2c9wv90muvlMxBNV89vtny4xiRtX9j+amZhifDLqGFJ+g0tXz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982353; c=relaxed/simple;
	bh=2DL4qxMQCg+FCJuJ9cWqs9cQC/IoU07dtc7dGLotES4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rE2ueZ2Q0mZK1E0n0nwDBL25c8U5V4kS/6l/eFweFX2U1G4T7JHoX/YJ0Ff8SAr8ZjGmZfPv7qDHrDkUqhMTTnkPSloHiksxBOBCDloV/7/1ePF0klrel+/gTRYe4jFfrlx1vFPEgovz+/ab7o91qS8USdFHYUWcMBtSB0ljSIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnCKy12S; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnCKy12S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoBazQ40lMy8fCDc1NFqUfYmKdAVRZtahUDUnNON3v3/qdkzlu0LRwXMT+YtY6zYMIouRy29tqPKdiBSEum1uyabLAgrnkMyUItvKl/EGTGys9Pp09OVI0MLQpYa+yqZaugJB8QEgKiPNqaUIMtLoOP4aeMwqWY9gfodJ106ZydkQlhdMUkfKsUaPDlDolr+5d8wMrnLBB9bePDwymk3wzHM6zxnVZqIidFjGD6C96O4rEDf7APyBABwtvooJN4ePEMck3VSD6oDRJV2la5jPSH10O7ccamq7zopBZ0UZwl9Vk2GNpzQpsMxxiD/qlKwjxq0l+05u0TyfZPSNlePcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1E0jOyNMip37otGEPlQ6UqGWAqbn8we6+vTUVnK3PY=;
 b=kzwHyTCRgSB2qRuC/RcbQv/dvQpqiwB8S/D7gR5Kppld/yRdOnsI0h6Dx65J/xOy5j98idzhq/8Krv5bJE+vXT2VDd/rz0olaFmZtb04jrZNULv+yTJ4GyTxdFyKxqmCNKIjURINrh0CKrxlbsAL6I2tQqTXrJk6BI7XrUXiYng/AdvHYPHjrUXJYNPQaw7JeE3C1ZU0Cjx8QU3D35qYPGySErFbhijUIxF8L+riqEcPl8072PcBZufsp5lOoa0fqmswSo4AL4HA40kCqiiCM9O8e+SotnWqgjBIIjbflibIFlqQbgF/TOu0ii9ktzl27nFD1oLxbqx7tU8CzWszdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1E0jOyNMip37otGEPlQ6UqGWAqbn8we6+vTUVnK3PY=;
 b=nnCKy12SSYgDB1s+612/6GRXjA0KFLPoOIwP4IugfIDT5FOdw6qDI9kEoONYFogOm5b8DLZ7jdJ90Ww5GMhKnn4iQyIZn2qT93fMa3WQ2B2AeJ5JozSiw7x5ihESHGxYPBNlknLFyMADQDjkU9DlKLoakndspLkeJB1MpixoL1R5C+zAZRqvJZSkfj1lOmvdKZlfO7cRgOuULL8TW5WI4c0IOfCuy+wWPsnjih8yq0GjgP5qKmrxXU4D2dapWxQ4bxo9BP/yUfFAgIYfOF8I4mBbk0OePwM4fURXjxPbZCW6PxjxjDbpm04UbSzAVEL0PZuN0LmCHerTmbFESqXosA==
Received: from SJ0PR13CA0203.namprd13.prod.outlook.com (2603:10b6:a03:2c3::28)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Sat, 6 Dec
 2025 00:52:27 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::33) by SJ0PR13CA0203.outlook.office365.com
 (2603:10b6:a03:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.3 via Frontend Transport; Sat, 6
 Dec 2025 00:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 00:52:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 16:52:18 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Dec 2025 16:52:18 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 16:52:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>
Subject: [PATCH rc v1 0/4] iommu/arm-smmu-v3: Fix hitless STE update in nesting cases
Date: Fri, 5 Dec 2025 16:51:59 -0800
Message-ID: <cover.1764982046.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 666fb042-a23f-4c65-3e42-08de3461ba04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uiGdRWQl8j9gv8L+1jybFArmBDQ6g0G3cuZ/ZdyzAlTtFpFhCy1v7uLrTZqu?=
 =?us-ascii?Q?BCTF9x7X1X/18/WZ7ABgAQsdwCs/mtA4fbnvsvSeQPDSYicevQhO+3d1GAQ+?=
 =?us-ascii?Q?lO3gEIdzRzktjyub7qFiCczg/3wn7bqTAQK3gnyiUztDIX8aUMRnrLQch/GL?=
 =?us-ascii?Q?FanKk2RlcvQrcf3OGxt6mdBd6vRocnMMVG9FEAuZioB5dCir9dzJ4Io++sz/?=
 =?us-ascii?Q?lcdyrCiNCC78yUHqivrFuoOkpkk86+4bek3H2+Ai2OvegMJDw+ghYd839PjM?=
 =?us-ascii?Q?tVP/MMtGGbAPs6YZ0dlTNvO6G7+ggdfCp65YcHaDbTw4FyTC+hziEnjYqKG4?=
 =?us-ascii?Q?0+0TMyNW9lR5Hm5rC9VX2sf7xVkAPo3vjwV73g15PhKtl0tRS/t6LpOJ7xEr?=
 =?us-ascii?Q?zsbcTCdAgENNWr9owjvpvvq3voF9HH/FCoC8YVakLTqy3Q9T6+g/QRIma5CN?=
 =?us-ascii?Q?LLgAcqeEaQ3wTdKPl5AFLCsfH3UY8L2Fh9/Ahej/GvUFFrPczDeTzHD6JKqi?=
 =?us-ascii?Q?bDrQidcRhoUl6sy/zt6g8cgyF3HacoKtatAFenlTuTfIgMH73mZUhCpMSXNe?=
 =?us-ascii?Q?re/ac8NMbvXaUy2CLDEUYkFI+YJDTuSGbBiVhwRy1zMgnFyssfHcmJVL01G4?=
 =?us-ascii?Q?TEhqamoWqrozgFc2cXiMBoW7Ha5ahaAyTZdzXf5RFfYFlA6r7PTnea62ErO8?=
 =?us-ascii?Q?0kzlzZ3rJ3FWxIdnbnG2dtIBiHsXKPtt2BIVQPwJCrz0Oqukv+SlfbpfXNMa?=
 =?us-ascii?Q?DTFlfH+03KIrOeLuBrqGfVrJDsQrTWjsHouZxcDGXhdavWb4cYa6nDvnmRrD?=
 =?us-ascii?Q?H8J1LTf7DQ0fPq6JNZ0u172DVuvERKp4h6dvnqslBJrseIXiDJmz0yia2i9g?=
 =?us-ascii?Q?sjYTcoa+wBaT6F576SFuxvTzNmOHKvoYytnk1WTcRkc3q6TbwB0v+I9Qq/sl?=
 =?us-ascii?Q?07Yd1iBy73KgH/eQmDcIJ2VifaZKppaf1/buYM+ur0/4VkHbB7drjS77OY0Q?=
 =?us-ascii?Q?mKp2tWOJMF2enPkwtGtW8bCK1BT4QK1h7l9gYQ1DtRleMHJhjnEA+yfByO4d?=
 =?us-ascii?Q?y7X5t3rB8TTKZRB0V0RMCEOdfhtK4lM7vV50YTC4QS6PleI5+Jrfy+F7r7Vx?=
 =?us-ascii?Q?IJN04i6vvXRB+euk6/8euqxktSsvUXU55gb6lvhf6tlPw/ZPYhrOTK8Wg35k?=
 =?us-ascii?Q?pZc+TIQ2NiYT7rin3Ag/jM9aCyF1MKJvRGhbOuXHsUXMuoBhIoSKpMyo2ahy?=
 =?us-ascii?Q?yNFFFP3Qm9WK1Ic3kCItUbqVSYHCZ1dOMxknzSviWmjf2WjobJHeusZkz5C+?=
 =?us-ascii?Q?xPsNDHfwxbJCbboea8NYY5lXkOf1+M2lKz2m0lEqYNH2fV38qZ7FeboHpDuR?=
 =?us-ascii?Q?Vj2mIJmPO2VQlyomyvqWxOJFSw2SWk5oD8wLhBi/x2NFf64PcdGwT91HYLzd?=
 =?us-ascii?Q?4j2pvagolqSylPdaOSglt4o7eCoFBX0cSLvBzSFZWu6lzaR81IxvQUZJVNSB?=
 =?us-ascii?Q?pMkz6nvh90x2V5hcXT9CbIPqTZQ7V1AjReW7a7xsG9O2FPMNtGnHr4zaGjaJ?=
 =?us-ascii?Q?Wz6w3C3i4eJnW9CvLj4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:52:27.0334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666fb042-a23f-4c65-3e42-08de3461ba04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411

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

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Add ignored bits to fix STE update sequence
  iommu/arm-smmu-v3: Ignore STE MEV when computing the update sequence
  iommu/arm-smmu-v3: Ignore STE EATS when computing the update sequence

Nicolin Chen (1):
  iommu/arm-smmu-v3-test: Add nested s1bypass coverage

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 49 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 49 ++++++++++++++-----
 3 files changed, 85 insertions(+), 15 deletions(-)


base-commit: 0d081b16946ef449fcb35b6edc1ef6f9fea6f0a0
-- 
2.43.0

