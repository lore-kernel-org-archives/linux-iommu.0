Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456E52309BE
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763407910; cv=fail; b=DC7e2l+D4Ann1AqL3rUR1xD1Toxh5LsxW3eqa48Sko9tFxSHIge+UIIiNTswL1HrmeqDVWUA+Tt05EJ3Kq+7/B5KeIiVgO7UrtPx0MTiVN6LIYatNgU3TTGWAEUc5uKVIPDzLCa6m5nKlk9UF7GTICv1Z4K8eayhimLmKWl8jx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763407910; c=relaxed/simple;
	bh=2VhYaQpmdwMqjJPIYxREOb2DQvG9G+B4R5BmqS6raYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYc5aYNqymUt0NgIWkX1smgJPkkh9kItBbqouWU/FVKZLL+DxzAUmDyg5eX6e+Lzmz02w+pa2zZ2FoslCrMZ6+CT+/RuLeCeHhblZqfM8+Utov8FEb7HQF+Nj8FPiJS8eyWly1/smCg0NPOHCcoKqKjwRnwVJ4uSvMLcw3oqme4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kW+yhCY1; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kW+yhCY1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqRR/AOH0SPWERKQdfSmJT11wuy+jLrwijQDer6nI08C+cHb3I2ns8cnBsOo2X689HZngoJADWtf5//I6fhL44XHAjzg9VtOXJ4haBOovRVC22ujrv/BXgoSDNZ2fTtfnfMah6iOUCGkF3G6xNg5XUy4nnN33rTcXPdpI3xpXRamk19YR6zXhszYiAc4SfCziLccZ6p+6vGsnHuG24jP6g6TzfZ248f8vlEVN47VNYiQaEO77sEQtfCdFG90pqxiwwKW7yxrj3quqCjKCHuEztexIJqRcs7hN+ceBLy9IoHUK1Ah8Hz3KUwAAt53R/l1H5R2ypq1ifL3Za9+iWDfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8gBjpdbhtW3lRvGRTzqKcYjaXghLzYYfgV6o0M8/jk=;
 b=JK10fzXP0h5VnnEkzPXNnOHPRS+HKZ/SqomUAsD8afkkfFvG6xqz3OIGbV5xLcEF+Pvo974/pMCEWVLGeLbiPZZfuipfNTM7uNF1b32gdMvLiCI6JvQA+mFwdhr3ZZWd6wfG7lCwXzyswvymv5xvXKMQSoYK0o0SMuIzNixDGFmTrMGFKzAV7nLQu7w0FQi95r1rQyoV3vmLfdho9HmGac77aHii5QN426j7vskTmgvsdbsPtVTk+5yBHPJpfQ1CmwAqJUF0Rn2GrEjxiiiccNewsSiRvKSo+is1Zjn16rmlAZSZFXpayGOBJYwWBieJqJ9/BJcCcpjtAV20V9NMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8gBjpdbhtW3lRvGRTzqKcYjaXghLzYYfgV6o0M8/jk=;
 b=kW+yhCY1QyizBY4erEJ5DvinU0G954SjHaSuPzpaTeWZxGqR8nH8g2we7e1gOXEHchMAWXBb1yIza7OJgrjleymrd8drMYnC8iahF3mpFNnUEZtpBVd3LEVkXo2z8a9y6yHrA9/JFQ84DyQCRomrAhmn8JJzivuQU8p2Qjp+GlbV1gwNg1UN+2aWwOUgnd+HcyrdK+h6efQL347r7skua6FKfiR+rd1x3HZrC7OsgSL0eOSQxZ5rE7bwzTkE2qjzYSfz/25B1KZHHSj72P5SO1H2oi9AVkzHt+866umT5+LIGrWn17dbdmrSO/QN+MhOsqLhYp9UFcA9UXPbAO5rsw==
Received: from CH2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:610:57::23)
 by BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Mon, 17 Nov
 2025 19:31:44 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::89) by CH2PR12CA0013.outlook.office365.com
 (2603:10b6:610:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 19:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 19:31:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 11:31:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 17 Nov 2025 11:31:24 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 17 Nov 2025 11:31:24 -0800
Date: Mon, 17 Nov 2025 11:31:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v4 2/8] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <aRt4CrmGzaq6TZXI@Asurada-Nvidia>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251117191433.3360130-3-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: b989f0c9-f785-49e3-4e8f-08de260ff14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d5i3S0TV+fsD2D9uq24gHqiDrc3j+mXu0HfkC5fcqZv6XAgXcl76/bFjUpyd?=
 =?us-ascii?Q?6xPn8Z/RoGXHbduyw2bywcsOqLqsianGBApMACEUKGTleoYaQoMKV9mzg8ju?=
 =?us-ascii?Q?q7Tc+ZqGXaOW6CILPoqa/mjIx9pmRmspkDdn2DYZyLSWZkLZppKa5iJ1QOjO?=
 =?us-ascii?Q?ew6GSOxCPn48Mfo8J/ig9LtBoWoUN1FYzjAdNZuVaOjhcurxXvMU6+eRELTL?=
 =?us-ascii?Q?TC8/i3jLBQyR5BH2k8AG059VjQjE6Av1szujAUZdVtKNVO3gJ3f9INZUxPRT?=
 =?us-ascii?Q?2GKRc/r+wqeA+/KzzeOiNOj0REe2rqEOuDsXmpVdXUXM96K5lbQE6v0bjIwY?=
 =?us-ascii?Q?jmRp4pQdKSpNshk2PCJu0akte3aaTCSkS3UvXVyYfFaYhA2wGLtBa2h03Rv8?=
 =?us-ascii?Q?61zUn45z2Soe7Z5fjkKuRmGsPZedEeoPnFUbtyUBtiIAabX27muXxVOgetGx?=
 =?us-ascii?Q?7ymwp2zzPsw4Dh5SSItoddvLy3sKuJ7pFeMUaSajqynjXibWuGM8bQpdxBob?=
 =?us-ascii?Q?sYKDKXI456GlYIleaoza8jvINvxRfkpJJ75jnfc4EgVdH3rE2ly6SStDbJv5?=
 =?us-ascii?Q?Ok+LjXnv+thaDIa+d0IGLkmdj+LiJoyUigFUUnguPHLp5lfNBteZGiqaOOAp?=
 =?us-ascii?Q?ArajkFA8WXogSEUUKM/yUB/WXT9Ci+XYsiKF2QvnfWz5BHFG/QgF/+c2I6aS?=
 =?us-ascii?Q?iqqXdVmu3+F3O6iLj7bX28P71Haun1lJKzJAj62nibRk9uiPMG5APr44lr9W?=
 =?us-ascii?Q?jgrMarnqVLcriQHR/DUUZiK0myKnD6ALGMUKSY8KbBI1yclGQ43KsLBMlT7h?=
 =?us-ascii?Q?N/WWC8o/rD4vd2eLhK8+Qx63WoiudwPFmtJqbljBisgouGZbtFdZtDKQTp4m?=
 =?us-ascii?Q?L8l9BWpJjVTP34EKMAsnIPbgXYIj0uPbPmYJsi406By8IK8jMHvwD4h0G6I+?=
 =?us-ascii?Q?KvuriJ0a8y8AVDHgryGVew/gFIAwjuG8R+xqDrcIaGxNi7KYZkTur2sO+gB8?=
 =?us-ascii?Q?OCHEN9D4MHb+AgadB7nFFoX38EMrXpKdoOR+sYl5e17uPDszBN2ndk8zHP8z?=
 =?us-ascii?Q?l+ZelpO699ZYRaSxuqVo/0HbozsazYsoKsX4U7tWrP7cjBRbX291LudpJKTE?=
 =?us-ascii?Q?vPpTQ1qT1CyL3T5V6Gch+9ZmDKzmu3JdcUjsO540/b14Vmy1iLVPdGGIyWiR?=
 =?us-ascii?Q?91ZtQfziOHHBW+ZY9649Fcwi3LYPDuCRKJ3L30mONKL11OvG2yq1k55yJcJZ?=
 =?us-ascii?Q?fhf5q0ZJjrXNFQ2OUuxb58XAm3rIHjJOA4ACCg0zZhsLdx5HTqlq7BaOndLK?=
 =?us-ascii?Q?i9MHXjvqX7yGKbOSfGgMnUrXsHzgQEmzPwUEyQRmPlEwllkrps9Z01cmLlYx?=
 =?us-ascii?Q?Wvu0lFAsyzHzZA9dTl/fSZ6yzZRX+GNa9HadyN2xhvhz2dHFLGvXfU84d8oY?=
 =?us-ascii?Q?zoEb6tG0Wlfs9lVMvCkYQxg3NkFyxOu8jb2YOKfkoRza4lsIN0lzpUzhuzlv?=
 =?us-ascii?Q?ag2R+oUu/RH8DG8CkTnAYp15+PgEEkbT1bXzdYOZ2VRn/sUDufqdssahujhU?=
 =?us-ascii?Q?KWdsiHnCGQ9ttPTf6hM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 19:31:44.6362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b989f0c9-f785-49e3-4e8f-08de260ff14c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747

On Mon, Nov 17, 2025 at 07:14:27PM +0000, Pranjal Shrivastava wrote:
> Before we suspend SMMU, we want to ensure that all commands (especially
> ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
> Add a helper function that polls till the queues are dained.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
