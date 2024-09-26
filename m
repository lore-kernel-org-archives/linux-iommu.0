Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE7172BD5
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380473; cv=fail; b=HSQFyznd1kL2Cm+2TvyIft7b3P7Ogiuk9SNO+DJc3SJ/Fdvxp+t59CR0oJPP3QSofBuBBUcozcX3t3v7FhnIcA2puHC2jbZAx+gkuKACduSf6i1lrDwx4VjV5ou98/ID0zAjv/rC++vmMsWC04riaaZnBgj8TC08jJhDlNXO0Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380473; c=relaxed/simple;
	bh=W9fl647zPmBNOOZfTan+7H24Xncaqphb5SScmPKuXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kJlZ4i5mc7Y28WJUGgqYUcqErNQ+xhigzHcbvfj13Z+lUsMs4q4sq913KI7BPM2AdD6yzRTcz7nfoL9fcoIaDRmprcFicWy9BfxSyPVssizLfxNtvrgBhaRNSFWbEnKxqh/7Ld9pF/E2pfzqW0iArXgtNz9/FDyejR8+9G6y+g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+VEm38F; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+VEm38F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFKVilVnFTY7/daTyYyqlRC4qrfLYHmUmWs124sFMGekzba/mAfxgqwMUsoYXYytS7f7FqOgAT6Ijd7k6Y2UNivqTcaF+bfO1FgWs2zjx9vc6QFvK0ixVr+Rtp9cobaxZ3nfMcPVchiOORV2xy2Rpm3Oo9FQuYa+DPLeKuHfXBH+P7PxG4d3jSy7q+ivQr8v7OHeeOywzxmuqI+NuGANER3aCMRYdTpdOm8IKHtXaP1rrKmsDo66TE78tuNRkw3OZDBzs+1k43ggm2LjDnDnWKmNQ46/ZtJOgP/GZp/RRy8u1s4xISjIae1oOFR0SsAHsaxyE6eZO6qgTvaJPvAvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP4GYzCaaC7+np/C58Zr+fD5vOwbwWWuTi2SIV9B/c4=;
 b=aBQjcdedChsEvdizT6/6nfEDSEYXzPoiPHevz05Gk4SdrGj3eZwozrv5nsmAFtMMLgkTgGPJV0oPdk7rK9o19dhbfa39coyLIlQ+RwFoFdn7z5Xhwd9eTyloGR6VAw2mJofwcNASHQkpYBOPAoqNig7KYxOmxnOBmZDwI93tnWkR2hSQAKeFY3bX7ojp2JF/JBlDP++pMpyqkQtUhtD6R7UHquhNQR6bnEhb5BggwpOOKgOQXW4iZ7pd+HAn2wQqtPkq6mgoHksXXK6UJvkqV8PZMjXMfUMpjJ/y5RvcpxH31SeCQ861uVVnRuuItTK5/n4YXqjC0W4YtdiikxfpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP4GYzCaaC7+np/C58Zr+fD5vOwbwWWuTi2SIV9B/c4=;
 b=U+VEm38FKvrGcPRc4CnDka0WVXhHZDX6wRTWIlpt/ibyx3Q7gTWskBEACdP9Jg45lyM9uSrPaL76QObQcqjVC5m2g2554Vp6XSb4TW6jCMa8tfTh++yatZhbbqQ8kAKu5uC5v85XT2lK/rArksDExoMnPuVra+a5/a/AEnxwtd/cEYqrj5h26sJNz/+9RECFO4ERT8unu7lWNAF3+xMOWJdR6rYmOAItE2k1HoEzppIYUw4bExdO8EV3o7nhiLTzkNI2jyovdmMx0dFCT/9xm67NX81LSZJIoEEfSTj6DtXpTPNUNY6hDRMxBfJS+0BhfJ6wv4HJobypH0NQqnXDqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 19:54:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:54:28 +0000
Date: Thu, 26 Sep 2024 16:54:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v4 5/6] iommu/amd: Modify clear_dte_entry() to avoid
 in-place update
Message-ID: <20240926195423.GR9417@nvidia.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
 <20240916171805.324292-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916171805.324292-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: 78943ba7-652a-461b-584b-08dcde6507e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iC7LloIU5TLGhYDoYpnsLumq0kM8I9tt6opA6bxbRXXP+XvzcZCfTDjr9Tzi?=
 =?us-ascii?Q?EbidvfAjB34FF3K9t5J3GGTn99VTkvUMHfEeGYbQzwT9exVSWb9a4EPyfO1J?=
 =?us-ascii?Q?DFWQFbceQw5qleKPcXYJJsk/UDz+2yKwSZ0vGXmltiiCWo1Ig2OsIHS0rZKM?=
 =?us-ascii?Q?FrfYVt/ELK9R6z2Xbi9aLO9j1BIDEX5D9EfGAblaHM2CotWCJaq0SLQRIkzN?=
 =?us-ascii?Q?4mdh8AqX84y5fWLTzLrtHHyYngr707HDQBXFFNHvjHhXW+Jb7LLWG7y98JHE?=
 =?us-ascii?Q?CM/VWWEfckbxSNDL5/xEFr9s/l/5ZEIey9oHRehPurcl5Lp+6oORTAEe0Pmx?=
 =?us-ascii?Q?nzXk+C/bnbo0VYZbanPsFs3g5blMxL/thphpunfw533fVv6gcM3MB1Wa5LSg?=
 =?us-ascii?Q?8zHXlZji+Fy8IM1qt7l2wVJZKgK7zYfk5p+pS2y/kf5nBD9V+kNiJBgtzKmH?=
 =?us-ascii?Q?xLipyKXsWDBhIVhUGiOsnk3LbMXDNKaLrG+K+9Kds7c4+z+Aiuv2bHYLJel/?=
 =?us-ascii?Q?R4EFQH+ayNGuPBGiDIwEcAt6RoRlZlEFkXl4X38CCPtNT/DOYn/MXD5MLaQJ?=
 =?us-ascii?Q?tFXxwcQWc4GsEiBN9dd000TFqceiUOZwqD01vwY0O26+5WG9E7giWaz0Ssyt?=
 =?us-ascii?Q?zhndEQq7RU89SZ5botsSE2jGbuIRCEHicPaL4bW4hH7ZBN+VVknmyOFF00GZ?=
 =?us-ascii?Q?TbvbnGMg000L8kWcvJY3vJGuWZ1i7X6munNyKTwuyFBDX4Tkf8hP+hMWHwJb?=
 =?us-ascii?Q?IDC50ZCsVrGME4lvvUKoZt7uUVmJ9jeAmaOqX4XLa+EkoNhePxVibk0MBW3k?=
 =?us-ascii?Q?WC1qSa5o5yyCdRuhWakmSz+Boyv3PXzd+s468Sj6rdAgPVK6PZW8hMcWMObG?=
 =?us-ascii?Q?kbIu0AakcE0Q67fs0x15rMXth31NSJNSHVDvFMiG2xg4v66UfjWtnYLnE3LE?=
 =?us-ascii?Q?ye3AgYEkQF3NwQVNcutRhNUbYVQSOf/FtbKNhUpwznKpV80iquJmDe0rwuQ2?=
 =?us-ascii?Q?eQv5UYVQiYG7CBr0qDEK0zgqEZ3pRV9Ow9xgZe0CZ+sR0RPjKPlGFYb1w9na?=
 =?us-ascii?Q?wKMUxNdMjJ0DrsGV0vn3FFpGLeEw190SHEwlm9gGmQNF7QH2AniDiAf2/j92?=
 =?us-ascii?Q?ME4/SffWTg9Np6y6NzfdFZvFFVdOv69zf52UsCLiuVcB1J+KwGMYjRXZDJU2?=
 =?us-ascii?Q?A1EYUrMFcmriF7o6saAXwKNdEMu/rP1X9QbaTAfW/iPTESpoOSE85nfmpoWF?=
 =?us-ascii?Q?dK45pozqiCG7BM2WA7Pa4yN5h/9yN9JYJ1mBH7t30SqWgbgIzhMt1mskn4Vg?=
 =?us-ascii?Q?s97AaR8o3QdOyCxKFDlrJbh6N+yECeUz8JQ2to/B3JT4Nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+KrxJtjqGxCLfm0U8MyP3E4QiAyJINZWrr97ARjg0+mY+MLvrR3g15ld02Gq?=
 =?us-ascii?Q?vr6LtfXb0K/w1d7AY7ekBay6q8yQgDhU4fBhORVEQBkMu7Q3aleibvYj0r7g?=
 =?us-ascii?Q?4UTlRQprhlEoY4Q+JuE07ceS7idJsdwDnP/rh9rtuBNWcNd3iJCHa/nnA1FX?=
 =?us-ascii?Q?gWdsISJryrgtGbhOVC61bEOjv6DyEr5gm1A+gMqeYYuhOetWnJ/3kxHEKaOI?=
 =?us-ascii?Q?8RbPOtu0xhSqX6LwEDdIkx9zJFO5P70DKVFDoSefiP78I485wcrmTETlWn64?=
 =?us-ascii?Q?K0ouZGdx3SS+ZvO7wzjbwjdzxcmLqAyGD2YcUnxZej92EOiVWanFu7vSXdNi?=
 =?us-ascii?Q?20pG2gRCT2DMt9ELVmB3jIFFT8Sy07zFK75yiHfIl9pR7moBTkq5fQVhU3/8?=
 =?us-ascii?Q?66XltU2mLyMOKf9aUd1ii8ecm1XtvxwIlJYytfdKOZMaYMJlUdRU51Bth7I/?=
 =?us-ascii?Q?9r/hAQCPFzl11Vh62znOBxNOhh9DWmgH3weJdk5j2piL1182GtSUuSSAODN1?=
 =?us-ascii?Q?L2DNcA8s6l7Tryxjirzzhn1Qy+ztEx6BMFJVObxGhDS8m7K0WYI6KrxWF1b+?=
 =?us-ascii?Q?zF2UY5nXfiKw/T9ITAjbzQwdQ9EKEwpqQNKGLsgl0pd9DDV95qyK8cbgZqIW?=
 =?us-ascii?Q?8qb5/zc+0jv8hm8qqIPhJ6tk3IsEu59dHZs41K+Te+Wfeay7RtV3Z8lafIWY?=
 =?us-ascii?Q?ltdQaIgUSDvfAVHTShsj3g2WlGWj3rE6ltbrqHw+s2nvqjTQR1Dj7TOLevYP?=
 =?us-ascii?Q?eUcOMENAcjxoDUGxvM0ghKVh0x+bcTlUDAldSUJItN6HN+2Qqutmlf7a6W3o?=
 =?us-ascii?Q?IpdsP6+b/8xtrsa85z7UXFOE3UlOHGzOo75BtJ3+B7+3fiGLpwyTR+efN4sX?=
 =?us-ascii?Q?Dzold1FqAbU2yh22xwB7FYn0UG+UEvDQwfrUijKkA7+pCwkc8zyp8iObWP9Q?=
 =?us-ascii?Q?BaZpP7otsSGdWgGvtI0PEiXJP1aMHCr82AvXz7Hld1CWER1QODpVkwC13w8L?=
 =?us-ascii?Q?WMF50GasQfJZveaKkeGi58zQjrTZ4YReMXoHvH2AObdeAhnhZt9taJPS7FCU?=
 =?us-ascii?Q?m8H2GNOU+A1LV5AzJQ2kvJgT16sBa2v3Z6ZFGHkF2x4ashiYLqz7V3+WbLqT?=
 =?us-ascii?Q?1K4YIHlaXAeZcsYiqw4cMpngpwpqkkFubgv18P8B7IgvfDY16isvOf35Z+WB?=
 =?us-ascii?Q?cedFTeBAe5twsEO0dZBzj3IUg1gdM/Vn/9hvV9ygTvKPqm1Z2hLnPy76SnqN?=
 =?us-ascii?Q?wHwfkuDhecUDb6wAVNowDeeGJhS93OdfNctPbDZavjiMw3XlrWc41tTs00Bz?=
 =?us-ascii?Q?f1mIaxmsZps6eyCBz+MnyP5zCVz5tsOKveG2pS26Soq6yPJn3aPiiAwsgUVl?=
 =?us-ascii?Q?EZ+t5sUowhGeEjQU+25ovVoXQVtbOiJqYKQFGCxKaBdkhE1dCJ0iv4E7GI1v?=
 =?us-ascii?Q?mz/rT4FkZehMBWa9c7vuUf8wb/EnT3W4hWFUy6MaTiakolZmgIsK+DUQnoDk?=
 =?us-ascii?Q?RYTyTi1hW5YbICWa7MXOsL5wGQcwhOVlbvwscskSfBhAW3Jbs2RNjjJaaudZ?=
 =?us-ascii?Q?TSyjQ8+A6sKwXGVBS+76eHWXHag7qMiJ/j+/w/On?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78943ba7-652a-461b-584b-08dcde6507e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:54:28.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ/CxbqLbMBFXw73D37q7k3XJ7qRd8xh+xXOAkbCBW+2MyyS2+nquQMyeG35PL3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098

On Mon, Sep 16, 2024 at 05:18:04PM +0000, Suravee Suthikulpanit wrote:

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
> +	new.data[0] = DTE_FLAG_V;
>  
> -	/* remove entry from the device table seen by the hardware */
> -	dev_table[devid].data[0]  = DTE_FLAG_V;
> +	/* Apply erratum 63 */
> +	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
> +		new.data[0] |= BIT_ULL(DEV_ENTRY_IW);
>  
>  	if (!amd_iommu_snp_en)
> -		dev_table[devid].data[0] |= DTE_FLAG_TV;
> +		new.data[0] |= DTE_FLAG_TV;
> +
> +	/* Need to preserve DTE[96:106] */
> +	new.data[1] = dte->data[1] & DTE_FLAG_MASK;
>  
> -	dev_table[devid].data[1] &= DTE_FLAG_MASK;
> +	/* Need to preserve interrupt remapping information in DTE[128:255] */
> +	new.data128[1] = dte->data128[1];

It doesn't, update_dte256() does this automatically. Just leave it
zero here.

> -	amd_iommu_apply_erratum_63(iommu, devid);
> +	update_dte256(iommu, dev_data, &new);
>  }

I suggest you change this slightly so the flow is more like

make_clear_dte(..., struct dev_table_entry *entry) {..}

Which would have most of the above. Then:

clear_dte_entry()
{
    struct dev_table_entry target;

    make_clear_dte(.., &target);
    update_dte256(iommu, dev_data, &new);
}

And then in the prior patches you can write like:

static void make_dte_gcr3_table(struct amd_iommu *iommu,
                              struct iommu_dev_data *dev_data,
                              struct dev_table_entry *target)
{
    make_clear_dte(.., &target);
    ...
}

And drop all the wild masking:

+       /* First mask out possible old values for GCR3 table */
+       tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+       target->data[0] &= ~tmp;
+       tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+       tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+       target->data[1] &= ~tmp;

Since make_clear_dte() already zero'd these fields.

Jason
