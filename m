Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B01E0B6F
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646067; cv=fail; b=Lq2+uHkcQGyS676Bue1wNFMP5GfT2jKH12JlOGF7PksulRu+sjrIiSJNu2qvGt0IQwvR3raQZ5xw6qsnQGVDvZLG1jvjuST3w/47HshI6wLh9gH8eEHifEMuA/I+VGZ7Qnaiq+klxwuBhOCo0SrxOWzzVjF//rsyAVC+TZ44+Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646067; c=relaxed/simple;
	bh=7eHT+BrhpwBJjAGiJlywqBPjWq2LliQ62XY4ZR4UeGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DcpW6MhiGbOn5+h5ucOxVg8mW3oNF/V8wVPAk525UeZl8mzDKtKVFYihHKAUj9GOfMPUgnotsFtCna1CdaUTZLVGYWMeKd+QZHka39r2+dE8syM5kz+Zf2XukurUJNgwLlMBYukdf8rhxMx1eSsAeqSx5SmS8onGVxmIcckTjh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHY88DqO; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHY88DqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oku7gCEK1AHAfihcSktiP7YmqHOZ1az1/0ff5qmicwrel/kItUiE65yUKIXdxT4djJ9ZZAQi26dSomeVUzi6eIdqtNkZmpUkfP6BowzrwpgNVTZ8SEwm5kQSuJNpxri3AYbYz6MCFJZ5PgR909SONRn+UxHtTxA7lTqbWsmedv9JY4kqjs7OBl8PZib8u5HLZ/CBOwX4DrGfFgSJqiPbxvs/LxVRR3O58CVtKrElPSNf9kXC3OWYW+TNwE10ywPK3FnUpbOyhe+BBCHCPuCh92uI2lhdfxnzVTQKo7Ku5CuLY80jhNC9TRuykULBrwll2qMwpuiWlH9ZfXADBasMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoGVqQ31x9oMBpQzxED63AlLeHx07yfHhcSY6rXIWCQ=;
 b=rrdZHZyCN4msOy1CG27kDahl+PPYfQVy7Ls/DZT7MlGTsOZBnp0QY5tVoIaNHx9WwjVUbONBjxLrOmT3pd6aaaIWiSGCG4swGBD0ekxQJVZXbavqHn5aeJ9GlpTU2TNHKCDgiQWDAQ2q/cLgENtMvpw9yWdr3baP/xsrtbvbP/SKkYArXrakogbUgnDNDeaVwjKlyS6R0ap1e23rkmdZOgYqvGUUgVoODhcO0IQUzJO+TboOBLZTqQ4E9690fyriLD8kfn1M0Wd5jCw/HaKRIoEE18pTIZlIRqwmSm+eNuC/rqGcx914OG7201D+CjVgom4vzBerLd1tJbdDrobFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoGVqQ31x9oMBpQzxED63AlLeHx07yfHhcSY6rXIWCQ=;
 b=pHY88DqO2L7yrtgbWi/TssFT4FBSlPtLupuBYIm+2m096MmJhaVuWFOUtM16g4vjGdWwR7wqMofjCAmevPQl7VDmIKdBUeGSWA+x3NtkKlU3bg974xnhDINPpFQj4hipyUOQJ+bAMk6qakmx/nkEFCSFIbb63+l9Pr/b05m8ac8M5DTjTPjx4pZdRrmNgqNjPgdODjZsH2fqDOirh74xTV04Bcn48B4+/ALgnB1dQKZkioi5SovDd6/oIKIXBH/ufprS9ZsnhlFxzsImpcfN4HVvx5bm2dr16pImYNh6c0xVwcnay08o0mr9OPLlQte022r6OutdF2SyCm3B1rBRUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Fri, 6 Sep
 2024 18:07:35 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 18:07:35 +0000
Date: Fri, 6 Sep 2024 15:07:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v3 4/5] iommu/amd: Modify clear_dte_entry() to avoid
 in-place update
Message-ID: <20240906180735.GM1358970@nvidia.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-5-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906121308.5013-5-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAPR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:208:329::15) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: a896f751-8522-4dd8-ff91-08dcce9ec94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gzauZXMJ6bNEkFOM3rm8fR+hURjYAmWVvSz8KwQCt4Hgw4EFtajP76SeiGis?=
 =?us-ascii?Q?W1j+MMbXZXgC4E26D7A40ylLFkT9VSWk5FvZ++mRqpmDKx+ZMAL6ajczFOaA?=
 =?us-ascii?Q?gd0DSsgQsWRhS7QL3DxPxNj+uWsNWld1nYnP2858aRtH6aglmVww/180fz0f?=
 =?us-ascii?Q?oChLMj8EnHzMisocg0ybTZiVVhYi7o2I0QRvKvVSlMSxuTCawDUWPGpdLYPf?=
 =?us-ascii?Q?gUKvRntP7fgyUppbg0Ov2e1+b1Rrq9CzDpDwfZNcCrIl+AbjoZv8HeKIV9/a?=
 =?us-ascii?Q?Mz0LNuEKLH68v14NP3mfK9Xn69c3AW3YrUE3pU7TRVpEO6k2gDC3lQGdFrKH?=
 =?us-ascii?Q?OscAX5KRgBkT/1vsnZfKJ0RMndw/BQWxdx6KfgSP+k3wOBTXsBpQuBLBQczC?=
 =?us-ascii?Q?prPEbzFZct9Z1dItBrj6D5yNZLHZixbUvlZrBIAL1qmpWHaSw3Oi/P08dy0L?=
 =?us-ascii?Q?4yxOMxpwmW5ReX5NyvP+0MQL76+Zl31FfrYgy5O11wiZ0ov0MnqB1cJ6goLO?=
 =?us-ascii?Q?yk2ZCU7eNmTIDWrg0p+NOzyNASeLSpRDW4YhH+4gLRvcnfdTXOwfufrz2fmN?=
 =?us-ascii?Q?Sz5GLQki08vHjE2jFyr9f2t3rs2QLlx2rj5edIXjNVgFgLf24qFJZmXLBcIL?=
 =?us-ascii?Q?2UWT3yDSYNWMZQGOAZEn4X+rl3z03XY0DNl9CDT5+P5fh/0IduJ/nHuLD2a6?=
 =?us-ascii?Q?5jQYFQI1a7RxiTPJ9Utha9olW1cTEi3sCExmo/vTbrG4myVKCBoBLp2s1zwF?=
 =?us-ascii?Q?oAXMOk4fN+FEDdaWErlnvTKTvWre18tYJDlcmxd9PsKN6opdaKEPk9yK+IVS?=
 =?us-ascii?Q?C31bWBs2dEL1YrmMHw3yH6IGuztlrTq3mDCGDVfuImRnMVPJDM/dV94BR/dg?=
 =?us-ascii?Q?i3D/5sGnjb/zLjQCx828DqsAtQNZ8FqgyO1EXDgC2fzvjGwhjUP3zNyfPpDE?=
 =?us-ascii?Q?6zucls5Ox5QN35ArWT0AM5Yle5c2Imw00776f+J6RT5kk9TgyKyeiIqjQDWK?=
 =?us-ascii?Q?CzE+v1Yhwa0iF4mNQ9yMRKLB6OPhmY5pbBa91+iFb8mRx3N2rjmrytWMAk3s?=
 =?us-ascii?Q?324BcMY16HA+hhg6Zmxj2HyWeSxS+FRBhwUXGf5tjXhU4EV5MSDfcslV0mY9?=
 =?us-ascii?Q?sPj5OkP6Efz6kpoPgePMXdvWArlH0fPR0JUCmdF33jLpZxYxgWoWSsyD4ghf?=
 =?us-ascii?Q?YR6j3VBsFwpFPtE1JfciQyknLGhDlf/+JSrzMxSGYRuRTXfLYYM3HvUVY03+?=
 =?us-ascii?Q?gM28zpETsdjI4oWR5H3andN+BpVFyGRssgqKZ3tiExv1Y0aPEm9B6uXAfOLe?=
 =?us-ascii?Q?T2ajrdiVTxgAzJdrZkOrvaRaCoEiwR2m9YJRrxZxwqCyQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9spjdHcozQfbmFoq+4RPR1EVTm9quUphgM+YnOXYlHA0Rk2Ai87v4F+QSj+?=
 =?us-ascii?Q?gct8IoU7BUhBbk8X13XgWOKaOnckyzHchEQYPDihI8neWJnVY9mc97iU+f2b?=
 =?us-ascii?Q?WP6ZTYTB2eJEg2idHfctWgt6wY1rBWp1QUJ4uGBKKuHh2LT0syt3lcMd+yJn?=
 =?us-ascii?Q?tFX/pYweMfon/g76F996U0s3mLF89nLgdQTlXq7uVMFCIFQDmosFchfDFi5S?=
 =?us-ascii?Q?dLsGwg8p2/XVvzTfnxkW2cz7XGU9xQw1CCVouU6nymDXAT/4r0x9x1KAcO87?=
 =?us-ascii?Q?ptc+BMS+LYMuqzjg3GKK1xS4JyeflytJ47t6JQEaaB4SxkGgtvqYDoNKknzI?=
 =?us-ascii?Q?AF+vIgXzvRYIF1tq6mpzTht0bDyqVcSyT/lET1hBstYVGHnvqa4afufYhMVb?=
 =?us-ascii?Q?7NA/mSaVqcI0VFhB1qWgZie3LhWu6S3tAUQw/IrNVFi7aSmhHqFEoWqK+Hwm?=
 =?us-ascii?Q?o/G/Z91aCZIL63EFCZwzJHvW2/Ggogqb3Aq+JrdhBNjpqY/LfqClSOrvzOOG?=
 =?us-ascii?Q?X5zxvk8NWMbNjJ7x6MHyrIyd6RoWLOFmHsxJ7OTMsd4gXgV/0qUKT1YPXLBF?=
 =?us-ascii?Q?VSKs4O3O80tZrVN5fEXIe2UgR+zIwgpFY99H8/rOlEXZ+V9GbLBPuDhF9ypB?=
 =?us-ascii?Q?1ytP5iSlNN56IHTpXaS3zhHxfAHTSAQBMWsc4/6eJ/zJOSFNIMWnuC318GtE?=
 =?us-ascii?Q?Zh5qeqsMi37wWDEEHOS59/s+gE1LJ6VITRA81u7QhcQqnBWxGK6mRkcVzlmu?=
 =?us-ascii?Q?ql6/fI72fT9PWKzEzIq9ui0fQGEqH2FY7RZVjxU8+d4U0fTc7wSS9+lSzpjy?=
 =?us-ascii?Q?8pmwMjj4FApDVrCYby3vAM2nj4+502tLIgTwj2KktHTBTgzvOkukGZWOtupN?=
 =?us-ascii?Q?7f9rYx51DYCFwUfijAoIO634WicyQ6Ae5xptZuUlJ49wcAdakfU5j50UrD0F?=
 =?us-ascii?Q?0ZJ/OppwwVspjngmna1becrg3vH8FEJx42injdmvub+lI9+jU8Mq6mztOjpm?=
 =?us-ascii?Q?Mm7WyCd1S7nUd8Wb8M4rRXoW4g+YYSunKjlzXm6z+vH9hRdnfr0xDPte2lSb?=
 =?us-ascii?Q?ltRKZAAMhoRiNn5tTPMKjfmUFKlMoQXeTFJzeqN8EwsaTVZbWBL4bnyQMxth?=
 =?us-ascii?Q?XmDZLisRgY6kmzUYgojV6p+YmUW+FBH9kU3dFS1zamr1MOcZTGIuGundiTez?=
 =?us-ascii?Q?USdG8u3ATno7r8IUtbdV2DVCgnW82SVrHOzXwEsetzZdg5x8lEFMBVoi+5No?=
 =?us-ascii?Q?if4MqU0G3pPpfnbgN5TPvmISmYHCMPSe97YTZcYUt4Kd5SFnqLFrWz56M1yl?=
 =?us-ascii?Q?vGgGTqtwwgl87DMfcjZCgOhVmFSN+RSxD5l7ch561ZVGwCZxVDDzA/fEsoJQ?=
 =?us-ascii?Q?c82N+PECDMj7q3z5VI65TtHpstgBXvIP+XXI4MmVXH/vpRPPq6fdXrOGeuFZ?=
 =?us-ascii?Q?0GEvHMdXmdfw9lYybfiUg5+mS2JR8Doh7fA1eAQ6423nwtFVtHRhPvqfyq4X?=
 =?us-ascii?Q?QMt/IedNBou/oVG/eheWIGL5oaKBO6MWcbDTj71cbOBpof4KFVx+bediVjX/?=
 =?us-ascii?Q?t6CHSKShTrknEs6vmPPjjlULnM8ez3XOHersBjEn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a896f751-8522-4dd8-ff91-08dcce9ec94b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:07:35.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 624H/Y4JDxKo1EbErS8SqGohbYA+8ohSjZ7lUAo1ZqxqzUymaCcqHFWutUbDc0qL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

On Fri, Sep 06, 2024 at 12:13:07PM +0000, Suravee Suthikulpanit wrote:
> Lock DTE and copy value to a temporary storage before update using
> cmpxchg128.
> 
> Also, refactor the function to simplify logic for applying erratum 63.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 ++
>  drivers/iommu/amd/iommu.c           | 27 ++++++++++++++++++++-------
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 1836da2d9e60..81a994471a30 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -425,6 +425,8 @@
>  
>  #define DTE_GPT_LEVEL_SHIFT	54
>  
> +#define DTE_SYSMGT_MASK		GENMASK_ULL(41, 40)
> +
>  #define GCR3_VALID		0x01ULL
>  
>  #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index f18ae6c077f4..15eb816d4313 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2025,19 +2025,32 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	}
>  }
>  
> -static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
> +static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_data)
>  {
> -	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dev_table_entry new;
> +	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
> +
> +	/*
> +	 * Need to preserve DTE[96:106] because certain fields are
> +	 * programmed using value in IVRS table from early init phase.
> +	 */
> +	spin_lock(&dev_data->dte_lock);
> +	get_dte256(iommu, dev_data, &new);

I think there is no point in the get?

	struct dev_table_entry new = {}

	new.data[0] = DTE_FLAG_V;
	if (FIELD_GET(DTE_SYSMGT_MASK, old.data[1]) == 0x01)
		new.data[0] |= BIT_ULL(DEV_ENTRY_IW);

	new.data[1] = old.data[1] & DTE_FLAG_MASK
	new.data[2..4] = 0

That is pretty clear and simple

> -	dev_table[devid].data[1] &= DTE_FLAG_MASK;
> +	new.data[1] &= DTE_FLAG_MASK;

Would be nice if DTE_FLAG_MASK was broken into fields someday..

> -	amd_iommu_apply_erratum_63(iommu, devid);
> +	/* Apply erratum 63 */
> +	if (FIELD_GET(DTE_SYSMGT_MASK, new.data[1]) == 0x01)
> +		new.data[0] |= BIT_ULL(DEV_ENTRY_IW);
> +
> +	WARN_ON(!try_cmpxchg128(&dte->data128[0], &dte->data128[0], new.data128[0]));

As before this has to move forward, we can't fail to clear the DTE, it
will open a UAF

This should also clear the top 128 bits, so I would call the
update_dte256 directly?

Jason
