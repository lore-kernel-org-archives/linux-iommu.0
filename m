Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E43648
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 03:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686884815; x=1718420815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xgoR0l5r2udN1zDa9TM+HcHai2NPJ2a4n7tVk7ch3HI=;
  b=Mkjs/KBcnaUQ/q4REfEIwKVIwywAxHSLtAw+Xo5ZERoacZZOm+zN+7NN
   ARNZQYlMpVsrINyJaCvQTbC9EqFOIjab+P5/hG7xsA7o+vCRIXk7MHVSx
   fMLwEF2mvEZhZJsKxRge26HNGQCJARBeEXqey+ItGJ7F9rf8ozqZGIA16
   nWkxB5O7nWYAUBn953MqKTUjPQwd8riVGkG6PYPNTIv3EOPpnaGX6U1jV
   DpOn4jjThacqxEsT21WJflGur1qZ+7tlM9Eu9kg+eSuJUjMdz5r9rRxlo
   lORhePD9xfoUaWDLeiW3BFai3knQ6ZqTKKt1fDs2VsbWSr0GUpEeyWsAi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445483003"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="445483003"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:06:54 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745964616"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="745964616"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 20:06:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 20:06:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 20:06:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 20:06:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnkiw+N3MFCfn2lD+eoecUm50b+EhIn/eakLIkYUZkT/0uKzlkBbfRM6NVpbcRxUvGgRCymvmc7ZMNmYWGmN0oY3eXvNoOEi8DzFhyCEMTldyNf0qoSQO0IWy3HZ2cmQLzBC8/Hf2IlpPvJu3Yy8HhCV6HCfGpEBvGO2+xTrmalOiDFzsd0CxNonObRRklu+/H32Ss/jWX4rvXLeRsvRoNTJzRogyy/U222rMFJytU/G1gxpFz/1NMuUaHX+Rd3A53NFc4oZr5Rt1a2hCJ7f10vFjjC+NtUzCVRUXLOTr/GBciRceso6A4K/yehJ0a1qvQQJo6HIjB9UEcPkwiqJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9jFGGAibt4QkhPLsRCKpuRhxeVcBv4tHZ9Ym6BNUAI=;
 b=Xwq8iIKrle4Pf6Hjllox6qd3QbmArZUgEXkoBe85AE7LKFPecKG2HEdmTi8HKy/sm6i9I8d5sY+NpDLTCeY1S/f+6pmFox8hgMPluCSBgZusCez03T0nZm4gUkvxvH2ZXvKn3q/xIa/JhJ+Aec61I7ZE3AuISWZZD0rjEZV03ih7AHsrU7tlSSG8cVETLs8eJlZq8g/2Dyxe+UqFPP9rN9nsqyodZtje/KcFmEoCANKxWh61d4BOljsXWHhTTDdXkwXTOTZD1a+KRBu7VWX68uhmvKwEtpb5PX3HIPafsrUqhXQfTKBUuns6uY5EKDQ9NV7trYWy51M8iJ4wdkZQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4138.namprd11.prod.outlook.com (2603:10b6:5:19a::31)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 03:06:34 +0000
Received: from DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::1a30:fbe1:9dc6:4e1a]) by DM6PR11MB4138.namprd11.prod.outlook.com
 ([fe80::1a30:fbe1:9dc6:4e1a%4]) with mapi id 15.20.6500.026; Fri, 16 Jun 2023
 03:06:33 +0000
Message-ID: <5044217c-9380-f50a-2809-0e3dc80f7bd2@intel.com>
Date: Fri, 16 Jun 2023 11:06:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Content-Language: en-CA
To: Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230615071613.690639-1-yanfei.xu@intel.com>
 <3f60b35a-683c-5e18-c9d5-964df9331f0f@linux.intel.com>
From: Yanfei Xu <yanfei.xu@intel.com>
In-Reply-To: <3f60b35a-683c-5e18-c9d5-964df9331f0f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DM6PR11MB4138.namprd11.prod.outlook.com
 (2603:10b6:5:19a::31)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4138:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a750ae-257e-48cb-d05b-08db6e16b094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BG0qGFS5zJlZUv+tPzUtu5jWs36wKNXUYnUgy5Yi52vvobgiB9w1LWhq5b6nRXtw+qWVqXIUcOA8ZTB9DHLQ1cS8mRkhtl5yoSOxtbwo7wbDeVB99K9qBfstZxXLh8C5npJb400FM6mOMd4mNyyzVkX3gX3z17zMX7bNdhMjo6dYlE4CZ9+luhSsZid1PiPwUkzN1RXt3a6wSt0NmYua7IRnjFnz+5F7YrSAkj7mzCfvWKa/sc+iqMK3K514rkHKPuTOh1TSuBFv9zcdUJgogLlqPnwR7Hhv/k35bQdv/w37IROb1tsBNnEc1sk73MDAoFUheNNr1+6BEYLmrBxd/yib9zDomJve8FqFqNV0bkAfzvfxurqnZafueLT1N6vYrLeWE8znh2LpzTl4rWIiw8HCzI0t3Qhxkz2HYqQZLGq/hOEAfGiBgdmy5atZoXvMoQJNM7t8Ee5rOd+6/9Dh9Hj8pw+tuEnMmUNOMxISCdwNTduz5wHu7STDMYQ/fwZDhqlkravpmg5k2xsA9zAJrJfkFxO87wwU7uvZ1DlbpO/LJgXLFdjeMuU8oMvvJk5rc0Pae0e09tV1OmbMLf2hIFV7wOYh91LNWltEdlDwCcR+kkNnrKtsdxOn79N+vVWIT+igI2XJ+Udk/w7s58CoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4138.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(31686004)(2906002)(2616005)(83380400001)(44832011)(5660300002)(8676002)(186003)(8936002)(38100700002)(86362001)(6666004)(6506007)(66556008)(66476007)(82960400001)(66946007)(6486002)(6512007)(26005)(53546011)(36756003)(316002)(41300700001)(31696002)(4326008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURPQWNDd0VSM0RtdThXMWpBT1hTVDBjS0JNazBpVTFwK20rTWY4aG9aanA5?=
 =?utf-8?B?OTZiMzg4TlhmU0lVQkFtTHNlOW5iVENiWTg2M2Rxb2JBQmo3cEQ3VExBRVNh?=
 =?utf-8?B?NHh2bE1ZTzdyRENBQ0lJYzkyQ01kUHREOEFYcldxbGxaN1o4RWZlMFQyMXYz?=
 =?utf-8?B?UDFOQ1hDamtqNFkwRzh3RXI5TGN6SmRTMHNjNkJEeU9GNWlQWVkrUSt0clEw?=
 =?utf-8?B?eld3Y3NBUkZHYldWa2pVY3g5SUFpVXFtQ3cvWW1nTlhKZ1FVWFVNQmJMa2tR?=
 =?utf-8?B?NDM5Smx6anYrbkgyK1UxUHQ3VlZtSU9EZm9LalV0Mnp3VWVlQ2kwbURVRHh5?=
 =?utf-8?B?dmluQkxKWFdLQkVzSXZhZVpNSUFqeWZnZ3laMmhnOVJCRVZMc0VDdU9HTlhP?=
 =?utf-8?B?RmNQV0dKU0hnZHZzRVdUQWtkZ0VQYzVGL3BwK0ozT3BNRUNLeFA1SmdtY3Ey?=
 =?utf-8?B?YUN5OXQrK2RaRFhnblJITEh0L3RSZHlHUmVLWXE4WnBCaGsvTWd1S2w3aWlO?=
 =?utf-8?B?L3UyRHZLS3RYSmlYT0VvYmY4cmE4K3VMaC94VVVjS3VaL01iZnU5MncyenMr?=
 =?utf-8?B?M3BtNStlVUl6YkYwUERZVm1zVGh5WGk4c0V3ZXNqMFBLeS8rS3cyQnhzWWd6?=
 =?utf-8?B?cThtcWNPWllVdUlhbjNlUlhleTJMR0VObGVFaVJTR0xxemZkR0tsL0JhUEla?=
 =?utf-8?B?TDVaM1hUb3hrVWQwNUF2RjdFeTNhaEMxdjlZS0cvdTV5b0dTaXdJZlNCaFJ0?=
 =?utf-8?B?NWJmdEFJWTRqNmRHSE0rZThJdVB4OUFxVGxYdXIyK3NCOElMb1JFdzRnTlBh?=
 =?utf-8?B?aHNiYXZGSXNZaGhYMW9FS21FdE44NzJIYXlQNFJzRS9KOUZXN3Z6aDMrK2pN?=
 =?utf-8?B?WWhMSGs2czB6T0FEU20zOFZZaEVtZmNjVHUxOXlKbThjZW9xLzFQbmxic0Vt?=
 =?utf-8?B?dVc1UGdZMURnMmcrV0ljdytCcmJ1R2FqNUo1SmJXZ3hGZDF1enArMUs2cXhP?=
 =?utf-8?B?MWRpTmVUbGZEVHZTT01xa0RsR0NpYUVvVlB1cmxrVHA5M3VSdVU3cTk1NXV0?=
 =?utf-8?B?U0U4TjJZcjhMMzZkRldhUVJ5Z255bS9DNVk2TExwaDJBLzZka21zQndSbThO?=
 =?utf-8?B?MHptQXBnZDZJZjEyY25qOUdmam5kUEpqSkNuVFNFT2M1UXhpMFBOOTQ0QWdu?=
 =?utf-8?B?VnR1Z2tHbjZwVUg5ZnFEQm0rZ0kxd1hWNnlQR0cwaWxmZm1FWlRSY0puVjRJ?=
 =?utf-8?B?OGU0NmhoOFVmM2V2aFJiVUd4Y1B0cjR0aUFrTndaM29pd2JDRzcxZXBnTDEy?=
 =?utf-8?B?V2NZNFJLOVRqem5kVlFhQ0xYOWU2TExLYnN0eHNKZ2xHQUV2WUplNkZnbnM4?=
 =?utf-8?B?WDVEREV5YkhaaGczKzZRZW5kTHlva0VCSUtDU1lkdlpzQXV0Y2JFZlFWQ2NO?=
 =?utf-8?B?ei9VbUdpWmFJWmFRRW94Q2Y5cXhDU1VNUEZJcWtnTXR2cUI2bzRKYjBPdTQ2?=
 =?utf-8?B?STRrUDVmajNUcGpHOFZpbXN4RkExeWNzYVRmditHdDgrUjlnSHR6R1hNT3R2?=
 =?utf-8?B?SU5WTTlqME9wTkdTQlU1U1QxZG1XSk5jRkdSa2NwS1pUd0haRFpYOTMxYVRU?=
 =?utf-8?B?UjF0UExmVmdzU1RxelFWdGtLQjhMRlI0ZkcxM0phZ1E0NGhUOFpoT1VrRkJu?=
 =?utf-8?B?M05Yb2Z1YmtQVlFBWkl3TzVJS09aZmNyQm8zb1RlWnZPTVR6aHFIT1o2WUwz?=
 =?utf-8?B?eUcwYktoNkszT1VCbmN3WmExVldZQTJZbmloRGlySE9tUWkwdnJVcTd0TzRa?=
 =?utf-8?B?ajdlaVVQdVhKdnNSaFMySmRkL2FNais5Ry84SlRySnFxd21zZHNEZk0yMmlM?=
 =?utf-8?B?bzZCcmNXaHVsY1lWMkRZeml4SXRvR0xaUXlKZy8xTm1TWUtzeTdnQUJsckts?=
 =?utf-8?B?T2VPRE1pY21OMytJRHpvdU1KdmF0N3Vma244MGhjM29lT2ZFZWpNUmxCUWVC?=
 =?utf-8?B?OVRNUjFid0NDU0xDNWZtTDVxQ2tiY00zODBvbGFNdnlCaHNXN3M3WGh1ais1?=
 =?utf-8?B?c3gxT3NrTGpJbDR6cUVpNFZ2cHczSEJ6eUFsSUxLbmc1bFB5aVlDdWNqTDA3?=
 =?utf-8?Q?ZEvEjGDVtU9yHzC9FoLfpGAT5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a750ae-257e-48cb-d05b-08db6e16b094
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4138.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 03:06:33.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWtnUy+qltNxe1q9H4iMsQAehglLxcGT6P0NL88ve+dhOIkgkk8srlzY1Y10CzK+faEpfTjX8h+IJJE52dT38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com


On 6/16/2023 10:01 AM, Baolu Lu wrote:
> On 6/15/23 3:16 PM, Yanfei Xu wrote:
>> Even the PCI devices don't support pasid capability, PASID
>> table is mandatory for a PCI device in scalable mode. However
>> flushing cache of pasid directory table for these devices are
>> not taken after pasid table is allocated as the "size" of
>> table is zero. Fix to assign it with a page size.
>
> Documentation/process/submitting-patches.rst
>
> Please add more information about
>
> - Describe your problem.
> - Any background of the problem?
> - How your change fixes the problem.
> ...
>
Got it! Will improve these in commit message.

Just noticed this when reading the iommu code, no actual problem 
encountered.

>>
>> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer 
>> coherency")
>
> Do you need a Cc stable?

Yes, will add Cc: <stable@vger.kernel.org>

>
>> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index c5d479770e12..bde7df055865 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -115,7 +115,9 @@ int intel_pasid_alloc_table(struct device *dev)
>>                     intel_pasid_max_id);
>>         size = max_pasid >> (PASID_PDE_SHIFT - 3);
>> -    order = size ? get_order(size) : 0;
>> +    if (!size)
>> +        size = PAGE_SIZE;
>> +    order = get_order(size);
>>       pages = alloc_pages_node(info->iommu->node,
>>                    GFP_KERNEL | __GFP_ZERO, order);
>>       if (!pages) {
>
> Is it similar to
A little difference that real size may less than memory size calculated by
order. But it is no effect. I think this is simpler.

Thanks,
Yanfei

>
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c5d479770e12..49fc5a038a14 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -129,7 +129,7 @@ int intel_pasid_alloc_table(struct device *dev)
>         info->pasid_table = pasid_table;
>
>         if (!ecap_coherent(info->iommu->ecap))
> -               clflush_cache_range(pasid_table->table, size);
> +               clflush_cache_range(pasid_table->table, (1 << order) * 
> PAGE_SIZE);
>
>         return 0;
>  }
>
> ?
>
> Best regards,
> baolu
