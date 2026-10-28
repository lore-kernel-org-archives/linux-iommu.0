Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793167974;
	b=DGEBPxVmQyaIVK2Z5zAM8agIcdyx35xsyI0kztw8s9qWnrB/6ywzfW6DfB0FWvP6UD0L
	 vuQkCmYDo1nzeIdB/9ArwCtusDJQXlnPRMreE3oIQJHYsjXIdI20+hM5i6kod5Q35GMhH
	 Q9gstaO2SlaPM7q6Dyo1lnGDbusCdrP10L/+h7tEa9L/bL3tslUH8lQU5vb8UNcbJ+ebg
	 LM3ZfxcAnAdxTKpBjQ2vl0wvaoOQChUjDOv5NZdoDD42oR4WrPAFJ3vhUSndj7A+fg9ru
	 +7EZDwV5tmXUSirrCCsS6rMVk4DfrUOPkxnMeYBYvbXTiRqhXP0BoTE7wyHWELcT7pA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793167974;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pL+r55Xt7v3lR3kZIg4ZwURbqxlmqoiSFb3+igLpt6A=;
	b=Botq2XBePxAe+hcdF2exV2kF0/0V+suo+jvGEnXYuHuZs3W/62ZgYScbXo3/tjBgTNsv
	 kmYxe5qIFggc+gmaVgoJ2sLdSSxec0wlviIJR7eocDaK5dUuT3E3MdGafauwXnocSEPtq
	 V6nDhyRxL7PD1il8boYTeTmfaWs0F/NERdDNXKj5JNWEqPvTc+/QqN6GYw0Z4r7WJXiGt
	 toXs48z6qh7YRBBmxukyULcGGTdUj6nKnaD/NReA5cKKusmM/RKzXDJcut56IweIVoQnO
	 kMV0BW4Rh8HYCrWRuhOIgmfacHQGt37hqFg9t9wleuAsIi+ThVb41cKBxL6hO+Yl8Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JZOsi9wl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.58
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4698606A31A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 06:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4698606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JZOsi9wl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPpqRy5kH0TwZwDHiPMoi67/1ZXIBAZdnJ8Z6o3/KMxrcpXJXdrG3txn47LDiTxg4O+Fs3eWW3HvYPL6oHg+f1fTuJ/nW5lPN0yF24Bqv4SXlRgY2CbamtKTXaizTbub2I881Nqn6V0Ma5UtNGCk/fiutzgv+aCs1AuQI/xUIfrfT/O03nnpySAlby1fPhFX1dPB9y/e825Ruk6hnBk6I77VhUJToubVEZbuGY3RMb9IhkGevzuFa0AmcKHuxpHZu/21eZ905BeUEC9eY+sGcxklo4GKwDLoE8q18NeQ0KCgl0OVqJRrh4pBcvj7COlvvKWXNujwJRqvVUxL67ZAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL+r55Xt7v3lR3kZIg4ZwURbqxlmqoiSFb3+igLpt6A=;
 b=Uopr7klc2UZhs8HIxgrTuqFdlv3ErbDyb69gGl0HVTHImiHAZ8zDcX0b92ldbpD8qP5Tbxhnzb4pNU9c7POlsk+RdhSSLHwFa82LewXOTb+QQAzbu9VCV4C3WsOpmPOGu1VHF90hjnoodiqhtim0/s5qPA4TXiNG5Pch1H2j6FcYgLsUi7be3r8jB5DQz5D9GirQG/rjdK4tcRcUAjf4uoDyveFeRFnoMTJq2fYxDFh7mXNniG0LFvIzSjwfy5AS3cXszNFPAidiZa2k26ejMb+oBE5SC6hQZVyAjtJsgOZ9es77Z5sbuu3PlSIkeMsFCkLGNKl7d4y8w/xpmEGu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL+r55Xt7v3lR3kZIg4ZwURbqxlmqoiSFb3+igLpt6A=;
 b=JZOsi9wlxD+Bpg+VcAUF1la7kUTb45VPRjUgfBpzFvm/fx1rTfj4N1+EYyTmGjtTAXq6ZOb1MP2isdadM+z463bBS4kPKiiYiIOCjM091k5e/NPnbberWI2aCtGmws1UqkHQzOnKqDCjVIkzJBjDsvPQ+RPBMycPU40WYTO38ms=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 06:12:49 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:12:48 +0000
Message-ID: <63ac9043-0658-4535-b42d-0e29eb37ac88@amd.com>
Date: Wed, 28 Oct 2026 11:42:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
 <20260817135155.GB1415075@ziepe.ca>
 <d5e053c4-34d4-417e-ade5-f7f461f9e426@amd.com>
 <20261027182407.GH1685504@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261027182407.GH1685504@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::14) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: e32afa66-ea21-45e6-1ac4-08df34ba7db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	a2QY1AZhkxNXLkolVvxgpeF9lQ/+Ne5tH2ORQoxVRrzhAnAA/M9z5oQnhTDfmgTqmvmW1+8DZ/jxqP4OZMq4gB0i4ztcpp+rMbvTq4T/PvtvJPSZbaCBecrUi0Po79w8Ov1/hT8Wtsb3z4Uhe4+75tNpLGFW1ddKFA0DWF7wbizkCHEH+EtRYl7TUylDc+qtpYfpvRf1TbiaUz8v+fNIkbWCpd3ztIXs2wOuLY+CpDeGBoR6XHfrk9IzXgxuD3xyIc7bsEQsVuQy77O7sIPUadnlM4Uh52mcHutQ5GcW1FNqTqAzLOBypO9z5jc5iw2x8iZEW3Jxn6/2Y6wGbQfzo5tJZm2x+oIUsMXX4AfrJDwp2ujll8DVDyImA4MbQ8GVfg5iNgeaIvObhk62mFMCPEYzrqj0+zs3JXXgIVx1K4Yia25JY4fqajsRTl2YSjj55R4GOl7jiGGziO0iJdm4xPWta32yYBOsHBF/TjItmHj+AwQEaGOshB4Fd3HUDuG+jk09Ap/DfFz1SqfjUtoFdDVwALMMt2G+LYxwJS1viSxhpDMe2yoGMJcby7IZBsb0h+r1WYvw/+rTLf/4q4tgTlSrSpW9RUrSqmsbewFDJSjx/fTnWi2+DwXqyCFUz7g0H7cj1wuKe+F8jFD8IBMkqcvc4sguLEtuy0cTPJpE/h8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1AxSWFWWWFTWUo3SUhMUTJZQ0REa1hJcFMvcEZuSmwybHIwN05HSStyYXdH?=
 =?utf-8?B?RUZNeWRnN3p5b0EveFYvL1h5N0h3bFkxUVhGZ0VmcFhJQWZYK1hhSUs3Z1o2?=
 =?utf-8?B?bWMySi91ZGxIazFMa1Q2NU1QZUVIZU1hYUZBWU5wdHkxOXZESHRMVzBzT25l?=
 =?utf-8?B?YXJnUmdyQ1V5MXlsN0ZCR05CeEJncjY3OGQ0REh3UXdJbGV2VXJiUVlXeEpm?=
 =?utf-8?B?emZsNWRpRlYzR0xlK2x3SU0vZjFCR2dMVUF3clFZSHVUY2QraVpaVFNjQk9L?=
 =?utf-8?B?VVpDdVU1TEFVbW1XNlk1RmkwZzNNbzNZbXk1SjRHOHFLRDYrSUlsQ2wvYnJl?=
 =?utf-8?B?bDNhRFdjc2lYRTJaclFrWU1zK2w3OEs0a2ZtT3QvQ2dScG42NUJGZjNabmNZ?=
 =?utf-8?B?NkxXTkVKeWU1dTFVZnlnRFFvNVUveXl4dEJRWVZOdjZ1TmRsNVROSm5yaE56?=
 =?utf-8?B?WThmTjd6eCtGQjZuaFBTM0ZFeUlwa0ZCTGJPSXVTQ1lVUk00Q0U4R1BFcFZq?=
 =?utf-8?B?dmpQSE01UnFuTWlyVzJweEdKaGVuRnZ4dEp6dGtkS0djQjA3OEpHaml2cGhm?=
 =?utf-8?B?RTlwV0FjUmtYRzZLalN6dnJaZXZaV20rMytibldNbmY5UEIvbS84dytubTVw?=
 =?utf-8?B?bjNLb3JYbEFLZFd3UFluUm50QW1FMTExTDlzcWE1TlNQVEFDTHhLQnhsaHFo?=
 =?utf-8?B?d0VmdWpuR3RoeGEzdHlCMExYRjJPVUV4cjc5M2NYSWJ3WVUwaFZiVFZDQ0U0?=
 =?utf-8?B?TU1MOER1Y3Y4M2tmTHpVbXd4UUxYTi9LMTd1RTBSYTNsRFhuWU56Sm5YdGJr?=
 =?utf-8?B?R0x6K0J3c2poblZxbWUwNEt4L0ZDeFpsRlhsb05NdCtsSXNaZnQ2c1pMeTR0?=
 =?utf-8?B?ekIzaDU3MlZmdjdZNGNqMW1xbTJRYjRuVi9EM0x1V2hWdS9IMjNmMm5kbkpD?=
 =?utf-8?B?VUx5WjZMUjFnSTNIRlhTdGw1NEduQzZuQ1N5anlrN0NQOFdaYStXNnZoYlpM?=
 =?utf-8?B?bXRCdjM0TURRbU13RVdmbjhGSFQ0ZHhCQVRaV3h2WGhDd0NJNkRJeVhmT0ds?=
 =?utf-8?B?M043YXZDUFNjM25wRDA4aG1JYXNXSDVjQ0N4TS9Ed0VqenN3YjUrd0NjZSs0?=
 =?utf-8?B?b3ltMExub3g5VHBycVB6ZktJbmdmTitxNXA0Q0JaYmJJZTAwVkdaVjVJTU5K?=
 =?utf-8?B?TnFPU01aZ1dWZUsvSUkzUUlCakRhTVUzbWI5NkRITUpUK2h6VUJoUzhqK3ox?=
 =?utf-8?B?UE1NUjVDaGZFTmZmeU1xMTNPQk1YeE1lUm8vYXllUXpIY3dRdmo0MU9vNUlm?=
 =?utf-8?B?a3I4MkNwVGo5NkVEMnBlaTBKUmdDWjFvZjU2WFNMVWhmVUhPamRSenF5Zkdn?=
 =?utf-8?B?bGhxK2kydjBaNk53ZWVid3ZsS3k0K1BWRUM4a0FFNTlJODFvWHJ1WVBya1ZP?=
 =?utf-8?B?MUkrT3c3WkJVeDZmdVRsaUorcEE1Y2dnNlRLWVphakZJZFZJYXRXSy9jV2xC?=
 =?utf-8?B?K1YvRm5WM3ZON2FYRG03c1ZPTEVCQ0xGanBDclNmNm93bC81NzFWbmYrckZM?=
 =?utf-8?B?NU1leHdLZEYrRG9ZZHJaS1BqcDU0V2xRTHo2MFI0N3RNZTl0SHF4N3l5c0Qy?=
 =?utf-8?B?dHRZSmY1YnVlM2ErYk5TdHY1ZFQwTTJZb3FnM1Bxc3NpOEs5Q080bmlENG5p?=
 =?utf-8?B?R0Z3WEZtYzd2NDZlM2NNbFRWWWZIVWh5N2d4N0xvRmJNS1NXOG9wdk1YMEtz?=
 =?utf-8?B?VTl5dW5zU25sTkNUQ2gxbUg3dzJ5MmFVcEZZbGwyVVNpeFVNVXExcTkvTk5s?=
 =?utf-8?B?Qlg5ZkYzZFlWSGtZanBPcXQ3YWg0Uythd1cyWnhlVmFMc3RJNGc3RnVEZWZk?=
 =?utf-8?B?dWx6Smd2ZERjWXdWZlk2blJ0RENlNzMvZTExYTVpbE9wWnBYR0hNVlpKQXRn?=
 =?utf-8?B?Ly85bTFOYkhZdGdjRHJ1YWZzSFVCbDFQSld5V1BZZTVLV1pEUVUxZDNOSzU5?=
 =?utf-8?B?bkJ6N29CdHNOcTc3c25va201VDVhNHh1c3FJZ09vWkhyYSt6VEF3cTVzQk82?=
 =?utf-8?B?L2RQVlpGd0JKeHNkOGdvYUtvNktLMmtPSGV4bVB6bEZqSmY4SThFNVJwQjdP?=
 =?utf-8?B?Vm1JTTFlU044aDFCa09LSUVNQkFQZXk4YW95bHVUaXRpRzdjUURzajhuMTh1?=
 =?utf-8?B?M2pocTk4bjJTd1hTUzZlL0cwSmNDTjNnUHJZWlZ2bCtFUWpCUWQwRU1qcThp?=
 =?utf-8?B?WkRFMnB2clRNMnhtWHpuSm02cmdzSXdVVitnb3pqYUcvUXJPZXFhK1BEUzFE?=
 =?utf-8?Q?Lhv6B7uxq1AfOGv8gX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32afa66-ea21-45e6-1ac4-08df34ba7db9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:12:48.8789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXmSHpC0psJuCyb/aTir7YK8ARdElALbbJJ/yWMJPQAKaWklUmJpDpNmLhaVZ3+5FLa8aMXguTGDKU4uksjY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825



On 10/27/2026 11:54 PM, Jason Gunthorpe wrote:
> On Mon, Oct 26, 2026 at 06:29:39PM +0530, Vasant Hegde wrote:
>> Hi Jason,
>>
>>
>> On 8/17/2026 7:21 PM, Jason Gunthorpe wrote:
>>> On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:
>>>
>>>> Remove the iommu_group_mutex_assert() call from
>>>> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
>>>> release path is a legitimate caller that does not and need not hold
>>>> the group mutex.
>>>
>>> Why doesn't it?
>>>
>>> Right below this line is:
>>>
>>> 	gcr3_info->pasid_cnt--;
>>>
>>> Which certainly needs the lock.
>>
>> yeah. I overlooked it. Its part of dev_data and domain lock is not enough.
>>
>>>
>>> In the ARM driver this async release notifier was pretty tricky to
>>> lock properly. It just updates the equivilent to the GCR3 entry to
>>> make it disabled and doesn't touch anything else. This is locked in a
>>> way so that concurrent domain detach doesn't face any races.
>>
>> How about sva_mn_release() path just cleared GCR[PASID]/flush cache and then
>> iommu_sva_unbind_device() path (amd_iommu_remove_dev_pasid), decrements count
>> and removes pdom_dev_data structure. something like below?
> 
> One of the considerations here is the release of the SVA should not
> trigger errors from the iommu driver if the device continues to use
> it.

I am clearing only the GCR3 table entry. It will block page table walk for this
particular PASID. All inflight requests and new request for other PASIDs will
continue to be processed.


> 
> Every device access should continue to be captured as page fault and
> run the SVA page fault path. It will naturally end in an error.
> > Not sure this:
> 
>> +/*
>> + * Disable a GCR3 entry without detaching its PASID from the IOMMU core.
>> + * This is used from the SVA mmu notifier release callback.
>> + */
>> +int amd_iommu_disable_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>> +{
>> +	return update_gcr3(dev_data, pasid, 0, false);
>> +}
> 
> Gets there? Or at least explain it in the comment?

Sure. I will add a comment. I realized AMD SVA needs lot more fixes. I will send
V2 along with few other fixes to handle device reset scenarios.


-Vasant

