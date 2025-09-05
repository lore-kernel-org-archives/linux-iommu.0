Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80A5305942
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096766; cv=fail; b=SWKyUO+erqp9ArHs0CP9POl+Ni67NIA/mAbkGFLZgLEqcKGMuLbWbzg+C0iSE7uXzhuhdqcaGLjgmtVW6r5Ovlg/YXbDVKgu0ZviH1wZjqFFQewF+O5Kz24GM++ftQBgrgGotS49QWF2OMwYi+1HBcndU5SE6se655lQP2t+XQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096766; c=relaxed/simple;
	bh=fxqNbWEYM0Hv0cwCd7wlxcivfI7+YnRWOUlmtrN3ZAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fCxNuMWUm4bBuaCDkSyBQ8y8mhv+JJi5ShxWvQrdWbkpIJU5VSNW5rGO0OFhALk5/YOfCPvLB3fvo74ybU+epO5CmGLbNmkLiLGa52d2QkWuzVTh9QQy7x1GV8Ipl6+Ye11xdvxw92uo47e8h0Dl6XqsJ9No4Zc+5ix//X4fSfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UqdFCLqa; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UqdFCLqa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl2JLm1jKAxpXl+z+Zq45fpGphonjb1V0BGvP2JKHpnHE0jrhmKQuk2SZ98d5NQmhTZ1wDJk2rFLPzU+7iy9E550MjuK8F3evHFXXHa+tQqN/P4oiJC9nyQYNbroTB63pzbpv0DJLJ7CCacXHrt7XpwPIdpY/gBUoJ9JFLr0aMuap/2QY40BNiDdP+IMR6BvVwrqroCZ3y2Rv1U/M1i7rrth5tFCiHL4T8Jms5baiWR2u3oJDJtYeGRRtiJUku77DTK3fHrvqc+FDbJ0mEdvWDkfg64yvssdFFKudAv/Q9PK1taqJGi+1a+Pl1DRVRpMZp9MOUCy5sMS0y2eGaocKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MO7PKecVmzNboTkhJ62dyiA908lKX0AxGiUF+khZZA=;
 b=Wt7DF32i8pLU+yoqYHO6eup+0Hd7OPXRxh7SfhcLJfS4N7RK7+YrrETMK4hXm6pXPGghxdEvTv29gb/OTQB1z3Imgm6RgpT+WokR3Ay06LNfc5B1tNmPZq0ckhE/ZMoy/KvzsEZKubmEYENNr1ZqDG+zsboHI6EMsEyC4DSxATaorBVD/8favYPrXOX7Yx5IeO8hWNg28bdehgy2wxsJSeJDt4TAK/7wNnmNduehj2tI0HEK8TRniNlXfIbXRAzcYJnj8L7jWpIpEmHNHTjKDZ9RY6wqwDy/QrAYt4X4zPsvo2IqqFfCKm96xmGLPZmBfUH8NG7p/hi+wHXBaJuT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MO7PKecVmzNboTkhJ62dyiA908lKX0AxGiUF+khZZA=;
 b=UqdFCLqalMt7ISLtYNJRTqlrr0hpjKDmDq9+NdjJ3F1ut3dqmstvxus5mlkzRNWp6R/ijoyDgi0NqlIoldZw3X8wATVakvP4WMHNqn8+nSp0aenZlZC6LJq50nNacd2e3xwrsEiGJXlPLVBfDZRC694I/i/wXZtya7yJN/c+4sh4qytW35kqiFSwc3/i8XkfKYo3lz3a1JMCR/T51fFWbvwmY2gYc1dGDxmeStVbTKtDmwzMu58SNuc6F/sGVbLnYSPK/bMZOMYa6/0KHB8xAyMnqSfVTPqB2mQukBdEhvoVXCSOtuLy0HrKrm9csAt+h/2fspgbWjzmpDsrzKhgLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Fri, 5 Sep
 2025 18:26:01 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 18:26:01 +0000
Date: Fri, 5 Sep 2025 15:25:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 3/8] x86/mm: Use 'ptdesc' when freeing PMD pages
Message-ID: <20250905182559.GO616306@nvidia.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
 <20250905055103.3821518-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905055103.3821518-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0400.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::10) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7f9af2-4185-4c0f-05e2-08ddeca9aa5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blzAaBI6p++GmmaP5XDc4t/ER7b2Xai4TxwLLJ82SpTumX9Is4wTikcjbFtB?=
 =?us-ascii?Q?sO+iRPF7GkXLpcgquIsjgjafcIrj1dCdEZF8uOguEhi0p46PjAVwHJsUCUqH?=
 =?us-ascii?Q?CMEFyUNB8jVIr9BTjPP2fJEyLsZrG2DG5YdpcWtg+eUanSn0/QnAe3Ze2eRl?=
 =?us-ascii?Q?1w7lsLP2wkMHybBcfKhPGTI3gP9CBGbL4d5bV7ZdC2m5XnGMcPEGQyeoXD/j?=
 =?us-ascii?Q?nJI38bKAljwpO3PXGb8cqmQAI1fSgp2ZMTE3btVTeT5WgeFYvKZZ9u4i75LG?=
 =?us-ascii?Q?Qs3h3PilWPX5TftId1nxnrp5p21iIonjx30YIawdqI6kBPxlPA2BZDAXxv9C?=
 =?us-ascii?Q?EeniZWsEqbrSUmfmlQJY5HPhR/J4aPR9YtiN68nOdNRldxbAfeSK8NvLAVop?=
 =?us-ascii?Q?3Z1Q6lxBr8u3j4OZoklnw3HUhy0xSGGlK6c0k39znAdOtU1YxX+BD9vLNIJj?=
 =?us-ascii?Q?Dpbw1phpePPcyPKeMKxUe+DSvbhJpbehoF7+cDGEZKsSbbTPw0VPljtx0doh?=
 =?us-ascii?Q?h3YssrqtgkK6ssOQ/YUd/7nCuNsLR2qKn38tS3Z/MxGXNj4iPj+CWbTyci4P?=
 =?us-ascii?Q?Q8u11RI9l/Hcr03Ory4HiBhmdSH2rNTlKas48gm0BbN5pdlGYNFujlj2VS1o?=
 =?us-ascii?Q?we2+njmgnUIpO3ziHheNSBeaCfdtCtcIARlT8vyh83qFQFa7tcdACF2+JTdh?=
 =?us-ascii?Q?HBjP3lZPkmCIHb6kFsz+yIRcZI5h0CsYrtutK3VtjejXanrLusy5mOHPPudM?=
 =?us-ascii?Q?QxU4G3MpMrmAw819P5djQGDhsyTQza1JFQy6kX2jcIzhNyq+W+5AcSG8jRnl?=
 =?us-ascii?Q?Ny2ahKcCvWK+yQoKu8ZLPsH+rsi6qseqMzU8CkiORnNxtsSbHVj5IyUs82iL?=
 =?us-ascii?Q?1n4wsE03/p+aLHJimk0XZU8gY9lOIJh71WTsiYFBPTWvU+C0/ojnqCHIhYHy?=
 =?us-ascii?Q?L2eT6i+ZlRuJ/lu4KjjZVPtgA0WztvHblkxjyyrxVLdGVc2fm5bcw5bd1FHI?=
 =?us-ascii?Q?afdzaaB+pyQkMx6dMucBP8GDVoM9VfDbNFM4HncIn6mS6JjkKiEQUq7pNTty?=
 =?us-ascii?Q?nSES5WEUoUb1/sLRdwAXhXIFTauylYmBX6He1YxAGHSnr9SgDdbSvmfkrzOK?=
 =?us-ascii?Q?+aZr2fDqgkXkbLuUyH/7GASlilHdhhF2xwfcnqXBlGaxklJoOd4ubzzrqzze?=
 =?us-ascii?Q?E+TTZDZQWowaEoIUTOM2KjtZ+SCrRhofAb1VLGSDgMr8GOK75+hxDvulQQML?=
 =?us-ascii?Q?saqzlbf3TiqO9s+eEoDMKtTuXCK+ZtgOSoB7A8Dfj5h0fQcai09/WFLnHRYv?=
 =?us-ascii?Q?VHItP8gPF5uaKXznV0XlTf7yC1/US/QtdrVpf6ShL5lmSGBcLX0e8NcEkv8m?=
 =?us-ascii?Q?tGsZxfLl257EksoqbDNEuE1QNL2pbKmdWZALdCz3gBDSuLniNBglVElKlNgj?=
 =?us-ascii?Q?BeoAPfVo2ic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVJ9p2dLKIIImtZiWCQ++5J4ynOrurHcJRWurYrG4xfNb3TUw8cJ2FV93wJf?=
 =?us-ascii?Q?r6Qw2p4HawdzNnrz+zZL7geJMcANT+2gSJlNMUIeQdwk1IEPo2Uk0mr1f3L1?=
 =?us-ascii?Q?GjJracliWsW1QUeTguEGUMgynXkMKOG4XNt/Xlt/SRhNQLfncrZBzamegETP?=
 =?us-ascii?Q?m40bSZAeef6Qp4TUaNwomLfNqML7Mle6yjSfN8NcOonV32JGqw4yqT+mugj8?=
 =?us-ascii?Q?s77n+G7vM/hTsfxNomk44BST5UY9MFpsK/hjfeoeZo2Va47jCCp5dit9ElbB?=
 =?us-ascii?Q?NcEI3y3qQdq6obpASvJkpiMgjeWYjKhnCsbsu3coKN8AYJWNmqYMfbo6anYt?=
 =?us-ascii?Q?dKsurHsdXSNdTUC8CrVE/g7WzZW8tiF+dL//OEYLXB2KwdpG6TOzZ3juT4GB?=
 =?us-ascii?Q?TdWtMlwMK+jK3lHlW6EEB/AVjA3Uw7dNnCcvenQEj72786PXLmsNY0bzFli9?=
 =?us-ascii?Q?961jaWkuJwdZl93IemwSfq4MaTyj3O7t3rsxBV3Rh/FjPN4c+0wAn1o+GHeL?=
 =?us-ascii?Q?bvDTZ93o3lIH1YuSTfup5GweN3lUg4RdN7hRXxbdpSkrWtmtJzGWJZG3R3V5?=
 =?us-ascii?Q?PzKQgb6Uqh6s+vvT3OO9TOj0tCX1OieRaha4p4rRhR8jYTnZ0HGlLD8fpqRs?=
 =?us-ascii?Q?/UnEfvVM14xIum8REyPOcvxryTUjrXtQ0dOquHmwBUjhgwuM5GyItOiKd3hI?=
 =?us-ascii?Q?gG1MU3TqJ1x+bw1jb9RLJQhnghf1CLPBYB9hd7AXjViW7jfKTdeCfapI2lYY?=
 =?us-ascii?Q?CdWP/F/65o6bXvHLLl+LJaBqaIVt7JVlxt0lYgU2DMjLY4VHQskof5vjeQzB?=
 =?us-ascii?Q?jVNEQdqncN5SsXw56VFtSU4j6KU50/B7nXakQgJT+nzuROuogvZwrSEPm60y?=
 =?us-ascii?Q?vU8+PQ4TbDaVpFxNbgRGnx2GjAfXszNjqNcp2sudkgtYTEeWcYusfC6G2vVd?=
 =?us-ascii?Q?ciGOr3fwDUHno6NxY9XOe9BOpTvZDjmQ/dWytGHkRbMEuCCWXrVxlOgydr8P?=
 =?us-ascii?Q?PK1qs0ecdAgJJez7vox9dLQqgD5RGznkGMosDjbvJ5DqKK1sRgWjYbxp0vlA?=
 =?us-ascii?Q?pxZ+SSc0j+C2Uq9SBapo16TusgbScfEMR6gsMJDnkotBc+EQ0EH+ALPh86k4?=
 =?us-ascii?Q?t6hnxIpxDOHBm7jvwHQymudhHwlYddwj47mlhZ/WODYaIawyO3rV1aDaTyM0?=
 =?us-ascii?Q?AZSCg5QnpZrWlkOofLWe/ajEFJ1dja0Gxau4bs942t09nSLf8fAp40mHP91w?=
 =?us-ascii?Q?kkv6hNEgHVAuSf5vn0zmSf/ywpM3YJ1I5PMssOmt4O/HnmbitUBb2HQh7+HD?=
 =?us-ascii?Q?0bruXXS40Ep9Y+VLHhWhM++h/3hgQcTZcPjnL6aZPhq1U1qYcalA5XznFdUi?=
 =?us-ascii?Q?kcnVQbIQpWF6NiNyJT3K8klUgeI5Ck/q03KW38sFR2wHWnW+mS9q4w/Dr1qo?=
 =?us-ascii?Q?3JJ0I0jkyke+oFZ+E9dTbcTxNvALSz0JMFhk+87jvu8wC/VBROEVyjXzwBBT?=
 =?us-ascii?Q?bR3v+wB0vJ8JW5HNcb3YynpYJil9pAfxcIyktO0zizkywbcmI33ehOmjqpuU?=
 =?us-ascii?Q?akUd+wA01toxH2bF5U8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7f9af2-4185-4c0f-05e2-08ddeca9aa5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 18:26:00.9872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrq7/mz2znEje9V/ZA3AiCKXBoI1WmMQkUfMnpP+IYKE23GJwE2SGJ/VjNcQ0FQg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

On Fri, Sep 05, 2025 at 01:50:58PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> There are a billion ways to refer to a physical memory address.
> One of the x86 PMD freeing code location chooses to use a 'pte_t *' to
> point to a PMD page and then call a PTE-specific freeing function for
> it.  That's a bit wonky.
> 
> Just use a 'struct ptdesc *' instead. Its entire purpose is to refer
> to page table pages. It also means being able to remove an explicit
> cast.
> 
> Right now, pte_free_kernel() is a one-liner that calls
> pagetable_dtor_free(). Effectively, all this patch does is
> remove one superfluous __pa(__va(paddr)) conversion and then
> call pagetable_dtor_free() directly instead of through a helper.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/mm/pgtable.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Much better

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
