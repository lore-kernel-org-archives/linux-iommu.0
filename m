Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71A3064BE
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819101; cv=fail; b=CQdJRDCNp6B2LuVoYHA8GM//BB8raEwO7gS4yYw+jw2l41A0/XvZX6JygBJ2hL99mIGRBhQ0EYa94BiO/btA0lQmGmvxMjLfqcOC3kXmnB6/n3E9x2zDx/EOpjnoHjx2qAOLD68vEQyNBOY7v46Zs9B8SVgLbEYM89mbTBbwnh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819101; c=relaxed/simple;
	bh=twqEUhAne08TiO+Q926Hnbsqxwivd7TU9TSXZghmIqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvRKlwGW2O+XYBi9EKOonLzKnf17MIFMwfTmrjZAGYQqJKurw31B79OL/WfO8oEk6MD5C2SGW/wsN2slci2wQHZjs2TlafstxuqxDIGV/CnXVofNf6l8SXx8/bz/nUZLlljczuU4LhgxDZ7Y6s2JTnUmos4fGk//KZV2Hu/1LAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bz8gtxX2; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bz8gtxX2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRPZu3+QtMZDAMV59zhQeBXy33Wo70Pw0S4RGuZGfGo7ejjXTW4Q+dfAHi4bUfvTSN6a0Wc3nfBRdjjLY4jJcaG/NPD7AV15yv2zjdt5ck2KAgkZG3ljry7wMVU9rTpOhY4fWTcSwurFoQYqRI+opY2gVZ7hGEltT4TDYZN1wKt/wjQxoMd1TnjjtSJeyWvPJydEZ3L1Q4zTX0/uOARuKQKsegyZwHDZyyw//gzVp9Wz3I4Q7qn7+FgFEoVLFzcf0oO3zla/w3qrxdKfZgOLhuR/UVti4kJuk+N52pIUI6Dk/SihQ9Qg2U404AvV/QOUoqfII8fGeFNmsM/VbT2RBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqYvem9VOLP5426JskmWTIoFLiJHs/BFiIuvg3lFRUs=;
 b=gIOCnZugkpz/eAUVcWYjHBYd4VXgbd3ouXnN2qM5+qK2nYk3TW+la+w3X7kKwZThVDz0s28B9g7kaXuhzdLi+gWC/V8Wksixp9rSBILZxZbK+m5fmeG8KgAwBpT/s6+4PrkTRUKRTmp/rg4RD29DPFA6G2HX/XlWNsVmjVN3ftbKptDvp0DJHS3KGPG2Cjq5rwPOn47X5460PsuOzc7dLOylBgmuU/wkn5cUYlpn8Uwh+jSUmC0xP6BBMDxd2i7Otgue28TnZdtQdDFcwhEFVk4peuQGXsK+l4QfKk7JK5uhNcBKky4LuYgyK5k1vnbbMk/Dj1jfQcs78KRo3LQv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqYvem9VOLP5426JskmWTIoFLiJHs/BFiIuvg3lFRUs=;
 b=Bz8gtxX2jgpadxMvL98QRLJ/Wg7HlgIN9292aioiia7SmdqrS//uUcbxK5x6cfn5ZNDWfdmHssXk1Wq1qZJEr+N3/GeskMQrs8i77/Rmadr2VSe/QaGL0LMeBEqgxnoShT3vqzyroJr1K95Ufj7IXVbHumSQupwC38RaBuUiJvwEktqBTkLOaU4KxbaZPBmX7i40fzPOzN8R8bjNQHh4+jm4OV6MFALmO/UzLIZSQvEbX4tlXx9GjIh/aHupervPfe7UiV4SQGcN3gzCd/wzNgnaAJ5+3kFi20W3UeMS0irvL/E+CN/km/wdWtKAKf25psIB2vqIAdaMX94Hq1NSZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:18:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:18:15 +0000
Date: Tue, 2 Sep 2025 10:18:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <20250902131814.GK186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0241.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 93572e58-4575-49aa-82bd-08ddea232cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xz8q/MZkqo77vLeYZ1oVk0U+LrgecWZuhF2iIH7A3B1lyc8k5j3wFib+Snv2?=
 =?us-ascii?Q?pDE3tb3pRJfp6wRoLrVTvK3Cw3waOyPhZLR4QavwoPtqAgNe7jAhiKiY32Ue?=
 =?us-ascii?Q?ai2pQUDCQF7HjI2AHdcdfx/ZeKosp529FE+8CuhCj3gtBAHsbwVhveL6QY2F?=
 =?us-ascii?Q?hf0zj3HUhVSZs0v/dOe785PemdGte+oBOyd+7tQnJEBCKj/I2+EgzocdmUIG?=
 =?us-ascii?Q?i1s4dNDD85fyZpw4oxRFxkiQcmzMVKN0qk2fPWjwjDNrjYnQiy5ZijUPBEjs?=
 =?us-ascii?Q?0OQReRC7FADmql13qnziRCwGSHWUYdjbSc/VUlFUQE7Uq70721LSfSwtDUqF?=
 =?us-ascii?Q?NA9dbwW7XP/FqEGK3ssypLdT9JzGC+6YWoZZn2K7dpqwNBExCTX2HCFwL2Ei?=
 =?us-ascii?Q?fMcAqk9+KYBqCqEDdXyP+upYMnxNGeG5MfS/Y2Ru42+/q+PPVA+zi3+qt8KC?=
 =?us-ascii?Q?tkajmsPAUv1H9Q9PIPVsLenJQKgDTgOnodj+n3V2uneInB9lSm9qWNsFz9DO?=
 =?us-ascii?Q?sOCVK4/XYICbIcr+h+p7eiorPcDlCG7D3iRzBHLBuIg21hiwlhJcIACCvpqb?=
 =?us-ascii?Q?KRLuoWaeXgM22AJe/sQg0NnoAtItnetJoNlxikEQ2hfo+ocVID7EisgWwosV?=
 =?us-ascii?Q?c+aN1Ju0J+BHndqDhgltNzcU1TDZNaSRGjAnlsNGRUZaSS/pAFy8EaVBX+mQ?=
 =?us-ascii?Q?Jz4cHbNslUY6DwxLq9it4nwzrMQcFZCrLJiQQjdYJ0Hze044JqicRVdtThhY?=
 =?us-ascii?Q?KhTbycOgEVcsxfyfQLnr9yJWyqw30xwLY0PyepcuvTAa1jGau0hP3jDKaPJD?=
 =?us-ascii?Q?XVYk3mzeBv41V/5ItXNQw30zJgw1Zk0ZJ6S13WQy2ckU/1lSHH0GX+60VCBQ?=
 =?us-ascii?Q?dd5OFCpkzlPOg1V8CI9+l1TrS27LuEvrTQU6OU2KjStin2i6YA5G1eN43zqb?=
 =?us-ascii?Q?qJqArD/WeDniQMgP1yHowXRsbUiQU8fSxpo5tVw5uw+uCClfn/yIOrDBewPm?=
 =?us-ascii?Q?FQGtEQ++NOEFwmyO2RrigqZ4aPCkR1V37kH1QXdiS8D2zOWuRGWE8KDua5sh?=
 =?us-ascii?Q?TCaWTYdTNVFq36qdV0FRDWhvKkE6nOqsK/VZS7pgIAIalvUEABjwwu+sehJ4?=
 =?us-ascii?Q?/SCh2QWSSAYNvIPMX2rt4naV5M2fc9sGT9DFjlbhJ5HZAPe2RcgLClkO4WF1?=
 =?us-ascii?Q?Z3wlOosSs1Dv3QOqRxEUJ4h+W7FB4FEPfFogra/0oD76lnAN30BjGPquMyud?=
 =?us-ascii?Q?k0jFfzb+gaCIlwjG86K7RcVsV5Sl1xIiPefEfbB+H9Z4DB2A0Fz2aoPS72G+?=
 =?us-ascii?Q?NvC4sRyDfUkXC6xCYJC6un3DKE0OPBbRy5Ei8ZMdcXZqqGYSbPYMlxJchT6A?=
 =?us-ascii?Q?8r0Yjnl2C7Chbmh1E3RsWbPqxene8W4RwoUho2xBMsqbjgVwYwgkrFNO6SF3?=
 =?us-ascii?Q?WjZXd1pRnN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4z75YEkIZiPNwvaIs2rMpqxtT4r1AH0II20Vj+myh9kfDN51K5FiSppklmqJ?=
 =?us-ascii?Q?ti2AOcLbhMaU4Lm2angE2AqnfajgNYdgQ+SgODt6V42C/ryOGsa8+DsX86uW?=
 =?us-ascii?Q?v6JILj9zx4KDvadIy6ZizAMDUjjTyA3sogFXy+s83DKkiumligXV4qF/9W4K?=
 =?us-ascii?Q?VvAx+QvK1zPz6ko9HJ0eOi9Ey0bdMWkUE6lvaFwRQ2DFThQ3zTAy1Co6dqeS?=
 =?us-ascii?Q?dI7RkzEDmthQ6Tk+kQLnqrPPmXTGuBqXXJ1doKBBAQP2lMf5mqG7OFubV1F8?=
 =?us-ascii?Q?HjzmclQnb7c4eIHH0ZjZiALtXg9kc0gLPKHcJiUvdEpfBWzyojlMJ2AtJHPO?=
 =?us-ascii?Q?OGODAOBbDMeflNMEbeHMxg0greO70kuPgN7n+qXEr00F5f2lHhwmdfatanRo?=
 =?us-ascii?Q?iVjdOWdQWMymAtArR9S9ZJloADYt9/uDlmfxfrKx63AMbDe+rgAU5tS7H7O+?=
 =?us-ascii?Q?aNmMODu5KxzywPYe+f7mrMslWkbSMYZTeAMTMRWq6tAbaMinh6SW6UwvAEtY?=
 =?us-ascii?Q?PVVUawd7QgZVq4bQiER88cbRxJM2ZeTgIQsCN+H/asUzlodGzIzEBOXGYHj1?=
 =?us-ascii?Q?d+EkMmh/kJfjfop+ejdH3Fgd0yawP/he1UcOzjFGTpdn6blwFaWg8mbPe0WI?=
 =?us-ascii?Q?JleIct04mtjdUf96emOpS3Xg5xKG4WNQhPZurBQ4tW5u79+pjWFIg23PL5lL?=
 =?us-ascii?Q?FsIbnaFdxcdJOWypwrCZJkAB18blWPY6JXWErErihfM5NjBhlE3sUNXWM8Uf?=
 =?us-ascii?Q?vJYuZTLyS7chHU9aWQDTbfp2VTYpvlbTxl+/0pfyv1yu83+OV53X2FooFEYV?=
 =?us-ascii?Q?y7TKb6MWMQ1RIsXKddfDFS7GQNOVPIzlAa6vhupvmcZHI6nxk4KmmpKShLtf?=
 =?us-ascii?Q?afbdmlDqf3vkjbdgBu5hlVlf4nRIpqLWmXE0G4+b8Y/L0tHe8jRXqt3UuR5I?=
 =?us-ascii?Q?GcpP+qsJ6/7Nd1Wxs9E3XE6wW57wjTSXfE2y5nhFqexuKYleqQnaqUtiCxmu?=
 =?us-ascii?Q?q+u8yx4w7aHxLF4HQgeBK29taeJudjfG/QOSO/XfQYNi+AqGeaka2o9QOdzX?=
 =?us-ascii?Q?s5lNIpaCzaUZ3RH0GEX/yQOs1yRMuL7Gg/c2+n42p23HHldCOmJc3cIR+HOI?=
 =?us-ascii?Q?AIuPnsO74i/aMqKqvKKJ2fDhlUGU1rcxQHUP9karKTrbBlGKM3/RoXz57WM9?=
 =?us-ascii?Q?iMPve3079QKDF8fjU6Ih3JjqLM5fcTp+kC7+AKDa5oIhGAw/XVDmWdcNu5Tn?=
 =?us-ascii?Q?i8SLwFKLpFDn7JTBPDhA4mobznYosVGrlAj0eg9h1aXkmQ536gjfg3Q+onTi?=
 =?us-ascii?Q?Y7EWB1iXksmh6fdwwPNyAh1j1llrtqnLhtJNr7kEB83g30JHRtmqly9zzPE4?=
 =?us-ascii?Q?18wYhr/PotEMfK4PdHumtuYNY9agTlt9P+70kwRXWvsEY73s6aWdCR/ROh5u?=
 =?us-ascii?Q?MLZDEkY2GqMtSVQTqo7whSsr2IilOCBU6NwSJ2o6ozZRdiCmCdaZPlrcjiFq?=
 =?us-ascii?Q?y8TY+pZaeS0FM706TKEuG0pFtrOgEb3jZq2SQ05LvqUQnibbCZuQr5twhPZf?=
 =?us-ascii?Q?m3rv9yfMxxgDLydfJD8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93572e58-4575-49aa-82bd-08ddea232cd5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:18:15.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxR9jT2ot+UjvMKRUh4+v2VzpP26XjR8Wu9J5GhHKVzw47Yh6PoTfw6ZhjORzAvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

On Wed, Aug 20, 2025 at 11:30:08AM +0000, Suravee Suthikulpanit wrote:
> @@ -605,6 +607,9 @@ struct protection_domain {
>  
>  	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
>  	struct list_head dev_data_list; /* List of pdom_dev_data */
> +
> +	struct protection_domain *parent; /* Nested parent domain */
> +	struct iommu_hwpt_amd_v2 guest_hwpt;

guest_dte is a better name.

> @@ -2616,6 +2616,7 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  				    const struct iommu_user_data *user_data)
>  
>  {
> +	struct iommu_domain *dom = ERR_PTR(-EOPNOTSUPP);
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>  	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> @@ -2626,29 +2627,31 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	pr_debug("%s: IOMMU devid=%#x, flags=%#x\n", __func__, dev_data->devid, flags);
> +	pr_debug("%s: IOMMU devid=%#x, flags=%#x, supported_flags=%#x\n", __func__, dev_data->devid, flags, supported_flags);
>  
>  	switch (flags & supported_flags) {
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
>  	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>  		/* Allocate domain with v1 page table for dirty tracking */
> -		if (!amd_iommu_hd_support(iommu))
> -			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		if (amd_iommu_hd_support(iommu))
> +			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		break;
>  	case IOMMU_HWPT_ALLOC_PASID:
>  		/* Allocate domain with v2 page table if IOMMU supports PASID. */
> -		if (!amd_iommu_pasid_supported())
> -			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
> +		if (amd_iommu_pasid_supported())
> +			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
> +		break;
>  	case 0:
>  		/* If nothing specific is required use the kernel commandline default */
> -		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
> +		dom = do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
> +		break;
>  	default:
>  		pr_err("%s: Unhandled flag : 0x%x\n", __func__, flags);
>  		break;
>  	}
> -	return ERR_PTR(-EOPNOTSUPP);
> +
> +	return dom;

Why is all this being done? Nothing touches dom on the return path
here.

> +static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
> +				       struct iommu_hwpt_amd_v2 *hwpt)
> +{
> +	if (!user_data)
> +		return -EINVAL;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_AMD_V2)
> +		return -EOPNOTSUPP;
> +
> +	return iommu_copy_struct_from_user(hwpt, user_data,
> +					   IOMMU_HWPT_DATA_AMD_V2,
> +					   dte);
> +}

Don't need this helper, iommu_copy_struct_from_user() does everything.

> +struct iommu_domain *
> +amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
> +			      u32 flags, const struct iommu_user_data *user_data)
> +{
> +	int ret;
> +	struct iommu_hwpt_amd_v2 hwpt;
> +	struct protection_domain *pdom;
> +
> +	if (parent->ops != amd_iommu_ops.default_domain_ops)
> +		return ERR_PTR(-EINVAL);

This should check it was allocated as a parent domain too.

> +	ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	pdom = kzalloc(sizeof(*pdom), GFP_KERNEL);
> +	if (IS_ERR(pdom))
> +		return ERR_PTR(-ENOMEM);

I'm not sure it makes sense to allocate a protection_domain here, this
doesn't really use much of the struct. Can you make it into its own
struct? It would be clearer and safer..

> +	pdom->id = amd_iommu_pdom_id_alloc();
> +	if (!pdom->id)
> +		goto out_err;
> +
> +	pr_debug("%s: Allocating nested domain with parent domid=%#x\n",
> +		 __func__, to_pdomain(parent)->id);
> +
> +	spin_lock_init(&pdom->lock);
> +	INIT_LIST_HEAD(&pdom->dev_list);
> +	INIT_LIST_HEAD(&pdom->dev_data_list);
> +	xa_init(&pdom->iommu_array);
> +
> +	pdom->pd_mode = PD_MODE_V2;

Nothing should read pd_mode, please check it..

> +	pdom->iop.pgtbl.cfg.amd.nid = NUMA_NO_NODE;
> +	pdom->parent = to_pdomain(parent);
> +	pdom->domain.ops = &nested_domain_ops;
> +	pdom->domain.type = IOMMU_DOMAIN_NESTED;
> +	pdom->domain.geometry.aperture_start = 0;
> +	pdom->domain.geometry.aperture_end = ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
> +	pdom->domain.geometry.force_aperture = true;
> +	pdom->domain.pgsize_bitmap = pdom->iop.pgtbl.cfg.pgsize_bitmap;

And all of these are unnecessary, should never be read.

jason
