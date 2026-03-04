Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A58D37418E
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618551; cv=fail; b=WdsCnNp7hSvcQ6lWGNmtckEUwaT0v3ma0A+RWJSOcGqv24xNZH8PHRhtCf77DIgjrZp40mKcJ652fJoT5WnwfBX51UpJK7e88bG+/4ntiLfrCC6WaFd6R1S7s60kjWlK5SRft7UKzH+bxyLHaz35x+yMyTwZIHLMzzipw07UDXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618551; c=relaxed/simple;
	bh=tJZkXazcMfvkcPlx9tmX7ewXSCwqtNNb+cXfEwYjXRk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WHMODxz7ad1U+3C9+r3mA4YUSl2BMAyM18zRVSM7BPuXWwwRvCmH2WQMjeOLheUcfAw7tMSJxEA4MExGBQn5WVJjwQkqldGkBkCyZPqWstm5F9zkcOgMbdTSIrfc1D2I4wwhx8PjarVlL+bf33BbFAsWWYzWNwmPqz3Wfdyx2EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jk37dUER; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jk37dUER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772618549; x=1804154549;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tJZkXazcMfvkcPlx9tmX7ewXSCwqtNNb+cXfEwYjXRk=;
  b=jk37dUERpX9vu/w029B+5umg3jSbJ+GG69dkr/9uQ4G96CbXPQigrC7U
   iYSG6uP9XpnBz4/ABjYaYBG61+M01QSW5fVm8ayXLUFgrlLXsuiHbPRT8
   6DZpQCCbssq9N1Z4oQWtJMU3DDXqdwC8gS7WlH/6oBCQP7v735QrUjKeb
   CHF63WeJIs2UmcRfOWSXHaBXpoSc6eOy34VrpkIxzcLfAfJOz2phs1jLC
   wKgqCjpvr1WdBAb3/Au+/QP8lfE+/3dgYPsQbUhZyLWucqYm5rx5OR/QM
   hnO1Fi4P3KdGm8+La7W7p18i+776n9ObdgRkpumInJxN6eCDwW41D9psU
   A==;
X-CSE-ConnectionGUID: lING78OhTZWNw9sR+MWUvw==
X-CSE-MsgGUID: sRAPHf4KQ1OhIm9sgld+2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="84309314"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="84309314"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:02:28 -0800
X-CSE-ConnectionGUID: B6sg3/G1Rq2DrrXYbQmc1w==
X-CSE-MsgGUID: CS5BiZCaTNWPfXicyWpJDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="221265597"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:02:28 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 02:02:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 02:02:28 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 02:02:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYl6VYFlbAHUottGmDyZH08W8B9X55MdSelYYFv7sklhmWt85Emt+FjDDYPiBjuilLgiVoylM7CPpFMvEtERiNqx9MtxsbvvM/Yu1BGAfDOea6XWAL7tckzBK8B/KHbUbVZZ2DfQMiphF8mdWTL0AExssFjoYEgn2BvFXpc3+Zoj9YvAEixhicTYfRQ1kvHasvBIidRUQF/RIxYY+M9umzOlvkwCSymZwMuGVJaUZwjlxXolsgKbbmTI59ZFR6Ri0ckXJVblxmVllFItXHsahPP69ADy0g3TWOTTXTpL+shNSHB8Ymr4ghPcta7ZfJ45fv4VawxNxT/S1aTnoBJUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZo0gIUUEVp3dfP3l3nxUNFv31oA4kqiT8v2O/Nsch4=;
 b=jFo46t7T56jgvAyC3zpw5GioDQXxD1fi6tRpEP9CAudM/QntzRc+w+2O5ztXqkvoFNrGm56EBd7U/BjZXgBZwkauRozsha9YReCNfvxJrH7sFE/92Zrb6iASF9GRJTbIownOh394pGu8qpAIMTEzf0m8LfWarQ5PlvvIg5DW/ar91N77nItnB/eNgBXhlzDAufZLFQcIoQestXgek5JjOqnBpTekjoNWVOrQEjqwMP08dl4fRTT9M/+VZ1FNYNt386H9xnkgLGyFHBxU1EE4f6lmzPsgQXKUTrtitkWINsrLkv6ft1WiSAF+s9vsc/2nGF18qnpVT0ZwKerI8OiE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB4981.namprd11.prod.outlook.com (2603:10b6:510:39::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Wed, 4 Mar
 2026 10:02:25 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 10:02:25 +0000
Message-ID: <d9d16633-85a8-4e59-9188-289af13eea04@intel.com>
Date: Wed, 4 Mar 2026 18:10:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <vasant.hegde@amd.com>
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
 <1c486a5a-7115-44fc-9705-18b292cb9d00@intel.com>
 <14caa56f-999a-ae00-2840-e97080b4f7af@amd.com>
 <967d515c-f098-48ff-97cb-2de34f17aa29@intel.com>
 <945476d7-6e2e-b8a1-904b-09c8c87067a2@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <945476d7-6e2e-b8a1-904b-09c8c87067a2@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0011.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::6)
 To LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9753a41a-9ffa-4315-9bac-08de79d522db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|42112799006;
X-Microsoft-Antispam-Message-Info: GSQHE85CTd9Zr5ItQoin8uxOPQAo2xsdRfAe9cvU/vdXx+yMwCDZ/OFPm8F4H5dJKCoOSHMYspaXc74+rjm4GPh6aBAWeMxUs32T4lbV/iB1tVC4kl0Eg6uC8VTxETXbVPrAjFOC/BuH7wjz+792LzAPULhHrVU3aQnFdtULd2l8necz9MfAsEreNY+P8IZd56UOlerRevPoNYsdIJhgHc9FhyXsYG3ppV/k+yvd5UxzUm7aND0F3x+iFoAhVc6WVynsvlQJBfNOloBLJbW+/Xej8/G0MWx1D1jk9Es3nduivnqlSxqeYla0nZ6js6r7ncR+aFGfWYKLmolsvflFn0awrNtcWBs6xwJoL/q+5fRKP9UO+2WjPUYFtIRByiNWHoDXYO+4ATkw4lG8/xLJsgZmpmSxhvtCWM5OEivdTwBiWFZyLvj6CBjz+0tW00VWzrLt4Y2XTdXj14CGKmQ761egobiSg4B39w5cVlwf0o15Hml7+YtfhvWapngNw4iDEykDRVJHksVD9TyZNmRxom7eKPYRLvG/lOSwRCU7ElCQkx1bLCHs5M//8viUtg3DDSnweYfq+jOg9w+0K02Zf+6jEPjgWiEThS9EHpNsPa8QKKDU5mtEuIGmhCUY2IjfnjQqkTfUj4i32h/rBEVNWbB3Xjcs22pLpu3kT6sJDjmqcbhRucuh+eAHFh+4v1/uK5fNnQXRJscA5Mak6Mc5pHPaeReaisgPBeSWtzoiijE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(42112799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk0yUGRHTHVkeFhLbHVnWTFoVGZDanlzc0h0UlJXcnU5dWxYNi9wbm9waG5X?=
 =?utf-8?B?cTN2T3lJK3Jsb3I5UzQvaHlaS2dIVGFJMXBNaWJYR3lhdHE1ZWdTRVVrbjdw?=
 =?utf-8?B?QkwzRHd5cDRxWXFxM2pSOTBMTVF5T0E1cnhNUG5MNEVIYVNsUS9sQUQzNldm?=
 =?utf-8?B?V0UyOVNVb0R5bHYybk5XdlVnd0lrOVRNNDJrWjVJYTY0R3RWcDhnNkNvRmw2?=
 =?utf-8?B?c0laeFVKelFIdk5sTmV1bU1WeXpWUkdHK3BtemQ5eUtxL0tveXNHc3liTml4?=
 =?utf-8?B?WU5RTHc2M1FQMVFsNU52Z3dRYXJwYThYcnJUY3BxYzJpM0NlRFJ4VXAyb1Fh?=
 =?utf-8?B?djdsNENXV1Q2SEdhN09BL0dPT2lwMzB0UVhLOXF2Wk9RRkFFNHdtTTExemVK?=
 =?utf-8?B?NnV6RXc4K1puR1JGUGRXYld1Qm94dDc3RENEQ29TZ2RTRHFnMlhCOWVLSG5p?=
 =?utf-8?B?eHVqTnB5YTlXZlJrMVpUQ3BacDlHc3VLN29ML2xEM0kzTXFsa0hQRnZIS2VX?=
 =?utf-8?B?Z0dmdFVoVDdmMW4rZ2Z3MDZ4OXpYSnE0MVNzeHhJdFErc0JlL0hWSTI1Y1hi?=
 =?utf-8?B?a2xvNjdIK2hhVy9FU0prWjR4ZCtmL1BwNGkwOGs3VWtYT3I2ekU2M3lhbE5w?=
 =?utf-8?B?eUszVHRaUG01ekx6b0VYQUhSUXZmVWxoUFlJeUZtSVBoVENKQkQ5SXpSMXl4?=
 =?utf-8?B?S24rZDZHM1FTaGhJS0tiUWdydk0zQS9yVFlQY3BoVU5HQXA5QTRIT1ExcEhH?=
 =?utf-8?B?NmsrQUtFeUZuY3dYbkVNbWFYTTBnMUllMC9vcWovdUtWMm52NkozWXh1MjhL?=
 =?utf-8?B?Wm9zTDJtS0xEcmw4alA5YjJIeWFhKzZoZnVBcW14YUxhMHVOQUx1UXRLQVdz?=
 =?utf-8?B?L2xab0NCeE1XaVpacGI5QXpqdlhYb1plbmlRc3B3d3M2dVFrUmdXVlR4TUEr?=
 =?utf-8?B?aUpRb21CbW9zU2tadmo0WEM5cndUZ1JEVEh0OWR0UFk1cTF3V1k0NVppZjFU?=
 =?utf-8?B?MHV4dXlFbFVzZWpzc1NZUUR1LzJTMlF3VEV0Q0hzOGprU3BvTk8zZEQxS29J?=
 =?utf-8?B?bVRYSXVCWHh2KytCQ0hmK2RzZ1piRUhsS0Z6SW05MmVLNkFSeDVadFVyTTFh?=
 =?utf-8?B?Nmg4cVpaNnQvbDJqbkRnRkIya1p2QjJSbDlJaTY2Y0RtcWFkWE8yRFNFVy92?=
 =?utf-8?B?R0Y3bkNKMDltTXl4ditwSG4wbkIyYTRTSUJ0ZGJYaldKWENXSXFFazU0KzJS?=
 =?utf-8?B?T0pYUUZyL3J1Zmhqazc0aTV0MlJLR2RPc3ViUUJrVlg1SUFwNmdmeVNVdzcx?=
 =?utf-8?B?WmRXVlE3QzlsWGJyVVFEMWFZeVdkU3dBN3dkN3BuYmFoWjJkQVgrWlBPOGtF?=
 =?utf-8?B?akFWQ3E2eTczeVZwbHNOU1h4d0xzNXo4NCtqNWlaUW8ySXNBSkF3eHZDL0I5?=
 =?utf-8?B?NTcrWU5qQ3FZMURHSk9GM09aY1RrLzhzc2pOeUJ5dlcwMnJSMDIvN2lHcnpr?=
 =?utf-8?B?M0FNa0FvUlZPcGN2Ty9NMTBraU5TcUNCbjRXOXdQQmhuejdGTXFza2xiZEVo?=
 =?utf-8?B?TFdURXJRYlEzQ0tyYXpPNGlYWE9XdFpQcXlxaDNqMU9EVk8rcTN4dG8zSUJy?=
 =?utf-8?B?YWx1ancrNHFLRnR2eFI5Z1N1U3RaYStHYVVERkQvNnROajJNTlN0b1A5Szlt?=
 =?utf-8?B?b0Y2cW9HdXh6WHdKcjdhWGl1NFpTQlJhVUdmQnp5VkZYdFF5QXB4cFpTUlJE?=
 =?utf-8?B?UldhNGtrZkNnaEx0OFVWRDBuZUtKMXdyN05WVzMxYjBuelB2NEpqblNWT1V0?=
 =?utf-8?B?TzhjN3BEanlZTkNkZXdPeWRoOFlleUhzbjBjRmpLSWhQUThGRDFwVUF0N3Fr?=
 =?utf-8?B?dytBcVJHbDMzL05iZW5DdGt3QjlrQ2YyckZCRUVvTkdvUnVvZ2dKVkZDVlpW?=
 =?utf-8?B?Q1p6aS9VZFRzNTlqWlpVTE1xK3Z0QkFDQU9nRW1NaytWZjJRYlVEbWl5aHJq?=
 =?utf-8?B?MkpGeHFwSnpEQmtQYi8xK2RzY1UzM1hUS3ZuTHZqb2ZReFU0LzVjZjc0bG5j?=
 =?utf-8?B?MWNQdlMvMGNlWndyRmlSZ1VCOTZEU1YxeE1Ib3dTZVpVeFRYQzZSazlCUUUz?=
 =?utf-8?B?T3JybXdjVnJleGl2MEsvUXFSVUhYNVM5R2hIS01WUmxkM1MvTk9yNWRTa2NJ?=
 =?utf-8?B?VllJVW1iR0NWb3JzYUNrMGQ5VzlML1g4L1VsMEtXSmp1WDhvUUl0NnY5ci8r?=
 =?utf-8?B?TWx1alY5a2VjNkpjNk1wZGp2MEliK0cwbnZTTTlkcnVFMTFEQmRoRUlYaE9w?=
 =?utf-8?B?bE1LdnR2MjdPUFhQTHFMWS9uVENPNFB5NG10MVVZcy9PaUNhV05RQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9753a41a-9ffa-4315-9bac-08de79d522db
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 10:02:25.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIfkElDKCd5M9qG9i50gOfOwZrNDyM7+SvqplUVAZFF5FYHywpcCyOpVfnYUurlIp+efMrlFs/a/Iq31rXpB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4981
X-OriginatorOrg: intel.com

On 3/4/26 02:33, Lizhi Hou wrote:
> 
> On 2/28/26 04:14, Yi Liu wrote:
>>
>> On 2/26/26 06:09, Lizhi Hou wrote:
>>>
>>>>> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
>>>>> index 07d64908a05f..523b8c65c86f 100644
>>>>> --- a/drivers/iommu/iommu-sva.c
>>>>> +++ b/drivers/iommu/iommu-sva.c
>>>>> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva
>>>>> *handle)
>>>>>               return;
>>>>>       }
>>>>>
>>>>> +     mmgrab(domain->mm);
>>>>>       iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>>>>>       if (--domain->users == 0) {
>>>>>               list_del(&domain->next);
>>>>> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva
>>>>> *handle)
>>>>>               if (list_empty(&iommu_sva_mms))
>>>>>                       iommu_sva_present = false;
>>>>>       }
>>>>> +     mmdrop(domain->mm);
>>>>>
>>>>>       mutex_unlock(&iommu_sva_lock);
>>>>>       kfree(handle);
>>>>
>>>> will moving the below hunk in front of iommu_domain_free() simpler?
>>>> Only when (--domain->users == 0), shall the code check if sva_domains
>>>> is empty. right?
>>>
>>> I am not sure if this can be moved in front of iommu_domain_free(). Will
>>> iommu_domain_free() be possible to impact sva_domains?
>>
>> sva_domains is used to track domains associated with the same mm in the
>> generic layer. iommu_domain_free() calls vendor iommu driver's free() op
>> with domain type specific operations. I don't think it should impact the
>> sva_domains.
>>
>>> iommu_domain_free() calls domain->ops->free(). Could this call back free
>>> sva_domain?
>>
>> I think so. Check intel_mm_free_notifier() as an example.
> 
> So if this is true, after calling iommu_domain_free(), the following 
> check list_empty(&iommu_mm->sva_domains) could become to true because of 
> domain free. If we move the check in front (before iommu_domain_free()), 
> the check could be false. That seems leading incorrect iommu_sva_present

list_empty(&iommu_mm->sva_domains) can be true because of 
list_del(&domain->next), not iommu_domain_free(). Am I missing
anything here?

Regards,
Yi Liu

