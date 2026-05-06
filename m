Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012001.outbound.protection.outlook.com [40.107.200.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88314224F3
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044624; cv=fail; b=q8CQQ0sNZU87LXwzpDzgX75ax9MVpIKvb3ZHWHyW6uwxGepDU2Dg0bAHrNdJSHh3H/NJ+GCkqz4Zl16l92cXtfIPMthbQQ0e+8cdO6PKxlw/VlOWy8p+PEv7mMAqPIQdOMJAPZRGNT/GeBP/1q46LJB0q227TqTxBVWZVFxnDOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044624; c=relaxed/simple;
	bh=efNTtKst3ItJAtDPtpfB1jb8Zp6f0x7NvkVENl7yUiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evSd6866Q1d96VNtSS78gcNe3iYG/hzGiomfmNfXFMjUSDk5vwT1rYyLm44NTxFKDN9eSGz/4byBuqT8DN7CT5otH6beiqbYlCLcm8eaM0ipiAQMiuvOImkEzj7BGzYKU9rqi/ZOmuIKSaFSPd54u3X+oE5kLsl8QII8CKsMNI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rn0LbZqo; arc=fail smtp.client-ip=40.107.200.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rn0LbZqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvrP//y+0YKLG+v4CqutcvVcCiiZDX4B9HmO2vqhRVUFmKaG4GEJHXb2ryp4OH67ScbtPB7fkHmdE/ztUXXYsRDcKHlaQg04viEBqDeAg31Y1jyAabFlf2WaSU7Cgg63by4D3I44Qv3+BzjMIpuyuKhRf+sWRf8ljWT2P+2hoQl/534Yb2+OmPlnTAjZjMtA19+Yw1qeIL8yoRAAXsE9J0erpn/wHQT82Kwn0Zu5X6ACu9bt2lnC3zXXyV8weTKUJ5Oi35iwHLn4jAJMpjehFOFkOBOIpXaXIhAnqTrbYeFTqh7jHmbsvSeGQShAK8o/YdrRHDAQxFb+pkDaTlLarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGGd/Y/8NNlK2HIYg6zKgWqLtV5J/cDb9KJS700Pc8w=;
 b=S1lVYv0Q/DhWq4d53tN5RrpcQgHa2UuXF52Opwh+80XhlHPnQ7iIk79p/SrJ8nZT3L7BuUU4ffGkxw+d6JTjgL7+qSAAlUFuVWzlDuE7HNDlH/af3z6iEQLnqHG2twoUf4u3oyLgpCI+WnnlRE4+txsgoVoZfyJihz1bEth4Ac3mOvEgN/7yQegM1Nnewb6XOzvqcHapemS1F9q6ZKkm/f08AnZMKXSdYSest6mVPsAiHsFGUNkqQLYS4Sc0flZqZ9ZUZpK4CAS3/OUGM74QHl0hUPoq7c405tWw297TZCWONweEIJ60CPleIx+B4lOOFq/X+idRC4lTCRY3pa0LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGGd/Y/8NNlK2HIYg6zKgWqLtV5J/cDb9KJS700Pc8w=;
 b=Rn0LbZqorBa5dGlu9ssPwmUZT9n5mqxs9LrDRp4YwIPTnx79BJW/fX1mP92k1EEKD9bVEH2r4FNjv8yMJ4Y43k3kEwTGDm127YkLf5dkO///Q00eLmTB5nw9qBMHkd2f9qN7J/7j5/5IDtS1jMUYBLKYiisCHwOLZJuzR+KWqsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SA5PPF6407DD448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 6 May
 2026 05:17:00 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 05:17:00 +0000
Message-ID: <d7462873-9476-408c-8f06-9437ba3c9586@amd.com>
Date: Wed, 6 May 2026 10:46:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic()
 when in legacy mode
To: Sean Christopherson <seanjc@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20250315030928.2373250-1-seanjc@google.com>
 <655fd173-5dab-40c2-8f77-8b3e891a1c40@amd.com> <aforwTPix7Q_ClTO@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aforwTPix7Q_ClTO@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: a987d543-e141-4ae6-f268-08deab2eb361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dbnLgPj0L8ahQqhK6HVORVxKZjXKD18Noq1+/ZpHiwbCBRmU8UcWzeSKOnoImj1nOpZT+JbENVXo2wCKKj+mrWezCncF5S25KvH/ReJVNwNynzoaKKdpATtnyg1hXWCTSx268i0pMZHrqYBVd9T/gmNIaUk8UPeAvdMzA/bACpEyeLF6Lb9Xwh9+cfzOWzEs8t5aoU/39bpoT/vHBk3Qt4l1kvKJehYPIHXQJG1AWYJFP6+MWZEwM0hacQ/t/Po5riIEEkk1aTeSmjA84pLwYJ53gHwOvoLiGyzojc1jGQJ0BwhWVOGEzM9k1nT+I7yrINH23nVSFZ0hm9ykc0goTTngAz0dHXkGni9FwwOr7jKcnMlZq2TIMw8Cch7XpjGR1EV+yUMbl41iDzTB/yRhStNFleBpkiBuTPusEs3kWsOd5R2ZAZcicgwgUs8ue2+dlfHqZQQqPp49HrSNkiAlEDt8q4N10gZLrcGDUb+1vvSXaGvQT7cIPyiw5z85G6GblxG2QHkti//2ahAfs3BjPgGo86Nxcsxz1MFlYrrxudTZPyIPuf7wsum3cZQpx2puJ3N+dY2GrVuL7QuOsP8jICYA6CEZlu/fQMiSHi9cKnfwoE8nckj370o9cDqAuhkfDVX+Fxo6DmCMMf0ycDNDI6xXFDgicJSf0wUOTQ7910V7mK4qmzw2p0yXd3dLHRnF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkpxalNRMHFLMXFCL2VqdFA5c01OdkVuQ1VNWTFla1dnRlZYZ3BxdXhqcjN3?=
 =?utf-8?B?eHM2aDZvZ1J3NkRGZkxPNlM3QTk1SjZMdUFZTnkxRk91cFJIQTNLMDZMaWZY?=
 =?utf-8?B?czBIMzdWYk50STMrbE1ZdC9Bb1N0VHZWQXdsU3pJZzg4ZWJLaXVGQlJsQVVO?=
 =?utf-8?B?SE9sck5wY2lOWXE0WUJDblRKMDZJY291cjJmVmpNT2daUENFUWloZDd2NzBh?=
 =?utf-8?B?Q2RWZjkwd1hyMVgxSHdxcmNnNFNvMldUWmJ5S3pJMGgrTlNWRWZyV083ckZz?=
 =?utf-8?B?dElvTDBONzVTVFNkblBDdmxTS25JdW82RTBSclFDSDdaZ09FRHd5N3JpNjlH?=
 =?utf-8?B?TTAzaDBSQ1dGOTlZVkthVzZKZ0xxUTg2bFZrTEtzOFhTNHpELzBNbjFESnpa?=
 =?utf-8?B?azBjcVExYzBtWkxad1VVaUZ6cmxMeXFMTFJKVXlTWWdNazRBMjA1WDF1Njh0?=
 =?utf-8?B?U3ZsaDJrQVVvdzRaN2xsMzVQcy9Wem90aFp3QU90aURHQVQ1dVdxMUdYNWJX?=
 =?utf-8?B?bThhWGNRbVByUk1UdUVUend2RDN0VE0rZkZhSTlTanF1dXJiSjlVbTdVWHVG?=
 =?utf-8?B?azZmUEdiWlE3OWhib2NHVmFOMHpYRWIrb09qckpRQm9VL0tpYUF3bU9uTytS?=
 =?utf-8?B?OE5reCtqMEU2WWN0aVhPL1ZLZGpIdktyNUFoaGNWT1A3WUpoam1vNDVzbnZr?=
 =?utf-8?B?b3pZMHM4MktmSFRiUWVMN3dHbGxIcGtWN2ZBNFljck1rQUVFTkFPUXFWRE5p?=
 =?utf-8?B?dmlqRXNYMXVyeXM4WEF3aS9aZktvQlA5N3g4SFJWdkJSYXlTMTVWM0k3ZlRE?=
 =?utf-8?B?eG5ra1pLazgrL1U4cWtBL3lLQmZmMkUrV3U4UVU3bE5sZU9iVWcwdDM2aWFa?=
 =?utf-8?B?SVhuV2JjR3lLZm5ySXFBZStHRi85c1dSSXRvNkE1VVVkaHJvNDVCbzlsK05i?=
 =?utf-8?B?cVdJdDFITXNjaThudDROU1diSVNoUm1SbEFsWUc5YUNTM2kxTlB4Z1RqV0Qw?=
 =?utf-8?B?NC95dURSYnNreW53MENPbXd2eWlRa1cxQ1o3OTYzODRpR3c1YURTL2ZkMGc2?=
 =?utf-8?B?dnU4OExGcXVJSGFmUG82TnpKL2EveUtMN1dDMlF6RklGdVV2QThSWG5NQS9w?=
 =?utf-8?B?cFJLQ2RscnMyajBWWGJ3a1l1UGplWkJ1L01Dd0VNQ2pTSG9rSzRvRGoyR2Qx?=
 =?utf-8?B?MTFOSUNNV1dNWjdWMVYrKzhPdzdpa0tRZ3BYbTZYR2RTMFFpbG1rRjR2Z0Z3?=
 =?utf-8?B?b2JvdWZEQk85dGFZVUR3MURyZWlJV1lZSWZjdmphVzcvRWR4VGhzNXB5MDRU?=
 =?utf-8?B?TDJtK0JZdFV1S1VXdDdMMUVCdi8wa0lOU3NOSVdVWGIyREIzK2lnUWxMcWNV?=
 =?utf-8?B?V3UycUI5OHBOZmpPNHpPS2x1S1UwR0E1MUpXQlBpVDVlMmNFMzcxc29zdmx5?=
 =?utf-8?B?OFA3UDY3eHkrMUE5NjI4bFR4MU9RRWlrSzRpcnd6VnNIK3JnYjNQaVU2SHZO?=
 =?utf-8?B?bUxYSUNrbHBZOTZYdGw1ZWdOVGFPTnE0TDBLRmxpcDdQSU1YYkxuNm9XdUcy?=
 =?utf-8?B?dDVzWG5zYmJuakozNmtIeGxtR0NXbW1vN2I5SnRjMndUN3l2aXl4SGhxcGRJ?=
 =?utf-8?B?RXB0d1R1SVA2emVDY2tIbFRDYXBEdGpWSmFxZU00ZmNWekEzeHIvaGY4bVZ1?=
 =?utf-8?B?Mjk2akIxbGtqcG9VVE84RklWYkNnNmhHQVI5bkk5K3pmTWtpNjNCSDBjUUlH?=
 =?utf-8?B?WmZINjBnaFdEOSs0U095VWRxZ2ZYZ2VBbnVzVndTbDg1NktoZDEvbjg5RXFz?=
 =?utf-8?B?QnUwci8xZE9kL3ZpM0o4N2RNQUJkbE40MGw5OHRMdGJsRTA2Z2JGN09zYlhG?=
 =?utf-8?B?YWdFejlsSUlJYmJmNFErY1FRQnVBbmlOSE1SNjZmUmRGL1FuZzJEUVgwa3V3?=
 =?utf-8?B?SWdKUC9KZldFbm5tRHpGQ24rU012RXl5Z0ZlL3QwMWNtU21IOWlwSzI5RFYx?=
 =?utf-8?B?eFJvaG1QUDdSbDFUeWRMWk4rM2h6bzQ5d1J2dG1rWWEwREJqdVZERzVHYWF4?=
 =?utf-8?B?OHkzQUhQdnllN0hFRTk3RU9KaGJpQjBqSmVEQzBwRWkzdXh3eGg4Nm90djA4?=
 =?utf-8?B?TjZJUWQ3b2JEL3pMZnR3cUplR0VEVWFBNHhCZmRMcFFaVSthMGV2Ui9XRHA1?=
 =?utf-8?B?Y2I0RXN2WmU1b3Y0ditJR0lRTkFKVmN1ZVRmMnN4aW14ZEdwSjltc0g1N3R6?=
 =?utf-8?B?cU81amNhbWVjOXg2NUxuUm43NlBURGZ0TFNXOE9rMHQvbjE0Ti8wSkdsb2Vo?=
 =?utf-8?B?L05kY3VCUFZTU0lteGl1eTV4bytJeE1KeFJvQ3Z3N2Z4akFzNkFadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a987d543-e141-4ae6-f268-08deab2eb361
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 05:17:00.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0URoXVqea3fWG/R6S+HX+ertA7b4TM/H+HSuJYKMRGFeLAY5T6sko3VZwbDS+3+pgOXhWmPB0yeW+lF3fHRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448



On 5/5/2026 11:11 PM, Sean Christopherson wrote:
> On Tue, May 05, 2026, Vasant Hegde wrote:
>> Sean,
>>
>> On 3/15/2025 8:39 AM, Sean Christopherson wrote:
>>> Bail early from enable_iommus_vapic() if IOMMUs are configured for either
>>> of the legacy modes, as it's absurdly difficult to see that
>>> iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
>>> skips allocating the ga_log.
>>>
>>> Opportunistically have iommu_ga_log_enable() WARN if it's called without
>>> IOMMUs being configured to support AVIC/vAPIC.
>>
>>
>>>
>>> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>  drivers/iommu/amd/init.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>>> index cb536d372b12..05c568da589a 100644
>>> --- a/drivers/iommu/amd/init.c
>>> +++ b/drivers/iommu/amd/init.c
>>> @@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>>>  
>>>  static int iommu_init_ga_log(struct amd_iommu *iommu)
>>>  {
>>> -	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
>>> -		return 0;
>>> +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
>>  +		return -EINVAL;
>>>  
>>>  	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
>>>  	if (!iommu->ga_log)
>>> @@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
>>>  			return;
>>>  	}
>>>  
>>> -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
>>> -	    !check_feature(FEATURE_GAM_VAPIC)) {
>>> +	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
>>> +		return;
>>> +
>>
>> We should move this down after SNP check. Otherwise we may hit WARN_ON_ONCE in
>> iommu_init_ga_log().
> 
> No?  enable_iommus_vapic() ends up with:
> 
> 1.	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> 		return;
> 
> 2.	if (!check_feature(FEATURE_GAM_VAPIC)) {
> 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> 		return;
> 	}
> 
> 3.	if (amd_iommu_snp_en &&
> 	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> 		pr_warn("Force to disable Virtual APIC due to SNP\n");
> 		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> 		return;
> 	}


Right. I missed the return part. Thanks!


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>





> 
> 	/* Enabling GAM and SNPAVIC support */
> 	for_each_iommu(iommu) {
> 		if (iommu_init_ga_log(iommu) ||
> 		    iommu_ga_log_enable(iommu))
> 			return;
> 
> 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
> 		if (amd_iommu_snp_en)
> 			iommu_feature_enable(iommu, CONTROL_SNPAVIC_EN);
> 	}
> 
> And that's the only call site for iommu_init_ga_log().  Getting past #1 guarantees
> "amd_iommu_guest_ir == AMD_IOMMU_GUEST_IR_VAPIC", and if #2 and #3 return early
> if they modify amd_iommu_guest_ir, so it should be impossible for iommu_init_ga_log()
> to be called with amd_iommu_guest_ir anything other than AMD_IOMMU_GUEST_IR_VAPIC.
> > Shifting the initial check down isn't functionally correct, as it wouldn't
do the
> right thing if amd_iommu_guest_ir==AMD_IOMMU_GUEST_IR_LEGACY.  AFAICT, nothing
> prevents calling into enable_iommus_vapic() in that case.

Right. I will add fix to move #2 to iommu_init_pci() and #3 to iommu_snp_enable() .

-Vasant


