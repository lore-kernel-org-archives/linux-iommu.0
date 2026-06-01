Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9A37A49D
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318298; cv=fail; b=VLs98dpAJLktYrU4gkFpNAV3XwZVwQ1tnHhQbRd6OhT9zmJu5EVQyrvT1grCtXe7Fn/si1cJHlb3fB6T+MAW0TwnDqwi99EhIZNf/SfG7b15C8afEXGrgczgbnEt+VwJswWv/eTKhqipI+cA5/cgbcU/jYvkNG+hn7e2kDJLVT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318298; c=relaxed/simple;
	bh=VvtjK1MuTHO8yerzrd22vtPVpkjY72F37p22QfqtDMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhHPx89d2yuw67OB3VWBD2z+UAd5boi3s7HvRtz+27Gf75CWTbLabBnzVIQKiZEbUjlCZG/yuh25mGLOLI3S6vCoSLXXasyP3XIwJazSKYTYMgFtAFN34ezSCiwSXLHAwa35ccctRbgmoNIQl1fgi5odj5pAtCP0jL9DnD/EJMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZuSaQCpk; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZuSaQCpk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlBtMD3Ltak1lWSkaq+eTTCOZYO8xwEDjy6ewlsWmiFl5pdTm+svAGlXRdz80DRE5RPHqC2utY6MTFv2knaQPTAV5rYTwpWUQM1yk6xyN7IbsJXM8ypHGEDF6XaGIabpQk7dyq2vWEfTr86u1pYiWfCptBSzIhLqr9CITy8Kvi8HBfPd0M3Act47WQO87HHEcBs3i4TpsP7s7Myn+P5/Kzz+TZJ7Xof4siGGR9k1nZbIHhTbUU4fEyFBp7+pV7RbWKitPulzEW/OxdDrL/jXFEM3XBq6LrB4nntFw0QxA+YUdDuZ7ooJQFm7mgbi/l2HO24GsXv/zzNFOrT0fsSMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgkEFX34OiLE6mGq+I/aIMgYJFbYlbCl9eEtE3XL4ng=;
 b=jM5HT/2tJz29WAofiNIAglCBeYvt79zYVyH5FBbeLfJyIXE+K6u1gYPTEDbBs96dVyTmNQmHvbH5DfnH8XwEuz/N+vYKvCU++cvDd+rhWiP4rF0ZMcs6Y39jdWgMurDSj9AnPKZ/q1HErSP1pR4IokjkpNQ9QFRULV15w4ByO8tPGXxmxXQ1WnpRqmecSOo4xmITini+8DJS6wMeV5rfPL8GNOJhM0V+mK+eyXByJMNHdsNgJ8iu8cP4DFOkq5LT08i83vVxTx/OXYc1ihDtdNwCpQudHaKyD1hoVzUWqkbas0IDNvvc13z0evdGyYX47kylvtiwjOdMIFNwMiqy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgkEFX34OiLE6mGq+I/aIMgYJFbYlbCl9eEtE3XL4ng=;
 b=ZuSaQCpkSrAJsWrbUA6MHORgvOX9dic7T6ZLCayl9DPSnIO+efbTnZwBbN+/nzQuwgXWC92Q+nC7iiDzGn8QkLvkOkwgKPlE+dORvaWqppRs/BwO+o5Ih2roLhyZtKGju6VZAswwh40XfGc0bbkKNZHvyuNoqD+rOJusQQJV1qupYYhPm2nV88KZ+CiTkpI37/Jl6yA63zaWnmoy/KeJlCRVftCHnSd4Lh1TW64GFE/yvMNsAbCheI1hHrIJzhQqOtWQrKdVzo+kRQDvHlPpPXbro8VHuohKEVvaj9pP+tKbX7OhuIHa5f/CN48QSH/gk3bUqjTz0woGoOeBl9pl7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 12:51:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:51:31 +0000
Date: Mon, 1 Jun 2026 09:51:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 07/26] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
Message-ID: <20260601125130.GJ3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-8-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR15CA0054.namprd15.prod.outlook.com
 (2603:10b6:208:237::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f073a36-0e22-4fa1-1b54-08debfdc8143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tEMjoipMn6VdhS3shYlALOZoNs0J4JHipCQEd/LCUeP7WN99CR1ltKW5WItjzDEQzyeo3gXWmxQcfdYaZAz//Id+bclRzdxMIBydvbOkmFswZ04o5upgDKHhesf+X48K6/ZTy6gFgbQrAmfOMsp/f2NRKMgvswTcQzhv/75bDLPnecM0iE0amLour95DFyJxNJugnHTrDc1cVG9TNQ1s6pa+VNb0ZgR5b+Rn21BLiMxFxGth/ENHS5Q0PPi5bExcsfBjHE3CXnFX0bsQUMncJWJ2WLstAclq5DqGZdb1hejHznSXFgcCxW5tFgbHOW4hehzcL+g+3vQAva01HVeeQov+RvnPtk5QA/3WO4zJ/GIH7OImbYp8CQtJuhcKTJA+yOE3WNSjaD8hx76Xqv4ITQRQ/WfNa/Lx7ocLtK3NRMH0JH9YkUz4oCjFdLqMc3DVrIf2uB5IMO06Ah++AzJVXNjplcT2cNiPXMcQVfBgx8xhYXz7Jq3fS+oXX5Kz4zdpHKfUjVzTAkMCyjFTl/TLImjmJwbEjBHgAMKMMbCaT+yaF3Pxr7O0HR0KmJR4tMxdbltcQlo69Fx4yqPMe5RwL5ITI5lVhDlpGWCCstTGEWB3cZLtSCVEgUClzvzxoRrfDKhMIfk6N42WPfRDwaUJ75S6ETEFkBYlrg3DXEPOpr/HQGS+Pam5jXEopQL+ZM4G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tv2dR/6vypiDw2vlO/y7/Y2gOk/O85AA2pbhrfmcrlLrSEXANsifRDL19trO?=
 =?us-ascii?Q?U2GYkw0y41ce+CftuAw3ENeMrOqR3kQqZZ48Vi9FT1ZyTRJatEHQAlcf2JZY?=
 =?us-ascii?Q?NAAlaLApjimvXPqlldBQpI+qFvcB/M2y7vqdmY5bNVmkoYDoy7Kvz9fn7igo?=
 =?us-ascii?Q?9oycXKSM9YDxWj5TBN1TiYnI2UKU/2m64m57aKnFU8zny7fYSuV1Fw9Wdxbe?=
 =?us-ascii?Q?E48GQNL985XOKTWUN0VlB0+D/fv074zjBBQNyVCdcZFx+aekAl/9U4Vh8OX+?=
 =?us-ascii?Q?LNjELh+Fc3hACgIvkF9BpJPZwsO/HIJSiFpW1k4HhO/gPL/DFCS0BqjK7SZm?=
 =?us-ascii?Q?HbJTJXa3liqDXrUa9+Ug9QR+WMp2kOXQMNxiswF41ZsiJiKJzPyZrCYoCbBf?=
 =?us-ascii?Q?Vd0vwnWYcO22k9xA5BpwJ5PedrQEvQoPTeSRUD2OgoCQHUxKnPKvhxAT8QAd?=
 =?us-ascii?Q?JHbbaD14ROJSnPMushZesEQsD0ARAUnFl2thJAJosRSApOvYjoR4xw2taGJn?=
 =?us-ascii?Q?4NT4envkqwgfhcJ15Cav06W1ei8FALJLZ1+LwmwKm72jDsZ0nzegOZ414/CF?=
 =?us-ascii?Q?JNEBm2dTE0arbDyMg63M1DHJyKsXd+27ZzF/suBb5IjmPTtnk7+U3EKqScEP?=
 =?us-ascii?Q?SPPc9LZAHXs3b72y30+4eqk8zqHq40BKAfFgxMywG1kUdy3QE8MqKyZrP9SW?=
 =?us-ascii?Q?f1cEq2Lz4//QmAcL72fsmCwKDdv/y4UaV2Ag6Iq5vK87uRN9Xw3kSq9wKZYX?=
 =?us-ascii?Q?NXzxltAm0yrb6b2RuHBJBnx/TfrS8AxDhuhWYSP1sl/0vyQsuKvW+oJ4S20M?=
 =?us-ascii?Q?RItcmgXXCh+8kW4a/y8g8I3kf9vRryO9Zii1yi9G8HJZyQqiejF2f2k9E6Om?=
 =?us-ascii?Q?uWc1cJJuOxKuGvM/zbgYwnjvnBaNmnrhz7FGLoMzW7Cthhvfwc3KtVSRgWCA?=
 =?us-ascii?Q?YSBc8J4Jo9uAhNiSOxMShdDDrjcFDCPWrG3Bepqct5ivOPK4jDfmx58itzsR?=
 =?us-ascii?Q?YTtIUcs0gKc6L3RrN9+pHjyKZL0SkqBMPVRC1Vd9EpLpF2Ku/pLRrEQszbvl?=
 =?us-ascii?Q?UfD8/eoztQUY/lz89Mpjy4d/m6SKkzC+vViJzRBj/GXA7qCYD1ppyr8BiOfp?=
 =?us-ascii?Q?cBgEkUG1tNvkz+RyutgIGt1VUTtvDW0GyaCTdvKLbYMyVPCFf/rgIr5VATSP?=
 =?us-ascii?Q?ZKDctKBhOoFcxIouaCWS3XsojJ8SjxAqQCoQDD1ZPHtIxnESVTjWE/I5gcaw?=
 =?us-ascii?Q?4WaRD1t6mjUIuM/TcL1f62qlN9FCnCkGB/7rXY1qNvso3vxJJmO520y6zfvf?=
 =?us-ascii?Q?0gDjqoOguNg6PJdGLwRM2jybBFYU3KcVfh/k5gbMQJvSH3BZU2MbwM691tur?=
 =?us-ascii?Q?fPGdvln3nt4vgDnjSIC1XougkK4ScChDyRvsqUjNo6pNUSqb7WFWeCC5fjDw?=
 =?us-ascii?Q?0F+/jRR8L4jzb+1dryST7CLZdHzYjEXNW1Irln6StHt4199irEgmYDFCwQfo?=
 =?us-ascii?Q?tQO7XAd2o6+CeNcRBT5/q4tskGPq2RJfWFVBfQbprbDVX0yfTCSL1IPCZvbY?=
 =?us-ascii?Q?JiN1/sOMnl3nxOko+lpH5Xk1UhRpAGi4V6RNf8xP3fh12bOG4Sqb8IZc21hi?=
 =?us-ascii?Q?SODYe/0C9PxUqXrZ9VOJf4BGMnXYYj2rZ3GVJeD6uSIz3z87zvkxE2W7ur5A?=
 =?us-ascii?Q?ILetSC5iKEmpeQ7hjb0ZY5Bs4/WXdG4KjBkFJ8JuDEMrdr+H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f073a36-0e22-4fa1-1b54-08debfdc8143
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:51:31.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hUynj2PVpdPFhPK1v5jxcAhJ8oCOHaWfDhpCYeQxlX00ZYuxxf72utfhVdu4968
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113

On Thu, May 28, 2026 at 05:17:19AM +0000, Suravee Suthikulpanit wrote:
> @@ -68,6 +70,16 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>  	aviommu->gid = ret;
>  	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
>  
> +	page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
> +
> +	ret = iommufd_viommu_alloc_mmap(&aviommu->core,
> +					page_base, SZ_4K,
> +					(unsigned long *)&data.out_vfmmio_mmap_offset);

This should not be casted like this.

> +	if (ret)
> +		goto err_mmap;
> +
> +	aviommu->vfmmio_mmap_offset = data.out_vfmmio_mmap_offset;
> +
>  	ret = iommu_copy_struct_to_user(user_data, &data,
>  					IOMMU_VIOMMU_TYPE_AMD,
>  					reserved);
> @@ -82,6 +94,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>  
>  	return 0;
>  err_init:
> +	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
> +err_mmap:
>  	amd_iommu_gid_free(iommu, aviommu->gid);
>  err_gid:
>  	return ret;
> @@ -100,6 +114,8 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
>  	list_del(&aviommu->pdom_list);
>  	spin_unlock_irqrestore(&pdom->lock, flags);
>  	xa_destroy(&aviommu->gdomid_array);
> +	if (aviommu->vfmmio_mmap_offset)
> +		iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);

I guess mmap_offset could be zero legitimately

Jason
