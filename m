Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029414;
	b=TV+tdNwtzBaKT0TYbQjfju+1pO2yGS/74y44QQr8lxbh3diWcZFwofYbC6Y8qB/rSPch
	 Vn0X+tb2UKjnPUus3KpgnyeYJ0mq9xSQxqHqQZHUqXvxYRDtXknnFZ/yrbtWbg1Yb06N2
	 fft0hMqGj+/4H9qe+kVrSi4P0seeuduXyhwbdJty4w32sJVutWoQ+XnRTAIi44INe/ZYP
	 mxtcl5jtWw3SgzrEXvaZ9pIkdcszBthfOZoNnogYj2SDlP5VbTiuVAE4KG8QyxGSbcieF
	 xlvi2Xrf2jxhA7oUCPRkfPGPEiqpfSzlbOufJx+acFOkrk/T4BzcEvyVMJ8WH/oRACA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029414;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=e+bzItnUwkVFMFtJ4tTysfsMI7UzK01AVp9AomVPTGE=;
	b=v/1LoFCBoZQQF7dTuwHzWFZC7R5V6ZP9dfuG/VXGx65TOqjaML4fZYBhqRPQp/LPp3xo
	 wp3uNZqCXELk6kBqlPaftaoIUtk//vdJjRkJzd9hcYUiuyl0gzOHzK75p6zxGH8G6uPIG
	 fmWsdygOa7SPEcBrsGYrQnKo12mB0pY/KECfiURzWvkBrz7Z0K9hEIwtf/DPrmfMKark4
	 xY76iIAJKNbLIZXDux9vOo6VnencoL9cLkOXTj9nEVEScMquo4scyI6dIxtzwdIvnR98s
	 Dwe60E7ZFA1i6XOVzradMkXvSJGZWgN+cXR5Cgjasr6cCdF+ZV6pqfcTntkX+g229Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gww42nbB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.40
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4415606A32F
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 19:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4415606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gww42nbB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPs9YRkK+5GENbJRUUbOEb9N9dl5AwS2tx1gVBdlA1BdiOE7RfqAKzLAaxYucyxxIP3zMBfRTu4Bq9wjwzEwVvW6sRKZ1V0K8jcZuNY14qHuC1t3aOJqWw9Pjlh3QTzgjC4Nzpp2dxaEuHsN4OqdKDd1jtWK3GoJuoPY19oUfV44sZfwaDiUE55B2oWYrXIDVSw3pZ3+KJ0VJd9KytwMvF1wGe+FTmZ/AInJCscYT15arkldLa/pLx/qnlC38RsuuMXTKUtP+SHu86E4lhYD8QCAGquVfaEnWNlaU5PQ1PqXao4XkTMimiaoGGwQkcY2heJH2M1WKuIhHJEsL5IAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+bzItnUwkVFMFtJ4tTysfsMI7UzK01AVp9AomVPTGE=;
 b=fWsXaV/smCuguYNjNfR6U0jfWG9EVSD+F5hgXXYmUzVdWBU5Ubo+tkMqKFi/s2yWw8fXR3ZpnlCV28AhOp458KzEmH0fgwOk6egh/a1VSTmHURnaVdCTB2mmziQIVhrFiIF+I3Doltp5eh7pAg4Po1iQta7HtJ9lqUEbff9HwTsVte4XZ3cgWw2ZVSF3PHwpr7wJWJ0Zk2jvXWlUCvNFnS9Q8lB0ofeU/OlWUud2paIIqhw9oL4FKDDd7eSVu1LgnIULa7O2mQ727dH1R/sk587YcIeySYdWWtM6FnEhr1uTA+RidjH1KvhIr/npNZitZ+n4AiX4y7hylDlL1gdXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+bzItnUwkVFMFtJ4tTysfsMI7UzK01AVp9AomVPTGE=;
 b=Gww42nbBqM8V/fXX/u6d9X0xjd0fBGY9fyUNcF51RwtCVSOmgGne2i1J/nX+VsITaHLitEOxjR2yXjbg0tpkGydFR7pfIIbfNCwDJQ42PsGc4iYL+A/M5GZD3fDSIumW/ZnlLO8YRV+xND/lr8ZFs6YhKTO1ja0Gd7WE+Y3FNS1xAZuuZn3vLP95rTVrzmdrgb/XCHhZhYwR/Scn5/2EhfsM8N2vYx9bl5CjwwpLqr3G0aIixHqreAq3gzncWtzfY5zU0SBqe++Qla7K9ehq3L/pwnEeEDIq4tTrM7O+J1Oi3I5dbs3CIsXYeWL0CdzZ6s616y9PLAufMF/8kpklzQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB8512.namprd12.prod.outlook.com
 (2603:10b6:610:158::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:16:45 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 19:16:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 3/3] iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl
From: Jason Gunthorpe <jgg@nvidia.com>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: jgg@ziepe.ca, alex@shazbot.org, iommu@lists.linux.dev, joro@8bytes.org, 
 kevin.tian@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 robin.murphy@arm.com, will@kernel.org
In-Reply-To: <20261028090453.2392991-4-guanghuifeng@linux.alibaba.com>
References: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
 <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
 <20261028090453.2392991-4-guanghuifeng@linux.alibaba.com>
Date: Wed, 18 Nov 2026 15:16:41 -0400
Message-Id: <179502940167.3851267.4719665473088413793.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN0PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:408:ea::12) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c90a45c-61ae-42d3-490c-08df45a87bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|18002099003|261009223027099003|22082099003|11063799006|56012099006|261028144727099003|4143699003|261022105027099003|261026140227099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KdNMKzthT7g51kD3H48D31WWQajSQGeqnw//byObUYMyKY491AdFBaa9CzYeljD9yLyBR5cRluIc+5nnBOINvMC9JASw92H8eSRBd4995VpMbWrE/R+52Wf58UvZt3kIApY6iFAPg4T6Qww2VPjfViT3QAcz9aQwQ7x6CDGUwz8rxon2Eosqo5bCp4sJa81VjL6X2xMXqm4g5hH4taQdGtxVfmvQ0dxV7UvSnBRcz2BCfFed9SHO1hYV0fGxUHRqJH51+Q0Sd1KLX2v47LHpzKjWk8D+OMr/qKlgXZdKyVSJ0dEv4gS/OZPkmmZN/GRWomE0MEsQs8zL3k/pSxCDYMJ53LBs7rzmEpXo6sZ6Qxc/V0jnd5+cZ0erTN+YbGN4Te61tm3bmdLnHAgi5o5Y0H34KbEk3UDGFZlh40fFMPd45pJNoZhEbFhs/u69NL+vdEQTQTcv1nrrmDUPpKyfKUw540sdAmnlF4RhDhEFpivKyysuPYpDn2pRds1m85ojfaC/sMg8UkQAKu9Q7ERBEUbHzTsyWYdF72INY4mJuyZObcC0oZsq6zoZLsvAQVCdAfLFNvhFfC8o3+iZwAElsfWFfaNe8s440KpmHcKClmEKkodMrQBjQu9Vc3yHC1RNzQxUI14p9LTs3YpksSbgQFYsxocBwBX1kRwr/tIkVF4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(18002099003)(261009223027099003)(22082099003)(11063799006)(56012099006)(261028144727099003)(4143699003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDIwZWtoN1pra2ZUMmszcDFSMUd6L21hbythejFYVFNuTVRCeDFObUtiRlZN?=
 =?utf-8?B?RUlEYUdobVJKUVd0aVY2NmtwQ05ocU43WTBoODlsTDgrWmEvUVpXbUttL0xZ?=
 =?utf-8?B?WEpmOFVObzJid0cwYzJBU1VkRitvS3YvL2UyRlRUVFpPMFc4anZSNFVsRzFN?=
 =?utf-8?B?MlllakhwSXF2cUR4Y0VmaVRmNUdBRE05QlVSKzdkb0QxMThkZWIxblMveDdm?=
 =?utf-8?B?RTZBSVNIbEFmM2pIOUR1UjBiMmVwVkVFa0d1d2xjUUMxZVFOQ3FGcTJpczFI?=
 =?utf-8?B?bjVSODNHL0c0NExFVDBiOW9hWkdxYlJLYVZkcVVpbnFHdTdtaDBpU3lLVTdT?=
 =?utf-8?B?UkxVekNyeUdhdHpsQjkxK3NCVGpzWU56Vzl2cWN3REgxc3N0bExHMllqZUVt?=
 =?utf-8?B?c1dsejlpWlh0MkhTUFBPc3VDUnBBaUl5WmNqaCswQ3c3emZOTGR2Wmd3VmNj?=
 =?utf-8?B?VWM4dnJuVmJwcmtGK0JXNDFOaHFQUlJjSmhpQm45b2crVDRWZG5hNEQ1RStT?=
 =?utf-8?B?Q1RpMzVkUFhMNm54ZDNIMEJzZ0IycVh1VGlvNGUrU3BhYUM4RTFYKzlrbDFG?=
 =?utf-8?B?MEh0anZSMW52Uy81eFNqb3FEUkFMVi8xMUJiTnd5VjNFMGljWXlnemFUUjBB?=
 =?utf-8?B?NEVKSnVBSzA4anlxQjhDNSt5NS9reWp0RGUyMTdFUjRGd3VGWi80OXg4MHVa?=
 =?utf-8?B?VnVyVnc3b2U1Q3FabjJOTEV0bDVvQ2UvN3lURHVqWTZrMkZOR0RXUVZRZGxj?=
 =?utf-8?B?L3o1TkQvMzdiSEFhRkx6ZHBPa0cwWXZqS2tZZWQ5QSswYnhVdVlkekMyWnFn?=
 =?utf-8?B?dGMwMTNwVlpXRVZPNnExQkdIVEg2Y0JXY0FaOEtTT0NVa0tmb05BMnQzelZl?=
 =?utf-8?B?ZGs3TXRtSnRBWTd4b2NvRFpYQWRJbFU0WUxOQ1ptNnlTN1hhQlo2c24yQTNK?=
 =?utf-8?B?V3dkYnB4OXA4NnN1ejMrZU9PYzJRNDRPY2hBVzJpWkVuTzRvOFRlR2JBYUpP?=
 =?utf-8?B?enRXbCt4bmd0WUhIU0MxVHBVdGhFYW5wV1FwRkM1ODArdy85bmRucXNBWlli?=
 =?utf-8?B?aGs1WmNBdkZPK0NvRGhITU9pYkIwc0g2amRlZEhHS05lYlhzVDA4bFFiVXNk?=
 =?utf-8?B?Yld2Z2NlMzNGYW5WL3ZCY1piRUlrRWRQbDA2dEJpMmlDV0x4MVNyTWdQNFM4?=
 =?utf-8?B?TmZ4WG1rM0RJYTk2OUVIa29wNkVVRnJTdUw2SWk5M3dwdmNVczZXSmpXeVR5?=
 =?utf-8?B?L2ZyVU9nSjlQVHI0NENYSWJIKzN4NEpjd3JrQmdHNjVucUczb1RPSGw0QUFI?=
 =?utf-8?B?SGxQc0QxcUJkcndUM3E0cWVzSFpKeTAyK28xUzFsV0p3Rk15dG5mSC9JSm9n?=
 =?utf-8?B?R21GSXhrNityR2MzM0R2ekJBdEJMWGkrQ0orRDRHSUlIbHpZejYrODJmNFJv?=
 =?utf-8?B?QXZldFZHSktadDNwYTREOUMwOC9ZRnUyWlpWSVFSZHZqbHZuMFNRNnJJYXFn?=
 =?utf-8?B?eUducVV0NTlZd0hrZnNpbFVTeHc1TTl0TW5abG55SkhoeEp0UktVMHl1NEh2?=
 =?utf-8?B?T0hUdFV1bWRpaHNzM1c5b0xrK0ZBWDdIa0ZRa1BXZUNadU0yVEtCNXJBYzJz?=
 =?utf-8?B?YVpIOWJaRlJBa2N5bUxlek91bUtpYldXbzNpOEFDQk1URkxDVTArK2RSK3ha?=
 =?utf-8?B?YmlZTEhIc1FwZTBsRU5hOGZFNUNqZ05lL2ZlNXdudHoxR2FUZml4NWZKZjVM?=
 =?utf-8?B?cjJlR1lCazhuOXRCcG1mUlR3a1NNN1FZR0J3Z1JwTGpTcFE0ckVkeHVGSXhO?=
 =?utf-8?B?N09jekh4RG80akpzQk02TEM5dDZJQXdBRHViR0hSMnFxY1JWcVcyYXRweWVx?=
 =?utf-8?B?RGVtNS85OXVvd2VYWWhrTG0yUW9aOGlmZWpTTkk1NzFUMFhpbjJlU0I1NUo1?=
 =?utf-8?B?RkZSYzJvSG9DZmMxUXRzQ0xmbE1ZckdJdUVaTTl1OHJUNTZJZ0JYWTVXVzBB?=
 =?utf-8?B?b1hQaHZKcFpmZXc4ajdySVVhQU9uSDJ6UENHMkIyMU5HN0lhT0ZRWVdqWTNk?=
 =?utf-8?B?eTNLeHRNMGhVN2JCbjQzQnVFQzFYcEgrN1lSU3UyRk5wOElFbmRQeWJ5Rytk?=
 =?utf-8?B?QVQ4U2MzWlRPdVlybWxNbU12YmdWMDIyQWZaem1SaTFHU1dyQWp0VlRKcWdz?=
 =?utf-8?B?V1JObksxRWFJNERnQkNMNmtqZzlHRnlpWXlZbndyb3JTSEZwVlFLVHQxaDJs?=
 =?utf-8?B?R25IUW4wV0RsZnNnd0ZuYnRpS2NHcVFSdUdmcGVYWENDUElNR3dwN0FTMm5v?=
 =?utf-8?Q?T0n04KMIYd8EJnVsvK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c90a45c-61ae-42d3-490c-08df45a87bd6
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:16:44.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ste51t8p0rWmsFck9DPOKRQkZ+qtmPxjeND/g11gddRuUE1z6LPHqklnELV4XYp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512

> [ ... 56 lines skipped ... ]
> @@ -183,6 +183,57 @@ int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
>  	return rc;
>  }
>  
> +int iommufd_ioas_reserve_iovas(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_reserve_iovas *cmd = ucmd->cmd;
> +	struct iommu_iova_range __user *ranges;
> +	struct iommufd_ioas *ioas;
> +	u32 i;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	ranges = u64_to_user_ptr(cmd->ranges);
> +
> +	down_write(&ioas->iopt.iova_rwsem);
> +	for (i = 0; i < cmd->num_ranges; i++) {
> +		struct iommu_iova_range range;
> +
> +		rc = copy_from_user(&range, &ranges[i], sizeof(range));
> +		if (rc) {
> +			rc = -EFAULT;
> +			goto out_unlock;
> +		}
> +		if (range.last < range.start) {
> +			rc = -EINVAL;
> +			goto out_unlock;
> +		}
> +		if (range.start >= ULONG_MAX || range.last >= ULONG_MAX) {
> +			rc = -EOVERFLOW;
> +			goto out_unlock;
> +		}
 [Severity: Medium]
 Should the check in iommufd_ioas_reserve_iovas() in
 drivers/iommu/iommufd/ioas.c use > ULONG_MAX instead of >= ULONG_MAX?

 struct iommu_iova_range represents an inclusive [start, last] interval, and
 iopt_reserve_iova() supports inclusive bounds up to ULONG_MAX, as seen in
 drivers/iommu/iommufd/io_pagetable.c:iopt_table_add_domain():

 	if (geometry->aperture_end != ULONG_MAX) {
 		rc = iopt_reserve_iova(iopt, geometry->aperture_end + 1,
 				       ULONG_MAX, domain);

 The UAPI comment for struct iommu_ioas_reserve_iovas in
 include/uapi/linux/iommufd.h also notes:

  * A range with last < start fails with -EINVAL.  On 32-bit kernels
  * a range exceeding the native address width fails with -EOVERFLOW.

 With >= ULONG_MAX, any range starting or ending at ULONG_MAX (such as a
 32-bit PCI host bridge MMIO window ending at 0xffffffff on a 32-bit kernel,
 or a reservation reaching U64_MAX on a 64-bit kernel) is rejected with
 -EOVERFLOW.

Seems right, it should be > not >=, please send a V2.

Also, with this function I think you can remove the overlapping
selftest function IOMMU_TEST_OP_ADD_RESERVED as another patch. Then
you will have test coverage for this too.

The rest of the series looks OK to me, so send a v3 and I'll pick it
up

-- 
Jason
