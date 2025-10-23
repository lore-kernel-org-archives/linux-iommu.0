Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309521A9F9B
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187817; cv=fail; b=g7RF3lWDmNfuGqmmml42PXpfmVnH+XidcK7wGhZG077onhzyxebBXZ35VxhMTM+d98H513DiJLdCIAPW2ZK02N+aIgFeL5a/AwFM75CRVUabE0Dz/K/DzozmPqqHjV6pcqkkiSjEEsDj1N9XyPdxNjxO4zhkN/K6P9DBgrBJxg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187817; c=relaxed/simple;
	bh=OpDPc9pnGfy1oYsmB1XuO9TPgCC1DOqlnsqxwtO6rcI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et+yMNwci5mXKdQYPjkFV7VW58X0GUTT39/rbiPrHE+LYIe0FDe9dseBzi5/TKzIBBdfTtDG/KTqEcBEItJBAJR6jRBMBJ3LtcddOFfBvCZOW3lXec9vfdZ5G+RaLomSaUybg1/+9ZqDdZi/NZ+Rhu/3ZhnXC7D/qdBgeJ9BCfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pt58Rt1W; arc=fail smtp.client-ip=52.101.52.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pt58Rt1W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5ZiYOLUi6P6X44f77UxUsYlFb3Vnavlb511SMHjHF1pb0JPybHctudz8sMrx/1zNA3Q4jSzVCMPItAxYDYWS3jr3C/RkbP91x83+LgirwxUz6IR6UgUW81pc3IwHSMUcBJsv1jD/JrfF7qYJXPXqdc7jX/3aS025cwaONp78+HVZcNRPwqEICXJzC/TuFPQAvYNnf1DxPu4usNZrxlipbgMg//Zn5qvu+NnV5mwHx1XuXV5u/pYAqKiVcHrwbm46K80r8N5zF2AaTFbAIKxTqzXLebwQ9ISUDmUsu8xtDoiS6AHHk2eCE+Kh8w28hQ0NlRVjvCQPFw5jQi5lg9Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+4mt6FkVVhdR3277vak9ncSik3EXpfbLDmU70XT0C4=;
 b=Rj1kFnBvCtzick1Pk+O32ChzJtGFSLZlpZ7CdgjT4JNwdBjPj2ZEvEIEVbT0kWDulWxXzzhxUg4DlkRLvnBZvmdLkda2NWyek7J0OURbhWFoZZcK5y3ErmyrdIfVomaGfLW+t4Y8biulIHPp5bPYG2g4WahzZ+iDIb1zxMUi/qZqVUe0I50TjET9rt3tzCDcWL6WEW8b9ZuwXqA6sRtE8zxzLUPRE4zlFtadQ7jeg/TxU6jPJhBGito4u+SebZRvalzxDGPcSrlNTs/2oVmMu+Z7yhOFv28lae+ObFVD+2LCGRFKeu472kZvUrcbPTTNzjKGgv+MrYTzNltq4jRpLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+4mt6FkVVhdR3277vak9ncSik3EXpfbLDmU70XT0C4=;
 b=pt58Rt1W+/K2jh5c0H86W6J+ZpJWIU9WQpcjEsuliPrpN1u0HYBzyLlByAHc7NngFbsCK9pkjVoRO5sR8Y/jEdwFwGe+nuR46QzZdKLclI+z5CAV8G7wQvJisSySrYs9nmsy15dFTqgUaar9lNZw6imQZNvCOvQteu/bHwrJuZFjCMnp2gmVa7ZYs6l0RAgO3Q/m7ixfDgdSXQgDuSD/EPBESWXA4izVLr/MgrNPI9F+Qd/aCrxW9A59kGkGxFHDhjyY1zVDw+//NUAWe3mX+iN/ivrTpnNWj48YUHOz5R6PDQDw7tPUIf1sJv/FC84vcJGkq5jyUelybVjgwwXH9g==
Received: from CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::22)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 02:50:11 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7d) by CH5P220CA0016.outlook.office365.com
 (2603:10b6:610:1ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 02:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 02:50:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 19:50:00 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 19:49:59 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 19:49:58 -0700
Date: Wed, 22 Oct 2025 19:49:57 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v4 14/16] iommu/amd: Refactor persistent DTE bits
 programming into amd_iommu_make_clear_dte()
Message-ID: <aPmX1fKDtwr4seS0@Asurada-Nvidia>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-15-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251021014324.5837-15-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: d209b8e8-4a05-4a3d-b914-08de11dee2b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nJUf5AYrSM1V3ev0nvZqz2ppEwYh3nAlngkF1SbwlftQlgnrjP5CqltfcK6f?=
 =?us-ascii?Q?otSSJCzNJY7tutlVMhUmUlz9XW7eUfL8qep1yKqMh/C7bGA3vo+E0Cz12ONA?=
 =?us-ascii?Q?2IurAtky3izcEyPqqHgJBhqAlGMReSdu/Sp+BMJm50lyi7F2taEO513QbdkU?=
 =?us-ascii?Q?e747LL7Ck4MJsJPPCY4U2GXuNlnw98xqG1IPZVhhwpSOscEujpDUoN2K6tjO?=
 =?us-ascii?Q?3bVJ36pDDaa2fdJ4a7IVheTTCVPaQxNmlDEb57cgLO5syR/5Rc3uTp8OmkN0?=
 =?us-ascii?Q?BcocBDw6L3tUQmCbcFlk4UWOP8ly9cg21etFhUIdFDnbFgVfAMXiGDW2Sl0M?=
 =?us-ascii?Q?tW0pCsB1XpxVSqeEpATTkV42zZlqR9cdFrYjCWQJnrCxAEdSIQqoXqLcA5yD?=
 =?us-ascii?Q?wF1socM/srXAYPtOonOxHf2VuFEm3whR8ePJsZwWjyU/Xb+5ABeENMu1J+u0?=
 =?us-ascii?Q?ZLzM/ZwP3+rZ9b7Rr3afGqg3xwYJNkefLeyq8bmUd4eNzowEJhoU8I4t91hM?=
 =?us-ascii?Q?+jA7vSwlODo5auKQ7XLuhyCcL1oHjF2wDAHo0IWSlagvVuQbw7PLwtc5nKsa?=
 =?us-ascii?Q?o4eEAmsMfrLNzMV9wLpI3aPGwdgkQ96szHd2gP1oyBBUAZvCu7ab7sTFCcKS?=
 =?us-ascii?Q?u/auzI2qlInHN1y4v4NKUPipzmhqsVflFXw3fBnL1KAjbNXWcac5gXRJALul?=
 =?us-ascii?Q?ilrRCM5gCxnUOf+6P4ZViMzTdBvrCU545T8YqCmgazt29FZZ+W96Ym6nXzTz?=
 =?us-ascii?Q?i3h+oEr3mAXZoAWyThIg/Lz6GkuyDBoBPk43fzJ9uBi4YhObHkxMwUwSAsmC?=
 =?us-ascii?Q?2w0ArpXe2ccqfxdncb14tLCZLzaStBz4gKVLdPU+M8GtAzChMyDKxIRGrVSt?=
 =?us-ascii?Q?ZZFEUiZHovkTTvvFuLTfyJuCyw7F6yGXbl6EfeRp9WdokJfUjvS2nHThi6ip?=
 =?us-ascii?Q?Hh7U4x/bPTQw3cZyJGwLCC57J2jpVjPvJOCfB+gyRLheq6PDqeVY0U4B5aRZ?=
 =?us-ascii?Q?fpKFx/ufPcNijlz9l+pfI6CHbrO2Que//jyxkJhp7Y59UEPL1jesSQQhsiNd?=
 =?us-ascii?Q?Mu27dR4obmduQcE3eZ7lABwu8L8OdGCmDA9FQOb9D93BEK9xpq+9fJKUPdtY?=
 =?us-ascii?Q?wNLwHCCaAuM85lPyaZxcWn2eVoQMwe4RBjHsImwNNZbT6MdFt0z7xU5eiyTj?=
 =?us-ascii?Q?9eFm8fTR3tS6TzSHqTvKrLxQl2xdOZ8GNT43hgHT3j46wzAnB3Aez29O6TaG?=
 =?us-ascii?Q?IccfrCygMtqx6iCUj/PfLvH8T9LLyLzG4k6cdX/dZChicSViZ3cvWnOB7Px3?=
 =?us-ascii?Q?Kn/WPzDI1IE4EfhMRDEI/OJ/h1PU++FWSgLBuvRb3S/FDLmF7oX/yEhzzcev?=
 =?us-ascii?Q?ycqhmfrH/KdEQck+1ocjQPPGZbLTYylkXM9A7CE9hgoKc56+tQfrTW1XtuzE?=
 =?us-ascii?Q?7Pnd/JT5/UC2wwgN8JsL9JmAvViiN8j9uij0AJhhHUXxugHoBKY1JB78Lu5J?=
 =?us-ascii?Q?v90QZz9C26RGdhVL6wuVHY9y/SR3nsEyV6nEL7PcvDjVt6+tZYrtdPyk77FC?=
 =?us-ascii?Q?QS7HuOitJ1qlfZxhoOA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 02:50:11.5768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d209b8e8-4a05-4a3d-b914-08de11dee2b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622

On Tue, Oct 21, 2025 at 01:43:22AM +0000, Suravee Suthikulpanit wrote:
> To help avoid duplicate logic when programing DTE for nested translation.
> 
> Note that this commit changes behavior of when the IOMMU driver is
> switching domain during attach and the blocking domain, where DTE bit
> fields for interrupt pass-through (i.e. Lint0, Lint1, NMI, INIT, ExtInt)
> and System management message could be affected. These DTE bits are
> specified in the IVRS table for specific devices, and should be persistent.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
