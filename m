Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADB285C91
	for <iommu@lists.linux.dev>; Sat, 18 Jul 2026 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416574; cv=fail; b=j1zvnUNBnCHZeB/NEJZuCmSREQ3qTiXbBzAfU2o04bkv9zEsLvYF2xm5LViM7b7FOwXs6kjNgSHPPd2y2vKaN129+KGCGzt3BUvHllZM9pdFYpwgByXqwggmn40a+fY7zZ9rXCob/OwniRtJF4dIqzvA441HoJ+x6qo3RiVFyVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416574; c=relaxed/simple;
	bh=AUtkelQKtplDaLSYMlwnX1T9EBJ105clJ9f+wclbfZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZK3rKttjzassVxkW+eQZA+cYmZ5czycJuQcxGyLJHDGnNuAXx06Ik1vxTIxcXc/67hb+ZF54qB/nY5q/GWmMOoBvb0tQ8B3ZJJ9GCa9nw+77qcawIxRtb10NVhfSbdKrWG01vrZyrqiTrkItXRzkwJxajeCN9rljK3nJKHOWv/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3G21gis; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3G21gis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMAJ970jcb/BYG7mj9hwJ7JG+hQqNSlrNbo6HOW0MV2zLcnIThMhiWa6NKqLvHkSKOx4WMfm2GP+fHLIHbfNLQfMlSzb8M5utekmS+uAnPed6DnhqC2KQ1WwAEwV9fs5Wd1Pwz/QpS73Jy8xyPH9/ryryfl99wB9YeKNqGYtgS/68o8n9F/8d/RJYa2Lm1Ef+bj5CnMbUEmM2EuIhnumYEvL85b9oRG1q32NFBgbdFyVswnzaQnO3qrvLjQ4VfOIrd/kc8mTXPizJAKEUZVzijFfO2ussVsYzjuV/l+bEfr52Lc7GBPjWhenLrpD6CkUZ1BTI8XkcOHvpl+gg8+Z5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m44U+6L1O4z8Hmzgx+tNoydLhfUwaRmZxDdeJwg1qDo=;
 b=wdsGg689lht5dXktE3EC8UwR/khHXR85QNrbH4GNtSlc9Yt0+KOtos1SCZOU8jApjAUkO6WrD4Gt1JLNB8HGoGdR9sjoUi3n8feL3uc6bnH5qvXOVMuRYPUPDF75bbdPKgrkL7GG16eNKlEilsrGt00JZS7xzFw0cjJMjbmeTF+BMgL6mRikUG9pp3rp1VmqrwaktZ5ioBq0cZ0nZEwqtiZRlXEOXkv3Hj0aEOnwVgbQo0chMl9EbjOiSokZeYAFF2nyWnGkQ91WCSQfIuGrvL2TmOp/mD56X25d5lSw2fpMzMPtjQ+GatHKvdTXVLB6ZHart2SJWf82GLWTgxEBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m44U+6L1O4z8Hmzgx+tNoydLhfUwaRmZxDdeJwg1qDo=;
 b=q3G21gisNqjulR24bMHGvmdU0lWe8k1lGAifcbyHToKupdOy5GP9Q6LRCXWZq+ab59rTW+1+iblreht8bBKBdiNx+2h2SIoohb6B7mXIsPLCHEr+XBBm+5cAKJTsNbNvUnOrmPgqXIt6aZGay0GWVOqxiKlV1hYfFzMGjb6gsjO/+b/T8niFjZfIUtMIMYD8M7e4B/8kz9O35Hymjb2wS10IFT6qGUhvOG43PaAh33WK0LtvGy2MjYTaqCyZ0amvRnhRUzKQUlBY4N/JV2mPsEALfGT9T9NTsaQAfEAi++rEOXzY0BMw/QH4gUQScibo4f9OVaqd2oXwSYrRwf65aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Sat, 18 Jul
 2026 23:16:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Sat, 18 Jul 2026
 23:16:07 +0000
Date: Sat, 18 Jul 2026 13:20:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kevin.tian@intel.com,
	smostafa@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH v8 0/9] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
Message-ID: <20260718162052.GF699082@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
 <alqh_NVatGn84o0i@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alqh_NVatGn84o0i@google.com>
X-ClientProxiedBy: BL1PR13CA0396.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: acb19f81-75f2-476d-29e7-08dee5228bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|10067099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	UYfyhE0BQ8btnpWOLadtFBOjFTQu+1bjYay7Khh3BuvxbcJzbaZV1caZ/TenHjKW6nNs8jBkUpAlszWABPOB/rNfl6NEHj5mMRLHG7IzAM8FzngSanwWr4R1cVTLYAHbyI8piP0kjDPGJX05vp66C7hJ7Q5qb0J0DNWm274PwSUiUJelzOWTZgew0eTS17GPU19xFmTgjhMrgC+7tCaVaH6x4Tiqk7IN/1lGg/Ei2RgkD/py56No+AI752hCWPAVZG6kscEc1pFoAjUT0KMnmS72MBnr0Qr6AvM4VOw8n4nzwiGnM4QhS2UxxYUKPi+OULfQouDEMnR9bCr1bppbLL2Scb8EOgOWyXDSdhkgCCiZ9jYgo/WrFZIwJxxBS/RuFekddHvQ0RA9j8Mj5tC2v6IXLIIfxEHFhsgZCjuBB4GhcFVLyTcCZQc44V00J724Jsk9d0J7eJXGnoQmBrt9WM9pmA9mFgj47lMYZPabBg9tfGpomfcuyMiX8YyMiC9QqqXXf6xZazxg/Vx4owWUeHClObLB4z8RYUMnveR+JoMNdWhcGpKnt/pRI50kJuuE1n66vJSfph95/QIyx4wtqGls0AWkPIVzd4NxYyzZe923ru33Qjzq3B9eZ9b9SZOwZQ7dQY2BBDdc59vDngkKahVuhtZHCRAqMsa7RNvkvxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2SX2RFzfi7kUDbM2L9K/KfykjoQhoRJ2/lz5tEbv0al+gmMorACLKAlLF7wy?=
 =?us-ascii?Q?NPQs5geRgkxR/zNBpj8A3v/l00pWQUsv46Kzfh2yHeVZWcw/10/kpm+mCLne?=
 =?us-ascii?Q?xx4VRp6iS8rNrnO/kDkLUkzSxPiBltN9W80gIHxlcWoNsiYLDoT0c9C/HbL1?=
 =?us-ascii?Q?Bo9TBHTUZ+7VRVBQOLaLJapAuDfGH8zo0wbppshkWDRJ6bK1ExD/tpaQ6Vyp?=
 =?us-ascii?Q?M7LtgJxhYlM6PxEuDUV/tlb3lqcwvQ5IDkprgfXAzc2vow9Yb/l/tBV9p3OP?=
 =?us-ascii?Q?g7ZP+IAIlGodv+j6OA0JfHbC5ABqkPXvB+PXIT6MB7W0P6ULtINxHU4yWX6X?=
 =?us-ascii?Q?u03PtyjuNKRXCnHpGoN5IuwZR+RWInXMvuUwulJyA5HVzprOnrzOhKbTGvyA?=
 =?us-ascii?Q?qLtdsSpR7F6e04VZ1DJRFvuJaVg8M4lw74PMzOUhpEL02onyFcKPmwYcQgjT?=
 =?us-ascii?Q?6COudLG5mPOqPd6XWwwNZI6mKDlAAtXrHua/XtYK8bJuJb9INTDrCcOuA+Qg?=
 =?us-ascii?Q?MrOC77LtwDrbI0HbSDqjGhBLr8VQD6IqUTnWR/lcZWyfTlksRd64NgwOsTri?=
 =?us-ascii?Q?apXjhI4uorpzDyQTU0WZ89ZeZQi9Mpg5tSvch/jtzhoHG0k3hz9qBDIpB89w?=
 =?us-ascii?Q?niDx7iWVILlwnzsFBqLM9KDgw3y6R73lnJ3jmRyamcJRSSRugdsYUe4pExk0?=
 =?us-ascii?Q?vzQctjkEhIm8QYgimtsX95ysZDGdMgccPcE46dsUQuO3ujcCUn3GKkvIukS+?=
 =?us-ascii?Q?YgnfaYuBTj9LgVJHK7dGVSdH16424iW2Fp9KBIGjTOUXGConoT60t7MBrCXu?=
 =?us-ascii?Q?CbGM8AnmhVrNQvRoEDKRyw9oSMYewxDNN+/ExpZdtzGjJ9/Yl7hhI/jGucNV?=
 =?us-ascii?Q?bI65uCoD1CDfG//f8yU9FWbg+qdNY3Cn9Gzt8MRMsQfE+p1shfqc215wi0zo?=
 =?us-ascii?Q?M159wFX9DZ0YCamVonIrsPGcAZUFtZHudbV5VtH8E+uk3ibn1y11DxiQT4GX?=
 =?us-ascii?Q?1swatE7AzbGSoY5JwaB4HrwA4I0UWSHxw6cyJoH9mvpLwovOh+iXTIERK591?=
 =?us-ascii?Q?z696S1/dZYdsybRsRxIQEx2kTg2q6BjGFs10p9tDz4capg8TWF8NdP6jPvGA?=
 =?us-ascii?Q?qs8df+m/hux+7cXtowUlgfZmyn24nTy74aHHvxkTR8aY7xt9Du+UONFIxjdv?=
 =?us-ascii?Q?mQ4J6Z9hsYknamE33xc7H2VUe1BUrlX5YqQVtaj1VvgKbl/l3FB5iTTrFW7R?=
 =?us-ascii?Q?dcE44IO4x1/YU7bSJHCJRfkC2xWTgucEWIyYbBB2rSyyoepZr0VbOVpr0w/i?=
 =?us-ascii?Q?7+YYQTJoOPIUx0pgV5tID/1nA0Mc5jf90VJ9GGUK+v1rLePabNvyNefPJGAu?=
 =?us-ascii?Q?uy207zXOa2PewUG+gBOJBXqMWjHMuMtn/LwrTa1tgj/PcIxKRFk/tqtTcqDI?=
 =?us-ascii?Q?f/dkR/zhg9miAwF/ArV3dp1Kgc2QrJLn3xY1SqCdBQ2hjzCXBOHLkZTUjjFW?=
 =?us-ascii?Q?am1ajgaTDAyQ7/Vzztk2Ek4rX2YS8+VBeCCfG+Odn4QJH/1evKeq7LMCcrFW?=
 =?us-ascii?Q?lIMYN2doMA/rJ4p3L7a+wBNgOlzPZzof5TkQfsPcTwqYE6ST5IXLegV7U4F2?=
 =?us-ascii?Q?8FLVTbFA67uztPrC3rWdWcpV60xkhOHqoKlQubQTtopeluoQaBCNxnWiLVtT?=
 =?us-ascii?Q?rZj0j6DNukb6vJtEtRwlMt3Q5BUzq25A4zw00N3Afd+k25c6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb19f81-75f2-476d-29e7-08dee5228bef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 23:16:07.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oulWE3ZS/Zrgz2KJoh83pbg0ki0PEI920M7+HotYQ0J5ZiTqiaanQZPpFR1fOlwB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Fri, Jul 17, 2026 at 09:43:24PM +0000, Pranjal Shrivastava wrote:

> However, looking at your approach, I think I can slightly rework my 
> preservation logic and instead of bloating the KHO ABI with physical
> addresses, I could re-use your exact table-walking logic during probe
> to parse the live L1/L2 structures directly from registers, identify 
> the valid tables, and kho/dma_restore them. There could me small 
> differences though, for example instead of memremap stuff, we'd have to
> use the kho/dma_restore API (which can be done by passing some op like 
> the data structure writers we have?) Similarly, maybe reserving ASID/VMID 
> can be potentially re-used as well..

I think this will be true for all the iommu drivers as they pretty
much all have this same kind of kdumpish adoption logic in one way or
another.

> for KHO), I wanted to start a discussion to see if it makes sense to 
> factor this common code out into an arm-smmu-v3-kexec.c (or similar)?

Yeah maybe so

It sounds great this helps the live update project as well!

Jason
