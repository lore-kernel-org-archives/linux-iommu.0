Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2092.outbound.protection.outlook.com [40.107.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AEBA50
	for <iommu@lists.linux.dev>; Wed, 10 Apr 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723036; cv=fail; b=fFFw4T2krvWS+DxiTGs+2eOkyapKLzc4RBgdGyk8r5tclGdt3dQgHxSy9mfRNwJLGwO0YdrhtpGTFuKR4N1Bs9GToxKQF9ESC7p6TI8dgsexYhPXM7/9NP9VlVNZW7fM+BEP9n6cJAXT737E9aGNlq4dcRGjtol0n0JRZJs7XnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723036; c=relaxed/simple;
	bh=mk3R8dSLY0A4yc5O3tY8XDFL4yHvJij/g4XLCl+Enww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sv/hY3BH9gv8Cj8CS5HfQ9Wqjj7LB3wIZ26fV3Sj8L8EHl5cHGoEsITitT22mfU+MRFgPSwrcyerutGEeGozS9JinsL3JD2poM6ybIbsdanJ+Vr54TTe1xoUTSV8BB0fgUQo0+Ax+nxLOaG95mzkGKvhHnZV2VJvXcRfK4dEwC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w9/h4YfM; arc=fail smtp.client-ip=40.107.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w9/h4YfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of5/kjT+nCxErmnxl2n78B9CNIG+bxIcnjWdrzi/IMy0C4acrOVwHbza15KZlGskJ9z2HozTbMMJFqYss/4LpmHCarmcKm6T+QDbaG70YCiRDhT8ZORzMyg2BPXt0F7JhFtfaIziz6bM4LRFWzoatFhlaWRCUN+Ig03nIsBbBa7f/ZtobOlCEI492cC/W0UVjauhbvdpM+/x1Fxy/ObW0YH/VOtvx3Z76eY/1BS7fwMyS2WQvP3PxE0vZLbOyFpgnlk0Y/I+jP7rtSZSkyT5vejXKdsH9MTiT9h+e3508P6qXHU15WgzNvQ40Yfv2PSBy8KkZXMTk98c0PfXiMJf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtNZMLB4sjZK37fMnFsbcygN5t1O/kyJEOTNJ1RIixw=;
 b=dKkUBn5IHnNsQH7Rn4u59/eJbFo2m87A+lAQDozMTBN1SIJIaRAn5ODZ+EquZsuAy4lMuyXZnx5ExVKWNoYxeDrDh/lFlFZVVSzzjD0JouUOEnMajOgik+nWz0DfCZBUKfI3RA6HZvjOru8fh0Tc3vQAZHQ2rOpQjlhvCc9S1Q//HWS6wZH3dEOdnJLNBt/+E7dyjsyEHU0ZvPrkMmTxzamOxetSSflqtwya3RR4FoWQecccjC+rnq99H4dXTIOggRy0Z7Ztxem/Hisa8SgH5pUs+Mx2xE/7U5zWrrp0RWSEGtZCPtLRGw79e1WfG33kWofEVEGj/0o7doVICswDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtNZMLB4sjZK37fMnFsbcygN5t1O/kyJEOTNJ1RIixw=;
 b=w9/h4YfMvIB7MKUpkHRvgqp35AMuCAa7YU4fwI79tlUCu1BBKn5vaDjnEIMxt8Hr6FhvlNAuGE55J7QOMMhXgePrSat/mTk0NFJxd/AzKxrfoQafZGqVg2trfaXxq81GqdkIkiqKMiY+80GKlvwDmf7N4/Vwa9HwdT3Kvc+BXJQ=
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 04:23:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 04:23:46 +0000
Message-ID: <7863b2ff-e4f3-464f-8e95-fa3ca0444dbd@amd.com>
Date: Wed, 10 Apr 2024 09:53:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rc] iommu/amd: Do not enable SNP when V2 page table is
 enabled
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, bp@alien8.de,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>
References: <20240409051354.26429-1-vasant.hegde@amd.com>
 <9f2ffe44-80bf-d1dc-239a-f5fbff21b237@amd.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <9f2ffe44-80bf-d1dc-239a-f5fbff21b237@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4159:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s2CidtmYavriCw2OQyifU18aky7WYS5O8qsekt4JEbpXhRA9Cn39nrQh/dfn1Zntf29WyhOw8ViayLoeP/YKaNS4Xbka4mm+GnKJAM4XzurzlsgkXJ5s5s0WZKSuwFEV0IOTqXtTLCYLwuEoqr4W+35+QrxD7gW3Z++GqGwPnFXyXUza/7+iFYgqDaTK0vghFUJ9LuxWT2gLcNd1PwhoYYOG6u93OAc9pYZbdlbjH8E11hS5yHABQQ3qfRRP8eCnv0T9QukPlvVDrzDgIXw+skrjsMlGXP6h9wfQ59m1PVUqgOucY+xVvoARViY0XXWIu/qjCBwqVg74nJa8egdhOQAd+JzA6d6OhhMBsBcaTKJxtip+0Kzkr3rpw9UPCt85xggsw/0eYSw0pVY6DytXuxh75bY5PKC3K4pV95urZCrlge2hrDPalNbTPi7HsfpU6dYyyjyl8827QnsYCHlScXR26ycPeW2CkdYyywerGaxa8zfJXMTkRpIki7KkG/DIceWIm3uKA1JBFfm+dGM6jxWTXC/zuzze4TKHRl4VQE0ALBHUwXASxJEtRdXQo7w6/Tk4lnQUChDo1PDIeRdLB/r5l7l1UkjIsUg1R61GhEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDZPSTlwcTdSNEpGcGN6eHBGY3RvSmVKY0RoSS9jMVl5OGxqM1lpR1RCcWlH?=
 =?utf-8?B?cE1KdFV4dEpLeDQrNzVjR09uK3dHTkRUWi9GaGVNRWtSUjAzSEYwazN3eWlk?=
 =?utf-8?B?Nms3aG5QNTFBcUlPZG1WU3JzQ2FzQkdGNU91MTVheTI1R1ZES0d6Q01pRjMx?=
 =?utf-8?B?L3FuSnBzTXdqUk4rWjZTVkhQYWpaTXNaa0p4MHQyaS83TVg1cEdoeWFQd1pR?=
 =?utf-8?B?d01IRlpOMXRnc3E2cUh4eTh6K0xxR2dwRk5FL1ZmbkxGbjZwazdxT1ZqQ2l4?=
 =?utf-8?B?bytLVkxtRFBscVJWd3pBa0xwVHJLNTI2NjV6b0d3MytjZ1pVaHp6Z29vc3ZQ?=
 =?utf-8?B?RzV1UjllSnpoUEpURHBEaEMyeGxSMUdtQXIwZEoyKzVCbzFIa3crbnU5cnNE?=
 =?utf-8?B?YlN6bmkrTS8vSE1EY2hhb1pJMDc1NGlXWmQ0SVc0aVQ3MFU1dTZDR1FQM09n?=
 =?utf-8?B?ZUpvelBQbGs4Tk1yc09PMXRIVEJVNkJVMkROUG1sWmptYWN4cG5FdUxCZDNL?=
 =?utf-8?B?dEVQOTdUMW03QTM3VDBIcU9wM1o0VkkvYmJRNStXRUtRYmc2Q1BseDJpSC9Z?=
 =?utf-8?B?V1BlV3Y4bVBGZG5jTGo3WXV3dWxWWlNKZDV1a1ZaY1JtSWg0QVk3cW14cWdu?=
 =?utf-8?B?bXhQRzVKNUtwbzZ6OWIveXY4ZjR5eDhSVk9EUmYrQjBMK1gvdFVUSjY0NWJX?=
 =?utf-8?B?NmxhN0ZLQ2VET3BmdDYrTEpPbENtTFNZZUROR1ZiVmpXSEtKVDVYazF4eTZV?=
 =?utf-8?B?eUNKcHp5ZlJ4bVBZQktlS1p4clZFdG9NdE1zc25uaGdnOGt0NjZ4VVBXQWFS?=
 =?utf-8?B?ZHh0NUtkWjJGclkycjNoV09QbFRpZms2cnpuZHVKRXFuMGg4djIvWWxRT0Ur?=
 =?utf-8?B?dHBFWmFJSFEyZ2hPdnYxK2pQeUZHdGU4SmxFdjZuL0FEcHFGVVdiOVdzUE9p?=
 =?utf-8?B?akNYM2J5S0xOK1dYU29BbEJIcTRubXhQc1RtbmhzV2I3Mm16bUVxd3lZdk5D?=
 =?utf-8?B?QUhpUXkrbUVrZGdtd1NTamJiRDJUZnR2ME03WE03VCtqOGVyaDdzdEI1VXFC?=
 =?utf-8?B?aDRXaTRpNWp4bVFpWVUyT2hpY2ZVZTNiTjF6OEFHNmVOUWVwZlJISFFndjRi?=
 =?utf-8?B?WUVTNjFvRS9oVVU5SGxHdEdXTlYwSVp5NFZuK2lGQWc5QW4rckVURTdQNW94?=
 =?utf-8?B?cENGbjU2NDBPblBtSUI3MXkxbU1WQXNMUnUyWmZOdE5KNmFCU3dUL003MzVi?=
 =?utf-8?B?bjlLVEVGdHovNVAxLzRVNGNGbnIyMnVldHdtbUt2TjIzaXhSbVZuanZ1UEdC?=
 =?utf-8?B?WGJndk5NUmxDUThFd0FtUGErMVdHVVhZOS92YWlQd2Q1TFFoU3FLckVBTkIz?=
 =?utf-8?B?V3ZLV1NZVGx4b1JueHIvUXV1MXlRY0xPU0J6UCtYWkNORTNiV0hwa3pXQk12?=
 =?utf-8?B?dXdlUTgrVExtTUV6b1pWUUJxSjNBbFpMR3g4RGVTYi9NaVdmZWpkSlR0NVVP?=
 =?utf-8?B?ZGRIWit4L1BtYUNaeDg3NXVEeUhiN0F3MHNSYXNUQVp2M1NVT0s2SURSdEgx?=
 =?utf-8?B?cy9XR0hEd1VFRlJZZzJqc1hQWGU5Y0lQYlhRUTg2bFZrN0FSUnB6M3FiOWRx?=
 =?utf-8?B?TW9XWHEzL3Z3UlhySjRiZ3NjbVI0bklRSngxZnhkVWJPcDlkMVROaURCN3Fp?=
 =?utf-8?B?Q2ZTb1VpQXFraVUvcmFHT0EvZURpbWYzbTNDUGxFMXM5ejhMaDI1ODJXSk1m?=
 =?utf-8?B?OC85RXFycE5vaDd1LzZhblhkK1ZaVWdBTnJBZTJyNTJSMkk4M2pSejVKcTRR?=
 =?utf-8?B?VEY0U0R3b0ZqNmtqZlB4WUtZQU5GbnJ6NlN6c2xJbzlaY2lSc0dBKy9FRy9V?=
 =?utf-8?B?bklIOFYvbFRZV1pUQmUvWWc3S0gvMnlQV2NXSWNjM1BlT2MvZTIzTldvVFRu?=
 =?utf-8?B?ZXR1d1hOcXpCYmpEaFBhV1NXNkhWWStGWEwwVFZqS3cyVTlKSUE1ZXFJcVl0?=
 =?utf-8?B?ejFERktPNk9OemJyQnpibTkxcWZyUGEvQ0o5OWZFYW5EV2U2czlpTkNLaEh3?=
 =?utf-8?B?QVRUV21pL041aGR0RTJVNzgxU0Q0K1RZQ1BhQzB1UXdtRVcrWGhGSHJTRmlh?=
 =?utf-8?Q?/1Be8VgKS12CvLU499ZfIuD31?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fccd6a2-97e0-4244-9b92-08dc5916032f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 04:23:46.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w7sOFZ7aLT+8VJzjaL/oD3WRnpJz94b620NvdFgW8a4WQ8WgYvxWWxEEgh9jX/QOu6xHtP6fwu44MgWlH/wcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159

Tom,


On 4/9/2024 8:06 PM, Tom Lendacky wrote:
> On 4/9/24 00:13, Vasant Hegde wrote:
>> DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
>> to support SNP, IOMMU must be configured with V1 page table (See IOMMU
>> spec [1] for the details). If user passes kernel command line to 
>> configure
>> IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP.
> 
> Might be nice to say that you are doing as the user asked by not forcing 
> the pagetables to v1.

Sure. I will update the description.


> 
> One minor comment below, otherwise:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
>>
>> [1] 
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
>>
>> Cc: Ashish Kalra <ashish.kalra@amd.com>
>> Cc: Michael Roth <michael.roth@amd.com>
>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>> Changes in v2:
>>    - Rebased on top of v6.9-rc3 and resolved the conflict.
>>
>> -Vasant
>>
>>   drivers/iommu/amd/init.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 005981c2f96a..0d9b69765099 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -3215,28 +3215,29 @@ static void iommu_snp_enable(void)
>>           return;
>>       /*
>>        * The SNP support requires that IOMMU must be enabled, and is
>> -     * not configured in the passthrough mode.
>> +     * configured with V1 page table (DTE[Mode] = 0 is not supported).
>>        */
>>       if (no_iommu || iommu_default_passthrough()) {
>>           pr_err("SNP: IOMMU disabled or configured in passthrough 
>> mode, SNP cannot be supported.\n");
>> -        cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
>> -        return;
>> +        goto disable_snp;
>> +    }
>> +
>> +    if (amd_iommu_pgtable != AMD_IOMMU_V1) {
>> +        pr_warn("SNP: IOMMU is configured with V2 page table mode, 
>> SNP cannot be supported.\n");
> 
> In the previous check, pr_err() is used, while here pr_warn() is used. 
> Should be consistent. Not sure if that means changing the pr_err() to 
> pr_warn() or making this pr_warn() a pr_err().

Looks like we had this inconsistency from beginning. May be we should 
convert it to warning. I will post separate fix for that.


-Vasant


