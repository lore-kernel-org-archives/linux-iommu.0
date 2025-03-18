Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226C17A303
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325881; cv=fail; b=Oqfdm9G6HlFh8k8jyatKpInuurW2Flo7eifBQX4k4gz0K/YgTHuCIK98OEwfjbmCq1OW4hV67/O8b0cR3sjs6W837qtZndsDDB+M1E7Dt8wjaPK2nxxq6SPd3ueotfpTjg8CLosPKNO8/8Q3zHAcpyNSuOtvRb0aPH4LdC9TQdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325881; c=relaxed/simple;
	bh=9mOmqVDUi91PBE8UeLGMkId/bt7RsZAD0Wy86+3EEBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXfE4GUYczaWrntIKqE+mki2KL4FCNPsCeSOHDkMywsugbdtmrC/tKMYmg/eks7RZ1t315Hmcc7MOibr29SMgoApCYxBBqbn5SJm2lJX9CJc0ch84x8wq49PMMxikr/xivTnV2GQFDnMV0L2r5UdqLAtrLmXXiuxmaAP+NFwQIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qkL/jSdH; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qkL/jSdH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDczT/VjzrBFoY3MB4ZK4hrnmvQTmt/F7oaFhf3oeVfIrbZZ/UuufhER+rOgPAvR8bNzZgjj/uD8+dFmSGhB7smv0G7XPe4h4YYtc5+Voq/2cpIibROUfgCqCZNYNJ6KQSdgcDeJPS6mIeHseMgcxXhUc8hVplJVfLkJ8uWj//UmjssTF0IzT1C2uFpkCiy9uwMjzFKbLcWMw/PEdg7JKU1rqRrKcwE7/aeHl3KVA7BjF4w0NjYYagbkUw4Gt/5pTdrvdaYGk3nCu98ksbiUd+G2vd6rxZbt4mQh65HSuncF0a/iLUqpwIbAtiSPY241K8gnOzd9E1raq7EqCkPM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9US+8AzSZRx9uGVteDwkEx6A+vdktRuWW20Wh05Vejg=;
 b=Tl7iQ21VLilhHaJ5xvhWVjp1AXRMdCvUY9eGgyT4LMT6ioZPc7Pgd2HI6JwzI0cyDnF7Ozbvm8Bg2NHGjcszpt0DymipEyFXBMVNCAmEUBnttU7dcDNXZ9cCdvCYGNDAIvGtzgPSQp09zUeOuuh5Rcnv8GV7J3H+LnevMVUy8fqvROnnt31Y58C5tDzy0g8o+JbPGEU6U+UNF2xdhHk5xCq+phGCMJem4y3+x6CnFUW57h0O+uw6jLJaZWpjI59H+zJ2MhXPnUIdOhO0tYtW7uVxLq935RWgDmO9Z3u5kmsXe69TCS2LpaemDRSXJOpG5rH5NeHKOXUF8PtJNR7+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9US+8AzSZRx9uGVteDwkEx6A+vdktRuWW20Wh05Vejg=;
 b=qkL/jSdH/rFczjFtlAX8sX4J8TJ7eHwreEMoEt0FNIagRWs2v06B8OSRQJo4JgSwJ9NP0L4ZmTyHSPxmczDQLNHBo4pWM28iGCgXY01o/alJj/QcSDyYxEyi4NKS4RCpPiqXu/LwShvZtosN2VUMiLca+nBzkwoJTzx3IFUzN10bLROuWVQp3+mjPthUAGNrpBvLKh8FvBAuXH6c93UTvIXELTIizlLoeG9Rb6uEsEuPFLMm6/fxl2R8bCxmRHB5KM7qEx/IGVm+7YjOvHNZeF+h8IYSrM7uN0Fm9YcmhnbAqJIzy4JxZNNQpvACxgDLtrKS8xxrGlZTs0JNZAmrxA==
Received: from MN2PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:d4::24)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:24:30 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::a1) by MN2PR04CA0011.outlook.office365.com
 (2603:10b6:208:d4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 19:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 19:24:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 12:24:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 12:24:20 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 12:24:19 -0700
Date: Tue, 18 Mar 2025 12:24:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v9 06/21] iommufd/device: Replace idev->igroup with local
 variable
Message-ID: <Z9nIYnDdvnFh7F+/@Asurada-Nvidia>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-7-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313123532.103522-7-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a16cd95-b0a0-4280-d68f-08dd66528135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnhIwheZyUTvKwSZNMgEPtPlIWfxa6m/o8rC4tSMdZaLcJpPYSZWkr6AEiaH?=
 =?us-ascii?Q?zaIRPKCncBUyWrtpKx6xeidd8EWz3cBfc2rMZtWkYFtJ0acCVSnfZa+LL4F6?=
 =?us-ascii?Q?trB8JdW3s+Oj03Ss4AxMn5P23/p/mbnuO12fgYG+a5uabeseQ3jsdaZKcHpG?=
 =?us-ascii?Q?a9aN0ye6+Zpg7dkJu1+k+n/DshZDpUMhJs+EowCK4c3JlhLvM51NXuYXWRxb?=
 =?us-ascii?Q?4wp3GKZuFHE7evbx6gOSLuIKPCi4A9ccH+8xDLmgI78vy0Pt9lZHnMGwMS2z?=
 =?us-ascii?Q?nusqFBn/KouQ8X96JtQIjS+Wx6v83U1KOVrks2yOF+O07jvwk604TyKPhDxq?=
 =?us-ascii?Q?Go1SCdZLEbQVkaDZHiMipA129C55mySyIXSLfanAl3J1OljnKf+bFOKKqdb9?=
 =?us-ascii?Q?sBRh+G1c+rKE8t0tQm+5djoQ3kEjV9wvqrxso1q5OyqGlFg4ZUcZpPw2NCDl?=
 =?us-ascii?Q?PQYdyCShWJOH0PTuK2lqDaM/oaMppuS3w4nPOp90LApnAOH0hOEujmxDtUaR?=
 =?us-ascii?Q?ofdT9lVXuV7ph/Hm13zi/GvAcm7SXGXYFwZdbIdvgP2bwuFSqXqDMC6Y6keS?=
 =?us-ascii?Q?purwXuqi68JF+VlzH4VD0TXYaK54mRUblCP/T8VqKFf6IjO/dghECkc656Lc?=
 =?us-ascii?Q?peQWSOuojywygop5cjEyZfze+8pCm/mQwifPuOrqshn5EOQoYPYq7WrfM/ZK?=
 =?us-ascii?Q?0+42ZJPj8IRHxdnVByYuDFGoYIIUBdUbvGLLMaxGA73+OWWy+adP++wmfLak?=
 =?us-ascii?Q?H1O43yp3w3vgjS6b+Crd0DFne/6Rfhr+euHEB3ANHmVle/uNv8u4wDwj/LpR?=
 =?us-ascii?Q?7HpuqYNbSEKaZ2u4LJ85i41iR90yWawx9+i94lkDy30sZM8hH/qU2tZYD0Bc?=
 =?us-ascii?Q?v9+x2MDYkczm2GaGLtviI6EJULdwp7PqwV05dbfPWIxlI8m1zF5KBBUVHJsN?=
 =?us-ascii?Q?VerFZFrO7rCu1OBAW+/ZsuwEHso7bV51OvdOmInwV2zyt+Q/MD2jkfZ/pddm?=
 =?us-ascii?Q?YK2T0XC9+7SOXH+mfTk19toMj5UAuSeVyKG9pirsfkt5G3h58d29XfBGoqXF?=
 =?us-ascii?Q?4nuGiSRx/JqFSs1Y0PHTCpaUjzzjvLSGDdceD7IFwKdbAN1L2ZWWiTrObppI?=
 =?us-ascii?Q?ZVh3uAbXB6+e3Q4GXFpOZvyGWbGzDSRPR52ntBRUmEednGkur2I57ynIIKGu?=
 =?us-ascii?Q?W9qd6TjIeCa340KL0tYNHU2pnwEZk4ub6NQaTJRH5zoRPWkJQmQKIkP+7YBv?=
 =?us-ascii?Q?Hwsd/qpWBKEn/LyUaOLtxmS+DJYJmETnf50eDiQEkQ0xY5f2Omr14kxhHRT7?=
 =?us-ascii?Q?i/LS490/AFB1XLk+9GFTVhetMvjZ/AagNvWDQAhZM/khF/1lYskJFFfihyD6?=
 =?us-ascii?Q?j+AuxUjzbBPvylpjJZrZr1YABt5r8L6X2CfyFM4Xrm0FTfrem4gQDMohP+nE?=
 =?us-ascii?Q?n8OQnjzpIPDsyBje65hgPvLlkWU+/WTRRqbFcgvmnVoHfafBf8DRTiljB7OX?=
 =?us-ascii?Q?/V6UX46cKHubkJM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:24:29.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a16cd95-b0a0-4280-d68f-08dd66528135
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

On Thu, Mar 13, 2025 at 05:35:17AM -0700, Yi Liu wrote:
> With more use of the fields of igroup, use a local vairable instead of
> using the idev->igroup heavily.
> 
> No functional change expected.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
