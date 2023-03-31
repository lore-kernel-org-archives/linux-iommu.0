Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A71864
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 04:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680237050; x=1711773050;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+LpjTMiDBPGywv/0k4tnA8Bbgv1uc//rGJ52kR+MtOE=;
  b=XFYo6Ar+SkSLP+jfQ9icr5joa6XPdTEi+ufdTgJQwahVqLNrw16oT6i+
   qBu3YjnUXWo+aKKruodweOc9/edw8BFpq7P0XrPloZMMiVwcPBr9ifcmV
   IYyK0tbAMO5B3RfobbxQuBRZJZOaA0vcqG6cUbYzfWUfFDQT/35jpi2B7
   X7KdaoGAV65vRlo9CDiILC2TR5AIw307+27KAYJVzfH5gsZj4Ft50oHWo
   Q5luBxvrkK/PIiJsq+tmXNZnQNdeyYwKbh3TOZ+fMeRC3DpPUqBEVTLq8
   Eg5KzY659j/ghBiZf06I22YIG5hNq7M9MH2RqG5rCnkU+rtd6N9yawK2L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="340085092"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="340085092"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 21:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="1014693342"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="1014693342"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2023 21:30:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 21:30:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 30 Mar 2023 21:30:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 30 Mar 2023 21:30:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QojgDLswixh1TE8fqEFc8iFQDmvMwntsP01Y4I28Z+UgiLuHTSvXtHD4XDrQ3bMb8hQpF2TBmRjqDa0jfG1aa3Zj8AfjTbY5pbwfvAHjKRqj1QstMhlp9a5J7cn2c+aLwixEQgiGHXObpqomiXMhEzhiTbVIFHUiVfpKVkqcxDfed37d2SnOOanrAXi8wIfaVlt76e8F/a+r1VlGp7qcINM+xda8R+oBNacq9wHViV4bAjgJoT5+EU4pAEHBZniq3pvEHzywed3yIhIboI8pzxohpntw5tFH++oC7V80oQpNaUhzur7sOTJtluBgG6WTkNIyw33dd1vHOjIM7pEVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwA0zE+AUTQ6QO0f1aNNotvYzK5DxftIrfltyZtDyGk=;
 b=I+MaBWJOYsTOtal0EpQoSSkRs2Lh1pPpXN+4mYZ9tpDM2w0kWzfHV5eORtL6NLqVXgdvhYPj0AVpRwwfBSNeEN2oNkqSWmmN8mA5hXzLi9zOePQTd5j77YnyXrRoFhlrV2V21cNkCR/Rmtq1RopQqwzjyPcxih5saT3RJ+61ecE+XsSTwqL6pvkiZoO9CIbVjtjeH+qaQ9gCfC5AZgi51lqJL7aN8rnl6tZAno+9u2EiTy4luU7qLRn1ROixpqmaI+q5tnEtyOjf8f+XgFcKS5ddfu2NQk4BTBlF2Ax61IWvhO/IMQ9n+QQNg3NAd9iNqvq+SFgyOw+hSW7vt35oTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CO1PR11MB4899.namprd11.prod.outlook.com (2603:10b6:303:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 04:30:47 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 04:30:47 +0000
Message-ID: <86864a7a-f369-473a-afef-fc032f27029b@intel.com>
Date: Fri, 31 Mar 2023 12:30:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20230331024236.2716001-1-tina.zhang@intel.com>
 <20230331024236.2716001-5-tina.zhang@intel.com>
 <3ac862db-297b-068b-743d-18730ac3002b@linux.intel.com>
From: tina.zhang <tina.zhang@intel.com>
In-Reply-To: <3ac862db-297b-068b-743d-18730ac3002b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CO1PR11MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 9343d561-4468-4c76-eeb0-08db31a0b2c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 07YMWWCEWumyW/XF/xXVe4Sg6avnxNOQfjRicfeTnCnlvNpne7LUv+7xSCP1BTAovvqtuDVyMKnhrmdoV5fgjFU4v8chzoZc4cOuq6HAO4lwtyZ0L46KMFlOY69lAr6BiVqMsqIYVKwKoGuSi6iExmlPNmSsOzfQ1v1LIWXOY5UhU5ygt+AHVimHYo1Rf5K5+JQuHF+aAd9YUSPfiFfqZ0UTxqN/vR5lVSrjaryVRwKbpCEG39/IOtMMjChQKykoE0AHMjhWcZMqFWDyMzOsGrbAsyyGmUbygNVek2jaYYzLZkEgK3fzYdXyc8q/GBVZMKglJn0uXH5W6O63C8C+FF6IHZvWKaZ0XhMrNTKrR3imunI54UVxtq+SWUibtmCLjmLdTuryvrzwDlA51mVnn/RlxffGiQhcShdHYIyPygVsUtpYYSzAqZhPBHuI8WU2fXrDFtvYrX7mV3m0bgMGilcVm1NiZFojBrl6muQNga3Y2qV+DUPKqLR+Ilp3L/7Az/1eDPZSObyfsD5VKlROf/JT+CXM8TXSdMJHMqLechNZNjDWqDi5S6MFIGAlHDzgmSe/bzoLTUtaDElpaJLNEPJE77Om5HU/GsKDrcrBcrKKhifxnQ+0a893GK1rF1xcd5S9IUu9zxh0rCEl4E8D+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(66556008)(66476007)(66946007)(8676002)(2616005)(31696002)(53546011)(86362001)(6512007)(478600001)(38100700002)(82960400001)(6666004)(6486002)(186003)(316002)(2906002)(6506007)(26005)(36756003)(8936002)(41300700001)(83380400001)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZnSzllT1NFanRzRGVWZHFmeWhLSHdMQ0JER25vQ29qYkQxNHJFYzliTk5S?=
 =?utf-8?B?TTJvSm1CZFRZUmtiOXJVUk9KRCtwZzRuV1dTcFJDQjZPTVQwWUNvYlZvMnQ4?=
 =?utf-8?B?ckxIbFJacWN2TnBRL255MDl6Mzh6ZDVkR2xvUFJJKy8rVTNlMW9vTnFQVDZy?=
 =?utf-8?B?SE5iT0p3MzJaU1dScHBzUW9yMW1tc1dETzJDZjdUWUZHV0d1RTZOSzltODZU?=
 =?utf-8?B?bSthUExpSnd1Z3pzaERhcFhTUGQrcExjT2kzaUNtOU1RVUpTMHZ4SVNtdDJT?=
 =?utf-8?B?Q3VWMnhxZEdyeVR0QnBFdGIzMExyRTJmc2pldVJjNUd0emt4NEJuSTVwWXJz?=
 =?utf-8?B?VnMwMi9neWtpbTNkdXd4ZElMRXBZTDY4NWVZZnZvNGJ3aERjOTR6ejk0c0wv?=
 =?utf-8?B?cEhsSjI1dVNGMTQvWjBGRXVvVno0RzdobWQ3Y3JlRVBXcXgzQ1h2dWZRZElx?=
 =?utf-8?B?WlhKbjVhTUE4dGtGOVQyalJ3T1RzdnpES01HUVI0SEpEQ1krN2ZNRFEraG8w?=
 =?utf-8?B?azg4c3BUWVBzU0tYT3dMZHE0UDdhcTRYRCs2ODBtbTNaaGEwU0Zvb0MrcWVF?=
 =?utf-8?B?L1FnV3hNajRDaTFXTUVOWkwyUnAyNjNVUEtseTVFUFJNSS8yYitDb2ZsRk03?=
 =?utf-8?B?QnFIZEZnelFjWWk1N1ZGdWZkNFpXRWpVREE1V004Qm96RDZObmEzcFlaUm9Q?=
 =?utf-8?B?OXNqdmg3SU8wdkFXdTdvaGxOSkVjMEFXOXU4b1UvMm5VMHc0Zk0zSFBXa1ZG?=
 =?utf-8?B?UXBsQXptTUdSblVJem1HYnVRZGV5YzViY1k1d2lDbk85bll3cTUxcVNNNTEr?=
 =?utf-8?B?cHVsWlFyRCtmakxYRDllaEpqaldGY1B3NVJkTmZkOTR4Z3ltK3lqNytUMllK?=
 =?utf-8?B?cVZxcXZmMXFUdTJkNzFQaHpjYXFjcW16V2lzSjB2aXpRd1kydklOVWtnTDJk?=
 =?utf-8?B?dG5DL0RPVjRHR1FpdFJHQkpNZ3NyWU9ScFcyd3V4cWJlWnhvY2ZxcGJxaUhj?=
 =?utf-8?B?VC93aWMydFRNOFpZbEZpbnpwdlFpSmp3S2FqeENZeU9LTmRUOGRuWWhpOUtu?=
 =?utf-8?B?Y3RrT2lnYkZtUlhvM0dWQWtESnZZWGFRcWduZk5laUk1Mnl6MHI4VHRqTnp0?=
 =?utf-8?B?S0gyc1FWR2tHZkxjRGFCZkgveXB4SnRacTZhbkRsS01zejRNVncvYkVrRVpE?=
 =?utf-8?B?OTNZYngxQitya0hWckhnWHNTYVYyNzdrRkVMSlNTbXRjV1BxVzBjL1NnZVhH?=
 =?utf-8?B?L0x4SnI4QURMdmhyME1rdytEb0N1V0hOK2FQanM2Z0tuRWxpaUdYd09ybjgw?=
 =?utf-8?B?RGNpazZRakR3ZFB0SFdQWm9Fc2RlM0w3OGZzUTZ1M2w2N2ZSWkYwUGhXQ3Bm?=
 =?utf-8?B?M01peFJ6Uit1ekpZa2xoS09NbDMvdDlNR1dTaXQ3TmhpZlVjT005emRERGtW?=
 =?utf-8?B?YW8rZzBaMFNiMDQ2WW5lMVdROXYzaFJ1NDhjMmQ3dkp4aWloTkRMT2pUREls?=
 =?utf-8?B?dk9Dcy82dnhjUmhiYnVKNWR1TGhQTmxLM1FwSkN4WE9qQkV3blB4ZDR6RlJl?=
 =?utf-8?B?bzR6cnJ5cjBmY210cUY1QkVmUjBJVUVvRzN5bGEzMFM5NXNzdW0rbkVyNmhT?=
 =?utf-8?B?U2dBQVNkczNvMUFhUVJkV3JWSHFPbnlkbmRkYjlHT2g4YVV0M2dEVWhYMkhR?=
 =?utf-8?B?eUhvNldJZzZXb2oxRWh4OThZRUxMMXRNMFFaSE0xSlhNTy9sbzBvWFpJNmNp?=
 =?utf-8?B?eUN3S3BnaGR2TG1xc0hyYndWOCtZMGNyeTB5Y3k1QXVwaHlkdDZqbG12OUNk?=
 =?utf-8?B?UkgybTlwQjdUVVllendCNU1wbWhDalRicnJic2JyRnRpV2xQMzZtbHpXU0xZ?=
 =?utf-8?B?MTJnMDFoaDk1aVA0T3JSd0lxM1VnSVVNODZMUHA5dWNpZ2RtVnFiTFBqVTFs?=
 =?utf-8?B?WTM2dlpUVm5wenptWGJLNnlXZnJZWUtoRXJOV29vdS9xMW9QOHh4Y2JMYW5D?=
 =?utf-8?B?ZXk4N01DaFZ4SDJNQ3NxMGFEVldGc3oxM0ZNQXVVZG5JQ2lpL3o4R0pPd0pW?=
 =?utf-8?B?RkJOV25URlNNTnZyRHVpdGgwU0s4MHpIbmJqa0JmYmw4N1lpTU1TbDFRY1U0?=
 =?utf-8?Q?djm5t0DkpYiCXKoJ1uyXYTj+2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9343d561-4468-4c76-eeb0-08db31a0b2c6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 04:30:47.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP8cHkwCuL5+opD7s5W2nAhjXAhp5No7P0Lzn5yj7qK4LboakMMmB6VQL96C/JcsbU8iTrHm3iafBDeAjoMHng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4899
X-OriginatorOrg: intel.com

Hi,

On 3/31/23 11:25, Baolu Lu wrote:
> On 3/31/23 10:42 AM, Tina Zhang wrote:
>> When performing domain_context_mapping or searching dma-pte of a pfn,
>> with invalid domain page table directory address, which is unexpected,
>> shouldn't crash kernel. Therefore, using if() instead of BUG_ON.
>>
>> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index de7fe7dcbc5c..e1881d48c2aa 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -915,10 +915,7 @@ static struct dma_pte *pfn_to_dma_pte(struct 
>> dmar_domain *domain,
>>       int level = agaw_to_level(domain->agaw);
>>       int offset;
>> -    BUG_ON(!domain->pgd);
>> -
>> -    if (!domain_pfn_supported(domain, pfn))
>> -        /* Address beyond IOMMU's addressing capabilities. */
>> +    if (unlikely(!domain->pgd || !domain_pfn_supported(domain, pfn)))
>>           return NULL;
>>       parent = domain->pgd;
>> @@ -1927,6 +1924,9 @@ static int domain_context_mapping_one(struct 
>> dmar_domain *domain,
>>       struct context_entry *context;
>>       int ret;
>> +    if (unlikely(!domain->pgd))
>> +        return -EINVAL;
>> +
>>       WARN_ON(did == 0);
>>       if (hw_pass_through && domain_type_is_si(domain))
>> @@ -1935,8 +1935,6 @@ static int domain_context_mapping_one(struct 
>> dmar_domain *domain,
>>       pr_debug("Set context mapping for %02x:%02x.%d\n",
>>           bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>> -    BUG_ON(!domain->pgd);
>> -
>>       spin_lock(&iommu->lock);
>>       ret = -ENOMEM;
>>       context = iommu_context_addr(iommu, bus, devfn, 1);
> 
> I'd suggest to remove all checks for domain->pgd.
> 
> If a domain has map/unmap ops, it should always have its own page table
> (a.k.a. domain->pgd). Hence the domain->pgd check is unnecessary.
Agree.

Regards,
-Tina
> 
> Best regards,
> baolu
