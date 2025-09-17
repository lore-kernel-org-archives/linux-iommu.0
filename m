Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061261C84C0
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136133; cv=fail; b=O+eta81E+lrP9QqirIg2it3Ja0kIFdQ4wFdXqDbbYJQszqTlmywxT5C+xgcCue0AH13UyJV/X0kAxCL7VCQi0YBAB+np7N7ehkQLGuji5GUQX6BBA0a0Q9vLHOrexODh+mmZF40NoOTdQkra5ltlq65z2AjFGRxDfJYV95TkyNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136133; c=relaxed/simple;
	bh=9pMnVZLhVinEM7jHL6FTKvfvg1/f1IVsTElGi1jp9q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mPPH7XPVNMWuBgUdpRR8h1OTfhGLbEzDtSaJD/xc8C0Ld+gokJmxJFNAxaepvqrPKhKUX3VnZLO2kTkQwdncJjNOvSzwjKojko+s3+3nUz/f21Vo5r8OBpADNW76OlrYPAkUrAmqq/+zn8bE2E1d/qcLttObWO2Y9WS6xoYlQ90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EiA6de6n; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EiA6de6n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnuEr8H67M1U3+dYpe5hw0Mmazzc3yeHsFDRJGpVlyp9n1uJOFAUm76QlV42ApYhCUggqjCo3NX6rWCl8JqqVBiToTURUizu/irK4Q8hoOfVQtzD6AmUtpMcP8M+uKObR4MY3iNiy2NemY7qMj+Rary4cf3bbCOwqbIb2TgaATFnZMg4WpTVLtt1t+UkWcsUYvQpAz4STNEU9wVd4192lOwCAwfmFmYattFjNYZyAniNZvrj4e/tYXse+b5Xf+j118Lvsn/w7r7KMOa8vJIYQGyEaie89qimUt5XHLAHhkyCll+KQB/PVlou6kxNO+zzRPmOL/i4kxCw2qoPXaXnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWZvP455P3/v+SuzQqYeBb+s8bvs6L1HZBup4WQ03ts=;
 b=qA6akNtUiaAMdcc4PNI1VW5Jorx/kIMfG8+BWLpQA2JTn2alb3dj2QqfY36Cpq7PajmHneyA4tFkDWnOCc1N36DW7pdwHuCljgvkheg9OVbsurIt5697wo/wXKtgdUZNpsJZOW4ytmmPGzbsulnm0Ff9GTg7RKL8jvbLv/2yJ7zSE6nkHjtD5f6mWRFojKKLiKzuV4I6EG4yKkj+HR3DCUxNkqWR8WmV1g1iFVea3gpKcxsgcl7Rqg+KFooOCB8fLtPBBXllIId5oejxhnspepDYBUPzuWCeAHkG4aHUPmUwO5LBQQB4Q0y5Lv19id2E3tUtxlfcg5H9U6uhTpFu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWZvP455P3/v+SuzQqYeBb+s8bvs6L1HZBup4WQ03ts=;
 b=EiA6de6n5TslhmFPhUqZrG6WSA7TiyoaRq1FKPc4tMyrL9WlrtSN4XKxK2+jZZ9uBdKb+0vmm1EvrNcwK38qRnIa7UWFJklDdI2Vy8Ra+wczO+myzQl2Zlt2PUm2lSoSIpSJ66LhcY3iWFT58NxeXEGALfjrkPY+klgm/Wi+ieDXvCYIbvb3z21ZrRbB/C2lgULmfdyODZgs7fXFyQVKr1micdY+J702viyVlvyuSqnuoQaXNxm8unHUEBl1B7RTgqbTer9po3Fnimzp9M5F6siSi+cKsNl3wL7M/FBkyk8/XhTw58P199ptdOOB0KIzeKSdkP+OJq3iEMIqOu/gDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 19:08:48 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:08:47 +0000
Date: Wed, 17 Sep 2025 16:08:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917190846.GE1391379@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
 <20250917103644.GB6464@unreal>
 <20250917113248.GA1086830@nvidia.com>
 <20250917134128.GC6464@unreal>
 <20250917135819.GA1391379@nvidia.com>
 <20250917184625.GA10800@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917184625.GA10800@unreal>
X-ClientProxiedBy: YT4PR01CA0373.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::15) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5f3ee3-7d99-4ff7-e802-08ddf61da14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RdHE6PRN7YlTmK+j/RklCPVvtHI+vXM9vmj1hjzkZ2scrdi7LK2dBtMeumsU?=
 =?us-ascii?Q?OkJlH4HEktLqyQs5KNbBc8WYiW21uJQUEy82uLkD11DA2Mr1921rSqk7co7U?=
 =?us-ascii?Q?xctLGlors7xL8l7cC09g0rIndK612wjYqZPHABEGTOND7Cd5MJQxtot+dAOG?=
 =?us-ascii?Q?GNn4ZAcJhqptqVoisJnvKDHUhJ44JKoG7NIjsRwA9ht357j5+jO4j2vonD4p?=
 =?us-ascii?Q?vcSzsIekG6elhSyF7sBmHfAYD7kjapMcxv7jiPddU665XBliiHYmi4kOWLBb?=
 =?us-ascii?Q?qv+lZmJwYywefCj2Jh7g/QniZRV3d/OYrhOBN1pgn69rl3dMqIvCsoha5mk7?=
 =?us-ascii?Q?ff3DCFBrsa/YO2qnwv/gooCVuDWbqKj/0G50kGoWURVinCcIbryLojxTuN+f?=
 =?us-ascii?Q?paVWrr71ihviVP7QI28DxVK0NBNah0JSemzIM0hvztUfChz+HKwI+PNSxP0g?=
 =?us-ascii?Q?txO44Do8aK7Vpjz2ClBkEpClEXTMSo4BbhpPgmKO1H3eS6z3AbGHbG1sTuyb?=
 =?us-ascii?Q?utL0QPzk1ttgXC5arDqMamN3sB9BwmnzilvK1jg4acNXp+Kj3iKmhbjkSTrc?=
 =?us-ascii?Q?rvqeQ3LH7nQGO3ZUDSP/7NG3/lrbzLEYSNqP00QL0a1CNyygPObj7Sum+tlv?=
 =?us-ascii?Q?bCcMnsdbgGkNeJeTKnk3ixW8NN+mjBJc2SMtB+gb8ddYnL9/3srJ2d6e/Aj0?=
 =?us-ascii?Q?9gHzCGq56iYw01i8i5ev4REtSzn5qeDwu0VH9il0VVS1wVYaVApdkZRnGheb?=
 =?us-ascii?Q?hW0AUsrFQyZpQBKcSQ8PQg7RLV21vWsyku+InRZP6k+1KzlraXLXwUQWB3HJ?=
 =?us-ascii?Q?yyrqSbZHlRYi+3ck6rFSbIm4++bykK106l89ATPKhxIx5feOUJjZCDodNq9V?=
 =?us-ascii?Q?N7s5avbKb88Icmr1GhplHVmFAtR50dNMLxIruszWBp3ds2W7ZnVKK8AqDvlL?=
 =?us-ascii?Q?g7MTpzMAXEWPiolkAEL8wtDjPRBJG5s5i1SLBLRikIRkCQ/YYKTDnEkbKAaS?=
 =?us-ascii?Q?4YMJnEV7WOkqU+Qj0vMeDuEa+Ka5MNaMMqHBSKs4iKpZlGqsnYCRqChvsrCB?=
 =?us-ascii?Q?dFTnJVG0jSMX/3sqs1BrB1HMwS9JVuBAy5EtglJAIUjx00TNoLtPc/3XJU/T?=
 =?us-ascii?Q?w61IgYlzzo56VBAUS4jRAEnzPrteXVsoKImXrKxugAnYRj+Fg/Ii/h9+ezda?=
 =?us-ascii?Q?TEJTteT1PASmewgWTeAwxkg4XD0BawpJkTtLej+IyKTWnw32MTe++h4cd01B?=
 =?us-ascii?Q?XOwR/uLRNh9Dovb25v6uR7kIm9TTFXRAR/KX4+M5TqS/ZOToD1s0dC7e9ctR?=
 =?us-ascii?Q?yrDRFc+YEbNW8ExpSVhyZVmBtGE9wHfG6vUNa/OlEMD0JFaLK0jW0OBzaQEz?=
 =?us-ascii?Q?AvOJHINRH6p67M3lhmkTJ74jZL/ImUcME2CpG/C+bLsTGW+JfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTspdmBcQhKxjBiqI/+iWk6vbRRONe4X2nhF6Rwa8BbiUAUWvheaE/LuQxsZ?=
 =?us-ascii?Q?aTmmKJqVJ7MPHy5nlAT5P8R7YXBDiHEoz3OoSbL+PAumcwgRbRUWo9D9ogiK?=
 =?us-ascii?Q?rpFC5FuRhmoL5ycQik3zSJ3f/Ky2yJnB62D+XryRuGGiftHm/Un7EFNbyeIg?=
 =?us-ascii?Q?QPfFkX5K50+NEeJ65GxxllNNr7RZ3fQ7IX0KhCP4XPebrmuB+91pnxba75zy?=
 =?us-ascii?Q?AesmH7vImdP6iJrOqHzO8RxM4IMzLwZlOoRvINHNGVWeFZR4YGmIdUd3CUN6?=
 =?us-ascii?Q?hwF3Jt5dUQj8aB9Wm8QcHZjgqj/qW+m4KcnJqf3FAeZFgdTccoU5xwPmaZTv?=
 =?us-ascii?Q?Ogf3+3znlNWX8EDxhhWgTj3lw4LRWGDca2W+xkCtC9mj8fqzeG6gizMAyZq4?=
 =?us-ascii?Q?Vxl1NUpBLGPL9NeZoHqBdqoprCLXzXU1gS21XSda5Kxzr4sC9DnGR2udKWeH?=
 =?us-ascii?Q?gmY/eimGcaoDdG4jKHjexDVjTmIB+Bql9X6o6mM5TsYuRj9SlsUXHVqdh6O/?=
 =?us-ascii?Q?RCzI7DQkKSw4GdKvC9O0VsJQbWcKWBNquAwrjV12IAM/Rj8iqNUm43v8mQ3d?=
 =?us-ascii?Q?0a4b5oaJVTn3TwubK4kauswpfDLgfukm+Ms120kuyodWOYs9Xup14Zceh/fY?=
 =?us-ascii?Q?teusj8HuwvIyuOcP/qhu9CBF5r8DGeY81HszVGtz0BeQVcbz/09aBuXa6XVF?=
 =?us-ascii?Q?diK42r4Y8LQkXw7UxN6TzWOAvEavshlIkhimBHhIyAxwkYnmVb2kGqsN2pbl?=
 =?us-ascii?Q?H47ape8k59QKUEFw/6ZefRR16qGevbAn9eFjJF9rK43NgWiJtZADPuAxYh+R?=
 =?us-ascii?Q?GmY/ZC/NPlKTwfSh5FBT1bn26Fl9kgYeJ9i3pzTinOzTZ2T9zzxQEVOccW9l?=
 =?us-ascii?Q?LIygpd6/R5n848MhjoiDAzJxR2Yrb+FgHgdxX+LIdnRvr4Gzt3szY3TzOn47?=
 =?us-ascii?Q?nGbAwazNj6kV0tEWdnOcvuF3vIi6hnEWpz2qxaM7HgtedMgUz8PSpCVG3v4k?=
 =?us-ascii?Q?44zLU6L0B40C6KgdRXxunBMFTKBJ0LK7MD7uXbam6l2M1e9XmlHN3e7s+vH3?=
 =?us-ascii?Q?5nrijpQkHe8Ajc5ubaOOlGYQikG1Xa+7Qha6apseTSzilLnW8xL+3DEbHOSj?=
 =?us-ascii?Q?iWGFh+ifZv9yFhwDwqzrYb5sI7fK5jpSGr2rw384d1+ioi3G0mi7DkrK2jyo?=
 =?us-ascii?Q?kKFcnXeIQ5hkmO50TofkZypCCx0eh9/itzuizzyHqYklmKNZ9yMJ8XH3CVSv?=
 =?us-ascii?Q?58sI4Rii7S/jPckz49u1uYrYBeW2HPwyLcXmunPUfjhybVu7C4D9QJ/7fTDE?=
 =?us-ascii?Q?tg1KSHqk5A8r1OhmRYwnKGCbJo39tvDdTcXucF3StTNKhQF8cDATmmQG9EU4?=
 =?us-ascii?Q?GXNVmSKSXmqr9HHj7AWW7nkRLOM53kOu3UCIE0NMdyu5P3Wk5rVTrhKmEgd6?=
 =?us-ascii?Q?oySYacS5ceJLsVwrD+0jWoGNjHfJP2CVUF61KMqBMwFhiv7i/jdEeqAN3si3?=
 =?us-ascii?Q?VV62sC645y5XbnlghVhParz7rpl20Owu0YhRryQy1eOtseszdaki5wBtB0ZW?=
 =?us-ascii?Q?HLNXGqSXcyiOCy0b5Jw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5f3ee3-7d99-4ff7-e802-08ddf61da14c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:08:47.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9hf+rQ6RIyoYUqmvqNReayOqJiCIV0Jf8npOLg9jgPXXusawNl61gBcUX/jBejf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701

On Wed, Sep 17, 2025 at 09:46:25PM +0300, Leon Romanovsky wrote:
> Let's take as an example MIPS/jazzdma, should we call to vdma_alloc()
> in DMA_ATTR_MMIO case?

Yes, that is right, this is an iommu, so it has to be programmed.

> or directly return "phys" as it is done in other
> architectures?

Which?

> > vdpa can support ATTR_MMIO with the same iommu prot MMIO adjustment,
> > that would be a good additional patch.
> 
> There is "bounce page" in VDPA, it sounds like swiotlb to me, which
> doesn't work with MMIO.

Oh OK, it eventually does call pfn_to_page().. This isn't the case I
thought it was, there is another one that just routes to iommu_map

Jason
