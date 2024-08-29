Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120911494C3
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908821; cv=fail; b=BTI4DpYs4AQmPOZ7fOzyxXVVdQI5/a30o1c3W557U7+uikRyX1TwSvxsFBHL+CcMiY4LwovvTvKHf9i4pXFKzZtFKW7ql6tWhfFMP9ZUasa2DRCcXL9taPKozAh5iB2DM+HXmNhnsqAjfbFF2PXDebulFf5n4s6se5rPbqDpwHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908821; c=relaxed/simple;
	bh=m8RFbPKwQLpxytw1NCwMnOxeRXXHHcb3vwA2qlxYDh8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NogjeM0aqZYW89gvnuNTsmiisjcTKSS3TUcoSL4fQuLw3fsRzgzjuqRvyLM34wCgadjwAr5XP//JIV7HkOw8mRtXPLH2NeWVorZtJBlIyYwqpM5UNb3d541jCLpYGkE4Tzalr5oc2jVsi9sws3Davv80NkyzT63042AKgIU8cAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r7i3tHpX; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r7i3tHpX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH38hW04t3E0N/P+gTrLsGdUyVSqaJPztihwzMbLW2yAbe43dGGDVqLTlDQIoJ9NA0NAWIqeOFxtslzuIGVdEqHpH1pEXnqvwpqLTLWac/2NvduWJSutAbmipXT82QNlxIiA8h5/bqkWLWhcg7LLFl/EsnnKQwpIbuUmFQFsk3dTmi7SNCqSFMG/PlWYNHpy4xINfYkNUeH1o3Lmw3nY884dXNQxhW+UjGUNCDQnndflbVuGx8F5D6AdJn1jpodUl20xpMKj64aqM07mGQylV8uf8h/McGKKuR7obNoaJ+YASpJJeBnCUzrxPw3D4SqcNFTMDyaM1JhyhcpS9vCuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgO+4gxTEkaaS3gucw40AdfBUP18bw/Pgxi/FqjTG70=;
 b=Is3bnBWNvUanBLWwyVDBuildu9w4KqdDaZhis/N2A4/lIduhVHpYghRjNh5D1czwqmNiq8KtUvLVxi8tXois9et9PT80+c/DG0cvhd5S8l+2rvdBF1bk5S+edEpeNO+Fd2erIFvuKHGALFYyzIj1lHyMygDq/+HS0/R9q0eMmaaXns43S2qgVFhe2jbk1k9wPZjDVXkU2bLOdasBUUoLb2IfkvlifRZ/dSCf19VPSH2yqLDg7SubENHUf481MYbkQGJx8KILHdwVC6yiDJR8syfHojst6M1xldhu+s6x0b3QdyZANjDHZILySM2VEQGaq2JNuW9DnChwPid3hEFLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgO+4gxTEkaaS3gucw40AdfBUP18bw/Pgxi/FqjTG70=;
 b=r7i3tHpXLoe32kD9tkmsBQbnsDdWCXOi3HoNChOjlJNiV7Ildv2Z9/op2eDHs4GQKt1Yuh9aGyJrLRa7IFRLig3Qe/vwAsSKeQEvUSR12N7+rMM3JXF9kcsorHQSgyeTmAK2AyLgHvxdovpjD3wzI3qeNNVc9FECeIGT/fTLwVLfQXk3JHACJ3rVyiV3q/TiLyCjcetBHOtgHN40SIrdQgygVK9p6rXoouWzJXJcourmgY+mgd0Lh8UsEsOmTFqk2aEWXpoujskGawu53ifzBvJ15zu4Ddkum3kvwjv3nsGe4r2zSyUNqnWMT249qWC4siKT8N+F8WA7ZYE/gCu8xQ==
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 05:20:15 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::1d) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26 via Frontend
 Transport; Thu, 29 Aug 2024 05:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Thu, 29 Aug 2024 05:20:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 28 Aug
 2024 22:20:04 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 28 Aug 2024 22:20:03 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 28 Aug 2024 22:20:03 -0700
Date: Wed, 28 Aug 2024 22:20:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZtAFAs86+iTmEHKo@Asurada-Nvidia>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-3-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240827193026.3993039-3-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe3ddb8-f076-4027-820e-08dcc7ea436b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kym99QK8uJvHOi+aTwrzHUrrL//8xMvy0qYfAU15OaqcVHw0Q55WdEDRzICY?=
 =?us-ascii?Q?g4xIwqTlZ5Cz1r/kOLIFiocrevnirgii4CdM9BtyBn+Aj+RokZrobHNwk5Q0?=
 =?us-ascii?Q?qZFwoabzieDJr+Kp3wEDKPh7BNulR9RSpU8YrxMKQndDrZ9mKcTwH68OEkhS?=
 =?us-ascii?Q?FpXkMJEv/PRnr460y9viQz+6nog0RelI9Gvoon/aMGgri3wStSjMym6FW4q1?=
 =?us-ascii?Q?Lkffy+MWwKnNGXBjoEPQESBHo2cmVQUOua7T3SJKjswaiQMYLTny4nidLEGO?=
 =?us-ascii?Q?JLJ9TEGqH7EFthbaIz8QCsqrbxedh8h6XaPCJhFkhQ57DbgMfiB9dztfGSgt?=
 =?us-ascii?Q?YsuPRKmIAcw5kccqn05b1kZxrhhXJ4ehldjVGTLenjQjQJELONqhv1h5E/02?=
 =?us-ascii?Q?Bt0WH2HTw5XXnIXIHfog6sQj5v+4oQZWuQulR8auyAhMw7DWxr2eZTI3JkRz?=
 =?us-ascii?Q?YdTg8SjpeV06IIcLXhBvPJY14ViSJ3N6zp2E/oY52ikypasTvwCiDdEhu7f1?=
 =?us-ascii?Q?NnxgLnb/r3gOq8DeYxeo4y6cuJoijAzLsutlo99nSFxKrVQ3W25VjhWXI554?=
 =?us-ascii?Q?WQCm0guRpnck3BdCnqwr+Xo8LrTp10F7FLaqRszDTjZrPF5iIIlO5a5Zuo36?=
 =?us-ascii?Q?BYyxd3+4wWx6+uJFdcrx9QxsHbMvzX5FQkdoMNRi3WJ5zpBrnvLk94CFheY9?=
 =?us-ascii?Q?bKHxfHXnGmKRdxLMv6+XIJ0NYc1bp4fbbu7SAPhTER2rRM7dzkkmfDjTjkYU?=
 =?us-ascii?Q?FwGYr5jKswKsVSo3QxcIf5QhSRCgCNHbS0j064bXxfV4rSxQDPo6jWyskfZr?=
 =?us-ascii?Q?WeBD4gWL/9HsKjK26+mjHP6j78ubOZ9mfX30AJ+o9l0fjYbL6/nNeYC/fzbK?=
 =?us-ascii?Q?1ZW+4OW1GmPHlePFTosqJJax33Iued39LAiklQ/oSesqO/rB73vt85AgbJfw?=
 =?us-ascii?Q?ONBTmIvUvrovNqg4Mtc8cEyu3ThB1c0D2vJTOs1cpXH/x4WKV+KBXnpNV7dG?=
 =?us-ascii?Q?NduXdV54Vszbx6+rMM4FgQHWZowop3PyeI6tngm2F0SfN7X6t6nhDijbWwqS?=
 =?us-ascii?Q?DQObokEh1h7eNqAUOXBWWrcQX9wROJJP9Rl2MY6zKOF12COGSIpH8E0qcJaN?=
 =?us-ascii?Q?cCjEX9sb/u24eC2539eVty2IuOcjpJCale90TN6HRZM5q1XtoMlV3vgBX1hb?=
 =?us-ascii?Q?2R6ar3NkpD1+G6L47RopJK48LqjwWTpUhmsZkRaAiHrUtIRewitITt77Zf9q?=
 =?us-ascii?Q?3T+vojCdMjtytpGGfGa07aHaj9XifY6QYlAUldLENe9GTI3RaZGE15RQ9yPy?=
 =?us-ascii?Q?UTkJ5eb+J71CkmFqolLS2PuyIkKznElh1oTjfiXNVy7sAVsJIf/oiy7FCXon?=
 =?us-ascii?Q?BuYOPlDlBhFPqj0mHNhB/5qPFkaIXKDv3NwAdJBPJzUTpv1ZxmWErmiWy2Yh?=
 =?us-ascii?Q?3p1a7XjCP42qm3NvTXBtQIQs4yhF7JSw?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 05:20:14.6067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe3ddb8-f076-4027-820e-08dcc7ea436b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

Hi Pranjal,

On Tue, Aug 27, 2024 at 12:30:26PM -0700, Pranjal Shrivastava wrote:

>         /* Stage-2 is always pinned at the moment */
> -       if (evt[1] & EVTQ_1_S2)
> +       if (event->stage)
>                 return -EFAULT;

Should it be named to "s2" v.s stage?

> -       mutex_lock(&smmu->streams_mutex);
> -       master = arm_smmu_find_master(smmu, sid);
> -       if (!master) {
> -               ret = -EINVAL;
> -               goto out_unlock;
> -       }
> +       if (!event->master)
> +               return -EINVAL;
> 
> -       ret = iommu_report_device_fault(master->dev, &fault_evt);
> -out_unlock:
> -       mutex_unlock(&smmu->streams_mutex);
> +       ret = iommu_report_device_fault(event->master->dev, &fault_evt);

The iommu_report_device_fault(master->dev) call lost its mutex
lock. I wonder if it could be unsafe to continue with that dev
pointer.

Nicolin 
