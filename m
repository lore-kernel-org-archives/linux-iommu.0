Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395402D46DD
	for <iommu@lists.linux.dev>; Mon,  6 Oct 2025 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762194; cv=fail; b=Q0HTZN505TVmY97v5IWo1xK5FV5uK8mh8hSJ49HwuFcB7wBIdry7krl7XglQqoYSbscXnpXM/GI+jFVFCVJL5sD3imG2AB+UZSqAB2e7MKDrqaMTpEXowpgU22I+ORfXA2TPkJM7sjenXUc+fmm7fFE0qKc93fYcDdE+0Q13poA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762194; c=relaxed/simple;
	bh=WYPfSYudvjPkpgcMM4w3TgY/J4QVGWh1fvog6qNTJxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mktJ56bm9BMKTXP46HGbFDyEj1WzDgF+s5dir5d4K6q4h/Jk6gOUDFLzp+grqbNQg06dmtKtPWUnG56EIDT8GCouRUydM1IMcLwrB9mpGlXDoOKCUxrarn1KSTlicpzL/0sXomdCS1ab0sh8YwNzUcCvCoE7vrYza8cii40WCjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W2oDqxtG; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W2oDqxtG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5EEn0n+FZ0C4qLAJBIcZAEVcBsYK5iaFUS5v3yuhQzKijpUSbysfvFXq3LkfE8b23TiYNoyYWhol/8oh+zVlPLvmEh2xMu3pK5Unp/dnn8smSQtNwFYyJ6+o2wdelTe4Qsh036JGsMIqwl9SPTdro6llyU8H41jhsCzElloDMsyFyAf/NKTwLJw8M03MvgpB2xhliSLTlWgLcf60rAN+EpDA9qpiNJYnupVq3sUHQxFSnyqzb8t5LuBizYBesLeN00M0cZaoyUptMxMLLLkLiz7ep6uCg+fH5idz0ydBBiDtGSepmzT3trGqKFwzDItRSzLPNtIp0mirEuaOXeU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrdTp8CsYlXoAw0epFAW349kcbRKtcf1Qd1jQbu4ZrU=;
 b=rvbJ/bYWJ3wHhrLM71xgK95tB4peGSympWAu4WXBDArEcWMp72hsvraQMvgrVcMNjivPfa6SXQuPlYzedtJKfOsiSf/RsiVTQReh2QljXG2UMsyNfJYx6Sg7HE4G1dbPIN/drHc4sY/Wmo0+IIkPvVzIUC3jGVJ4cq09H69WGtD6zpGCYtLY11iVRJAoKnfY3DFrXx9WgS/TMKjNX7sI5Shp/5WyOytuDZyG85rGyS0e84dsN0coUdSgB7kAETS+Jw/7KEpBdwGlrv5i1umUEwXsdzk+KhG1NGuqpBSKPBcjthaRx0Tk8cJznWyvciOsF8W1tU7VQLxAk01ZWTv5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrdTp8CsYlXoAw0epFAW349kcbRKtcf1Qd1jQbu4ZrU=;
 b=W2oDqxtG1CAILH5/6GX0exd4yS8qv8r4Ien9RNVmHmSzvw2rxB6kALZP+IR/ZQucc2CasulJ4lU0YxruQcpG+jqHo+KhPq8gROVgf2/vS2Ori9hnv+rwo4gaozAVAYOCpShycCnN0ZyWSpcdRc45/6RgMALYoVUHzGg65iu6f96SvLBuAsHU+tOSvq9s2b0QlT7uNnoJiDZc8hy0Mrji3tK0eqWb7Wd9dKN42YlPbaoNmObyFVSzFCIq+PI5EnjcOlRPepELbJvkGXTRENTRid2apHqGkbqwPw3Pf0fkosYjyKbHy2l+GYH1OBt0ytiyHfqZrqnoCiPJMg6jvgnTzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:49:37 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:49:37 +0000
Date: Mon, 6 Oct 2025 11:49:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v2 10/12] iommu/amd: Add support for nested domain
 allocation
Message-ID: <20251006144936.GS3360665@nvidia.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 214959b6-df25-4cd5-aac5-08de04e79299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EScj7f3shcVpivU9KFeV1PhDRpkdE1fJTjftRYtr+IFNHoTqXFTXFOMYRjfT?=
 =?us-ascii?Q?VIdqXgxqZvhAYNSsS/Kagf+2VOekjwiLQYI7au4q/ARnKGCZD7ZjBi3l1fzq?=
 =?us-ascii?Q?aXCMpqenMPO8scJBk3i4xbRIM9DKiY2aC0Bl0pV2a+kppzVmYHC31TuI4N5H?=
 =?us-ascii?Q?KBylut+xEdsqIkCyywNcEK/Bj4xwYuCJoHFJfl8JK9Rg0LTvfPvVcC+2W5CZ?=
 =?us-ascii?Q?XcMOXuN2nkAZO7JgutTVNYUk2evUkbfvOHmBVRwUu56kqMCrXelFnBoF8ROa?=
 =?us-ascii?Q?tZqHG+tEO/l/lgMFA0zlwFRFSL/TIzCg4LEMreYiej8GKs6o0Y+2z1kYXYFr?=
 =?us-ascii?Q?0lo2QCSM+01VxHZNcAeRH2GS/QN5jPHKwRgqCa86gCiy7OJv3WFzJPU5W1oU?=
 =?us-ascii?Q?lf2LWnWAOEaXorwx45sgmdSnObOictO65t/ROERNxEVRWxOweF14/fCUH6IQ?=
 =?us-ascii?Q?6XyiZ58eJraTl8lH+C9J+zhh95ayTuk1gmlMn0yM7Itn00UY7zv6XU7izWVb?=
 =?us-ascii?Q?5IP57I/r/xiTE6GLcd1IpOoe4Adp9pTWWnrh0DsLEAa9DygpkIWV4ZQBg7uO?=
 =?us-ascii?Q?jaQ6twCOB6EKBYrdhVWUpkVti3rZ1hqz04FKYCGeJpYEYp1WfAycWag/2TJL?=
 =?us-ascii?Q?+LxRpvUvdDKn5yx6HCGSOV2haikUXI5pk7IJmELLIf4+tcxailR2DA0x5bFC?=
 =?us-ascii?Q?TAz79oOXrBsrm79JTsAtMKoOA1D4hVQCt2FSY5pvi26sqrXqv6LSwCQvQuy7?=
 =?us-ascii?Q?barKRvbqg3Ii6FrEEo7GEtInVzBdgA7OLS8ez+KKKwN+CRyFKkFu5e2iPeGD?=
 =?us-ascii?Q?fsPg5qyXvUye+owQ9WOl7jm757Nv7cC64eVl/oNfkCK9znHlNHiz5ORdOx2O?=
 =?us-ascii?Q?mCVCVNOpOaPcnr+ii1mcv1i/8+0fC7YvKHFEBQz/kHVJMAcr7qPf6JLxtujv?=
 =?us-ascii?Q?CpXdMVdTnZUqVIHrLDt9Be7qObAq0IoSj8fuj+SA1lD511wGBfL39sonRlNF?=
 =?us-ascii?Q?4dYj96e9mpvQA4AQgyy1WqA87Uu1+MNIePXiXjxLXJy0Tsg8Ynje9kcWtn2P?=
 =?us-ascii?Q?/v+DwC3s57iMRGmLoy5Q6/Lz5D68qYTCEgFiYFgyolIE9OQeKrg9ZUQ8xuZu?=
 =?us-ascii?Q?3qjmFWMSAxGYgbEQ54Fcq5k9PuRdKXquPSo90LPisn+JEnVOzNrmetWFvoQL?=
 =?us-ascii?Q?y//AaaD1uFWLtisw2+IavtRMASAX2m313mfDd4siVlWipL4Kq99YiTKhvHmG?=
 =?us-ascii?Q?xA+Y33cCCANJreQL4NhvhhGDSK4EMCg/DLuyQo4J9l/3kf0ExnojlSmXq/q4?=
 =?us-ascii?Q?Fc9ORInk5uqsD2DAD8j4InwO5rCATFZupWIdHRnAxNh40dnK+fhRIhO/g0HZ?=
 =?us-ascii?Q?TvEwi6Rj1ns7lqQMdfgDAztuWMNCtdxd6sBYYtGLVpAaA43rDrNPh2Mll3az?=
 =?us-ascii?Q?bCnHzUCCpROqukiDwUpRMJY8d7o44V4S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g5mwO03SQUVrppUU7JqySnhPrAJao/HmiZi+Fn9M1Ve4Bv/oinW1PancXz3m?=
 =?us-ascii?Q?NPRo/bXkDFFgTHYJR+ZsYL0QNJ4DOHvZ5Ei+31QEcHAM2hzN1DZBtgrPd2sH?=
 =?us-ascii?Q?d6ZcAvyl9ka/eFCLMdauXwXYmDJytDy+g20DpJFRmMc7OoIgTnH3oREqUHWk?=
 =?us-ascii?Q?ViVjsO9zXmU0I0Bpmg3per31X45jCoMzOwtW/9StmzTkQWf8P8y3hzS5qbqV?=
 =?us-ascii?Q?W1Ds2vgirS/kmsgK+wQXgyHjCbd/3W1TFJpVJ+L7BzH98efm+gS1m/bRdSxl?=
 =?us-ascii?Q?mxsT5MO8IZSPt7kG55M9kd7X+dxPv44C9zS2OHnlKdOECKynW6pZr/3YqRCK?=
 =?us-ascii?Q?AxlXK3vOG5hQBDa59D9oofjjksx1jNgzg3/ChTwJjZEcGQg1VDj03jBDdNzK?=
 =?us-ascii?Q?+WyOIm4eOGKojG4a+jIFUFD2Hh8WME0mxxv2uDBiUdumtP43TcVPDIsDhsAf?=
 =?us-ascii?Q?Gs9//LBXzC+nliOLRQl8XyvyvZiQRyRDQqHZvu9PP5MxzgcDzuOO+Z8iYL2S?=
 =?us-ascii?Q?C/QezfNFtPrfvvHPAld2mHk0VxNXZH5F4HOa6byOVVQLfHfR/57H0lLpuH9R?=
 =?us-ascii?Q?Q8H2Y5wZbmsrQMyVOyZpqlx6WXQJQ2hIC+6Rk9xOV8zKQtft81ngr4kXWS/F?=
 =?us-ascii?Q?yUB5qmdjrkW+3WfjrO54/IXzpzOpy8QB/MEhyR62Ts6Ie3KKmU1P4C+CkiMu?=
 =?us-ascii?Q?s3T23oiNoivZtu2bSFS6i6RtG5emx4+bKgU7jTV2WTAZLLVF2AvpSC91iEpy?=
 =?us-ascii?Q?cQH2+9xPHOa8g3TGCw7sz3SwGGlOAnYSnsT4nH9U2M0RRAtN85Q/TvFxmRvM?=
 =?us-ascii?Q?P8aNSJJjY20MCU/pt6uuxFlNpSswwJI675AsJdP/YnUHvunilwEl7tEIfuo5?=
 =?us-ascii?Q?v3qpwqznHU2jjXCl6DoZaNGzcyx3YpoDy7It6J2FYxQT2J8xlfzhJkXiERzy?=
 =?us-ascii?Q?eyZDCsrEObDQ77jy/20CYXks9hTPVkUPFZ/luoA1ehrX+mwFe4ox62vQqxSk?=
 =?us-ascii?Q?cotMdVrJXY16va2pxetbhL5sCitSf3/Y8lHcFFa5CxTkmNj473ZqVMkBNgLa?=
 =?us-ascii?Q?/h0rHCMM184f7ewNs6el+GvlZCONpU9WznB1ulZFyQX47bPTk5y5NYEogQhe?=
 =?us-ascii?Q?BJk4SAAcQVq0eSvuB9wCiZy88m7Lj1o0+tHvkNY0Q45I9mnh/ScYR4MCx3uV?=
 =?us-ascii?Q?wvGCaXqo0DaB57Lq4xgR7AMuv93PstDiTZQ2g+D8PpP1g0n1S/u4PyakNigv?=
 =?us-ascii?Q?faueatBn6kDihz0TJzbPq9ymc/Xb8JfYAgc3kxrT5uvLsJizLqI5ZcRPlNpB?=
 =?us-ascii?Q?luRCDVRGF/oKA525ialPlYW4zE1SmReWfnIaHokQhwRshDxymyZHznA5KwFs?=
 =?us-ascii?Q?X2CNBiRP+//GFEYy+ztLRMf9a2yXlwAUoGz+/uRDz8jBCRXw5bVCONmdXb5Y?=
 =?us-ascii?Q?OoZp/JvpRogggRtCA5fTFCtT5Vugh+D8gTQGJHfitLbh5t/qcsrbEM+/ivih?=
 =?us-ascii?Q?ymhrkBdOC5DU6CDW5IFjlzdasWKXK9eV1zWnndX9VPhXTOARSEPe1jg0IkET?=
 =?us-ascii?Q?ek6/DAZbx9UgYwmYXRc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214959b6-df25-4cd5-aac5-08de04e79299
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:49:37.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrPunKktG5TtoXD/hHQn+6h3JWTsoqKv6Sj4xUmhLvJS/5IAYFnORBPXZRmN4pbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

On Wed, Oct 01, 2025 at 06:09:52AM +0000, Suravee Suthikulpanit wrote:

> @@ -857,6 +878,8 @@ struct iommu_dev_data {
>  	struct list_head list;		  /* For domain->dev_list */
>  	struct llist_node dev_data_list;  /* For global dev_data_list */
>  	struct protection_domain *domain; /* Domain the device is bound to */
> +	struct protection_domain *parent; /* Parent Domain the device is bound to */
> +	struct nested_domain *ndom;       /* Nested Domain the device is bound to */

These two should never be needed. domain should point to the nested
domain and it can get the other information from it.

> @@ -2620,7 +2623,16 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  		if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
>  		    !amd_iommu_hd_support(iommu))
>  			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +
> +		dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		if (!IS_ERR_VALUE(dom) &&
> +		    (flags & IOMMU_HWPT_ALLOC_NEST_PARENT)) {
> +			struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +			dev_data->parent = to_pdomain(dom);

We talked about this many times already. Domain allocation DOES NOT
CHANGE the dev_data.

> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
> +#define dev_fmt(fmt)    pr_fmt(fmt)

I'm not sure these make sense, you should not be using pr_fmt, use a
dev_XX on the iommu instance.

> +struct iommu_domain *
> +amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
> +			      const struct iommu_user_data *user_data)
> +{
> +	int ret;
> +	struct iommu_hwpt_amd_guest gdte;
> +	struct nested_domain *ndom;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/*
> +	 * Need to make sure size of struct iommu_hwpt_amd_guest and
> +	 * struct dev_table_entry are the same since it will be copied
> +	 * from one to the other later on.
> +	 */
> +	if (WARN_ON(sizeof(struct dev_table_entry) != sizeof(gdte)))
> +		return ERR_PTR(-EINVAL);

use static_assert for something like this.

> +
> +	ret = iommu_copy_struct_from_user(&gdte, user_data,
> +					  IOMMU_HWPT_DATA_AMD_GUEST,
> +					  dte);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
> +	if (IS_ERR(ndom))
> +		return ERR_PTR(-ENOMEM);
> +
> +	ndom->domain.ops = &nested_domain_ops;
> +	ndom->domain.type = IOMMU_DOMAIN_NESTED;
> +	memcpy(&ndom->guest_dte, &gdte, sizeof(struct dev_table_entry));
> +
> +	/* Due to possible aliasing issue use per-device nested domain ID */
> +	ndom->id = amd_iommu_pdom_id_alloc();

I've forgotten the details, but doesn't the gdet have the virtual
domain ID in side it? Shouldn't this be going to the viommu struct and
mapping virtual domain IDs to physical ones so they can be shared if
the guest says it is safe to share them? I guess that is an
optimization, but it should have a note here explaining it.

Jason
