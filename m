Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152C2D04E
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524092; cv=fail; b=Sttspyg7PykWXaqg8DiVKmxqJq2fih67A/9hSIBndNIjxTxFT40acmJPbL1wmMUrrtHSn49+9Uyvm6bDgKmOQIgHVPliZoeG+ium5b1rUw1X47783pcCqL8xVTbfSlC+GNWXhxoPBKmIeMVdMEdxp40sEFnjcdzefpDdlUe8Tdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524092; c=relaxed/simple;
	bh=j1HlUlJSH9eIsg3HwlZzz1tX3sOvzClejJWs3wijcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H7r5sHsTMOgG//sfgeNbiVlK+FE+c1IPfxk1JfcvxmYKtRuv0dr6LE9FClbo6lKF4KMRwaIRpQ68yH2ObWjHvTMB1QHxEztLUPMIv3gJiULfMIW9QyTFgTcDJNCPrrXdygcuLMMX9XnV1bBdNprTKSj+rlr+lIHTySO1wp/sYdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDhJM1Os; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDhJM1Os"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEWO6Sizj2Z+lMSWrPFKaUBolkAMJUpDy/cEYlaXt65MOGbs6ix7eRdcPfUEbqlCsrdBFTF1EvfOC5JfcAum5DPTrUSWZi4xvR0DKV9SdZKgCvM42gTl8ms7PfAf2D2JHUZNOmsC5dz7ITegdcDP5iE+h0466o1W82270x5hKQHMb/niNEAfe/cADJzfF1eVMKCqMTgZL9jbDMEhjSEx/NwhweNBLSigfrE/gfHTzpWn2yK2iI4kuXSpp6vGb2rfu/3e9gKZf+G5899OGLRnUEy93oCmBEXzEWl04rXlAPwPfegrKXWS2Usli0oqcgsOCndHhcTnY4MoxGbv89/pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxGnUTjjKtLc+YLNW7gV0kKKcCP6AiMD6h0v/NVJLI8=;
 b=UR1CND4wDA6TFisxmiz1iz2lv46Mc4PFTCrjSpYhfvSbCjIgcM9WfAPysGTFYyzp3nPt5PJY4Zux1fkK1ehTmwmQsqIMgybKsHpF2cgplT0cNJ7/d1OaFE2Z5i8cVkA0WxBj80/b1ezytSHj+ZbLKlAf8D0htWmfx6xHp1PpGT/rgjn90xrX4dVrYYR2d7uoupY2dM9UffOJBbImS4NdYodRQgqiPRy+ILMnL7V7uPqTBFR6j5JrdJFaHY125LXbOWplF5KUf4V/it3KGp3gR1Y4uCjvePKRxQ+NA/p1ZiGg9wNpwyfG7Xn3zY5V7MLGAjtqAA9ieJe9zMuo4WE+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxGnUTjjKtLc+YLNW7gV0kKKcCP6AiMD6h0v/NVJLI8=;
 b=RDhJM1Os64zHrt+56cBp3aDhpcto9kPRVQBMbtDvEfyehTJR6p094xrUxMbUVPNNWs9dfCUMco1WXAv88pTU7GodseLlyaE/leqxzYeDiEO1xwNqlZjZHMU8bDiMl+4c5DwiR3bKpEH5f572veJP8ptyOAJz4isdz9rp+octz4u91xkZhQ7K5/CP3bVLR7i/9Rg1vBQq7wT+Ti+8Uxe0mYzF2aLGCHBHTSa1cdHuSe5ye3pCragBswFyF5DNgj0OeFPhy7MHj19Ww+ILiNyb8FwbvARD+QB3egiq/Gy85HZCmnYt62QquVSZldhtrdQiev6VO7wwV7xfSDigY519RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:28:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:28:04 +0000
Date: Sun, 12 May 2024 10:21:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 01/14] iommufd: Move iommufd_object to public
 iommufd header
Message-ID: <ZkDCbWv1DFH25mnh@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <09e84c7c9099aba07b24b113c70d57d4574aee08.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e84c7c9099aba07b24b113c70d57d4574aee08.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 3089295e-4299-44fd-bf4b-08dc728fbc26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgafGxlC4kN80BxDBYA9qqs/vltmCmgTDIWDMYuwQkOK7493ggAqBKgbYICf?=
 =?us-ascii?Q?iQVLEfJjnQb2K4rVUmxXFy5h6WvTqoZ1ZT20erh4YiQm4gOm7+ay0Uudovu4?=
 =?us-ascii?Q?RzSHYYV8eql3GkBsl6nRT11x7o137KOYEky6N9n8djhmh6xxiYt29VdIQ6qn?=
 =?us-ascii?Q?FdSz5A4Zujx1Sne4txD4x3/GHVB/6Ea3BwgFHtyUlQxwRC7CWqeI8y4WkgPZ?=
 =?us-ascii?Q?VjMr7m1T+GO4rMtimuU4SHnBWutxUoS8M8EefYQKHOj+zTqN3lla0Rqmla2X?=
 =?us-ascii?Q?uwPSVnWPjXG3fl3LTJziCJGOA0mrQxq6ApXvOxU8Rbhqw3C9F2UoDGy9UEdz?=
 =?us-ascii?Q?Wwhqoj9RiAvXByt4bvRHybnfbNFlHX8TBnW08OkkUxaLxUcXO+5seMREZcRl?=
 =?us-ascii?Q?LINHQqMvy1emPBuC8dAu5LRbaEAsElsowU5ZrLCg3BFfKVQ78TYlpiP5RMYC?=
 =?us-ascii?Q?PPMj1WSEtZvb4+mMa6XZnkwLvdYBCYimXyxfwQj8CXJxuEImla3SGs34RdiC?=
 =?us-ascii?Q?SZt7T1CgGzBiV/1Js2gjvOUHctfJt2ADtQIB16P1ezfpJ1pInzVT+Da+FHfT?=
 =?us-ascii?Q?lzAH1ynuzt8IK43cFQlvWnq68VQxQEZ3BkGMDXLVb0U59/ZJQfLX9Xd7GqD/?=
 =?us-ascii?Q?aJvOCFHfBM78hWbKtpjIVXWLaiQxwG9KJggHajVmSP39DIfdGDqicCXgHeLH?=
 =?us-ascii?Q?BuLaUm2n1Z+7yGdTNVJreDAhjP1ty8S4GkcMqUzX/AmG/WjhulVzXHygHBlc?=
 =?us-ascii?Q?9UwWJ4Tk967MHci3X7JGEtV7BClCfYRvJz7rlQU3RpRSbMP8HZb0d8bdFwmA?=
 =?us-ascii?Q?Mu+hKcJ8TtvjA0shXVfy5baNyWHYz7rdx0Ixv0xiO34KhW6fY+H/XwR6kLA3?=
 =?us-ascii?Q?N9BjsbCFAlbhE8mUjKCXonK1wLvUjfuaoDxQugFj25hoClaHax8khokp9sQ1?=
 =?us-ascii?Q?P9hkd1xkaTvoZtvF8KU7+H2m58tghPNknHt/0dx7lX9RentUVSl7zQ5K3CC6?=
 =?us-ascii?Q?BnPlBu4C+mcAfFslIlmTmKeeCNomkKCnHTq/yMgoAipNQ5bHO6OZnNONORy7?=
 =?us-ascii?Q?a5QfEsfbKpU5l0bY0WAwPz+UEo2RtwS61uz9dZu237c/9pgli8+Q13jPOOiK?=
 =?us-ascii?Q?PnYFm2v4D/9mJKMvqnUI5UaCpkzkDusnRW0sdL4b8EtGEoV798wSTv4gbi3V?=
 =?us-ascii?Q?pMd6xDH10j9+2nXx4jHelw9V2XVgUs/OGjcJzXWvM/RDjNQiYgKGEPZvd8FY?=
 =?us-ascii?Q?XdgZSGSMvDKTu/usPzJ+E3v/ZYgLbXnevNbhGEFgOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iRMvUmu9vhvEKvA8YoViY8EYS9mUQEVGMUKLuc/g3PxWsIXDYcv9cP7/75gH?=
 =?us-ascii?Q?QCkC2Ltt5GgtBuNiWqZbJwdsAZ3PY7zl1HYI8ulRCDLY63yXIsYfZ8clCYB7?=
 =?us-ascii?Q?xyP5RmS5Bn/0XyA5/bsBtRogr2fQlYxla4xTBlBapOcOrUNMtri4VbmzxIt4?=
 =?us-ascii?Q?A0EQr7fzG0P/19yXUb+Sn3EFralAC4xlp2mjK7JdLMXqJQwlxvtPwIZ9VCzO?=
 =?us-ascii?Q?skEp/e09q2olVddwrD9dx0phGYl7/Yt79VC8ayE44P2/mU91YjfjzxHPvcMu?=
 =?us-ascii?Q?9Xjx2PSM0rV1/Eh7rCnphZ7x9ZcYKV4guaXNFe9UHuvXg5t0XlbYRPT7IzqS?=
 =?us-ascii?Q?iNiNtoPP/6uCtJeLLfajHyIuOrl9oBnxhQq0bJXQfUaOJ8Ij5vPY16Twl3M+?=
 =?us-ascii?Q?fvkCtQXeA8oSb7GQSOr2c1vhK4KdhZ/XIUtSHEBp0puIhGGh5Guv0nm0R050?=
 =?us-ascii?Q?JzVli1PgpFmlZHzytxWKNaUwQIMhgpZBZ6qOiVjtRW2K74qcbjtzQoYT0n1r?=
 =?us-ascii?Q?Pz3LDoREme3ITnJ72QPDoKxG02/pDElv0+2x46JCFo4MdJJGgokMASH6UhnP?=
 =?us-ascii?Q?8NWssZ9PENuI/95UKY3fOOlbh30FCEhGQdTN/OVKQplpmF3PukXRMQn1nfFg?=
 =?us-ascii?Q?mxe3EUckN+BYXk5D6qAd1ObAe+WBJ+ZVvye0GEAZvm7bKvyXPKgwg5kCDJ33?=
 =?us-ascii?Q?968AWyVE12JpHOKx1t0J0HlfcUgR1LFYoNoS47JCPHx2mL0tnzcUxkI7rTj7?=
 =?us-ascii?Q?sinAqe0fRe7084E22IGXMXDASK3wQnVLVSg66hGN1HE51j2ufQp+WgfIM2H8?=
 =?us-ascii?Q?1GdhbgR8bNCwy/mRI40+oiDPFDE2D6UfW3ExJ4pUHG8DqkxcSxHyAXmhdgDR?=
 =?us-ascii?Q?QUZ4k6wTCf8xfU5xMxJxLcYudW1opMCjRvg5uQpbaiL8/ScfnyVekiYcTD5v?=
 =?us-ascii?Q?0yPgaJxruWqUUmUuKEpaulGbcYzN6ybABzZp6uXjKnC1UwzWYZ9oYPnXRSs5?=
 =?us-ascii?Q?CnMkwekD0qmTx/PRv6lADDg9E7oy4DQp52lh/sqMJDLdHGl7S1ujOpk5bu1c?=
 =?us-ascii?Q?PdYgsobLMiHdO/daDYMF4Q6+Fi3bt/ejbKizoaGFARon/XUY7acjjGnbiVpr?=
 =?us-ascii?Q?H2f6+fTGxxPR/YnW0INNO0USPPpD452sQgdc+fisKlhkRG/tXPEvlYiVFhwi?=
 =?us-ascii?Q?BwaBPY3VcH/CIa3kAYmG2m/qgrbenTs0cBTXH80OXzWp9yamQAj8lULCzaJF?=
 =?us-ascii?Q?5zXZXbofF4ZdEJxMnflk0kzJscm4wFLuMd3l13cF50DRsVS6jyfvMKl3mg+O?=
 =?us-ascii?Q?rqWWj1ADT2Ocu0gZ6Ru+f/xaavuBcHimjm0mUdusE1Lim2i4surnr40l6t1U?=
 =?us-ascii?Q?uuaJbCoJqbnpnn+3KedsVd3w2V2GofHymlIp86xswy5Ixu8PpPREyk/+0flN?=
 =?us-ascii?Q?kiDZuMAaqkRWoG1MXUXI/h5mE8089hqzdjPBa0PlhsDjfnAE2gDllLPySJC4?=
 =?us-ascii?Q?i3pgL45Ij+s7EEPCmuaLk1oF+rMaLbsWMizy30C6iLMaujm4p5i2auO58KhO?=
 =?us-ascii?Q?gT/tklnzxEV0P6j0lxPzo1iGPipRdRf0U9RIvUiC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3089295e-4299-44fd-bf4b-08dc728fbc26
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:28:04.3359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJM4WRLuLv1YQVA/9/YnxjxG7CsoneIwYtIcirMmtjXkY+f/3VFVaRyvUxZinajH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Fri, Apr 12, 2024 at 08:46:58PM -0700, Nicolin Chen wrote:
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index ffc3a949f837..a0cb08a4b653 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> +#include <linux/refcount.h>
>  
>  struct device;
>  struct iommufd_device;
> @@ -18,6 +19,28 @@ struct iommufd_access;
>  struct file;
>  struct iommu_group;
>  
> +enum iommufd_object_type {
> +	IOMMUFD_OBJ_NONE,
> +	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
> +	IOMMUFD_OBJ_DEVICE,
> +	IOMMUFD_OBJ_HWPT_PAGING,
> +	IOMMUFD_OBJ_HWPT_NESTED,
> +	IOMMUFD_OBJ_IOAS,
> +	IOMMUFD_OBJ_ACCESS,
> +#ifdef CONFIG_IOMMUFD_TEST
> +	IOMMUFD_OBJ_SELFTEST,
> +#endif
> +	IOMMUFD_OBJ_MAX,
> +};

Can we just forward declare the enum? It would be nice to keep it in
the private header

Otherwise makes sense

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
