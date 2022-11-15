Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0C7C
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 02:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668478344; x=1700014344;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=f8ophW31XO5X8Wt+BM5/oq0zKcq45Z4FtcQ5+JyyLVM=;
  b=RwMsHujk6aIb2UFuQSAnERzFWCYgQtnpeTvH430CR7gqXmlWFsuDtElZ
   1MHTEyvS+AlLio5cDIKovz3F8zB61j6yWveBjdVQSGzW5bw1imcZ8QqNQ
   +1dlBkk3pyhxTJ/DTcDGSR/EVVkxGHxRogYrTmmUJRfrPJ1d+0JucmNSh
   fV23PSbdZZiQNyBnkHYveWWIqffJBNQSk/+8do9ZxhdsWyVwVG4W4WybG
   oCJB1N+sRFb2wmWX0KqZCFGVhKx3UfxUtZ0HQ04mE5Rdee8bhesF52RTy
   yXSB8YEzdZJOFfaM2/R9UsBi+I5BSymAeeVmPXn6DFQNxzt2VQrAkkkEv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="291848423"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="291848423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 18:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638751381"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638751381"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2022 18:12:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:12:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:12:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 18:12:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 18:12:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFGZY+UZdS1v6xKVnjfWScJ6nqbxIAquxr0iA0a6TOg3UdMUCXXEjHb/neb/bsG55UnKYfikWQs5UIJjnWSHgot9mGBuP6febbOHl8ZeOjhclFx7lZOvCQaMfcxQmiS29c2htAoAWxm59/6xmvtwcdGxllm/mTuoV3ub9q1dpz3C/83SLpx4Rm2GINou4Bm2RnfCjcWVH5jyL6i9Yy57bmeOy+jAY+iWq5VHckssx8ONmmoXa+Lxp+unieVlNzZcCDKx2hPkhf4g0zRJ8wNb7iqhbslexwSp22b7ieSBIHQ4rRXA4CxBj/jbR6eyptkt1hDk/YcrJKCyU4bJaqPqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaEhGQ94WmtbBp/4UfbKzZTk5Zpop+6nmmemRmk1nSE=;
 b=n6IfW3pkldX7FciYbew7lEQPNuMTrv8XV98J/yt4MqdqNCn/v7m7Vn6NXFKct75xV4Fmztmj06W+OciqXUVhP7qjuhd/AS007w+mYxnBXNFD5eerHOjTU9DYGgdo9NNv+d4gUEjMm0cq8Dd1/2385kBkAEui3hytFsm/2gzGJ1rqbxHjL5pPYpx4kbrqE8XnIoLhm4wM7J+hBfwgXsEvtm+UuJLzxKieGbKnNpsRXJ4/S3lYQYGobA5kWUIGC70dchYCd+EdsT5QWAtxd4UeMgFR50FOSYr0JQcNNRIM1Zdciol5bS7b8cKb3EJ0ZdDERvBiABh6D4gJsWvSFWLmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH0PR11MB5706.namprd11.prod.outlook.com (2603:10b6:610:ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 02:12:21 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::468f:5d8:f147:1cb8]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::468f:5d8:f147:1cb8%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:12:21 +0000
Message-ID: <5c572fe9-f45d-2fc1-733c-9c1f1acdfe98@intel.com>
Date: Tue, 15 Nov 2022 10:12:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH] iommu/vt-d: Set SRE bit when hardware has SRS cap
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20221114085514.1105039-1-tina.zhang@intel.com>
 <6a34aa78-17d2-bb44-1e50-76239cd1ffbb@linux.intel.com>
 <adfe9835-2a05-95d8-5506-5fb6163bed43@intel.com>
 <c063e57d-6703-911a-4042-2e58fd91e3b2@linux.intel.com>
From: tina.zhang <tina.zhang@intel.com>
In-Reply-To: <c063e57d-6703-911a-4042-2e58fd91e3b2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CH0PR11MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6c0169-5253-44c5-85a4-08dac6aed325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMV5V6YlYeHwhFp+xf5iAR66g31ZCIb+MacC6WEgoYoohfx5pu+0G1/NvZjaeKilCQC49YdKZDwwlu+tk8blCi87rshVg7+B6iwOFpJ0WbqK6RwxPoC/GMJ+1OGReDzDD7Hx4o4MIbjd/oODWlms9ZJ2Bk8RG7RkWVBmiY0mjUmDfzOg3M9vcnfxej4gucu+mlrFj3T8eeg3F2H25vHFuuuShAab9l27J8RQFAU1miOJHRQwyXrxxWj6am+pHDX/BXLd/TNIY0XOE4CgRR2ckLlscxf63Evnta/cmXnku9fSApbelDZeAf/ouiGwFNBhuEip67JT11xvEvQZV2Wv+xY/qimQhuORI+eT47XyUTCYyTm+5E2LCB4Sk4xvRftoVFAN6SH8IGn2HZ2VyafYPvXSfnIIy/cfr4yPjkDhaQ7QVIZvMG0bu8sI5cqrMhYSHq4+bgDkAZxUhNoR3ycH3uz4w/ICTvEqYReWl26RrpRrv3z8Z2LRWrEj+zl5HDZtLvx+XN7DutxQuaSFbsE2cVpIZZiiczrH/3CpkosShqCIEhmGQ3etSfdgVN+HrJgwbXFzrnc6dndbBRGYIlWlDtX1QRJ5prTn+P65paLWU4DRCR4yuoh+CpGOTjLhpYK3GA1Qk5BxP+Vpy+FcEB/KCxknjlWmyv21kEbbLhzKjsIzOVgi8jnBmSzmXVsDogyhCiPAdQqPFC61ri7fZtmyhpgYdOfiYLGk9x0PE+h1LRp1aDFOnGLPpx034VDt/r6uztxoYqj01wmLk/a7Sh9Z/pW/poqdPnzjdmcACaIJ0no=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199015)(6506007)(53546011)(316002)(2616005)(8936002)(41300700001)(186003)(36756003)(66476007)(66946007)(26005)(66556008)(2906002)(6512007)(5660300002)(8676002)(478600001)(6486002)(31686004)(6666004)(83380400001)(31696002)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VhNGVRVUNKYmVNaFlqZGNjbWl3SDVPaS9YQmRJanpnRVdaTkpHWHlsTUpG?=
 =?utf-8?B?YUs4ajhrdDBNUVV6SVI2dzlOeUczQUR4dllTY1RMcTBGaElOUlB4UUxsRWxn?=
 =?utf-8?B?REpudk1iWm1OTGpTV0lPOTVtU2V5a1h2QUF1ZERVa1dpV095SjZKRGxFc1Jo?=
 =?utf-8?B?S25NRnpzYmx5ODFtTENBOERXU0lrQk1vWUQ3UWRhL1J1VXYvMDJwbTNON3ll?=
 =?utf-8?B?T0R4K2pLWi8vWVBLMVlQazVXOHRvWVhRTXdBVEJXZlY2Y3B6TlNKeW5SVllD?=
 =?utf-8?B?OCt4U1lYK2N2VjhYOVQ2cG9XSlhFSEFrRFVVUUNpcWxRd1BJTm5DNWJCYXAv?=
 =?utf-8?B?WkZHQ3MveW9FdW41Vk1JRCtFWHFuZDN4MXo2TFVNc041dUhkMUUvb0NWNjgr?=
 =?utf-8?B?T1FwS1UyeGJyVHZEV014RnRYN1AremRiOEdCaExFVkJoaDhNeUd2T3NQNzQ4?=
 =?utf-8?B?em9vSElQbXBxMEtvVnBIZ0dxYkZ5aGZLNWo2VjRyZmxkUmhIUTVjYWRwV2N2?=
 =?utf-8?B?YTVEVnpmSTBQdWJLV1RiUk04NDZSSlJ2Rm02dEx2RTBzNTNvNTRibmNwZVdk?=
 =?utf-8?B?VjRCWVZOb1Y4ajhQWHVnZW0rS1dRRWcyU25ybm1UTFlFUmxLVFlGUEtvSUgv?=
 =?utf-8?B?KzV3UHZaUzZ6ckVqNENDK0VjMXBxdG9PbHJwdnVYaVBTQmJkNWpJak9NSUhZ?=
 =?utf-8?B?Qk1ENFY2ODN0VmNiTC9tak55UjF5ZWhZN2VOYWZkU0xjNWcweHFpbWxDQUVZ?=
 =?utf-8?B?UVk5SC9oQ1BzM2k3ZktkSUVXVUtrVldjcVFlRWhWdG9ZS1hNUFpuM2YzUndO?=
 =?utf-8?B?NW5SVi9uMC82NE1KRDNmWFVKRUpmS25kTUk2aWZ6VGwzVFZlZStYc0c0bXFl?=
 =?utf-8?B?cmxXeklOOGgvTk1kc01CRjN3UzQyYVdXUE4xOXBpenlaRmNPdmhDZEMxWllI?=
 =?utf-8?B?Y0pPZUs2ZFlxaWppeEZKeFNYUC9YZ2tQM284bWROQmg3NGdxUFVDUEY3UDI1?=
 =?utf-8?B?MzhyeVc1UTl6dHg3czRFTmNLcDRRNzJIQ3RpcCthbDVKVWFjKzFCMEFvRlIy?=
 =?utf-8?B?cmduOUREWFBXOEhtbkppWm9HQ3dBUEpua0x1S0NBUUVnRDRtNUFZRGY3SENM?=
 =?utf-8?B?ME8yeHVwKy9BdW5wTnA1OHZub2k1cHpZMjhxK2pseDRySkxVbHdmWkVHYW9z?=
 =?utf-8?B?eG1UT05oNGRyRFY4UnlmbGdpempsRDY1NnFURHZzeGlNYlJocmRRK1JtcnBn?=
 =?utf-8?B?VEtFSkR0VWo3cU1CTlpNTHd6QUFUOXNmUmxQdXlFa29hbjJ4U3pkL0hpdmZR?=
 =?utf-8?B?WjIxYWhicVRKZ2VaLzQ0UWJ5cnl2d1lSMTN4cUhIeDQzb3YybUdKdzVOaUFv?=
 =?utf-8?B?bUVsNGpnaHNwQ1J5MWo4YU00ZTM2Zmo5V21XN0xBeUlFQzFORUt2V2FsSWVW?=
 =?utf-8?B?UDhZUzFvbkdRbWg3ZDBLVWdUeGpzVWhGUTZLSkcxd2V4SjNZeWtwa0JXQU40?=
 =?utf-8?B?bW1oUWV3dGpEVXQ5dDJud1Y5WG8yU3Rsc0Z0VjRpa1N1K24wcTN1bzBVOGJW?=
 =?utf-8?B?SkNNMnh1clYxWW5pQURCNDcycmtWNnlvSWFRTmo5NmFYR2FmYTd4RnZINkl1?=
 =?utf-8?B?OVZPcmZlOURFRGYwU050Mzh5TEJ5S25EeEJnMHVxQ2hGSEdHTXZlVkFkN3lD?=
 =?utf-8?B?aStGNHpJTHRIdXZ4OGNVNDQxMHR2VnBGaVFrK0ZTT211d2RPbEd1NUczTDZp?=
 =?utf-8?B?bnJGTy9BNUlWOEpOV3BqSjZjVVRZeTBrcnMvcUcyWWtPamdhWmxUVTdqZm4x?=
 =?utf-8?B?TWNiQmdvTmk3cnRtRmhBQlFpaFRmVUJZMjQycm1sZmNmdEs1VzhVR1RENXJs?=
 =?utf-8?B?dGxzUk04NmtnLzBUVlBweWNIQk1INUZWSXNOaFBVRDRCMzhZQkxUVUdPb3lk?=
 =?utf-8?B?UkFWdnh1czhzN3pVTm1KOHp5aGg3MEhIUGF3TWkvK0sxWWxsR2dSTXdYakN6?=
 =?utf-8?B?dEtVVEVOSG9Lcld5dXZYMmpUOHhDUTdMRkxkYzFIZURJQ2tXTmk3V3JSaTdL?=
 =?utf-8?B?VC9xMnQxOXVaN2Y2aHgrYmNsM25XeFpmSWtrRjR1OXNLR2FQYWo3Vk1rcWI0?=
 =?utf-8?Q?KCOYFwg08eTKx+6+ibSQsvH6h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c0169-5253-44c5-85a4-08dac6aed325
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 02:12:21.4951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNuDqzRWrA74G/vagfXi4qyE3HJlCtEPr0+/NaGcNRdvzxMX2jIjO11BzTIaWXor2h7nP37K6GJzhs0jYgMDAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5706
X-OriginatorOrg: intel.com



On 11/15/22 09:40, Baolu Lu wrote:
> On 11/15/22 7:55 AM, tina.zhang wrote:
>>
>> On 11/14/22 20:00, Baolu Lu wrote:
>>> On 2022/11/14 16:55, Tina Zhang wrote:
>>>> SRS cap is the hardware cap telling if the hardware IOMMU can support
>>>> requests seeking supervisor privilege or not. SRE bit in scalable-mode
>>>> PASID table entry is treated as Reserved(0) for implementation not
>>>> supporting SRS cap.
>>>>
>>>> Checking SRS cap before setting SRE bit can avoid the non-recoverable
>>>> fault of "Non-zero reserved field set in PASID Table Entry" caused by
>>>> setting SRE bit while there is no SRS cap support.
>>>>
>>>> Currently, both intel_pasid_setup_first_level() and
>>>> intel_pasid_setup_second_level() implicitly take care about of it. The
>>>> only missing SRS cap checking is in intel_pasid_setup_pass_through().
>>>>
>>>> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table 
>>>> interface")
>>>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
>>>
>>> Nice catch! Tina.
>>>
>>> Can you please double check  intel_pasid_setup_second_level()? Its seems
>>> that we missed such check there as well.
>> Hi Baolu,
>>
>> Yes, I thought about it.
>>
>> In current kernel code, the intel_pasid_setup_second_level() is called 
>> only in one place and value of the pasid parameter is PASID_RID2PASID. 
>> In the body of intel_pasid_setup_second_level, the pasid_set_sre() 
>> won't be called if pasid == PASID_RID2PASID, see:
>>
>> intel_pasid_setup_second_level(..., pasid) {
>>      ...
>>      if (pasid != PASID_RID2PASID)
>>          pasid_set_sre(pte);
>>      ...
>>
>> }
>>
>> IIUC, in the current kernel code we don't have the case which can test 
>> pasid_set_sre(pte) for second_level PASID_ENTRY_PGTT_SL_ONLY. But in 
>> feature, if we add more points to invoke 
>> intel_pasid_setup_second_level(), we may need to checkout this SRS cap.
>>
>> So, do you think we should include the checking in 
>> intel_pasid_setup_second_level() as well in this patch?
> 
> I guess the purpose of this patch is to make sure that software never
> sets the pasid entry fields that are treated by the hardware as
> Reserved(0). If so, let's make it explicit in all places. :-)
Sure.

Regards,
-Tina
> 
> Best regards,
> baolu
