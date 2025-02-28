Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E6192D7E
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763939; cv=fail; b=UrIYaV03jM9h9J271DI3g7G793HG0tUgoxEJV+tXdA6+mlVl4LtgTqbXaGcoJwuEZHcc+Y5XIr+4+VKRdX68YFiR64ZgGyWXdFshXRIAQ4hNrtuRVzn9uZFkgNI7jHQgJND6z4mdUiC5PfOniglGdzTZvQUmzAK+9l2lRLkBzq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763939; c=relaxed/simple;
	bh=k5M8DbtyJetFgw+hhxTgCr+kFZZJEMIAkVCiucPCtko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M18gYuUcXQrTZVy2X5nWdfCZENV2fDnpfsH8t7lbcDrJHlKQf0ZKc5qnqHyHs3CAOntPr5HlrjcK5o9x14mgbqy3FhIQzpR+AxegyfFtN4ajua76u91Li4rihX6ceZTs/9QGiP2bJoPz0GafnDQX7ewTX9I5zZgnkSdnAKykDHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TQy13lMT; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TQy13lMT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD/opUROeCyHoTwmCUFYjLcVJlQ9dAOdWOJStkjQa4dkUFNBmfiuATCAO0q/TjbHE3Bbq3lTqfECvIj932CgMPKxT/+Z9YnMnanNk/UQ5Kap1S6BgqTLwExDPlh7QCN4mtD3mH/gGwvPts90MuzjglVE7rafndmn+Y2EzpJgGZSjI/i10TBn/XCXiuVWrNgQX2jqPyNE4mklKajZVT8TXuJNruS9m7SNfBaHf/CsAl7anichcmZ7HxzDYv/lbL5ec7jUtN9Q4MITSX0C5mScuvM6FFaxbloD+yJKfv4a/DWm4CEH/OFXjfwQaWrP5sjg+95xwmvIOnHTbxHiHvEh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXFX6WuEywKNWv4+z/oDwF2A9E+HrkxmWyJNIpdce14=;
 b=dgOBX3lBR1193fO81F5A4mZI4I8wiZfgUpjWg/bQ/taUK6DUBXpDp3J6frIMEj0GUaKJuW80l5+7AlxiXjIHtPbjRywmE1Oc7P8W6xQv9QZuLlGJoL6vQgSD/kIQ2fAAe40Scs44sf0ls7TZAHTK8oNSKfZxfm5E4ARPJf38K332u/Pi53FRi+JlZsRTATk0KZmf0KEj4lvu0at0XqLLfjIgkfdASwUZjUUFDpT0nYRp6GDfOr5fgGnR+Akl2e3AI/cLhM5jFlaO2bXt5bH2OZOK/u4GPwECtvBc73wyTsofzRRT4uHhmLg427x/2F9ZtniKuatBgkwOtH3yeR2+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXFX6WuEywKNWv4+z/oDwF2A9E+HrkxmWyJNIpdce14=;
 b=TQy13lMT9xJHOXYxl1alcN5qcHKusCHaIVYdd5bsGv3Ysvv+548mMWnGQ3QU9wdh+hUUwOU5SV1JCB4rL0eACEcIvTyRuRIQNie5/17TrFxL8WxLspuzNGgRUuensiYOPTiDk9XL0gvMQTu93K/Ee5RZOjEQWVR/QDEDTmNlsLf6FvYSFx3f4shshJWXpJR6A9WdctMXb7ltyy+8xu1Ijn+OulB7A/Vikwe+W0dy9WYNdOqollvrVo1gKyEe7y40rntxbTjBYn3w2EfhG07nPxfxvQKG1PgDKK6QZ8Ehc2JYHxToJhqVeC26nN39z8DPHzfpFzEMxiyZNzclCfNkIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 17:32:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:32:13 +0000
Date: Fri, 28 Feb 2025 13:32:12 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iommufd: Move iommufd_sw_msi and related
 functions to driver.c
Message-ID: <20250228173212.GC39591@nvidia.com>
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <ece6ab9a0144eaabc285eb21a09da683d6d9951c.1740705776.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ece6ab9a0144eaabc285eb21a09da683d6d9951c.1740705776.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:408:f9::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e01b061-71ba-4481-db00-08dd581dd68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/Hhqwzp5rZYjVJlU1gttQ5ifCjcvj4Cidw8/oPlcw7JZAzjH4rCFfpwSSVu?=
 =?us-ascii?Q?CxTuq7HQ3qVjcSrUZKIq+yeK2JaVUPSyNF5CZGagGyktMB0IvBBR9qC15Rnx?=
 =?us-ascii?Q?rGWLn3VfA4xene2teKQfNe6AZqR0vlYUHdxBqHPzOo2LYcfxs2vqn3jS/BSk?=
 =?us-ascii?Q?mb7SdmvzMyqAKB+VFWbfcJ8jefHu2ir89wzJMXSCrzBogQx0o+WTHaLA5Wns?=
 =?us-ascii?Q?w3dGuOA8M8isKhXc1q9HRfLp89owlIzWaAdCVmIps9fy86mqKJ0p8D5QS4Kd?=
 =?us-ascii?Q?rjSrywSZDuFkl2usrqQOgfYQhEGONLV+6XPI8Tq1NYeGvCBTJyS7oQIoHCkY?=
 =?us-ascii?Q?xFehzeo99IkTsncnVu0Ms98BV4fSE7AePTti453DLBtg6q5/KAIt9KJMlzVZ?=
 =?us-ascii?Q?jGdxuJ3ULoec/XOVMFxQtRRFD/b8aAU+yaeFOfEkA0BAbxvuOLkw4hltD5Os?=
 =?us-ascii?Q?I/OYqUUgBPyWUVJRCEn2TBsJn/Qmupn0ErzrRMIhVICjz6IntpvE+VLNDZcC?=
 =?us-ascii?Q?7bFGxlniABdT6hdbVsAw6cDCggNZImaowdqRyAtwI2BxdUqUvQjl7+ucVVqn?=
 =?us-ascii?Q?VQPSTdswmgTqSEQsR9qmfoPxVjriFVi13eL+EYuGwzzRNCoqokZ4FyR9PZAw?=
 =?us-ascii?Q?pjYQ0QTTUkAB5echQaJANp8UOa81Ep1p+GSk29zzM9bsdy9cKmwrS+Ekv6p3?=
 =?us-ascii?Q?gOPDvMRTkOXiIUHUBqdF/gFJcVhRXTi/yDFxBmuhWHPAv5Kp8ooaT4wPqZNM?=
 =?us-ascii?Q?BC3RvhPi2eh+Z3paqhqB+gztUHjghKFUybYf7L7laB3oGe+gp7IiPBHuIOz6?=
 =?us-ascii?Q?TAUo8yWc7HDbC9dxQehzp5mklekrjhtBh6/aFjYtfyY0cIWHxb/n8wcfwVY/?=
 =?us-ascii?Q?/GfLOGKJ6lrW8VpfEKh+FeOdhmaVf15nmeSoujzm1x6ApC2Z7s1lk56BaWWN?=
 =?us-ascii?Q?8iJwwneqZL+W38YRpX2xLdqy27DdvdhrkYvSn6T2PJfCiLUrGcgwmuipndf9?=
 =?us-ascii?Q?j9e0HqRg0NFIfjY/RMwsMOkhRBT8pXrDwwix7Sn9TvpuwXphrBy6Y4FhZVbC?=
 =?us-ascii?Q?Jir/ibUb8G6Tf6cuu7J0Vui0/9i1ZRK5ZYqi2MWcJYGahrF8s0Fwk2IqOIwL?=
 =?us-ascii?Q?Y3PA62SqN9xT1xLyD8bYTgBKReYL367KXFgRJW0YGf5YWkoxDZJnWjLidHxD?=
 =?us-ascii?Q?a3fUWRQ6P4NMZCdp4ThiOirWsfSWkk4nzP+MZ2+DYYGkeLWBX3+4TT6Ot2ML?=
 =?us-ascii?Q?RJoweQDV7Jg6m/YxH8P69ByppFg5W9bJrWDPDbbGghkeI1l7sS6O0k7upYgx?=
 =?us-ascii?Q?yK1HiXiQcE2TRDYvpI4WHFHTaeNeMhhzyRLd+9uiHCN5euw7H+fRPLnv7G3r?=
 =?us-ascii?Q?6zhM5df+Ncj6nFA5MvoD9hkxFFWz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dggKS6smaMbQlCs7R3rTPvfOsmWG3oVRxz7ib1W0o5+fcpcfAaU+GR06rbg0?=
 =?us-ascii?Q?2hpN3LzEcaJ1GoaVPHun7YQuwUs0LxHfBAuwZHrYnlOyZOiFkABIvu2XsMB8?=
 =?us-ascii?Q?J68GgZoMQR15g9x24YZb4Juze89ijc/WQ0HOtma1FKOVQjMUe4y3AsdWM3xS?=
 =?us-ascii?Q?ge/KFWSOUU+VuhtuJcaXrHke/qabYc3oLR77TKyrURffsB4zse4skwVnE0ys?=
 =?us-ascii?Q?yb72V33RYG9/ltj+f+ah86Uj0A2d/5N3wuBNGmRjvD1Oh3MgGZhf+o2bxC2z?=
 =?us-ascii?Q?ZY/bQ2LIzzy2RtDJccZ2kwoIYaQg0/7/pikZBCdBjIMbbfSXyCIk4zE1RMln?=
 =?us-ascii?Q?7bV86COIcZ0y/7SqDX1MCj9KjIOhzRE7Bm9lr969Ja3+YwKgAWHkCk+NihiY?=
 =?us-ascii?Q?PYVXAOEq4jfErIiBWUCuW6wVLg3KTrnzWbaA1XDyK0upMHWlBxPXwNfcRbaW?=
 =?us-ascii?Q?e790Zobf5IyEqNq9v12NLf8q3fTJkQ13i9YkO5R323LSejEgMh2IPA665HCG?=
 =?us-ascii?Q?hkZqffFIA1Kdm0oe8h069c3mB5mTZ5PdfnwEjbDZftYI0R6C9hm+ytFCnBJT?=
 =?us-ascii?Q?ReUMsMTL0mx6cojYhNhHAZ5fIdTdrgs/K0tgwLfNiFs8Of9i1hDhvAw/jobM?=
 =?us-ascii?Q?AOjZjHTgsuF6K0W4doyW2RZ7jPSSyaJbHO+MdqAOD6kwwpkyIEbepx2OqYSs?=
 =?us-ascii?Q?q1/ZmVfif39mxLYUT7U8q5KYirMdzcPqqgXpydpx0PMfB+f39Nyg03JTc92t?=
 =?us-ascii?Q?uaSxBZ2xDYoRT5QxGe+jF0Aqc5h6YIRhlb8Qpy60uWy+6qOOD9YaGWylz02L?=
 =?us-ascii?Q?Qd93IP0qEzSISy2WDhbOw6gvyOlXfw1gJOhDeF/VZOWuhzvb+GxEZXr/JW0p?=
 =?us-ascii?Q?SSn7Fd/4tvI2OCMXH4zd3goRgq8d41rwRGDgTjr2LutjzI8OP6RqnXLzqL5r?=
 =?us-ascii?Q?B3OLDHt1cohcg9spvpzJCErMnbjhnYtHFRXy8rX2t1DlGNNY3gdHbr9o0C1A?=
 =?us-ascii?Q?isAYqsVTLJPerHJ4hEIQ9IxQOw9ugo9aRvRwpsL+LcD5rrf3kTX1Rabx3e5S?=
 =?us-ascii?Q?kjo6IzjLMx2FepkPoEhvoEY5J34BX514XJOWRe9JIvSyA12SfnHnJsCr5TYS?=
 =?us-ascii?Q?YuKPcd7IEzxa9xJ9Rsy+Y13wxu1jfu/3CXmI+krm+9mqPP74KVa3HnUqwd9r?=
 =?us-ascii?Q?VWDyUEIhElKtaE49NZCH6vLb8w6IjQuHl38cbFmqT915gvevhq5laMdt46Zp?=
 =?us-ascii?Q?lIwYaGkE4CMr8XWnf/E0hj6Fx1UpnCNVTTOBlhn4gvXxe0NpYFbjkkdArazh?=
 =?us-ascii?Q?nGstjG75r8pM4n5T9Pe3NA/KGT1VTOajL3cvbTH1dJtp1XppdigYD/nUgW4K?=
 =?us-ascii?Q?Fr1KO+DOamq/It4wvAAcm0hKTsHacshARII3FM6iuUDOLnMsahqWbGHyaAAV?=
 =?us-ascii?Q?qs4vqyslAeTfrGGYs5pQLsafmiycZ+da2UoFl7SzZ1Ax2KPL3IUXCh+K4ADp?=
 =?us-ascii?Q?Uzb3LKx2tggNMH37qZmTgfIIQtghq7MoBUgLhb+gzvVuywEK+9E9+Rm5hHTb?=
 =?us-ascii?Q?yF6NlPSHylTly1Qo0U/S4H5KbpEzR0hqL5UbSJsZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e01b061-71ba-4481-db00-08dd581dd68b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:32:13.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwcSA36LntgTLHtXU8K06i25+feqQv+zKws+Bl52fsUmDbEStqodh/NJAE2NjtoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

On Thu, Feb 27, 2025 at 05:31:16PM -0800, Nicolin Chen wrote:
> @@ -187,6 +188,8 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>  					     enum iommufd_object_type type);
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id);
> +int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		   phys_addr_t msi_addr);

This should probably go into drivers/iommu/iommu-priv.h ?

> +int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
> +			   struct iommufd_hwpt_paging *hwpt_paging,
> +			   struct iommufd_sw_msi_map *msi_map)
> +{
> +	unsigned long iova;
> +
> +	lockdep_assert_held(&ictx->sw_msi_lock);
> +
> +	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
> +	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
> +		int rc;
> +
> +		rc = iommu_map(hwpt_paging->common.domain, iova,
> +			       msi_map->msi_addr, PAGE_SIZE,
> +			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
> +			       GFP_KERNEL_ACCOUNT);
> +		if (rc)
> +			return rc;
> +		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD");

Stubbed out too if CONFIG_IRQ_MSI_IOMMU ?

I'm still wondering if we should use a function pointer, how big was
this compiled anyhow?

Jason
