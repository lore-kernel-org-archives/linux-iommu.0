Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82918198E6D
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327069; cv=fail; b=utKMbPNWl7cB7R16uF3NSWcoZyT3M/bodNKROuaCFiYzwbQC4IyUjCUzffx3Q9bgVZobC12ix8eZz9z8iOQTCNYEQdSHKkNw6mfzkoQqp4obW5WflxYcI4xP8m9Bg0ZGaIgpFQpEm7MBGiWeuMRLsSwW1aaH3/XZXpt/5XgY91U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327069; c=relaxed/simple;
	bh=EFqvLYCd6JBj0zKwrSIvEb+03ByqIDMJqxYfN+N3h0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnYaerv9Gdy0f974Hli7vf5dg3Jqj69NQ+KW66pTpKUS2PYQrwfKslcNUP1ZXF6lYAF3vIFvxGjarn3U7JMfO6wQgRuz6Fgz2WGBpVD8j0aNslK6VxCc2Wf7kBJAXV5zf6TBbA3kjKG8IV0TMVb8mwOile4giyWEYJoLqCTsDtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XdZWCLP6; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XdZWCLP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDLFEzv+qRhxpvilkcLYs6xiagOKg6wSgnRf+IuEE9lsd1V9MqR+gvnSd+0fG5fp6jmxc9f6GRzP37PDTzZf7gib0fv5Q0a418UYcFqD6Dj5vNu3gx80vedRCauV9OudrdSnhFHB9pOwc8WBtH/tWtBNhgByhrxcIkjwprFYHXnCY8aWgK4LYWp9TJcVpoUB9CdYicNMzGMBnLh3z4IdNwv3iCha8PR2chu/cL0e3uy9BqEXllX4HEomvTmMeAQw9RYrz/bV+rz3aOn95cTyDD4BpWP6iqzNOROV0sF2EMsM/nOrT/gy3DXpd82EwWHvwAxELNwdIll+0k5uthBkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mrK3MSpLCgYD/wWMjcFPGsBZfNBCUE3TWLYnKV9yQc=;
 b=i36RdkEBZy22wZa2oIBsd50SORVyOstpNsOJpYzvWbTNYOfUxXWG6ZAxMrYUmnmckAUMwvrXpysuuMVygsOgJIcP4kCupzI6fxcz7DAWDAyb7M1rUSfa3X2jPKrC9RhZmQjEQMGdq4483pcSKvqLnI14TiMoa+1yqRie22QP62LgBjsxDGMClwVSqbfgkj4kCZrANercchMlcq9KOcZ1RyvJvLhCy+R+MSdwUtEG2wA+qcpjhcNCErfViES+qYfktzfAz4acTIcmhcDOGEzgj49AVVi8qtEhuDXer/zXsx5PtDfIsRVQVa4xkeHH/TMu3wl61Eh+jqZLz8oso285yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mrK3MSpLCgYD/wWMjcFPGsBZfNBCUE3TWLYnKV9yQc=;
 b=XdZWCLP6gSrgREW6XsZSjhiDii1lNnOwyaMv2R9NLUNgVgdnyhKUepmWTlAl4c80el40CBepQn0ZsyaRO8EKrd70PlBx0CxQpeGazAOEQLzA6i7qyYifWHvoC3aUPJo5JgDQaBolhj+J+yNuAc6S36TPgpwg6fx/gV6hdjdZSAAdA5SoQeI5tLSWiUEjsJUruRElZhoUFe8SFSp3LSaOUOtTZwncB3C8+B/MVrsmr024ticNuqK03RiVt238rgfCX6NnT92DQkDqDO7ZP8GEai43zwIuGI9UnzCD/NYSiziwZ95JNg3xgs42c6zsvjKXJLMaXxHPdwwkyhCvRawmSQ==
Received: from CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22)
 by MW4PR12MB7286.namprd12.prod.outlook.com (2603:10b6:303:22f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Fri, 7 Mar
 2025 05:57:43 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::87) by CH2PR20CA0012.outlook.office365.com
 (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 05:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8549.1 via Frontend Transport; Fri, 7 Mar 2025 05:57:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Mar 2025
 21:57:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 21:57:32 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Mar 2025 21:57:32 -0800
Date: Thu, 6 Mar 2025 21:57:30 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] iommu: Sort out domain user data
Message-ID: <Z8qKyvNyNU6dkN7V@Asurada-Nvidia>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
 <fabd6483-af48-4893-b539-2835640c5316@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fabd6483-af48-4893-b539-2835640c5316@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|MW4PR12MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e83ab0-5af7-4aed-2f24-08dd5d3cf9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TM/YmmW2ha8yEmHwSfX46H7m5Mpt84KZJvM9qv4gLZgLdC1Zn8iQ5grQjAf8?=
 =?us-ascii?Q?MkhCf5/A7G1ApXdvyT+3+qS/fAkzdX8y7Qrlnib3M0c4Cu3bhAiVUxmuo8i4?=
 =?us-ascii?Q?PbmYcJSPQcQdYoC2ynC5feZja7OJxzbGs5ljORNpPM71iL49OHjr2gYcekHq?=
 =?us-ascii?Q?ZybjbfIuEoj8JqhWhagSm5UXzAMaJcHGY+j43DKY1UjkPikWTOOth6pl3iWJ?=
 =?us-ascii?Q?AYEmQIl8E/0MmVpmWJo6K0JVfnj7le10q1xhcfuyX4mqKFcUVBjJm/dQyOOS?=
 =?us-ascii?Q?6fROh4plwWfziR9rkwqRxHg5ZA5dB1zyGI8EyfqshRmcqUw9ofvJS0XDdpyS?=
 =?us-ascii?Q?myB9JudnNd7KK8YPF81Y61JbLkJJWwLvzFxcdqU5tAdZH9BjslD/1AcNg0JR?=
 =?us-ascii?Q?dSx0fK+C3R1FhA4ZLKWesSPYKAfQ4x5e/Doh9Hq6MtNCfRELJ2K61aAZB8kf?=
 =?us-ascii?Q?39GIuK/SwbXwPhl14IgkNnCom4KoR5wTuLq8nsb+b02uLVN8pNqjs+XR4gr5?=
 =?us-ascii?Q?5H+yq6VU7QBSEKRLnHAmAjL8WJTS934o5qsLIKSrmNMyYHGtU4l4EeQhboss?=
 =?us-ascii?Q?H6NyLWfGbmDXmbVpRSwb7ZguGRXuqyqRwz1mb3jHvtYry+0+H7pXU3LBb8TC?=
 =?us-ascii?Q?fhQRL7dFtt/pMjWitSEnUV2bYg1c32IQb4HfHO53auv9CLDhcy6IOwIaCs/n?=
 =?us-ascii?Q?uQUf4jPyzoZYgEOEXeGH+5WInIrhX7JTY+0GrVblt2Z1iWMjLuzq+7YJTD5P?=
 =?us-ascii?Q?OsYb17OfzsuLMHE9vaURvdct6XzbAHp9ma490iI448ebxBG9hdryf6iX0iwr?=
 =?us-ascii?Q?JP+KvrP2965+ylnrIIsS0CTH1JNAlrKsFdB+2jYWheLgASjy+l4Z0TPkUuUb?=
 =?us-ascii?Q?BiaYSEnECSkO1Wd53PAunKTvhYZqPG7B23RlizB7QTHTv93frQO3oThFB7Fi?=
 =?us-ascii?Q?z0GPj5Hx/lYwbSZlsgRE3bSY0cvYRIZnEWiN1LByG1yyw9aw3tok3bok2Ki/?=
 =?us-ascii?Q?7Ep9PoeJXTSUgw2bPWAd5mxhgZC8poOckfbbkNGuK212fQ0SPhCUf9f9jVpY?=
 =?us-ascii?Q?2PFy1FxUvvKVLYez+5vqtKDL9PAozSb/r5vgWlvmqUYKALMYUHcyIc7Vdffl?=
 =?us-ascii?Q?t5UK2L5TfDKjvSOCVrUrvIqCX3zT7+64ScjesIg+5keNJDBOc7SSsphAt2+k?=
 =?us-ascii?Q?PWCCBbeR2smomu1vhorOV/omz4xxWWKHLrEnSNtNsdY8ysCSbPQUVsC89wA+?=
 =?us-ascii?Q?QEEVIjAXFAoSj9pBVnCMd/ljPiBkjmBxRbZMYrn/0uLX6CLnJWuXHOEcFV00?=
 =?us-ascii?Q?HlAPGebkQ7n5ucGBCB8z0uBkV8AS5UnVEN0c982LP81WLcgaZYe8fGKPTdYn?=
 =?us-ascii?Q?MI6/vpN8Ue7zm/tHa6c8Cpe0FAoY5KswGlgWXuhd0NnE4i45Z7dIf6qIjVyI?=
 =?us-ascii?Q?fe92TZHDzgu3PjiUUesnJC4eyh2DbeJ7eAScplkWvbM7uU9DMWiLF6uMUb/d?=
 =?us-ascii?Q?pPQdI7RJzP793fM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 05:57:42.7342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e83ab0-5af7-4aed-2f24-08dd5d3cf9ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7286

Hi Baolu,

On Fri, Mar 07, 2025 at 10:28:20AM +0800, Baolu Lu wrote:
> On 3/7/25 05:00, Nicolin Chen wrote:
> > From: Robin Murphy<robin.murphy@arm.com>

Robin had remarks here, wrt iommu_set_fault_handler():

> > The fact is that all these cookie types are
> > mutually exclusive, in the sense that combining them makes zero sense
> > and/or would be catastrophic (iommu_set_fault_handler() on an SVA
> > domain, anyone?) - the only combination which*might* be reasonable is
> > perhaps a fault handler and an MSI cookie, but nobody's doing that at
> > the moment, so let's rule it out as well for the sake of being clear and
> > robust.
[...]
> > @@ -224,10 +234,10 @@ struct iommu_domain {
> >   		      phys_addr_t msi_addr);
> >   #endif
> > -	union { /* Pointer usable by owner of the domain */
> > -		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
> > -	};
> > -	union { /* Fault handler */
> > +	union { /* cookie */
> > +		struct iommu_dma_cookie *iova_cookie;
> > +		struct iommu_dma_msi_cookie *msi_cookie;
> > +		struct iommufd_hw_pagetable *iommufd_hwpt;
> >   		struct {
> >   			iommu_fault_handler_t handler;
> >   			void *handler_token;
> 
> My feeling is that IOMMU_COOKIE_FAULT_HANDLER isn't exclusive to
> IOMMU_COOKIE_DMA_IOVA; both might be used for kernel DMA with a paging
> domain.
> 
> I am afraid that iommu_set_fault_handler() doesn't work anymore as the
> domain's cookie type has already been set to IOMMU_COOKIE_DMA_IOVA.

All three existing iommu_set_fault_handler() callers in the tree
are UNMANAGED domain users:
   5    451  drivers/gpu/drm/msm/msm_iommu.c <<msm_iommu_gpu_new>>
             iommu_set_fault_handler(iommu->domain, msm_fault_handler, iommu);
   6    453  drivers/infiniband/hw/usnic/usnic_uiom.c <<usnic_uiom_alloc_pd>>
             iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL);
   8    118  drivers/remoteproc/remoteproc_core.c <<rproc_enable_iommu>>
             iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);

On the other hand, IOMMU_COOKIE_DMA_IOVA is a private cookie for
dma-iommu only.

So, I think we are probably fine?

Thanks
Nicolin
