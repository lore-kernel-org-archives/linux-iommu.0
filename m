Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1392247A76
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959690; cv=fail; b=lpZK6Dw0yW6nslAbA2vd/d5iEaLTPgpM1332P9ERxzHCd40ATERGqeKcvEqaNpUKMi65KZVfcmlJwZtcla/Ki7oFqfWbnyPmehAif52ln919JaVeK1wVeNN0dQj/7Q5IMVRYxfiqhl9aXDFqq4K6Xp/aFErbSti1P1q+B+iSuvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959690; c=relaxed/simple;
	bh=coGYRfLgwm3qX9fO5kaV2pYHkX4MAzbWJyyxX6032yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hmx78iHwDC4WKzH1CAnrLEm5zdAz1pWLlVwukaah9AmUa9/BrJPGbGXkCwigk4SDq2aqbwKL1S+H25p4DGB0NKQ1iMkzFZuvfWWLcgMsblcDASAvnY5Grspw3AReLHrv7NBA2KVaQkYz70wdevSlzEFhLf090wvVRENK9aEZw74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bvYAYyTz; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bvYAYyTz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB6b77qTNqya0lnPLwESAVT6GFCTztgxHqDfoS4nnh9V+gox1vxqEz8B+Rw5hDLohheo0W3ELuQaudcUsmGAuJE7crUGqgSrlAa85Yzux5X+x/JVza9KjFYdsUc0kDUgybWgFxJH7Wm1hhNvSot5JCD4tAHIOIIZZQpE/VfM9kf4wgpg9sLhxSn/ETbZNICyvPLRFhnXmIjmae8fXBJFxdzV7Ipg1CDNNKF3oGwHz1ESXOEIklxXvq+f7O1iY88k4n9B4ec5GWMcAPX7qWzLKUJO8wfaDS0fDXiqFMI62NB1GMcTQNfy1JC9uXvYXmlihExVeL7VLE1sGFEIgQB7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoqU0lDBcVdLB9w3KsvGWxIGk8WSaycVlKCCt6Grncg=;
 b=OeeEyi2X0cT2Ko39NRnyuz8ZjHGFSMLHu8VWEsoEMpX4+xGCzmj+1qjRBmRZ0avf0fejEb9WdqxEJ3nwGlusRRkyids9Lf3ZgWYZuhHFplO3h7m1uUwYIuKF0GO0cwgvNHQ+0Pb9V0Hydrug6ftjg6wIZGGlq2878QGQnlrc3EEnrOpoIghfG0Wr5vEUyIuRLZ48NbLzmg48wuMoV/oKnoBynG5dDifFEV7fQkb2XjfuAV7HBHBM4kjLVY/Cy7CXF6or0cWXQ7yLKvIf7ozP6mcEGVeO1N6UXDNSJD9HwaWVkcg2SOXl75MnMJygTr5lGX6a4WTo9HuxQ8AZ3y2NRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoqU0lDBcVdLB9w3KsvGWxIGk8WSaycVlKCCt6Grncg=;
 b=bvYAYyTzWS2+zt+B9LqLGZODsatIQY+KV3jZkdse6x3MfHbv0h3UorsQ/02F+szyG5y+++twDXkpDBe6kaGedABvDlyPXwk9LbzrZ/mTZrcqyKGtau8xdJsfmJ3nPHNJAeWJAyA+qMCCwxNKXavhb2HXMchoc3AOYWGrUtZi4Y6FLkYvbxxhqOwftzFZ3J6ZWk8XHYOpOaRCfEe66JdMhjlqFuhA+khkDwk6DY5NE5akbxPAQs8e1EYyrmPLbHjr6hinfd7Mc9G4KdkbqmJH6pidO5NRu+oFVkLdhUlnX6pULQhp7SAM3eCv7zoZ08cZnbo9XWmT6zrOJue/jQudlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 19:28:05 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 19:28:05 +0000
Date: Thu, 29 Aug 2024 16:28:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Message-ID: <20240829192804.GJ3773488@nvidia.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0861.namprd03.prod.outlook.com
 (2603:10b6:408:13d::26) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3149fd-4625-4d89-5268-08dcc860b495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a6Hf8CPWNi6uc6setUKWt/ePbcHSCtGKDm+tcZanBIsYprsixQZSX5YdyLeL?=
 =?us-ascii?Q?gGkNIPn45NP23oU0ikTlJsVt5p0he95l9jerVl3wuCf+5SN/dRdMvNc+bCoX?=
 =?us-ascii?Q?8UHSGQk3Hft4rkWKv4bCZ5o3UN0x2wJiw5nrwataJ8/PZ+y8Hq6FQouW4dSq?=
 =?us-ascii?Q?UPCW7OXCorNPKcbFe3NBlyPJHvTZBHdBfEbOgcjylShN5XqY2qDBUsx+xiAt?=
 =?us-ascii?Q?/+fZ4d6zH30xyWE5p+CJyatuwWZJcx4InPEO6QZOvOebQ8UlZVjw/kxeiAhf?=
 =?us-ascii?Q?rjm96A5Ykoo3y8ZUWicyk3ElScLT5SvLr5NbKOVrekUSOFyJBDDi7+H+jvSb?=
 =?us-ascii?Q?2zU1E3i+cJnmzS3OUJl918OOHAbnNw9DYM7pJW4dE1nHfp8mnkSIEaTLG39i?=
 =?us-ascii?Q?8wM0G3bjMpdKd5EPIKcQXunzaOKEMcOQYMAy5KfGMNOzn00oMkbsjqNmHgkk?=
 =?us-ascii?Q?zjipH5JRq8GenDaDzrz+cf/seQM6El+fBGtm6dvCINuRnKZ1BV1fu9+Q2P2c?=
 =?us-ascii?Q?ko2DjWTKuZYh8smvQ0o25Bt84jUF/tg2+13CrCkeVNWoyWfwKafQYnG+s/yy?=
 =?us-ascii?Q?OZOfevH33BLqIG5cZ9zkzcQgvwT5D5avdXzxArvyllX5mpT8HZFiMOkt5px1?=
 =?us-ascii?Q?8KpoC4e2mpMGwKG4v+eMJfCdBmybPsj56/k0pUxd2V8gaNijJ22cEJxmQCk9?=
 =?us-ascii?Q?MDErFXAu64rVlh4B6HUEx6nVfq68I2UfpSFi5LG6DvsvviKnadAdPg+7P7AD?=
 =?us-ascii?Q?EG9pi0C4jq6W9AEomxR2xdHaGwmNFyGWzhzq2l0Ke7PjH4SNhjiMGwOS1xMV?=
 =?us-ascii?Q?I5iXUbRQ8cztaW6uquJI7Z2sOOcSfKyeWclt1U4AeMAvaU5sWWFqMfLIuhas?=
 =?us-ascii?Q?DINewck+F9c31mUF+WWpL476KPjMkOVZZTCjPIU2CJzzS0FD6Ht7LUgiHQ67?=
 =?us-ascii?Q?/pOsmNvvWjb4d+HK7nVBkeoM9VKD0k0LEkkx0qjAzR+F8WOlJO0vvOdl3v6o?=
 =?us-ascii?Q?/1plXaMQzbHZLygCFMXIdI10370uLd0BOeziknYP3QTj2rdjHaS/DCvHYvEJ?=
 =?us-ascii?Q?ikwBzOh2XBf6hkHp2iFaZ3WWR1HAyNc+KiP2kVIKBGKLjMOFq40cUYLzsx13?=
 =?us-ascii?Q?Ja8bkDnjVOChWcGnQbkOO42EBp7cOaERbHA+umBmFmauEOHbqW1cx1JsPKXK?=
 =?us-ascii?Q?ufg1C5FBH71YnX+SpcJ9EmH02JzvIXS+NdJD1xm8aIM7+51cjxEbp8W0nmfk?=
 =?us-ascii?Q?6r1t/IA30UQd+eICZuSjpPyVYf/ANOvCa27myRQV5cUxBb+iFAM6Ky9Jhx/+?=
 =?us-ascii?Q?mHgkxV+C7voGmodoI5DmAuFZDxBCG6GAPBLntkI4w2lt2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d54/FWiHd+NPObmns9OMavr7L5zHoCXqaJK85iCBoj0dxHXCcaHEZsIiQqjc?=
 =?us-ascii?Q?/Cc7RPbSwDkNRlongSpF/WuILlNdZGM2+Wv8+jemE05cqmiDMB/XJ5qOGu7s?=
 =?us-ascii?Q?RCchAC1bQqodR3sO9Jyd3s6isEDzSMHrT8pjdRTUIndwaYDbF0GcGsFy3bu2?=
 =?us-ascii?Q?uP7o4vidBFuIJcedeIVfAB5fwFiRw08dfz8H4Kb/whqgwXhhQQrgdGFeFD2t?=
 =?us-ascii?Q?dWA+dplG47g8ZN3K6e5zCGVgK92g0e379+ZKY6yyTvjkhpVJFB/F85XGK8+T?=
 =?us-ascii?Q?CwL1VV2u6IrNmDdUaSOXasBTCws1csKg8y5jBcVOQVaAxjbR3y9+arWWyS5K?=
 =?us-ascii?Q?1/RpCoE6hQ3QLiA+CsxOBJSYGWSHJYOcdMaT69CqEGZI4n/B7HIdsLXzsfqh?=
 =?us-ascii?Q?awZrAwDbgUriOOwdhBu8LE93uvEwDyj0SoC8k+mClf8c5d4q2PxthA7ah0PE?=
 =?us-ascii?Q?BQPlk+yMkPeUm07+qXR3Kz2Bw48Q04CVdFt+ivk1DtwxOJlVH3w0aS9GqxSL?=
 =?us-ascii?Q?JfrHm9p7bDWEwx7dnr3lkYXN1c024cKsyDDBr3m1q1os9AbZla3jkfhdQJ3B?=
 =?us-ascii?Q?oG8OEiKuwt1UUR+twjeYqbzma0I2YbkavQcaXZDHXd8V8z7h3eaZ4HW7o46t?=
 =?us-ascii?Q?g34NS+2WeyXYaWWA83vTDTHb/gSWZoXrvN0+TfPeaPuNsy3kvjPaVGQgqKjc?=
 =?us-ascii?Q?J8r53i9JZgknhfjKosBD9x1ruJzdysUGLsOcmHcP8uYfT+kTrvyTUVsnXw2o?=
 =?us-ascii?Q?2vFr+mLXDhecfTW4U8yXsY6Rady69xsdd+nZ0eNE36QorAsj4tadd+6+7LMM?=
 =?us-ascii?Q?wV7x/CmwJFQQEm3B5zdaeKMsiAacw3QhXxwISkDilcR0NxGv2lFlZ4QePZZ6?=
 =?us-ascii?Q?0pfBAErZiNX3hsokiRHHiIMKeAnhp5z12pYQPkWeWozdKbcZE+vwoLZtDuTV?=
 =?us-ascii?Q?048EbrctnlaKc491BTY4ELJHQZngJOLclpDLU5EiQERlbPKeZ2li3A48HYDU?=
 =?us-ascii?Q?tU20HaRPi4WlV10NB0MF26808kY7uPw3PgrSh9yssxdgc+DDOJYtHBC7uaGM?=
 =?us-ascii?Q?uaZ0y1D1hkVFQ4M32bo2Mltw/xwbCoBtcPC4ZIwpjFuJMypJxRLeJ5CbJkyg?=
 =?us-ascii?Q?3VCMc1OJdY6Ii+NsPib3noLn1FFdhdrQc7caZcsg2gddtYP9KEAgOHFOFmJa?=
 =?us-ascii?Q?+OGx+xEfLOJaRNNLRrTb+WIUgkbwyHRNe/75bhLgXJweJBdsTprgITVFfw6A?=
 =?us-ascii?Q?4B0fdIF0M1XW3fy84UJVPpTyAkz+d6YAxNcPbSxQfHBTJ00/lnXpR2bZHYux?=
 =?us-ascii?Q?u+hWRXRXu5DHihP9E4EaD3k8q1CiypUQ5kUlatRR5dV8HH6HvpEZ9AjWf7Vh?=
 =?us-ascii?Q?Mq7QwggMtrENN56+ggnp7Jy7Icvr9UMz6CuMoTDLeaGTSSYpTexREJ8y5cRF?=
 =?us-ascii?Q?BiSpBuWztsVUOZCmSfte6XahW5eqwBLbp/uNn0DygaDqiBPhc+GzDEhjCFxv?=
 =?us-ascii?Q?sN/AGH2Eo35oX1urWH++ZJDSMfoLq5q3EA6c9wfBMlGalL2y4defRLtvJ7Pn?=
 =?us-ascii?Q?sLhqd2NJbGhcjEIS6lg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3149fd-4625-4d89-5268-08dcc860b495
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 19:28:05.3282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQkVL2AsDViSjEauNPk+P7UukFZ31hwOm+adNr32kNYXWew/k0YMe7/rIswGdRPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189

On Thu, Aug 29, 2024 at 06:07:24PM +0000, Suravee Suthikulpanit wrote:

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 994ed02842b9..93bca5c68bca 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -85,6 +85,47 @@ static void set_dte_entry(struct amd_iommu *iommu,
>   *
>   ****************************************************************************/
>  
> +static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
> +			  struct dev_table_entry *new)
> +{
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
> +	struct dev_table_entry old;
> +	u128 tmp;
> +
> +	down_write(&dev_data->dte_sem);

This locking is too narrow, you need the critical region to span from
the get_dte256() till the update_dte256() because the get is
retrieving the value written by set_dte_irq_entry(), and it must not
change while the new DTE is worked on.

I suggest you copy the IRQ data here in this function under the lock
from old to new and then store it so it is always fresh.

Ideally you would remove get_dte256() because the driver *really*
shouldn't be changing the DTE in some way that already assumes
something is in the DTE (for instance my remarks on the nesting work)

Really the only reason to read the DTE is the get the IRQ data..

> +	old.data128[0] = ptr->data128[0];
> +	old.data128[1] = ptr->data128[1];
> +
> +	tmp = cmpxchg128(&ptr->data128[1], old.data128[1], new->data128[1]);
> +	if (tmp == old.data128[1]) {
> +		if (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0])) {
> +			/* Restore hi 128-bit */
> +			cmpxchg128(&ptr->data128[1], new->data128[1], tmp);

I don't think you should restore, this should reflect a locking error
but we still need to move forward and put some kind of correct
data.. The code can't go backwards so it should try to move forwards..

On ordering, I don't know, is this OK?

If you are leaving/entering nesting mode I think you have to write the
[2] value in the right sequence, you don't want to have the viommu
enabled unless the host page table is setup properly. So [2] is
written last when enabling, and first when disabling. Flushes required
after each write to ensure the HW doesn't see a cross-128 word bit
tear.

GuestPagingMode also has to be sequenced correctly, the GCR3 table
pointer should be invalid when it is changed, meaning you have to
write it and flush before storing the GCR3 table, and the reverse to
undo it.

The ordering, including when DTE flushes are needed, is pretty
hard. This is much simpler than, say, ARM, so I think you could open
code it, but it should be a pretty sizable bit of logic to figure out
what to do.

> +static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
> +		      struct dev_table_entry *dte)
> +{
> +	struct dev_table_entry *ptr;
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +
> +	ptr = &dev_table[dev_data->devid];
> +
> +	down_read(&dev_data->dte_sem);
> +	dte->data128[0] = ptr->data128[0];
> +	dte->data128[1] = ptr->data128[1];
> +	up_read(&dev_data->dte_sem);

I don't think you need a rwsem either. As above, you shouldn't be
reading anyhow to build a DTE, and you can't allow the interrupt
update to run regardless, so a simple spinlock would be sufficient and
faster, I think.

> @@ -2681,16 +2732,16 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
>  	}
>  
>  	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
> -		iommu = get_amd_iommu_from_dev_data(dev_data);
> +		struct dev_table_entry dte;
>  
> -		dev_table = get_dev_table(iommu);
> -		pte_root = dev_table[dev_data->devid].data[0];
> +		iommu = get_amd_iommu_from_dev_data(dev_data);
> +		get_dte256(iommu, dev_data, &dte);
>  
> -		pte_root = (enable ? pte_root | DTE_FLAG_HAD :
> -				     pte_root & ~DTE_FLAG_HAD);
> +		dte.data[0] = (enable ? dte.data[0] | DTE_FLAG_HAD :
> +				     dte.data[0] & ~DTE_FLAG_HAD);
>

And this doesn't need all the logic just to flip one bit in a single
64bit quantity..

Jason
