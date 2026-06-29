Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7141A337BA6
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767824; cv=fail; b=AQvu0iEQeHicoR7Yh1V9fnycu74xWDCLdEHPuNovwfttabTvv+NY2hpZJNCr0c+LbmDHWCUfZX0siIT7LRJ8NbdD6OabiUB2r3X+EvYxi3Alyv+3QiYZEOtFZHqFOweE9G1ftbFSkc2z15K+lMStEkll1Nos0W54tvo2ENbx+Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767824; c=relaxed/simple;
	bh=2tvnql35GRwrwjt2aKpk3KIhqIjJjshUkYf1ldwWnUA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RbtNHzBNM1yofpfc02nGJ2YhDsrWB7Un9X6HOQ+1qOQPzuOuIxMlm9BjSt8BE89HaYDktLBjgObsJw9RCQu09SFl+uCEKqONj1P06TtBSWTW8peKjJik3y6YO4xa/sKkBv6GpNebXglKS8vOIfx5YD7pYUzSewOprDKjE2h9AaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lE7Ctfvc; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lE7Ctfvc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9hQgWOqrbu4l39FWiQL0eU406mQpxKFs5g7Wj477UULn7WtIrje/XMgPXVbvHoTn+Eun3AR5D2dvT9yDl32M6DKM8N3DmACmwtTkoWnYCHiXCwm90FvnWgQve1xrLia6b5KVi//eFxY+BEAtE2Jt1klgx0J18+Toow5HxglZ2oblJ0QZ6xGxdRkSiHE767OLyeA2H4VOtfXNbb4iqfORIWP8MxWAtH076S9M7llygDeB8lefif8iGCG4a/GeG7ATywYIkS7CmGdIznqqYKWXxyl82/AzngAyMqRcLCam5AeKFfXIYFwNn7T2zIN7neyJr6td7Gh15iT1U9KWSdPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuMw7ffZCvuFkUCpbvcY097RSj1PxiB25xOGn26g0Qw=;
 b=Sy9Nn2arsRSdGr+WuIi2h1Jf+IMsytlO3Tr0QD6lOQCK6+2DeYur9ktWNykT4NfI6FNxsf6zFnFNphN8RcfTFRx1f5aR69B4IyGGN0kDZVAJtjs7/vsGBfR9DNE/yvSAelcEKPZXcSobuOybSQovdE1JZGC2hthCBZ44nVeSi96dJplji6Q5WJ8AZD1ROVNK42P1thkSUdedFYK88isWLo9Q2SlK2Hfu6MCnogbDy7W7VTCqcLUcAYTQh3WQIG+DdSgVV+wca4lCthK81bkIjucSykCTMArGcoBV2mzuM7RYiEXQ3jpSoVmHcbd8Tj2m7DrL+b1RfGg+dMcbssJZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuMw7ffZCvuFkUCpbvcY097RSj1PxiB25xOGn26g0Qw=;
 b=lE7CtfvcwsTwFxd0jcbszzuYs3Lv8W8nlnieW0GeHRkGwiT8DIymr+ouq5QGTygQM50/jjVQbcPxOdtUJl3kL75JKHxUIaRUEvW5kBeYAITu+kTyXEcVx6yN42ty2SOWovi15dUBeycqWmnP6vtUoInsXYevsYIgGGRN+tcD5zOb0kWvnzBKt51Dod3Hb2if5YQ0RkEd/Q/Au44X8ihLSt5wFsOOcm0XH3nxVF+zLTvm55cKynoU5T4R0DMmyMvhrdFw5/L/e97fg1gyYwan/oY4de9gTLw3K40qqOXwR5u4G0GqKzK9FTajwTfDmCeAR73goI3Jv82yV7b2Q0gKUg==
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by CHAPR12MB999247.namprd12.prod.outlook.com (2603:10b6:610:2ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 21:16:58 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::1c) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 21:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:37 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:16:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] iommufd: Fix vDEVICE allocation lifecycle bugs
Date: Mon, 29 Jun 2026 14:16:23 -0700
Message-ID: <cover.1782767110.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|CHAPR12MB999247:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa752bf-fb6b-4bf6-752a-08ded623c0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	yu6n9fgTH2vkh1zf36vIMKUF3NU6Dl9jDPVfe/SJW3tKzO5AAEyjCHrJy+ypevx3LmaTFaxYylrxH9NoObkNNL92hekMCpcJ8BGgxmipFfZsiRM0SBUaj8nGHCYoUEdhlR/z4geL8YwLcUbtVFaE58V9wNJdj/F2OFjHLw4Y+gAuLnyzbPCp8Z/wW08S2EqMp+4kWN7reSIE/5YqDjYsjVt5AwMiPtnk6zDYkmqCj5ZiiXfdZlnYa9o7ccWF2CHCOxe5coCFDBJRDaIWTGGKgSlVJhVHRFuWR5ZS9pDVKHSXte0QAKP8C6oPHs7hF/w0IbIZE7Kn+n1rJTNn/++l84wg7nbw78XbwbMUyPupQLmXjzzSPgXdlO1XQ1uenQDrbSxbSlMUHWb/+OKcEBMAXqlEeEuuvkV9YzdXXvYpVxrfh+H6e6gy2NCs9E4zkjtE2ojlmfYS5d6p8ijSRqePwXnD4jWz3lUdgGjfgNKdEatft9moRxMebub2nLjZsXxWdrVBUEZfQUkMdrxzjYWuGYkWSVkFL3YdD2eW6Xt/sbArPhfjQlE2kIaAn5JH3yPsF6K4QDVMDcTCGb76lvyKb0qvFiMJGgaXziC0zjV3rhpaMjHGfG2JlldnoI9D5XYORe1KQ8VeeEgRB+otLnb8pPWCi1p470YobUNE6Htp4fkHVkP5sy0wqkwXZzPW+tNnOzukdkfbqywUi+4qEW5vzg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(13003099007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5dGafE5Fe+lEt5JJWvtcR6DWa65D0iw4DlyEUBCy9L1sB4cK6tilR0TKyTcYCUznRMFV8y41SCtXzoEyC9Eo/YZ4ZMKd2wDM81adU6V7p2x7GFF4eVOGZRW24WQGOu1MuPcdp6l9Kjmhe0/fSR6ZQo/8Nbv+dHu3PHyKW71FEJByablt751WG9BayDgBxmHW4F9dB7x4S7193cmIHywaqmjU1nulBCjnzMDFQhlH6chHRUIY40MUz8I1lsNHl7xvxsA1cuXXdaCPKniQl7qxpwzSor5iXA6xETFtE21MUrnT11AWDtXt37euOvv31nOhJilXwZQEqZIxNiGp7eH8uEZZWV/XNIwxo4hf9XwPzpZ5sfzaSdZ9yKaRbB7SYFdq8Ghf70GsX9XV/5u2cQiBe1OjLb6tjH5YrzalOg5t0X/aqC2/0Xo0ymVjL1ev/g+G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:57.7631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa752bf-fb6b-4bf6-752a-08ded623c0b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999247

Sashiko flagged a few bugs in how IOMMU_VDEVICE_ALLOC creates and validates
a vDEVICE on a vIOMMU:

 - the core publishes a vDEVICE into the vIOMMU xarray before the driver's
   vdevice_init() runs, so a concurrent invalidation can reach one it has
   not yet accepted;
 - the undersized-vdevice_size guard returns holding the igroup mutex,
   deadlocking later vDEVICE operations on that group;
 - the Arm SMMUv3 vIOMMU accepts a device without exactly one Stream ID:
   an out-of-bounds streams[] read for none, stale ATC/IOTLB for several.

Fix each of them properly.

This is on Github:
https://github.com/nicolinc/iommufd/commits/fix_vdevice_sashiko-v1

Nicolin Chen (3):
  iommufd/viommu: Release the igroup lock on the vdevice_size error path
  iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
  iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 15 +++++++++++++++
 drivers/iommu/iommufd/viommu.c                  | 17 +++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

