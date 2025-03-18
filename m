Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730E20FAAD
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314847; cv=fail; b=ZUkbzADlVhQCoAJulWPI4XLaCK4whGWNDhn5aBLmF72Pgjm0QBUfEGNjOMMyngGRC5Pp2ilk63hmviTnKDrDXuVEQtVVET5uePA0nVQ37N6nFKO6jZoptW2iXZQuKLz3lxTvd4QQDut4ZXrvoiAuufVk7302pzyXKAhSe+I62Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314847; c=relaxed/simple;
	bh=jvsLAbqE7JB/DCoYjMvzsUlR18Dww3OzNgCVkBUK0lo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oA81N6Haw3nfLeP/VMBbWt7PXb40z96MULOzHqd/WJy8m2vzHUTUJRfqzDSlud5w3ln/7+J+kdl0jk5tM3SM1lJXGsw1dJd0AfBk1ftoTv4W2zi/CENm9kk5++ZPGNVNukQ1fg3umBCHAxmp1hLKk/3DJyO+PNzBhdr//GXyeXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgZs+3Ew; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgZs+3Ew"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3xEJwJeoX9m6kzHPlEUwyGeWmeUssstbIgIOm2a3Z338tMheszoWsfskWlmhO5t/VF0//FZbDgwm6A7its07cen9ylK4tiTIMf64W2w/NmFAOJpgarmwxm78fjt8GFQse0W8aKL2ebWVZV83LJ2mTHS+qsHVUVGcA8HWI8NNfjqvRQ//XTYkSfKbgXTuOebTF4Vk7oQ9AKBtsGhqeLlnpqwXyaszM/VHX5bgjVQjXYuwl9VJhhUgMsnzU7jwRmHM3phpXYGNQgoPWSZ9cTyi3vRa6cNIMp+CqMC1choaUUfmGl1vNC2EcQejMnHoXUh3kIt1uBmHoWz6s9N/MHDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzC50CBJ0p/X/CioO4JQOBGEVUz5+u05teGaP9BcRUE=;
 b=MV8WL5/MTYhmm0Lnxj/jJpkg31OEI9X3vnsuQ80CT1G2hjB20sTCeIqYu1JELbLq8n6RSJDaGO8XQXvY6Z+NwDVhPZ6dsiHPAhPCwlOOOAhGYtzq4litqusp7Apq2Yb/KbPdMOwyQ0hBxkcI4MGSV6a+ExqACq6Tij5z7rtOvnInbGGoBa1hboPgjZsnlJkdz1d2flvhIH4O7ftX6LKY/wOHV7D9OO4enarppokJD84v3M6sGPyfPwTT9+uizp/LziCVru+Gzlb/uYsFTjyxdJFUmnqZzJG2LeMstUP2+5guiqEyDHxA+ZV5happVcIjPbpFu5P7rfFqbdhbDf5diA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzC50CBJ0p/X/CioO4JQOBGEVUz5+u05teGaP9BcRUE=;
 b=CgZs+3EwLKG5dyscqJ8ovJdVaYcaS3LQGxC01jYZ85epb20sGByYJ2DR4PJSiU0lsXP4JlTyDuQPlpc/bnXG4C/PhQuT17Z6NO72VNnWmqRow5dgKj/Eu4OgKMbsctDz3iqzAxvfrv/C1KbqoSSKHZgtcEJab9YYUFwBjvCfLxQzyQvV/e/TPrRJXZB7Y0FtBdXkJBueKq9KQZ/1LsluJUTITTYQB5zBqFWSuSNfpggWYtzop5HB9GubXtJLuZynYqhtem+WFDLtab0VZdwBnjUjFRUQOpM0iK9KmxE4ry6/OW18JZhCg8aX7MDhBBsKoeFpMjLl3IknonBz1YiRvg==
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 16:20:42 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::38) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 16:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 16:20:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 09:20:24 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 09:20:24 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 09:20:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@ziepe.ca>
CC: <kevin.tian@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sfr@canb.auug.org.au>
Subject: [PATCH] iommufd: Fix IOMMU_VEVENTQ_FLAG_LOST_EVENTS kdoc
Date: Tue, 18 Mar 2025 09:20:17 -0700
Message-ID: <20250318162017.709212-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: c0410df1-53c2-46c1-359e-08dd6638d46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxWDekRRr2t3tAjJEVaux8MgaXuKOCiZO2G7cecVik9vNYIWDvEHEcpBgsnB?=
 =?us-ascii?Q?3aaBoJZ5sKLl/9TeqC2z/iFKkv0PaCrFi2JyY8s8MrvccAYyqzXWurnEv2aa?=
 =?us-ascii?Q?UJ+6inotwhbSLQyBggcmiPkgfg/NT8Yo53Z3o9+Nu221nNgC1qIbRemNbFAk?=
 =?us-ascii?Q?kGthoLuKspOV5028+h4P+isM3ZKnpc5l9jeaSn8ECt7HbYsysr8v+Ei9Fi7J?=
 =?us-ascii?Q?5KLe/cJPmhN8aXe2iapHFTfUDnn86sMRq2a42sv+sWYBv5r+zBjcg5XuR56r?=
 =?us-ascii?Q?qphQwFHuy7mp+UgVarb5806CbRsglIATtEgmJ/9IbQcfCw2cKV4BjOBIZsrE?=
 =?us-ascii?Q?XvM+OFOUiUttS5L/m6fTNFQe2KuEnZ9zl+mbFT3LCvnt1WCee7nHqCUxnSQs?=
 =?us-ascii?Q?xQIhKR355nabUCMH1fSH4tT2EF1FKbBbNikqS8aLUmtTyD0T3t6HPtEv7pC+?=
 =?us-ascii?Q?jR41gxbT/EV+h/3RaajVrWC3O7eRftevxlSZT43Miz6l92Ez+/CmYOAbV+JP?=
 =?us-ascii?Q?0XzCxBA5+xhqV795PiDVDMXwyYYU6cR3QwxHUg0jPiGzxmBRIzt1NNybIHCp?=
 =?us-ascii?Q?wNTyAyZxmv5jkZHhQhgZ9l38rplyGEo0pe+ZtJD1vLZYMGYX40VZLhmAxW9u?=
 =?us-ascii?Q?UePpzrBiQEqVoBMVnHaK90Fyh52f7H98+cYVMyifdI7XqvAS2t7XfO/ReJr6?=
 =?us-ascii?Q?BshxJWDl3BbkyGyYb1/utbyR10Wsji/YzdKSaWT0vSojKn6xtbkX+cYDIOYV?=
 =?us-ascii?Q?k0K8yGTkQz2r549QFj4y8h67Ye7EhC0KAr1vI3E6BJNiTUCRlmPRNxNYg7AI?=
 =?us-ascii?Q?MuX17qarrJw33Rls0WGnK1y0gROP4qPHn8nNiAX+0FoIP++RpeprYFCB25HF?=
 =?us-ascii?Q?pLKmJ1hHh4HGNWv3lCoRJ6poQVi/CC+AbkPq1cqyR7jRCpT27iKAGmwurQ2Y?=
 =?us-ascii?Q?aUv+vxkKBohbiFpoAu0cEtozzUCdSYXsVz97hc74PWw3RKXDeM2GeUVZDf3n?=
 =?us-ascii?Q?UslewvnvJJlkyM8mSVKVkntY+ygHvjJbGfCxKW0rI4kdZYDDhXIf4DwKcSdn?=
 =?us-ascii?Q?UKiUUueyWLkcoZHehBiYHW6wObOtavN3vViwzOtRcNxE8hdJ5xKPFNiRJKtQ?=
 =?us-ascii?Q?IjZgyefJzWWTs3quZu4Xah5PrXURZ4n2ffvoor3ySlNttJhuYi4CeLD495EM?=
 =?us-ascii?Q?dohC7VCdv9/MBFXygArgunnolvsCG00W6WcZ6Pj49YGj5Q2hPbLtTZXK4Gb0?=
 =?us-ascii?Q?Fybb2wm4WBRwoPNG61SSWClbOJKfCcL9vHMqnOtQ86akZFdS+j+8bj+DSSxH?=
 =?us-ascii?Q?FXUY0WrWme4ingo18KCEB2P4QPOSAtELwX9icygkAcb2K8xVERruBHimrZeA?=
 =?us-ascii?Q?mFqww29B9migBVrzK8kQEtmVD9d+NOf2Xh9yvhP5yESwPjqkDbEjsprtYxCH?=
 =?us-ascii?Q?M6ot7okukluMuVpYOo56rCgh5KC9cp7Uap5ovVc6koXT/q9jM1mE/v7/pFNu?=
 =?us-ascii?Q?5ZyUuV1cGH9zmUw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 16:20:42.2575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0410df1-53c2-46c1-359e-08dd6638d46d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

The kdoc update wasn't fully saved. Fix it.

Fixes: 50c842dd6cd3 ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250318213359.5dc56fd1@canb.auug.org.au/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/uapi/linux/iommufd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 5fc7e27804b75..25de462a6422b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1017,7 +1017,7 @@ struct iommu_ioas_change_process {
 
 /**
  * enum iommu_veventq_flag - flag for struct iommufd_vevent_header
- * @IOMMU_VEVENTQ_FLAG_OVERFLOW: vEVENTQ has lost vEVENTs
+ * @IOMMU_VEVENTQ_FLAG_LOST_EVENTS: vEVENTQ has lost vEVENTs
  */
 enum iommu_veventq_flag {
 	IOMMU_VEVENTQ_FLAG_LOST_EVENTS = (1U << 0),
-- 
2.34.1

