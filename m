Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515063;
	b=j2x7QTrOvFpK4lIiMl6up8syLx+9YvJeFM7eFAITjatePPZr7FcAAUJT11k8Jx7RsU1N
	 HhOtjpy3PBL5VMY95/u8QmnPa/tKpzSiuZPl2Klc4b8FeTMN7VJ7XicdyhOK5GCNnx89P
	 D9bqxJe+ykwMXFwmEZPpz+9tv7gewvh70ZB8s0eX4ZvTay4GC6sek5iEaSqTHZ/2a/Pat
	 MvDX5rGKBhtYoLTt+0i8/WAr5DrFGBr0hIBkX8UKIzNZOfAOcm/pSTWPehsP14w1Hh5Ep
	 I3KuhaqhhlxtswpzaT9wguARPQ7RvhgfyL/4zJcJR2pHPBDPvwuYg1dbCKp3D6OCvEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515063;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=N/ZvyFEjxAa6mJlQLKQ8Dl01kYcChtstD/ZrbDbDOCY=;
	b=ftS37MhIV2FVCnbYfwVg685vKfZLAOSIZp+KXBhFlmykxFQP5b+GbnfWbegRqJY0xOUj
	 twJYXUJYyuYNKaDYIzsevRE7X2Xo0UPQ9i1Uju3ihZIsreqmgxm/Pl3rLEVXqcuOAHgeL
	 SOVgjE48uFiAwQAUjXrhr6cd2f6Ryu2OO5Gser6cAZkHDNMG5rWc1hRNcO40lWXEKUr2u
	 9c36Zm+U8e2Ea+CWR+dccGqSuK736y+i25GK03UnljmfrWFoCQeCYhGqF6SmEEbOWbEuh
	 9jUUY8ESXWMVp96WZT3XGBfxUcbKjMsCQh+ngpxU1xnSxg/6PZ2bl36YGLf1j4E+E0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="K+S/eo4W";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.33
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92124606A325
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 16:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92124606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K+S/eo4W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEOzAcXk12TkreNuRddkjgTsRGZdgUaikJxZa0uxrR/+pdaAJl8Y2cYWyr/tzMl7C9sJUB0y0PgtY3vnDgXOgAOWCGs3JDoylhkiDY1bYpQW0SP5iEjsA4Z3JGV1YX+8ioE4wQvvOYNo1ze2n6uFLDbwvwIgzdP+YHj3Tp55WVunPnybEFoBT1beWmyTnZs1XP9v99AbHZiBCJuEgZTwqMT6aqj4EHQz8LYHxa5ci07Bz9Srq/KcsqwY7he8T5kxfVkx/DP/CoBX/UiVfEaWTT9Xuf3Oda8UjrIZxzW0g5XxmEYkqBdptB+L92EywK558RCGAIdjUW8nD1Hyx2+3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/ZvyFEjxAa6mJlQLKQ8Dl01kYcChtstD/ZrbDbDOCY=;
 b=BmbvS/TTop9A7Nra6+ACjWBkzSj7/U7t+WcQqvPbYUz/CNIOaCEr7bSbaxoKpN3kqbtb3yiAQv7XVCcAySLHoSoz9xpcXac/Prd1RVwq5hfuct+GMV6iXM6/hsYfvTYXqI6DUXwKZhgibGr6MhhvKd1UzKg8nsfxbXqtb6cQpxsNECQnRmPyxoik5eVVh75d9XOO+OpY3C0Xnr8NcdmZqYahfpxXUQXNzJ+3Sh0ljqr3o0uWtPvHcM9EN7XcoxHjzDMwdW9vdN1Y1WVFHZbMzLA3SDs6w1Re1JAiE8yVPSRz67f3CHlE1Jh26DXszospQp7gRj6XJ7V4nD6SVN6apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/ZvyFEjxAa6mJlQLKQ8Dl01kYcChtstD/ZrbDbDOCY=;
 b=K+S/eo4W6Voii5uKJ0vn4rJy5OXZAd4dml0dNvpjuHFXDydL03BjmSRyOu4EkRM0T6pTZaEoWICbTKk9jVOrZAGMeGWOwirY95ya4TaLk5/PX/sPpiIlf7idqEX4acxTvBk3KEsk+oqWNC81tYYsuMo+YdnatoyaV0RHJuefs8KOqqngqvgHUR7haox7TeS7PkqrL1jDL9FBAuVRS2eG4IxVeYRxBDluImA1C6rqvSy4qqpIldQOp+HcDkmjmbJHRBm1sUsQn0cNjCT1TomoGnMFAhX7vYtwNpkWMTwu/YVpM1HKvhZ+JDc/7zLwlk3N3c0UcytbrLRyIu/rn/uPSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SA3PR12MB603307.namprd12.prod.outlook.com
 (2603:10b6:806:58b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 16:50:59 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 16:50:59 +0000
Date: Tue, 20 Oct 2026 13:50:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com,
	SooJin.Tan@amd.com, chrisl@kernel.org, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
	alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
	guanghuifeng@linux.alibaba.com
Subject: Re: [PATCH v6 18/24] iommu/amd: Init and clear vIOMMU DevID and
 DomID maps
Message-ID: <20261020165058.GF3008132@nvidia.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
 <179210758994.4133959.6615374486960504749.b4-review@b4>
 <9043514a-932e-436a-805d-9694b88d9caf@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9043514a-932e-436a-805d-9694b88d9caf@amd.com>
X-ClientProxiedBy: CH0P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SA3PR12MB603307:EE_
X-MS-Office365-Filtering-Correlation-Id: f81d8609-97b9-4d67-ae2c-08df2eca5129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jc9PoxUG1JsPb9XhEL23LqUXG+OqpGcp+kKvyFlSmOIwqz3t6NNshLLKaUQqFqvMz5fCh8fnVa9Uaq7/0MzA51gLyARNAHTD2gsFpMxo2uahgSJCjNVGicNDNBOW2xV/Avf6SDmYtEyh1j/pAcnIlQJy7pcinULYVaEkq/QLOmIPd8+SnwWd9u/U6u0iGHqF3LtI/X1aNe+55aETgVUoytiLYER+trszLA2IEp6oTcIF35uXqOQ78OvjLf+LBrWSiSmTFMB0DsRR5RmliPGEj1Llp3e+C6cnKLVv8b+bA/EBOlt5Tj+kocmvPTC/iaihNJ12Ovgbi/2gwI1PCRxAFvKdwo7dCkd8XCBlayzXBiPprzmZnc6lLek78v9+bJoL8LQ4b1mTYjAAF01ygcZCG8RrulBxGwkaf4mov+Ajua5F2L7QGnkKhr+L/ymHxnJk7wQQL4MXZCeFT9BLZ5biZ4jXe/LeAYPLBlh0CAeh7QVZoJGkn2eiIjz7DxnsYJgAvrNT5hBGtd1gSv58Sg225GFM8C46YqMbPzw7qW0xIFVZvobS6gVd8M67tgLyFmO/OEG5i/AcYh/e4IkcXbz421OPINkRJ90TFLPDQkF0Wa+5byH1MmN30Hd6iuWyKJjmdCuXXgPo640ZqXHCKiQF354ZRCOxif5CZxY2BAHPo80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iRwm/vJF0nsi72tuU4FVPGQmgbC/NSuHBogWN/jf5SdBsSQQbgBCy1rCAFLr?=
 =?us-ascii?Q?gnWEB5+f9Cj71tsBixZQ7R/LonQtxN6K45sg0qEpfdM9xOYJYppPgIVqegNp?=
 =?us-ascii?Q?2jZLurCSWAIvkZkGoe3iIiuD7dv+NJWVaSQNfxM2Lww6buoVQXMUn3o9h8JU?=
 =?us-ascii?Q?3el41p69RE/bM2U0YNnUWzQDvCx/glS96RYTifu2Ds605zV8Ss7+PqaNMcRt?=
 =?us-ascii?Q?+tyJvD5thCXdwl7qiAz1i1G7qkSyMX/euklBHB+ExlH1VBNPs6m5cZa+A2YF?=
 =?us-ascii?Q?/bf+I20+YIoW/MGB4Mh+vL1f/ixiMn+Xb810moaB0pE/K+vCKSeUqvB50xN1?=
 =?us-ascii?Q?hqJ9oeyNNn5UEooxS0iVZjgPYnR/1dIXnWv+zvO/ab1y4y62jKbgGf2lIAsF?=
 =?us-ascii?Q?oZkmCWQJnIyKEOqnlPo7N3J9oSr+RFaqwzD+MrBxqGmruKfYht93yzptW7RI?=
 =?us-ascii?Q?1ElZrzNM8Te4bEkuZ3RyTebPyXFrRHk38bDAxkfEMp6+/Nfmhm6bWR8l9gxR?=
 =?us-ascii?Q?DbaivHqj5UJfmbjxQ6Wb5rBX0CBz6/e19xtjUetiXOWzTc9hDY+5JBP2bOsK?=
 =?us-ascii?Q?1Wl7d5I0BpH5BoPGdFk+8a7RDluplHhBrEi9MC/neZ0+Nsf3dDkfwCDTBxZW?=
 =?us-ascii?Q?uH97MUwYOJMwWqsKWRycs4rko5IMdc7+jG0PAU5DjuwL6/YM0H/PMJkyWKOd?=
 =?us-ascii?Q?YThuy72RjEBmq9xGFcT1Nr3FUxO2Gn1/y5hS5pnaHlDtoY9QmBNU7Ee0BoAQ?=
 =?us-ascii?Q?nC/0q1FeT6wWaD0EIgpR1yfvIeTERJdUMz2T42fcBViB6pyf9wNtOFsuAiLT?=
 =?us-ascii?Q?UbB1CQH4UOfNeYKHbutBubSoYk4CrWdQQAxQbR6pqvMGhdC+3GWyEtDQaX/7?=
 =?us-ascii?Q?lqJ5ZvOjRaSMv6vOSvJECNiZFOMw0YViYdbm8Y/YJUEqeSWQIBAGdKDzE/rR?=
 =?us-ascii?Q?nMk0hZMyGX7lrYjc8yaAVH7ATALXlQVp2qRUEhnik8i6edE00F5gH0rWFv1h?=
 =?us-ascii?Q?oO2bhxUZIV12K6ESE9WZNdZwO3Ds6PFfNB+PRhtu6VOBli2VC9+DRno6vneM?=
 =?us-ascii?Q?JG1R24IRBuiFRI+TTbzJV4SvDxBmyHQ6G6x8WBPWWy0osEo8cfRs8c3yRdcc?=
 =?us-ascii?Q?NREDZFvMEe9ft5C7Paar9a5rBCuJ+mBRMa1M5My8aFb7vjxv6sAIS1l1vO4v?=
 =?us-ascii?Q?fYXF985k/CC47se6R+pmIf2P/8qI1uMyECLRrdI24ccUNGZDHReCNGEA5Iyl?=
 =?us-ascii?Q?fdJYIgSXVIP8BYvNNHVLweC+sSfnNPAme3OVkH/C4f+vWSx6A5o99yAoRJy7?=
 =?us-ascii?Q?vkvQ4A7moSq2vxVaEl3pHX05T4N0cfAxTEs901GCwgbtPxmM5Sh9EhXRUa31?=
 =?us-ascii?Q?jBJpjt80pZE+svIUcwejCnWeNFHp+IPN/uu0MTd/g3tBb1RkIZ/GY5igVZ9v?=
 =?us-ascii?Q?/3w8HNbLN06w4xRNLvqXMB2S99l1AsskB+78H5uOskUhr+9SIRYRiiJm0b0Z?=
 =?us-ascii?Q?Gp0fTBFvdxBMchLHjfqqJiJ71Whykccy/CVpQtjlAOp/gPOAmPLAUA/x1HzX?=
 =?us-ascii?Q?6XVIPCbyLeOjWQsczPO+Inea6kVCZOQD/NFLPz/ZKU47cB1nMciv6H+P0lxG?=
 =?us-ascii?Q?+0ffHjsmpVoaKoEtkwjLb/lBI95o8hz6gN2521ypqtsRvtN/74jMsOZv5IUa?=
 =?us-ascii?Q?D2VTi9G/EZGcwFBwa8hnYKxos0Mxv3A1Hi2ieL1sVUy1SkAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d8609-97b9-4d67-ae2c-08df2eca5129
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:50:59.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sdoy8jFbLsJAE4q4VaCG6CPJ8U9YiahUPMxH7SZlLx+cnfRZxuInkKHXsWaarUUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB603307

On Tue, Oct 20, 2026 at 11:00:25PM +0700, Suthikulpanit, Suravee wrote:
> 
> 
> On 10/16/2026 6:39 AM, Jason Gunthorpe wrote:
> > > Before using a vIOMMU instance, prefill the mapping tables so hardware
> > > never sees an unknown guest ID. Map every gdom_id to the nest parent
> > > domain ID, and write every gdev_id with hdev_id 0. Init cannot be
> > > scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.
> > > 
> > > Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
> > > resched. Attach cannot run until viommu->ops is set after init_one().
> > > 
> > > On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
> > > the full tables: that would start 128K DMA writes into pages about
> > > to be freed. vDevice destroy and nested_domain_free already restored
> > > idle entries.
> > > 
> > > Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
> > > viommu_priv_unmap_free() on the same uninit_one() path.
> > I didn't see any explanation what happens if the guest issues an
> > invalidate to a gdomid without a host domid?
> > 
> > This is related to my questions about when the IOTLB is cleaned. Given
> > this patch I would expect that once the mapping is removed the hdomid
> > is cleaned and any invalidations for the gdomid are NOPd
> > 
> > If the gdomis is used again it is assigned to a clean hdomid and those
> > NOP'd invalidations don't matter.
> > 
> > Is this how it works?
> 
> When guest sends INVALIDATE_IOMMU_PAGES command with gDomID to vCmd buffer,
> IOMMU hardware uses the gDomID to index the DomainID mapping table to get
> the hDomID (from the entry w/ v=1). Then it uses the hDomID  for actual
> IOMMU TLB invalidation. If the mapping entry has v=0, it would generate
> hardware error in the host Event log.
> 
> If the hDomID does not match anything in the IOMMU TLB, it would be a NOP.
> This is the same as when host IOMMU driver submit INVALIDATE_IOMMU_PAGES
> command w/ an unused domainID.
> 
> For current implementation, the IOMMU driver prefills the DomainID mapping
> table with nest parent domain ID (hDomID), and restore the same ID when
> mapping is removed. This is to make sure that each mapping entry has valid
> hDomID and not just some random domain ID.

I asked what happens if the gDomID hits an entry with V=0 ?

Presumably something bad to motivate all this extra work.

Jason
