Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C52C08BC
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763402074; cv=fail; b=UqhsdeHk0E+2fQtoX5O7dYbEd8ofviZgrTuu/Vb11TYHxA458zKaGefCynw8MnL1FvfjUe1wAGXJ/wwGAq85hm7twPDSpJ0fTSVYydXrxc6JleZ9B7yaYI3AtN+2HW3lMUJ8AMaPSTXi9SX/8ryM6cAZjMvN238hMdNCahKY9rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763402074; c=relaxed/simple;
	bh=ktY+s8lkpoiJsasHuNtD6grlTX0GJoAD5q3NiP5n4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O8t4GZjp1696sPCc6okR9CCEdt9iWv5nZtx4dFqUVko3JsnC7XUHOg/izSu4ENlXE3N7o/1KC6YiCLItuQyzj6UyvT2fQ9lpI7FYiF2QxS25OhPYUQQfuhkTmJeXNRFQ9ASHyP61nYpGmG5QH4KASfWuXhCJ3OtckTiGAF6pXUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RBb7P71o; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RBb7P71o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2rB1/tvsqyPO4xs7leVQLWTW+GuaYB965m+AYtZogTKA274xBob8RuHSrV+c7399TFCBodwAf4zUSK6vBqieebDtoLsOMqgEfoQiUXW4EE0ZcxwVIusEocFfKivq0p7eI4f3/O/uxDALuPDbTaa+VGXMGkIb1Z1zQEcqEc8w9TxE4TsLB0JP2cqBIm0gGJM5a4/GzA7Vw3JR/52DBMiUj+ZJqL/FOI6tiYJO9ZVxXdnZ9wchwtaO1f8UiSO1MDas5FDU9IfqwnKWDj+Paw/Z+bixaGsDbkqj6ucUxzn3YZv/Vq18qmqnlup5+ZZXh1jq4+l5So+IIePdAF+O7R0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXneJYbncfn3+na4gDkoWfS4+8N0Pxesd2K8OTnvDu0=;
 b=IQek/L1z05Bw/1n4I775KJRTlTnGhsty/Ar54LgoZMwGkLO/RCbtivLwx1K5dG1BgcYy8hUwuoqgnZaQE/Z/hEiiqqK2P78l2cxoJpHTdSB71RZB+1lX3GKamYowLxC9baQWoevkri5ITYJk0aBJqBXw+JsH6+XfH75pZMfb2Lkxxn7qX5OEhVmNfrnO5v/eo7mi52tnM+BeMQZ0EtR5s19kA74KNBSWSfm1Tpt3Xwr+7VHgS8J4ATFYbGqFAkP/21GWq6gjyAeKi18Q/zgD9wmSUxCBFLgNYMnaI0v/rnT4/UwFSoJd0d0Sqtd4cWMy5A576rUeAzEiZwwKWk3Avw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXneJYbncfn3+na4gDkoWfS4+8N0Pxesd2K8OTnvDu0=;
 b=RBb7P71o9XFRNfhYmvuKfMdc2lzvtyWTYIqsWU3GxbZJMx5k8fj40ycpiNNpxikawXQbHGR3hrOXDffVJDYlgVn3oU8OwAdQe1mQ921aKJxUcBfI7Yx1Qg69p4d/5vrtv4b8qYwBh+KWNgf4pe/6DZIyr0BFZ47uQnIMf97a3DaPCJ21Rot9dPtcnht2gNTFcOcPif5HuqgvkZ8hD1Kt+sdOldP7QIWTe9N8VdzJsyuMpnU8DfQyTfLqqdw7nRQJ+0QhOFlWRCAwNvMR3R2lQHg0tU41We2xOtPNdzUtprgZYEDWrnnCXrCYUZU3ZnpT3gIX6AanuSYHpA/LLL6tFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 17:54:28 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 17:54:28 +0000
Date: Mon, 17 Nov 2025 13:54:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com, joao.m.martins@oracle.com,
	alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 00/14] iommu/amd: Introduce Nested Translation support
Message-ID: <20251117175427.GG10864@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <aRZTAgxpA8/7216A@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRZTAgxpA8/7216A@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0310.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 26215ad4-3dab-4da5-af66-08de26025a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tK8i+ddK2w8nOkzJ3/2z6WL+qE/vWLjDd3s6ujK2wIHsFTcTel3nJW6D7iR1?=
 =?us-ascii?Q?b7UdOYSlPydwLfDbjk5dE0JCjvxtYgdphnvhV+uu1rl0dFhEkprKGkJoQTSY?=
 =?us-ascii?Q?gCh7balPw13YGU4QjwWxFLaDgZRkkeEQt+FNhoMv/R5N/wctDSg3QWGJHDEo?=
 =?us-ascii?Q?SuGga8v95njM2y/fLKwjNfOsF6053fU+H4VYuhaKdgrEiOxmz6E+OaTAwg7F?=
 =?us-ascii?Q?ZyPPCpE9Ld1vI+WTS6qTDRgVfcfrZThPzhCQEHUeZE6m1WEA2tcrhEIHl2O8?=
 =?us-ascii?Q?j8GANFwJEoewIFpxpgTKtEaLlJvGxkjEOHB1bkevnCzlcR2qlWhQQr7v0Gll?=
 =?us-ascii?Q?EaTm4zOi/fTKL1b1ZMtKSL0PzaarL8yYzVgcB96ILlfcAGxdPvNRDufcQo/R?=
 =?us-ascii?Q?+KWMu8JskqDQEQrHH3OSQyCeWGDlYRTGnfjtMmBOdNWqLZHc3wdAxpWdjBwr?=
 =?us-ascii?Q?s1HNeJMGIcY7Eob+2sNgWE2depCq9q91qdONn4ikUPiszc2I3O5xJSWA4ONa?=
 =?us-ascii?Q?CiXF3Rzj3SZ/N4WPUIP11EZ+DL/IvnrlJc5lfh4SUlhoFUhLcEcl4D4NDQLL?=
 =?us-ascii?Q?yd8v0f4uRL4Rj2EAeywldj9KlkXIZIro6z+QNE/nBjmdth5vzdnUDeTXEy9y?=
 =?us-ascii?Q?dIgam5OORCDW13uwclmucQ6tMI2hs+w/ez/gbtTZNFcBDwwzspCM7u4WHNCL?=
 =?us-ascii?Q?Ysw8xRbliQkBzrZp/vozu6up77UXWqgCm8i+RAfmR7g3StY+Dyk7/jGRL0Cw?=
 =?us-ascii?Q?nfH8TUTLGo/nIE/QUJdlg1Hw0+10Q8hUBgV/4B40TIs2pEDcsLvV+ZhSfhWS?=
 =?us-ascii?Q?6FsVzMglavHe8hh8/kZyzzNAit6nEmVjTM1GQCY9/E/5Jrbuhj7cLpYNzFXM?=
 =?us-ascii?Q?iBifqwlTOAqp2U0Av8v13TrQ5dCKdu+F2aBzOFH4obSsGXK5eUr2ccNjOtnI?=
 =?us-ascii?Q?DM6cJzwgHNLLCyw2t78/sdSaQPLh/+UBV7woTkFSo8TAPlmR1LwmBHvDGiUm?=
 =?us-ascii?Q?1ffgzrocSrSWZ6QQoWv91kQSFGsCq2Ug8WABbsOMaVDY+IQA8MzECKY67WHs?=
 =?us-ascii?Q?facf4SGrUTFKT3/VmjEDQEEOhXmHzLDHmw9oqvz8Z8WJ9y7J14pDrI+5GxgK?=
 =?us-ascii?Q?0UbRQ7KwwZh0HtCGkjRjV2ChFScrrbVvtFOWjUc9y9qePWMBzHxEfESCAaFk?=
 =?us-ascii?Q?XdAdOrKzQdv10ZxzpwjUM6Kmrt7TE+Xn+gTFizI3ARXAn3wMxp/3smTnfHXr?=
 =?us-ascii?Q?70tEUhqDmuSWqiv3ZtCor+FpYK9C0zQ8ywdOZe5H+4g01C3SFBo5btZe14YL?=
 =?us-ascii?Q?1m77iVD3cl629EsnTwSq2L6haDjIUDCRPM63xhef5FOvjtSAkw5MMbEpqJ8P?=
 =?us-ascii?Q?5AuqzncSb/KaHtjvAtLLkT2jg/0wnU0LMDZI6VW+X2tQkQKmC2GYnrg3jN5u?=
 =?us-ascii?Q?nLsNJnWuhpl/BU6wj57AMbeMq8gtKsyRI6XwqxTA+iJ6uO62QLZmRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ynhBRAMG7Vg9X5b2D/FyBf9qliAWkR4MQZTqqj5OIhv3CD4P90FGwe2u8cA?=
 =?us-ascii?Q?KvZhasqdTBUZbWqLCDuAO6W4I2rPhBFM3EfcqXGUOBinJAkyp1siQML28fBs?=
 =?us-ascii?Q?rMf7znomHjMn9te8VToG8wKFFCvNswPrbtAiJJzFPfudvEbXzD7DWippkxBh?=
 =?us-ascii?Q?TkvsYyd18v2Kti00YzG/35wvAq6gDsW6e7zfib82Y4din9ecNJlw4iPcJyj5?=
 =?us-ascii?Q?wvZxHDTlW6ynHYB6CoN6v6iSrDFdgHJ/GZVvzzf7oaNy/BDf01BiptoRzrY0?=
 =?us-ascii?Q?lqQipSlq1pUxY3C3g6+jK2EF2WsZ11vcz2H/4V3rTlIuu9bJCgRQ9EYtA90x?=
 =?us-ascii?Q?wFWmqfo3tgxjVKa1RIN3wljUqd1QUtDKJTG+nYr1e5/zQ2wME5vg93cXGJmX?=
 =?us-ascii?Q?sQEpTxoYP7FjR5uxv7UhNtv2QC8/LP5v8He2zTJmZLpK07SAZG+LmEwHJhah?=
 =?us-ascii?Q?/oubRDjc82EmOrhkSl38DRLkftPhGeo4/eBIX3ILe3rrtkN59vn4JuGPzTGw?=
 =?us-ascii?Q?WIHUPjx2hjJHZkuNLHUl2fFIir6FTopYhgWCmgIFuXSHDJ3J3pyDO+wXRV7B?=
 =?us-ascii?Q?SEw0cLRxjobFf/tNXkMvNOdPHbqugjYAywJXywkfPFA6pzfKzZmEYCGVnCDP?=
 =?us-ascii?Q?bNygw2ZHEIys0y/3cgiazIFi3g/Sttrr1oZMOGbECM0EaFDgtTssHrpa36hs?=
 =?us-ascii?Q?RVygoOXspiRFn+QEZ8wM/L9pJqzvt/RL84AEwqUhzVdvagjEvIU5LLZdasXE?=
 =?us-ascii?Q?7JRpVmBGfLcxyNGz/UOsavahuqNBslkfwYXFYGtmRZ6fa5CzdYvBv6syNTqn?=
 =?us-ascii?Q?c5mfoBBd7wNfjaCNotqje5+cmegd9EpJFs4hvBuOeNC4DR8Z3h7rZ/cLlE9f?=
 =?us-ascii?Q?jXDsPsvNayzD6gNS1bZdixO9iwF37YC+ESZe6pTrraciYhUSX9AZ9mIezueW?=
 =?us-ascii?Q?hF7twPUhq891a0zx2e/jomY983Awp44sMPnoypWG1h7wViUC1LF+LD53aolq?=
 =?us-ascii?Q?tEbse1erqRACR17A4Z0uw7BNatQ4B77dcXlPvvatjOd2n7m6x4JOZ5HIWZwO?=
 =?us-ascii?Q?f/TZaCrg7C6An6iRn6jeAikUYBQM19yFnZHMMUOXHehzF9kOA7RSCmSNAl6I?=
 =?us-ascii?Q?61b3/P47HbxoPWsMgw2RQA5G00bMdavv/G3kZLqmKJGApnu5xOtKDqmCaaXP?=
 =?us-ascii?Q?+nZPSh/1iOjfrrIW4Dowi5om92kByc4sXiJ34hLda/7Bw9MUNHukxO4AqKOH?=
 =?us-ascii?Q?SgWeeGPvfchggi+v4gnscTom4BWrnMBILwJYKN7PM+2s6T78mxO2ZPg2peVg?=
 =?us-ascii?Q?4rJkq+iOSmnR++Hld4xl9Z5SEa76laxcBH3+Dg8ztLJQ+tYorxSr6evjMfPb?=
 =?us-ascii?Q?7lWHU37T9295epsZ3mCmO8BZclK/jkElUtz4CwLQLJjiv+0ZKP8vjavAnCgd?=
 =?us-ascii?Q?QFhBRc8KvWBwBCMxWCdIEiX8Ul2w/m3dGYX8kGoXS7HDQVqg0DNS4tKUZ73v?=
 =?us-ascii?Q?d3LXRUU7fYjuXkBW6F0+30j0Ee6bJadEwOd8r7x5mxrj6HgblPzEYz4tLY3e?=
 =?us-ascii?Q?kP1x7vvhdtCVnfSNivk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26215ad4-3dab-4da5-af66-08de26025a53
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 17:54:28.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNivGgbQR9ynTpLqm9nHUktPNIHGBcVJv6U4xBs0nSNYqiuRpRi2Gm1l4xdU7/W2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878

On Thu, Nov 13, 2025 at 01:52:02PM -0800, Nicolin Chen wrote:
> On Wed, Nov 12, 2025 at 06:24:52PM +0000, Suravee Suthikulpanit wrote:
> > Note: This series is rebased on top of:
> >  * Git repo: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git 
> >    Branch: next
> >    Commit: 91920a9d87f5 ("Merge branches 'arm/smmu/updates', 'arm/smmu/bindings',
> >                           'mediatek', 'nvidia/tegra', 'amd/amd-vi' and 'core' 
> >                           into next")
> >  * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
> >    https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u 
> 
> Nit: this patch doesn't apply cleanly on 91920a9d87f5 :-/
> 
> >  drivers/iommu/amd/Makefile          |   2 +-
> >  drivers/iommu/amd/amd_iommu.h       |  36 ++++
> >  drivers/iommu/amd/amd_iommu_types.h |  48 +++++-
> >  drivers/iommu/amd/init.c            |   8 +
> >  drivers/iommu/amd/iommu.c           | 221 +++++++++++++++---------
> >  drivers/iommu/amd/iommufd.c         |  50 ++++++
> >  drivers/iommu/amd/iommufd.h         |   5 +
> >  drivers/iommu/amd/nested.c          | 259 ++++++++++++++++++++++++++++
> >  include/uapi/linux/iommufd.h        |  11 ++
> 
> So, this seems to be a preparatory series for AMD vIOMMU, yet it
> doesn't properly work since it's missing IOMMUFD_VIOMMU_TYPE_AMD
> and the invalidation component (HW_QUEUE).
> 
> However, the series does declare IOMMU_HWPT_DATA_AMD_GUEST in the
> uAPI header. I am afraid that might confuse user who might think
> AMD now supports virtualization using the HWPT-based mode, like
> Intel VT-d.
> 
> So, maybe we should either:
>   - leave a note at IOMMU_HWPT_DATA_AMD_GUEST to declare it is
>     incomplete yet, and remove later
>   - keep IOMMU_HWPT_DATA_AMD_GUEST in an AMD driver header, and
>     move to the uAPI header later
> 
> Jason?

Yeah, I like to see this incremental work, but Alex recently raised
that we should be a bit more careful about how userspace perceives
these partially complete things.

I don't think tricks with head files work well, I think what you'd
want to do is leave some critical system call disabled until all the
work is finished so the VMM never has to see a half working
implementation?

The patch to get the info would have been a nice choice for this purpose..

Jason
