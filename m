Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8435AC34
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449026; cv=fail; b=LAf+7zy4rggNsG+lzAp72wPbmJY9Xj+cn0dOAjz6nj+hx7nCe6VH+dciB7kPI5La2gr0TUTvSs5kcpvBah9e7vxCeD2ey+93pR0wAZYCQQ4tMQpKrY/vwowwpSLnEk0qyX8Iq9xkP7sJPsfpdM57N8dppEAZcudResOZ57w4s9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449026; c=relaxed/simple;
	bh=fLWIIhAMqLi/nzrnJAYeat3BICsRQ8HX7Lxgqc7uHek=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioj5DwaVNEzJmMzXTC3PNtSZxd/yga89Eury/RrqSIK8Jru5L/14aTVMkxM8necF8gBxmTAfbQerOVEI2X3k2Zrj0UGZyuxO5AgDVVArmev4Qh15Q1/SM8wUY3/xvmsBCTqlwc/RRYGzVQ10twVnmfPvw1PmBGxMk+mBAIk2Hyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJR6n6Z0; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJR6n6Z0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772449025; x=1803985025;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fLWIIhAMqLi/nzrnJAYeat3BICsRQ8HX7Lxgqc7uHek=;
  b=SJR6n6Z02VsKJyPoqAbaUzrvgOllkOmDSH7DgapefpmmS9Z96wyowb8w
   LEiNvnn2WuEOpQvNbNtC09o6bcsTBxIC9+Gb4uYrpMB7tK1au9t9tGsFg
   MH/OSmPGMJ1djZKwO2WG+EHhuVDHeUvJG/1zR/a9GASk1IIOu2k722UWB
   xE+Lqx3SGHsHQTEDQW/VLOrIxMNhIP5WdxCPONObojVzozMH/GX+s5wpL
   EY7Vut1RfriziZQdYwGxTVVZfPoU0uSVmB09JvHpuQYmXTbJJXr32FdYY
   H2La6Fd7eB7NZR6CzoZW6hAnZP137EZkQC1CPGk/drG+NbmTTqEWqPj8Z
   Q==;
X-CSE-ConnectionGUID: zyQ9QsqiQha3aDxg7SnIkg==
X-CSE-MsgGUID: x9RbE4IMQfm410ahtuOpoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73320865"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73320865"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:57:04 -0800
X-CSE-ConnectionGUID: aqWLEeMJTu2EkAYOqGL+Yw==
X-CSE-MsgGUID: 2xLnTDRdS9yWpIx7JHUmRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="216845411"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:57:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 02:57:03 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 02:57:03 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 02:57:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtN7v82+xqoXlIh+qJX87nascKRSaqoeorJEPf+qWXWCRm742Zfadbo+bYKSKcFEcUPUyU8VDz6nGxIKyolSohP9iPZWwAkj6Nj/xBnHwAw53tivBvS8f0Mm6GEJCmKmO1VLpvFe45ksSDEx0Pev0+SGz+uhMjIos5ZXBi96R4u3TrgOW2HrHSGX4KBq93/95oCU9m3mgQ0bAglU86Yt9QMm/l+bafD5orX/f0evOiDD/mapKoH2wmo4I8OexFLA/SCa/4szn3s8o5+4+b+PH2n2spxbBEtorjss2zfn/FYtkCGYPt9+vg9ojoAk3zACIz5wVBKfYBolX7v4S8Ylbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/C3viPE5ljkxH86jL8ryOvH9Y9GLdYsDacCoQ5EQjYI=;
 b=KSmqFxwBwar98be4XS/x0sBTnuavvfFrmua+y03Sy1M26asQcVShxkfPzj2cCegI/y/87sdv+1bTvXSISi6Th/AshFdrQ5bEFSCQLLGmAHKOEShGqWFtVlyo0jBBcuiRARjkeix42+0e+wMzI9VFuiz51Cp0SR2cLnYuWn52298K0mCZx/TctL04Iny2b1Ouk0qqlszpaHi37k8HMU5pVG2XRuOkkltDxUz47DyHo7tgDbROdk2X3U6VcMY5EO5ZztN66JIYSQW3AAaBNl9JI5NIaSoeA3gn8DqN31SvCOse91qinM54YZW6Vcmcs5syvwSEtJNrS/DVyXHIYyLsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Mon, 2 Mar
 2026 10:57:01 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 10:57:00 +0000
Message-ID: <98f392c8-cd64-486b-9ab0-d04c786ed39b@intel.com>
Date: Mon, 2 Mar 2026 19:04:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Baolu Lu <baolu.lu@linux.intel.com>, Lizhi Hou <lizhi.hou@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<vasant.hegde@amd.com>
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
 <0833d160-9659-4140-b775-a0ab0c17a451@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <0833d160-9659-4140-b775-a0ab0c17a451@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 264e7e86-2725-457d-30d3-08de784a6e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|42112799006|366016;
X-Microsoft-Antispam-Message-Info: DuuhVarb1kYKkBdzEhbC5IfIuU8jEdhvjzoUzvSBX1FlCkvRut9cnqlvoSkwxQzc7dAhBHZtpz8HaJyhOasG2YeiDqFNZXsI2RLI1DjC5K/4S4v8qs2c/HVH1yqhJMWlSpsNfSWX2cCCjoON0cEstZ7Ilvsd/uir7+SrBBwEhwUxL4ZCudTBpzzHWhHAi9OHPK74Vc1ammkGWHOl2/guco3RYHJMK6HHGiNOesp5jfFYuKlZjV9L0UkAfYXxLBgjnjCUg9ffg7vVs63rm9tM/tLECQO07k1zliVqDueZmD3XJZNppl0HrVRxa9hyUfzlJnStkjgDWJEYmzeFkW4s43mnTVf/Q+ciQ20I8DG+TyUjjIlaVM4aE8KBnDB4wf7+qZJiYBnvWjfhWUgPI1uonE9PvwcmIRgXV+n6sCTEWFVPF1FUTGWE8WX+G46kNpyE/1NlMN+L5vmvjj30jK5C1Fd2DAoQv2wkNMDGUDCj9rksU5Gtb85FwLRYzAed7SRN5DlK9ZcsDGZ5HVhNtEThdsIsy9W2Xk/GiYALz+KCQWtGyweGbhIt0y23KI7Ric4h97W86JKPb1tnwF29lvt+jIW1fBTg6ivA/7hnRQvh7tRdl3QjnFjYEP0v/b6lDMwb+boyXWUUdtMQowobvtOlQbSE0o+MNiR0SNlUUGxpTxTn40IUr+xFj0nSPZUCuCEG7cpKYZs2CIG2BVaGtP7TDHSTa00CpS/Xr1NjrLGRcJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(42112799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1Q2SUswamJ2MHBtNHlLY2J0WEJYU2ZJVGMxWmV1eWI2TW9CSnZhQi9wU1pz?=
 =?utf-8?B?SmkxaTVobVdGeW1PWTRKcERqbUJZcGFPQkVJRnE2Nk9VREUvWnNBY3R2Qm4y?=
 =?utf-8?B?dUxna29kVlc5eFd0Y0hnMitkbjF0cG40VWtyNEMyYWR3UklBM09PeDBtbEN3?=
 =?utf-8?B?MXlwbEtnZVdvT2hZVnNvaTVnYlRGS0lTSUZkVy9rTDlBMUVOU1BSMjZFWVJx?=
 =?utf-8?B?VG5aZUJ3bEMxUDlBQkUrUFd4ZWIzSVJ6VzNBbklkM2FDNUN0ck50bXhtVktC?=
 =?utf-8?B?TUloWk5HTHgwcUorUm8wZHE2cHUrNkRvVS9YRWd6U2pJWllJQnVtbm1xeG0w?=
 =?utf-8?B?ckV6M0ppZkx0UzdsN2JlWWoxMXVxdnRBWFZFWUNReGlxVGpuUjUweUV6UjR5?=
 =?utf-8?B?K09iTGVzeXlBRnlwZ1AwK3YzSktiRzhnSTgvNVdEcUhxellzUk02Z1hGQmg1?=
 =?utf-8?B?Rm44YkhXMnlScVYwNE9QSzJQSmxRWHB0aVFOVHBqVExGRVlZSy9PZkc3L2R2?=
 =?utf-8?B?Z0VsUzNVL05ESC90VHpxRklVbG5mUXVIdm4rZ0VmTDVLd2pLaGdVR2xsMU5Z?=
 =?utf-8?B?UFpQQWRqUnJTK2ZWM1lqek5UaGJZR0NxMHExVG9lS2NaT3phOEJIeEJFVmRS?=
 =?utf-8?B?TFZoUnBvR05PQlN6NENmY0N1YTZhTEV1b3FQTlhUVGFaVzVRU1VpcllzaWNO?=
 =?utf-8?B?SVpaZStzRmRLVDZuTk5PckVpUCtlTWpUeUlzQ0FGUVd2RFV3Y1llUmpvSzZT?=
 =?utf-8?B?c0Jkc1FFOWliNWpTZFMzMno0clI1eG5oUnJ4VTlWZnJ1UGhlUG01REFCQXlQ?=
 =?utf-8?B?aExWMkVUQU5MMk52bm12ZzRCbSszdWREcTM3RGFzU0xwcFg2ZTdHbHJJU3N5?=
 =?utf-8?B?S1hmVUdtY0FuQTBPOTZsV3BVSHlrbC9vY3VTRk1vOGs5T25yR09NMzYydS9K?=
 =?utf-8?B?dWpuaEtFTkhjWDVpVUE1SjBJUDhLR2VJbzUwQ3dhUEFtMVQvYkpTYUsrcmQ1?=
 =?utf-8?B?K0NrVXdkUHNXUEE4ZnQ3T1RVT2laeE1WQkRINnhiaGh5QVA2QVFWcGpaOGFv?=
 =?utf-8?B?d2tONXZSellpNmp1eGJsZWllY0pxc0cyNkVCMmE5eTBOMmRObVZZTEZhejRG?=
 =?utf-8?B?bWI1VEZYQmk1NnhOcUo1YklBbjJ1MnpqbksxZDkxQmZzZjFnbXJKdDdpQ3k1?=
 =?utf-8?B?U2t0VEpCMXBkeGNuNFZXdVNLSy9kQ3VFSkpaSzU4b1lla3BPcXVjb1NDdDFB?=
 =?utf-8?B?cUljV0FGNHgzYi9zUGQ2Mk5HNWluOHJRcGZWK0h1dmI1bjhJSmpkQWd2ZTg4?=
 =?utf-8?B?ZFp5MElCbTVlTlZsbFVqWnFWRkl4Tzk1clRCNk5oUnhYUDdzMmpTUXQ4c0tK?=
 =?utf-8?B?QndtTmgzUFdxWEU2UjZWWWc4Z3BZbUJSaTRIcXF3Um5hSVNtb0s3aUJyRzVP?=
 =?utf-8?B?dWd6QzdXclEvWlpMRTBTMGpxenppUE4weURMQ2xtOHZ3YWltOU5JdmluNE9j?=
 =?utf-8?B?blh3YWxHTW9Cb0VOQzBtRGNyN2RNMi9xN3IvcEtISysrWHdjOTRCMURXUU0r?=
 =?utf-8?B?c0VnNnJMWit6YWV3YXh2RWU3MWM3aUlzdDlHQUlUbm1xT290RVE0YUV2VTlh?=
 =?utf-8?B?cndRMFJXaVZVaCtOTjlVWnRYQmgvNHZDdUhRR2tTK3NmbXpMSmp2RFlhdDF2?=
 =?utf-8?B?SUMvSUFGQStrdUIwam0yZjhqZmhISEl1bEVlS2VOUlNkN2xHY05VRFF6Zkhx?=
 =?utf-8?B?SkFROUJCQlViYk9GOVc1MUhWNkVhWnNWNkpsdDg5UXc2b1lrejdMcjRBSXdi?=
 =?utf-8?B?NVhwa25sWmpFNjQwYzFWNmlvM0l0SzNrK2REUURCNGtxY0J1WnZyT25hcnpM?=
 =?utf-8?B?eTRUM0lvUFhoS3lDU1ZhRmNqQyswNVI0NjhjWU1Hazd6V3E0QU1SUW81cit3?=
 =?utf-8?B?QzUrTmp5S0NlOHZGYjNnRVpvWWtvTlRPMTRaNVJ5b1E0V0gvWXZ6VFlJN0NH?=
 =?utf-8?B?UDA5NUFPUEZTYkJGY1NlZ29hVlRXSEdNTUJ6ajAyN0VTbXc4MmhUeGQyZ2U1?=
 =?utf-8?B?MmZxN0V2SEhDSG5EUFVmSktnZk9QNzRJVHFwQ0RFbmw0aUlITW8vUGp4a3Iz?=
 =?utf-8?B?YlRDMzV0NmRpRUdiYkhJdE92OUkrL2hNZ1BJSTduZytNa2xEVVpybmZwcVMx?=
 =?utf-8?B?eVdLeEwvOGFBSk5VY1JHL0swT2F1d0xSNThqdForcko0ai9RQlBRc3NxZXhq?=
 =?utf-8?B?Q3poZGVucFhMZ3BMSjJpelVuU0k2WmYyaFc1aXJRNDZRVmZFN2o4VkZZOGdt?=
 =?utf-8?B?akZYTEZYM2ZwdTFHS1VLRkJjUW8xNUt1YlFkV042dEJaRDhJQTFxQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 264e7e86-2725-457d-30d3-08de784a6e2e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 10:57:00.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKb59u4aVGzhO/vrxhgzOPhMivPdI2raA80LS82BiwDKRh9fvlLyb44yIIYtSKvnyZQItt2ZBa1p6D68RbB61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8370
X-OriginatorOrg: intel.com

On 3/2/26 14:50, Baolu Lu wrote:
> On 2/25/26 02:30, Lizhi Hou wrote:
>> domain->mm->iommu_mm can be freed by iommu_domain_free():
>>    iommu_domain_free()
>>      mmdrop()
>>        __mmdrop()
>>          mm_pasid_drop()
>> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
>> dereference a freed mm structure, leading to a crash.
>>
>> Fix this by taking a reference to the mm via mmgrab() before
>> calling iommu_domain_free(), and dropping it with mmdrop() after
>> finishing access to domain->mm->iommu_mm.
>>
>> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for 
>> kernel address space")
>> Signed-off-by: Lizhi Hou<lizhi.hou@amd.com>
>> ---
>>   drivers/iommu/iommu-sva.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>> index 07d64908a05f..523b8c65c86f 100644
>> --- a/drivers/iommu/iommu-sva.c
>> +++ b/drivers/iommu/iommu-sva.c
>> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva 
>> *handle)
>>           return;
>>       }
>> +    mmgrab(domain->mm);
>>       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>>       if (--domain->users == 0) {
>>           list_del(&domain->next);
>> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva 
>> *handle)
>>           if (list_empty(&iommu_sva_mms))
>>               iommu_sva_present = false;
>>       }
>> +    mmdrop(domain->mm);
>>       mutex_unlock(&iommu_sva_lock);
>>       kfree(handle);

Hi Baolu,

> How about making the iommu_mm structure itself an owner of the mm_struct
> lifetime? Does something like the following work?

According to the call stack in the commit message, mm_pasid_drop() is
triggered when the mm_count reaches 0.

 >>      mmdrop()
 >>        __mmdrop()
 >>          mm_pasid_drop()

So I see a deadlock issue with the below change. The problem is:

mmgrab(mm) in iommu_alloc_mm_data() increases mm_count. But 
mm_pasid_drop() calls mmdrop(mm) to decrease mm_count. This creates a
circular dependency: __mmdrop() waits for mm_count to be 0, but mm_count
can only reach 0 after __mmdrop() calls mm_pasid_drop().

> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 07d64908a05f..9c56c2222617 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -47,6 +47,7 @@ static struct iommu_mm_data 
> *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>          iommu_mm->pasid = pasid;
>          iommu_mm->mm = mm;
>          INIT_LIST_HEAD(&iommu_mm->sva_domains);
> +       mmgrab(mm);
>          /*
>           * Make sure the write to mm->iommu_mm is not reordered in 
> front of
>           * initialization to iommu_mm fields. If it does, readers may 
> see a
> @@ -212,6 +213,8 @@ void mm_pasid_drop(struct mm_struct *mm)
>                  return;
> 
>          iommu_free_global_pasid(iommu_mm->pasid);
> +       mm->iommu_mm = NULL;
> +       mmdrop(mm);


Regards,
Yi Liu

