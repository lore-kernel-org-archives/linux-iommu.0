Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA41F5437
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687446; cv=fail; b=HcLegabW9f3L3wApvxGMO0b6/WgOnD3LqTjZJ76ydx5PW54sO9kzuqrLBSkKmK/SIcoa4z3G6zzgN8oI6z1vRwswCuatVuCCdP9RBsOaegT7VhzgYqYC1nxUJnR+0cGoAdNUekcB9qOvPbuM66llJGPaoPTKQzRuQ/OiPdZehYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687446; c=relaxed/simple;
	bh=vKl9/QXo/nn1sCsu9RB3MLMzP/LigJvVK8VakQtMTSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDAwKXoGFtwx+nN67suSXEAIHKMB9f0YAG/BXGgqoIkarl2lwRolRSU/NpxXRgLBhHPx/aPQTJA/Cv/iEt96ix1G2gFZhHePBxUUQw4yBdH4Gce1WtYKKAFtaeaPvvDHJF0eWKcovrJp1OlRz+spTKhUZjhZze+jnAfVXHRktHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=peyG0iLY; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="peyG0iLY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxmBk656ZWZfjl2cfduOV9nFjCec0upHtJ50BUeowjZE2P8ZyjnZHwgV7EaRGDnIZCsc2ttg7BdPmJ+pjEXF9k4pt2598lUAwejAny60wX2nn1qdWX7T5xQI3V0+W34hoG+ZaPat11+gTG+NQlSDDP+4Ek5EK65ispBnAoV95V7S7/U7epaVf//YQdefRp8IbhMWkyBn7x7jL71YBBFLxgIBs6Au2/b6/EHatrHkHDHFgsr3nOarcVGvZyXcHBqcIVzCqrMxuza5RuBbnNsI4TJEzCYvqbPqUA7yR9/5YxIjMvVvhlLWshqA4PCIR6zOcVthNzPSosAwhPe3yKp0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg7ei312YcZ8UUudZsRVNomExgPFyTunSldWiRL6tkA=;
 b=K5V6uMgC6RsCS+uhM/Jvr4xTGa2hr1VDtfiegBg4GBbQE6PwarIQmcO45CzBTP+5+NBuiTo6mtcpGGsEr/ZTEgFAKaaABlrKItJVVqArfqjmYiNADzQmxOeTuROP8dlN/GGsu42QyrTmVNp4vpI8GNAvfwkJDC799yg3mHyFFCXi0R6ptlfwHooqP/rHy6BI87jR0Pqpu6Lbzv+OUOpbdlzjaw5pYuum4PLLHj47hmuaDyD2jwdj39KCXUToNywX73IPu0v924zASs9u2/K746CX4PQ+8MfahE14YNt6M5cwvPQUTypHHlxP7wqeigk7Ay5fijRPcVSli903G0ffpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg7ei312YcZ8UUudZsRVNomExgPFyTunSldWiRL6tkA=;
 b=peyG0iLYo7i3C7Nnirexnn2UoDWBTBOsGVo6kwZvzKp1cmg8A2fLfDcx4ZYFKLQlnnlE1UORzzT6G2izjCc7QDDYzxmHPG0ma1AVU/LAJ5930nNfC+0dsCDAkXwV0fmsznLvcsNuXUp0KX/UoN0GzRZI64nW+SqyABoJaQDjtzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS2PR12MB9709.namprd12.prod.outlook.com (2603:10b6:8:276::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Tue, 2 Dec 2025 14:57:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 14:57:22 +0000
Message-ID: <14cd7d76-7be4-4c88-a286-2bdebd70bbf9@amd.com>
Date: Tue, 2 Dec 2025 20:27:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking help on AMD IOMMU unmap logic
To: =?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>
References: <E16714B0-F380-4AA3-9F71-944C83FD7E45@didiglobal.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <E16714B0-F380-4AA3-9F71-944C83FD7E45@didiglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS2PR12MB9709:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3888de-b257-45af-5414-08de31b31939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0g1eVZEdFo4Wk9Zb05ZT3ZUYWNiUHRrbWphZDdVQk52WWxveEpXZzlZVW43?=
 =?utf-8?B?aXJJMEVNQTFHZTl3YmpkNDluRmo1N096djFTRGtVRkpiU1NkVDBUNXpkN2dD?=
 =?utf-8?B?ekZyM29saDRudVMvc0V2bitGRUwzRDcrYmVvZGFIcDRlVVNRK0U4UitRQU0v?=
 =?utf-8?B?cnJRbDFjNDJlSHFjbzdvMm1aUm1ZZGNJM2J2ZC9LZ0RIQ1BpSjNoM2hmRURh?=
 =?utf-8?B?UWE2dWU2NzU2YkxjVGt4dzhOTStQK1k2VUtRdHRhM1p6UGk3NU0ra09WcWNi?=
 =?utf-8?B?TWJUamVvdVZXSG03VVVMaEwzczB2YUZYOGVmWExtSkRxa050cUI5dS9oMXNy?=
 =?utf-8?B?dzJRR2hqOUppRXNzOTVlejNyY28zalhSUUNhNmF3TnFOYjEvczhvcWhqV29P?=
 =?utf-8?B?T21NU3YxMEVuYmhkQ1k1OUpic0E2US9YbE1XUDVJa0dLTjFrWnA4aFRERVlO?=
 =?utf-8?B?by92YnVaa0VGaE5qd0VBT2JCMWloWFM2R0wrMFdJWHRNZk9MdFB5UGNMSFpq?=
 =?utf-8?B?OUEvTzFlWTFUNkFzOFdHNG9BMVZncFdKM3hqY3d4VllEeUN1NUNjUEtkYVRx?=
 =?utf-8?B?aXJxTXE3ZEt0STJ4b01XZEhGeHdNV2JXWVlLQ3dKYThocWFBUUxHeUFnVytj?=
 =?utf-8?B?UXZHRThBeFpGVG1nWGpaVTB4UjNtc1VyYmJNVmNQMDhBNXhTWWIrSFZCZ2Jh?=
 =?utf-8?B?NFY5cWVuVzJ2ak44L2JUZ1NCNmdxNHpjZm0wTm1VUzhjMmhOcDVXR1drbGwv?=
 =?utf-8?B?SU0xekRkWUtQdGRVRlBUV1ZFUUkwNjFyOEczU2hWSGwvV1ovbXY3MlpjV2NZ?=
 =?utf-8?B?eFpOM2M3ejFwWlhXWEk5V3FHQXZJUkd6b3oyUll6ZXNkMzVLWXBNeVRnKzY0?=
 =?utf-8?B?MmQ5WjQzY1kxbFZGZThWU1BMcm5zOHdpQ0ZNWWczeis1MUVGOHl0VHM1SWNz?=
 =?utf-8?B?bE0ySWNvanFPd3VBaXowRTNJcTdmbGpKbHJXTHgrZCtXeGRZbmNSMWVXSTVo?=
 =?utf-8?B?SkNUd0V4WDhwSGdJczduV01rYjljNW45bk11TVQ5UThIdFJhVHlVMlQ4bm9E?=
 =?utf-8?B?Yms0ZFpWRFlEQUpJcndxK0JweGVxbmFGbWdsblo4dzNhRVJlcm5HbVBwbmRR?=
 =?utf-8?B?cGoyL2xsclA4YkJnWDMxYURTdDVXMXJZaVJoZ0tXTFBLWjhlclFXZUMrdzRt?=
 =?utf-8?B?T0VZdHZZekxid295cndzYUdiUzFpWEcrK2FFeHZqbW1aZlowcXhVcEU1ZEtx?=
 =?utf-8?B?WEowRWFaR3F1NlVEdS9mNkpFRkcxQ0tnRTIvL01iVG9FdDlWWG5oRXVpZEtK?=
 =?utf-8?B?ZncxdGNlODV3V1dnQVVmMlN3S1R6MTNwVzYwVmVMaTArUit2TnkwY2FZU0t6?=
 =?utf-8?B?Y2Z2VFpLVzdNaGxKcFEzV29ENldERlo2ckozcGZCc0tlcHd1YjN6cm81YVNW?=
 =?utf-8?B?TXpnTE5OcHJsWTVGYzVkNW43RW50M1piY2VFSXFOT2pwSkYzVi9RVlo2OGdx?=
 =?utf-8?B?RnpJejlJSWMrMjk3TXhuNlZmcXdOK000bzUyZ2RPdVdWM0FpNXp1Z3o4S2Rz?=
 =?utf-8?B?dFVtVHFYVm10SG1rYWpHa3ZHYXBZOEpvbmhXZ1BaZ0NlNzF0TVdCa2RsdDFv?=
 =?utf-8?B?RUZzYjFINXk0THdGK0tLMnRXa0ZiMHBhM3B3V1p0UDRxZUd3VTZqZzNSRHhx?=
 =?utf-8?B?UFhlQ08zQ2FFYk4rZnF1cWVPTFFsS0Z1Z1c4blBaNlFubC9TV01xMk1sR083?=
 =?utf-8?B?a0QrVmpwWkpNNlA5WnNXM3NPM2FqeDVTeUFRNDlqWklxK3psczdJUCtEd1hi?=
 =?utf-8?B?dEZxZFVqWlI0NDV0Y0Z2dGxkelBPZlg0SDgwNE8xVE9LOTUyOWtuNi9nWUYz?=
 =?utf-8?B?SjBZeXZVS3BiVnBITFo3eUR0TCtZQUloWnUrRWVOZWcxeDdxbWtSdG00SUZR?=
 =?utf-8?B?OERlNXFlUldMT1VWQng3RDNmVTc5eFUvSHV5SG41L2FxQXhFZktaby92NUpy?=
 =?utf-8?B?djdpRk1Cd0p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkFZQnZoNDc4eG1BNDlMeklPYXlibjhzeUtaKzB2YjBBRTUrUEJySkNvMm0v?=
 =?utf-8?B?czRIQ1BaYVdJSmd6MDhZRlp2a1JDMlk2dnExR1BUOXdKRmljMmY0T3ZaczJN?=
 =?utf-8?B?eml3bmtsaW5tc29mdWlGSW9IaUFnd0lzRTFHSThmSEFjVlk2Vk9tOW9CUjlT?=
 =?utf-8?B?b1M1aTliWmpqbmhtaTYzdEdJaXliWnZ2UUYvVE5Iak1rejNkblNrUDc1Wisr?=
 =?utf-8?B?Ti82czdmMTc3RGtsK1ZhSnQwaTNSeVI2MmhoUFBoZGUrZ3B6aWFkclA3NTls?=
 =?utf-8?B?RXRWVktUbzNKVkdYUW5rNUthQnN0cGg0My9rQjRSTVFmMjNmTDZIQ0cwaHlK?=
 =?utf-8?B?U1FIYVdOUUFCU1laOWVMSGM1aFBidmZoeERxb3U5NSs2WXNpOGpUWFkwTWZl?=
 =?utf-8?B?ZUM0a2NUZ3NObmNNcEVtT2QydzkxK200NHk1RU5jZGlqQm5zS0thcU1xRUoz?=
 =?utf-8?B?RUMwdXcrNHNvb0xTb1oxZzJ1VWFGUDhPNXlONlQ0UFZ4by9BcUhrZjRpdHR1?=
 =?utf-8?B?a3VXVENMbHhnNlhaZmg1OC8xTENqV25LYU1MTnZ0dWo3dDV5RFEwODZuSFZ5?=
 =?utf-8?B?WUcwc0RzM3FnWkZTQ3JhRU12di9JWkxtdG4zSkZPRzdxdUFmLzdYdWFSYk01?=
 =?utf-8?B?bkt5S2RHbDJGNmdKUWN6b0NkeFgrNXQ5bkJZMGR2NTVCZ1l2Q3U4RlBqUTJM?=
 =?utf-8?B?WC9hVDhxeXdUT1ZDWjV5Y2tjajJhQzQyRzRYTFNjV2VHRVE0cjRUMnl0YVda?=
 =?utf-8?B?K2t2Kzk0UVdUSlVzcmpBb1kwaFpZeFBlRm5RZ0tPbWhuQWNITjYreXZiaksz?=
 =?utf-8?B?TUNPL3NIeDVCMVRXc2FheG8yYXhYa1QvaG9ZUDhlQUROVGVpa29XNC9YY1c4?=
 =?utf-8?B?eGxSNUg3bHVSN0RaRHN3dTg4TXBxQnVLWitzajMvcTVmYmpqNjQ3NnJEYWRs?=
 =?utf-8?B?cnFpRUY0U2dOVG5icWdlYmpVTUJpZEZZSk5xTDJqbFZzWldSbmlzSVVGcUk3?=
 =?utf-8?B?SWkvajY4cnA0ZHVuSDZhNjZuTzZTbndSUEZqU1U3UE9RN3J2MEZWSUJzcXhK?=
 =?utf-8?B?ekJBaXpWdno0V3F4cUJtZFk3U0JWa0ZWbUlOQlBZZVhEcGlDaXMxOTdwRjFo?=
 =?utf-8?B?WVFlaXptRGZWd0VoOWo1ZmVZd1N0RkMvL1RuKzEwY1J0U0tZN3ZScTd1OGZD?=
 =?utf-8?B?cnA0VjdOREk3SmRjWE8rVHRuNXowa3BrZCtVY2ZJUC8xelpmOGdNbnQvdjNx?=
 =?utf-8?B?NlhONG9RZUxlMjJtbFVwZDBwZnBBdVVzMmNHRDdDVjR1VEV6S1plSVRvQmU3?=
 =?utf-8?B?N1hVTE96ZHpFUVZlQVhYYjJkVmhBaVpHbkVwZzF4ZWlqQnpIdElOdFN3TEk3?=
 =?utf-8?B?T3VSUDFPNzU3dmZPdkxxOHBoQjVTTlQvRE9DODdzUSs5dWlDR0ZnT0hqLysz?=
 =?utf-8?B?bUkrSUxRSEJwQ0FxREJ0bUNlajRPczByMHpuQlZDbmxKam9ZZTNub0RtSmZL?=
 =?utf-8?B?b0RJajdSZlV3WCtKYnFFdHJRSW9LeU9rY1dBeXliNHd4ZFpwR3ZpNkgvMFdT?=
 =?utf-8?B?Ty9tUEg1WXZKaUtHRGJtYmlLSWRCb2FyY284L3U1SmRpWUVSOGJaM1hqZUNW?=
 =?utf-8?B?M2ZXcHYxRDFodllyZU8xTEZJQjRlWTYxTWRFc3ZacWhRRXRHN0tPNmZaVXVN?=
 =?utf-8?B?UkpmdEhSK1VQY1pwdmFYZUhkTElEVVQxZ0hxVEduNUhaaDFtMUpUMWdBc0xi?=
 =?utf-8?B?RFg0cTE5RnpxbDR2VEtCdUFUTk9sbEV0bkR2KzJPSVpQVkxZby8vSjZncHR6?=
 =?utf-8?B?aVBZL0ZJU3YrVzJ3UHJMTjg5UHZDUHhrZjVUNm5XVWFleVRhUURyRVVlclhF?=
 =?utf-8?B?YzdNRnVMQlM2WUFhTFdxUHFaZEd4MnZ6WGpNQnhQdkRCdVJndzZoUnlLQXpp?=
 =?utf-8?B?ZGJxZFJhOXl1ME1PYlRDQ0hJRTYxNy9DV2hrc0ZYZDdtK1FXNXN6UWJnSGVz?=
 =?utf-8?B?Y2dFK0svRFZYaGY4N05SczVUbUFKUEEzT2N5YjdIQjM4RXY5MXA5d3lGbmdZ?=
 =?utf-8?B?YXg5ZGpLYS9MRXlleW5KMEZTYisxTnpaYlpZTG9UQThNL294SmZsMDhtTHJZ?=
 =?utf-8?Q?Xm3uomK6w4919dp/8fcB0Ub7K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3888de-b257-45af-5414-08de31b31939
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 14:57:22.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMKdm84zl4xONF5cevbEBMmA//InuZ3JFAZgFD22nnR/5MRcFAthtxlOasUEnfLozbY49K7LSb+eF8CQHoBLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9709

Hi,


On 12/2/2025 5:01 PM, 张元瀚 Tio Zhang wrote:
> Hi Vasant,
>   Hope all is well!
> 
>   My machines crash at "BUG_ON(unmapped && !is_power_of_2(unmapped));" in iommu_v1_unmap_page(),
> from vmcore I learn that it is probably caused by adding unmapped to an unexpected value after a NULL pte found.

I am not sure which kernel version you are using. Its very hard to figureout
where you hit this BUG_ON etc. Providing basic details will be helpful.


> 
>   251c4db699ca7b966db7e59e8663a231c96ba454 seems fixed this, with the commit message
> "Also if fetch_pte() returns NULL then return from unmap_mapages()
> instead of trying to continue to unmap remaining pages."
>   Could I fix the crash by only applying this part (return when fetch_pte() returns NULL) of the patch?

I wouldn't suggest to apply partial patches unless you know what you are doing
and why its safe to skip certain hunk.


> 
>   Tracking the mail list, I find
> In original patchset V2, this BUG_ON remained
> https://lore.kernel.org/linux-iommu/20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com>>/
>   Then in patchset V3, this BUG_ON removed with "and minor fixes to unmap path." described on summary
> https://lore.kernel.org/all/20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com>>/
> https://lore.kernel.org/all/20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com>>/
>   I'm also curious about the details of why this should be fixed? (I know little about IOMMU, from my understanding

You mean BUG_ON ?

> If we do not continue unmap remaining pages, would iova remains inconsistent with GPA?)

You need to look into unmap path to figureout what happens.

-Vasant


> 
> Thanks a lot for your time!
> 
> 
> 
> 
> 
> 
> 
> 

