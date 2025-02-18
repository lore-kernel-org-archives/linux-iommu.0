Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649DA1E833E
	for <iommu@lists.linux.dev>; Tue, 18 Feb 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906844; cv=fail; b=U/qc7iiojirtae46IzdyjxJpJ1Y2E9zMdTW3G1xwEvze2i2a8lS+/7YPQTJzvaLx+7UH49SvpSV7inig8/XQPznz+VuEppZPRFffD5gev8G1XJaBPz20l1ng5+T4vkcwpKBMg3jf/o8d1Yf4gwtG4MA9mTqvd24/R7lcrm6oYbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906844; c=relaxed/simple;
	bh=a7rJ7BE2bdGdcLfdMfXwY4e4Y9Agds42UzMa/ncgI+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iP6AK4y41NqH8gqiPivRNScnNqNVvD+/X5Pw6WBvojuTgVO7vN3aVJ5Hj++0h/BneosgchyINU+eVkpvam4LB84IFaxvgUbgeKX3CSTBFOhbDMf5ksIonXZgRpTe8qP1Yr55GRKS/TYNuKqI6SJR2U8YvZjRiW8VcOkqG/bvhFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RAh+wQ+v; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RAh+wQ+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXDMMarItjYSV0tNNUuEcGyZ4O2LobMxywvyQ9PihDtpLUj6TFK0L2ae/thG1xVBihay+IywmAc05c8XdOs1RaBZb5ev2yviJSQZ4pXYmqEtYWYvFxNwwbfbB/4KGZPy7MLw7lqU6aHRkfFavDVdU/RRvwyxm7H/Q1Mfs+zqmmwqHulUdeuVKg3UvpXzgI80SrMGPgGUmCxwpS7WypadEHkCGGF6UIhY7N4WIdxi5nmNuqRSmZbhcHZJVYgBEHqglRKUPLNi/ddh81woO0DJUpfmvOw5IBssGP+P6BxuUgCVBJKIZviRKLeGD0NFBI5G1YvAa/NnnLivLXdvkUOc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb8ZkFz40JPeFGrwhHsncbN+q8BS/clpc3pDUfaxQ1Y=;
 b=pk5ORk2kTrMp6G2AxP8P2/xOJ6rRzu3tUbvX4TUh858Cectvaj/f9ws+Wpq9viEhsJGkK1XoMEc0nBFDmiYZkoMp8vDTJtLyS4PdL5SgXQgtiSHIbtwlrtxFubJh2MX+CuK8/KmEQRiXHIiHC72ZZXxhc7r3z0zrhYMp+AHipiHhRvnnPhJsV7g0pA+EuifYtDvBhXNS94if8qJbKd3OgNQRvhR4lCs41zx1tUjG090/p83UPuvufXyg7Co733lqn2aa1oj9j2M/Am1DroIvVpMBPtM0PEC8+lLv0d0cV8j1CqbTKLTAxMf76upDTVAhGZ4P2bJQSMwCaYSfWTRSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb8ZkFz40JPeFGrwhHsncbN+q8BS/clpc3pDUfaxQ1Y=;
 b=RAh+wQ+vYmT4MtheJ6GQJ8fEN4+mjkcL5CyiEZKgYQ7UO4aNjVo4abw9CdFICsYIo0pJ1Gdjly79/dsvYM6A07PSbKK/3eeIfNTR7hVf/qw9/z/1Df5gAhEwMc5n3TNIqnMT8183SaOOawMnr4dD3V3bZ96o9dhx2WDBY8Mre3EKqADtmNh29Y6uJe2GFzoHVaHUYtOyZGwrW/t2Q/u5+5lOUPTKqWwiN7U97CaAWmXsYyKOvxFE7x+KK7OtFhP/fsIer/4rYGXHeEMo1Ll5Uxg2E+IdyxJdZaagIdAVefhPwdr8qe6UiIGwRpB/jgpWY7UlnND4Dzufw7W0vjBh/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:27:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 19:27:19 +0000
Date: Tue, 18 Feb 2025 15:27:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, robin.murphy@arm.com, nicolinc@nvidia.com,
	will@kernel.org
Subject: Re: [PATCH 4/5] iommu: Swap the order of setting group->pasid_array
 and calling attach op of iommu drivers
Message-ID: <20250218192718.GE4183890@nvidia.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-5-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a335e5-53e5-4211-6559-08dd50524286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCn0kiu7OmZf3Xr6EjIbtMbj6hbr77X/Me/IdmERTCNR/9KshKCnv5uUylE2?=
 =?us-ascii?Q?Dv/XtQP6EEcgHGh9Tx/Wg5gYnWVxur36cYPfMQGPUFCoeDy4VsJ6wBNeNC98?=
 =?us-ascii?Q?AUEw7xb+Qt0nNCIRkX09U9Xklq4/RxwcIOhz0I1Ku5+CrVRw6EWfEYa/KLsp?=
 =?us-ascii?Q?6Bg/gd2joByM+5Kc0E7hFqlywpBvKIVLle5cSvcQTxpR14Oy1MxU9Xy2mYfz?=
 =?us-ascii?Q?bWBF0EZtvGX0QlDPPse0Y3rbIXxOrLyAgETI7Ed/ncM98KZdYjwHU9ZPUN7q?=
 =?us-ascii?Q?aNutBzA+HFBE48KI25TzLbYXUW4sarF5OUI71/PKjQP80RM/B89DUJvUez2a?=
 =?us-ascii?Q?OrUGb9+AoCUK1qhDLpA5n46xtK1EB2UkTw51F09eZD7z2myZyy1Qmp2oWkPn?=
 =?us-ascii?Q?I4o/5xIUbvv25Vu1VDYmbD8+dhj46u8dcS976Fz+91XpRsUxQaFonKxTgWZW?=
 =?us-ascii?Q?PNde84mG6UEE9h6PAWrthwMMKQJkCQwUFWSlbpObu7urgu5LoEFuiDluG4Ab?=
 =?us-ascii?Q?PgdQsV5eYm7ffWTHc6rhb/PzE4ddyne85GBU0+3C4Y4oAKJhh2+F4/FGm2j0?=
 =?us-ascii?Q?NEwwRu1G2F8Fpb4EvLUjZqrIIxyKj7M16vpSnzPXgjgM4LM0EvyKDAsXm+XJ?=
 =?us-ascii?Q?Fwmmjk544sQzVUHpNvHntjzJzUIvf8bagZUXoYqXXBx65zHHDSFXZsD3fe3r?=
 =?us-ascii?Q?vx/TAx763u7pKkAKaBvoEXmDbC/pZProyRFN0rbqBys4qPw/0UEvViiJWxNf?=
 =?us-ascii?Q?fYHSFJghQIpClgoV9gEkH6WHFdHIIAweVsbsTwrN+TGLywQRZqjLYA7h+9Bu?=
 =?us-ascii?Q?Qxulcxerawt2X5FBmDBPgqelW+TTEnCGEHg4Zrhii9UY2l44DsP5sy0oOfAv?=
 =?us-ascii?Q?TUqzooV+Uf1j2Vh3TAz7DH1orIUSuyBMuKMT8BIygAndYmNQRJ2eLhb2ngbD?=
 =?us-ascii?Q?OMjnVu6Jh9GKr+YRgA41z3uxIqf5vMr4T5HtErQPX329UJgU0ItMvXCkWRZx?=
 =?us-ascii?Q?uL1IsRO1zXSRKE+9sT7wXELoUqUULA/wg8ewE71JyjgSeD/dB6npb29yxYw7?=
 =?us-ascii?Q?YL+plm9l8MQPOV4/XGUlHDotTNS0ZqP9lRkxt+VmP4J+IAymrJRZPs21RgWq?=
 =?us-ascii?Q?VwWRLemMyTMR1mQBey0ZvEsgxJROVCVjMg7exnMa1SZG9oZ5v7JfsLj24PUp?=
 =?us-ascii?Q?gkPvNlIGzDtnj73D4h8XbEdRdQyRbaCsMCnfoHB8XwLA4kcVQAcMPcbTcHSb?=
 =?us-ascii?Q?44T9xpHeC3WHjesmXVUgSNcRKi+S2GSnG23jQrXMDwFKe1ypxOar+0g1DCaG?=
 =?us-ascii?Q?Mz2Ln9sgpP5VVfa37RGZoBR80CoxeoRQRuUOkFygqmht+xFI/KLP0vUcrQgs?=
 =?us-ascii?Q?VFwvMwCMs2yMUQ7qH1iBxklZedpp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4YUPZpSskt7gWfoUhDrhGVVxASwWuE5XLdY/et5Z4Ve4S3N01teGLQJ3LPt?=
 =?us-ascii?Q?quzRn+GwjPZpLepbKFdc0ROFhK4D/Uey1bV4tS5kPNVHyrd37ZHgSu4TLgYx?=
 =?us-ascii?Q?K/iA6Bbwbrz2YKOQULghLfmb1i9FTJHTBt2AdlD8muMk4ZSSjqpa/6rVGCtW?=
 =?us-ascii?Q?Cudi3WeyEM6JCLlFB+cYZ1WMzD1l43qLBhuOL5NvUo5iXCyq6RIV1sNw89Yb?=
 =?us-ascii?Q?BH1EaxsjhJWIUPwGeoZEXrfO5fkNdCXc8Pr51tzdMw0DypcLFBLYyUX09KB/?=
 =?us-ascii?Q?MwGK4LBRUTpfk6QTN+xCsksLF6S5M7/Od6EglenaP4bHzb+cI5fCQMoEA0Er?=
 =?us-ascii?Q?kEBv9+/Eiz36Mjcs5QOKM2GxIIvN0dCol5X3OOdq/M2a/w5uy6jaR7VQdmiW?=
 =?us-ascii?Q?xyqgiH7OG9nnc4rsCMSNCpi8BxjxAOUT50lVpcUV+EHz6FmZqPOAJxEsiLUR?=
 =?us-ascii?Q?UjAhfoZgr03GlR3HtohJ5BZsF/VzY2V0yQsjHEPQeS5G/Rjp8G9+GruiyftK?=
 =?us-ascii?Q?zEDDCNMpE0EcqTRn+VNfeqm8+5R1VsbvcYOcX80y1WfXeHfk9Zr5L2SQdN/9?=
 =?us-ascii?Q?OJ9/S4Xv80mGuwIlvEKdQfqApeZ4apxl1nj7yIubKzuM9O0V29JHlHTLOjyf?=
 =?us-ascii?Q?q7cW+Lnj2SGYdzFFqGDiMSKkLgwQYM8imYqZ/0S4PXDK7TYIbGurNPUXR8aj?=
 =?us-ascii?Q?FN+JjXM6xAXxhIL0fhoKyCR6jxm7wr57rkiA49MtJsafVxMakF1KiGYtDyj+?=
 =?us-ascii?Q?VrC6Bvq/d0vp+jqTP0C8soXFUhYDHxEKLLb6Awr5Dq0DIJ6hg+IHDtmXYqMx?=
 =?us-ascii?Q?+3s3juOqLRUic5ky5ZqTBGWS/J/4/5Kd3wOnmwuwGKzz/eyxO/8HnAxa/Jtu?=
 =?us-ascii?Q?+tPYMnDhaHDxgeXOqJibPlzaAu3PiliB06yUUMJBw8DTuutiRkdeOWIBDCh8?=
 =?us-ascii?Q?vhaZKItqq2DWrePLOIiwOZogFEXcdsEJRdx7jG244cF7ZzNW8SVVDOw4N7/s?=
 =?us-ascii?Q?2vv5Q8EXzqwo2I4tz5lwJT+vK7FklPbVkrx/EK3kn7cOVzV6TED7S4G9oVUe?=
 =?us-ascii?Q?esqN9ja4KKk1ZyYiSGmbjQWls6wwKjH1bKotW9I/uhIp9BwMr/2jZqPCDpda?=
 =?us-ascii?Q?AAzxr8xFoGElJZaoA1C1AScGGi8bQvFPk5EQk5U/5TJ6NfKDIfQ0CVgoIi1r?=
 =?us-ascii?Q?T8Nr1iCvAePVqiz+qM6+kiRcMoU/Un56ySNLAdTUKsOagwiBSUlG+ZShhkHH?=
 =?us-ascii?Q?rDJGizWQ92Hh87W8CxTSG/P3ibG3gB8TsAPxX8GfT3pEy67lMa0htLcvVfxz?=
 =?us-ascii?Q?Cp5zr2Ay6Bn/WZB/qbpiprzUKM70pOtM2nC4NZWq8h35wn+Ff0ylOCjnzGRU?=
 =?us-ascii?Q?vZ6XlVAY5osRIrzHK3GYiPdUoq8d/26AYxiMyrO8CdyEZdPZmgXjKur5rerJ?=
 =?us-ascii?Q?qgvv92HLUVPcZnr3wmsfNMiDg4V87Zd+oHj8VaqLDw3MLuJAWhnvqxoNMKwP?=
 =?us-ascii?Q?OPIyWNC9+w8XuQO/7VJwhshK+DMOpq/pVNEpTR9ERXgTTlPwE0BfW5Cu2b6X?=
 =?us-ascii?Q?4ORDcL6b0fTNW6RuzfCZgodFBihv5XUm3zowV8eo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a335e5-53e5-4211-6559-08dd50524286
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:27:19.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6fDrAWEh9H5q4TnuQfeRHRmoEa2vmI3JZVbktkXuhCNUsrXeR46b+D/wOTl/1x5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

On Tue, Feb 11, 2025 at 10:05:39PM -0800, Yi Liu wrote:
> The current implementation stores group->pasid_array before the underlying
> iommu driver has successfully set the new domain. This can lead to issues
> where PRIs are received on the new domain before the attach operation is
> completed. This patch swaps the order of operations to ensure that the
> domain is set in the iommu driver before updating group->pasid_array.

I think I would drop this note in a comment since it is subtle and
important..

> -	ret = xa_insert(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL);
> -	if (ret)
> +	if (xa_load(&group->pasid_array, pasid)) {
> +		ret = -EBUSY;
>  		goto out_unlock;
> +	}

Let's write it like this:

	ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
	if (ret)
		goto out_unlock;

	ret = __iommu_set_group_pasid(domain, group, pasid);
	if (ret) {
		xa_release(&group->pasid_array, pasid);
		goto out_unlock;
	}

	/*
	 * The xa_insert() above reserved the memory, and the group->mutex is
	 * held, this cannot fail. The new domain cannot be visible until the
	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
	 * queued and then failing attach.
	 */
	ret = xa_err(
		xa_store(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL));
	WARN_ON(ret);
	ret = 0;

> @@ -3510,19 +3518,26 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>  	pasid_entry = iommu_make_pasid_entry(domain, handle);
>  
>  	mutex_lock(&group->mutex);
> -	ret = xa_insert(&group->pasid_array,
> -			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
> -	if (ret)
> +	if (xa_load(&group->pasid_array, IOMMU_NO_PASID)) {
> +		ret = -EBUSY;
>  		goto err_unlock;
> +	}

Same here

Jason
