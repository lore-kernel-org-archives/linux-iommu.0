Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013047.outbound.protection.outlook.com [40.107.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BE28D831
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407804; cv=fail; b=Yb9aFVOIZY1bRf/ZiNtrIwbRsoJbSZ2u3d9EY8V3h3n8nWy7mslayBxRyILIVSDzWFm8gGH0Ld0E3tzG1R3K8XspRi8499MxUirl+q0Uq/9eCaU9mCCfFr8nmKrlzSN4j64f1aGCaNEyY/RkUQNjiUpk9lFYF51cY3Zr7wFUgW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407804; c=relaxed/simple;
	bh=IueTGTInx+ueNgA7KtWlXqBYGV2YqXXCnvGZbY7ZvlA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bwm2+No1DUj5eRlgL/KdaFmOZjKC0XAPrYutA81TjD8VZlsAXOjUZUT5Fz6t1IfMdzNVquCOAQ7VRpqwelQdcUOQ0VBFY2ujZF3YQhG64/qaAv4GaUeoi8xxcSpe+eyEk3Yof0eo3DCOjFDrxsi/v9rermgrXozuMHpwb8DVbEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FfvkGuKX; arc=fail smtp.client-ip=40.107.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FfvkGuKX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsXlDS04LUlyvgvnmG9fs+FBXSBD1PkIuHGs4mBGu1TpPJIOzB3h8CMZCeb1ITLnIluLN5uEethsR7e8r4wyusA8Jx5309A8WtfkTZA012Ad0Fvz52hVQJajgqGq2AJl8zJ1Uy0DZ+JzIRcHqa29rJkqzYuA2CFymzkdv5FMupYnNXUOKhqcBnhsNTRaDFEqS9slqz/0Mc6tAcfadwgZ4C+e7HdFipjqjCsFUz0XxD1qWY3tS4t7m0Vn+3PIeKZMI+2fZpKw96We4ZfgCfm9fZR0TvurpDYMGurKFddpe4RoIr3NJ/M0O0n/ppMVH+6DtYCzcGOWdLOs8c1FW3QCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWNHTMYg4xQHlBG8f+KtrWbaYnh0FBjd9gWy6LJyRPM=;
 b=gOpYu5NRaryqgkTq9NLOUi35dBftx7FRi1wzlNRIsv1BcTsohf77XBVmjJFej/rYj9QNB1TsavmGKU1FRPXpwMvY3Yij2qC6wOiMaZxpuhz4Qgcsdc+4sIfsbknvTnKqgIA5X/rbWkPaJeIlNU8gBRHaOcZdI4WKWZH7iebSk1SJD0Ash3hrVeC+U2DBhU8j56BUfXtZFe8laJeJqR66vY+ZzisXAjU7vAUEGOiLAlWp0+gvQeN4/1Ya/Zklm2dEVnH0ED5sv9wbC4c3ZPomian3/5f6T2VbKAFMCiMYPwlbAOmcfzAYFKqTHD+wr16BYiEFjUYiAYOvtSQI84lVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWNHTMYg4xQHlBG8f+KtrWbaYnh0FBjd9gWy6LJyRPM=;
 b=FfvkGuKX/YB6+mAi+H0i7ZgryNNh5PXL0eHbk1WgRXafOmLBcIxynKDB2aCjv8KZ4HkHpyyRwqQs6eUaeJbmRvbkJLFsHZLnS1ZFxWggcJf25zzIAQusQFZqPTdwxylAlUarqkYmc8G39r5Smg3l5iirN9qMfsc0FeLrUxXO2jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:56:38 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:56:38 +0000
Message-ID: <6ecb2ec1-974b-4ef3-aae3-ace4aa90baf8@amd.com>
Date: Thu, 3 Sep 2026 10:56:29 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] iommu/amd: Relocate vIOMMU translate-device-id on
 PCI reserve
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-25-suravee.suthikulpanit@amd.com>
 <6576c2cf-fe35-4c64-ab19-0120494d7e42@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <6576c2cf-fe35-4c64-ab19-0120494d7e42@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0079.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::8) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f205b5-55b8-4555-07b6-08df096f5b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	mpLs4I/YMOMfb1HSMin1cl1j441j7Y92zql3SmveE87pgCLKRzZR47Ng9gtSTfYeuytC9nWCWa6PZIUzGaPYwrNBxp07OPs9vp2ELpBZPxgML7+Uinf2awp2KkkpX2Fe1WxvwrlHVpk4tGBViYzCrw9mI+K1/WdyQq/+Vi2GBEWDXeOn4DHa4AcbdQxGygHZX0OyFeWehTSsCTSNO9PaR6t1/5BpznSLeNyrCeDQUPSHrjXXw02TaWOvzgjSuGrpIyC0F0x0xPfYWawxzwJKQ/YYz1bwiJDOF20aK9tKuEkbUvtmNXt4oiVwfwpOuGgFpAcsCAt6wUbTYhLHDmuHI9lgdNTYWI3Hs4Rwt1XZXZw7qBYFboxbc+VZUPXXGPEuqeV3giXsYl2P55iHy09vCXJr6pSUA1nTIsAV5V9orEY2RpM0IyF4ycFoItFXfuWZ+wD5yCoEFCz2iR0MEPm+TL8IoyJ+wF0BUFm4KlFrFhBWc4Kyp3eyDA3c0Q+7Za1RASEkkzKrA8xDhXHxKpZ2zdyDWeHBeDEIvdWahCo6P0W7y796kLcStOOZ37aT9Y2A1mBoZv86Ym6aZbZh7i7w7QbJCJWph39qw2cSqMfUoaH0P7/b7nUjpOTqgNOiKr8NUIWgQWulLeZJ2L9wVD2Jlo0+9YJa1AyIGOp8y7NhWXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2NKRWttVVpqdU5qQTloL0lPNVlyVDRJRGR5cWEyZHFpSUsxODhTRi9VQUE4?=
 =?utf-8?B?UHBWZFJvendyZDJGWVJNTjc5L3hEWkM0bitkWHlCSkNMWE9xa1JGMUIzb0Mz?=
 =?utf-8?B?VERtZDlRZTlXVVltaEY5bzBTajF6Uis4elBPMm5BdnFlUGlEVktSVGFKYU1P?=
 =?utf-8?B?Q0RmR0g3alMxbHJNenQ1VXlYQVUzdnA2MlVzOFBjakpaSWI2aHlUTXg4aTht?=
 =?utf-8?B?YmZLd0IyTXJhS2FROW5XcW9hcHNYNXFVRERSWkovRHE2djhPUWhrbVdNazM5?=
 =?utf-8?B?QmVWT3U1alJicFpPbWNMN0JTL3ZvbGtkTE83WVFyVVFDUEFYckhYS3RXMEk0?=
 =?utf-8?B?K1JZTEQxVmorNjJ3MEtuU0lMd0RpWUVRWExRQzF6UW9mTmFtWXpEWnplUWhE?=
 =?utf-8?B?elpjNmhwVm5Sb0ZIdVgxM1lmYlRvdmxHbEo1UmhldW80N3hyQld5Z3padWlW?=
 =?utf-8?B?Y1NVT2phU21DWVlCNHNET0ZscDFKdzE3RnNvMTA0aEtnWDBPNWZCbHJ5d0Mx?=
 =?utf-8?B?YVhtNnhWcVhzVkYzY3FaWkY4ejU5SThIT0djVExyZFphaEc1aVRFekJFWjlZ?=
 =?utf-8?B?Sm9HbVNXcXlWUXlKbC9JR0tLRWE4aVZkaWtEVmQ0ZmNkQWxhdTJNemtnNktM?=
 =?utf-8?B?Z0ZydGtTY1hjSWhLVjRDdTVzVFJINjFJYzR5L0ZmR09NTmtUVzhLM3ZHTm85?=
 =?utf-8?B?cEcwYjB5dzd5a3laenc1R0xobVZvK2JwZEhTdUVSNnRka0FFMkhDdUlTZ1Nv?=
 =?utf-8?B?T0NYZzZxWG5zY2JkK043Mmt1OW1KeFg5SGdLRjRlZTQrcmJIR3dRQ2pYWmxZ?=
 =?utf-8?B?d0JZVi9wUmJvbzBYTTdzUm82WDFHWXpxU1NYMmJlbVpwc1pUZ1BrL3U5TldE?=
 =?utf-8?B?TSt6ZVpHaUxrcitaZjNpTWM2TEc4QjBZb0d5cU5jYmJBUEFMcVB0VXdOb25z?=
 =?utf-8?B?TU5FdXY3M083U0JnM29CUnJwdTZWUXMrT24yQTYySld6TEhpNWV2WHJDLzhE?=
 =?utf-8?B?ZWp6QWJIbWdSQ21TRjdZZk5YZWVYdm83WS9xSVAxTUVMM3hTS1Vra2RvNGJ5?=
 =?utf-8?B?bUJBaU9yalBTeDJDMU05MjFHWGhaUkRqR2VUakhjWFpBTG9jTytscU9lc3pu?=
 =?utf-8?B?a3hTbHVWcFJHMDlwaUs2OHBpTVN1RU0vK0N0QWhtWHowUnIvZ1Z2QzRLQ080?=
 =?utf-8?B?Y1MydmZndllHMzl6eTMxVloxeG80dkJKRDJHUW1MOG9IRzJmQXROT1FxOTND?=
 =?utf-8?B?dzN1cTZ1RWNvc3ZjS2h5R3pjUHF2VVpRNm9scEYrZ3FqMXdSYlhHYjlXNUZz?=
 =?utf-8?B?d0t5TXBsblpXcFFQVDlmeCtialQ2VW1wa1hOMWxzYjQ3dzR3K0xscGU1UXFo?=
 =?utf-8?B?dXloRldGT3VIZVhQKzhSNVgrMU5mcStrNkw3bHJlOG1WOStDSTUzSE9mUUFy?=
 =?utf-8?B?UDIxbmQxTXlaZDFRKzBBajZ2enpHYTdWWXVkVXVWNkthanlRVFl5QTN5MmRH?=
 =?utf-8?B?VnlncVlldmNWZkwwTCtjYk5FWXRzSmNlemsyZmJtdnoyLytOenNWV3B2U3dj?=
 =?utf-8?B?eldWd1A1WnpkdGlCRWhUMmpsclMzdnBVajdnellPM0RQbk1NNXNIYmRKYWFY?=
 =?utf-8?B?VmZabHk1ZjBLanhSOVh6ZkM3V1lTMTVtL05aUjZGR0pyVFNCQXVoTGx6blJT?=
 =?utf-8?B?THdBK0I1RGhkM1k5WFplY2JVdURWSnk0a2loNUk0V05zTTJKeDBzM05LR2JR?=
 =?utf-8?B?MVdKRXNEOEFLMHBtM25KamxhWDhQbktOUGtBVWhFWHVZTjczMUp0QVZOUU1a?=
 =?utf-8?B?c0l6QjU0eE1WZVFjd2R6eVdoUGkxU3ZlbXBmcW5XMzNBKzIwbkJnb3dYVVhu?=
 =?utf-8?B?RDNSdklkMlBWZ0Jpa0JhNVdIZ29sVDJHZGYxeENZL2dOSUdhMllpWTM4YitT?=
 =?utf-8?B?Lzk0V1A0bkhNZDZCcUh3SHRQUCtTaTMzZVkwNWdhL21TakhYWG9RVW5IVms3?=
 =?utf-8?B?allIZDF4d3E1cmE5TFBQQXVVSmJsVno0YWFCSkdva0hZendKcVVtYWNMa2Uw?=
 =?utf-8?B?bk9pbFd0NGxtUG8ydHhCZy9IRU80RkhKcHYwNDRPczY2TEMwWjFpSUNpaGVY?=
 =?utf-8?B?NEtrcHVFTUtGTEtjUUhjL3pWekkwTWMxYU9ORW5WOUg0K2lzY1ZPRkh4VGZn?=
 =?utf-8?B?ZGhVY1labmk5MEphTnA1bUVaeUFsUHJHMllNenVNa1dpa0VSUTd1anZEeERC?=
 =?utf-8?B?MStyQm93K01nRGNxRSsvZENkQ0Q2SDA0enlBaWhEVEVlSUxCcGhiY2l4SWJ6?=
 =?utf-8?Q?oYhIYL8suaYctf+H8N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f205b5-55b8-4555-07b6-08df096f5b0a
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:56:38.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+NRW2DjTQpMB6OXrvuUdfySFM6jxCG2K38K17/xEXJX/P6lRWMC4L6ShIy/q9hRIOkYxUcVBVtHoWQq9luTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771



On 8/19/2026 4:42 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/7/27 21:29, Suravee Suthikulpanit 写道:
>> When PCI attach reserves a BDF already allocated to a vIOMMU, relocate
>> that vIOMMU to a newly allocated translate-device-id before marking the
>> BDF reserved for the device.  Reprogram translation DTE and VFctrl under
>> trans_devid_lock; roll back the pool on failure.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/trans_devid.c | 116 +++++++++++++++++++++++++++++++-
>>   1 file changed, 115 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/ 
>> trans_devid.c
>> index 9d7d93c5dcdb..6fb1ba3c9444 100644
>> --- a/drivers/iommu/amd/trans_devid.c
>> +++ b/drivers/iommu/amd/trans_devid.c
>> @@ -82,16 +82,120 @@ void amd_iommu_pci_seg_trans_devid_fini(struct 
>>
>> ....
>>
>> +static int trans_devid_relocate(struct amd_iommu_pci_seg *pci_seg, 
>> u16 from_id,
>> +                struct amd_iommu_viommu *aviommu)
>> +{
>> +    u16 new_id;
>> +    int ret;
>> +
>> +    mutex_lock(&aviommu->trans_devid_lock);
>> +
>> +    mutex_lock(&pci_seg->trans_devid_mutex);
>> +    if (trans_devid_xa_owner(xa_load(&pci_seg->trans_devid_xa, 
>> from_id)) !=
>> +        aviommu) {
>> +        ret = -ENOENT;
>> +        goto unlock_seg;
>> +    }
>> +
>> +    if (aviommu->trans_devid != from_id) {
>> +        ret = -EINVAL;
>> +        goto unlock_seg;
>> +    }
>> +
>> +    new_id = trans_devid_find_free_locked(pci_seg);
>> +    if (new_id < 0) {
>> +        ret = new_id;
>> +        goto unlock_seg;
>> +    }
> 
> 
> This has a type-truncation bug. trans_devid_find_free_locked() returns
> int and signals failure with -ENOSPC. Assigning it to a u16 truncates
> -ENOSPC (-28) to 65508 (0xFFDC), and the subsequent "if (new_id < 0)"
> is always false for an unsigned u16. On pool exhaustion the code would
> proceed to install and program a DTE with the bogus ID 65508. Please
> change new_id to int:
> 
>      int new_id;
> 

I'll fix in v5.

Thanks,
Suravee
