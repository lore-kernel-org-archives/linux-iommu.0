Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785F2F90CD
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509864; cv=fail; b=VeKVQf1mt84SvN9g2TVXWiPHllt7WcjYhcI7AbcQ6XdpkVnNmsbhaWc/c2v7emjhdrlEBOFP4FSrYZyTHIJqJ3yI+F5P/gvWw/JdTNwrSY4SGxa/eWqusXsKp4LZfCgKUj0l0wt0UfUl/rfJfX96i6zju/kNORmuMyvIGkUqqUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509864; c=relaxed/simple;
	bh=Mfak9bLbAUoJ1a93AplhRC+lt+2RRPdZBp70ZGdIuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LYxTymYR10IH1rJSBjdDcPu0lKsKxsKowKs7CLVoEaSyckL/urY7xIbRFU9hiooXzF04uOBQ5CGOgwzoct9STSErWykgVd2kEtC5RzJWXprPRw3CmB+orAPYNezJwN4epqIDvCAzEOVMKvqrQhMpLJimmwcaYFW/Ma7W3mjY4mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QRmaW/jM; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QRmaW/jM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7lGkoXTol6gx8CzQyFndigXRDs68UgCW0ukS1M+xc6nda6VSra+Zib23qu+e8NoH1xT9l+02VK3xztJlJYjkGIrSCPP0avt1aYHhzWmh8eIZUYE7ZWNAWte+fy6yeN+ilLXr69XDym9mL31Wm2kHpK7Z9G2kaJjcUYqYt6cD6mRCN0ECJTycC8IbrMDLvyVkEKAXpOUWhQiFUudTwVi+IpAMVjDgrgNV9J/oft+Wy81LikuVNu6tUKQDSyFYbWZbH52cMvc98O4eMH2rUq29TajX9PQPGVDQM86cspMHgPgXe0huJRivPyIhMPpYMy2Z7u4ZenFkEW5qurEWa6vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SIlaLcaPpJ/IzCTuC9RpQr6WfgFWK55SIkyLieuXVM=;
 b=r2+T/p3JJ597OD9MdIofU07POYmxjlKIc20+tfO3xF2Q6ONhXjpGFAHbA3jPkPRH/MADcpS9D+dDQ7n5z35pCTm4MngjAn19D0Vse7qUS+qUfYQN6LyGxyZe2+RMsKovW8j/xp7pX1DZFvd0SUiVj9HC5Fg1vAwpwPh5Td+8U/4GEckVo/U1RJDb1jFVhRSVcSyyP6nnSB5adcFk/+PDI9Z/IZS9EdKFjPWyuazKyhc+75qQenhiXItRdrQ+NS55ks4aGNhR6ejPK9aqtwNAs7s5FFy9Jomr7VqBZJ1eervdy0ILFqT6phwBFBQ+dBPmwysvp/+3SGwbpj+W6bitAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SIlaLcaPpJ/IzCTuC9RpQr6WfgFWK55SIkyLieuXVM=;
 b=QRmaW/jMM3XiRACh4MPKxJjOEI1ewYo9/Yy2wr03nQHGob3NjH75btpoXjjPT3fjC6dkjC8k1WP/SWerS5Z71xYhcEvOPSAWyiEy/EAE4wsnJpvpsfosWFHYmf9nZ6XMl3MYf4Q8gt4AnqtcSzUSH/PDPYqkyCGIENdwfIKaIO+pNYVz3nScN+lepFh++PpSO55nNMm8pZKDdwotjxOVA2G0U9DD7Vjhrp63QPcvrUXuREdELRLgloguY1eZQrHoBOJ72JI+Dcq+uxsXZwf39Cm80BHZLLaD9yImuxo0Kj3RI78jex3hU3gkW0Qov8WjAk7LS/1jzdIav+uzwEAFww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 23:50:56 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 23:50:55 +0000
Date: Tue, 18 Nov 2025 19:50:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v5 05/14] iommu/amd: Introduce helper function
 amd_iommu_update_dte()
Message-ID: <20251118235054.GF120075@nvidia.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0316.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 48aff765-bf39-49f3-faee-08de26fd5081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7H6TroRyzMuZqKx2OVnlmsCxst82IwB+6qPooVtP82VBCDN4sP1KjluCt3a8?=
 =?us-ascii?Q?qKmEAnpm2d2dFSxr8gweWACtOG//DugCi+RENMA+hJYKhYmJycZlOvKH86hs?=
 =?us-ascii?Q?A3zEeuEnECEKR0qZxTwxf3yOOx76q8ivb6Orl1jQeJ+AVUArYGsW0u0zjHWi?=
 =?us-ascii?Q?jCu1IU/enfFkXq9TnqL3x4L9fDiBC2ei9OcK+MfYfSCY2BOX2OKWyuGxYHGm?=
 =?us-ascii?Q?CeLb+Qmk3Lie/Z5AwgHm0ggvdDSVkT/M3HaTnxJpgeAkyBf6e7NPK0+Cfhww?=
 =?us-ascii?Q?Qfc4s4N+gQTnBUE2CdqQkLmoSJeGRjg+PI71rPHwDy6mUOMRrqYQUGF7HLYn?=
 =?us-ascii?Q?Rk4rNvnCvUUb5FRE2xgqnyeLYNo38IhJhketcckuRWW38wCHJS9mXiwqrjkR?=
 =?us-ascii?Q?A2VSavegA/B2dFkzRu/nXRA59+J+CZeeAYtwkIYwf5vM989J02NJMTYIkrng?=
 =?us-ascii?Q?reiE2BpxBMYZvo4fSh0Rme1ALvbE0Fu7IXa54Te8o/UMMY1WUDhZSHCihyam?=
 =?us-ascii?Q?SGdsvCeLOVM5Ymma8499MfqpJncOwkCI6Tg2egVJ9PkM9JcP4aEQI3AL+pMT?=
 =?us-ascii?Q?rEJXdB/gQJhH34/RkdDIiS6z2eK6bza+OK2KkSBzaTcJfQgjZy7bGNARlk4R?=
 =?us-ascii?Q?JVO4+QQEQpHxSTcuG6YI0jicpiIpYEN2Hb2oPtlOz8dxlVeH1w+j2xgaCIqN?=
 =?us-ascii?Q?O0xk4HMMx21SoBbt9H6ZLf0LTI3EhGLdt6Mb91aDZk0g7XGagWHLQYiDdaIX?=
 =?us-ascii?Q?vPxiG5XqPuxRWwoV+0BdpurXzY+Q/G6xebSB4zA+TlH62pZgUkj9GZNf950b?=
 =?us-ascii?Q?wCrFFgpSv5smwc6DhTokcwTJITUjm7S1HSDNCc6tHRqzBYyK4xpTjJtu+dhn?=
 =?us-ascii?Q?X74vJS3Wr402DFu+0SUsTl3D91NfPrA9yn+EmS5LCQPc6M31f2hbj7NkB2PF?=
 =?us-ascii?Q?4xjZoXrvoGrpl/R4j11sr/CBzBGZxbHQsrMpDBKfwP4/UD29PzMmBqZSx/9R?=
 =?us-ascii?Q?fMzms81iVu0TraBTefdS9i66tNNTJ9AJK9WBZHXwVis7Uw6XWj6scD09ifMK?=
 =?us-ascii?Q?m3EcgCI4Q5XEHwuMz2aEm08ckZy3CM+gre+apekn/fUTBh98YEQiPeyYDVOA?=
 =?us-ascii?Q?k8rqoOSazbVL5Ie16ZqlNxm31V4d5jt8wroT8JdkNT+dpW7FX07OE7WzPruY?=
 =?us-ascii?Q?pGR8MAv1tv5/NC/drA2m57jw2cpgeg1d8nCfPMlXY5bcK24p8mJBhA/ZgC91?=
 =?us-ascii?Q?9HPUHiBeld58jV89YMfMoGAGu7K/R5K898pDBXDhQArIBN3OQ1YVN1OzJTym?=
 =?us-ascii?Q?pGqmxofSJ/zSMtKdhQYit0pKtcCxrrDcUk+ZKImmhtJ4ys//q8ffl4EzmB3w?=
 =?us-ascii?Q?dYxCbo/Q505VMSS3K17iW46TyUDrBOM1fvuvwcAHBBLp2nduJnqVUfaxPO4i?=
 =?us-ascii?Q?3l6AshOSqoY6SEj0KxcCzGwTnGeqqMv3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bdc9xkMr7UBgswOJ9F4xzG3NiYcePN9bVv8DrVujH1TPiMzIyNHaFgWv8R8l?=
 =?us-ascii?Q?PMFiXiuDw4A1wuTQimVtClOlpU9oo1Ql5mpj1Kro/P0q05R7LnpBb9BmnmRJ?=
 =?us-ascii?Q?1IgGWFO1ycamVV2yBVxpl4ug3ZpgX1Pbl1UkZ6paD5oNTXYCewNfcVuBMKWC?=
 =?us-ascii?Q?D+5n0WQvmaQUYYN2sTIoJGpJSc0gpv2McqOcFbEygSrGVFWHD4hb4IbXYqaY?=
 =?us-ascii?Q?3LmwUfudCF3e5UiePKIovm5ojfYVxmEMg9Cqp9GB3N+2cQD92BAYcJ5ZM8uK?=
 =?us-ascii?Q?zOygJ8IsCixP7179e+Hh4EasSxrTzXSROtNgK8NZk97UXOl5hgrlig66bWQn?=
 =?us-ascii?Q?oRvCUO8TTrkF8zXuGluWOucF2Can2Lri54HyiEggufJYTCS/GgOohC2Uai+w?=
 =?us-ascii?Q?nge5Hdj5JKejESTuvteqgvkilK0dEJOsVNmGpykGAxo/N8B2cPkXRShjBtkk?=
 =?us-ascii?Q?necBqMAEkMH/qHsNAM5ShKu2qMxulBLOYPwv2VMBOuzP8jZBUC5GHOFH3ICI?=
 =?us-ascii?Q?9zVhm6KeFvp8bS5biXrLjHGbhUX7Bfur3ToJkMPCzoQBeLPqs/wX2rjpg5VN?=
 =?us-ascii?Q?/AhEe+J2GLDA84jZAFC9Gm9RLhevZp1fHhF05U6cqyKVvFb6nyTrzRn4KzNB?=
 =?us-ascii?Q?iiz0Tdrtfz3zQ4jcW+i/MHghCnPlabZzjOkAGCCmpbOY+BeThKQgDL5+JB5o?=
 =?us-ascii?Q?vtGUp2wueh7MmPIm50gLjbCZ8OD24WXBNctN7Ie5PVuMDCvYstXeNA6OkbOE?=
 =?us-ascii?Q?6FgzDyFF0zy0iIulUB5vcFQmPDgR2IgjJ8qKucMuyP73SuRkjy09lwZmYK4b?=
 =?us-ascii?Q?+9Fz2UYcZ9wFp5hl2TsY8jpK/EfKMS4tvlftTGRn1Yg19A5x/KbpWvVvWkXB?=
 =?us-ascii?Q?0in6F/lZCAUEc+ctdwNXSY5yb7ywSQ26HCiZYoBRErMBn6oFwWTCrlKxj0lz?=
 =?us-ascii?Q?6qc5AxvQlQPafQWvkLqOr3ygkWpglH0KMy6ZOyuEqFknKMM98PJA+lCAmtBp?=
 =?us-ascii?Q?T6nkC5TrCy3Y+zdi3+eNJ57RXWBoLBNCwoa178BbJKgJaLCXlrT/0Ah6iLWv?=
 =?us-ascii?Q?pi+XF+1WAHBs4Lh9s0R12fe3OEd4Y5ak2Zq9wa082BKhi/FWOwFoob9NWGVS?=
 =?us-ascii?Q?LOI9I+A3WZP+H8QvNgQw3600wDIQ0fcrm9YXBxLwcmFmJyR519sYOFrIbUM4?=
 =?us-ascii?Q?UUqG26MUXdkhIc2bnWFeeApJXxu9fZOx4T3oFZc7sGaWXFnptcYoE9D4PqDQ?=
 =?us-ascii?Q?cZoT1STRXa61+VeKGDencnEX/rygYPFN0JY8mMnVi5NwSq4pXSviPMa85qy0?=
 =?us-ascii?Q?GSH8pxD83tldU1T/vYjhJurYQpPSFAzOa0vvZgon4PTpSrqPcjhTXVg5L1iC?=
 =?us-ascii?Q?hfe5Q15v2YzWut2BMrC1hLNoWd5dkPg4+s8hHJOSu46i8vKGFCrK6br0uojA?=
 =?us-ascii?Q?dQfGTcH0/U9S6fPCG0FJPTEPTXODvP9e4oMryuC4pel8rOOdvJoTZunolkl8?=
 =?us-ascii?Q?9/husAU/tbnKkxUwA/FqLyneY2hANLue2cMpJHAKeF9zNgSvx/8aZNE22TCo?=
 =?us-ascii?Q?/YPSOGIC51gxbA7k0PI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48aff765-bf39-49f3-faee-08de26fd5081
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:50:55.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1Ix4wtLPZUvh7u4loJTYFeCEuAIheCFd+MQfdHyXZ3zsqHtCaxdW9LHAFBtBUdy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910

On Wed, Nov 12, 2025 at 06:24:57PM +0000, Suravee Suthikulpanit wrote:
> Which includes DTE update, clone_aliases, DTE flush and completion-wait
> commands to avoid code duplication when reuse to setup DTE for nested
> translation.
> 
> Also, make amd_iommu_update_dte() non-static to reuse in
> in a new nested.c file for nested translation.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  4 ++++
>  drivers/iommu/amd/iommu.c     | 24 ++++++++++++++++++------
>  2 files changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +void amd_iommu_update_dte(struct amd_iommu *iommu,
> +			     struct iommu_dev_data *dev_data,
> +			     struct dev_table_entry *new)
> +{
> +	update_dte256(iommu, dev_data, new);
> +	clone_aliases(iommu, dev_data->dev);
> +	device_flush_dte(dev_data);
> +	iommu_completion_wait(iommu);
> +}

Something to think about later, but clone_aliases is not optimal
now.. Since we have a "struct dev_table_entry *new" right here we can
pass it directly into clone_aliases() which can avoid doing
get_dte256() entirely.

And I don't think we need setup_aliases() to call clone_alises() these
days as the core code is now always immediately attaching a domain of
some kind after probe_device which will write a known DTE anyhow.

Finally, it would be an improvement to this alias code if it worked
like arm and just kept an allocated array of the all the DTE table
indexes setup during device probe time and just ran over the list
instead of repeatedly using PCI functions and callbacks..

Jason
