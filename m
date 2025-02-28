Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EF1AB6FF
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764349; cv=fail; b=PFI7Im4U8s3JnHAgNSIC0ZVhjpJo8fTmh4yva5+1bMtWUDxBQyrPsghkYOBLHpuqvAoBIAuSmNmn/yIg54easeGfLcxg+N6zAMndj/qm80ju2fg2MLZXt1LOJtgDD9puU5I8PQYygyeGlmmCs1hrCybWv5kUVLCyospX965HHBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764349; c=relaxed/simple;
	bh=gvRXvk3khO6+QlOJjiYfmc1crxmbA4XaDvojuu+5YoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SbYrBlfky1v2YR3HIVeQ+E3LlEUuB/14fa6FPJ90A8BMwd+3FEBGL/CGrSQQ3s8/5OiXlJR646hT/iCG47ilJnD2a7LUTxZ/3NENV4jcH1J2iBilbZawteT71eQJQL1mgmHpuBLvLCGFwlUK17ep5rCN3/GbEWdVoe9iQcEFKIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGDL/E23; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGDL/E23"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBVoMdPLy8otbWSLJHZW+d0IwuF/Dqgu3CdvLXX4rgr/ScJFhueAi7nlzjO7qZ2d8lBUMgYQFpzHn1uQ+kpBaSMk+tE53Em9jRPPZOl729VpXPfQWAkXqyb6bJx1d3P8Fq/FngxqAK85NY8TQ+dOcrpoa0XhhrFJa6qNCqRy6muLc1zFYNAQK1gHT+QPVx2Xxw9yZwGN+Kep2WUiu3fYZutr47MWIhrn2SSRLmdm5C5pIcH5vPfnWb6lwizeGJDMs+0onsKEnDHJdL2+urfmmHeQ+h3zR/Fwer21edYtHefeAx2fBV3+Ov3fkx/FtfkQuVje2OzMU8fr1Cnc1V890Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA27BKwSwYd71GYIzoFFUYtbyDK2Oj19MllmBImkcbY=;
 b=byGmeh2K0WLFigwb1hTJcsiDmwfENUyOJ4CqLZ6KU7F1AABhIIhkVdHw51ESWQqKQpb+tEzO/XBV6jVgDo8fBdKSnkooo01xOeHCBXGiwioYr/LijQIsNIUfPrbAuhdS52rEKCG9wzk5Me31ojhMkoKt0NCRjm5DXig+XHICMO1S+9GHNpVOvT/L6CTykEIvtENDNyop3hMmzdVqHzslFv/ziXmxTQx0O2+Vs5CCnwcCnSB//K2Fn4+gKiZ8Z+W/uxkIL20X+JI8PygALIdO7wyRS+iJAsKucPQ1ksde/PwnQ+Rw9FcRU5Yyl/XAp37PLzVtBs5zNiLO1t1dVuWdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA27BKwSwYd71GYIzoFFUYtbyDK2Oj19MllmBImkcbY=;
 b=OGDL/E23wZgQv8pYLKecer9+lzGxLEldvki83KTGqVJFRx0Qg2S6MoKwiEP7WSKru8CEPcVqCFuU4ZQdQVBoLeXICWnSYxMGtMss/rZ/RO0am3b8dmljQ0bB5+oXFO0GluINgdrkj2uFuisPWTJhUYLkhKEmlKXFcQjnkrxINvnhfmDGIo1whh66ULCwxnN/iyBBS8TUGmcSA3sZlMSMB768JxFY1yX37+RPY8A0JOf8t80X2fibCyKf4qVn2fAPjwAM1wXNwHCveldnvfPzl/GzP7LFPKzlXrFkSqCLWeOxaBiYKN0+BtP6/iTywyFvrxcTe2WXSwTuQ6klZkBJkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.21; Fri, 28 Feb 2025 17:39:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:38:58 +0000
Date: Fri, 28 Feb 2025 13:38:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	nicolinc@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Sort out domain user data
Message-ID: <20250228173857.GD39591@nvidia.com>
References: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e68d5820be06adc1b34fc0d1c9399481151daee.1740742271.git.robin.murphy@arm.com>
X-ClientProxiedBy: BN7PR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:408:34::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1053ca-0d74-4f98-5757-08dd581ec7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CjynUBy9sVXd8KBBEzdu+FGwZcvFjDIfGReAYVtfDLB06ebfowbYW/8P/yLA?=
 =?us-ascii?Q?Ws7UM07b298k/HZOJC4JX4LYwyEZc6TCRr0omRVNV8Hq2PUWp3uw7ulWLUyw?=
 =?us-ascii?Q?nNuKWt/fxwlhFzvkXmQNcRwwaBf0J6rRynZri5/mr1g1GaKicMcuTPrMoCTm?=
 =?us-ascii?Q?GmaEzXKmL71YgWVESkk6mQA/nEpp+coCr3k4MPs1UjFGz6TmEwN/25ws3Uub?=
 =?us-ascii?Q?GrsLLU4EZXkc/rdLSuyUcvWAhT/YyQaJRY78DDk/27d03jnsUfgDhbvBn8x9?=
 =?us-ascii?Q?OjBy5L6vuq3Kz25f2zNge7OAPVI9AodO5YhBX+mDCxhwxtAYnuw4kiFBtC8m?=
 =?us-ascii?Q?adyKQifrkzGQtbTk37AV4AIaI19zTINOCunZRk+9R3fsoGSXMaVEc3RAVl70?=
 =?us-ascii?Q?1mJH79BhpWq7rdcwv0rxa82o2e5Id4WzVpF5zk+RNMYH3x5U6nmuUahNEx8q?=
 =?us-ascii?Q?Dkqx7V9JRZM8RbblWLwHx2VgSiRGpQD/mqIzD6WSY4JuXGNnIadkK+Igh3lg?=
 =?us-ascii?Q?bh1ByPZhpeSCJ/huAPKel0X6Sf1Lj7/XcnY6KDI0WAtW+2vMk+ybb+NJblnI?=
 =?us-ascii?Q?KYBffd8GAb+dcT4LKcU62bHzs3xhOMFVNuUVwrTd6gUF3NGid9MK3XeDDvdz?=
 =?us-ascii?Q?mWIiOfXcocS2la2M9ZzCyFKCos5VSEoErQ7hsqk+xltaxfryKoxpYpognd9m?=
 =?us-ascii?Q?0ZFdm5UlqUJtq/9/zJsFVIjDO3Z2RMGDr7CHrQHuCdU8srd+CyaxRM33X1MK?=
 =?us-ascii?Q?r3R6y32JZ5MPaxRzibtAobCDN57QzoFX+6Gn8tSZhXx4tt8bzlz/LY3nE0+Y?=
 =?us-ascii?Q?X4w/ECRk+DymEWx7YY1YCDVmW1+DYl0BpFqk6Zs0gfs7Vwcn0/1ssgeUsXwg?=
 =?us-ascii?Q?ORX9gA9IC5/pgGZSzYiT2rFgzrf6O7KYFd0T7kU3AvLnugdXRA36qkDEhj1C?=
 =?us-ascii?Q?AhgEMk6XzEPJJ73/ToYupFoNxw2n34l3kj2MtlWD3w54S2IQHXNAPhoUbCLZ?=
 =?us-ascii?Q?D4U2xlVTezxB8lSn9wd3Q6i4DGnnbhEDw/F909ePr+zfKPh3H60TOch7YNr7?=
 =?us-ascii?Q?IUTdo+USWjqdzmtrZOHLLHE01siGN2EGmmtQUf+XnWBc7vL6Gjrs12qm/mur?=
 =?us-ascii?Q?GOXBGb8o6BX3Q3xMTYfVud5CGgkpMp5yVdoiZQo8XRm7kRXwa4pC3rBl4aCl?=
 =?us-ascii?Q?QB/l7iGkKZiDHI6MDtFjJkimKXOVKNFrzhIvVRi8DB5V9RaeyRtImubR2ssC?=
 =?us-ascii?Q?lvwQy4UCwd/lKW/AFp/3+iLJ2jdV8oqGPWFjPYGZaM7RdwPZ9Xki1IxrjxeQ?=
 =?us-ascii?Q?Ksjmfveus49Em4ANzbkCgwTj1q83JwHmFC3vZIudHBksrqXuuXtNgKr5QP8/?=
 =?us-ascii?Q?JbyMUURMQ+Jy/4yDVZiOzDr2RYuT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wen3FqzM7LmYgdVFtU0WlEEm5y4s8CQUs7/dQof293OdKxLf9G76M9vJ1Dbh?=
 =?us-ascii?Q?Fa+vNahNxOca5Kh8AxzirWfxtH5n00KMGSuFpsGIIGFBBvqT+xESg8YaST5k?=
 =?us-ascii?Q?dx5ldBOWC4o4pgtfvscmmKV1BwEj6JjspTZAKkDUAux8/56UWIqEmkI5PPhx?=
 =?us-ascii?Q?GJGVBhwSCFWx8ozScq8j70RkPAhkmi4uHRmr4Y4lFLmjp+ukqHAfeu0KqsC5?=
 =?us-ascii?Q?8E/zNaaZrHKF16o3wAy/BpfGtRE3wP8+psR0UFnWLTWCPOwhtgvGYW5af3VQ?=
 =?us-ascii?Q?5MtuxYXc8Yx4Ecm/8mLaLSmXBYE/gQV/oF7oA3y1XWcdtp4ZWPL1YNjBZHpV?=
 =?us-ascii?Q?HduHWGQafG0nMhtbC70TXCVERAiXliJFmdmVCFwO/SCzh1Kl1Sl5ZeaP6DXm?=
 =?us-ascii?Q?x2E0dz8lIiP55B4CjJUQZikEmW9QhznsUdLV6tCSF2zd4nvoSxDWfw+GfpCq?=
 =?us-ascii?Q?zVPUBYf+tw++/VUJlYrmJ7is00SG7k6Qb2nUWAcvMhPnh9mI1RZ5bzbDW0Bo?=
 =?us-ascii?Q?caSgqfUFcsBRP+2VRYFTIcdRz69gzPSqnIGkprxW+i8E3mQW8ZRV7okNT2yu?=
 =?us-ascii?Q?+c9KHYbOHncTVMpZj/IvkYAMMbIZIkKya0VdlRqUYVgpyqG+E/9KwNrx7mJS?=
 =?us-ascii?Q?mk2Un7ROpZ0LH6AQl4kyJSHqZ5J+TbzaSnm0KjCB/v6Chz20J44l7sVl/Hra?=
 =?us-ascii?Q?8UYbu6D7yuPhF4rOmAnSlz9+pHe2bmM5VhVb5fmnv1XRGmWgKp4EdIFwuVu1?=
 =?us-ascii?Q?DIFjxDEvQeleOmaeIc+HllNy1hkzgR+D03jsrmkU8vRobLyccsBvZbiwl793?=
 =?us-ascii?Q?IE9hN878khhDYXoKJfM8OoXE3eYWuDFZe2vBbqnHoM00dD7WY2hythfAEuaG?=
 =?us-ascii?Q?5rGpmgTl3e/lNHfiieXMJ6C268oxhCNKFqMoiZdVRyXjW5bRZOvwUsb52Qwn?=
 =?us-ascii?Q?fnB+oNDLPkYC9SpRwDkwlutF63g9Oe5CNMPYRPJbsw8uPZ2C1rY5RxMAe74a?=
 =?us-ascii?Q?E+KpX0XVZWy4hSi6jlKB8zEX+QmE4pHpy7CTiz4t+eH8d9RtH2/EsXGkz4D1?=
 =?us-ascii?Q?u5pGvLVoiKSgNDZAs3Fp1TLMX6lNcS6XZUCut9MeJMBnTlJV2t94TZ+tYFua?=
 =?us-ascii?Q?J5FZFmNebn4mk95WNS3FwAOZpR7ZnKVMyPTXT7c5RyedVoyUBjrL/rBjWF8r?=
 =?us-ascii?Q?fxyuqHkGGUMJ8RMPPCu92ocBC8kgruZsn9Gw3OxR8sIw6VoeCZiqAZPQBNS+?=
 =?us-ascii?Q?yA8ISbagzOm0pUS6/JCzhNK2C71jSH2hXoH54X2n9I7vj3LFZIrXYR2xujmh?=
 =?us-ascii?Q?HOfmOMEB4Zbaq4+oTpvskGDzZI5s+Z6IZRc+vi8gDFdVuZB4lteLwsvp4llt?=
 =?us-ascii?Q?aDkqfnIlFdue6jQGLLwxinJEaWPzzsn8bvNAy+LHiIfyo5Fs57FLVgku/uPC?=
 =?us-ascii?Q?wE5v95S3Pj31TidyFeQViouGHr/YYlwzAf3hpX1V7Ei92gSIvgO9uHI6cUTO?=
 =?us-ascii?Q?aaeNkMaInZ/k4D1MQT7jUjJRAZJnfnCUoIXeEDs/BzjlarElddlCpAIAXbHW?=
 =?us-ascii?Q?N+6+gtTB4Z7Sqe/1Hr6a8omFbwJumjBKxcV6uhCv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1053ca-0d74-4f98-5757-08dd581ec7f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:38:58.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyLUD401WgP9vbubmOO6vPAz1s5Pv2r8cWH/rf5h43lqv+PGvLQO9SI4TQ9q/gSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

On Fri, Feb 28, 2025 at 11:31:11AM +0000, Robin Murphy wrote:
> When DMA/MSI cookies were made first-class citizens back in commit
> 46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
> was no real need to further expose the two different cookie types.
> However, now that IOMMUFD wants to add a third type of MSI-mapping
> cookie, we do have a nicely compelling reason to properly dismabiguate
> things at the domain level beyond just vaguely guessing from the domain
> type.
> 
> Meanwhile, we also effectively have another "cookie" in the form of the
> anonymous union for other user data, which isn't much better in terms of
> being vague and unenforced. The fact is that all these cookie types are
> mutually exclusive, in the sense that combining them makes zero sense
> and/or would be catastrophic (iommu_set_fault_handler() on an SVA
> domain, anyone?) - the only combination which *might* be reasonable is
> perhaps a fault handler and an MSI cookie, but nobody's doing that at
> the moment, so let's rule it out as well for the sake of being clear and
> robust. To that end, we pull DMA and MSI cookies apart a little more,
> mostly to clear up the ambiguity at domain teardown, then for clarity
> (and to save a little space), move them into the union, whose ownership
> we can then properly describe and enforce entirely unambiguously.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 189 ++++++++++++++++++++------------------
>  drivers/iommu/dma-iommu.h |   5 +
>  drivers/iommu/iommu-sva.c |   1 +
>  drivers/iommu/iommu.c     |  17 +++-
>  include/linux/iommu.h     |  13 ++-
>  5 files changed, 134 insertions(+), 91 deletions(-)

This looks good to me, especially the cleanup of the fault stuff. Do
you want Nicolin to rebase it and combine it with the other bits he
has?

Jason
