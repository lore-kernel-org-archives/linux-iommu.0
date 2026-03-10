Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35493BAD97
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160902; cv=fail; b=VtmAu7dSQmM6ex442uLpPbj7HWKOLS2mbB+yCMn1XeRa84WIskQggSbFklQA2pFalLQDmKFB5EX5sgMlD8hYBoq+HuC+/qa7h+a4fYhnhsV1YvvX5w9F+WNrFHK3X/16wAvFS223zSU8sPXz0/6yadb5NyytOiChaAjfjmVN8As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160902; c=relaxed/simple;
	bh=dXP+QriO534SJnHj7qciTMaibOik9DJssCKawM2SImI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=acheQKXXJ1KISY7ntl5eizS397glNKPi3o3Se+tVcofGnWylGEhQiC1OLpru0rUZsLOUzmtnkMyC5GbMKVj35NuSH0koVUuH/bAzsBDg4tWXa6c6VIDyir6seVQB3MfCdBLpawm1MMN/9LqhSWUkZ3dymn13r4gziokj6rauDyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXpCINm9; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXpCINm9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjo8ue/aAhRLaQigbkebfK2UsiJySV/bCyo3qEJ06ZiyMQZtdDp85xzs/VBOU1DWipEQj4P5iUe2losr5hVdzqwje288crbKZGzFnIi7EIsPuwNS3Li7C6juA5tXhgSXm18ERCJDkGdKtBZuokhj9XlBqV+V0jw9Ybh7EiG3KpvTymSKdEOZ39A0aBYeyMq4uI0t0j4QHcpkuAg3f8pszxTYc5LRgtrO/Z9KLX6Ht3BzuCip3K9mpVq7UWnQ/81QZgi9zkQM8hJgQvMCkTy+qRtWOXOWMK+QgnGYpH2XA8LVJAHe74FFwYMu+tZwdAOegBepUPc80pzeWGIS4t6E/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9tJZOGdUiDICUzecNXCiVTOlbYrRYERp5tQz2ZNGpw=;
 b=YocZDxxll5DqfOWkmo1Rw3yyGT6aGGfHj7viroU5askVVWtias+vm3wuRFJaoVP8sPgyWIr8fNskIDuREdH+RHKXg/o43VdUCkSGg+2OTOHxNxpT7NgXwssxA3IGGUzATwJ674tA930rJ/OtDcaGVcfeBB32LgFgo7mZyjyycSttfkP0N3fPGYDbli+ixm+bJDUr7UhXOJVeNK8OhDLy+C4q3jrpujl6xTdp9M+pAj2rPUKKs1bjhA5Dlb9vhVy/cvvBdHQkXCurajRmseaubcHfnfNI/QsutTGqZvZfBblVbV1vySQl4aYAlQo3e4OFnsFymfF2qMFWN10tEL7Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9tJZOGdUiDICUzecNXCiVTOlbYrRYERp5tQz2ZNGpw=;
 b=LXpCINm9qMIzZD4sNDfJJboX237hlhkYhqB77CkkwLh8vGmfR+2lgAKVcdQLIzVk3VCrLftVSclnRv9rXD84celugowaNGnq3lwDuHbrL9yyTFlTWEB88TU34VricRBTJIfm4ax8M4K3P4h1plyB8aJvJNAqyl0IuMhAfMtzoDOxV5m2O8id0SfmgKXeoW6TJJzfebXS83EnYhetuSBCpExOsGyqfjRPnSVD/+i8yXxPoVUlJIYaDMSc1hYRS4S/omdhkbNns+tryogrfym5fPqgINSpaoe6dPVZmH2UghC6h5wxpaJUigR+Ysv7DQ7QLd/GDmHQjSVOPTEVUOeq0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 16:41:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 10 Mar 2026
 16:41:35 +0000
Date: Tue, 10 Mar 2026 13:41:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: joerg.roedel@amd.com, kevin.tian@intel.com, vasant.hegde@amd.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Message-ID: <20260310164134.GA1410323@nvidia.com>
References: <20260310163136.1179322-1-sherry.yang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310163136.1179322-1-sherry.yang@oracle.com>
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: d6080804-48b4-4851-a44e-08de7ec3e494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AS39FOB35kPHc6SfctBob1dFU3vFZ5FA/77Gew+YbbhT0Zg8H4dhwKRGQVVKBZB5TPs9B7Gq+Eq+eslU3GatdS8Jns6CqrfBJwkrwecXVUlJE6BYs1vWcYQE0W8nDfdxM6D9VI+zQJgnntiqAbEbaH3gd/3/T+p1Kqq3hrFdVdcfFOasON10mU/eFUq8K8sgPxE5yDDnJ4J9JgUzlXBZlEeM6YUuQtNwmm2xuoy7hBomR2cN6YUkh/GQzFNVx/yAlrMMEv26Bb/a2F0bwoAOgEyTI+n3Va3cB7QjKGAVKdxCP+dnGHfulwbQ9FXmikRX9Xv1XOlmi9k+BY9UOH+q683eXuU6mpYXRV83yRLuCdeZ+wR+Cu5a1mqGMaoxz4Y3/LAaUDrvYbeBcTt1HMXlqGMVJMpadz7Y56fMgHIYjOgiow9RF3QA57Ix6EqeLWoITc1P2Bpujzye/LGelYLcf/1IjnQ4mW6FBfi4usRe2DeD8eXXC6tzxp1Ti26fmgJkdtKSC4Pp1U2NuH8zYsFx6jNLLzBqGCLhZET1OEkgQR0fYJxRndbmQ6ZoSLmMY0mefl/uNXiTwJ5iRidpMxxeT6pfeLsEfYiatnlptP50izJ7EyNBTCTPPDE3df+gSIBW76p8DF97NTDa6+93krwb2O/y9a2y0aTiIBmvy3jokfNyFcD1FzMRBNnNeEKKP18QvAbhMXVL87/zeEjJRDDWSKkKFOyIizpWEWPHyNp57a4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVM5Q3RwNjZ5SFhDZTRNZGlnQ0t6TjlKdGxhYzNoc3FiSkI1WDhRcW9IM3dz?=
 =?utf-8?B?VytNeW02ay8wdzJYeGhPdUJ4emc0ZktoZ3JXUi9VUlkzMVROdzBoTHM4RmRB?=
 =?utf-8?B?NWpCV0traDcyYkJ4UWFOeHdYYXNxMUlpQ2t6ZzhIMWZndDU0d0ZmZzRhOU96?=
 =?utf-8?B?RG9HdXNEd0pVN2ZjdkYxaHFxR0s3a2tHNmxoQUV0TnJCNm5KaWZHZ2xJOEhG?=
 =?utf-8?B?V3E5Y3M4VisxZ0t3VmErNFV1d1JsN3FjeVdDcnRtaEVENkhDKzQ2VHVScEwx?=
 =?utf-8?B?MEN4dWYycnpndW5aa295T0NOZkQ2ZHNGYnNFZU9ubm9oNzBTTFFHRFVXWmlH?=
 =?utf-8?B?S3J6dUVuVnQ4d0MvRk1JeEtMYU9SdTlvbGpjUGM4ank2LzljWU5SbEFOMVBZ?=
 =?utf-8?B?ZElkaTY3Y2p3WmxESlJFY0FRL0JOdVJET3BsbytqdFRDVS9YZjN5THpvSXdO?=
 =?utf-8?B?eGhpYjZIUXFTTzFCKzg3VXlyTE5wTFlwektjWldIKy9Rb3ExVHBQQTlxRUFR?=
 =?utf-8?B?S2c3RktJWEJnVnRMd01LQ2FoTGE5eXJSTnRCQ3FaOEFLRFp1SmttYWI4bzhv?=
 =?utf-8?B?enRqSGM3ZWZSNkhCR0QzUENlRFBqUGdWaG5yS2lFNzMrTDd1UEZPT1VNajlU?=
 =?utf-8?B?K2FOK080U3lFYlFyWGlxZEZOaCt3T2hSdUprdW12d3FWdnpnTm1lbU5DeU1W?=
 =?utf-8?B?am1VU01kQ2JJNHFOSENNQnRzZEY0M3FpZjZtbE5XZ21LdS95K0xzdUdxUjdJ?=
 =?utf-8?B?RXpCaGxuRGYzVFI5bUJwaHpIbmh5M0FJdVZkUEVGNmRUY2ZjRjExeVpUZTNY?=
 =?utf-8?B?V0VXdHYzeUF6QjN2ZE5JK2ZEb05hWVpRbjRYNGl4Ym9xeHZQRzQzU2t4QlZ3?=
 =?utf-8?B?TUd6eDlQaWRZcWtiSDRnTHFzZEtMNXArWmp4SWRBMWhXTThSWFRIb2o5T2px?=
 =?utf-8?B?dEN0R2UvVDl2a1lMVUFkMkhJc3l1ZTBwL3JGUWFJblU0SU40cTB6ay9HN2pi?=
 =?utf-8?B?ZmZ3bmQweEt4eEx2YjZJV3BZdnZMbHVRbmtYcTB0cE9LNExlTStkTm5QbDRm?=
 =?utf-8?B?Y3d2Q3RZTFoxbVAvRlA2QnFYblk1RlF0dzhMV3BucUxEeFBsQ09XUFhYMGZv?=
 =?utf-8?B?cTlTd2EwMlBNSlcwRCtXVCt3YnNRdHp5SVlhc25mVnprNUNwdFNEOEFuV1dP?=
 =?utf-8?B?Q3Bpbi9zc0ZlYWMzNXowTzR6a1YxRzRncFk3ZGJQZE53ZmpmS3I1NkNudG83?=
 =?utf-8?B?UElaK3hMVENhSjBxNFN1WWcySnNudzdkTEZINitMSkVkL0xObFBrdWh3RTkr?=
 =?utf-8?B?dmo2NmFDTlZ2RHF5VmdQYlRKay9USjlxM01BM0h6SmVVdG42azlpaDh1S1Ew?=
 =?utf-8?B?UXB0M2syNTRlWDFLZ2hWTkttVnd6Z2tPdzZERTNacDgrYmpsTVlKZ3VWYlRk?=
 =?utf-8?B?c3V6TjhTM2hWOEx0RjJHd3dZc2I3eHpDbmlJSVY4QXJPKzdla21HeUVRTGZH?=
 =?utf-8?B?bUl6clVXbzl0SWNZR0YyTUJHbndmeER3djBRdFpJSUxmZERSQ2NvSzN3Vm9k?=
 =?utf-8?B?SE41OFg5L3AxUUE4NlNsS1Y2MlEyRXdwN1FLY3FjUGJWZ0NlNCtucDJ3NFRZ?=
 =?utf-8?B?VTV5VkU1Z20wRG12cnpLMmRQYVA2dGhnVFdRU0ErMjNkSVZRV3lmZG5uVnVQ?=
 =?utf-8?B?NVlCSVI3MjlXNFFMNkd2SmdJTTBoeWtWVDBWNjg3dkdyazhQRnpORmhkVnZp?=
 =?utf-8?B?b3V4OFVkUmcxL3g3ejkwakpENmJNcFQrTXdYSTkrczE2TEp1OTM5TmlrSVdk?=
 =?utf-8?B?TmVFcllvMEdQRVBPK01jVmtsN0xxZXV5WlAyM01USkp1cnZzbytjRVJtSW4w?=
 =?utf-8?B?a3FCVzVidDFuKzU4U2tRZ0EzR0tnN01NVnFtVWVUTTU4TzVCMksrTlBEWldz?=
 =?utf-8?B?Ukl3cUVESldaQmhBa0svQXR5MWZ6d3RoY3lOZ0VmTm5NTEVhRTFKajJBWmhz?=
 =?utf-8?B?UXYxUU41RUZ0Z01sekg1MUZ4ZkMyTDY5ZmRRd3BxdjQ0V0FCSU84UG5PWmFP?=
 =?utf-8?B?VEdTMkQ2cnNad0NHcm1VWHRtUU5lbjZCaENxV3ZNcWc4UllXQi9BSjdxSUtK?=
 =?utf-8?B?bjNOQnowS0tOU2ZJUEM2N05IWHoycTQydzJiWnBRQzVWMUdKSy9FUlM0Ry90?=
 =?utf-8?B?MjdDcmV2TUFGd1pVM2JiSmtJZktKUmNvdEZVTE5JUFRwd3ZrM0grNUFnaERk?=
 =?utf-8?B?ZUVWa3lTZktmTGFEbXBJdnlvYmpRbTJYbjRNZGJhczZoTkNpYzNEblJPVEdm?=
 =?utf-8?B?b0FjVzRHT3pBaUVUVWkxWHNkOTFuaVlaOUJ5N0N4V3hGRUVOUmQ1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6080804-48b4-4851-a44e-08de7ec3e494
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 16:41:35.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH6XSwTn9eJ66H3fs20LXmJqD76dLK/3Umi5lmhtYkTabaJUKelJzeCe+OAGpa9U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244

On Tue, Mar 10, 2026 at 09:31:36AM -0700, Sherry Yang wrote:
> After enabling CONFIG_GCOV_KERNEL and CONFIG_GCOV_PROFILE_ALL, following
> build failure is observed:
> 
> In function 'amdv1pt_install_leaf_entry',
>     inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:650:3,
>     inlined from '__map_single_page0' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:661:1,
>     inlined from 'pt_descend' at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
>     inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:657:10,
>     inlined from '__map_single_page1.constprop' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:661:1:
> ././include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_71' declared with attribute error: FIELD_PREP: value too large for the field
>   706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |
> 
> ......
> 
> drivers/iommu/generic_pt/fmt/amdv1.h:220:26: note: in expansion of macro 'FIELD_PREP'
>   220 |                          FIELD_PREP(AMDV1PT_FMT_OA,
>       |                          ^~~~~~~~~~
> 
> In the path '__do_map_single_page()', level 0 always invokes
> 'pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT, …)'. At runtime that
> lands in the 'if (oasz_lg2 == isz_lg2)' arm of 'amdv1pt_install_leaf_entry()';
> the contiguous-only 'else' block is unreachable for 4 KiB pages.

I think this is fixed already by

commit 98d5110f90ae0dbc5f2f13f033e06f6d57009e0d
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Mon Jan 19 20:19:49 2026 -0400

    iommupt: Make it clearer to the compiler that pts.level == 0 for single page
    
    Older versions of gcc and clang sometimes get tripped up by the build time
    assertion in FIELD_PREP because they can see that the argument to
    FIELD_PREP is constant but can't see that the if condition protecting it
    is also a constant false.

       In file included from <command-line>:
       In function 'amdv1pt_install_leaf_entry',
           inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:651:3,
           inlined from '__map_single_page0' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1,
           inlined from 'pt_descend' at drivers/iommu/generic_pt/fmt/../pt_iter.h:391:9,
           inlined from '__do_map_single_page' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:658:10,
           inlined from '__map_single_page1.constprop' at drivers/iommu/generic_pt/fmt/../iommu_pt.h:662:1:


??

Jason
