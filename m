Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7E1DFFB
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723726870; cv=fail; b=gKBmOBVydvO7+7haBJ0GlchxaP+7mfB3ooj9Vv9ADwCDoac5btd3+7iDGgb+3GP/h0XiPFveMK0FaW4Vpif+4YgxSvqB8jiN9dTgeQc42vY7A5TJJzazKDvkpSmw1F89cxTtQaYkbvt7Sxv/97vvA1DOGPhXKuji+LRVKOEMto4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723726870; c=relaxed/simple;
	bh=TVyQtDGsYo7oRVq4Prlq+axhZ+OcCqXV7TzWetb0K0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iUvmpYEAf34Ts/ik8rDaM15rXVc/53/fEvuQW4j/g5NoEA2xOfMfRkw2XPNkkWqpSh8aAWCjRFv1jx/t+p4e5yEz2vRceknJksHWj6PS3G0IsKTIac9EU+DioaJ9URwZbqjW/bfeF+bKe7LOFblgyBAkBMlMHmiQAqkYUPqfstg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TaMOly32; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TaMOly32"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGHdeSXv7cds+FhJs3HBu5eRjusIcHV7SlODtWulmCcZgCswnwx/MR+XynmXxROOCg3mRR5alaNe9ccwzYHPVom22Ik9mR69nOCeoclPm4TITIqathyVjZrOLiIXcX6dL3VweA12YSED8uyC2SUqi6jaz52eC2P2kgiMOu9myN7OVfP2x3IuapHEfIRt5WmzMSL6xDVLx+0M9WdL82oS6W+2wrJGIKZZ5YoR7H3uHVNjU4WlzqS4+pUgWuLsTct7wh2lFP66g54g22ulXu/WcI2rjQKIW+lT58DVjSczO4qs/eSry4MkByi00zN6R2mOU6UXsiR/OCWwvMxruslDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YPkezZ7Yn9BpSh8zOtViiakV2nwIRVxV9w4j1nGCQI=;
 b=gV0YcGWdgSPCWPRwcZEv5oxZ98b5NGvh8uJYGnymRD9fivv1aMm/NPSzosmDb1jg63B5zeuMExin8BCo4lA3HpZdToGHQt1X/YofZ60+sKVXKvYuP7M0KQCSFP9/ilSWiCEcLZgGoVmDaMUVBbc9C7UtJde1+YT3UoLoGKrTmCa+vAUokocUr6aIHY4vgCCBpFFScxyEabsFu3GRXpsgHQeVNNjKk04tVt9TqkM3Q9vics9eNO0XK9ztJADodYzD8KciJNyzUo/uwuDavSzHkVy4HYc5KrNe0nk+yIcuorVUCxB0QD5++kpe0ii3SgVWxU2U8EjfRklZ38vRfQpdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YPkezZ7Yn9BpSh8zOtViiakV2nwIRVxV9w4j1nGCQI=;
 b=TaMOly327aEcKB6cO+c7PrbEc98oGZcX/hqrULT4mx5nM4yBqCKr0VRvTVTBQS3xhD5jGDLlhmwZxzz8scbX3MVTK9gf+BJufOB4Mz+tFheI4QuRwfFKrXeuTwc0ZkRmDFV8PcrJOM7fWISHktcTMKa5uEnzgMKSYEcPdevmeURTvFjk9DNpidiWRnut6+9lwVvfVAd6phhVfOG2CF3sfMQVFpK3mjpUJD4kSc9ZggztbhXYWOJuDkSlyXgiYbMKSdXBgf2cpaytUdatOre1JcRPEydKyX8KlsSMBgsjUtmHJG3yQiUAd1whKp4g9A4B+HM6m+249ycbTFTEI+2Z1A==
Received: from BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 13:00:59 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 13:00:58 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 13:00:54 +0000
Date: Thu, 15 Aug 2024 10:00:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	y@google.com, Mostafa Saleh <smostafa@google.com>,
	iommu@lists.linux.dev, Kunkun Jiang <jiangkunkun@huawei.com>
Subject: Re: [PATCH] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <20240815130052.GF2032816@nvidia.com>
References: <20240815123223.7116-1-praan@google.com>
 <Zr33pnFDbuJntl9H@google.com>
 <20240815124611.GE2032816@nvidia.com>
 <Zr36-J4fZ8PlcvV6@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr36-J4fZ8PlcvV6@google.com>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB7763:EE_|BL1PR12MB5802:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf8fcfb-f33e-4907-8b93-08dcbd2a4bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9Z2zN+H+lN9UuMrwhthgWA+LTERN+LSoGnKxzMob0nKJFKKstVeQUq0fg3W?=
 =?us-ascii?Q?xlgtKDq999OxFjULF8vMZ8QqXEcIPznhruDAmwhsKaaST5vTKu0L5vqdNHBJ?=
 =?us-ascii?Q?Se62IdCx4myUGGw/bHm0D8hbtiL1XZiwaNDvUy/vrnb6GQr6Lgjab3d0e2l8?=
 =?us-ascii?Q?An0CyUNn9IrSkMJL3dxAaeekG5ChyN3BgVJzY2IypzoeFHDqOXgNJO5Bq/Rl?=
 =?us-ascii?Q?dxmFy9Rk3KPymA9q5hKZuM2Bv13MCT7cjAwdgl1+mu8uoz1Iezk4s0S2Ci/b?=
 =?us-ascii?Q?zwZq6aL4SPxdN/xRXdq6i+QZJvRKWP6sbcktn8Xn0j5JlKGkmIb3pLI3Np8k?=
 =?us-ascii?Q?kGbD6n4NLzbXZrc82R49ZMfQqelP7M5CYvuV5LHTNLQmdLp/hHpiENwOsV6F?=
 =?us-ascii?Q?aM2ZhgdEYy/O/iOcYQpkQswXkcBsClxYydYPWkNWQBzqeaZigX4IP+sD/ymb?=
 =?us-ascii?Q?AHeFpxg38yntMbPEFul7+jqgJxPIntMc1m8X05t/3C5SkQaJzfh5L18/4Cf5?=
 =?us-ascii?Q?7Ce/19r+TthzR6/OwVb6V7avPf1WYUqquPYE0/6/8/0KQG1cW9gBpoze8tit?=
 =?us-ascii?Q?3+s8QId3472+tTjnnmD2vU8p0EUhVL5OFg7UZK7196yac10t5kETek/wtuqJ?=
 =?us-ascii?Q?bIegiyli9LG9sqzRr5eq+coiJbVDE3QANI+oplghQjU3LdJTMWAtWxcLXQTH?=
 =?us-ascii?Q?0pMLoPB6tYEB+RCw/Hc99vXRYEU4JtKrD1IitkkJbWfRj+3KEBJv4LJJKlOI?=
 =?us-ascii?Q?snkwC3rAkX48XEKKt8nmcLr58CW/B+aXUcM+SLLv4VonhkVBKqv2h2czBkcl?=
 =?us-ascii?Q?38rNNcyP9c1SEqT91s3nqVb5YKZ1qmDVErip008CGNowr7w3ebU5P/yTl/ii?=
 =?us-ascii?Q?xb35WSKFSw5JsSobQlAxlk/7oDw2P/vtKY2NyBqX7GBvpZWRLpU77XFsPLRl?=
 =?us-ascii?Q?424LfWooPXhwikPFDjiR+ofzkm/YHMF/fNbcrzxERJbyEbTcGUq/JQkLbzPN?=
 =?us-ascii?Q?n21vPt6qxIeEO5V8aSPXUEHivK5FMRHK+kI73u822NOGmWhIGphkRuqnnW+8?=
 =?us-ascii?Q?UGIpJN+9AtsLWj7QYxrLe9BFT7aaszMshZawo1sbYeqjtmFHKIGQKKaZETj2?=
 =?us-ascii?Q?lGGRPQsb6GxlsQ+ixVfbqhkYPDuGb2tXcwpvABc8R80f6Pd9xKnTO3TiHshs?=
 =?us-ascii?Q?uyRcd3AHm3Fg8zWc/ZdLZygyjTOyNpBdr4UA+9vHH5Ec948MPumt3rF8rKC5?=
 =?us-ascii?Q?E2R7t+a8A/gEvflyFZ1RI9CrQ959680ppDFSjDwhN5FeiqcYxYyGxME2fPsQ?=
 =?us-ascii?Q?q7Gx81vP1K6jQZT7eu44c0sH8U6eCg2rZtjhxLRzjKOmJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSJt2eek1sbebXM6lGgxXuXCXwQBXgTCg4dW1GMV4qeUSwsJe04ox2/irGS1?=
 =?us-ascii?Q?snl4Fc7atkOI9E5kHsk/kHhJy4/FMKC0hw8pbwaZ4QZ648gl4rnXzSzvQGxF?=
 =?us-ascii?Q?Np8Hle9CsWFiAiwK9suM5q/zU+zFQqAM8uoKdUHTxJCu5VEAwiGfySo6agal?=
 =?us-ascii?Q?oV+2gIuRXZXWKf4UFnfJoyXuwJ9mdsDaaXCGsaBA3McPEGXd3/bIya+1Hyi8?=
 =?us-ascii?Q?qbzLV1s0LWYXmIT+Oy2Qhyr/aktYQBc0z/+0MWIIHQRVReH7aFwIhd5yOW4V?=
 =?us-ascii?Q?4UDo9fb9JpRK3zofhZxEslS3FhFOgF8NWBj3GnVVGWbifCGFoCMHihNVOQfM?=
 =?us-ascii?Q?e9WoW7U3Gn3Usdxiu7MmV0ZEaminGtV8OQhZchg8Jsefhpsv9q7H1GI69yzL?=
 =?us-ascii?Q?eUpXxNuh75UJaQeITWy8GBDe6HWJjNnbOdb3JNaFnzBSreF7Nlyd4ZtfZ1dR?=
 =?us-ascii?Q?uygTyEG5coj9LF1IsFhazEb9OiNrMzSzwrh7JbsLkRODLPs+4L7p0UDp1aHO?=
 =?us-ascii?Q?8vKbq41abZ299usmoXDjh90aN1USjlGvyrcJwEXtPp4YuqGGWE9Sst2/mhJq?=
 =?us-ascii?Q?w1cqEz+f+i9z33mX7jKjdvd1GNp1N6IybNVIvigWhGD6apSqETPgS0DR5MbL?=
 =?us-ascii?Q?ftLytWQaZzuQsXc2uPv9R5yDSFQyXuY2OEaW05Pai2b9cfW0zts73yzG9EMR?=
 =?us-ascii?Q?fBPNLs1RIkL3b4W3di44VHdEtddORuPUr9Y7nMsxoIIkQfW/ujjJUJuGVLO3?=
 =?us-ascii?Q?lSUUVgh5arvWjcDyh5sCzNc5nT6X/L1w9uAdDoAV0f7xXidXW/EV4Cc7qBR0?=
 =?us-ascii?Q?cmyOgv2nEiLxyoWT/+rztDjVTbIpmOIQqB4ZpOZNjt+YJrBzAUgjNAP3bEEZ?=
 =?us-ascii?Q?krpoNDYRkBxYxTLOYTpXLnSOoQOSAZgeHZ1uiaY0L4EvTtQv3BUe7Y/bdJBX?=
 =?us-ascii?Q?GumtTVMMRKvBFbqwgMLsVEzrXDvTf4okF7Wgo2gli100QG6smkSzIJ9kJCi5?=
 =?us-ascii?Q?TL4u4gD/H6htNqcewexS3FlhvsFp5eQ5o5BCwKPmxYyCTkYGnFcIr0BleyFL?=
 =?us-ascii?Q?uQwgpSFkmqsLL8dEDBZ4PwPypumH8sR+fp4eSkaYCper4CbE+WyVB2q0Kr3f?=
 =?us-ascii?Q?NRJ4LcbXwQftOX5ECPJsM+JpMs1fi1Hncn+3kQ1nj0UAX/7bd30z537wzT7Y?=
 =?us-ascii?Q?ztmflDVsQ55AkreEZWpkIHh8X8wzhP6SozCm38b8gkodYC4vkSJhkT4Zcxdd?=
 =?us-ascii?Q?dyLO6M1rjb7i/6zjr7wrQ+q8vqXlN6AnO2V5vOLRymgV1/7mX5C5FHvSrGTT?=
 =?us-ascii?Q?jZy4i2/bXgiWknbinZzp9ds+d29yas/uYzir15uPkNUOJeEq6hyJr42PxWIU?=
 =?us-ascii?Q?bqZ7T6gthR0iA6TgeXx/ualLqKv5oSah4g1ktmmTVuJMJBffniNGFFRfspx+?=
 =?us-ascii?Q?DZbEdgSNRs4r/aUCJWZlM4xvgmBWMouwufUgaPFauqfD0lyfBaMEKObCLSOx?=
 =?us-ascii?Q?A1OvhfUAR9ZkDrGWPhHKlWgIFhYRpkwC4oj4VaviAdPEUak/ATxQS/hs72JG?=
 =?us-ascii?Q?cxauxSdFqVyFQnHJ/JY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf8fcfb-f33e-4907-8b93-08dcbd2a4bda
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 13:00:54.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjng2S/6Aq/9X4gA/RIuohyCEJEyrWdhbtylQaYOR/6CJoZ39R7BYrBGjjQiHfOC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

On Thu, Aug 15, 2024 at 12:56:24PM +0000, Pranjal Shrivastava wrote:
> On Thu, Aug 15, 2024 at 09:46:11AM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 15, 2024 at 12:42:14PM +0000, Pranjal Shrivastava wrote:
> > 
> > > >  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > > >  		report_partial_fault(iopf_param, fault);
> > > 
> > > Apologies, I sent out an older version that missed returning a value.
> > > Please ignore this email, I'll resend the updated version.
> > 
> > It is probably Ok, the merge should resolve it.
> > 
> > The fix is already in linux-next:
> > 
> > commit fca5b78511e98bdff2cdd55c172b23200a7b3404
> > Author: Barak Biber <bbiber@nvidia.com>
> > Date:   Thu Aug 1 09:26:04 2024 -0300
> > 
> >     iommu: Restore lost return in iommu_report_device_fault()
> >     
> >     When iommu_report_device_fault gets called with a partial fault it is
> >     supposed to collect the fault into the group and then return.
> >     
> >     Instead the return was accidently deleted which results in trying to
> >     process the fault and an eventual crash.
> >     
> >     Deleting the return was a typo, put it back.
> >     
> >     Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> >     Signed-off-by: Barak Biber <bbiber@nvidia.com>
> >     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >     Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> >     Link: https://lore.kernel.org/r/0-v1-e7153d9c8cee+1c6-iommu_fault_fix_jgg@nvidia.com
> >     Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > 
> > 
> > But doesn't look like it made it to rc3 yet
> 
> I guess it's there on as it gave me a build error as the `return;`
> statement was returning void for a non-void function. Fixed this and
> sent it as a v2 of this patch.

Oh I see now, yes, that is the right thing to do! 

You should also put [PATCH rc] so Joerg knows this is for rc as we are
fixing a regression in this merge window.

Jason
