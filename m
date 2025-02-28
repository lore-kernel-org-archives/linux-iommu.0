Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A2F155C97
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756783; cv=fail; b=CUnBicpX0PwcjPHA0RJG/sWVRp136FGwEZFrW/82lOsPILl9hEyi8/QKG+ih300LRzHhJWLhrYChnzIPYaNfxhA+OnOMX35MVsKazy5rxmutWA6THuPwwnJveUsvIVzI8zi/WkuFKhG4Dlj9JFlNa79gogaPr1Cat7GHBEA1Mp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756783; c=relaxed/simple;
	bh=6jkTU/X9BCm8p6AJKBOcZe5oFJjsBGm1UtvNNAB0u5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sgD146EFBB3ozFYak/P2k3iIt2oEvsRAPyGdLAyeN7vXM15dmed+p3bH/KNtP33esbTisikshZ7Prk/Vv5knTooNNK1n4MeEi0uFCpVA5BzW/DwyAiviBCSmW2R8O1EJBmYVpBklrhJe0gFSEBmnAl8hVm6ZKyvXRkxTZCheEnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IWmdwztP; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IWmdwztP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xioayh+wDNgJlGNag7PkmQKVO/qMkvG10PqTgO9Jf3aND+Z7NiSGw2GgVDGDw4mI8ZQEYwMgEgaJkGfh6a7biUEQccQnMugoCbid3jnuHiywgQmAWCMUu9HF2gRNadrX9Ba8UQJ7CBGn2kTdYXMiXZxWzAfML2Y3J4lLasQlVPR7YmDFPz0uVU2vn6N35sDqU4pGS/57YTZbS5XksslxhdD4NvIMDXLz41b90W70uLTeOodmPkYKsxnn4Qr1KwcI1xnMTSGuWvbzvDQ8ujiz+6Uvxy7UCa4W8v+byn0NrwMFgEYTXpVWfZRfepAm6l5R9J9m75/IKlH8AiLftqepKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N3993HOtRGoaQ/vP4e2nxvk2BMpHV3fNZEMiKKcCsE=;
 b=u2pMsxBOSX0LBvLF+wc2ZGf7wef6a9IWRnO6YQF6oLYUKepuexNUBSycCz+Ccb7yvQnjiVxM43z+e7TEdHrU/RwpWqzrf6iau7KQvkjWxjElvZ/AOQ4XNTvbcD4f1P7sU4wbKRi2YnX+zOfOGGU63zx1SPOvB4mLfc4AeTCXZuKfjAYrWGKfHU6rhecU6+GGGZkQHZPuitGJpcbZGzMgggnnT7a3uxw4IHKod0E6zhXuEwz8lBR5+dieJZ0sTkLDgmclaCt7/WzOuUGG0yP5S0Lb6nS3XRLkDyM9V7uTGnSUiqCectjCXA2RLzOZhLpdqaOEIsHdHzOrT4hobt4Arw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N3993HOtRGoaQ/vP4e2nxvk2BMpHV3fNZEMiKKcCsE=;
 b=IWmdwztP+I82ghm7Yf/Ftfl/TO8aR75p/Waole5Mr7H9M88nSuZ0jnNGKh0vnM6PogOVsYNe4qdo4Kv44Sl3H6slr4EHJTW4EBpbwy3Yo55pzQiRDztmY0ku9IKQPHcqZOzlNb19cbx99zEvW1FO2sU665xXlbWaIIK/wIFWcdVDgj6zPmlluynGG99vZde0sotJr85jeeh0I+aYPmGu+MfDroQRLFbPmifF5GTg+bleipFS+cWWG0vwlq66IjOODKqH/AZ9rac21pAT4C4zUw1zm+G4xAF6eSwNW97Dx/WBC5U/tNPVxv1cAhoHz6V0GVbw9f2ToeormKCAZ4CIsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 15:32:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:32:53 +0000
Date: Fri, 28 Feb 2025 11:32:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v8 06/12] iommufd: Support pasid attach/replace
Message-ID: <20250228153252.GZ39591@nvidia.com>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-7-yi.l.liu@intel.com>
X-ClientProxiedBy: MN0PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:208:52d::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df726d4-8573-4211-a3ef-08dd580d2ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9BBZLjB+jKpFlgx3WT5EtIqyWslrpIejaCOYQpHb688a4CE84EJpceJNPfm3?=
 =?us-ascii?Q?nw/UvbflaDa4QONW/D9O9yPcUrGGO68cXJTqMQt+hGtgq1lGkxVA+bk/GPK3?=
 =?us-ascii?Q?DaB11H9A0v0lRkw6dV/c+S6K+Ygslgt52g0CaIwGMpcdwj2t+SQquNwNb6u5?=
 =?us-ascii?Q?xI1AtHOk/nm1NZZxIr1zQp69bEncHxAIu7SS4y+tHRLgL5RpWV3gjkwfwvSA?=
 =?us-ascii?Q?h1wCR7hUbInWkT5bygOB31NFYrfAu6M9XhxTMDMr6OSXPqEd9UzoGk3B5L3X?=
 =?us-ascii?Q?wqTj878oPibitUATdnPg8bs7DMFj+YDUyuJWPy5ulE0W3xRIXMXkDWxB7Yzg?=
 =?us-ascii?Q?fXmUbQiVlUz+4D8WjY3Jj5a6ER+WYUtHPHudIKFVa/7+9lM16jTV43mOJang?=
 =?us-ascii?Q?Vp/Dr1LMGbKn4K/QMzT+4Y25b+efyV0KQJnxriZloZ8+vquQjXYKss4UQX9N?=
 =?us-ascii?Q?R/dg52+DF8SCJ7hwQlviZu4J33gdOYU6q1UIdr+ux94iE1DJiVO/nYKndTTF?=
 =?us-ascii?Q?75nbhKPGG2jxg0O5FwU6mfnbZn3GML1AyCZMn6C8IvuJIZx/O3O44f3ZVYMK?=
 =?us-ascii?Q?CFDkcoZB/stZMM9gs3yPA0UqiFjFYKek6s0v5mXPwXah0z3zxH1mjG4XNDWO?=
 =?us-ascii?Q?28uu2tmfiT5ahoJOcOJFboC7nNdocq+ii7L0faiNmH7qzZmTfpqsp2ZssoDT?=
 =?us-ascii?Q?Q4Jk25tF489BF4CvpOz/Uztb28aljj6FytNay6d2OS0Re1JquZKrrDP8yrJD?=
 =?us-ascii?Q?iTuyHFtt+FKYy5+1lUMkAJqxtFlnOpaOulnQkhm2gXWjsGiUBS12J7C78odd?=
 =?us-ascii?Q?3fDeG8Rf5Xhab5rzzp+SH4oSNdp0RM4jl81x17NoJuIrkZVxmOIFOoCvZVpm?=
 =?us-ascii?Q?9Pq2CnpxUylDBQr2XiYSa8X6in3+1Zx5yGJY3lYbpVfYZFtiM7AcueVRD/tO?=
 =?us-ascii?Q?glMuR2UzdJgdYlTyI5sXunnGNpqQ9cmUK6wIG/81lwOD8+F3DOMp3s8tfQUg?=
 =?us-ascii?Q?bmt9C+i+UH5BFHSL/Pg6kWSxVcCnSHkOrTmoZF5pdvSwhBQwa/tvty/lJ2SU?=
 =?us-ascii?Q?7BSB190RwC170PHvB4xZAg6EEgeeZZnD9u+tmCqaRHRpfVVxTdUu2jLjoFSR?=
 =?us-ascii?Q?K8HUQ9HZHwUCYPjjlNUI1njisE0nTQy2UqFpYIA5AVCDIPaT9CbRKpRCvNKf?=
 =?us-ascii?Q?xWgXTaIsS4g2xe68/MTaeWf0X7lAYFLe5JH2+99yuZQlE87yQSD0YGHYhflk?=
 =?us-ascii?Q?yWwwRaMLsLuurHbzgCEnBX+ZnV7Y9sJQeJuGNjxNbLuPzW0igTaXYEJWPDZf?=
 =?us-ascii?Q?1PsUNf5kZFkimRuxtjb9pqV9kC/JwtwfwGQbkg9ofrzmdrYgdiG2PR05bHgc?=
 =?us-ascii?Q?fngcwvuh4BsnnnrUmos3hN2k9l8y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcSVO0c6f1BA+14Iui6QhR2IduXsVcyGbPexOyE7uOfv/eBT0OlAqfMQGnFR?=
 =?us-ascii?Q?9cVnAc8goe1iqC2GxmqtiIygk8JvkpMbvu/ubdocgM98f4n+B0WAy6CcEvm9?=
 =?us-ascii?Q?fHKQ6WABNMCsBsbY+YdgCZEDG5yrc7yNR4bGxTPBBv50FX0JO8KHYbyCt+c/?=
 =?us-ascii?Q?nCoPM/cNvj6jC7cBFvfBkWtCPruqmsWmKhnnl3fL1dJ7lmUmSWDWMkODyrIn?=
 =?us-ascii?Q?0KgVQPC34TDdJ+BxZg0ZoHMzEiRqbM+Bdx7NUnZZKAkIB7UiMBGPLMpggdhu?=
 =?us-ascii?Q?WcvLYHetC7mSLkSo9u3i3iH88MCRLNo5ozXxG99uvKs43kGv+NV2mv6LPEHQ?=
 =?us-ascii?Q?T/bNevx7rPKdcUgOlwqDCfUacRQO3q7V2S87K7pOxQOgn5IpNNM/NEIvckDX?=
 =?us-ascii?Q?OsZm99hW/3lNpLwuur0x2yZZP9Hc2fFag/yBqQryyXjtXaDeAErYEzaHkkmW?=
 =?us-ascii?Q?ghs3XMa+stFCzCjyUtij1zzbkv9PdRGGKAwNvHg9xllj4fHsBAjb2w+gvI8K?=
 =?us-ascii?Q?ny9Zi70ohD61C+jqZxeMkJGw2Th4Q/zUZqadTlMHdRJ8oe2W70nphYAvVVsD?=
 =?us-ascii?Q?2C+Qwiq+5FTJQXu3QDO8qTOFlLNjM9YKm8pJV3yjE6QS1KERTW+XjgDRGUa2?=
 =?us-ascii?Q?425qJMobjPJSGTqniAvI3zFBByR5rXGhi/LdYh47VmyuulruYga4uTGAT9i6?=
 =?us-ascii?Q?apaK8/KnHrOtMAxRQ9IcVguuCFij3tAt/X4/0URdoOlHufCakwtnqgFw5ETx?=
 =?us-ascii?Q?O06VOZXCUMoUjLnsxYoorJaxdZxMMvnQt9NzkbOULcv4oDJIgBc8J8FtspjC?=
 =?us-ascii?Q?8i+AJyzfFBT19+AYO92yAKlxJbpW0EDRBNK6uXvdpTYbdrKzovBKZskAV9Pi?=
 =?us-ascii?Q?EjlBhJ5L69JH446BIJfBSXH2G5cWh25W5HzBjP+QaaqoSgbIadN02tDjH50k?=
 =?us-ascii?Q?KnWkwwZUbd7p0CYaX+YPGNyJYB9YQZb40vxJ1smuuKzuv3VKDKQP396nUZWI?=
 =?us-ascii?Q?o4UM0NjWL56vBT7KsDO4Yaf2I7KvAAu/gs8ajRRVI+/xG7TzvnQb5jzSmAsY?=
 =?us-ascii?Q?4N23QLtBtcfvsnKHZnrDTgTkU7brfqBM7hfXr4TmuD7qnEMS6PAOX/AXRi1C?=
 =?us-ascii?Q?nBSWpOUjcRRWcROam7dgvM7dxMeCP9Fak9uRPXgea0SD0dyluBLX0fOgYo/B?=
 =?us-ascii?Q?Cbfa77cR2on8pfcgQWHrbFA165KbJGT2R0SUhCp0wET/Y2HKuAqy5pMgMKFs?=
 =?us-ascii?Q?ry8ygsp886sFXSwVCUT4K1Tj/XIP2yis41Ngq7XKaPRKrz1ookmob2yJKpoh?=
 =?us-ascii?Q?Q19in6wrVmsuNgrLRSQjDuMDGPolrvwPrCpuEIup4YgZyO8G+bKFOUwcQx7h?=
 =?us-ascii?Q?7NEkK04VUbQjwDXlQvcWVvt3ksFEEHGd/vloQhgLYbK9bRBLcJBe2BCRNhTS?=
 =?us-ascii?Q?cQYZ/VCUleZC/Y+PIRUnxS3QVMGSIA0GEujSZwZZhHeuMtYZi0VIB0jWlzTX?=
 =?us-ascii?Q?+6MxkyXbdwSrCL5LkNwSt0A2jPczJjCrnlqQoWVrUg4sMJvgP65MIYRfgFTg?=
 =?us-ascii?Q?cyjCyE1MU54VWuOy5Ewm6rDoQbGnRxcI2RXi3a4l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df726d4-8573-4211-a3ef-08dd580d2ad8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:32:53.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgpdUETX5TjZSb7l7CLVvhIJd/Vyo917gYeA1bZ+G5WXMOLg1K7aqU2HL6ae7Hmn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

On Wed, Feb 26, 2025 at 03:40:26AM -0800, Yi Liu wrote:
> This introduces three APIs for device drivers to manage pasid attach/
> replace/detach.
> 
>     int iommufd_device_pasid_attach(struct iommufd_device *idev,
> 				    ioasid_t pasid, u32 *pt_id);
>     int iommufd_device_pasid_replace(struct iommufd_device *idev,
> 				     ioasid_t pasid, u32 *pt_id);
>     void iommufd_device_pasid_detach(struct iommufd_device *idev,
> 				     ioasid_t pasid);
> 
> The pasid operations share underlying attach/replace/detach infrastructure
> with the device operations, but still have some different implications:

You don't want to just add a PASID to the existing APIs and keep with
PASID=0 means no pasid?

> @@ -136,6 +136,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>  	struct iommufd_device *idev =
>  		container_of(obj, struct iommufd_device, obj);
>  
> +	WARN_ON(!xa_empty(&idev->pasid_hwpts));

Should this be in the igroup? That's what the core code does, so some
of the protections you have here won't match the core's version if we
ever see a multi-device pasid capable group.

> +	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
> +		return -EINVAL;

This hunks could safely go in the prior patch adding the pasid_compat?

> @@ -417,6 +418,31 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
>  void iommufd_device_destroy(struct iommufd_object *obj);
>  int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
>  
> +typedef struct iommufd_hw_pagetable *(*attach_fn)(
> +			struct iommufd_device *idev, ioasid_t pasid,
> +			struct iommufd_hw_pagetable *hwpt);
> +
> +int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
> +			       struct iommufd_device *idev,
> +			       ioasid_t pasid);
> +void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
> +				struct iommufd_device *idev,
> +				ioasid_t pasid);
> +int iommufd_hwpt_replace_device(struct iommufd_device *idev,
> +				ioasid_t pasid,
> +				struct iommufd_hw_pagetable *hwpt,
> +				struct iommufd_hw_pagetable *old);
> +
> +int iommufd_device_change_pt(struct iommufd_device *idev, ioasid_t pasid,
> +			     u32 *pt_id, attach_fn do_attach);
> +
> +struct iommufd_hw_pagetable *
> +iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
> +			       struct iommufd_hw_pagetable *hwpt);
> +struct iommufd_hw_pagetable *
> +iommufd_device_pasid_do_replace(struct iommufd_device *idev, ioasid_t pasid,
> +				struct iommufd_hw_pagetable *hwpt);

Ugh is there going to be alot of stuf fin the pasid.c? Maybe it is
easier to just leave the new functions in device.

> +struct iommufd_hw_pagetable *
> +iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
> +			       struct iommufd_hw_pagetable *hwpt)
> +{
> +	void *curr;
> +	int rc;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
> +	if (curr) {

I guess you could do the same trick you wanted in the core where the
xarray in the group stores the normal domain too, then I think these
special functions just go away since the xa tests are folded into the
normal functions in place of their normal domain tests?

Jason
