Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93620FE
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 16:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADTCnVXn/N0pH9znw161TdZJWNEEw/qr2xJJHWnYBJPO1tl0S5UJ5dJYHU4icU1NissGW2DtWbp/1yTgFbsJUm6ftwlVAxHa8NyN7EhRqd6vep9dFqnWcnbCfz5+Sf2bs68MOVrYVNj/VpYJn+AIwTADtGi9G30+Mesxa49VFyxJUJNNPchF5pSRotcMxS6UR8+A+vW5SkQFf3PkytO3JHl0ACJsQ9DE9QTyto4LZj7OEOytYs7CZa5Ou/Z5RnE5Cp8ByNSkeCTR0A9tD1SCE1nVZqOfZHz7qUZjotnW/LdagjmYHyjt1tpEdWPCQb1nbZKHmgYxhsPvJC7mAp7hKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL8LbtMcSPWQ6DR+lUxl8C4vNkEuWs+nErIvEABS59M=;
 b=V4tGGJVI174dX2bkPDNbo6HlMQGRanGoSp3+amTuFEqGsECFCz4X00zOvuaJuyUYta5Mzwtc9VsXJrxctPtVl9V8wq7RdzaRgoFSbI26/3E+tP5/sT7SCGEmpV+nCn0oigSnKY55fiIUIChhKFwSv7QqMyeo784IeA1HDF1DeGRv3R2jr5yGqvSkizaL/vLFMKbSwjuzxF/iMku0LUbdbFHaXLi+GlKRnKdgst36/TU3vE8WeLsMROUsVyY47sFoWJObED+wg4TvuN2HyD3PQJlVjn4XnZO0FxhbIg1dVR/1qvnz1D2u38hMosgFSrugKnYgym8uxnDHc6KUiMinAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL8LbtMcSPWQ6DR+lUxl8C4vNkEuWs+nErIvEABS59M=;
 b=rJB/OdKJKHuQ7QNwV8ptc2LfP/E36CxQxtsBUkwcWAdafM0TvswiCrnCmmf8Qo9q3iDMBjUEqmID0YDMQUj7NhCummzBa+kG5Z42w7ipksFPuGSqjDKnakUKXcWxoEpUcz10OHMw8msoW7rkfpxA83qYyBn7ddEF+s13ZZ9KUBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 16:46:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:46:10 +0000
Message-ID: <fb7aa349-5cc2-a854-63be-261448c1ee83@amd.com>
Date: Mon, 7 Aug 2023 22:15:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 15/16] iommu/amd: Initialize iommu_device->max_pasids
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-16-vasant.hegde@amd.com> <ZMz5zVbcEVX6Rrj2@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMz5zVbcEVX6Rrj2@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 592a2bfe-e5c3-4c57-0502-08db9765cd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H7wqmx3tUuvgLKDVOCZPEGuSJLKdIHl01hzwl9LNHLMIICCg+vTsimkUNf/YmK+IO4rWHwv5U08xYm71PaFTJUsTpKgVAtTY53S0HovyKNHLdeuRYfjCM+TlCd2qDtBNzeq88IdyR9xDP/OYnYC8T4h6vFuZN6/Z5r0GuMbSN5VL+D3bMK7iP5xIc4z0VrG/hm+cQ4ORlLL1dIG2HPmOi70J/CChUPyubGx8qu03+ev65a7uafqr/tPYyXn73KFRRRH55jv7yQsSHrqXbu1QknDhEECYOqHFSPh3Uo78LfXu/nB5ihieTi5RtD+d5GPbjdRB71cK6abDEwbPmH8DFMCvsvOKtSyGBlWqHR3xE0m6VHEzB2LIAZH8FouBICJ+kZ2mkvDY89wPHmujawvKrya3IdBuhrd7LMKwz5uXCKNZw1CQ6yj9Qy94kMoz3fnlOJdaSC49bj9yoyk02MG8KlaW/xZ/DUM0uqz9AI7uhGnD7ZCVC1MMDWTSSOTTdYhRczUlaOhnmQStbBp2Foi/Mq7cuk739Z6mzAh7kZ0gpcHH/WosO3jInPMh+psGMQKL9zMfLgtIXD0mlITKh/x4A/kLehFEI/MNMvAfFWIq4kwuPPCalVI5ayqnnRxCKx+GGv8BRMwNKO9C1fy1iczoOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(6916009)(86362001)(38100700002)(66946007)(6666004)(478600001)(66556008)(66476007)(6486002)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(8936002)(2906002)(83380400001)(5660300002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkdJTTV0TkRhbDNwckM0aXFyRDYxbEE2a2Z6dS9Ubm1oRDJWM1ZwZUdRcDBX?=
 =?utf-8?B?WXZ4UmNNVGt2RGlEVFJBUEJXWm9EL0dNci9Ob0gyeWNmU09scFB2NkUzbFFD?=
 =?utf-8?B?enhSK1ZhNU13dWE2c1hLdFFnK3VDNnV1WXBtcldMYlFKeHdwYUh5dVVkMnh3?=
 =?utf-8?B?NHVxTGVzcWp4SVNkNUtySi9MK3NvVGdSVCt3QnViUGpkTWtjNUxMUENhMy9Z?=
 =?utf-8?B?c3Z6U1FjRUJRUFdpMmYxK0Vnd0xmeGJaQ2FnaHhWcGcwc1I2T2duUkNNdDBS?=
 =?utf-8?B?MjZndzJsYlIrS1FJYnNCdC9CTjl0S3VDeXBmZ3cvS3h5SGVkem5tMGhWKzFY?=
 =?utf-8?B?T2JwamRPcE5qd042QVZsNlVRWDFLK1hmbmNoMTRTTkFEeXkvSHNhNXFJUmhs?=
 =?utf-8?B?cGVMV3hBd2p2Sko5U1hNTVppNis1c1I0Uy9RYlRpb1ozaUNVdEhZNjVITm5K?=
 =?utf-8?B?VStac21SUWFmdXhKUjgvdEhqT3hqTFRlTmZTNm01dnFpaVlBNG1PUHF5UjdU?=
 =?utf-8?B?aXF0czZPNEh1ZjVMOWpjRDR5QTk0VUtGSU5pN2VabmVOSG5WMTNTUWVGYkpV?=
 =?utf-8?B?RUh0ajNhOGJZa2N2STRYT3V5UzhBamRPaktOWmcwUDlBeEhqa3Y2UkVpcm40?=
 =?utf-8?B?RWlWaGk5TVF4ZHBnYUZjVTFyMnhvYnZVaHFsd3lpMjRXbXZPdE1rRDR5TDFZ?=
 =?utf-8?B?V0lOS3UrYzRJQjR0OStqV2dyM3JJL2VRWExjTWZGamxNM2czTFpyOWFYVUhQ?=
 =?utf-8?B?bnhvRnUrMUg1MGxPM2psZXhOV2poTUtJeG5mdWdqWUVlRUJYOXlyTVVUTTFM?=
 =?utf-8?B?S0Uybk55Nlc4V3BpUFhhdVBTekdhcTVGUHg1NlFxalNWK3lQc2pOTStkWUFM?=
 =?utf-8?B?TkFvdzkwaUo3bStKZ2Z5N1RvMnppTW1Pam4zamRGeE5QUzFzWURIOFp0ek5v?=
 =?utf-8?B?ZW5RWWZTcUo3YW4vcDdibG9TUUtBVVVhOG11eDZVVjJBSzlZWGdvaEsra1Yr?=
 =?utf-8?B?QlRZZnFaMElIN3pMQ1A5K3paMzBzUDVaMlFySjJ6ejVBNHUrMGsvSlJtVGNP?=
 =?utf-8?B?Tm9HMXB2MmE1d0RPeEhDV1hBZjdFUUZNZHhyZkcvZHlpZVJQV3Zvd3hmZUxD?=
 =?utf-8?B?S0pMRFJkRllOMkR2MnJzUHQxS0lGVXlWQnRTaXJCUVFsNUZwcnNxOWtxMVRX?=
 =?utf-8?B?Tm5lVVVjVXRkeUQrZVlIUjZDbnJrZzN5UjYrdW9UM2NHTUZuNnRzbExiWlFy?=
 =?utf-8?B?SnFrcFVmaTNUR3haQXZ4WUFyUVZSSUs4OEMyVEJrTmZiMFVwRVcrcGc4SWsx?=
 =?utf-8?B?cnhOT0t1UmIxb2FIK3VVRmhaeUpoMXpVdGtjaW9Da1h3cDRQOVJNTllTQk5h?=
 =?utf-8?B?M1RNZWFDcHVnVlVjOXI0akhMN2o0aExwUHhhb3NiTjRGdHYrNVNNSzYreVBL?=
 =?utf-8?B?ZzhaTUJrM2l1ZlRKR1hOT2RIVm4ydDJ4UDJDUU92VVlReEhHQnYrSkVoVktz?=
 =?utf-8?B?NlpXNVpGR096aGdKMUh3M2xrc005M2xobkhhSktsRUwwV2RJek1hcHBtUGVz?=
 =?utf-8?B?WHFtTTkyRUtPbUcvd3ZmMm9jNUc0M2dxZVZRVlgxY2p5eWEvMkFHVkdObC9l?=
 =?utf-8?B?VXdyQlRObUlYRFRrQ0lCdFZVZGpGQU9pRjdpbGxXSXdtSFFKTjIxRWJ2RzFm?=
 =?utf-8?B?RGtKOG5QMnlZMTRJUHB4UUlxUlliT00zcGhLTm5tWmZGTlcxZmpnREgxZ1ZV?=
 =?utf-8?B?eWxoR3YrdGdOdDdqR3l4TVBrVFd0ZW4yY21Zck5zY3ZNR2VBT1BROTc0bk5t?=
 =?utf-8?B?YzNJQjJDVjhyK25RREx1bjA0eGJLQmNtUUJJeXRtK1AwT2ZKdW1MVVBDOGlZ?=
 =?utf-8?B?UWt1OTNwNXNPTHJaR0prYUZXRWxab1BjOFc3d0h0WjVBT25tdnJSM1diSy9v?=
 =?utf-8?B?N0c3eU1vZkd3aEZhYlR0eVRtZUFZaGxHRjRiUGhkVXpMMExqV1dmbE1vZjEv?=
 =?utf-8?B?Y1VKTjRvSit5WHBWQTNqbzdJa2NuYVZpQ1FRRkc4UkluNlBnQjVOS3Y4NWpk?=
 =?utf-8?B?Q2gwclVJejdjaGRMTml3dVo2R3p2b1l2bVkxU05FSU4rM2cwRkg5ZmNWQTdS?=
 =?utf-8?Q?7bfL8EN3qvD+/TIEH3fsX+SOW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592a2bfe-e5c3-4c57-0502-08db9765cd61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:46:09.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIebPLY92oJxTdW99krgbMdonb7+tfuq+nXjNC1Q2Iwd7lLD0kF6NtQK/O17J6r+1qyuDzsSuPQhCRavt/aaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

Hi Jason,


On 8/4/2023 6:44 PM, Jason Gunthorpe wrote:
> On Fri, Aug 04, 2023 at 06:42:15AM +0000, Vasant Hegde wrote:
>> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
>> introduced a variable struct iommu_device.max_pasids to track max
>> PASIDS supported by each IOMMU.
>>
>> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
>> to set max PASIDs per device (see __iommu_probe_device()).
>>
>> Also remove unused global 'amd_iommu_max_pasid' variable.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h | 3 ---
>>  drivers/iommu/amd/init.c            | 9 ++-------
>>  2 files changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index e114e4af0f05..0d339e022572 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -895,9 +895,6 @@ extern unsigned amd_iommu_aperture_order;
>>  /* allocation bitmap for domain ids */
>>  extern unsigned long *amd_iommu_pd_alloc_bitmap;
>>  
>> -/* Smallest max PASID supported by any IOMMU in the system */
>> -extern u32 amd_iommu_max_pasid;
>> -
>>  extern bool amd_iommu_force_isolation;
>>  
>>  /* Max levels of glxval supported */
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 1f56478ae74e..e0b0e48d3d38 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -185,8 +185,6 @@ static int amd_iommus_present;
>>  bool amd_iommu_np_cache __read_mostly;
>>  bool amd_iommu_iotlb_sup __read_mostly = true;
>>  
>> -u32 amd_iommu_max_pasid __read_mostly = ~0;
>> -
>>  static bool amd_iommu_pc_present __read_mostly;
>>  bool amdr_ivrs_remap_support __read_mostly;
>>  
>> @@ -2086,16 +2084,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>>  
>>  	if (iommu_feature(iommu, FEATURE_GT)) {
>>  		int glxval;
>> -		u32 max_pasid;
>>  		u64 pasmax;
>>  
>>  		pasmax = iommu->features & FEATURE_PASID_MASK;
>>  		pasmax >>= FEATURE_PASID_SHIFT;
>> -		max_pasid  = (1 << (pasmax + 1)) - 1;
>> -
>> -		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
>> +		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
>>  
>> -		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
>> +		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
> 
> You said you'd fix this to remove the BUG_ON.
> 

Sorry. Missed to update patch comment section before sending.

For now we are just fixing the max_pasids support. Even current generations
supports upto 16bit PASIDs only.

We will consider removing BUG_ON later.

-Vasant
