Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1353FD31
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953176; cv=fail; b=NBoZjRBTVAW0XlS0lhGuHYCqm316gUY3NzKwr7jVGj5BI8aK59Uep0tUpVIWp/JrJrV9s6qSga57/1jagCKuJtNOHElLjL8b4OQHAPI7SwUv35jCGDMQa3+h9HcoM3sv9DLwI59DEOYSMqeTnAga0XS9UcdraeYtUshwt4vC7OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953176; c=relaxed/simple;
	bh=FDTrRCnqTrNDRmKK7hdWYdm8J3rcH1S+BmV5JLA+eZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5UfjQ1CbljunIPdmQHk9/0qzVoLH87mXPlRPY1gIhYVTddYQil+l99J1n3MrgplX16uOdnw/X0pN0CcMjK6YE/hxc6lO56FYkRZ4iJ/NomNxS3hTYzlfncKbhhhyC+pX61xt5KM9sT3A2y1EoNldiQdAuFpU5/ISDxn41D1jN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vtsPv/4a; arc=fail smtp.client-ip=52.101.46.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vtsPv/4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzY+udwE1PodNNMflVUi7JMvjwYgYRbJa8bg6gxH5SBiJevEh4LG6eVI1447RO1jMuqg3dK8ntpvl7VFplOne+KZsdUS63tXiGHnoXzMSXBKSM3bPK6+8zG4QfX0PEkwith69TjSgbcSqnRn6+ORX+xeOoY31Q4eX37FQmsL1Mp2bU3lmZZYIzhC6kNr/AwxMxAqbnxL3+Zr6WSROzabS5n9FVs3S8gNCqhcTlmBzNfQ7yMW6dxadTmPenwhAlJEpFpVtpLzaqb5/pUtPNMkHvgHR+5p268yx4fGGcc06eCO9WWZJdrjGkmiWKTh0PDTEt3jptB5r5c3hbItuTeZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v761CJJVy4dXSGloAI0KpOmGtnCMW2ME23J5OpEPDcE=;
 b=b4Ud1WvYC9yPfuOSAZ7tvEDFAn7VQAByEYULmfrAIQmvouYBjhWguKJARJgDOld3BLERwWFcvK4QRtcWuoG9GTks0E3NF6o/gD1F/TgUXp2inbdy7D5SUnTlUan9PBw8WI+oJOKRZ/7ZUzHOix+Vv2i0mNHw/5FFCXDgUJ+Dq9SdgCIfW6E7JdxTqBMkWdRXJ/3PC799NXZIWV3QZ8icWxzf5heX28Db6DuHi2PltkEujUHnRXtrjhWF3eHUX/oU0eSY2asFvBTKAGor07VG3n601gxZup+pppHeqQxwf84QoFb6iYEpqMwqcQLvR9/s6xHA9tOczVYk8Zf4OTK3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v761CJJVy4dXSGloAI0KpOmGtnCMW2ME23J5OpEPDcE=;
 b=vtsPv/4aBMADNCtZbdYoi2vzw1iBfaqzK+cPaYb+YSNtJwKsIta3Ns0e1Iv2uQE+TNU+Z23HvkCUM1CQKqDcH3YoILv1ZX5kFgOsBMRMuLrTcYKNMdAZ7Eq3a4rQCSKXB5bkqtCgBc5tmAJhwxAcloIKrFGklwK3Zvfi9bEZy+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH7PR12MB7353.namprd12.prod.outlook.com (2603:10b6:510:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 11:26:10 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 11:26:09 +0000
Message-ID: <672815f2-089c-4794-9517-1b0f2d17f858@amd.com>
Date: Wed, 9 Sep 2026 16:56:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Timo Witte <timo.witte@gmail.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
 <yq5ao6egyn5j.fsf@kernel.org>
 <BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::6) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH7PR12MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9410a864-77d7-46da-395c-08df0e6525a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+5WGPwVwZGLY11my+0bkt1d5z92KFysr76eylOo5VIk3Xan1HrPbhYAMA8Axnj+fpc13vkf2uDY7N1oQLctyH3D5qPmIPxEXt9EElUTXxTy8kWSja3wRoraeuRoDccrIGsTXXs6+qlqhPhMYQw7nDNnMIJy08+GSMxuQq1emOx+f7G/25R1Tz0oS7D/i97bTGOOxmbp/fLQnS0RZs3HiZOjp+yZ2xCwWF0CCGaThi97Q7PHVIbretouwBIR8hrAl5YCWRqRA2iOmZtazF++zpcdI/VBQk19VStb+gcHNa6K/4B+RABQozBTTTeR67Q0IpcK7cvl2DJBTKcRn45Om9ZFSFKrAALVvqhmZ9HMQAl2N0yUPWnjah/edwMHQqWgx6ejRVd6ExWxWQRHKmuV2PHk8iPImiQ0lpChTkSVXLpyYGFvS4R1M/+u+kLlEabDOtByl7TC0sTNWZ65eWI/shixnKVsa+v7i5HaFfR5nEfQefG52phaYuIqVKUaqsoUZaLq8WF+lBGiOB5FJ13v0yVRUGIxwTcv03IA4SGfTy3wpgsQKL55EZYOs+2rJNyuVxVtSZTXdcK+f5m7j4yJWxnY+xfSl4DnlrtTkmS2EKGuObFzmz1wrM4YTstgRjkA1kJvbWimrL8OqY2DRzh+dbEIfkCCyh9kKc7eZJy1k3sk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlZvYWRRNEFmL1U1Uzl0Q2d6TzQ5THhSRzFPc3IyR3ovTElDSVAxL0hkdHZp?=
 =?utf-8?B?cGRsR2dVTDhsdHUveTViekY0RzZleFA2Q01BbkhVY3BJVTkxbzhxZTFPWDUw?=
 =?utf-8?B?WDd2ejFYTkp6TjRXU0FyYWtxdHhpSGpyQzlQNTVORERMS1NFTldobitGQVRY?=
 =?utf-8?B?U2F3Y1QrbzE5dUp1bFVaR2Q4SHRsK0kyKzdnMWsxbksyRzBYbmxxdXlvZ1A0?=
 =?utf-8?B?azRnN3RtTXJYdXdyWDVzTjBNa3dEanBqdjgzb05wc1dEMWYzQjhPTVYybXJo?=
 =?utf-8?B?dVBjRnB6Q1BWNHZObjdYUVB3VWtaY012dTYvS0NvT0xHR25NRldJcTF6elFC?=
 =?utf-8?B?NlRDZGFuMzBoNXhGeTdPZzU3NC9udEh4N1BkWXE4RExMQzdlVFdGRWJwTGFr?=
 =?utf-8?B?MkxEbWM0akJoZ1RVUEx0UW1uV3kvenl3QVkyQnkrOURwZ1lkMUVidHFLZzZi?=
 =?utf-8?B?bURDSUNPU0Jrb21HczhYbkkrbEZXQk1NTUQ0MzM3SDZtcDM5MmJvdjQ5ZCtP?=
 =?utf-8?B?TTAyNytTUVJpNWRsSWkrRStrQWJDN0MyWUUrajk5K2FDdFFzamJuY0RoRVBE?=
 =?utf-8?B?ejVLWTc4M1ZNNlB4cFB3azhsZVJIYXJVQWZIT3pNSTloeXpUamY2aVJXUVFt?=
 =?utf-8?B?Rmpzc0IzcXVTaWM4ZHlLcUFkV2pHZXI3MzgyUzlNNDljN1l1TDZ0RDV4QXpw?=
 =?utf-8?B?UE9TMkNuUFdyU0x1eDlsbE1La0g0MmtoRGtIUEdWTCtOdjh1cGRsbG0xbEtK?=
 =?utf-8?B?MHJDWU5mSHBqTGNwY2hHRFpIQUZpVWhtcWlJZk5xVXFvcDJadGVTTi9ZQk1v?=
 =?utf-8?B?KzZ6T3pHTmRZYUVqbXQvVEtVSTRNano4TDk4VERtT1RLQ29lSVJZL1BNZ01m?=
 =?utf-8?B?TWdpZmV0SjNmaEQ3dWpQY2xJL0dsRzVzYm96ajluaWhFd3lqcGRNNjB5dm5j?=
 =?utf-8?B?RzVBbG1CSkdFcTdhb0tRSW1mRXpyeVFRY0tZdzZ1Rjh2Z2xhekdXL3U2MzJj?=
 =?utf-8?B?Tm9kMjI4TXB3b01jU3hYQzJGSGgwMU1mZHFscU1EdWh6cmxSQXpIVXcxV25n?=
 =?utf-8?B?ai9WNTB1a2k1SDRNUFpWekF3QjZPYkhIMHdqVDFjWkNRbHhCLzdIV0hiRGdJ?=
 =?utf-8?B?aGtjM2s3b0hjWVV4NUdCa2F5Wk9JZ1J4RlRvN1dLYUpPbkdFT25SM2tLQzR6?=
 =?utf-8?B?bXhkWm9vZkZQOWt5VUFMd1Aya2srSHVrOVA4RWtwVWh6ZTdMckwzL1llb3hi?=
 =?utf-8?B?NmltVDNJeEJPOFJTOWU2UFZFZmN1RGlVbjhpK2dMcGFPZ2FBSkg3bGluZmd6?=
 =?utf-8?B?OTZVK3E0MUExNi8yTm44SW0zQmFxa09UanNTZGRhdnpsZDlyUE5XZXNjdFN0?=
 =?utf-8?B?KzlySG5kZUpuRTdSVlNNS0tzSnhLWDJEaXBrUVN3V0VKQ2t0aVI2S0pobE00?=
 =?utf-8?B?TlpHQTBpTEpNM2ZOTEROeUJWRVpnM0tKOTNKTk5CNHY5U1JtOVEyMmZpSU10?=
 =?utf-8?B?RTlvRGY1UnZBVzRZZm5ya09ZTTluaDNEMndzNUIySEowVHQyd2JPckVoc2RQ?=
 =?utf-8?B?clJVTjJtNlpwdjdVMmwrajNORjMzMDdmWDAzNFlIZTIxNlJKZTIzZ0xjbXcx?=
 =?utf-8?B?WU9LMVlRbkkrY2ZVL2hWUXlJbklkbVlOOW9HSkVEemRPelhSVkRsNExBaks4?=
 =?utf-8?B?d3p3Z0RjV29RN0ZlRXFjWVBXazFkVXA0RE1WNTBoMFV6SjY5SlBiM0JWeXVo?=
 =?utf-8?B?dFN6b2t0ZmJwRUNYczJITjV3T0xxV0ZZbnROS0lDbnFOcjJtU2FIdk9sUW91?=
 =?utf-8?B?SFhmNnB1anVFcGFDODJQbDIxS0FvTmxKSXdrVG03SGFyRjduYWpRU1FTU200?=
 =?utf-8?B?WHJUaVNZdjJML0RzMkhqSFBHZ3phRFk1eFpnUzN1NVpySjA0YXJTREFYbUhz?=
 =?utf-8?B?YzFYMVlhSi9hU3BpVG5BTDl6NG9FRkwrY0FkSGJWcnhhUVhOMFB3c1R1VHVB?=
 =?utf-8?B?cXpiMlBIVGdhNnBZS0hoMFlDWlFtK1lOYTJkc3FZY2hpWWZESGdZMFRkRHQ1?=
 =?utf-8?B?RFdOZk9Uc0F0aXlaVlRvdVRrU3NFdnNxRzFPUXZsaUFzZ1FXS1JTWHg3cUZ5?=
 =?utf-8?B?VzVyMFo0US9vVktFcmdIRUEyQ1lFekl2dWRqVHE3L1I2RkpTWFRKYkFTT1Y0?=
 =?utf-8?B?NVpSam5ybUZPZkVuamxtTXJOZ0ZHQ3JXbkpNMWwyM3hXanRiRWUxZUp1bElG?=
 =?utf-8?B?OFZGL1I4QVhFQXlBU0dORHJyMkk1ZXVVSDZnTDR3b2hpbUNBNm5aNVl5aUNB?=
 =?utf-8?Q?BO8uXmNfcy3norSyF4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9410a864-77d7-46da-395c-08df0e6525a1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:26:09.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyyxXOpUPpGodiho33jpFHDi6elMAbUGfKYh//+yFm4+VxDXPV4WHqMD5IsItuSNGIVyV8nBToCnUhUTB0logw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7353

On 9/2/2026 11:56 PM, Deucher, Alexander wrote:
> Public
> 
>> -----Original Message-----
>> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>> Sent: Wednesday, September 2, 2026 6:16 AM
>> To: Timo Witte <timo.witte@gmail.com>; iommu@lists.linux.dev
>> Cc: m.szyprowski@samsung.com; robin.murphy@arm.com;
>> joro@8bytes.org; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
>> regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs
>> (commit 8277a12d0d60)
>>
>> Timo Witte <timo.witte@gmail.com> writes:
>>
>>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and
>>> select them via attrs") added to iommu_dma_alloc():
>>>
>>>     /* Not yet supported */
>>>     if (is_alloc_cc_shared)
>>>         return NULL;
>>>
>>> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
>>> force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an
>>> AMD GPU with a 44-bit DMA mask hits that condition, so every GTT
>>> (system-RAM) allocation fails with NULL/-ENOMEM, amdgpu init aborts
>>> and the system boots without a display.
>>> IOMMU in Translated/DMA-FQ mode (iommu group 29).
>>>
>>> Before the mentioned patch it worked: the IOMMU PTE carries the SME
>>> C-bit, so the memory controller transparently decrypts for the device
>>> while pages stay encrypted at rest. For IOMMU-backed devices
>>> force_dma_unencrypted() is a false positive - the device DMA mask does
>>> not limit addressing once the IOMMU translates, so CC_SHARED should
>>> not be auto-set for them.
>>>
>>
>>
>> This means that, with host memory encryption, DMA does not need to be
>> forced unencrypted when the device uses the IOMMU?
> 
> + Tom and Vasant.
> 
> Yes, otherwise most devices won't be able to work with encrypted memory since most devices don't support a DMA mask large enough to cover the C bit.

Right. With SME, currently AMD IOMMU driver always sets C-bit (encryption bit)
in IOMMU page table.

-Vasant

> 
> Alex
> 
>>
>> modified   arch/x86/mm/mem_encrypt.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/cc_platform.h>
>>  #include <linux/mem_encrypt.h>
>>  #include <linux/virtio_anchor.h>
>> +#include <linux/iommu-dma.h>
>>
>>  #include <asm/sev.h>
>>
>> @@ -30,7 +31,7 @@ bool force_dma_unencrypted(struct device *dev)
>>        * device does not support DMA to addresses that include the
>>        * encryption mask.
>>        */
>> -     if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> +     if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
>> !use_dma_iommu(dev))
>> +{
>>               u64 dma_enc_mask =
>> DMA_BIT_MASK(__ffs64(sme_me_mask));
>>               u64 dma_dev_mask = min_not_zero(dev-
>>> coherent_dma_mask,
>>                                               dev->bus_dma_limit);
>>
>>
>> -aneesh

