Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5216FC01
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 16:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAhIS9LaoHv27gsn5e2gjlF7I1tJSNANRojABSRo6ma1tonjfMRLM+avur3gqB2pkQe8BuaMUJ0i4YOc3KtEVCN9SjrdHMIDt9SMhMiA5LVys0UGPxeVNtFZXIdQ2nWq1cvKVsuKJTAR+mPbG0DBsu46v5MHzJJJWMSLdUFtJjOiwe+idOGamjtPC72dWYosaHZPcOKWmhbkxrzf65e24D5SPy4/ZmHAh/8q7kL+XRymF3sFSGNRk6RgD0dM59MTuWolaY0boh7XsBR46HWBna8OIy+DjyeFhxzPSi0DNu6yjDBzMlIaA2w5Lf98nCDTx9Uv5NGg9HkPdaDsKHKOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FZuEDDLDNRQDNE3ajqU5QnVIeZOP1YUy83R7waigGQ=;
 b=Ngko0V155vv7qTewgiJ+Eu6WRQlm2APSGCzX+oQI6zjDBdqTSE3+QiICYU1zQSmB7RSM6H1Rc77h+JMkTHCc5+zbfXfuZl9eCafvJBSM+hERTE0Oifb52EdXWxFBsaakBpzIB9a7vR7iu96usTlqGVjKeMUVCuV3DXRu/1/oEsKSUPpCaT81kF83i+6NzLupNsZaKvHyZCAUHEnWktz9xekjBgb/ScguKOTUs91cZWw6rr95V7Bks9bwlwCL9g6Evcex1/k2nBSN1Sw3a6+y6H/hUpyzvWEDItlK1q1Q9KNv9q6Da0Cn0QEmiwLxjMOx4jJt59Vg/lKf6jvapEf1yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FZuEDDLDNRQDNE3ajqU5QnVIeZOP1YUy83R7waigGQ=;
 b=t47orBfytoLgtK7pvdQXMUg1XzHYQFOaPDmFN6Dep8JzcUdk7DarvFrNRFRTsoMBZ4AWSGTfh3NL3sVv8evYA/Jl64utYRBIRvF6YbjUI0cJP7VMGWjHzawohDtIl1Rdb47zUOS34M/frO7nJ1vOqQwkBK7loLzFUjn/PxOSgvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Mon, 7 Aug 2023 16:44:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:44:37 +0000
Message-ID: <14ad5515-e320-198f-8e94-1a83678a51b1@amd.com>
Date: Mon, 7 Aug 2023 22:14:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-11-vasant.hegde@amd.com> <ZMz66cV24yQV9Byn@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMz66cV24yQV9Byn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH0PR12MB5107:EE_
X-MS-Office365-Filtering-Correlation-Id: bd58ce9a-e1ea-4803-fe0c-08db97659675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bk6QDLBfvl8YZ4O5KMLI510Kgn7K8I2aeFISkhGvlKU5xTMfK4QOcbyexULK820rdeaMYmlfZ/KzY1gBtq6rpKSs1OLj47wAD/q5l8rX5WebtgYM2RLSb4riMFPmIzgLkgTQYBTxpO3bIPxDQYG8Y2qhChVLX1lJzHSAJbDMpCLh8ibP6JdBBxXwiPzIN9pnOwGaUZp9w292D/ELNTrU3Jp9SRZtNAfynGhmE5AChDW7vx+lWHVl7jo3lhplFxzJkaeHL1MzkH2DgRuYK3RpCAiMMsrxxTvNchvp9yZ7znSlHJr0SsAL3HqVOnI6idul/rZdhS9mComZuRBO87mBzho/MBWf1aUOBrfx5F+qVCApnkoNohYK/Xe9iAolgXksAZmz+iKmrgKNs21KdzSOF4tmBFn00SbP+eWql+D9+oO5x0MMwPtlLeCpuXW6ai4fRK/GQatyJh2RqlKzmB+u17I1xf+FGzWzAedyue/GBdA8Y1AS6vXLSjC+JmSTcuS5e9L5mW3EZe0IBQmhf4tN53E8PgMckB3TvMX30bStez5DZVgruh1b92ReQtIafkDc+SvZKwCU08g33qqr1z0A++3NPqp+Em53hx4ajvy/YKP9qHBsvPqHW5C++KY6uUpP0iv8445D98jv5Zm/kbNLqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(41300700001)(26005)(2906002)(5660300002)(31686004)(44832011)(83380400001)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(31696002)(6506007)(53546011)(38100700002)(6486002)(66476007)(66556008)(478600001)(66946007)(6666004)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZBY2x5Q1dDWUxBWDRlU3JSUVlSbFAwMUZFa2NjL1ZLVU5GeGI0Vm1JanFM?=
 =?utf-8?B?VzBsVUVaWmg5VUJ1czJQekNnaUMxYmFYZzNqbXRZSEdTM1RJajBuWnA5WlB6?=
 =?utf-8?B?VlZTYzJ4K1B4L01JVUdJNnlHQ2lxTGxQd214WUtwaVc2emFQdThuVjF3Q3Nn?=
 =?utf-8?B?UVMrSWxTOTl1cXNNcExzNUt6QndHdHJmYXdPSGEySGY1SXlqdWozaER1TUtP?=
 =?utf-8?B?TENUTjliM0toNkNJSFRxZEJ4bjg4MGpLc1VSOE81UW82ZGFwSnF1SmNwVGJ3?=
 =?utf-8?B?UzR2MUo3VzcvWVpSR0h6cUx5SVhVM2dVZmNJMDk0ZXZXL1MxT3NNd08wdDFO?=
 =?utf-8?B?RjRPM1FIV1E2ZlNZS05vQlY4R21LMFYyNEk3bkxBUzZ6WXdncTR3TWsrSHVm?=
 =?utf-8?B?UHdoZWp4K3dNYlRjdnBUVmswREZta1RZUVJCN2hkMU5pNCtYV3Y1RTI1ODU2?=
 =?utf-8?B?blJaM1FialluS3Z0aUZNbG8vRHNIRTBNbEhSUzk4UkNRLys1TlVCWm1vVlF3?=
 =?utf-8?B?NUlqdGd6eFI2S1Z0aExDYXlwbm9NRG5hWWpFM1VwRTR3Z3dsY2VtNkZNQVdG?=
 =?utf-8?B?c1lzRmNML2VHRGlSbHcrNDBCNGt1dTg2aHo3KzM3MmJ4R1BwS3dSdytXMEo5?=
 =?utf-8?B?VnUxbkpTcUNoMU5wODJROHdVc3ZCNDIwQWpZZmR1UXdXZTRsUjBvbVBUZmZW?=
 =?utf-8?B?WTNJS3kvRnVwOUIxbzF3amhwa0lzZUtOY3ZUVnNnbTIyM043Q0V4Z01mUmxv?=
 =?utf-8?B?YjZQbW1iaEg1Y0x3b1N5ZHpqUExjanEwVldVbUxWMTZMdDA2T0E2eVp1N1Mv?=
 =?utf-8?B?M0JPSjN4Wnd0ZWlnWXVuazlNSTRrQVU5T3l1MlBWLzBaclBOWFRjQlV0d3dX?=
 =?utf-8?B?Mjl0YzFCeUxDbFprYURPeWNianViZ0VyVjR4ZFdXWDQ0Rlpuai9TTGVubVdX?=
 =?utf-8?B?VGxJNE9rU0JjczB2b243NERKT1Q4bExxaGxxcUJnNmpQYjE4YTVobXV6Z2hy?=
 =?utf-8?B?S0tqTVBjWmtTaE5yeExqZDZHT0xEODhHSDZhU3NPVnZaY1Z5bXRWdE1Td2lO?=
 =?utf-8?B?aDBqYk9JWVBiMFVwRzRmanJyTUtKRE5NUGJKdUpTSFR4eTYwNVVyZ2p2L2dn?=
 =?utf-8?B?TVk4UC9DUzFmVVNPMFhwUGc1RHFDc0ZsNTViclQ4TmFwSnBvTFlCVFVGUHNa?=
 =?utf-8?B?VGpoSWhmc2pPcUV0Ym9WNzVFNkhWalFqcUh2dEJ6Qkg3M3gweWVtSkJDUzNX?=
 =?utf-8?B?N2hvVTVCQzdOeTdJUGU2Zi9oeVUxMStYVkg2N3REaGh3eStDWXZrb24rSm1u?=
 =?utf-8?B?UTFaSWFIQzJoaDNTbEE3b3lrL2pQeU5pUk5yRTRMMWdaaXNSN0pWd2NIRFhn?=
 =?utf-8?B?ZXFKZGN6ZlRyU2lBRytSQmRmYmpuU3FSUUM2d2JiV0NRQm1SNnFpK2czWUtO?=
 =?utf-8?B?MXFNRXVleUVNWGs2MFVWUG1CZ2dMWGNtcnlsdW5KVUF1TG9TbDlrYURVM0ll?=
 =?utf-8?B?bFhSeHlpK09TNUhqZkxtUXJSaTEwSU9QRE1GVk1YUTFKZnlmYTZMOVlBZ1By?=
 =?utf-8?B?WWZHRS9SRGJwNUh0M2dZek9LZVE2OUpwRkkyekpXWmZkZ0R0TjVIcUMzdk9D?=
 =?utf-8?B?VDRLQmFwaUVZc0hkMFFIRFptK240SHoydzk5UEJoa0N0WlF1aWc4dGZjeTh4?=
 =?utf-8?B?ck1qZUpqbzlPM3NVbTMra1ZGbUxTamdUbFVFZ3FMTTdQSnphY1ByU0pCZndh?=
 =?utf-8?B?cWloTzFENW5vVk1LNWhjNnNOOHBBWkF3SmFkU0dEdnNiVkhtRHFYcTYvTzRt?=
 =?utf-8?B?ekVLQ3FlSnNxMm5HWnpSMHFrN2RJTmhQQlJNRUhiUkJ3R0djVmVYUVo0c2FZ?=
 =?utf-8?B?a2VYWkZHRXRFTDVReVFkaVRGMkprNmZHTWlpcFU1YkF4blBjdWxXbVFha3di?=
 =?utf-8?B?cWdiTEJrYnprT1h2K1ViTEhBNWo2ak54STJWZyttOGx3dnMvWUFDbE9Ua3Qv?=
 =?utf-8?B?cVh0ZWM0aVZmQ29Cc3g5S0tlT2dOYmdaWEdXL2dua0hwY3g0UjlYWU5yY2tC?=
 =?utf-8?B?UmozQ2orbHFlYVdSNTYxT0UwVFp2Y200MmNlNjJwRFNDYitEV1J2UjZXY3M0?=
 =?utf-8?Q?04IggdhClHbcUV7OkYPsE5A7M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd58ce9a-e1ea-4803-fe0c-08db97659675
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:44:37.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk8h68uKBOuKwnB+0mAC33g37JQxzOAUZw8jFCymgE+D0PKGMbbsz6mkrsIVbxQ9x/xQKqu6Iejp/yrPPWWtFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107

Hi Jason,


On 8/4/2023 6:49 PM, Jason Gunthorpe wrote:
> On Fri, Aug 04, 2023 at 06:42:10AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> In order to support v2 page table, IOMMU driver need to check if the
>> hardware can support Guest Translation (GT) and Peripheral Page Requet
>> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
>> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
>> features. There variables area redundant since we could simply just check
>> the global EFR mask.
>>
>> Therefore, replace it with a helper function with appropriate name.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
>>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
>>  drivers/iommu/amd/init.c            | 14 +-------------
>>  drivers/iommu/amd/iommu.c           |  2 +-
>>  4 files changed, 17 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index a5a350ee36fe..0605f02fa711 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -95,6 +95,17 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
>>  	return !!(iommu->features & mask);
>>  }
>>  
>> +static inline bool check_feature_on_all_iommus(u64 mask)
>> +{
>> +	return !!(amd_iommu_efr & mask);
>> +}
>> +
>> +static inline bool amd_iommu_gt_ppr_supported(void)
>> +{
>> +	return (check_feature_on_all_iommus(FEATURE_GT) &&
>> +		check_feature_on_all_iommus(FEATURE_PPR));
>> +}
>> +
> 
> I'm still against adding more globals, the iommu struct was available,
> just use it directly in this patch.

Sorry. I missed to append the reason after re-generating patch series.

We want to make sure features supported by all IOMMUs are consistent.
Hence we introduced this function. This function will be used in
subsequent series (ex:  before enabling IOMMU PPR feature, etc).

Also there are features like SNP which has requirement that all IOMMUs supports
features before enabling it. So moving all checks to
check_feature_on_all_iommu() makes it easy.


-Vasant
