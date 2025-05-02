Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DA1AA1E4
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746213282; cv=fail; b=bH94+MzvXdmCT7HG99pWaBnig+g/MRFnLnCuPuv7QKcl3Pf4sqV7En2edf/LG3lUCQaqclra0xpzwc7miVx+hxXzavOcE6tEE+icRK40UFkxubCQrNSoS/q1QRuv6C2EEojnuRXDXbQssW3ekCybQ7PkufyAWyZVokxRayN1KRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746213282; c=relaxed/simple;
	bh=fE8MjXA7aFhHXWSJ7luGgPF9KVN1MeuhLssZ8/QGq1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfnX6ByqEn1/P1RPuiBtsCd/cCBThsdoih97YrZw/lRiJQQbsMrXZL/dPakI/+XDVFyNLIR7J5aQW66nnyjC2hY9/welhRHZtRpXJ+DnSZ+Knf3vBZyiXl2WVWy/1sD7YXVMLpYNuIhgsYbClV+ILNA1V+XeK0DQn7DBqxqheZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngxgKZZp; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngxgKZZp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajyiSW4fbjF1GdiKVZeYggUJwQcp7FedsVKIjih1VogGVKRWB+7moKqZB3CiRWbrml7Ukh/AdFOwrPbCz0+MIvzW4OUk/Tzb/LiruuZk6uc56GXcYypvrY//llbzqgxdozu4Klt6gLg4nEAc2pBxD/UNUyKS7t5M8TwBCu45YDZHAZXYV/AA2qugfVHbZqXdUGlhQbYlxH2SbHnAHEsdbcaz2ziAsvMH18KsLckid9+GVOVgcoyLd0G76AXXoBhgm2wVD+Fruile43qKOkQW+NCptyD29G1hxksDSBn5hUXws5aYeFmKx4wWHokBTdMpRzLFillkm7/8A2JGtdJFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUzyxrfhv1ECaWaClxJDAZZW0ONaP8iXDtOyeq7oyJ8=;
 b=CmoyTqFY8DPuMDR6cRi1ViLixWCY59vN0knp42yDO8AlIMnLhwKs58FJSW3AgNhFcAGB9tsHLairCRc14Bbb16ofDcPg9BFOEjC47dwHhzOALVCQZISLHBPKv5ZEssSCn4VXrMkh1iSJHVNov0WzJMOWJErfzKobTSqbqubsso7R0z9GyUFqwXRUGO2AkAmECx6vOMgpsNdJ71tqJL7h8CdhjA+nCptGWxRre4jUoZqyMn7WymxUmOR4P7FVbV1+GDH5EhfUTz2H6sQffNNmYN5HF1nJ/ssWNmn1fTcpabPEI4noCpM+UW+8e4hagdhU0uZNBG/0lXj+jLPtAxa5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUzyxrfhv1ECaWaClxJDAZZW0ONaP8iXDtOyeq7oyJ8=;
 b=ngxgKZZpVC9g9Gurztbb9A5L9C8CgyVJ7WbyPEL/E++8SEfW2LN9BFP/loeg7MVVUFzZHnsiW/ptpK1Xq0s7DDcUTOdVbS6aTEYDq7L6k7D1P0lTRyX3nKTUj+4S8aDI/46aD2H5sSgv6UCn7gcH/nE7dOZ6NWEL4dtwAa8feCxKzI+5L/mNadccWuhU50v/8GJ0eTNCAkKLBKxOjI3Lb3jhOazu7FuwlA0le9UB7TyFfqOtZIE7FlwCUxdXE5daLMuUPU//zwEqPB0i2ZledQ3WO3F0dFlnw5k9+j14Kxwy39TdZAZ54wmdUB/E5tEAFp5A6osaD848SXuLHs6V0Q==
Received: from DM6PR11CA0053.namprd11.prod.outlook.com (2603:10b6:5:14c::30)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 19:14:35 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::95) by DM6PR11CA0053.outlook.office365.com
 (2603:10b6:5:14c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 19:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 19:14:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 12:14:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 2 May
 2025 12:14:22 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 12:14:22 -0700
Date: Fri, 2 May 2025 12:14:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH v2 01/10] iommu/arm-smmu-v3: Refactor
 arm_smmu_setup_irqs
Message-ID: <aBUZjJWgGSWaUwUp@Asurada-Nvidia>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418233409.3926715-2-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a080d7-5452-4b45-8a88-08dd89ad939d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?90jZOqB4NCFE8XHKYoZd8QUFMfR9SDOp3VYqOqUp81h3kpNRKTlqCRJMnAj5?=
 =?us-ascii?Q?wgHI7E8Hl0ZjjBvGV6JrzMGjzL0SUh548SbRphybY6Sv4U4q1FdvfOj7+HZM?=
 =?us-ascii?Q?6TCum3JJPPZ+HubZFalM5ynnvy96K2MRXOMonM+EhO07f3/RS2MPSBKtukbl?=
 =?us-ascii?Q?CL8b6w9MaaPL4A8kvA6vr0EURbnvJSczmZeCRmq8HmpHQZOCf28l6Jwd+a8X?=
 =?us-ascii?Q?CqojYEd4eAi/ZJu4Z+vkT69IJrpLmp+AbkTIhoc1oJDvKmbqvxeEYGIrU9ML?=
 =?us-ascii?Q?hxeuQI+YSxKCT/AKO21+JhKBYRcE64TLGCfTHbUSR9btONQSWrIFSw6ZrFup?=
 =?us-ascii?Q?2Xsi544j/rTEib4m1jHIaI9hk1Nf7IjucAnvFXAtODY2vzVHI/Fg3ZKacX1T?=
 =?us-ascii?Q?SdlQOuPbEtTYCbYG/PcgD3Sgw/UdD807E9l5R3+8e+H+xi1fsCj7cQ2X8QsT?=
 =?us-ascii?Q?X83OJqYYrsChN9J45UHu1ClHBYdTe+9c2robweHtzOqHoJTP8xyKr26gS7Ei?=
 =?us-ascii?Q?Ne+5ZCgsvI2G2c14RQWJuK0eR07I/MUwanGPjCmqj8UG8oERW1aje40E6MsR?=
 =?us-ascii?Q?cWUnOc+Pgt7vhwvy/CvLiEU4aPrBV+aBtgmu3Wzfsw6eTcWkGHQCGLBkBYSp?=
 =?us-ascii?Q?+cHMVI1FmJpkASrkmZ2U65Yesq9ZQxgtUu4lUlTBkkXaJR4GIx9hwZnsRxp1?=
 =?us-ascii?Q?e3utgYRHlkx497uinkMp8XvCuw0M6NEb+ui7O+gND4cNoRWhZFyRz6tk95vb?=
 =?us-ascii?Q?rf5M3a+DQrewq4J5uRESRz/O+k1udRuXackJxAId21nJvLLwNLSnBqn9PydM?=
 =?us-ascii?Q?2kJju0EXrEaTq3Jfwoxp2JmNiGUBZ30TNsNVpb1R3qj0d9NcIAGjXWoBrjJo?=
 =?us-ascii?Q?muKDLDeQjaLFOgtRodq3Qeoy4s98yR8obFcfp0RvQuTBePr2cCOglzJWx0Jn?=
 =?us-ascii?Q?slJBh8bhaC2+XKvrVqK9rGXr+VxHUomhCDLvDAynNVb2xquOvTe740CQPqG9?=
 =?us-ascii?Q?6F5T9cnifpRZcY58sutgHRrhITsSMXc8+6NlFLra+d2Dk78m3VseDwUNl8kh?=
 =?us-ascii?Q?TZI+4ARgf3SmIASR5zISD/BvTH+YUAalGqzKNRYA/LeUu1zlTlypsbyXYeCr?=
 =?us-ascii?Q?vG6H3YYz0/wOaxkzpRNnTjcLBOr2v1ZCEcHYwZOcXzD/urh2ZBWzbMiNtJpp?=
 =?us-ascii?Q?om5FVCcmwoIrUzEWCWR5Re+j3EzPRlSpB3U6fBz2VO1yAqmVa7VAY302R0AZ?=
 =?us-ascii?Q?lkSud12vu/HiO7FwPnGq0oy7fp1V4Invg8w4THww6QVyTZ0PsUlFXlmgGjyg?=
 =?us-ascii?Q?is0OVfONM6JPlKDDBBQ6vzjLQKTCuNRk3QUwto1nFtJUT3WWn1zE5JJZJuO2?=
 =?us-ascii?Q?FSzX2V58yUmmdVCRW3Yu6vlQ2gw8/wncDpk/7cBBJ6h2eQhoixOGGn5d2pVf?=
 =?us-ascii?Q?xVNep827MJ6sXcrnuQR/3SL2ELMJCuy9U/0Qs4YJPGU+07HYsl/Bqt5Pu3jj?=
 =?us-ascii?Q?Kh6uRZvKxsAyY/QIoXY+pnf/dtnho9u9XIws?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:14:35.4009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a080d7-5452-4b45-8a88-08dd89ad939d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

On Fri, Apr 18, 2025 at 11:34:00PM +0000, Pranjal Shrivastava wrote:
> Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> registering interrupt handlers and the other one for enabling interrupt
> generation in the hardware. This refactor helps in re-initialization of
> hardware interrupts as part of a subsequent patch that enables runtime
> power management for the arm-smmu-v3 driver.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +
> +	/* Disable IRQs first */
> +	ret = arm_smmu_disable_irqs(smmu);
> +
> +	if (ret)

Could remove the extra line?
