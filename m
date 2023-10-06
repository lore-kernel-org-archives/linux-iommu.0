Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C412B8C
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F5MDu08S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERvKQpqSY8bejo0hGXFezXJtXwxXF6lq7R+e7ZHy7enCvEPuXYGVQdGTgW74WKebjN1M2w0+J69BeX4LuUZAaKgkLdbvzSeDyZM4Ow5tA8XnsTigLA1Xajdiv8Hq/7CLSGktw10fcWBCPgZeA9oGr8Fixh5ghgJ4uShyLBsv8PNrmAlMk2N4xtMgInrCysfKCxuJPfpEpP/s/fPd0e+CLIbC8mEtWDq7ArxAm1PXaFTO7CY+QWrVuSJLAN0F3hIKMBip/N1ECw6zPSa0KeaZIZizTRGjSqRK80PCmB5v8ANpXOQ7ChgWaR2m8gHdDBfGwu4hdhn9iHAsljGzRIoDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/XnB6GRsLeF3TPE9lVVN/8RvtQv+Ud9xrN5CCwP/LY=;
 b=Zo/I5BR2FB8bmRX4RegxMNd8kOWvo/8c9aI9vZTvXzzv0roKb4MBAgEzDjzrgd6RSGbzCgV9gerepsC0NDtDB47n5qX55qE3mqDUuNtkau3Ihx6mnMC6fzNhBGYvgGcJfWO4pRWOPbg1Wh1Yh76rXtkqDjieFQU2wnFEIWxGNiCohN3x4RhrOUoJmEavMhK8aQYo98HvZl9/xhzJOzgNIhbfgJl83OKhndp6YCMqWW0tPjF8ldTsCEKob0v+kTnUcx5DyiYiiUiE2/mfZm3x+1CYf7yHjJx9boXMbiXOsdg//G8qj5LfRUSP7JJrdO2/69mYHAg6DzbqzEl2+sl3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/XnB6GRsLeF3TPE9lVVN/8RvtQv+Ud9xrN5CCwP/LY=;
 b=F5MDu08SHcFI7wHUpYY8VaS5n7HWpfTNVrAXc8R9VONSi2V1HI03oyAfYS96ejF2LRZbsklHTEwEA0gbKi2u0fiAQDKRPx9sRhIMgipRycZVfQd+mPZ+FbcU3SkUKl711OeHXFiH+30Oqi4GRq2HJMduKnf2F3psM2dliUQqYk8F/EJcYo9ISTjX9u6YWb1hrN8CGprS5XKoPjYwbkKW10yAmWZUIs1EaPstyxOCOCvv6xU/cWgwHTGs017qGd82bpNIc3Kh4IGcjjINgjZ26SyTjGFoQiFhwMFwQduL9Bm57FDF/p956MqS8pk1hIaxLMFtM7iUiSLje1+rCvbKGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 12:41:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 12:41:11 +0000
Date: Fri, 6 Oct 2023 09:41:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 7/7] iommu: Restore SMMU "disable_bypass"
Message-ID: <20231006124110.GP682044@nvidia.com>
References: <7-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
 <b496eab7-c0fe-4dcb-adf9-f5460e4a8a28@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b496eab7-c0fe-4dcb-adf9-f5460e4a8a28@arm.com>
X-ClientProxiedBy: MN2PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:208:238::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: d09ebecc-93f1-404a-a7d1-08dbc6698555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qp9xx/iV5AzZ0hdJQoU7VDCBwwv1fzHUZDslMldudh9+IJ2nZgkFD1VIEYHH9CCDSDl4U9xlUHpdbKBAclgU9/xTjzDAtfBbZHfSSOcIYEqNz4ORIYlOFkcvNSppQtcPHOfyDSpQV7gyhJGADQx7pE3Q7kNR6QfZMtUndJVhsNPlxpMfGKnoyI/3eScIOwF+g9xfoIkMtWhWH0k4x9VVKpU+Hn5GMGuJ8tLd9kVpbl3u8YaJAw2yflBJa0gM/AHdDUwuR2x7QxMsrSOvH7cW+Oqc8e6/tSyeYA2w07Mc+nObGKo/Wmb1qPXgcrTGc0CxX729iPcpDC/3DsMT/9hAQzJ5n+TnQLAU+QK8vNyKtBNVaSieN2uonNnv/qlLV0v92Z9rTycYjSEy/p+FAHWsm1Qvl4W6vOBSlS1AWsV/qMB6ujC1oSpibp33+DS/7UpK9R4PT44YtBlCuK4ZDBHoDFQyIWYWHwrOEiM0Sq2IyGvQb4qhbZCD0LF8P9xf4idt9SRRmGqqZrn5CDLxq/Lnm6N4C7u1D6z22Xg5kAkZ2Vb41C77p40Y3JJ1kgUbml3tYQ/quUKtZ1QovZpSXgVMDfW9nZrWvqv1UX6nBdMVZMHfDrSB5J5JjDxtUhY7TW9K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6512007)(53546011)(478600001)(6486002)(2616005)(1076003)(26005)(2906002)(7416002)(41300700001)(6916009)(54906003)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(316002)(36756003)(86362001)(33656002)(38100700002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ZMCx3SXcTN8QQSh85cNf7gprXI+ctOYnNSZMWv/YkPhuGGwSDrJADL1VLPv?=
 =?us-ascii?Q?zKMJ2StHrFTxbDPP9Y/laH4wAuSsqjTxni8gF/n/KMNlUnqOB5hfbwgeMkDd?=
 =?us-ascii?Q?WI1SajKcOtm+a+t2LkpChN/ZouKrLAhpk7JjmF935AgSCMb9ME7llfChmXC0?=
 =?us-ascii?Q?fAPZlzaTyQyI6RgoSOVXC3Up+/N6EAEVo0Vt2f6ta/wrNsELAuz2tKehr7ce?=
 =?us-ascii?Q?n78SwFWiyYrxZ/w2RxoiLs6tFlvWpiaMjSS7YEBhbi4+tPIU7+kL52a8nx36?=
 =?us-ascii?Q?WVPGZqKZBqj3raPw8F0Ijqk90ScVHmAk8noeQNiCufUv8X1E4CLlb7UO8jcb?=
 =?us-ascii?Q?p4Cl7eIsXxSmkuxTRp0ezFJGSZZSNj4KTnUqmZmFuBfpcgU2cEwydt13b4cU?=
 =?us-ascii?Q?wm4nxukZuM93iSYeHRE404IU3vWnhO7RP3aoiOpCZO78e1uqAq4a2+IKOnNf?=
 =?us-ascii?Q?0jjVcoJUzgqpw2rAhj5pIBJa95zGInlbsT7xALOCVU9ExY/IJkS5gxRPiSPn?=
 =?us-ascii?Q?WXH7iAmBnGFSX0bNKBu43E+nIan2zsCqHv3jkb61Kd/cqYh7dHjojj5vlplM?=
 =?us-ascii?Q?bkjDM/92tZVlh2r8RO9Dup9JScqpyONDoPNinZPO/SryQIf2cHeX/kqCaK1x?=
 =?us-ascii?Q?AyUBrC9pS/XlbG7Nx287fM/e6onTuRdae7wsbPedTiXfngx5eARUPxGflIyy?=
 =?us-ascii?Q?Z5SAbLCV1CIfCJOTdp0T46gJ6m32CuuYlkWWUx4WhSbZqcXOqRSYtAhhuMFy?=
 =?us-ascii?Q?mnluwNq1eHmhhF/gK9zDyIG+5NqtniCjrLxpn8nY0/twxNC7VNuJcqkylOmw?=
 =?us-ascii?Q?KWrZcVS6t6C3D9itvUp/UWX49GoUIJIAgubT1oZUMjjFqnaJwWig4ftyy1K8?=
 =?us-ascii?Q?xw88vEwaxp9pqYPAZhx5DhSoCd3g65Pewg6Oq0ntqYxvayipfzJfSVXsrPBt?=
 =?us-ascii?Q?PtLygxUV4w2uSnuAti5EXgzWzB7Qc1YqbvlnPDgeulRqCM8ONRjGk/JDgGuv?=
 =?us-ascii?Q?1zeDeiwQEqLvawta8N9pa1S8XHg9kcq5mryQcMbUwAaKf3uYhqBbiOvSGs1g?=
 =?us-ascii?Q?6xFGj3ZFd+rzQs3JtRP+AwUbzC/C4dHxXCpJiDoCILrgJl+MaOX0HIV3CRVN?=
 =?us-ascii?Q?N5bQIzeNglMOjoSI0eeN6VsQjjo3lhLF8m5nqE9I8J+AbrNA8EhkVzMKHSae?=
 =?us-ascii?Q?Wc4hu8r5MPJ20WWBzqkVcWdOUovHw3jN/78+pGGCDBUSTJvmWNSg7TDKwQQz?=
 =?us-ascii?Q?iswS0yRl1qrBMg+tf1O5cLL5AOkZ1NBbfEq5PKa3tpCNjOgbi7u/QrkxADrW?=
 =?us-ascii?Q?mudb1H90DXJzDKAR0O97/kM+CCk3svEZZVEC37KqZNb5OrzeVWCl91StObqI?=
 =?us-ascii?Q?zaJbfsi03tgKmnvbqDYcNw9zgUghdIUGLgvIrG8oPlGRqtX4ZfvdyiviZqyd?=
 =?us-ascii?Q?t6GLAwKZwQi8zwXeFlmk1mWkO0kR5B6/tkJY2UOwRYUzxOSfWbpDlw45lcWy?=
 =?us-ascii?Q?qbepAFAsm4noJ2zl6BmPWlo8V/DtArcUgjQQjLFQVGLHOzzGea6/KbbXrFLA?=
 =?us-ascii?Q?M0cw5GK7v7FPGaHj8mljAKqiFktWhOqyI3gwJRq5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ebecc-93f1-404a-a7d1-08dbc6698555
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 12:41:11.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiZtgNqBR64XNMAr/sfOQsUKMkIwuIZ8JapzAUc0GjK5S65Aa+4X7+hT5F+8zdBx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114

On Fri, Oct 06, 2023 at 01:06:08PM +0100, Robin Murphy wrote:
> On 2023-10-05 19:28, Jason Gunthorpe wrote:
> > The module parameter "disable_bypass" changes the IOMMU configuration when
> > using CONFIG_ARM_DMA_USE_IOMMU to establish a faulting/blocked domain when
> > the ARM DMA ops are not being used.
> 
> Nothing to do with ARM DMA ops, it is purely about the behaviour for
> StreamIDs not attached to domains. This includes known StreamIDs during the
> window between SMMU initialisation and those devices first being probed and
> attached to something, but these days is mostly concerned with unknown
> StreamIDs that would never be attached either way.

So, I'm happy with this explanation and we can drop this patch. Let's
still update the driver to the new API anyhow

But it does not completely match the impression I got when I went
digging in the git history. The commit messages seemed to convay a
concern that SIDs which have DT nodes and struct devices but did not
have attached drivers trigger DMA errors to flush out bad stuff.

> Also we're now tantalisingly close to having ARM use regular default domains
> anyway - the full conversion to iommu-dma still depends on significant
> changes to the IOVA allocator, but I'm 99% sure I've got a viable
> intermediate step which at least gets it out of the way from the rest of the
> core API's PoV (probe/release shenanigans etc.).

What I wanted to get to was an arrangement where arm iommu doesn't
leak out everywhere. Get it out of the GPU drivers and related, get it
out of the iommu drivers.

That seems like a necessary step before even considering replacing it
entirely.

I was going to take a break and see what your of_xlate changes look
like first :)

> that frankly the number of users of arm-smmu with 32-bit mainline kernels
> is, to within experimental error, 0, so honestly it's not worth complicating
> core code with this.

Okay! We won't worry about it for smmuv3 either then

Thanks,
Jason
