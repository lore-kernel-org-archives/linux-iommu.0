Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6714685
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729210254; cv=fail; b=aPnrAmuFhLoK01im6lEG2okV8VyeNOGZm5O8n0XpeLcHEmJ6X+VftN37QwJM1ZVg8AQL6yZk7vLbeUyCzXrx2OqEHdUnqkbCk0qbjPN8AfUjRWUTrpVMNOw/0xLAdmYCaedqyNHq7ZT2pnboIoaIMVrtEZNH2KhZnAnfPlaawiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729210254; c=relaxed/simple;
	bh=aChRsb49RjU+HptlKujEm6bSzGwwBxK9F362xsMjYbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qil9TXMfSdq7o3XyFfTGM3om9tMsgUdG6uYynpwCJXJv1KvlJf27ESGd2Lz6nLB0J9VeKCPqFfFXaVb7gK6qZE/oHHYC+SGjk5pTkRrkzI5QAONFvjLjl0swt3LRr1/SWH7CKb9Fj/+FA57bxeyXv1SQOcPN6Nh/mPLVvBeFz1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VwN47hXl; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VwN47hXl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfuSza8CPeI7hMxoh7leXU8Sm9weHueNo/0bsomagcy3utbhUOIAkv37KNFPG/v1v2oev3jJGR/c/mDt0d4+CP21s04helFweud4yGbn3rqlqRlRegXI1HkqfKmA8yCQyveHRrVjayZW6qxTAsXl5Js18SNlUYr2Y3njMxFWs5ytZukm9Gs7NilTwn5G/9hC0UWQwjnGQN41DK657XlEwP4yFMLZEsLOAtzMyedtd+pVGrvG+Jf7BRzS90fi2i1B8BSpdnd4YomvndoZU4wBeqBVjYEPl2Rai1XuG1+GhMBgADecIaCAt7XnvB9C3/AxGzAKEsW0b3vvGaCiB8EMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McvmgwS1X8RATsxMoc+YLoNSK5dHUvhF4tNhbZ5WRJs=;
 b=wYKJitluGFWQJGVavv03ta0AI8eqy7rNHFpzFeWxQrOuP31WudrCPyylmeErHpZYDHBwkJ2q4KLRSoet+rbBq01hZg/47782/f+fyO7FcOGrUGh0i3lcMjPmyV+u1GfnCETuNR2Edb/7+g5+CqUzBe6mYnbcVigxk7xuNPASejjqqgXR6fPOe10SXRSaIb6ZL2aFV28RR10NoRMFq4Rpuq6Nsasv0CZUnJBkO0NbjIorycFWAcPg3SioKyJVh6e7JfWL+4ywUuNxn1fgf6IzNCA5usY3CvXnrsyh4GyVMH64DuF0nVlhMbVaXrLVUlLegiMIlCrW2XU3jzzSCpylBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McvmgwS1X8RATsxMoc+YLoNSK5dHUvhF4tNhbZ5WRJs=;
 b=VwN47hXlq7kWyYKxfA7bE8bMPztNPXDvTLITrPY/AdXW/CanXTK3uqvakDzbsuC4aW2GMxbhsZAgtJy0IV0vKRRNCmvIWaEauvY46s4EUYbmP4zcW4gje/qYSD1lGBhSeqY/hUV3zXuS4UYszKWiaYFKwR93Rp/0GQfg5J7+bIibhKJ/zJTC0KUmfL3rzxgfEM617rLD2cMwedQN4dJTEq7FC6A3GF38Cxb6vjPk/sbVhdCJd8t1IyWN+ZcPLnCvq2SRaG6lwfO5gU9bXwTij/snJW64v3HyESOZFAGHNwonTV5OS2CHk1d1eHa5FxoyB4A4cyhpuNOYAUbntmpe8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 00:10:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 00:10:47 +0000
Date: Thu, 17 Oct 2024 21:10:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V3 8/9] iommufd: optimize file mapping
Message-ID: <20241018001046.GF3559746@nvidia.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
 <1728067700-32092-9-git-send-email-steven.sistare@oracle.com>
 <20241016130001.GI3559746@nvidia.com>
 <6fdad0c2-8b6a-433e-9405-016aaee40413@oracle.com>
 <20241017192418.GD3559746@nvidia.com>
 <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4574487-346a-427e-a97d-6e1ee366ed1a@oracle.com>
X-ClientProxiedBy: BL0PR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:207:3d::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4035:EE_
X-MS-Office365-Filtering-Correlation-Id: 014a7238-54f9-4616-3590-08dcef095112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BPJhp8ys9e+El2mA0Vg8SwG9iCynwr0bpECOHScYuCiiOy29DVbQLotjxNln?=
 =?us-ascii?Q?+hQ60EYykqLxQA5gajTEBXWZWHBK2YNW+AMum1X5FONcVeAd/Qpp+UxLEXwH?=
 =?us-ascii?Q?pPQGGuXG3y0MZP7fwbcDUiMmZl9AAOy1lZFonoLq6MSnRyhcqelw/s5t8h8A?=
 =?us-ascii?Q?3C0hqfOvKf9Pec3sRdFIpdlp9PIU3WPHACeQF9rBkfqgxqZSxCTvnra80ssW?=
 =?us-ascii?Q?SW/8PxkAYmhUVugHyzk9FzoRRKW+fclD+NTSyHARgeHMjVoojoeRgc3sycCl?=
 =?us-ascii?Q?bBnieJt3DwzBJo1aBLBsLM6O/vdBbau8S7HeK6HEpgJ30mtxDluGNloUHxFT?=
 =?us-ascii?Q?xaaZyUwvC/92kfByJCksf62oL/HyyktuH8J701F/eY/IJV/WVConKiu3TEju?=
 =?us-ascii?Q?sRxuoXPupgKmtlkGiYxlhfTzC/+TG8LfvqeoPMxf09B1agGbxyCk8Q05+enm?=
 =?us-ascii?Q?fm8tFgzkDA+2b2uMCRJcVEy9dEEGJOHmVbkcFGJFEXyQR48+xgf7bvrgDveY?=
 =?us-ascii?Q?79KPw9o8aOXJiBV9HLJ0rgmVg5k0YUmS8KhqAIAhJ2CTYGZmt14/73vcm/Fh?=
 =?us-ascii?Q?pWw5jchaGE6emYiICfwoLkXXzAZpTMAdhOdqcPLNyuGJqYcwEHF2jWADye/0?=
 =?us-ascii?Q?5SW5RzFyZa1l7SJOD3gC/705R7PRVLxoZQKfsYNQJFh3aZrutbcYMoLfHmvG?=
 =?us-ascii?Q?S2KNuYfjc7gjEMueMLy7GjNMC8dtrEfDBnHqfKfISaemeH1rz5lkAOduMg9T?=
 =?us-ascii?Q?gFywVa+2ld/lqjxgmc22Q9Ow4SKjkpU6owZdbpFbBRKLW6s9+zqbQp/bgdXc?=
 =?us-ascii?Q?89/U8UolxE1D9GbGuX9Wwsjc5sq50fFKeC0B6RtMIckHXVCTit6IHnHsk6Li?=
 =?us-ascii?Q?3LBR9S+Z3rhGV3za/dcgxTlvrtz7JYRU9BVZoDEEFnwjRIjcR6M+8krp8QrV?=
 =?us-ascii?Q?p5TMoNbRpB2KsqrXKDgqBa78hXcX4W/e+3j+m9Wtpz0zAi3vpg++1y+w8/7a?=
 =?us-ascii?Q?O0Ev7jOJFFyS9QlGV2wMc6EZfFhZGGXSMKt0PWoDmtxCz83MZKNzY7JFq7ye?=
 =?us-ascii?Q?DKhkU3j+1k0iS+eGe/H1UN1GcbxDL2WcnOSoDwkk2KhKmrNTlgk88qUPdP0O?=
 =?us-ascii?Q?0RKj1ONZL+eCTIz2Y5MidBOeJ+TjjcO932S+CIcI5pC85Je+oLLF+MwzpDhu?=
 =?us-ascii?Q?L6v0zkbH8vMmnpyQYnrfW7+n2ppA6RKgmawgykqy1hmyxglBNieM/OvYRt31?=
 =?us-ascii?Q?XJRPnm0+S+rePTzu1eBRIPoobtLx1Vjq7q2+X9ZwVZfSShYimpWHallR3wdc?=
 =?us-ascii?Q?50inoTE0n8o4XE+WkYYu+m9l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+RgOUMT3U3mcNattR2dxRXOlBP6b99r/ReO7YxP5Mb2U/LZ8L7dVnfgLI3g?=
 =?us-ascii?Q?pWMg/udHsqP/NFbEY9gN6GnYEeTqQTfSkZOpGTaCRPBV2zRQuVsrLEBxDObp?=
 =?us-ascii?Q?ZqvGb9Wm+HP5zNDYjduKa3vo6sHnR+X8pc+LOsqUapywt8NhjLUbeJKMM6s0?=
 =?us-ascii?Q?yOcsyGnUq6yxKZSaSR6npNd43ep2DmbJJpDqgeSUh4qL7XgAAWZVQFZE12Gt?=
 =?us-ascii?Q?CfMIbGiuI0A6ecETJcBTL3DoVuYAaVnrtinijp82YvLb99PV9PVPCvWXkXju?=
 =?us-ascii?Q?Xv0H3/5BUGEC9Rfg425FPC1ogSslWDH47aZYw8LcUkoDP1LjbwagQHSQ+8xL?=
 =?us-ascii?Q?sGo+eL20iQ4N8KcdmwolR5mGTuQghu0xA6q5rmah/kVSHXoOhrOtqOuDHxf4?=
 =?us-ascii?Q?CQjq5cn8+xI6sjTkG7IfVxRjMmdHdFOHXMJJ15HfuT9E2Mk6NxPXB2T1qn4j?=
 =?us-ascii?Q?eu4kbSGE/7NFTIGT/t4hoAt6l+Ig1KYxGEfqlud8tJnU2wg8LWkG6bvz0qtz?=
 =?us-ascii?Q?94hMXOS5bxd8nnO0ptvh411UXrgvTnJ0dW1zJZZsT07axdVZfZoR6/jbYWEt?=
 =?us-ascii?Q?IrvatxrxSznw7G2oo/FRIG0E9GU2mU/uRDHKdrFEX1n9BMklrGxGCzi4eBcR?=
 =?us-ascii?Q?YPEMLO219dD3el+yTuaRVJO8t5mB08LYZJr5f4ptBjwuU4Z9KBh3TX+CF2Tq?=
 =?us-ascii?Q?plpFTZsdrfRsqqxdiR2719oniYVaZjcTiwptBzOJUN06lm9w5V0eyHJ6Ai2a?=
 =?us-ascii?Q?wn0K/YJcEHT/vOxmKu7vf6CbT8weSiK9FD+1q6cWOZ5dgAug5UJHYDQmq3gf?=
 =?us-ascii?Q?2n83ew8e2kuW55M53xhg+fjt038ZMZOlwU8tIF+L1iHQ8/nGo5mU8TmtVAMy?=
 =?us-ascii?Q?EUJx1Hxp0xUB7duH/z6E8yOMZ1o2k73lQOh1I6vrCnH19cKMo5PYgI6r1dZy?=
 =?us-ascii?Q?ewon4WGe4IRWfN0i/1laCVchA3FelpUmtN5hAOQgoBik/lL1heXe1vz9s1Xe?=
 =?us-ascii?Q?d4IHdE7VZrs1RvD3uZeBA3ilvCE2B5VmXtQjvdfP8A4rqqiLpTcJyp1MJEeo?=
 =?us-ascii?Q?Yw2WWQS0qSbs7lE5ofmFWMnefNeWpAyrJhZSDdpr8CThfYWBRM5OeofQhINw?=
 =?us-ascii?Q?0YNJ83Qe5ARWRujvJHxyVkE8QZqIFM6TzGjKKVVcZaKLn79njB2aNih3/2eL?=
 =?us-ascii?Q?RXXE1uW+3w8tEgVplIQkVsElNC8yc+bcV5UdigiF2egPJ7iPuNLoJgHHdXbr?=
 =?us-ascii?Q?VLX1sNLBAdlH5G3jAQFYJYqNDBEgKGUbJ/kdcs0OrlMRt3aK7XkzPbzOGeVN?=
 =?us-ascii?Q?efXeC16aosoK/3tpozpRgX2K7W65/QhLkWGbBqA1tgs833gb+X+Ok5dXyLFT?=
 =?us-ascii?Q?3Tun4XDYrMFfMSwqM8fLcorhQkuO1SkQNrYVUjho2QeYj1ZGFiA0XySkZHgh?=
 =?us-ascii?Q?0OE0jPUZg/LWI9dGIIpdVoGLG4i/vIZOIToDnRBwTodD1hZ9fWk2XL578TwT?=
 =?us-ascii?Q?Jx0IFO54XLJ5bZNIkNmBdLbuQsHbSE74wDscN0LVyvt7aojmp0zsVJ8jndK0?=
 =?us-ascii?Q?kwXJ65ANR6h4uN4VrWs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014a7238-54f9-4616-3590-08dcef095112
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 00:10:47.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOWf3B/5BiQHrE5sUANkvHc10LkaWdQNGcMvoksok0EO5qmQ960BLZ8Q/A9MMlno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035

On Thu, Oct 17, 2024 at 03:37:49PM -0400, Steven Sistare wrote:
> On 10/17/2024 3:24 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 17, 2024 at 01:02:14PM -0400, Steven Sistare wrote:
> > 
> > > > > @@ -623,6 +639,67 @@ static void batch_from_pages(struct pfn_batch *batch, struct page **pages,
> > > > >    			break;
> > > > >    }
> > > > > +static void batch_from_folios(struct pfn_batch *batch, struct folio **folios,
> > > > > +			      size_t npages)
> > > > > +{
> > > > > +	struct folio **end = folios + npages;
> > > > > +
> > > > > +	for (; folios != end; folios++)
> > > > > +		if (!batch_add_pfn(batch, page_to_pfn(&folios[0]->page)))
> > > > > +			break;
> > > > 
> > > > This function is really weird, why would we have a function adding
> > > > only the first page of each item in a list of folios?
> > > 
> > > It is only called when we know that the number of pages in all folios is 1
> > > (user->ufolios_huge is false).
> > 
> > Oh, lets add some comments about this please, and maybe give the
> > function a more scary name. batch_from_folios doesn't suggest it does
> > something so strange. batch_from_single_page_folios ?
> > 
> > But, still, *why*? If the folios in the list all have 1 page size then
> > why not just add them in the normal way?
> > 
> > I still didn't quite entirely follow what the ufolios_huge was doing,
> > it is what I wanted to look at in an editor..
> 
> pin_memfd_pages()
>    for (i = 0; i < nfolios; i++) {
>         nr = folio_nr_pages(folio);
>         if (nr > 1)
>             user->ufolios_huge = true;
> 
> batch_from_folios is an optimized version of batch_from_folios_huge,
> usable when we know that nr==1 for all folios.

I see..

This seems to be a side effect of processing the folio list twice,
once in pin_memfd_pages() which figures out how big it is in terms of
pages, then again when filling the batch

If the list was iterated only once during the batch fill then there
wouldn't be any value in having two paths.

This seems to be like this largely because the upages_start/end are
counting in pages instead of ulist items.

Do you think that is necessary, or could things be done so it index
based and there is only one loop?


Ie instead of things like:

		batch_from_folios_huge(&pfns->batch, &user->ufolios_next,
				       &user->ufolios_offset, npages);

Where npages is the total number of pages inside the folio list, it
would be nfolios.

Jason
