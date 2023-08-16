Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD017F7
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 07:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtaGdkok4DZXxS48bjYNsxXPn7j14kZipSlKwi9yIzoMY7BAe8uCgn7/19wuYK5TIQy25ZYshzDCI6bffPtgARMfSW8kL3fNQJkqmuonZdUWL8Az3bdeqLK4oE48XwgQUTy/foUoLTDO1JdUxXvf3vLQcm2f8KZfJFWF8+DPYLZyuLzWB5mcfiBzH90s9CuapI1XNZOjn7pcQaO+6FfKiQACMrbSl9ThS2iv71VtujEhKqGWqCErqrnNSpwcK0Mh48w2knEo7CCyi3wBa/u94ZV9AmzkSRk8FapVgyKQZYKLOumGvezKS5QSDdKyN2dfgGvxmW96qrU8NH6KGhWKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxHVxHJIsIgbZ4wdSFXx0mmJRK4jK5Wc8HSc8Bj0zzQ=;
 b=Ay/roePWJuhw8yXRs+Sn85OtAViU2nWKmNG7eFCf5A5oWmfuWJeoPP1kolxCcNoYunkQ2u6M3f3VP2bf1y1DEVD4iJKhW4ElNFKUnMBzrSUfiBECGFSyqLLJVHBcN2LZ40QC8HKZG9o4BJhTSYkpLwx/p2iRArEqylbh1jNmOVj0nxuxIupD0forznomT8rq03VosEX9J/qdmr/Jr+rEeaDJzSe3fCdaIWSphgaZp2AyPtpEr439s9olNpj5YeUTngkG2jjaFiNbyHVTJFtQ/Soh7QPeaxvKk4akI/nJMNOWwYTtdl+lLxbY+vplu8S4Q/GgVuCrYz3h04hfkLSfow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxHVxHJIsIgbZ4wdSFXx0mmJRK4jK5Wc8HSc8Bj0zzQ=;
 b=G0uDyoml1ReKaCi93Mu3z9XZAQfHlk8bAimVGOcAl07RXEHQDhCed5Ze68TKDTIQDCXY9ZQk3VycHUNAd0rQBtHnJ4b6sUJ72fbGcDS+UH+RkC4BOX64yzLRe9XGQ2SPPObuhRGgepN4HrGRc5hqh2b/JsKZuiQCyZJj9fx3pfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 07:20:05 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 07:20:05 +0000
Message-ID: <0589f2c9-70d8-22dc-6fbd-d8d547b74d23@amd.com>
Date: Wed, 16 Aug 2023 12:49:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 11/14] iommu/amd: Introduce iommu_dev_data.ppr
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-12-vasant.hegde@amd.com> <ZNvE4r/NOSM5N6Z/@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNvE4r/NOSM5N6Z/@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf32e54-f795-4cc9-16ec-08db9e2936a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lixD8SqjFegRUekswYypCP4gNC59eyvooagpnjDfotG+JbhKdf/i05wFU3rc3Bds6yl+l20CMevDnQLCIueUUWs9c1f6CaGyBysSdYWEuLDDmZ8BuC6e7OYnNWlxXSPD/q0ix7ihCGKBqsotqdZ3im7c+jtCR6xS8cdSPt8laJ/wrN1q0+KVa2pxhtzAm80P4Y75XTmL7DeLjdw4WSjb5hwk4hg+z916671Lm/0lkp78RGDzJtiICV1aX6qReEDVyP+noFGcJWP1cTdcs22ycRpSq7Zw+1Te5BIYdc7WRafy73KPHuYqLyrvz9PsYyeOM5JngeGiwEwkYxQJuEZOEsq58he9JfXDnEBEQI8sNZ103CqraDEUmQpRHd3Ovnk5jflbEq40oEI26ebCFXppnmMO48L2iG/BETBDzUbEETNFV6dt71O6nX/2w8QQF1tqshuWyozCUu0OQVLRVwNgVomQ9VvEmxxkfELaZVu/pWtqP84zjRnmNHV6yjiGqG1YPieUTXcgf/zsJg4nZN+eFxilTdZGwH3E9qGO+9cWkktHmEdEJR9bN+KFCvmzI1+32xlMbw3BWImeWvU9S9s4wNYLOmHYS+oaErwDrkZbU4W630f4jgftA+KtJq277gZOONFHi3v8GVz69oqUw2vBcw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(6506007)(2906002)(478600001)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(44832011)(53546011)(8936002)(4326008)(8676002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUlLc01rcmo5OFZ2VUhiUXdXYkNjUlBvWFZ3Qm1LSSs3S01KMDN0UndhTlNs?=
 =?utf-8?B?T2ovWlJNd3I3MWwwN0x5SXN0RjlWd09qS0FzVEUyNk1yNXBHSFB5aHp2THFZ?=
 =?utf-8?B?QW82cUxqeTZtUnFZSkJYVnErczVoSnd6dk5HSk5odFgvS2RwL0dZbnRYbVhv?=
 =?utf-8?B?OE1IWkNuaWZCMjZsS3h3SWg1L3BnTnczYXNNOEJ0Vm5nSE1POVE2cU41MXVv?=
 =?utf-8?B?QVJFZXhybS90OFlwQ1dGNm5hOGdzMm9TK0VnRUZ0RnJad1JjY2VrM29NVFE2?=
 =?utf-8?B?MHp2cXo3RHRqV3JQRWRZMGM0VFJpa2xVUUxlc0g0Y21obHdvYlNyMnNuak9l?=
 =?utf-8?B?TmRZWCs2R3VqQm9VeDd1R1B3bmVOSWtMVjFoTUhBaXNKazh5SlJDTTFFNm0v?=
 =?utf-8?B?MWE4M01kTkUyWHE5eWg2L09jRW41eURqbUNOVVIxV2hUaFRuUFlTTE5lcG1o?=
 =?utf-8?B?RkFiZFhBL25XUVZHSHdqNlhTQnp2Q0FLcmVTdFpPSElWNDNIdnBkUHMvblBv?=
 =?utf-8?B?UU1uM0xqYzlROGlDMmZOYlVTeUtidFUwRmdGOTVKR0dDci9vRllWM1gzRC9z?=
 =?utf-8?B?dCtvbmZrQ0F2SHovRXdDNzI2UE9nRlJlc1dERDZXREp4NnN6ZTdJOGFuVWs3?=
 =?utf-8?B?ZkxxZzJYaVJPU1AxblBQZVNSdUVhWVNIUDNBTUwzU1Q0MEYyNFpRRDQ5U1U3?=
 =?utf-8?B?eTk5ZE1aSFM4TGZOYlZmSFdHWmpBYUZESlBKR2VmR09uWTJpcjl5UnIzUE1Y?=
 =?utf-8?B?REdrQnQ1T3VJTlNYWWEzTXZ3cktzeVVLZ1Z3TlNTUmN0WmladElCMWNEQzYv?=
 =?utf-8?B?ZFFzV3pOcWIrZTd5WFJZOTJ4MTlZRWVMNFh5TDgxVjlmL2xTNUl4akk1T1dC?=
 =?utf-8?B?N0VFbStxTy8vZnZ2dzBRNXIwTGdGNGdNbzY4RVNZZDBjelIrNHVIQi9idHdN?=
 =?utf-8?B?STc4REF5b05OR2F3QnBwSWwzNFNwRkJrOGRsYm5Tc25kbDV0bXhZZlR2NDRs?=
 =?utf-8?B?TXhTUVMzcmtwTmRWS1BpUlhFOUtpVGxFZ3RERlNPMEJIM0UzQnRYTzVRZDVO?=
 =?utf-8?B?Qzd4Zk4wVzhEM1ZXYTlOV2NwRzlaT09VV2Z5WHphMmRhRGNybjd1bTBMVmVN?=
 =?utf-8?B?M09Oc1VDNVFmeU1melkyTzFFWk5PNENTL0VTRGFXYXdZb0ZKcGJkRm0wNUMv?=
 =?utf-8?B?RVhBWUhsVFVhMnFCak92NlNnRjlNenFDelBRNHhjZXpoS2h4NTh4dGF5QWJP?=
 =?utf-8?B?ZE4xWmw2Z1dpK0xYWmt5eUNXY0hOaUJnQXZXaEpua21IVU9KSGNjYTRMSzVI?=
 =?utf-8?B?cDhwb1NZaU1CVzVNTjFiZHR3bk5mYU85bVJHcituNVFhNUlnUVdONVVPQ3A2?=
 =?utf-8?B?UEh1THA0Y0llMi82aytBWmZkU1p2TjBSamhxbXJBQXlHeExXa2hpaTgvWFdN?=
 =?utf-8?B?aW1tZFpObTBKR00xTklOTEdlMjJ3cGpkcDhqUTBWOVREMlBFL1BnL2hsWkNN?=
 =?utf-8?B?UVpBS1BFVzl0dWFpMnFCaVhaYkJDTHNlcWw0WTEzdmpIRDIvanNSMmhrcWFN?=
 =?utf-8?B?VDZCOWZRMEFBTSt4cFo4cFBwY2ROT3hBRnk2YTVNVlM0NitNL3BEOWttUEt0?=
 =?utf-8?B?OG5Bb09COXV4REgrZDNmZnJZaTJyMzFkWWRMVkxJZk9DWmZpQSt3VDhyeGs1?=
 =?utf-8?B?NVlCR3EwS3NXQitiVlhaeXpoQTlXTURBQ0l6WEh2L1owdlhOYmNSUlRyelpK?=
 =?utf-8?B?eDVGMXBFZ3J2d05HWjN4QTM2VGoxaGlRT0FDU1Y4ejk0OGhXU041RGwxZDNZ?=
 =?utf-8?B?Q2RTalJlV0diMldJU0JSVGlobWsyTnhpWmlEL0VvMnNPUjNMWFZJbDVVUkJL?=
 =?utf-8?B?RWJrRnZ3Z1dNVGlicm9tQk5zazdSakRrNkxtYlBzeFE5cVhScGFlYTV3eWlU?=
 =?utf-8?B?VEo4Ni9MUGZHdWg5Z2tWSDhodGx5cW1HL1VRUlQ0a2pzYnVzMFM1UFo2UllN?=
 =?utf-8?B?dmhuMVRHaWg4NmViVzlvT0Jialc2a2RIc0d6Nmo1S1ZyUFhteEVNYzNCREo0?=
 =?utf-8?B?UDltNXBpWVFhOVRYb3ZEU2R6ZS8rOHdSVFJaRURrbmRGOUZtMzhaTVN4VWFn?=
 =?utf-8?Q?zzKDt9jkhXgBwOX0nLZwkPTWa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf32e54-f795-4cc9-16ec-08db9e2936a1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 07:20:05.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZWlcsYFUKMm0wq2C4fbultc6wlhbKO+bcSmUZFm7AktYnGD6KdRmQ8vHGWQREBTyqGOBqx9hKxO1A2qriOSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

Jason,


On 8/16/2023 12:03 AM, Jason Gunthorpe wrote:
> On Tue, Aug 15, 2023 at 10:21:59AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
>> PPR is enabled per PCI end-point device, and is configured by the PPR bit
>> in the IOMMU device table entry (i.e DTE[PPR]).
>>
>> Introducing struct iommu_dev_data.ppr track PPR setting for each device.
>>
>> Also iommu_dev_data.ppr will be set only when IOMMU supports PPR. Hence
>> remove redundant feature support check in set_dte_entry().
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>>  drivers/iommu/amd/iommu.c           | 10 ++++------
>>  2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 1c61dca63824..c9027119ab35 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -816,6 +816,7 @@ struct iommu_dev_data {
>>  	u8 ats_enabled  :1;		  /* ATS state */
>>  	u8 pri_tlp      :1;		  /* PASID TLB required for
>>  					     PPR completions */
>> +	bool ppr;			  /* Enable device PPR support */
>>  	bool use_vapic;			  /* Enable device to use vapic mode */
>>  	bool defer_attach;
> 
> Linus would not like this if he saw it, continue using the u8 :1
> bitfield..

Sure. Will fix it.

> 
> Otherwise looks fine
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks
-Vasant

