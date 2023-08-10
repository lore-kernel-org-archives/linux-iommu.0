Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49323BCE
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 20:31:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzwI5n5RJHo5MgpP7V5WXRMJDSHbPpKdaLuYSR/4OjkszmScp1DG4U4BXuk0VutpxdPWGyeDj9s9WQHkYmOqdt1b5huzsyOn/Z4mQ55FNtzDwmQzMSElx4yaTIPAF9PPeDz0arLGwY3WPH+MujXj2HLylhTlyH9XonDrX5CTFFWHxACXrVBw2b9SFsYe8UjThICywxP784bsu/jAPki4DJucreFCQIpkYSz5YwdiLLLMa6z8WvGjzb4yDqFh0frmc519d28wqkU6E8WXya9JUzRXi60E1Tev6doDrkxrArhjg4LWjPqWpdY0FeVFlrv7KFt3xOxePcrpDRvTBo69jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhUSHYs7M4qpwxqCakCaKKjxSxcrEYrMJs7QFL1S/zg=;
 b=N5gciL8HYDhjQSalXv2QbyfsZ0QuAKMl6AyBcFSJuV5PzcNH7fwF0HwwkH9ZBiJcGLsSJK07d0jRpWgwaL3mD4efXoZ6D+DtTGTc5ljpNqWPkNfRSqvkXPjREvxLMw28oGnYwqfeP9x3z2KlxnM2hinBSFLls4Wx4OxIUvuzzD4qzCmsrtliodsJWJg0+/MAS9JGfVt5Jic+DVhThMXGvtT6md5vqR4B5o4iF+bxwlcNCA3l289FcvPFuXY5jvXWVSSt+R657BZ2E6l8p2sJoOcLVtUeuQ6NCy4l588BkIz/C93NA+wdw2xpveFaDF2jq+TlUePHfMhzlVaVz17udQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhUSHYs7M4qpwxqCakCaKKjxSxcrEYrMJs7QFL1S/zg=;
 b=qCL9wTwB4v/uxIj1djM7q2CIyPsiCyqxQUuhkx9ku1isRWFPyQS8Qi/MFMhHWjvg8qajkCyEAgM3tyNjY6hJiHYwznHAN3yTLpLzGYBTTVUC5SZNHJPIkEjobw65UyqtNjtWqWh1qzRDS4b8G1Z4ASQwCTOJL9OG7hAgbI1i2qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 20:31:44 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 20:31:44 +0000
Message-ID: <b11dcd0d-f24c-c940-ce10-a5eba650b27c@amd.com>
Date: Thu, 10 Aug 2023 13:31:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, wei.huang2@amd.com,
 jsnitsel@redhat.com
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-11-vasant.hegde@amd.com> <ZMz66cV24yQV9Byn@ziepe.ca>
 <14ad5515-e320-198f-8e94-1a83678a51b1@amd.com> <ZNJJTzuCyKXQojfe@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNJJTzuCyKXQojfe@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e90f8c5-a64c-4515-1594-08db99e0cfc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ChAzQxYwFXLrHES0nC+96LCOz4DMLEITZ8N24fX18lgmz+jj7j5Lg5z8aTvQziUCe/mXpPZwugjUCExaDUGPyQywwskVojxYrfWeuuzpslLGXu9SdK6u5lRVBSKQvkrd1OA2mBtB/eVJXMHCR1zfxOICdr+pAHZnfM5+CvD3s6Vleg0C0kc4NXSkvCHrR7bjTV26zQqLv9jrV257avjHtfhQEz3Y5KLlsDnoy1Q5M/WQXnQNn34534SdqkHDfAnezCmlKOY9d9RmSnyrqxQwLlX6+OiO/1Cr/ppaNUEZIStBF4BiLf1O20AvCOyKTOxwtFWJXznBpPjxtTCvlkr3yR33vsYtPkgT+G6Ij9nD8fBKzoeMERngH9wxQQXWdqNwWgGCvDtK8LzKK9Dt2rEDojHn84z3SynPJQXk57HtoGnA6/WQjdGTxiWs6ATmINjNj8/LJD05u2VOmiprvz5SStd2kq0jznKQkYdzmdeduHzlWMGPfMgMn8RYmMRIfwlk7rwaT/+AKUsvMsGgtRRru5fTOYAP93cOde+NJycwrUdzLYaq4nZmZBU/ALyax7t2pnmtTZDvzfGT3hPYZ22oGkENdL+0Owwg8ntpcJm4GyMD1VOVAkoPWdwlNAzgLyuZ75V3XfehTQ/8O+xViXW6LA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(186006)(1800799006)(26005)(6506007)(8676002)(8936002)(53546011)(41300700001)(36756003)(83380400001)(2906002)(2616005)(38100700002)(86362001)(31696002)(6636002)(66476007)(66946007)(66556008)(478600001)(6512007)(4326008)(110136005)(31686004)(6486002)(5660300002)(6666004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anRFK0c5NGcwRGx6ZVdJcTZvSCtEcnJFemNRaWFRREszejV1NUcrbFBhR0Jy?=
 =?utf-8?B?MmNSMVhmL2t5Q0xRbm1ZcUpibkRncVhFN0Q3NGJVV3hrODB5TU1vUXJSMDNy?=
 =?utf-8?B?YW5pT20zQmQ4Y01WTStLdTE4MCt6WlNWSjhvU1Y5ZVlRbUhLL1pURVJhMUdr?=
 =?utf-8?B?L21rQlNwT1lZc0FQL29UckFwZXJCc1pTQ0lJLy9KL1ZDcEZiSkMxNWo1RHBX?=
 =?utf-8?B?MWQ4RHQ2WW91REk3SVdvUGtaOU1qYnl0WWhvRlNyZTJoYjRXbGVPVytmaEVT?=
 =?utf-8?B?bU5yZmo3bXJGZ1ZPT292eGlUdFVNTUp1SXUwK3E4RlBPNWtRMzNpcjVsOEhq?=
 =?utf-8?B?aFdySmVTd0xTU0lKWWxhbE9PVEZpOFFwWWMySVFUVXpoMjh2L2JFYkpsenZL?=
 =?utf-8?B?cmg1S1VFemdaNWpWVEx5bldUNlJUZHhxUkQxTWNFTTd3SERFK3JXc25icG5w?=
 =?utf-8?B?QXg4M3JUR2xZU3dmNWM4Uk81YnZqS3EycFoxTkhDN01CcUw3eW1HeEJhOTNu?=
 =?utf-8?B?R21SdWZML2ZRdWhxRXZVTGJ1R3NGZmJ2OVpEa1VZakhHVS9OdjRIK20rdGdj?=
 =?utf-8?B?aEJHVGowNXE1SXJYTzZBczVjRXJYelJSend2SXdqclNvYTg0elZiQlpJSi9j?=
 =?utf-8?B?eDNTOUNRMllHZHI2M0pqOHEyQjl0Qk9Qbk8zZllwMlpDYW1tMW5WNEcrMERY?=
 =?utf-8?B?eW12cVpTc3cxNEhQYURGQ3BhbzIrMUhocVVPWUw3ZzlrTzJWc2FaZ2JTWGRs?=
 =?utf-8?B?N2hPdDV5alM5bVJKS3JlY1owQ0k3eGN0aDlWN0U5OGd4TzZ1OUtXRkhGRHh6?=
 =?utf-8?B?TE9EcnBoNVZlay9ZTkRLVDVpK1NCbGNvMjhWd1B1SmYzQ3hueVZIT0tBMS9F?=
 =?utf-8?B?aWppeFF5bGJkL1Z1TDB3OE5saFFNdVJzWWZDVzliNm9FcGNXZytpSEthUEpG?=
 =?utf-8?B?ZmZFVG9NSVVVcHpQbTVocS83YzdCSU4reXgxQ1huVHBRSWVnZGZnMXFtVlFC?=
 =?utf-8?B?UmZWWEw2WjExWHBFdzZabitzbERKT1JUM1lZQ1RwT0lta253TWwreW51enBR?=
 =?utf-8?B?bEdtZEdQWkNQdnlyUFQzeFpiUGpTckRUN05ZZyt5MVh0RS9DNy9WazUxVUQ4?=
 =?utf-8?B?NFRyczhHQmFnaURzOTh0ZUNRbGlQbzFqUm15b29YZ21pa29yZXpBNm52T3JB?=
 =?utf-8?B?ZWJHN2xVOGptaFYweHBoOGhjdXYvQ01qOHZuem1MZmhnYlZkbkxUc1lobTVR?=
 =?utf-8?B?NXp2U2pSMGR6TlBWY2UxdTNYdDFxMU56Sng4SDEyaFFmc2ZRangxSG9FRTF2?=
 =?utf-8?B?aVZYNmsrcTRRNnQ2MGdkVkJrQmp5MVZnNEtFSy9PUW5tT0FFUTJmZEpOaWRX?=
 =?utf-8?B?bDVtaEh3T1dFWStnSnYySTJoSlYzL0FwMXV0U0F2cmo5cTZSOWpnYi9ORnBR?=
 =?utf-8?B?NWRHNStabCtEQld6aTZualVtbE4vUUYrQnhLdU11UEh1M1RKOHRsTUNhdkFp?=
 =?utf-8?B?enppem5YbmV5Y3pZaHRIdDBEdUN6MDNJWVpuWGEzRXZDcjJKV1Y1aUVERVp4?=
 =?utf-8?B?TzRUMThoNzgzSU55b0ZSamc2VW1JQ3IzYXdBdEcveWdlaUJvOEhUOGYycCt0?=
 =?utf-8?B?cytyUEdzRG1iazE3aFhzODNpOWJad0UyUnB5UjR0SnltdXRSMzQ1MzR0Zzcz?=
 =?utf-8?B?NmtUYmF5VU11emx5Zk5vNks5aU5uNmVLNkZETG9WUGpiTmRKc24xK3ozMUpB?=
 =?utf-8?B?Wnd4djk1bmdCcFpxKzJVZXB5VTV6dnRGZUZIRUZpbXNDWExSdkVJWWZBOFZD?=
 =?utf-8?B?cVFVRTcycmlxYk5QaUhVOTFuR1hzYUxkL21QWDh0YjRGNis4ZWJUMDVFc2xQ?=
 =?utf-8?B?WnN5Mm1Ha3hnbm1lQ2UvK2FaV3grMXRYS0pwalhJd1NEcTF2NkhQcm9vWHlZ?=
 =?utf-8?B?UXF4SHcvWmI3eXpBZ2NIYkxJOXRHT0NXM2hHR2k5N2NVV1dCYUN4TkZ3OHpI?=
 =?utf-8?B?Sktzelo3NFV1d3psbFNjUGN1WXhUSitzdGthVUU0SkhONk1yeWt6Z0hXY0NT?=
 =?utf-8?B?amZKQ1FoNVZtWXU5QkZMa0tEbk9menN6MVQ3RkJ4UXhNNnRPRWxKYVgxRGRK?=
 =?utf-8?Q?7y9lGwngh2GF5N8RiHcHcWj1K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e90f8c5-a64c-4515-1594-08db99e0cfc5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 20:31:44.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TOWYnG/J0lwPpAqwzMVKSm/WRi+Dgw0Fxdul3vki+rmBuFOiY8Wd/foOZ8aEfcHShYHg2VoYhKWvFB5Lq1+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

Jason,

On 8/8/2023 6:55 AM, Jason Gunthorpe wrote:
> On Mon, Aug 07, 2023 at 10:14:23PM +0530, Vasant Hegde wrote:
>> Hi Jason,
>>
>>
>> On 8/4/2023 6:49 PM, Jason Gunthorpe wrote:
>>> On Fri, Aug 04, 2023 at 06:42:10AM +0000, Vasant Hegde wrote:
>>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>>
>>>> In order to support v2 page table, IOMMU driver need to check if the
>>>> hardware can support Guest Translation (GT) and Peripheral Page Requet
>>>> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
>>>> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
>>>> features. There variables area redundant since we could simply just check
>>>> the global EFR mask.
>>>>
>>>> Therefore, replace it with a helper function with appropriate name.
>>>>
>>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> ---
>>>>   drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
>>>>   drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
>>>>   drivers/iommu/amd/init.c            | 14 +-------------
>>>>   drivers/iommu/amd/iommu.c           |  2 +-
>>>>   4 files changed, 17 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>>>> index a5a350ee36fe..0605f02fa711 100644
>>>> --- a/drivers/iommu/amd/amd_iommu.h
>>>> +++ b/drivers/iommu/amd/amd_iommu.h
>>>> @@ -95,6 +95,17 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
>>>>   	return !!(iommu->features & mask);
>>>>   }
>>>>   
>>>> +static inline bool check_feature_on_all_iommus(u64 mask)
>>>> +{
>>>> +	return !!(amd_iommu_efr & mask);
>>>> +}
>>>> +
>>>> +static inline bool amd_iommu_gt_ppr_supported(void)
>>>> +{
>>>> +	return (check_feature_on_all_iommus(FEATURE_GT) &&
>>>> +		check_feature_on_all_iommus(FEATURE_PPR));
>>>> +}
>>>> +
>>>
>>> I'm still against adding more globals, the iommu struct was available,
>>> just use it directly in this patch.
>>
>> Sorry. I missed to append the reason after re-generating patch series.
>>
>> We want to make sure features supported by all IOMMUs are consistent.
>> Hence we introduced this function. This function will be used in
>> subsequent series (ex:  before enabling IOMMU PPR feature, etc).
> 
> That isn't really the right direction. iommus are per-instance things,
> each instance should attend to its own stuff. Globals should be avoided.
> 
>> Also there are features like SNP which has requirement that all
>> IOMMUs supports features before enabling it. So moving all checks to
>> check_feature_on_all_iommu() makes it easy.
> 
> It is confusing why this would be necessary, but even if it is, it
> should be limitd to SNP with a big comment explaining why SNP is
> broken.
> 
> Jason

Actually, it is not just for the SNP.

Please let me further clarify the existence of the global amd_iommu_efr 
and amd_iommu_efr2 variables.

EFR and EFR2 are provided in two places:
  1. The IVHD block in the ACPI IVRS table.
  2. The register offset 0030h (EFR) and 01A0h (EFR2).
where information in the IVHD block supersedes the MMIO registers.

The EFR/EFR2 information is needed early in the initialization process 
prior to amd_iomu_init_pci() (where we can start accessing the MMIO 
registers). So, current code ignore information in the MMIO registers 
(only check and warn in case of the IVHD and MMIO are mismatch).

Currently, IOMMU driver assumes capabilities on all IOMMU instances to 
be homogeneous. Therefore, during early_amd_iommu_init(), the driver 
probes all IVHD blocks and do sanity check to make sure that only 
features common among all IOMMU instances are supported. This is tracked 
in the global amd_iommu_efr / amd_iommu_efr2.

Therefore, the helper function check_feature_on_all_iommus() uses the 
effective amd_iommu_efr/amd_iommu_efr2 instead of iommu->features. In 
facts, we should remove the code which directly uses the 
iommu->features, iommu->features2, and the iommu_feature() helper 
function to simply and make the code less confusing.

We can do this in subsequent patch separately.

Thanks,
Suravee
