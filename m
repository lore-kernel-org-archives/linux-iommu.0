Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750412FF71
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504068; cv=fail; b=BhYU5fzv9jz93kYeJ8iZZvYiF8pVO7rnOVI/VxVHNnYDucPPI4gmKeM4rtp0sUX1PaX7M0Sb6hLg1/O8NSqGXRuNMPwxn+jx6iivJazt+v+pv12YgubPxoMyuYXerZlP++r6hCpHMI9gR2cp84EoJt8sxpC8dRmLUDW4WnnBFc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504068; c=relaxed/simple;
	bh=zQzUIGAw7fI3YRtg+lQh0g0Z6sqljrw+NQfSk/dsfUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9LxuNEVQWf9iak7U/JU1MyUf588Qm2pdeHNJsjjBQgbC0XnzkTX9HkfrUTyVVneRnUKNj36NLm8e8PBZLwp1jOBjlajF0MTY4j255G75lF9FO8eAsTAPpd5Uae8cwGMlgMVNeMpD/iLZUw7zEfBdpGcN32yf+5p1Kbwg/9zWZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XfS0TYq9; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfS0TYq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiTtbj8egTwVHr6RhFwGUrI2g2S2msPmR1enWMrBLumFOsltUmyljoojGuN+kv+t4AfJn9r1OCQwz42EqcpO/+D8PESw1MN2CbUgAcVLFicjmGLd4yCUW8+N1S4MWmnHzpBPP95jU1ddmFv7cvFLIIQs6UhKrgucTQRBXZgzkTjGO99YVwTBYdn/B7ch0pG5IS9/6cN0sw0GkK+GThfeT7AxDVqoVR8R+R6iOgpOhJidhV5ITs94y7vQmGcLT3+kZ91IEGcCoaQh9M4fbj0ei+jpolbqp5DLKY1oZdlMe+SM5hpxVxZqAx1YJjlkcpfOiPxZWjgCcRUCC+uTqgsp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iFMJMtmGOb1Ni+BwOve7JUCj8eTgHHGGLGjTJwe0ws=;
 b=WpDPQeb3kD6ge6tmLmQTsvDTyfZlXBN1VSQSpx8jcgtQTbbaWZ7mq45Oh1UsLo4uc3/DInI6Jo2Z1Orn7uGB3VDCUuFtbVdkX0jZSaAcOnXYxIFGM++pAPVoLxvefLhUwtDMYF3Q/d7z5dcJhgvmCNFlmY2BkPZOCXcOXkYoF7o+cJJTSGsJ1XtKgskK+InF9uT3ugQYF2eunYzYEBezo0shc+LS7YWvN0F7qzQgvmOW9i+OkjX4l3xrXOdflW9lU8pgvwJ1Bt/OAgeJZdBW/GsdmHFEAAE0pldqwnss1K/RMdgdieigqrYi8uPQrG81JZ7FrwWt00js3b9sgxwpeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iFMJMtmGOb1Ni+BwOve7JUCj8eTgHHGGLGjTJwe0ws=;
 b=XfS0TYq9gqG5CdyqHzDxf1ozYOVATk+6+15LA0VYlvqMmSi6ysuZmz6cIr/jB4j5oywKV9waERXNIl3p2gHL7ezElr+alzHMXVtuTtUg1mrgLaT3egtBI3NLaA/zrEXadVfFnn34AODV8pmKM6349rps3fic6UFHf8SeTnGoBCLdeVElR3VDPSyXHU1dzPr2L9BMZdklXREQw7c+oV1ABebcIGlwK+MJ8Yq5D4O6bxFVsOw3J1GKcaEx2Y8N/tqwmI9wiTAk84chD1uSrmZDn1dMBD3EWyKALwVbLvgVfcxhhtr0OWgcICf9pUF2OQJhyWM+awr79bsoGtMi8NurlA==
Received: from CH2PR19CA0004.namprd19.prod.outlook.com (2603:10b6:610:4d::14)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 02:41:03 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::1f) by CH2PR19CA0004.outlook.office365.com
 (2603:10b6:610:4d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 02:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 02:41:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 19:40:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 19:40:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 19:40:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <mochs@nvidia.com>
Subject: [PATCH next 0/2] iommu/tegra241-cmdqv: Fix two bugs in __tegra241_cmdqv_probe
Date: Wed, 4 Sep 2024 19:40:41 -0700
Message-ID: <cover.1725503154.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba3b202-967e-4e63-fdc8-08dccd542f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMGtWWCT87/cm/CouPfS+jEXeEgnW1eWAfS7tRkLuvG+pusyTwhFYi0baAev?=
 =?us-ascii?Q?4irAHRrk56T8Hmd7IWUghq9tOvA0IceqIZ3VX6FBeQbtf806aDuKOcuHhyCV?=
 =?us-ascii?Q?bZxBdtuaNjc2SsVMKS+ET/1M7wU1hOUH7hqBSEtJuFslqUQlzHFFr5x4hu33?=
 =?us-ascii?Q?+aL1GK5uyI1qci3wRpvvtnOR3r6/iDAS4N8q7Z4CXsrJaH5r9nJsddo1nNCh?=
 =?us-ascii?Q?qfPjlKFfuBuHgz2Vc+W4xnLPT2MCP8D6YeNdSIEcb7dpAZpn6m7UaxAgGREg?=
 =?us-ascii?Q?KDLujFyHogITrZwQU6yHvFt7dxemnYUwKXRYM6Gh5HaKGxZO9fGufch4n/AT?=
 =?us-ascii?Q?lLUHSD3lq/rBROxHqG70Ub/EYgAOWFVwkinYr9jGERRz9Wt4+voTn39uRcl6?=
 =?us-ascii?Q?1Xoj/bOwZcGFqWU+uAEdh0Bm1xK+UUCdlST/UBJWzo5eLKpleG4J0MOq9l9q?=
 =?us-ascii?Q?4M9jyT7hsNI66IfT2In4z7iqmSszESreoHFq6zjx///j/70e8eVoj6lEXGNU?=
 =?us-ascii?Q?dKkGoY/HVEJYPjTViG8sPLo/9DJ4VDtFGiZZQEok+qWGl5C8rXa+i67QFAcJ?=
 =?us-ascii?Q?ZDkHeIMw9OlXFeT2+xSfflXPblzWy2qObvKWQiuR3waZyOrBtRngfYXJ9e31?=
 =?us-ascii?Q?o/mmQThpeGKhrM3zt04wAyJAhlIJU74XYxRkXZlVC4zZzCy2btmjsSIeQRan?=
 =?us-ascii?Q?nQM5chlFI6yJrKI+me8kj8RhJzqjMIbWDxr1B/J4oGfbtO656nxt2GjWh9kk?=
 =?us-ascii?Q?rasxqr0axEnqz2WvjgNGvookrDe7V0ySWP2Qtyu/fc2ValKXCmTD31UO7AIc?=
 =?us-ascii?Q?TZbFq+hxByq7s0D5Vh5sK7nDI0NW4DDM62INcBQDt3YKEy1I/M9XSnZgq1sE?=
 =?us-ascii?Q?tqaOjh/m4P6xYvpDBVGVkfYKeL7Trkoe5fngRc2dW31Uo9QyQbVy+6npPFnR?=
 =?us-ascii?Q?Zu4BvyKfNzwkZ1PtpbNOW2tXrnSvnNgEPY3vXHCrbfo8t96X/T+J0DgcHMoG?=
 =?us-ascii?Q?jY48Di/QgFPg5ydiuU7stnYd8FJ8GiU1x7vNZaykoQMaknigQoYjdhtNJqn7?=
 =?us-ascii?Q?RwBz0JxnV4kI0wspGYvqZ7e1K4XqfDdgO4/Xv+sLlIUeBTTcQ4DwP2XA2JkQ?=
 =?us-ascii?Q?h7m5yInxd1eXy9N7B6xhuxX+512T9yY7K2+kYlhnu79OyQWLSdphfcGC3rcK?=
 =?us-ascii?Q?OTKoQGd5neSeeIXZh78ihQKYqK6GjTIuu7wBuj6G0ndx/umJA+/mL2Ud6JTe?=
 =?us-ascii?Q?PGewlPVDwKdFyE5dvIbu95AZ2hBmJkE9H7SpqkNzG2VvaFy2kGnHn8rV2r1v?=
 =?us-ascii?Q?/1Wyt9rKhf7FiFuOzrDhgPhS5CJiW7eOy6I16LMBnianKnBq/s3ifJIabZgo?=
 =?us-ascii?Q?I9RKv86lHLyLbgOOOPVrqMOmyF6Z3CHx2DPR1K2ar/nj4piA0IEFC0WiNP84?=
 =?us-ascii?Q?blgryJ9hjjLDAcH+OFqX3Hemy7FIZUmZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 02:41:03.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba3b202-967e-4e63-fdc8-08dccd542f43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

Found two more bugs today. And here are the fixes.

Based on Will's for-joerg/arm-smmu/updates branch.

Available on Github:
https://github.com/nicolinc/iommufd/commits/vcmdq_in_kernel-fix

Cc: Matt Ochs <mochs@nvidia.com>

Thanks
Nicolin

Nicolin Chen (2):
  iommu/tegra241-cmdqv: Drop static at local variable
  iommu/tegra241-cmdqv: Do not allocate vcmdq until
    dma_set_mask_and_coherent

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 85 ++++++++++++-------
 3 files changed, 61 insertions(+), 34 deletions(-)

-- 
2.43.0

