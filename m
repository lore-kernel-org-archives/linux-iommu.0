Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8121FAA
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728022303; cv=fail; b=qMxVmSwowP/hcomPQDCLTK4l1rKiPIY7qX4OttK6cd3HVkbRkL68PFJ0dXtCXYKWYz/nD+DM4TsEISPfIx8fzVjMZbNmhNhJbVWZ+spcsA1ShqPcE+8A03YTRdNIPVdmuJWxmUqN0tTlZg9lgx9adZgpaqpO+SYVQ/NQB0IbxqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728022303; c=relaxed/simple;
	bh=QC1tg8ZsqMCmbscgzNOf/v1PHcgKe22mKhijr8gukRY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jTd/qkHgMB9+ZYOMdalUJ3GmfSh2z9fui1pXHMaqtdQw1hzdKc3Zczn5mtb5WiM6XoSKYi/RrNTobefq5no7WeQ6D2ikkoEqqhLiDX1YZB/iFofyaP5gvfRY7LLbScTqvFvNI6iYIpy69FucRc7ZohAJn1SZQqYrGrfU4bBsUm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0DLP9pdt; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0DLP9pdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLHd9xNvKWTb7gba7aIWl+h+NOwEuVJNOwtHzFy0IqPXahXBgeZhU22iMzN2Nml1ZhwHs9Hoqr2PCKyNx70miZrWv/eFZv2bIZggnrCb+nnKyFH8rm38oo/TU03tyEiC64ORDgqTiuSqEAkiKMUOhpW3pNwI84FNAKstZ/dwOnV1Wtni7Z/GGjelTyqxqNhZ2wDao/JamXo+R63n3RNE2EhtGAZZ7OSkfJuHOKsrrGFgnZ+vmH7XIHUNUsouPUa1mvOKL9/tcu6eTgjSeFfOuCrzV8r8ojCrEMQcb/zIyNDjZJoDJdbmmNbhbCDEdobtz1QcTWWmh9daPO/TbNIkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2HCkWh6l+cdSHeCZApTYV/82qDjfLt/Lb0y1M5E76o=;
 b=es1TaI3pxK6qkSFdExCaAx7LW99ZVtLb9T3iNSf77OkXeiTOg/A/CrOMncGPGibwqm9/62nE0Hhzo6CpKI46R8+xhgxpz+Vxt4ujfHMyKMtuoN6QRoStQTFyKDtrrOybHYNFwRA3QJntaBKBkMzANBiSFOb9yLoZRUJZfk4CRsmnFsG2dgeeC8pHkWWEbd5BXQoUUqyzCSgV//a9VUE8+ZeKQHsV3a+NBFW1XLulYNvh7lsAuhqB8RrNeJI04Y9mH2mZG3u+6awYyWuUvZtDUo3GBn8wnRkgkIYwB3UBLZJr/ifL29wWJoaLRL6jJqeqsb2u0dY6hiGHbiI2SHpRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2HCkWh6l+cdSHeCZApTYV/82qDjfLt/Lb0y1M5E76o=;
 b=0DLP9pdt6s09k8wMnCd+GWSzEqpJFpGU811CGYKiXcwyraUb9/Ct4aF57nNPjXeWGvpWrSVzJrVB3GkTvWiAs5zpCbJAc0/OgMABzw+kvfmkMDX9POojKaxr6IsiVUJkjo8xRHdwvDjGqyy5RXkc3IY5tKZ75qe6D+sub886eNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 06:11:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 06:11:38 +0000
Message-ID: <96676a7a-5041-4450-9b79-740006ba3709@amd.com>
Date: Fri, 4 Oct 2024 11:41:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] iommu: Domain allocation enhancements
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org,
 Baolu Lu <baolu.lu@linux.intel.com>, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <970c6058-9e02-4cf6-bcb9-cfb8afb4eac1@amd.com>
 <20241002142431.GH1369530@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241002142431.GH1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf3f504-1027-43d1-b472-08dce43b67dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmFpaWRKdWJ6OUxGNHltVmZUWE16SWdhUVdwNjB3TkpOMlFORysyYkdhUnBC?=
 =?utf-8?B?WWYrYU84UE9HRW5RM05PZFR5WGlWN1ZkMHZDRjhKbGNFU3JiUUpYaURQMXpW?=
 =?utf-8?B?dTBlQStCN3UxMG04Ukl5Ry8xTWlYSEdQYXVVR0Z5YnozOWRCUmtKQUM1ako5?=
 =?utf-8?B?cUVIZ25BRUhRK2Z5MjdGSGxQMDlBWi81akdLeUpFUUt6Q3hJbXV2VmYvUmRV?=
 =?utf-8?B?QzZhZWlaMXd5TmVNMFlmUzY2Tk1Qbzk4SGtnU0pEeno2aUFGZ1VuZDJyUFJV?=
 =?utf-8?B?eGhKQ3Rpd21rbFFaRGZ4V1Y0alo1VUxyZ2d6NGhBN203N0owbW81WkJ5azhV?=
 =?utf-8?B?MlRKQ2tPUHdFOGJ4Mk8xQkljV0VWMnFIVElsTjlFdTNiWGxRVUJzVGh0TDUz?=
 =?utf-8?B?UTJFNS9BQ29KQlcydm5ZUkNPRWZjWVIzM3Fha0ZTNFhqYjN1OStyeXdBdHgr?=
 =?utf-8?B?YjQyQzljTHhqSDdISStRWVM0ZmhwcDY5UU9tR0pKcEJ3RktET05LSGdBU1BM?=
 =?utf-8?B?a0xSZm41S3Y1b1pTK25DeHpuL0s4TEpSUHNYWlFvYVpYNms5QWp2RDFTNUY0?=
 =?utf-8?B?cW1PaVl6U3ZHOVo5RDZXeDV1RmdmSGRKZHh1dXNDNXRGN25yWkNZc1F1UzFZ?=
 =?utf-8?B?N09JNVhPcDRzcUxFZzdKZk9XNlhGTFNoNkhrVm5zbVN2L0hoNitYOTdSbDRG?=
 =?utf-8?B?MGpHK0lackdjWGlLRVB2ekR1YXBoRzQzRURJemQxdk9wMk9wY2ZKT200Qm5R?=
 =?utf-8?B?bHF3MTkwRDlObG4rejRRTVAwaXQ2djc3MWY4UHA3VDhXTHdrK1dkc2dIYUNy?=
 =?utf-8?B?bllzQjFuTXdFT0lSbjkrUGdMQkdTc2g5SzNiRTVQandZb01rQ0FKMzVYREE3?=
 =?utf-8?B?RFlJZTNVYldocVB1Y3kwK2dreVdYNTkrV2h3YWg0UDZqcE4xMGxLNjF4dStR?=
 =?utf-8?B?aFFQQUs1Q0IrNVE1anFpWnpqZXljRlBYWERvS3hYR0tYS2Vkd1FjY1BRSUhH?=
 =?utf-8?B?MzVpU1ZrcTdwNDVsSWNLN0RDenR4VjNnRGVyMElNWmpiYjgyTXpnWm1ZR2Jp?=
 =?utf-8?B?VzFoVFJUVUFkbEwrRE03akQ4dEpNbzBIQU1aUld1SGh0N05ITHNDOVUvR0Y1?=
 =?utf-8?B?YXh5Z1JUUkV0dkwrS1c3TmM1NnFQUGlrcVAreWRTTE00SUpxUnRyRCtzY2dB?=
 =?utf-8?B?OFJSUjdvNGhVVm5rRXFOWnBKdi9tYmIrSUxwODJSSUowdjNoamkvRlY3TUJq?=
 =?utf-8?B?ZGRTSmlucEhGM1VZaDZmMFR4NHJnNmJ2VEc4LzFVaHdJNS9ReTVjT0NjS1dl?=
 =?utf-8?B?d2tBZ1p6QjcwakROUkFlYW9rSUowaXRRZjcyVHYxU0Z0M2UxZDRiMXdOMi81?=
 =?utf-8?B?TEpTaFNHbmtGNjBDYnFML2FTVk9WaWl4THd6Vk1GdTc2UGo5ejVIMHZITUF0?=
 =?utf-8?B?eW5sd0NlTXlNRnJMeERmT0E4dUs5N0xKZU9DWDFtWmJTWWloNFovNHkvUjAy?=
 =?utf-8?B?K2VzVlpBVmxWRmtVYUl6a3JCc2lCY3RGK1JGS0lBdWlsOGpVUno0eWllWkpT?=
 =?utf-8?B?YXhjRytWUzF6eEhzb1FIYXUzN0c4cUlNUEFJVXBSVmVwMWg2cVlUQkpHWkxM?=
 =?utf-8?B?eHZjQStkazlVemhsR1pKMjBiRVAzVW5wM1RMNlp5elVVQi9pMmZmUEREZncv?=
 =?utf-8?B?dGFiZnNJVHQ5US9WVmZqL1pKVWkzYkZSU3M2TXBqdjBMNjd1cTlVWkxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHE2Z2NmM3ZXdElPeWpwWFNFd0lJa2tVcjFxeVRYYUY4eXVCNHVGU0JzRlh0?=
 =?utf-8?B?clNndjBPbzYrbURmQ0tLVExONDV0T3RaZEI3Tm9PeDNibGxRWFpJV1dxbStB?=
 =?utf-8?B?b09JclEyRExxTFZsNTYvOE85L2ZIVHloMmRqMDlmZXFWaXE4eFpBRzF2cmpl?=
 =?utf-8?B?eWdTcnhRMGpmSVpyQzRKRmt2R0ZKVm05YnFNMCt1Y0ZKV2VTbmZtK3AzaTZq?=
 =?utf-8?B?a1BVUW44bXFwYWNJbkl2QVE0RFhzRkdwTnJORkoraXVWNElYWE9wVzZtWnNZ?=
 =?utf-8?B?eTMxU2VKN3ppTi9vSEVrUWpwNXpyK2VKbXRPa2FhbWlDck5MUW0wVU0ycVIv?=
 =?utf-8?B?aEtVWHVtT2pPNWFGZXdNZVY3bE40d2Fwb1IzYlBLai9TUFU3eHRuaGpVZ2kr?=
 =?utf-8?B?UWFsUWo5NUduMVFoTGdvY3lMaDlOc2NDTDF1dXZkbTRpc3g2MnJCU0s0TFMx?=
 =?utf-8?B?dzlzNzF6a21yN2dKOUZhbzJFdkVBQkh1ZlpIU0xrSEQxSk1BcmpQSTNGNFhV?=
 =?utf-8?B?QkJJckE4OTg1a2RkMWk3elNQRXAyaGsyR0hMRjd6d29jOWZJdnU2dFNqdDk4?=
 =?utf-8?B?U1gzL2NnYzJ6Zzc5ZDFSUzh5TXFFZ2wyZVM0b1ptNUVWNzg3RUs2QlJObkc4?=
 =?utf-8?B?UXBCZkllTU1CUFcvWDUyUXF5eGpIdGYzNDA5K2c3dzFKMGwwNDhHYzNNVm0v?=
 =?utf-8?B?b1p3UEJTdFhoaUVFbUN1cUk1alJNSXpVSUVMQUswdW9YY0NRN3ZzMDRNWVpY?=
 =?utf-8?B?Yk5YUVgyM0FMeUJrU1JLYXJyZ0NoYXZCZUxJWTRjQTNKRHJmcDM2aXZ6dlJH?=
 =?utf-8?B?ZkZYVThscGdVT0JQeWhKL0xpMjE4N3hWd2o2Vk1OczdqcUV4UW5vVmJzdTN0?=
 =?utf-8?B?TjBTNVNzQ29PaXM5WE9WRU9nUGtJNjVMZ2pNQXdOWWpBMnlKQzZLR1g3U3NF?=
 =?utf-8?B?YSt5NFNEeFZ3ZVlpK0VWZDFBNGRTaHFMZTRHUktvZ3pNaHduaEYxV2IrV3M5?=
 =?utf-8?B?UG9mcVlOUTZVb2ZuYjNPbjk4V05jMGtnMW54ZngzeFc1K2lWNndyYytxeGVD?=
 =?utf-8?B?cHR0QTVnblNFL3F3MG5Oa1VaVWY5dzVNekJZU2oxbU1lajZaUFdPaTFVTG5E?=
 =?utf-8?B?dXJpOTN0NWdiRURHM0g4Sy9ITXpYaVFzWHhoTlg5eE94VEFVRVBJUWtYbDJ0?=
 =?utf-8?B?bk9FVENFbUFVNlBkL3hDZTFudWkzV3hiWVBhSmtBZmR0eWUrUEo5NnNTYi9Q?=
 =?utf-8?B?d2FwdW50UDRjVk51MVVybTBJZEtUdFE3M2pneWRqNHZLeVlZMG53ZUtXRTNz?=
 =?utf-8?B?RzBOeEJtMFhUcFlJMitYaytVSmc5TUJyWThmMHNUdG5JWnN5MGVjVzVwTlgz?=
 =?utf-8?B?NDFVUmNncXZsbWtzZEtRZmQ2d0JieUptZmZ1V3A1SDJOT1Jkb3JhV1Q0U0ZW?=
 =?utf-8?B?RThiVzUrYUJubXRKRkQzTi9DNFNZVEVISEJFcWl1OTIrQmpRSjBnRG5zVVpH?=
 =?utf-8?B?N1czYnZXNFhENFc2cnl2SVZxVm80NThCNzRVcjJtV2FyVmhsQ2hSUk1xMmF1?=
 =?utf-8?B?dXpvcTZYRm5LMHd3QS9Vc1RCNGNFMGJ1R3hCRU1qc0xTM1FqTk5iaVBiVG9G?=
 =?utf-8?B?bExkTmNubkkxOXk2RDl4RmhCM0RUSUUrT28vK09wYXZSRHFLMlVla0hnQkJo?=
 =?utf-8?B?a016aUwweHl2SUhEREVIK1RlSHhpUmxMYzFMcmI3WFB1cGlzQ2lpRHF2Tisz?=
 =?utf-8?B?Z044bzNZY0RRTEpzenJTU1J6UU5aS2o0T3pWVXVhVU5KcUNqWVh5djErZnJy?=
 =?utf-8?B?TlZsZUo5dmdSU0NuMUF5WkpPeUhBZnJOcGN5SjYvSkNNb3FNM0duVk0xN3Nj?=
 =?utf-8?B?TDBVeWkwNmhheDFHUjBaT2YxOTB2eXVENVFTRUgvcExZemg5RlpYeG9nWE1M?=
 =?utf-8?B?NU5UMWRmOXZmaURGbGl5bjhicDZ4UGVtVS82MldSd1crM29xU3hRSHBMSDFK?=
 =?utf-8?B?Z3ozMHcxSzJVWDlueXdzM0R0aWhRSEIzSFVKMmVtMlVQVUhrUGgxc1JDeTFM?=
 =?utf-8?B?M0FFdjBaYjJxRGUrWGlYdHFlbTJ6NURvaEtJWGJqOTlJZDBReEx5ai9Wb3B2?=
 =?utf-8?Q?0Vltv3PB9kN5iFQm/F3bDJfJz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf3f504-1027-43d1-b472-08dce43b67dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 06:11:38.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW6fsp+f8hMub0xM09SJsynYm/pcBG6ADDTgtziQEXUphFu2qO2W2i4UKA4pD0xSfOgUTEi8y9bdvLuSinRuFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253

Jason,


On 10/2/2024 7:54 PM, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2024 at 11:00:32AM +0530, Vasant Hegde wrote:
> 
>> Looking into SMM3 driver it looks like some changes required. Does something
>> like below works?
>>
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 737c5b882355..4d4af11c5fda 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3088,6 +3088,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>>  	struct arm_smmu_domain *smmu_domain;
>>  	int ret;
>>
>> +	if (flags & IOMMU_HWPT_ALLOC_PASID)
>> +		return arm_smmu_domain_alloc_paging(dev);
>> +
> 
> Yes, I think that is good enough for now.

Thanks! I will add this patch in next version.

-Vasant
