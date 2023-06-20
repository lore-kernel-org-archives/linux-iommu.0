Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB4101F3
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 16:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLDM6aJxGDSxUR/0zO7Oud9rjH5ARAySxUmRDvytp2bVx8SBTIFKTt7EyWG6s5sC7m3UEKzd/VwA3Ns4dirYxaVTJw/5maGhgFZ940FagI5uQsZ0oTE6WMDD1u/8oRebe614EphJtJ/RPK7oU/2oafkClooCz2k5/0OUqjDiff2roJmdgNI5yjBjE7gavx3i8Xwil5QOVG1nRxntqeBhy7XtNyYHyoXZm+3gpr+xU4gwwWzYTcMWS7vt3CaEQyWpYgIUuOxdn3Bh0hSEXIyifN11umYrC8dVbSpLtuuraI5rfN5AUS53gpBdplKYr8iHVv78KiQc+t2ZnwtL+cYSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGxops5efq0cdHicqnnLqBDXPGEfn/YCkY1EfL3h2Ls=;
 b=Ah3DvbiKchV4xNfrDQ8WE7dpRXnGtzonqpUX8r3OyZ/+VtdeYKgmcqPS971oVe+xltUoEsho9Bn5n466WbFFQQW8dFu+FJ1kAGyayKcfSLCShCrGLas50v/8tSaCqKIKNRE7stchr8dqrsFMLJ8ZCWefora2Hr42aieboHB+4FuPol/nN8zMzW1rDkhP1GJ30KpBwaxh6TVsbqo1V6ZxUs/EyJy4iutC8U7qjwrygx5vP/GkhxudLfgKxHcmOVWhO9M9cFNsnAIX0aZDNRsQwM0Q6ahb6uqHS33gdmOJbEWYmpnQIlDWORJyOiN7rDBkCewuhLR/D0xKjDTQFU+gBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGxops5efq0cdHicqnnLqBDXPGEfn/YCkY1EfL3h2Ls=;
 b=ql6DFOJxTHsDr8tdhoc7pJsuAox6ZAsFCMU5AwPMcHJ7dQYZdROIY7WnH4c4vGS1ohWnpPFesv4Z43I1JNbujWjCKCsXhfWGPCRbJGzhKg9KEsEKjqrh9gT4kQbyHy9z+GUyBGohOUOJM3byqSZCnfV575nWTNtexUc9S60EgsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 16:01:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:01:36 +0000
Message-ID: <878cba34-f2ee-49ba-0f4e-588704871430@amd.com>
Date: Tue, 20 Jun 2023 21:31:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] iommu/amd: Generalize log overflow handling
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, joro@8bytes.org
References: <20230609101746.6412-1-vasant.hegde@amd.com>
 <20230609101746.6412-2-vasant.hegde@amd.com>
 <f0b4d748-9c13-7214-e578-a9cb27ba6e4c@oracle.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <f0b4d748-9c13-7214-e578-a9cb27ba6e4c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::21) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cf1492-e81d-4169-ef85-08db71a79fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nCbPLjWpFcpsJwtvcHNBk3Tla2EiaRhASRP1ww9xqIaSfvACjvnK3+3bz6VmGQZhV1kU+TAkf42KywtVQcD+3oyhXqxLgisokOWk8vRNlrVBt722p4swVjByG355OD1Li7frb6Je4hY1sWB4KxdgfYrnYBhU6mbP2qvLtcTZTKA4tij0WVT9+x7qxZdv3Ovb75DQdNSd8+TPu8FXKkbH6+Csf3dZfttuKg9y3qlrL4WcrjuBrk328B5sEbrpDrioM+K8RTB/1UzcswgYQAY/vvFrcFfXehfXYg9Fjo3fNeRNgJ3HuzgCZ9fGIAlTpvrVFlGAr4C7NXaxtligAKAMnfd/U9iJNzie/i9f5NaMbbhLMO8DUI5RU9IJ4Wc4yW21yHOoYQphimd3BC9TVmTuXs0sLV58Jr/UiKrZpu2LE2pwZt4l+mG1f1hPn81yATZmICz3Ec14fe7EA/sFsPcgPAAdezmlz5IflVY6LPkML0gWDNOMjQQ4a6xEhJAbZPDHyRJQY085OVkwjt5BnBHWA37ufqAoWwVBurP0ra9ujbKbZnVhLJZy9MrU98ZKsaU6Tp8domH++ZIzCpEu16OVpEmNjLf7EExbv6f3RIb7DAxSPUzEt0jwaY1n9QKYmwTW68tPn0lim06M+ljg14eufg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(966005)(6486002)(6666004)(478600001)(83380400001)(186003)(6512007)(6506007)(53546011)(2616005)(26005)(36756003)(38100700002)(86362001)(31696002)(66556008)(66476007)(66946007)(4326008)(6916009)(316002)(41300700001)(44832011)(2906002)(5660300002)(31686004)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2xlcFptMXdCVS94U09EL0VjZkxQM00xSEsvS04zZWphQTRUYlZId3kyWEJ2?=
 =?utf-8?B?TnE3b0ZyNFN4Tmoxb3doc0NNejNuamxKQnA0aHYrN3dyQlR3VVpNSkp2Z1JT?=
 =?utf-8?B?RnphSHdveDI0ajF3cWgvWUUyRmtvenpMdVU1UnMxR2daQkxmMEYxRlhlN3hv?=
 =?utf-8?B?Qnoxdi9sUis0VEV4UnRHNlpLU2wvWUMzU1AvNHMzOWduSGVEcE9FY1FySWNV?=
 =?utf-8?B?SFRHajk2QWFpUmRJMkwzUS9ucTNpV2dqc3BqL2o4cDdOdFRLaGwxMFF6b2FN?=
 =?utf-8?B?Y29MdHpxK3pDK2gwQUJtalpPTmNGNEptSUoxV2h2V2dCalBDV1l0VFZnYWlZ?=
 =?utf-8?B?MURJSmE2QjluTVdyY1FPUlJlK1QvQWU3NlBTS3V6aDNObzRtcVRTWC8rR0Vn?=
 =?utf-8?B?aFRwd3g4ei9HRzhQeU5wdWk1OCs1Rlo0azY1c3JaczZUSUJzdnpqdnFBbzlM?=
 =?utf-8?B?Qm5wQjlkT1A5L2t1RTZWcEFvOC9UTVB3bHpzMHFaZTZwVUh4SlNCa3ZGSFpO?=
 =?utf-8?B?ekgwMmNTeGtnVHhVcnRoMjk1TGkzLzFTcDFvUlcrakErZExJdEwzWHcyeVJw?=
 =?utf-8?B?SGpGaWtCc1VxZnNDSnNUY3BLVm8rT0ZlQ1N6bm9ZOHgvS3ZmTGJKczZWdGl6?=
 =?utf-8?B?YUNBQjlJRjlHdFAvTGZ4VkhjSFVtQUpkUHR1Zk9wZWFyM0RjMDVXeFJDMlFo?=
 =?utf-8?B?NkN3M1BnYmxYejQzYzNPaE10ajZpckQ0SmZwODhLai9yaE1mWWxRMnp6L2tC?=
 =?utf-8?B?R3loMXRGV0dRQUNPaER3UTJsc25IdCtvcXlqeXV2QWRnR2tUaWtQSTZqcXdS?=
 =?utf-8?B?YjlGM2RSRldSWGc4bm1tRnBlR29kMmNPQzA0Y1p6ei9pQW9ZeXR6R095UUNk?=
 =?utf-8?B?NE1HaEQrdTJGSWhvS0JVN0R2RDVaNTJrdE5UM1c1WTJ0RHRuekpLNTBzdDI2?=
 =?utf-8?B?NUF1RE94eU1YVWM5eVVZQXNBUWwxczR3ekhUOTVSdXg3VGhVSlFzRnRTL3lG?=
 =?utf-8?B?RjJsZlB1L0dGcXJBcGUzcGJ2cnVFNGpMWS9HS1pKZld5RXZnYzVkLzZPWThl?=
 =?utf-8?B?cjRwZkdQR3dUSEJBUzJyTTg5WGJCK2NuSFRma0oyWnVVd0FQa1g5V1MxdmFh?=
 =?utf-8?B?NGYyQ1lmK0hiaGE3RzZ6eVhKbmNPd1h2S2hGMHFLU0ZiMlNDMjZoNjB3NVVD?=
 =?utf-8?B?NTg5Ry93WkhDQ3BZKy9rZ3dCVElQS3ZUSDZHOW1OMlhqSHVRdExWTzNTeDJu?=
 =?utf-8?B?NjQ1djR0TVNjWHV0Slg2Y2hTNHBndFJOU0kzVmdjcUV2QVI2Y0cvKzN0Y1RB?=
 =?utf-8?B?UlFOd1NKRENSeVFnc2N0MGczVmtiZ0RYeUx1b09GQklsb05aRHRHZi9YUEtZ?=
 =?utf-8?B?NjViTSt3eGlKZjM5Y0htdUk1WHBIYXA4OFdsLzFuQlRGczBiUzlNWnl4OGln?=
 =?utf-8?B?R1ZVc3VjVXZ0aWIvektpdlVoR2U0U0VBUkdSOFZwdjhJL01NTWxTTzgvSjli?=
 =?utf-8?B?WDZadWNtamNjQmJmMmRZSzUwdC9IRkxsVFppVlJXcyt5ZGs4eUd6K01QVy85?=
 =?utf-8?B?OFljKzZuY2hZNDVUbURoRUkxVURvQzdacDNCNGpSajZHRmpWNFd1Y2xWYmkz?=
 =?utf-8?B?UEJJZFBiZ1RMMUkrekk1RjRFS2pBSk1YWlJBRzdJVDQvRzFJR2F4TThwemcr?=
 =?utf-8?B?VXhLZEI0cVpPYnVzbi9VSld1NjRmMEpSRys0TzNYbU5lUVZzajR4SjVBT0Zh?=
 =?utf-8?B?MWE1Yk9ETTRNZnZvTk12SkxIeTJUU0Z0TDZwZGwvQ3djY1NOUHR3TXdhbzcr?=
 =?utf-8?B?ekk3SEJ2dzFicnJrNEF2WkpLUFZyN0gwdEU0L1h5QWc2aWtaT0VrZjlLSk9O?=
 =?utf-8?B?N0Q5OC81QVU0M1REb2pNNmJWNThoQnhEVGhkZmpjaCtldzhoRWlaVHJGNjRu?=
 =?utf-8?B?ZXU0Z1ZwTjZXK2d2dVZ2TmZpVDdhUnovY0ZnYkp5ZlZFUXpPb0pQN2hralA4?=
 =?utf-8?B?Ym4rRUIvczZHc2M0YnJXWWlHUGJWZUV0U2w2UW4rZlVDbERRVzQ0c3Z2ajBm?=
 =?utf-8?B?N2pUWFRueEZYNWZjNWN4ZDE4WjFueURVd09QS2lub2xJcWkxWElvaG4zRUVp?=
 =?utf-8?Q?+QrDmDA7gHWHjREtHTS7JSfji?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cf1492-e81d-4169-ef85-08db71a79fe3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:01:36.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SZl9K+eyMMBosGYULObZEVVn6See4IpbfEcSaW6HqTsS+KWleWr9z1b2Ud4dTl4Rx8yLbcyKJbAdp93QcMFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

Hi Joao,


On 6/20/2023 8:21 PM, Joao Martins wrote:
> 
> 
> On 09/06/2023 11:17, Vasant Hegde wrote:
>> IOMMU has three different logs (Event, GA and PPR log) and each uses
>> different buffer for logging. Once buffer becomes full IOMMU generates
>> overflow interrupt and we have to restart the logs. Log restart procedure
>> is same for all three logs except it uses different bits in 'MMIO Offset
>> 2020h IOMMU Status Register'. Hence lets move common code to generic
>> function and individual log overflow handler will call generic function
>> with appropriate parameters.
>>
>> Also rename MMIO_STATUS_EVT_OVERFLOW_INT_MASK as
>> MMIO_STATUS_EVT_OVERFLOW_MASK.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Really nice rework, fwiw:
> 
> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

I did post V2 version, but forgot to CC you. Sorry for that.
Can you please look into V2?

V2 ->
https://lore.kernel.org/linux-iommu/20230619132346.6021-1-vasant.hegde@amd.com/



> Just a though below (you don't need to address it, just an idea)
> 
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  3 +-
>>  drivers/iommu/amd/init.c            | 51 ++++++++++++++++++-----------
>>  drivers/iommu/amd/iommu.c           |  4 +--
>>  3 files changed, 36 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 364fdaa52e74..318b84cf47f6 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -120,9 +120,10 @@
>>  #define PASID_MASK		0x0000ffff
>>  
>>  /* MMIO status bits */
>> -#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	BIT(0)
>> +#define MMIO_STATUS_EVT_OVERFLOW_MASK		BIT(0)
>>  #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
>>  #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
>> +#define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
>>  #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
>>  #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
>>  #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index c2d80a4e5fb0..3c21e9333899 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -748,38 +748,51 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
>>  	return iommu->cmd_buf ? 0 : -ENOMEM;
>>  }
>>  
>> +/*
>> + * Interrupt handler has processed all pending events and adjusted head
>> + * and tail pointer. Reset overflow mask and restart logging again.
>> + */
>> +static void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
>> +				  u8 cntrl_intr, u8 cntrl_log,
>> +				  u32 status_run_mask, u32 status_overflow_mask)
>> +{
>> +	u32 status;
>> +
>> +	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>> +	if (status & status_run_mask)
>> +		return;
>> +
>> +	pr_info_ratelimited("IOMMU %s log restarting\n", evt_type);
>> +
>> +	iommu_feature_disable(iommu, cntrl_log);
>> +	iommu_feature_disable(iommu, cntrl_intr);
>> +
>> +	writel(status_overflow_mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>> +
>> +	iommu_feature_enable(iommu, cntrl_intr);
>> +	iommu_feature_enable(iommu, cntrl_log);
>> +}
>> +
>>  /*
>>   * This function restarts event logging in case the IOMMU experienced
>>   * an event log buffer overflow.
>>   */
>>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
>>  {
>> -	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
>> -	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
>> +	amd_iommu_restart_log(iommu, "Event", CONTROL_EVT_INT_EN,
>> +			      CONTROL_EVT_LOG_EN, MMIO_STATUS_EVT_RUN_MASK,
>> +			      MMIO_STATUS_EVT_OVERFLOW_MASK);
>>  }
>>  
> 
> If CONTROL_EVT_{INT,LOG} was instead EVT{INT,LOG} (like it's PPR and GA
> counterparts), I do wonder if a macro is better placed here considering that the
> only think that changes is the string name and whether it's EVT, PPR or GA is
> used. But perhaps that might be too obscure.

Sure. I am touching some of the init code in next series. I will try to fix it
as part of that.

-Vasant

