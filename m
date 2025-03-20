Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBD14B08A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484240; cv=fail; b=O7osDt9GQ8+rq5cWk+ctKMQHN03bNd5JUVbCOo8DPyyr5tK2Fx/ebnF584P4IIQHClaJUSJ4oIsQBb7Jr4AHDVSeqShCluchmDUpVTLOQzVSEM/5Lxr/ihEBwA8zBuQLAhoRNZMPxKzxQ8GwFtlwOQGfU+esAlFy1RMNJZh5i2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484240; c=relaxed/simple;
	bh=dPzBP2QWP/up+LEckcz/6fkt9dOgpy8dt/f4B6XYUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BhnPDuek/qT7FfnlLg3DUK+QJWjYSXhpAHYnT9vnx0KoORIxuG4EHNNer16nwaRPDWyqxoKwVLmebmqhSdk0A6RUDBc74egvjEj9f6wnFQHDN9cVuFNUt+rvnSM+WOVo9FPf7ZPDOuzqdlpfLmjGN0/x2PDuvTsmW3CXPTtGL5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eSMyNJfS; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eSMyNJfS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dayW9Dl9aKSJ68ygkUoDFs9XqeioagPjv9AAcW93hEpjRyzzqZ1I0rmlX8xa+NuUgWYHwzZDmNFzfqc/hxuKz0YM5JHW4sr4uuWNfnz4D6NatmhsviNTZzqda6w/AYu9pRIhcIFJlVOSW0HxixHBitmObkujn3KPR9bNP69KKupvzQ8t/OLHWqTqZssdqU8Eutwc6lCMN6ZWSiDK4hU3MmN4LP+MFgpPM5QJ2aH+DIdpqJaPIhCFjMWZYPSGOLe2r7NlU/ogbMxKV4fOX5HCTjSoPHLmdjf4OV+JLkz5pzWWTLs4rxqN06zQ9LBQVz1XabW6oUfuUggpZjeYdjxt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foaCyQ9p9qvaLHVC+kwmQBnQMO9aeZ0qJI/mx+SP9hY=;
 b=WwjI+T0Vyvo2M9bF7Jlw1QrfcvForEd/PdjaZwGp8qYQZWH48vd9hQ3ZmgZXRKR3qPaabLDH+41KcdkTApH7ve+6J42o3rz43O6AQPm4IogqyCNM9KzxppAsT1NhyXSwGqfpDZLs73Mzn54qgF8L5f8YsDB1utzM7gv44YZwnu4roGMzjdBDGD16Vtfp0OkkW1lKZO7JLdMdUb3IDWjuaoQTArH7q1gl0GQCuRMyYCOnrYqt4YT5xV8/CNMrlScTeVHuf8dgxCbJI4HsgsLCgExMxeWWHEoJCppAlgRBMvQFsxRIrx9kX+22QcW7UDgaJSJhlwvKGKy/cXZhKZIPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foaCyQ9p9qvaLHVC+kwmQBnQMO9aeZ0qJI/mx+SP9hY=;
 b=eSMyNJfSEJ9lgW7U2mPU3XkIan0MuK45PJr8Hdxymzq5UhylBDxm956bhK4okbijyxvOtBXSWfITno7ZvgFcyefz39M7ZDQn9DzKAYf6NwPad8PUaZbe4VQmhTDPO88nqy2XSsJvozRZa1lWs7wzaZaQ8TJmq0t1xb8lGph7NEwTforH4b1prQ0vdrFStSZItE2YN4RfrcjKZJ0m5LQxQusqXdTnRzbSUm3GGrHDdAp13hBuOvy3NxwXZrE5OLGeRQY3FKJ0kqCJzAt0Xke8TJ914VQTfk9RoDscvP3MXHTEsdmHdjEuvxHHKJE7XzZwKO243gDlz/dCdGW5oDUxog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8941.namprd12.prod.outlook.com (2603:10b6:a03:542::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:23:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:23:54 +0000
Date: Thu, 20 Mar 2025 12:23:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v10 01/18] iommu: Require passing new handles to APIs
 supporting handle
Message-ID: <20250320152353.GY9311@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:208:134::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a897349-8b9e-44f7-8919-08dd67c339a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gwe/PZQdahELpm0EIwIytjzsC5dIYQOb1ll00a7JLSWiakecx8sFmE1iKeyy?=
 =?us-ascii?Q?IJAT+6nZosBl2NbDYIlO1NVpCrHfbxoWLYfwTW/Pun97qhWuWSPUxcyWKvs4?=
 =?us-ascii?Q?p9z1uqjzGVCTg8p6zeTjWTmADjg0NMEgi3V3rzzIAklYLhTAKGj4XzxH2jme?=
 =?us-ascii?Q?eYeN26rqQHEsn2Q4zvqPGC5MaVRGy30mhA3xyas9wMYfXJHePIm81omtVsSp?=
 =?us-ascii?Q?I45QbjrGeta/dxypvYbttWDavUYGaSYWnwuSmsH0wMFoGLwz4lo/7w6y5Lly?=
 =?us-ascii?Q?4vA687/zD39cPG9ryObH/YZ8kjjqAG+BsLysZEadx0SpkYXBAlxX2eMIqh/2?=
 =?us-ascii?Q?HvYXuRbCmNAVUyA2ov1vqV5eI40CMZYgfx21N0az26tWhQsJE/NjHJE+RNu9?=
 =?us-ascii?Q?1mMdP0uRHiufGdyHEHNe6TQOaR6gdcaiXTHWlcaCgHPKZJbaeX3HO0MCaJSa?=
 =?us-ascii?Q?Cab2yRWlQJileugIi5/HneRx9TZmd1l11bREQVozM4w5sKbFyLo+Ry2hfLqw?=
 =?us-ascii?Q?3V1tTVU38cOg8jIQ1FUqha1XjnJvNUoDq5VQz7wY0mXGTf78zp9XXAxqB2TA?=
 =?us-ascii?Q?IZAmKMvroOvmmdw7N1xWJHf7fsBYZ5UdnjZQTOau1JVlkx7YEtuh9ZGtkjGi?=
 =?us-ascii?Q?T03/nUrFTXdB5YhlHbpf5hMpkST0VzyXc6Gm1CjZhKEV+B7wtoiFwNJu7h4B?=
 =?us-ascii?Q?+cI8xllnE3DBfri18UO6lAwcrOiwtEaxYNysR5SUsP6DDWgzLQdYsh3BXJlM?=
 =?us-ascii?Q?UMS9lnOdfKppeFSmI+g7pVynwzb6j2MVG6yOa+StgFaUzqW1/yFiT4wPp7PA?=
 =?us-ascii?Q?eBcNDWx12p4GnzjCeBI8rhuW87+WqeRxKG/P8fg7NEofm4mMjSuvw4lCTMDq?=
 =?us-ascii?Q?V4+S6TTq4GV31Cii6ZZ5Ph4hog0EzKEMSEKk8RgvG3D+ASNPKj1mPmnt/X2h?=
 =?us-ascii?Q?rp0pgqfGqeDDfUZ7YAH4A3gsoGkr9fZe17VBtc/MFeXMSQYHZLLgByYRuSas?=
 =?us-ascii?Q?oNi5XoYtARaInmfJsmS1/fnHvtpgGMylV2Dl87QqyVPfTpHKOs7ohwT+q+l5?=
 =?us-ascii?Q?YGUsSKnRrUbRnFbrn3vs4182E2Fo8Slqa8r507zYDXjFjJxbNpXceanVQhl4?=
 =?us-ascii?Q?izKmhwl/Jy4+DOjolNqqKHEIP7nj3uzBnH/4tCeA9VTWk9hBO6D0LWmcCv/g?=
 =?us-ascii?Q?PPjMNa6gsHi+04luGaYeLQwrYv3FccKT+1cZwNF6OAdypEOeLXlbXfeeQar5?=
 =?us-ascii?Q?/cF95DMejLt3VIjFqZuRwwv7DiIFGsU1KSxY8t0XGivPBv/Oz/u5Ga66xB7v?=
 =?us-ascii?Q?xPSaFQhY/3WJTLaOHbnOFCqaH0ACqI/lV2hGXMqr3XCUOJ1EHpsThgX1qvOv?=
 =?us-ascii?Q?95uEl6rL8w0rAwL5THtjHWHr3eg4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFd8BJNFzYL9Z+Lg2pL1Bl0m0Fdv3+3OsA/V8jknBxgws3BSAvL8Y75Y+2nF?=
 =?us-ascii?Q?dq72j7KD8thRBiKA+atvdUKfCLvpFZQ3Vl3vxr/Fkmo7lIG6xfQe0WXoY23v?=
 =?us-ascii?Q?rioqvUiaIugkTP2yFFetBIfzi9udLGFwAJBTyfE8JzexwbT+S4PLwnepXhPs?=
 =?us-ascii?Q?fBcNWRuI5PMnHbnp4KKwZ7o0WolCr1CJmWQagbiHwPpL1sgWXrFKz9pP2gTz?=
 =?us-ascii?Q?Ot0P8ngUEet25LppnXe9xvYm+G6ns4zO4KQVNw6FJYYMx02zdxrBXD4c8xsU?=
 =?us-ascii?Q?LZuJf/5WUekoY0lllOSCVzt+NvbjkBS44DvPAez93xsP4rw0UCdz1RlXxvhR?=
 =?us-ascii?Q?TbHccuYnDxLxtghzjXq04a5OGc2igDXpNaxnr5d0e+xsLO009Ix1JgDBMBF9?=
 =?us-ascii?Q?vZvv6tOyQEJQTB8p4WpImiVG61RQT1R9aOY8HpAJWe0bDYPkjCaHbxQR99Xj?=
 =?us-ascii?Q?W6olQroJSvaGJzF4pMOhd0yw7XgY4OZtUHhDQbK0L7CzMW8Jvapfg4hUU17v?=
 =?us-ascii?Q?f4i3pJRE5wV0i5hdK3KXvuy+iHCqS1UWZJB+mTU/H/OYYuHKHd6kkKJUQOL3?=
 =?us-ascii?Q?lFYTPb6SBoQI6ZFlhT1RxJBRqiORZASZVJKxISGkPQcwKW9Eub7KmYAFRapE?=
 =?us-ascii?Q?2zIbQMtgc82+5ozAGEfeyMCcUjsfvM6X2CCyUCLaebZxKzR5rs3oWsq6UbcN?=
 =?us-ascii?Q?SIUe9LyV0DQaV9tIUrvS1Zj8E3MN5UFg9IbAHtyMPEkJ1F2ttKqpWMVieAsN?=
 =?us-ascii?Q?KUfW7xfHsyKxrrPmn4uHUKDOPJmwwxsSI8awsn3I2CCX39ZTN1omTtDnuOCG?=
 =?us-ascii?Q?LoOSEZ191VnpuOWXn2WwkWe2Ww5rxr4lAXdMA9h4Ugeib63s6mLB2YJSpEF0?=
 =?us-ascii?Q?HlJaofYAAPBSSLbjXQMZKgxujVW34CLpTmA/1bH7Tnpc3xnA89WKCGnwkZFP?=
 =?us-ascii?Q?+goZbpA2ZjF9EHFjDV8RL/WHfuBtQUlvp2+ktypa+D/5ECD4TBt9zrtpYion?=
 =?us-ascii?Q?PWGYsCl//HuPHBhbUwyDtMi6zC/kE1L/MI3p219BWqrMqh9vmCAsjS60K/dz?=
 =?us-ascii?Q?JLAq0PftaGT1QjpBrZLe69aFr0AlJDrXh+aziV9pCC+AeB5/OkjAr4WrjHRe?=
 =?us-ascii?Q?YUASl85f6XpK48LXx3U4ERk4VCB5afF/2azHxxvlKGwixWPMMT3E2GNX9kCD?=
 =?us-ascii?Q?h7f015rhvfCkSm+3KcDv+TIxJp305YQ//AurLrdT17vEO46BWuSftMkqti6l?=
 =?us-ascii?Q?YuxIrWuwEx0WI7oZzag+WJvxWPd9cqg7EHpuQ6QyoyEFzqj6AKfre8WLFQd1?=
 =?us-ascii?Q?FA+3d35+ZLYDfMubP4hdsTktVkhkbil04WQyGHjSRxsXftxKj4MUaYvn7VSb?=
 =?us-ascii?Q?W0FLuseoobE0MsuSGQVbfQXw/EPFtV5L1SBlw61Kyn5OO6bl7K5DkAunB2u2?=
 =?us-ascii?Q?ZycjeqVmknMJe4lw8tM8CcYw+vMjX22L0Qvzbh6pm3Epur3meygWrclAAfIg?=
 =?us-ascii?Q?ntPYlgJydhViCbskazJCDSgMRrEWZ+VFI2/AcvC+V1Z5MAxUXXz2n7XHz/t2?=
 =?us-ascii?Q?349bXGRvvtRVoDFtB2zHMgPsjDt+zpCoo71tCfB5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a897349-8b9e-44f7-8919-08dd67c339a8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:23:54.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiP9Xdhx8vFlb8kKKhdB3PIhcRf6TiHcHdPgeriEVvblPBuroHn/51EHlfWqDWQp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8941

On Thu, Mar 20, 2025 at 06:47:27AM -0700, Yi Liu wrote:
> Add kdoc to highligt the caller of iommu_[attach|replace]_group_handle()
> and iommu_attach_device_pasid() should always provide a new handle.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

May want to provide a code pointer to the lockless paths in the fault
functions in the commit message if you respin

Jason
