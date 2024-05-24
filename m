Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5338DC8
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559682; cv=fail; b=cWtKs5tUqSZrb9syX2ue3yl847l11faOfspg4evsaYsof2GT4d/l/waegTu3dr9umodIBQ9KKgNHu1Hrnelg7xeOCrAei0CJY1ia6Q9H4b7mAFcCJ9qVgDf7GJt3DAoq88o7jQJYPXgxXv97lV4Oa3+8DlulVdDqAij07Jpje3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559682; c=relaxed/simple;
	bh=73xMPCNz71gkt2YOmzFnA0Uzklt7euMfxCZzkMkKZzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ol0L/KD2Q3ZD4MZHuixc9VuUstQdrMFkUBkKtC5aAONAYRYQeFVPu533Bcbb7rUXeLSyCj6HTW3uF77vm9NJXqTYp3MdhRsV1kUTHFqqr2ilWH698TmgdGuNhusbcgUvmki7l94iRVBofEHkz5eZhPuL7dp++MxlCk5YOKICbYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpvEz/5t; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpvEz/5t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUy9YT7P8li2w3SJQXqqYx3MpmqLBA5n1QtL++Jb1N5CdoW26bGA3yxlGX/qyVnoU53FJ1rbsHy7NTkxzfblDx1tBw3xihtmA2N6zFW+viC7TDDEAGo2Dp+qEqMWEpyGZLWe8CDR/+f1mU6BaNyTW5TcV4abJKpCU7pZL+setRJvttmsuqftYcX7uG+zWGLdistLl/I94HVXpMzdFGCo1IKace2cqA1ExMRdW56gfxs4HU4a+DHlZrEfukxa8pRGntU7D/xvwpRBVTCPF4mFSW52NuG0K3bVmEkk2T/p6v9lH4i1Jd4vsdxSSul4hPOeDsVLJl9GRNXmD3WxG9MAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DemUIUcC0UJDIb0YFCi+qMh1BvalRwAaJRObr+8Sg5o=;
 b=N7NOYPz2bRhB+kl6oQZDhreJcDIh8KADzza3ffbhVPvzV62Rk2QnpPrUOeI5WoemPjbl0OLPgwrlpP8zZKInqTYUghwDvJKyHsxaoBe1w2jRXykQm/wy+/Q0W/XF5IR0mbeqcbfEzoBXvMtwwNE6naBawzJrhOb6RN2oWxc3TQIm1eFQc6VE8wSSYQVuOxFrx0RUs7n1lr+fp4ipkGt6ztejbdtDBMub6Eu7sY88SAxSWM+XQrzBmG+Lqm3ajLTQ+ymlZmnG6JOrv5dmvggAZGAfND1ejliD1LcHc9n795IOcYFZ+TdbA/NG5WlIq6h0i/+LWB8S7sgIiSbJJccqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DemUIUcC0UJDIb0YFCi+qMh1BvalRwAaJRObr+8Sg5o=;
 b=ZpvEz/5tYxBcFZXD7v157hQ4AsL5l/plHv8iQiPMbKJ7XxGd3rtAGSVO3pw4Sh9KhKrq7U7Y8J0Ma9soZIrw5YCF/0aeeL/6EpwAtd4aoc26xFx1dzrwUofzohvHaI/nVJX5/TQYA7XvTG0J4du0u4+zevsjkrZ90D5faAZ5EA9Y4CPROKfz2vJVgg76idtVkdf3sSuouQpGivimrNGV8TfPxcMdz9ESS1dZnd+JaqWlMwhybytdlGApxKG3/xm2e87uN+DeDtchtL1j2l+C8gNjo+2YrR8vMx5g/DRrhU6z4VlKbPv6xc6pRH4lbskbWn3zWhJGWQ4fwmm2PpPrIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 14:07:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 14:07:55 +0000
Date: Fri, 24 May 2024 11:07:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	jiangkunkun <jiangkunkun@huawei.com>,
	zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Message-ID: <20240524140754.GZ20229@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
 <BN9PR11MB5276ABF99FDF6CF0F863501C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <13e93238f21b42539097d7e347be684e@huawei.com>
 <4618c24f-aaa8-453f-aa9d-67a864e1c93b@oracle.com>
 <20240522165640.GD20229@nvidia.com>
 <cb2ab7ee-9e31-468d-85cb-71e70d7a7e0e@oracle.com>
 <20240522175053.GF20229@nvidia.com>
 <BN9PR11MB527660CCD250C176DF86F9EB8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d949dfb-ea40-418b-81f2-f2711b796d4a@oracle.com>
X-ClientProxiedBy: YT4PR01CA0423.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d63da52-1c2e-4f4c-0406-08dc7bfae8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uxrZDYZ7ay7jaFwUsoSdHjlZ7mSpHbn2ieTmXCxkaSgXvy+WKl4neoFoU5gb?=
 =?us-ascii?Q?W0FyrKqSUtutslsgBkVbUqozMw2GHjZE3kPipivpN+3/oWHYN8Yg9JQqyI9w?=
 =?us-ascii?Q?B1vewHLeetSRl7J8vz2dDvHdygZs5RjVOSDPdo9lZemnD3ZjSHlvV6RLXzs2?=
 =?us-ascii?Q?xARxtvAigdmgKeRz/ur3qcmHyHvb76zVTWJkDH0nYv8eaSTl4lWlcRFA+Pun?=
 =?us-ascii?Q?FK+8i5XzCOZC/MNE+SlSLFNsi/koDEzNHJbI8uGXTOHJx2bmSc9wnqRQbLeb?=
 =?us-ascii?Q?5ZEoeFsiyt8pa6SNX0PgBHRBy/YQvVC+QinZl8En5reBIZtXYiRHuOtD8I7n?=
 =?us-ascii?Q?Mga2uYPmgl7cqxjczQdBvmDsG6ZLi4xLTC1mQS3R+/PMfywZNgAtHVPYYd8h?=
 =?us-ascii?Q?mCdqNgcGh+ygmJP7mtMKMTHH1LRveOf/unKOVGb/wHTrfqspCfwMd98RDO64?=
 =?us-ascii?Q?oq76hSIt5iTGPQvJBuuNO6nGLRh8Uz73eXo9fA0u3QAxCehXASUZoX7c+IEf?=
 =?us-ascii?Q?wL/vR1l/VKTlgbsZoMe4yyxKXmMycLcbmRN1S0txR11Jejd24QOaoxxE/uOE?=
 =?us-ascii?Q?uGzRixtj/RBFaq5SVVOxU3rraNhXWOghEmvXCwjQVIdbaDLiI/+J66GicQKS?=
 =?us-ascii?Q?+yfCe4SK6DWxxcbAhoqsdEwJmSQCv+0gjpGMoOjf3ZLK/m7FE5NrNv/67jRU?=
 =?us-ascii?Q?Xl+qwjzvvM44bpZ3eYFpDwaUnQMWNnrNBp9x/QC7F5ochKlaJeSCRCtryIW2?=
 =?us-ascii?Q?tEa+22LE2nzJ9j8b2S8eBuqVHlAvQ+zcKSDo/LVZEg0oFq2yz+sSWz9eYqgZ?=
 =?us-ascii?Q?IUZ82tMoosDu6LkNRcBHThkBKNDAbDm7UV8EP2F/KX+ZBoCsMhmpMDGfWIKr?=
 =?us-ascii?Q?hHvkY7D4/UByDew/YZDVOLqKVo5CQpZwtUqsHJOjvyL3sMVSGZqkbhwzzpqM?=
 =?us-ascii?Q?CKj8WiI3HtKorEwLt7ePSgCjkzduj0Xp/Jedg+dwIErnm8KEBez7GDPNVO8Z?=
 =?us-ascii?Q?wzYKvqICwzYuW1LgwxIS6nUetcrD94+Uhxr+PUTKXsxka85WAgXByion+9Zb?=
 =?us-ascii?Q?42TJCh9bWg9b5XpF8iR8cjI6cpgTxoAWTOIjHVZwPMRq7plyi5PX+YI87AEV?=
 =?us-ascii?Q?UiUzGVBEFxaP2tyqVMhmvJgsw3m7eQGyY4ENvViJekZ3qMakIU+US/Q6d1Il?=
 =?us-ascii?Q?vdwYRYfmMKs7IIPalIcxJzZJI0zoNksNKGtVcSxSXXjWszq5TE319ZYFAgDc?=
 =?us-ascii?Q?xZdqG6c3/UAJvu/gtm+kWzKlCgSwgd+ZfCcnUKLr/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amU3MFfrXmOh8BTRyZJWFDG82oqhg1lq6QAsaWau9nqZTroe59sSedu2J99w?=
 =?us-ascii?Q?0r/u+vXi39wQMzOuOyPXhOnAYcvQhfsZAJsc5MisUsHjKUYGN4Zk93My5b/O?=
 =?us-ascii?Q?cAM/6OJZYz5434HwMtw2Lz15r3ZWNbgkQTaPVMB5Saap3t65ORO0CfMTo7DN?=
 =?us-ascii?Q?E03tq82w6iaPULQFHsCMCIvHK/dtYtONE3fHQhltzKssPivEX5L/5QhCa3iM?=
 =?us-ascii?Q?B4CPBlvupG2j6NlIZ6OLepPVZYPvpFGB4cjO8V5ez1l9K36pVzVSpBv+NlPp?=
 =?us-ascii?Q?FHc7xXWNXnsaIhmn13wgdO7KQO3g0Q7UN2jriLqtGZxmv+POum3o80HY4a00?=
 =?us-ascii?Q?EWzUZ+YzWNmYeWg6hv0zasJsi1iBLZ//w2XezV/53D2RT+bDk3cjPemhNjXX?=
 =?us-ascii?Q?NAFRk5pGM2hz4PJSpJISDNm04zsg6NLpOXtjk93Hc1T96mAfKqoHDtIck3iC?=
 =?us-ascii?Q?HcQeejGUaoLGSOs19dH3FVoZHSD4NC10qMIooKMHkPay26nIOLzuMEoFyo5C?=
 =?us-ascii?Q?kfGKqRRAKgQla1CmYFo0LbGJmoOBKZCNecsv5SWOZbQRpnKjVq1dd8wjdTQv?=
 =?us-ascii?Q?lYrtvnbBx4nwLW8cJ6gAAoHvBOp+p5B45P0p8YFdE/uTgILpysZHpoezI+IG?=
 =?us-ascii?Q?csDRwfZZNoOlgzOvm495TaEIITT5doTknfGGm5BzgmkFaXC4zvYOsJgRoYtt?=
 =?us-ascii?Q?RJrJ9cc7bhwymeYxKvwhLhOVXe1fv9F+a8mnqvAgshQWoTgtWHrVYOi2sr0z?=
 =?us-ascii?Q?B0ht6OixTiJPda3CazaZ+dbavlQGLuuZYkrloCQjW42yj0aQJavt323PIEHh?=
 =?us-ascii?Q?uvmC+OOoTYw898e/EkadObgrrRw0EaHHiq7DxmEGYkbyNjUvA4hDYbW4as28?=
 =?us-ascii?Q?VunllJWLtKt7vJBBN7dcliAZBxCOfd0RAQ4NFZIiIC1IYoX9Zx2UV24LMyfB?=
 =?us-ascii?Q?Ld8Wv3Fnf5jkHBQ7RswBPuF33X6C1LqMnToN04U4v3AFMdiqX7Avv9uZcZJ8?=
 =?us-ascii?Q?90ZsxHiUU8vkiBp+KOP+pQyK825WlRmuRNXxwnO8OfF60GT4bCIrtgiUEJEM?=
 =?us-ascii?Q?YzpNTPmG59dBrHL8xWkZ3q9VXD2zRwtE0bxlFhzGds7VABJTxEEaVX0fOXEv?=
 =?us-ascii?Q?ul/v0yAkigVY2Assbqv4EH8NA6sdxj72sWqlYDG3kahl5Qkf7pe3g3jppM4A?=
 =?us-ascii?Q?UMMQ9rdFY81t0fa1o+a2uB+An1iSoN9vBmL1b2vSekbETudMo5wSPUGpBH78?=
 =?us-ascii?Q?B5Vo5kCxx+Lv407Px4/MJclSNnzznOUL5p3J7lXop4iol0NE+46dBJ0YC2Vv?=
 =?us-ascii?Q?CDTSimuD+QvJXBxyehHg4ebFUbJabcrjAUecvxYL+oEwJ3W/TXYbYCHsTykI?=
 =?us-ascii?Q?naY4lZXhaV4DinxoYctKtWYuoJ8XqnadTSuv1fPC73gTmC/3JKddyKy4J/c4?=
 =?us-ascii?Q?F61Bi6Dk/bPLgLW/Z6DrDLy2TAHWgS1i2RK3o2vd89FNGTEwarCqW6vO1mvu?=
 =?us-ascii?Q?PSF9uifIEi8lKA+jIUJ3sF0rEurC4b3S0qmLCs0OcF+Rg7amD7mSzC5LMfoB?=
 =?us-ascii?Q?/i5t5qZM01ytGwbIi24zP94RY97Uza+U/kq4vJte?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d63da52-1c2e-4f4c-0406-08dc7bfae8c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:07:55.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhHVEmGl4qiiKXRKb4CXF1HPqQ0jK9qXeJpyUvYaDid4ERBIi9V+apVGWZoI8IL9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

On Fri, May 24, 2024 at 12:30:22PM +0100, Joao Martins wrote:
> On 23/05/2024 04:30, Tian, Kevin wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> Sent: Thursday, May 23, 2024 1:51 AM
> >>
> >> diff --git a/drivers/iommu/iommufd/iommufd_private.h
> >> b/drivers/iommu/iommufd/iommufd_private.h
> >> index 991f864d1f9bc1..de3761e15cab54 100644
> >> --- a/drivers/iommu/iommufd/iommufd_private.h
> >> +++ b/drivers/iommu/iommufd/iommufd_private.h
> >> @@ -52,6 +52,7 @@ struct io_pagetable {
> >>  	/* IOVA that cannot be allocated, struct iopt_reserved */
> >>  	struct rb_root_cached reserved_itree;
> >>  	u8 disable_large_pages;
> >> +	u8 dirty_tracking_enabled;
> >>  	unsigned long iova_alignment;
> >>  };
> >>
> > 
> > should it be a hwpt flag instead?
> > 
> 
> Most of this deals with iopt locks and walking iopt areas to clear dirty. So
> this being a iopt attribute looks cleaner in implementation. But I think I see
> your point suggestion considering it represents a iommu domain property.

Yeah, the original idea of the hwpt/iopt split was to keep code that
was principly iommu_domain related away from the code which was
principally attachment and lifetime related. Since this value is
covered by iopt locks it makes sense in this struct.

Not sure the split will stand the test of time as we keep finding
reasons to muddle the boundary :\

Jason
