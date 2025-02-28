Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEB2280A5C
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772618; cv=fail; b=cXrDTJF0VmPmP3zbMUQJf7aOS9QhlMsD2Q5tt4tF9DakSnr9SmJBRrR6pIq3G1K0DIk5NnwtAgiu4RM4Wz+NbXUa00PpVnUcU6MeuAOAr78eSHFWv9gPjjsWZVp+eciav6Jplmh+3kQXUCUAqYI4gUeIDmpv5A5n8wcknwr/Xm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772618; c=relaxed/simple;
	bh=a+lGLx0Jm0LmVnigI+Y20sRfRNgfZzBcCZWB0XxEicI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPJ5nanJhJpDoiNJx9XBkDxiYGrD/dTXTBRg2nXi18um501rVOTc7vrrgYTsogphuARw8Be3RaaZcr9TX1QEo7ACn5gWX4a9WI/UufAMBwVBYS99jUco8uLo3jvLkJ0YdfyUaxpZziFtofJmBEIn3YXpnEhd2nHxFn1AaHq3ODQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uFbGcHli; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uFbGcHli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuXARFJZqLuRfxAFCdbNHTyjqyp+I6pATXzHZxltZoE3wECtRgKr5NuGGd3mG9kLy9uaLb2JEcg9cr9lHk7KF0jDfE1CjS1P6Axwgr6oMuKoyB23DqpWv7lIQTwHxtj5+RFZEUllKa5ev/LNYuorN7SIpx9HpZGf1L2qYz55ltQQbibev+1NR60s4vpV8NkOdN2Yy5budkNyr6WX/x6p8of5z8hWVhDLLkGhqTwNxCGq55e15aGjafxh2rdBHUhK0McysvQefe+4pjHA1EWXAo4p6Il31MGiB32YEmSxREHq0hh0J101x5IyC5QSOSDzs0BCawb3/R5B/h+7DbTQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcgMKFSJYaB8RHtD5CDLBmOAy/BaBmflZC6IXdnEaI4=;
 b=K5E7+kzr51BfNKW+08xZ2bD5Ff0L8hPOueN0eZsKIhp+q8gzadAITskyO3abZMvltFXUBitZisXHZH+MpHZUl5hf4ORxlrFh0irVwIA/PEDHJlhW1f36fDba58f/5oyia+2Bs2mFJXLwe/pUMZ1UENBG9dMShmZCwoGuktbs8XWiAd33Gz0dRmImKu8P+1+95spChXNdVyEAshGXUR4bECitPadMvHdTrMpyk8uTqonCKIqxPjxxhAfyBS4xaLmeDt7cg/hhD1axdZOf6RGYlDOQLXFlC4VX7tb+aX3LZeUxVBSCJYgCouUJGJ2rUh1VvzDoLIoLD8aRyiIX8ALanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcgMKFSJYaB8RHtD5CDLBmOAy/BaBmflZC6IXdnEaI4=;
 b=uFbGcHlibILSQbRSLZRBwd/rK3gw00wYi6oAqfE7Yy9MRKXiRgGf2Qm5Os45XRaHsz3jiNvzSognydAqsgJDfolqEmJg4zJSH0azyNoqlX8UnkOXW6DE7BpM+4WZq89r4eVXuzda+vyFZdO+NJlGCKjJ3bT20todV+Xo4W+KTYQT0IfQlCtKUmpAz1poTSqunQ6iTx/eIPzPnD0ext5b6Un7ymvB0EhuwUSd0zYfTiVyPbnYkfkISl1mchI3Izldw/O9qJgGEv1X1CpTyNFFrXYj9KRsoRddukdR33Ac62/MgK/Wg5kvwPyUZJo9u3V66PbJJdeRgfn9u7WjSSieWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6357.namprd12.prod.outlook.com (2603:10b6:8:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 19:56:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 19:56:53 +0000
Date: Fri, 28 Feb 2025 15:56:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 09/12] iommufd: Allow allocating PASID-compatible
 domain
Message-ID: <20250228195652.GK39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-10-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: b37a7237-0888-4b8b-9011-08dd58320c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ugJt3BcCoJzKF+jDzWEDC+wSMWO+e9tR4IYJTiwuA5d5snukMiJOP9r8hjXr?=
 =?us-ascii?Q?6wpv4GxthVdRwW4MgZ1c3UNgwT7MQP9fBwXm/VwbGS4DodEJsiw4Gb42+VKT?=
 =?us-ascii?Q?DhdiQW2Tbzmy+6/thtaCnrDPnChXrENNamALHTmp9RCmQ5vWCqCMVlK5Pn+r?=
 =?us-ascii?Q?6ssznK8KZ/pHx17aSqUEUXn2yea3F6ACSo49OKGKQN5Prhu42Y6P9XMSbia+?=
 =?us-ascii?Q?vf/8sFz01l84qdvSZVmwbxBMtTP1sNl7ZCewneR6pcbd1j2sJ7FSMYQ/H/jL?=
 =?us-ascii?Q?+FO7M41GM4iBsw8O/kANfoJI8lpQfD9U7YokbcgbrGqb+sV2Oi/ANcJ+v65B?=
 =?us-ascii?Q?wRctloV8Az1WBKYRAFCWWhiLaVHXrKJW0bJItcGjiRaNY/KtMEfAFUlvSvcf?=
 =?us-ascii?Q?UFR1B3YxhJUG5viAXSBiIecIWlmti5Q2ckHmNDYqxp9q2GU4qySpKaLSAzop?=
 =?us-ascii?Q?0IUECwLm/HpvYxOh5Saqcm21ndW0ZXBt3HJOFnI+gVHL4d9o924OhwVHVdvv?=
 =?us-ascii?Q?+KS10VXRDISXq6AkE5UXNp1vcTQR/qeelMhoYl+V5lv/IJjaQSZ8NffI0VDp?=
 =?us-ascii?Q?t7Yas10llnbI/a5tKLCgFzIqrn4iCEbgo5deN68O4c+i+rNWXhGKktZQUvaQ?=
 =?us-ascii?Q?Y5SUd77m2Sqv+tW7Bh8g1SYZoDLuLkx1ONYw8fD0M39fkjMkZcaliyF4W//H?=
 =?us-ascii?Q?6HW4+CjCL3TstmIxvjbrSqiOiRZtYzb6jS8bfFxhttqr9MgtrKn7XTCXZegy?=
 =?us-ascii?Q?iddl+eTEQaxz327oW9Ffe2Ai8CHMs6eJjtpM5IAlK0XzAlKJLs+xU+Robjf0?=
 =?us-ascii?Q?aZd/DG1MUoQ7XuKl/QBFmsFJL1KNMT0p4GDyUYalKqVUIDCNMowmWvA/+TH4?=
 =?us-ascii?Q?b4suqFnllY+55KCEtXeKk9haSN61IK11YNRNcYkU4bZL5/OkNmFxYqmefibT?=
 =?us-ascii?Q?7BIoCSJrdlYNa6DpUHQ1CtMK/nNCXivVGy4Mi/8qzd3D8NrrZOUpuQf8d5Rz?=
 =?us-ascii?Q?JYizEcQAq+6nCc7BQ7IEWjSfMyOjHhJEvHdXM20QrJ0SyoSMQqx8PrzcuOS8?=
 =?us-ascii?Q?n/oNE8rKIwi0pkkgUGdBHSEjWmHh1Tbpu4BsU9Tphd6PKsmoVKHYSrk7YTD5?=
 =?us-ascii?Q?oujEm4jAXzOqjgKHVRV+N9CIaGaGm94OB3J3V0lXQlbRYFssoFi5BiKGO3pR?=
 =?us-ascii?Q?ytFFhVvgCmLqWWOCsF29zXwyMEbfyl7GnlECz6UlcvjSI39urIWy0UsjF1Ap?=
 =?us-ascii?Q?QpYmAWpYJ8PXH/2d70u3HFVkcw31xYugV4fHpwYJJmMywlBeGmpmeY4vAo3w?=
 =?us-ascii?Q?zkpdeFts8EhjIk9iqQIt5lNTzvEDQqBHE0TWYSP3TWdS90BbVMLpwky1KSpH?=
 =?us-ascii?Q?sCd+b2KyeEaFFuoOP7sNA2vskUS7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7a6BtbiiDcGtYFYrRq6FTeekuHEh0TYala7jOBm+BaQKc/MbJNSYTqgIJpYT?=
 =?us-ascii?Q?5UtRNSUcHtOyQDKT436ht5Su6RjmeZPjL9xMX2FEfiPTkFSXUCdpSNL7SMGA?=
 =?us-ascii?Q?QG8AekGh1Fn5Ls6e707jwTiMqTGeVVshfL2ZC3LlWCWvQKWEMGLMPz0Jh/Lo?=
 =?us-ascii?Q?X1xhFj79W0h0r29Bad7rsdt0mwRT1iJFOepcyIjSk21ARnfaPk1MBUNdV6vI?=
 =?us-ascii?Q?QzHh5EJQ6jHvQ8nu3p+fKCNt3ERSPA22r64Wxpl4nEqVEcxP6e+kvTMRTU0y?=
 =?us-ascii?Q?8gbCmlPbKqZ/EnaRGfR7wboRiAXV328HJRuE3eanTaj/oru2EiP8pWrfgTUa?=
 =?us-ascii?Q?NCHrsihjO5deX5ocnLULbJ+qG/kk9gr8sya5JoF60ajZ3D3lPoQz3wm8rZOy?=
 =?us-ascii?Q?un+SB4zK8VkcIly0OHlzdhlwOv0Mu+Xoe9jFSglPZLN8KZuWr6l+duhKArzc?=
 =?us-ascii?Q?YJ4uSl4YKmnQCf4nAbfg9HGbQGnQu4JzF61tyO1TCHOWA8iYjus20xzqTi/0?=
 =?us-ascii?Q?ORpLvGtR8Vfm7o4F57LBlSrWdxXLIa+9kweduCbo5k50kJVjq55XJ4J8VMoW?=
 =?us-ascii?Q?dpXTeNIsC1jAXxZR4pAAgw7tNf6pENyeWkTyBoLuhXDOY8kjg2BveMehZ4md?=
 =?us-ascii?Q?xWecMsjDFmskRI6dNNU10dt5YOlnpNgHQ8YgSAH49WGiCkO+Nnhz0eZgUNUR?=
 =?us-ascii?Q?6t+sR7Zt6bMs1LYOTfAmfm2BMPwEwl5Cktt24xN5shHcLXTqpCKEW5Oda0rM?=
 =?us-ascii?Q?O+rtR+gw27EovxwZc0G5a2AaWdP0GzcCcJpWb+hMezBdnJeAiX1eShBmIZXw?=
 =?us-ascii?Q?qsd6UZdeQD9SJphe52tUN5osTRArhMaZekAEfQroTzXK2h4H58ybaAxjnlbi?=
 =?us-ascii?Q?bK7yF2YMgdmy4nZLhSpDThWnVF2Ck3WEEctJFKZoRUZ28at+qFZlt0iHUTZr?=
 =?us-ascii?Q?0Ug8L0hBX2o1L7GAK+CPx1/m1ZHrJJhLU2YFoCHnxHIrc2BX0Udf7dMefolJ?=
 =?us-ascii?Q?zEf6lOw6/zAhHU8e/wU6VncdJu+PFy7pMcNGBgCwXiGXv8dzel9jY75v+50i?=
 =?us-ascii?Q?mJmG9Iie+qvbqTl3ZMSJht+se4fj71t+uDtY/vcwzvcfxF/CsAwtUuATdYaF?=
 =?us-ascii?Q?cohFAwzKIB5Dzflc5CLfqxGrQqkPWdpXIwGYEJPFqnED0KgGADya8XsJV59t?=
 =?us-ascii?Q?YZJGQmFKYa4d5ArwwGtAriNqukimrH2+GQYMSCzCAMyI0bwRnBDKfSAl543k?=
 =?us-ascii?Q?za8NvD8aVWDlAL7aGL/HwBk5/DKlMYBXRBU+EI/HCXXccxkSLWjNAOwBzjoU?=
 =?us-ascii?Q?bvjFqbw8cWRPdm1TIFT0HUORUrP1S1UOhFTko69TVmXbBRVeV7Gc08v7Itiw?=
 =?us-ascii?Q?qmjv04Hcli5coKWXY9dB2FnU7VZyPDF5fYGkNS1oFQ7mPScxr7PsslNt/zPR?=
 =?us-ascii?Q?tG6/aVLEcsNVkoTz3MQPsO3V2nQJoVH199pw7FGkNU2RIhzxq1uKRa9i+1FY?=
 =?us-ascii?Q?mHXI4Ny0zRef7xB6dDERagbvU7rTl1vpF/BK6A7dtIzoT6ZRry8VZBrs9alU?=
 =?us-ascii?Q?qlOJpzZvY/Be8Vks5TQWRine1ClDuQjs+Jz5Q/1q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37a7237-0888-4b8b-9011-08dd58320c69
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 19:56:53.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7weC/SNtUgkpKDBGlpTh175wZ/lDYSMeY/LvLDjTKQ2HgJ41XoaVAiXJ3HQOqqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6357

On Wed, Feb 26, 2025 at 03:40:29AM -0800, Yi Liu wrote:
> The underlying infrastructure has supported the PASID attach and related
> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
> extends iommufd to support PASID compatible domain requested by userspace
> or the PASID compatible domain allocated in the auto_domain path.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c       | 4 +++-
>  drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
