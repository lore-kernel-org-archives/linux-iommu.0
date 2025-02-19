Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D259E1DE4C6
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983746; cv=fail; b=TMCZ8sGz4vLOjozqI0u/l2P7rAA56J8ZDIPcts1HutgDEvqtEmZhaHCiYbr8LFlLz8GPde5WFvYWExpm48ThHN0Eg/puW8tHpJbwzELgEBrsnu4rsBKzCD3g6JsrjddtKBMyV3HjYQrnXNTHPrPkrM25T9RaCoV83NIdXpjcH/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983746; c=relaxed/simple;
	bh=zDEFVYoj+xLfu0S1dMc5eq1YJs7bUwA7+Ezp/WNRbSY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSebZ9k8NDkvph9/zR72dQrF7OOCnENP+CQ42G0m6KsWckkmVR06Z/jm/bunJVHO46svAbNBFlS2WZ+My6wl+ss6lM9Qt7Kcg5IU+kXYcPZtQi3gIwDQ7b3wsUCtHt7SyHe+SqtCus1YG37d2T/AtvveIO9WtbJzG70lNA0eY0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gBi9y43i; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gBi9y43i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKYjCJscoIoTs8sQh/DP7/WcD7tIi83qoxMCFD6Z4/IZDADtX13o3mJVMsAh82qNyJoLlGotAxu8wXC/yMPA0KTilsfUQjdSg450v5rgTqgyM9L4GUxnmervirAmbnU+JpKkAmaul+rHYLUzM3c78WAzZD2ydktL4olImt3ZlHbBQP0tsg5DbI38zNw0Xpsts/G4PKOPvKn1DM2DVt5QkAx0zXvKa+TqZ5K7B59PZsapcF0nXQXJrVzMqWIdwivatPtB0ApZkcPi38PTcIi1eIY/lrqODwTedDy9rGYQVtg2SQjKOqzYA+XG9004GmNKnmrGCJ8l9AEDaKRpjUo9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdRMvOyy+RFKkD/OaGRnDHVeip4lN+jnV7hMjilcXvE=;
 b=PE3UZAhCMkvUNo2LvifCMLLfZTbIliVAmPkPjMPgYIxlPpBiTkJN+v0akOHQ5Sm4nCzLhmzVpEo2lKgMUHIoWg0QUGIuwhSXQu+GPqU7n03t5oRky/YaXPSFnbdyGpZT8JWDun2BTzpRFNdaaFNzE4kObEIuvLxwa1Neg94KbqTPoW5HjwYIRiHGz73FKe6Jm8s4wKMj8+8nht3RL9Sn5VYJxxmoZd0U0PoHrfLtf3YDRH8js/1dNon/QNoheUQyA5jNCDmk2A2pi8cIPg7XgNo+Zl3+PHBdNgK9MAFwUjX6VTSMdAJP72Lt1xRpmRYjhi2XKYT/ocPH+T8OI+R5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdRMvOyy+RFKkD/OaGRnDHVeip4lN+jnV7hMjilcXvE=;
 b=gBi9y43icv/SoRKdFpXrwIa1+1LFQDiP2OZz2cztAiBs2cZ2w1mto4qWvRZSvjU1zBTzLqkSAxuuVV18xyLG8rI6jWhNZ+ENDnchzItnuagZfg/W1yKf42aR7skwDZ75WT9+b9gS2b3rw/vtQgUM2T6262jXYBdtqsxwUJo88Yz02qiVDVe/PjAW09YTwJ7oeRi8udNvsU54wIQIInGcwHoRMcAZK0lKaqYLYwIMxDUKuK+qtVTV9BdGCUFRwzN365XMgkig/rSL3GEdZbYGqdGbBB9qzK2Cnfxt8Fol/RdV1Blifzwan6+P6D3WZ5h/eAC+p+LiKUwJkGACRFe9yA==
Received: from PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::20)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 16:49:00 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::81) by PH7P222CA0017.outlook.office365.com
 (2603:10b6:510:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 16:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 16:48:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 08:48:48 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 08:48:48 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 08:48:47 -0800
Date: Wed, 19 Feb 2025 08:48:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
Subject: Re: [PATCH 1/5] iommu: Make @handle mandatory in
 iommu_{attach|replace}_group_handle()
Message-ID: <Z7YLbix1s55dIEWx@Asurada-Nvidia>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-2-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-2-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 5582bcd7-25fb-4679-d9b1-08dd51054ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgKrRnt+g8zXdW0+MoWJJHqqXN5n1h6Sh+VmxAv4EeU0j3vfzmU3Ggt6EI2I?=
 =?us-ascii?Q?x++Fowdy4i2kIX6NJBegHMbrmSo0xXctGxmnIc2sGcyWwPz3lcQ7oJ1ntxLy?=
 =?us-ascii?Q?UjC6hBoFHEibOeR4mTpMM4PV2yqvq2otw+ST6Jsk+kn0l98vgnFUOOJhkt3I?=
 =?us-ascii?Q?VkQF4xH8QBsOm6VKY9Wy5FYc4TKzZWklBq/Z9mejfyzVF1+eu/sm3sSHQIFU?=
 =?us-ascii?Q?VkaCMffDc+E7hfWU+7dDFO/uDH0ltcrUBogUYmEaIHZ3TmFPm775ISS/25yL?=
 =?us-ascii?Q?M2USbK20Bryg7b9exfPPNd09mMxH/XHkfgmIOOVVs/x64wMiX0io29kuLbHU?=
 =?us-ascii?Q?LmH1drrmoVt4MJKkTjfFrRDu1r/VXzp5uHiDx0PB3a9L/Itri4i6uY6xUXmu?=
 =?us-ascii?Q?BmSjtdxcE+TROTDsDq1GeEtueDaSPj11+vYM27DMJelt0qmCOywAXQ3fqiQ4?=
 =?us-ascii?Q?zVoexcT/jVocJ8o+mYL1Sekbz/OpwngHUXn5eafrhXuKxy6ws0q5/pPkl8qp?=
 =?us-ascii?Q?htmxXgR64sRqa6vyPNVFREioo78p6cqYmjB6r7DKgcX7SqX/iBUPP01vf4Or?=
 =?us-ascii?Q?PX4dfIqlUWuGdixR8oy19sR93YI2WwtJYS2ep6Ztgo5KdvSeANRp416uYpY3?=
 =?us-ascii?Q?3YRroZxsUz63po5hJLuUAug6OiZXww7Re6xZcKimNcgwO+xtAG3Ep4Xfs1B0?=
 =?us-ascii?Q?1L/pp2p3svDyIYtGT8BQvl93y9BbnZECDS9i0uZVMii1JTIJLtHzdG1WzWpt?=
 =?us-ascii?Q?qv84j8h7txNpGgmWCfUM0wZdo+LloOk7koKD+dFwP/IUG71NWikUvToPoSsl?=
 =?us-ascii?Q?fVyEjGzzSuqT1wL8Y2B4fTEDSSOura/PqLnXdShzOL+dohxvZcp5PA8E0UPG?=
 =?us-ascii?Q?bTN90gKMavalehV3H6X4gEG2vh/kP/3eK8K4AFVXl9Hf6w5NPOQNulIydzto?=
 =?us-ascii?Q?ayxxIhUYoogi3BbjEuS17SXKji6UYGPL/EWLXEjUsr+0l2EKJypQLh+R8/Ak?=
 =?us-ascii?Q?0K1vbofami0TMmBoMPw552GusPl+OQsi0F4rozcAbe5FGFjXowTCe9gCVVET?=
 =?us-ascii?Q?7kyQgLnoGShBpA0v9LKoPvEk1KHdNqjfuwnI10LNHGpUgbsT3djgNR6XOHOM?=
 =?us-ascii?Q?Y5/OG+6nbqp/xVbXzcpUurWoKG4/eyDQ/5TM3ZcgfL7VrhMAjSam77GIOweT?=
 =?us-ascii?Q?QtUwJ/lAruVTjxpHb9F40N/YjGcFNh0agHwqYMHfZsa48HJmisfkQGuXjHbm?=
 =?us-ascii?Q?NclAVGJHv2IE0wRKQwJ5NiReqfkGSHPN7GBrUT84Ce9rUEijzU78xfnzxCqh?=
 =?us-ascii?Q?RIj1jv8BcRLCfSRYb897KVIbxbRJSK/m+9ERN2z7RC5N/nf5cYioS+sAyvLF?=
 =?us-ascii?Q?4YwiCxncFYQN29Hndan/HisSqUmAlJ/BELlnjtfxQ0LSQz7d03SNst2xu7gH?=
 =?us-ascii?Q?BFOw3tMBeDEYodKV1f0/KUgZf5CayuxJKriSowK7IaEqT6aIW3GCghRxIGTy?=
 =?us-ascii?Q?T07kHShFZQVHh2U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:48:59.5717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5582bcd7-25fb-4679-d9b1-08dd51054ee2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196

On Tue, Feb 11, 2025 at 10:05:36PM -0800, Yi Liu wrote:
> Caller of the two APIs always provide a valid handle, make @handle as
> mandatory parameter.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

A side note here:

> @@ -3511,8 +3511,10 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>  {
>  	int ret;
>  
> -	if (handle)
> -		handle->domain = domain;
> +	if (!handle)
> +		return -EINVAL;
> +
> +	handle->domain = domain;
>  
>  	mutex_lock(&group->mutex);
>  	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> @@ -3568,16 +3570,15 @@ int iommu_replace_group_handle(struct iommu_group *group,
>  	void *curr;
>  	int ret;
>  
> -	if (!new_domain)
> +	if (!new_domain || !handle)
>  		return -EINVAL;
>  
> +	handle->domain = new_domain;
> +
>  	mutex_lock(&group->mutex);

So, we don't have the mutex fencing the handle->domain, since an
attach handle is always a newly allocated one in the caller, and
there won't be any potential race occurring to it.

Yet, this feels like an implication, which we should have stated
explicitly in the kdocs of these two functions?

Thanks
Nicolin
