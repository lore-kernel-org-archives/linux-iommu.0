Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D168264F89
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051613; cv=fail; b=Takm/bZA1+dBFuuGXkzalsO5FOnaHDN1vv+x4N9MQZmS54LYcDtGEBrenacVZpXJUn8t+nXczdPcRd7upVNwQAdVkXjtsXSGrRE0V7rz+1OrgaV1f0ozZu0C3hKw6LrTcMy99Ddr5HK1gAgH6QGlMsIUtbuB2/hmbXrF+CffTXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051613; c=relaxed/simple;
	bh=Neh37icK+bnqUoypIFgmoY2/9lfHrgPZ7yxS95/gOtA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBpMDkh27vO/NSNg6800AeK83L6N7zvSMeP1aq8jOirYnVZZGJKY41GS3VSic8VaSlr7Hv1yEpZy5tHaFWUkpWTTvwDuQEZxEPEMH6EER3AI9zORaMe2UE7unQ3hSc9hXnCdesQQXAreuPpURlg9NBExvPH7+RaCxcFdvXpDdr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pByORw+O; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pByORw+O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsFz0fe1mcY91jA/crXvRzWfj/2ku/4aDX8wqAF4rC3z10xyB6nRv0F6PcaZVv3V8uhW08FNKvWKLvfI8qU4UqIH9vBLGMBgUHK6tYRX5UX91t5APAhloSfQJwXHp2ScbRtGu32FXPgaNJm48GLSJ0s2rwli1CJeMN+zZ/xrpKoxrxC5rweW/EJUhz+GjulryiKeSwXUQnKqyKbZ+z2uFS3zYcNOFyD6OnR3ayivsFAvO8yEhMceen0v4W0I+GDt5F74FDNRkitEE9CXbdC1nFYaCk2xgXeEw0KLENvwKcViaZ6sXqR45PxjmrlrAfUYZ3PJ2jAZVlfeKRlx/WiHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSZED5q/CW0lL3TaM7dwkxMDP5zs+qsgdaLr0xpGn9M=;
 b=rrfR7ddGK7OXEvuhIMzkq27+ECmaGi96IENXNb/DJMH8tTF/NHXFvVR7l8dNLnzOdpSymBs5c7bQfdjksYoYu5bnI/p+D0bYCcx9Xg4MBcxGhen2hytXrki4y3JmdB/6Ahopb99g+uyHNpD/sjgpD3/nQo/mZvDo2GrSYbHqWBjSiymicp5BeZjO7CTAIcOGPtiKbAC42GvLufxT72RNZggebpidDWzSI3lu4j0REiK1JCTws2VpjmMy/K7vhS6pSb0quB2xSmkFQiL2G5Y0/LynE+Fd31j6caPQIyGN8hRGe7SKbWh2WOuQH83iCqPW4n/rlZSaV7zHBxxDLhSrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSZED5q/CW0lL3TaM7dwkxMDP5zs+qsgdaLr0xpGn9M=;
 b=pByORw+OgHNgsvhKcA/63O6vdSPjfbIjvkRSKqAx2Aq9RJm8/tKROyH/7srca49niBmzD7D1nZ5z2PLQw3n6/9+Doyrz6URvC5MsgVG8cQ9FDTsm6XU1HJLwJz3MwNuqjjryJcNSZg6iOimlZ0vJBEdjIEFWdLRglGEXN46TSLxdd1cd1iUH1fn05US+gK0rahviDWZztTadJVOfpi5iFsusY0Dr5giWLDr6x2CfE21A0gRR88cITUo6cM2NIKeNlEerNB9iAXJNmbbgeCw7s+f1bNvmuo/gUWiDVk8oVSlCpcMSiSKkTYfstgo3REuGAOYx3FV6R6Y+h7+kpxIx8g==
Received: from CY8PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:44::28)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:46:47 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::a2) by CY8PR19CA0019.outlook.office365.com
 (2603:10b6:930:44::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 18:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 18:46:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 11:46:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 7 Apr
 2025 11:46:23 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 11:46:21 -0700
Date: Mon, 7 Apr 2025 11:46:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <jonathanh@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc 1/2] iommu/tegra241-cmdqv: Fix warnings due to
 dmam_free_coherent()
Message-ID: <Z/Qdewr7ZqwfK1ZV@nvidia.com>
References: <cover.1744014481.git.nicolinc@nvidia.com>
 <a92f259bc18f8a5acdc067770b485ea71767100e.1744014481.git.nicolinc@nvidia.com>
 <20250407174408.GB1722458@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407174408.GB1722458@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: c38ba07d-312d-4266-6bcb-08dd76048cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7IwwXTqb6OBOuLvRZy95uNTcLuyl6kuVmd95u1nT/h6n67W3PwRH+bNyZNGL?=
 =?us-ascii?Q?Rd7R97Q19T/yE8IV+ksb+MEb5P6fcKqI3C5F61yl4iKFWt+VUvh626Rx5g+b?=
 =?us-ascii?Q?WJYLKU8SoM1/dlbEzjije6cB2mJAufFzP1QM3eP0KUh2XhXbQ3xDcZlnMmMh?=
 =?us-ascii?Q?1KxOXMIruzzTPo6Ggtg39VGbyx75z0q05ciU0sh26A1b8FVYjCkAWXcOmiY7?=
 =?us-ascii?Q?4u4CAM8yFNq1XAfRmk/MMxh8ZFWK0NUT+hDt7E0M9RjpQToK1ZmTjT9rxnJo?=
 =?us-ascii?Q?Hqz6Jo7t2uDCjPBE0Z7MjMlOXJJ9wjuKkPQfc5/8Xc4UTx0X8fW6LfAZXk0x?=
 =?us-ascii?Q?rDvhogYBBoYeX+KJCUfz6vLAw//IXcVsWo2Jv92kAKffCduTeD7gdCXlZvRi?=
 =?us-ascii?Q?i7vqnKr5j09Ncv8Mn+dktddohQ8MSjckQN7KuE2VjM9bb79JSdYn8wcuEHrZ?=
 =?us-ascii?Q?bMWw7SYjPGd2hWapA0JFoD2FvN6ggkEbpX8HyI/FjLfK6tUJDX4RxbQI+g23?=
 =?us-ascii?Q?EjGUqMjsjFd27qKxDW6Cw0jQdseAStqCZr+OpL+5JmTXKujocZSi8XrHfmje?=
 =?us-ascii?Q?B6eLfeDLrkGxS6StwtLOf+uKfweY6RpG3rt2ROI8cCyQA5s8eVdgufnsVcsJ?=
 =?us-ascii?Q?YRbl2S+wfoZSKNM6+zHSZU+Y5lszoHSMCPHTXQeJPbm4tRCRvU7rJ4U3tttG?=
 =?us-ascii?Q?DEyleVs2SOESj2jYyBKzNacnXIFXWWUX8GC9T++qdP/xDew16f0LTLbNnzf+?=
 =?us-ascii?Q?3sPRkL2VBMA7rqKfX1712NQbgsm+Psnpg0pMoRfY8rnJO9gw8ls0J1rZBee8?=
 =?us-ascii?Q?MsyuYlT1O/VSzEsrSjNuRAkA/SG/X6reJWwmBwkY2zeuemXiqBGwhAsYutCU?=
 =?us-ascii?Q?h0L8XNckCJkwlmcv0vo78rYKYwY+ZFPhQpruBU7+weR6hn+7l0bA9ek+zuGc?=
 =?us-ascii?Q?H4OLI29ttObQf3u4hTu5w5JApdGD73ymihlg7XGOQKgQ4Kq4qkXhWBoyqA2R?=
 =?us-ascii?Q?SqohFc8cxu5301GhVJbOjjKgToeJEBDXfd9eTbdKV4svPSvsd97RWPG7aQp3?=
 =?us-ascii?Q?hK2YX/XO3a7oDJ2ZsejVhrhoe7j2IAZyWJsquU+lrBQdT/HwCKvbH7LD/TqH?=
 =?us-ascii?Q?2eYlgDGdL0vvBxCNo88DoYpXVs7o2D29UXRYDKWqfES35dWb1kNlnLOUrILk?=
 =?us-ascii?Q?Y25vC3VLtd+LLAz8dD3OUb5aKgipbTdzCQkVB52kSSTn90J65VBUQn4rwsI/?=
 =?us-ascii?Q?kq+1edlBwZ9tGpeodT1e7w15+G4QpDmMnDGaxkcL4ll6UrjPhll8JuPxDFXS?=
 =?us-ascii?Q?V7FZLrhL0tazPP9D3aw6h6NphVD6Eu4BSwoLenhaiNQ2xTlG7Q0GR4opryGD?=
 =?us-ascii?Q?w5V0UimakQS4BtEsEuVHnqs5dLN5JV4hC0ds2NOBJkE6cEFvX+EgNfLtdXFl?=
 =?us-ascii?Q?1bMilxa1krD6kjk03bOMQCpRiEXb3/z/H/6WEiEUJ8WSRR9J2FORJEfHLZcx?=
 =?us-ascii?Q?P6JaYRL0Pm5RmZU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:46:46.9200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38ba07d-312d-4266-6bcb-08dd76048cce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912

On Mon, Apr 07, 2025 at 02:44:08PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 07, 2025 at 01:34:59AM -0700, Nicolin Chen wrote:
> > Two WARNINGs are observed when SMMU driver rolls back upon failure:
> >  arm-smmu-v3.9.auto: Failed to register iommu
> >  arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
> >  ------------[ cut here ]------------
> >  WARNING: CPU: 5 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0xc0/0xd8
> >  Call trace:
> >   dmam_free_coherent+0xc0/0xd8 (P)
> >   tegra241_vintf_free_lvcmdq+0x74/0x188
> >   tegra241_cmdqv_remove_vintf+0x60/0x148
> >   tegra241_cmdqv_remove+0x48/0xc8
> >   arm_smmu_impl_remove+0x28/0x60
> >   devm_action_release+0x1c/0x40
> >  ------------[ cut here ]------------
> >  128 pages are still in use!
> >  WARNING: CPU: 16 PID: 1 at mm/page_alloc.c:6902 free_contig_range+0x18c/0x1c8
> >  Call trace:
> >   free_contig_range+0x18c/0x1c8 (P)
> >   cma_release+0x154/0x2f0
> >   dma_free_contiguous+0x38/0xa0
> >   dma_direct_free+0x10c/0x248
> >   dma_free_attrs+0x100/0x290
> >   dmam_free_coherent+0x78/0xd8
> >   tegra241_vintf_free_lvcmdq+0x74/0x160
> >   tegra241_cmdqv_remove+0x98/0x198
> >   arm_smmu_impl_remove+0x28/0x60
> >   devm_action_release+0x1c/0x40
> > 
> > For the first warning: when the main SMMU driver cleans up its resources,
> > any routine in arm_smmu_impl_remove() should not use any devres function.
> 
> Bleck. This is situations where you should not be using devres at all.
> 
> It is not that arm_smmu_impl_remove() should not use devres, the
> problem is that arm_smmu_impl_probe() has mis-ordered the devres
> callbacks if ops->device_remove() is going to be manually freeing
> things that probe allocated.
> 
> IMHO you should just put the goto unwind back into arm_smmu_device()
> probe and not use devm for ops->device_remove(). That will put things
> in their proper order and no problem.

I did that in my first attempt but it didn't keep the "fallback
to standard SMMU" part as the driver was..

But giving it a second thought, I think this fallback might not
be necessary at all since a structure allocation failure so the
standard SMMU driver will unlikely be able to continue normally.

I think the correct way is to fail init_structures and that will
ask SMMU driver to unwind with smmu->impl_ops->device_remove, as
you suggested here.

Thanks
Nicolin
