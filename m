Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C74D2F5
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329472; cv=fail; b=Vbvg19jnjYxZ5f+C7+ipewQqol7XfLDKBEmrpalgpoqS52aoV/RQ7tJHrp71LoKaPOfxcMUue1rhuCVazfVuUlayOgWbNPs2aonzl9A0WUNr/XPAGA9/MwaIvtH9HSTZypj51RgEXkcorDFtHMa+p6TiVeM7XKMzdWJv++RuasQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329472; c=relaxed/simple;
	bh=t/Chgw0kV77qgNSvKspBon1Ey6FGUmgnUOh7X8Wd7Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3o4ny+425faYWNPauGiNR81Pt8F7WSAqnrT/GKXz1S9amhkmAZIf9jFSIiwRFxJSSXwiJ8BiAncFkCCF20rKqWFiMDglPN4B/6IlwjTG8RkbdFj6FMR4FHm2ZVJa1fHk09O4fyOUrICvvXNemKeJj5cDZr7QF2WSGD+PzGXs6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4WgGm4i; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4WgGm4i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEryHXL8FzQkl5h3kitt1sXdHMTIPIoh6JfDAyWb9VzVrW1z3dzmcr7RMFi3Ad8emAxoKpOfFmNCenen/2Quprk0ijn5SKDX9WC5/q9uHrWvNSBIT1x1LNTmRjIlIvCLEEPYQwIbJTRfkhKUkwwp5P0tRI9hsk4zDCd90n5mXeyFMw/jUH1VoxV/QKdOQ4xidKMhZgU3r/Sfh45Ahw8ODBKS7MMWISetEJPdvrcsAU6yo1xULdPKQccsa4E48ckfTHAAZ1x8eWkaIZZLK2QFJ1Nt57vP0T5OZWLC/4sGkE7+dg6xd2gaINd/zIDOLMX5YXh5+WlD+ztilrGoMVMf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCag1f2EHGbF65BOpQvkeK8FF0tOHwSFSltMTnfRunI=;
 b=ZZo+EqqE8he8XCpwFFMN647u9CPp3n/OwVWgL/XclHsaC+SA0j/Sj0hmAyhe+IHtDE7zOuvHDgWxiuwtY3u0a/jpoIfu/sB6/th5DqcEI60iuIFHmF1B309viH0Ar7XhJop0kaeSuz1yXHd7kKZphsZ5Zm7EpJV3ousGGROK7ugkSG+iFtgVP7Zosc2YuQEpBdlMdTvawm4Hwb9sn6t3K7EBaz4DcXWS4TObBJwYFjtYn9G4VKDrIxKD3CgbWlKj5jER14pf0acY8pOJiFLOFVR3zQ1/D2hujXyrj+bo7OWAMBGSm8nS0D8mimHUAPocUVWXFgrACAQwyld1TInWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCag1f2EHGbF65BOpQvkeK8FF0tOHwSFSltMTnfRunI=;
 b=Y4WgGm4iAVg3kE8ggtmMVsWrozizacPxRiVtixZOnIPNtVy3Swca6gRbPiWB5H9CBntdz0EZC1Wyr3dKNMYO59r97C87l4k7c3ESvqOw1zXQxU/VqwWNEWcpYDKnBsIVDCHwEEbHJy1Knd7I4usTXmOeidYU2XEYoV3w+ju36S0PX3WNjCVTtR5oa3/n+bQSANSIsNcSaY+ltRF9IKt8rDlhfHONk646BUP5kGVvPn/BoIFLIRHLm+OrJiZtyEYa7i+LXLRRGFkbtOvx8eCPbCgU+qePh81J9YJux0OwZKoXxxM6n2HvukxH1XL1oNXTfhvl4FQR3d2ZeiQ1oyi8+A==
Received: from MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 15:31:07 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:31:02 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:31:02 +0000
Date: Tue, 25 Jun 2024 12:31:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Avihai Horon <avihaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 09/10] iommufd/iova_bitmap: Dynamic pinning on
 iova_bitmap_set()
Message-ID: <20240625153101.GB2494510@nvidia.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-10-joao.m.martins@oracle.com>
 <BN9PR11MB527647553CC48B598BC79C8F8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8f2ba561-5f57-4abc-be7f-26f33124a60b@oracle.com>
 <20240625122745.GY2494510@nvidia.com>
 <3f4a80a7-9e17-43e4-9bc4-c1ca056f16fd@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4a80a7-9e17-43e4-9bc4-c1ca056f16fd@oracle.com>
X-ClientProxiedBy: BL0PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:208:51::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR12MB3849:EE_|MN2PR12MB4301:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1030e6-6207-4667-cf93-08dc952bd21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4fSR8yr3B7dc0tvygy1QoIH5KyYWS0aNp8i0PGKc/JEbhA5XwUHJmyIvw0WV?=
 =?us-ascii?Q?jskjfynY1ViO4yI1VqHjTXuYhRQiaJiaPWvQVB+d4xaDtYEqLcXC5fm4QXqc?=
 =?us-ascii?Q?P5lQr80CclbbXyjhXd8rEKjVWNl1lhs2LOPCx8A6W6rXU9umeSKSZrsmD1Qk?=
 =?us-ascii?Q?N3LlnMj1HP5RrMRWNJC7uyIcnXWD3recNrkh0LYixWpBi8SC8cCGVvKR34T9?=
 =?us-ascii?Q?R89TydTtaiTxN3iISayQ2p2cVA3+QaUWBsI6Wi9P6lJs04MuIoDTaO+sTlCi?=
 =?us-ascii?Q?eTLJkGt7BDaeuyjtmQwyBIElxIMRqkxzRMJh4YNYB6lTbSm+IUiaMr4UE3Ba?=
 =?us-ascii?Q?d+8WHCYVaifir7WH4T6oG7Trwnnzow5Wgz7GORtON9zbqaIrj1X1MJo9X8uz?=
 =?us-ascii?Q?fIql4YRmbDn9g7OGja0r4FCZs1En7JNPv9BGWZCnDEmPVhVH/Ve4YV0Yo4bQ?=
 =?us-ascii?Q?KY8ryCuOsajAEZ7WFemTT54hByX479qkPnBTkf2y6pMuuvwo1e9SjUfmPcVG?=
 =?us-ascii?Q?WDCNTfA4n1kGkqEqWHnheHyjoZNfykppO6lvK+0Ptf8IlXZQWePYBFb4WCWV?=
 =?us-ascii?Q?tqMBPXjVe+D0O9bhaMAhVdaBoAY06F0unLVS4EXjvoJLZqGchs8pFsM1eZNX?=
 =?us-ascii?Q?ZZLOlzJGtJkvjvzOmiYwmRCteCmiTZofkL6+HVLPc0eSapuoscMhjKvftprn?=
 =?us-ascii?Q?VVBZoj9PcUfG53M4tYCQ/Mfu61PrOx9KdFNqMmz/+YZgH7cyofpL6O6LE2yV?=
 =?us-ascii?Q?vl8ukHc6WO7TmjcMEp9RrRt8/hDkwUDcmczbO6mZGrxXw2BraNOix42GJCmr?=
 =?us-ascii?Q?B+iUeOQSFbaCkCFSWZSTBIfLpmfvufIIJV0g4e3dVB3lmeKkTsnEUyz3b3Ix?=
 =?us-ascii?Q?fuevfGbvi37ZzD3a7pG9MdWpkRL/2rvmPHqoYS8jsVAdIsxIKw4imXMdXn4Q?=
 =?us-ascii?Q?Lqmh82mdhq7KfbnUeiDHwVD/6ZRwFGexA3NkQxwgAi8Np/UBYBcx092V2HSu?=
 =?us-ascii?Q?ZppqLgvixU4HeDCmjNVQvHUL4Ltiz2h+VCX+VALqOrefzh6ZOog+aMhPyoLZ?=
 =?us-ascii?Q?MmY0SRxuu68XNxF+U7S56FuKPHJ1nkHQ38RsIMOIllbpCck7g67BufYNP/F6?=
 =?us-ascii?Q?TpQFTKiTtgn8HWPAprD1AgH9xNO5j++qFY3+nygKTNTCsm+5nmx+mhdWx0oN?=
 =?us-ascii?Q?CCcRtrGzj5NlcbPR24PH/+C1dfTmscZQ+M3+XeNsKkYuO6d7gFEwIsVepgaJ?=
 =?us-ascii?Q?KvA0tJZRhUkuOZoinClt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PQhmnIkvStHaCITGcYcvpYCHUPgFRA6EcATublN6ZdC0OIElC/8NX7r9OYZ1?=
 =?us-ascii?Q?Y2sQYxv/Z38jiyAc90ZYmK3A0V62R7pX8rdQ9+RG41SYHm3kCOHQEttGK9ap?=
 =?us-ascii?Q?sjML7sGM95HPeBDbGtLbT6bz2B+Ncsp7uTY+sj8oK5wDSdCLres45X5MPrZt?=
 =?us-ascii?Q?XG7lcvu3UFFdM6nWiZ019YM0SR9KsJaZHnqYzMFXSpF2GsCG+rXs7lviaGWV?=
 =?us-ascii?Q?1KRlHi1SKzoYjPLIZT++RGeWobEue3Y/ezmIo6e22aEXtKUqmjrX/ikEPl9Z?=
 =?us-ascii?Q?JhkV5w3v5I6rOxDQ8fksgquRJcwiomV10QskyjHmqJvig3Wy8bTDqd7GBaJ5?=
 =?us-ascii?Q?aGeLU5VX1rZOT5iZgbirherTEnwKccCXTuoFjMtw879C37fhbIwit36mvBRN?=
 =?us-ascii?Q?BairwYZ56l1xVcF3c17bpZcw6Vd0wguou4SOpBZ1XwiYZGMuN0XhpEUAfuZA?=
 =?us-ascii?Q?AZqCJ+xe1p7uuf3jMcRdWKAf5RjXKd5A54P6i3cJGEvI3dgimKBd/6t74yv2?=
 =?us-ascii?Q?evjGQbpUAlTz1fcSZv4g7UVw23HMELeOycHIlu/yw/Pqv00awLyX9SYadWas?=
 =?us-ascii?Q?+KjOQBCP+gZoTg5sjWXn0zaAM23t0/3d0UW93i8eDZOrijZb5Uc9WWQxq4IS?=
 =?us-ascii?Q?f5y3Xer0IgKGKKEstSbUiKFOzk2te7wrvf1kIrLRKtKElN5FWf6Z3NppwD7T?=
 =?us-ascii?Q?XeXTkgYD/CvdQvphaZVG1tFBnoLyFLaIWT3BSYQVxCeNEhpLBtqKZk+omD9L?=
 =?us-ascii?Q?s+BAjdzgys84cLdN1LTDK3/V8PzZ44HNZ+IL9o7WzxmSPNatiemmvcqusSms?=
 =?us-ascii?Q?eXMucB3OcdMQ9Y3rOMoeqaAWQkzK02EYa+PHDTUVqr639QdFHrR7C7pvW0Tp?=
 =?us-ascii?Q?7kgVbcw1JXLRxmZLPSmwrHgNDGJx0sV6VQ1Fzalj3BfY7dArocIB7N8YdKK3?=
 =?us-ascii?Q?9C9gVNgNpUtQ1mFEFi0/Dp6utt/ewP/ZPskbxxLl1eAS2/LAu+qxyCCuYeCc?=
 =?us-ascii?Q?OKdYMc1e6FWXA8eUGW0VstSNSmWHmSBoBm3957oD6zJaFXI3ilZ85I6y4c8d?=
 =?us-ascii?Q?eqhSqGM+CPD1yYPfIzNUu8y7VAAHVtA1V4CyjGVishP5puRsEuLo6CHbCDVI?=
 =?us-ascii?Q?55zsAWFDiSMggFUOtY5gXuqlGQ/QlixWp3TQWwuuvbK69hNG4IG2PTBANIB1?=
 =?us-ascii?Q?mHBTc/yeegC+6AE+1l42ksuRL4ufZRrnQEClpN1yfktGgDop/RSIrpwLOxD0?=
 =?us-ascii?Q?kCkWkUU/V7x13BF8dA5ex/ytOSPq38GLPI5YHPzpowQtl/inOi/yIT+kJfnP?=
 =?us-ascii?Q?JnkUyRzrmq0zrjJ6Bt5Hqc5e09IlwqcthRuDXxje6IyCPr3OHYy8kY+vHxLS?=
 =?us-ascii?Q?yzxY3VFdLjJvt4g5AzQ/kwFK85eIXC/c6XZBqTryIekaEGm81yq6upYLyfdA?=
 =?us-ascii?Q?cqo4CjERVVq9wnN4fzfjMcT5ZxKAONHzjA5iUHLYry4wUgPKjeP9i+joPKFx?=
 =?us-ascii?Q?kRACXMDjYrhSpMKzR+rC3AvmE0KcMbVd3jmAyzy986t9112PDyhkz7BW7fhu?=
 =?us-ascii?Q?W4rH0toQ1hGFC+ekNuu2xUlURgcF+SAbxNmCGvcQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1030e6-6207-4667-cf93-08dc952bd21d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:31:02.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+TaQEZlkCmE7GcLem1fkxalZq2hji+EbNQ6zQjew8LaHjVATPTJpqMGWOBKZA3I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480

On Tue, Jun 25, 2024 at 04:27:24PM +0100, Joao Martins wrote:
> On 25/06/2024 13:27, Jason Gunthorpe wrote:
> > On Tue, Jun 25, 2024 at 12:13:15PM +0100, Joao Martins wrote:
> >> On 25/06/2024 04:38, Tian, Kevin wrote:
> >>>> From: Joao Martins <joao.m.martins@oracle.com>
> >>>> Sent: Saturday, June 22, 2024 2:43 AM
> >>>>
> >>>> Link: https://lore.kernel.org/linux-iommu/6b90f949-48da-4cb3-ad9a-
> >>>> ed54f1351a9a@oracle.com/
> >>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >>>
> >>> missed a fixed tag?
> >>
> >> Technically it is:
> >>
> >> Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped
> >> pages")
> >>
> >> Though I deliberately didn't add it, because we need the patch afterwards to be
> >> fully fixed in iova_bitmap_for_each() callers. Not quite sure what to do in
> >> these cases
> > 
> > Add the Fixes tag to both is better than not having the tag at all..
> > 
> Right -- but do I propagate that to all the dependencies? That was sort of what
> I was wondering. Technically it's patches 6-10 would then get the
> Fixes tag.

Well, if the patch actually fixes something, even it is only part of
something then it should have the tag.

If it is just refactoring to prepare then no it doesn't.

> cases'. For just classifying the commit it fixes, then I just need on this
> patch. Putting on the second one was more for stable tree, and in that case it
> would actually be all from 6-10 not just 10.

Fixes tag is not for dependencies, that has to be sorted out some
other way..

Jason
