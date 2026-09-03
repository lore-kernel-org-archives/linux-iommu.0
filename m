Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA425A640
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396092; cv=fail; b=Xc85LN4eDOFYmIoHcRLAKMMFQGNPaMyPCZ8cZn2l52kjWngv6nN9kU5M5L20zQJiOSYds42hj+1Gdzke5OOIUu07iakt0uvD3wWMARa5ib5Afwnk8dCcQKiKgklQk/A91vQlOrxBPu1X4Vz3JZT6HuTd8JUdJJRnCffSc1YDIDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396092; c=relaxed/simple;
	bh=4MKf5U75DywIrqp8MhvHb8j7QV4zFbMo5R2Yq9obpOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rh3XklDsHFFfob/z/T0fL264HwZlVaVXvR0HYC/W16WDhSoNlBAZmurwnovGQd8PBNcPGocmVlFSDci5AiSqv+S6C1cLLmrXl/7fLNfbVyo2/CeF3Drie3ql6TOWVVcM0dh68BR4PhOGgkYheAQTcDT+WCXkNY2KD8nM9FvICe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OLJbwVbj; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OLJbwVbj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFJgkgMroM3I0ss8R+cc77O1A7dIjuEt2VjvqXrX6ztDTrq8WIWbM/dEpx16BpcIcwLzW4FM68x2eYSffXi7rD7wfsCfU2A29EWrPkI0wLWfzkS+ZjLsl7S93cl31F1AeRou49sHrFfJRnoHVPHR7TgxpxFpV4xkk/kNNnk7D+mPhFwa2veWHfFsyeLvRb70eICEQsQXOfs/V1fnIVl/leeZv2vCbG8VjjTQ4fYiFx6UifYiQqNVhsYwchSKsjGpAc0dqLAAsz9rIubpkWP7vpjQqeR1AifLPmfjWxRJqLCSRadd/rKIG7vXtjQZG89I41fcP2ordkoijyrMTyWfwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeejGKKH57Ez6cFONA1Mlhai5PQoKACZu6JVlaCZJz4=;
 b=mmCaeaCaI2B2VWv085gZGQ5Wcf7QYrbaDdP9FyRGRuHbD2zISmKTrlUegeHbWibJk4j/r187hWmHu5Ad1jjpIbsgOFzc1iX/k+sxfyunpBtnFBnz5MV8r3exlZNtOWxvnhrPE4bYVvS/MM7npdPN7QFrkxst2D6916DUXwt5mqoDexFyt7dc/LOAuDc9qzqPItYscqsOUgVI5iTgCoDctx20cVCLZRz/41KPEHIs35Lr4J8T/I2z4opMdGwT6YU9S0x4ScL7keUhntwq03K5nkowIUYDEDlyl0Blk/7B63o1a9FaMSI7SUu9uR/g5+9SUf4x+mfC08DhBIe2SkApaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeejGKKH57Ez6cFONA1Mlhai5PQoKACZu6JVlaCZJz4=;
 b=OLJbwVbjYNoaK2ZxFjItLyuX1aEgjx7SBLDcTZT2HzzsiNHOeyN0sFnEijMagolqqyIoPhOtlpTUiHdf8ksF+gOhHCkaA5qqxsaTf81ns0a+pKKzJdp2BKcOoB+T7r+Hr0cB6KTQdhyeQ4l2k41w9VP48qJJwVIuvT/CeeamvwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 00:41:23 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 00:41:23 +0000
Message-ID: <3b84605b-9437-4941-8df7-caebbd5e1ff6@amd.com>
Date: Thu, 3 Sep 2026 07:41:14 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] iommu/amd: Add helper functions to manage DevID /
 DomID mapping tables
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-16-suravee.suthikulpanit@amd.com>
 <fb4f14d0-3c80-4a77-880a-e28be558fa4d@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <fb4f14d0-3c80-4a77-880a-e28be558fa4d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a434039-e1d5-4af9-3536-08df09541429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/zKrrldVOUab+q/axHeh/L61WTPn29WOuKJ5tiMGO/IQSBjPK8n3DpIfJUknqFOWYdlU20lIKpXXw2D4+Io5h5SruhOy0fjnoztGHOsFmJ+wWdoo34NwfhVRANTmS3Omht2+33H+lhNAnk5lxNaA39naJOIfqAAcG66pLDaoofh+0uvQos1iBwulOGKpeGiIelfS7LvjeyAkNpBj9uDEX+7oIvFaoF1Pk4hzZllGqAkQKX6cLgmm2h20FINC+hkGzGQE/Gwlr6mITQuZ9IRk+3RfjhSQCEwYphPPqJCuBPzjFEDhC6TAJwFSWeRzUZjn1IYY7/kpo5Gcf00Q8yjGbNTuaBObJgtcnr2MpNdxeaPK+JC2iBffb3FpiJzaK9yDFwyPvQHA1PckvBHKIoAw5qHIFbMfVaMtpOmLB+jFoVIPkNyu2nSEsiMMeh8vKaitV0i/Msl54xX2zi4SOo5RyfvW91HZfkHQlrzhWJ8Umb5njX87e28w42hqa6g7o1eiG0avJ7xNX6lnz7AoXquQNiSKHZ5RA7ppnS/EcnZFsmLTUUI2FrfKj0OqMqtKoOPOEmOdXxpbrw00w8mDp1UP2A9v2MSnXlKek/gQlCs1YT368pmu+X80BqsxHcO//GesTS2avSacwnHfwTUhqwzIEZIRTkCIDLhM0u3h4rdAIsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE0zaDg2MlZsc1hqNHRLMjlyb0tGNXVjdHB5SGZlUXBsVlNhWTEwTjBjYWpE?=
 =?utf-8?B?SEE0WGF2Z0VUdzBTc29LOE54THNJaFp6RzRxbnR6WjFTZkcwcWt1ckJUSndB?=
 =?utf-8?B?eGZ1MWJnSWhPdU1TT3hpdkJaSFVVL21TSGhzemI3dEo0UENrMVhDOXgzTURN?=
 =?utf-8?B?L3NxKzlvNjFGRzE2SmYwQmk0QmQvWWVwZWJ5YnRYa0tXTW1tazdzVUpWRlV2?=
 =?utf-8?B?UmhzQmhwNEpNTWtUWmEvUndYb1JhS2taVG9vd3J5bnE3Qmp1dkhpaFNMNkt4?=
 =?utf-8?B?ajNKVWoxY2hlOXFESHg5UWRGZSt4R2RjdTIzN216TkFGUWNkcE54SERSckZv?=
 =?utf-8?B?OFNZejRmMUdheFBSZVU3OXE0bm5zV00yZTVjdW1QVnpNb2E4bjIrSlBialFY?=
 =?utf-8?B?S3p3RmlaZ1AzNUdGUXhDTGtSQVhtZmppdmczc3UrR0lxM0RiMWg5YUFkeTBl?=
 =?utf-8?B?anMvS0lqaHk1VEFCT2pvVklCUXAyeXMyMmVHYU1JM2dqYU1IdUlSL3hDSGYv?=
 =?utf-8?B?cFE0NDBIRFc3NFZnYzd5alJYUjNCOVFWbGN1RDRqd1JUQlJNbXd6dUk5cEll?=
 =?utf-8?B?Ujh3cjZvUEFuMVcwWHBaQlVkcGRrZXdxQmJlNnRZWjBJZ0Q0TGg1d3Z1bm04?=
 =?utf-8?B?dCtXY1ZTY3ZBYXZkM0tHOGlEcHFqU3p6Z3FuS25hZjlmRjJRclpBOGFNSHhq?=
 =?utf-8?B?dktFZ2VLQ05HUitQNVZod2xnVkpSUUU5ZGdTUXhNV1lmbndYcFp1MG16U0sv?=
 =?utf-8?B?amFxRlE4NzFOSzdlV3o1T3VWTzliUU85ZGY0aDgxb1hMWTdDVVQyamY5Qkta?=
 =?utf-8?B?TGFjdnp5N2MxLzZLZnRtQ0NoVkxVUUFCQUtuSzJGd3kvRG82Y2xsRFQ2QWdY?=
 =?utf-8?B?NmwxcFJmODlTd3RjLzkzNHFHajdTamx6VGNiakpxUFpqVi91d2toclROM3E3?=
 =?utf-8?B?STZYcUlxbC9yQ3g5d0xvUEZKODFxb3U0TlFodmRFaWpybzR3eUhBcUdXL1Vv?=
 =?utf-8?B?NG13ODZQUE0zL2FRNXlINjFTTVdicEdETjREa2tvMCtXWmJ3aThqZlNOYWha?=
 =?utf-8?B?aUcxNHRBTGZQVUtPd3ZkSW9paWIwZVhvYkZ5U1BxNUsrZjVlanZ3ZGFPeFhj?=
 =?utf-8?B?K0Y3VDNta09ET3hOVktSWFNJR2ZmYUV5NTd1WFh4cURhVnFYN1NlZXg4dzQ1?=
 =?utf-8?B?eXNMMTN4NGx4THdoeHZwajhLS1liV3V1RVJCQTJnbHlSRDNVVFhQa295V09B?=
 =?utf-8?B?RVNHckM4RE5ub3FjQWVKemNPYnJkOUhkMlUzUnBZQ3g5b0lTbDYwTmpyLzhq?=
 =?utf-8?B?UFIrcmphcGFpV1VSMmd3NWpoRktYSEVMbUlzbjNkTlFEbGtoWTNWN2NsRGpM?=
 =?utf-8?B?YzFmdzlzSnFzdDEyZGFDMVhYdFRtL0VuNEpTb1dvbTFXOGdGV045bVd6eXU3?=
 =?utf-8?B?THoxVU9jQkh3R2w5elZXbGJSUEJkYzFRZHM5bExDRkZXVkQyU0wxS0V3dXZ3?=
 =?utf-8?B?K3BKaDJnUXFJeVoxeXNBem4wYlZkWDhuaVBUV2FkSkxSK0RvOUJYaFd1b2gx?=
 =?utf-8?B?WCtvNUwwYWFOdGZSWVNoNzlNQndzOGFudmRsOThPOTEvaCtEOHJtZVhXbnkw?=
 =?utf-8?B?ZElZYTlCdHgxeTJ5MWl0RHR5T2tMa0Z1Y24xYmJRbVpGZCt5eXdaYVYzZXRk?=
 =?utf-8?B?YkpUWjhhSlFRWDZNTFZOdUNYTnVUbkFoN3M2RC84S1FOU01wbnRsMXNDR0pE?=
 =?utf-8?B?SnNTNmFieDhxU05WbzJpbGdGYlhNbHBJb01xNFVKc2d2OEZoK1B5VE5FTVVF?=
 =?utf-8?B?OVNlUG9naXVOV0NKVTBGQmhkd04vcWlOKzBjeVYwazV6UDVSTE9ta2NwYkNn?=
 =?utf-8?B?ZGoyS0ZtUUxDZ3R1TTFad0V0ajg4UkwzWWZSNkNBckNIOFRlZmhOd0dobW1r?=
 =?utf-8?B?MVlteVpVaStQS2pQc3NWY3ZSS1ZWRjBHdUZjVGVueFVPSkN3NUE4clNqSkVq?=
 =?utf-8?B?TVVma3pQKys2dXpQV2I2alZoeUkwREN2OEMzcC9mMmdGTnAxbHI5NWFNNCtE?=
 =?utf-8?B?RTN3MmFZTnlKQTdob2NQaFpGbU1rbjVwQ3RDSUxDckJJSThyNUNFb1lmYnlR?=
 =?utf-8?B?WUEySnZzVFVHSmxZT2lMb2dlZDVaeUxlVXorWjk1MjFOc1pldk45QzZpTk8w?=
 =?utf-8?B?aDJYSVV0Y2pMY0xLck1jbmlCSTVYTFVPNTdjbVpNSFJPWWsrR292ZU1ocWJ6?=
 =?utf-8?B?RDk4Z3JCWmFSWHlLNm5lRHFkRVhlMlBmZ1NVK096N2gwQXlNN0VHV0xOa3ZB?=
 =?utf-8?Q?eBvl4go32Hn4WCC6d2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a434039-e1d5-4af9-3536-08df09541429
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 00:41:23.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIVHYVZkTBJN/AsNiocC0pBW5pe2GnHZjMt+8z+04JDHRO+d5Rz3Ys3xnsp+C+MTsKVqYu1DJJGJtDvx1vkVPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864



On 8/19/2026 8:30 PM, guanghuifeng@linux.alibaba.com wrote:
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index 2c1a267826dc..91d0dd3ac912 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -26,6 +26,20 @@
>>
>> ...
>>
>> +int amd_viommu_init_one(struct amd_iommu *iommu, struct 
>> amd_iommu_viommu *viommu)
>> +{
>> +    int ret;
>> +
>> +    ret = alloc_private_vm_region(iommu, &viommu->devid_table,
>> +                      VIOMMU_DEVID_MAPPING_BASE,
>> +                      VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
>> +                      viommu->gid);
>> +    if (ret)
>> +        goto err_out;
>> +
>> +    ret = alloc_private_vm_region(iommu, &viommu->domid_table,
>> +                      VIOMMU_DOMID_MAPPING_BASE,
>> +                      VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
>> +                      viommu->gid);
>> +    if (ret)
>> +        goto err_out;
>> +
>> +    return 0;
>> +err_out:
>> +    amd_viommu_uninit_one(iommu, viommu);
>> +    return -ENOMEM;
>> +}
> 
> The err_out label overwrites the real error with -ENOMEM.
> alloc_private_vm_region() (via viommu_priv_alloc_map()) can also
> return -EINVAL when the pdom is not set up, and that information
> gets lost on the way to iommufd. Please just "return ret;" here.

Ok. I'll fix this in v5.

Thanks,
Suravee
