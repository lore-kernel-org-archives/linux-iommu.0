Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717197;
	b=IPk/A1mJz1eIUzVf8ioVgWJ/s5RonGeVODqktEX227x6cTamPY/1t0L9SMA6mzqZVukM
	 BSlfZhud0aLgv6ixmzoplPsucdOCL+0lqmS88TvIlCejH9RGnMJsOqrg4PMiHzqS55EQz
	 3/TdIV9P/ahw5cl6gbN/aaXhn7VxHKeA5UT/ThcA13am70gNBJTfjyPls6Ys9Jtl8VyXK
	 ER/mPEZjXPXgxS4yE7JAeoeres6eTbpUDI5jaqxoxlPMzRWvmJWJb3A6A9YzcwhOMw0Yb
	 SZf0rZg/0vFf3pOZlTv3N5WFfwBbI2YsUua1uaGiVtc401Jh/pR12lAUn+QfY+AiyWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717197;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
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
	bh=0wuogVntnB31riI8cayCwO8isFBzPw+kNAXngTW2o18=;
	b=HSqM1qob1vcsBJjplLEo0LhrZ4SeuSdC6RJufqJGjg7kHgAYPA6oDKU5v+PNn21orkRG
	 7mpKdWLp85gkkQ7MxCeKhwS4dQsaRG+0vqbBUGPAqySNo4dk7YJPeVwmuH1whYPOYysiq
	 RsYotCKswa8xja472P4anypFTa/u5PxPyIhuyl6mhJAlzC8vUsY7n5Akg8paSOAgkZUme
	 rU6E78c1zygleNtVGYshduh8a2z7ekA4aq1PTyFGLl/uOrU8MFm1UTa9BKi+l/Ml4Y5Cn
	 3WkPpJpF2ph0MzvTlkw5kr/eCr9jIgddNXu/Jh3C8xwlISHg5+1ieU6xIqlZvjd3hxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lt51kJ5j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.2
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94639606A324
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 14:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94639606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lt51kJ5j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY97au50auJIQNSdM5xjFj3cbYsJAZA70TydRQarEyCcg9+R58b1pMh2KRTCpwW/vqVSeW3Ye5V94KSm+mGeQ3gDI+74DzMQBjBdw4wZ0BMIF4XKGpTMFG6raH+AZiIHRSFM9xmykl8w6oW/ooxPm45kxyYfJwNo3I2PjPi2yBI2aqZrS263Akn8yiE8DrBcRGhsJ13g39L7k25NIZjP1DOsWzpV6vh0kHtS3wlo30HaNczmHTQwv25+DXEsM6JZ7AFh0/s9kP2m5FxBTLV3/T77hU6fQZLL9AJsUYGLjaa8KaGWXdWEGR0mM8h2AA6HzBmx6UO37QEEGr6VVoAkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wuogVntnB31riI8cayCwO8isFBzPw+kNAXngTW2o18=;
 b=YQh33oKgGH1KjWtfch8ElDSDRHNdp491Bvjc/qeG5I2AhqNE9rbFGqXPpC02cDe6oc3Aa2Ek/o6mXy60Xjcd0c+2ZPsFWxNB+Y/8BJ2ULhfD5kx3h/XC3DbIPHJc+kpSua/QqTw59X/wl+0fiEzaP6edtkuhh/zvIHsGxJkA9sIr4E2gx55eSvk/zrVwyLDEY8iSCZrxiVLllxeT2llkQuW5ZbFhfgZrY3ZrD6dujRsiAK6zOPYm+iCXXwD3Jw2ZhGlEqgulJt1jVauqAOA3r1uZGdKSFFDP1UKiNZvvojfz8aVJPrM/jSABNRgkEJZEq/ctwwLHGpARjaFXoThRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wuogVntnB31riI8cayCwO8isFBzPw+kNAXngTW2o18=;
 b=lt51kJ5jGrgSoeMG88I13NLCWgMK6laE27J5oAmbY88g/WUgxyYvAIy4Um/C5aADzGYr/qPx4oyMUFqfEXtlVyOXsEQjt9wRUImoQ14acrfy3EaPiPdlJdUwoeZBKu+JiGqKiWcwrMc2HhZPY/ktUQ+SwF4N5HRDpZemOl7aYVs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CH4PR12MB093331.namprd12.prod.outlook.com (2603:10b6:610:507::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:46:34 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 14:46:33 +0000
Message-ID: <18bf71fb-df45-478b-a625-2f6dffef47e7@amd.com>
Date: Tue, 3 Nov 2026 08:46:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD IOMMU NULL pointer dereference during boot with
 v7.4-rc1
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>,
 Jean-Christophe Guillain <jean-christophe@guillain.net>,
 iommu@lists.linux.dev
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <97e7c46b2c3b8a0af2a458649349798c4ecc55ff.camel@guillain.net>
 <aa03a31a5d700da89d2d20ce92a16c9629d20702.camel@guillain.net>
 <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6a3cf464-6c1b-460a-9ee5-5468ded48e0a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::16) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CH4PR12MB093331:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dbd4c5-fac0-4856-6f2c-08df39b9405d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261102123227099003|261021121427099003|261026140227099003|261028144727099003|261026121527099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	UcRJKizI1ORHA9SI/fJ8Aso4HBgHhJkza7dh5H0CT/2wJ1Y5DnyuEGkDBuLmcTMk5qsQeAqs0JAsCBzSFyeNBc33hkm06lJvxmmEQeHhUgU0pBuVNZUEJtMFFRJbs+NOcY8cwLL6KS17bTUdApKngLmEY2xs8P4WzlLqI1uPijh0kC/suCpyyjpvEbzfg36LaoJBDRtUyjoQnKtFg6UPeQ2gsqwFtFiqn8x8+cNx4d7PgZfTmJCT0QRrhmYD9bPLSJoF7ZcqYPHTpLBTept1y3BfGtaoMabKdpMRqLMkkiUmGNNBQVqwpYSAAWAxQkQ84xRko6Gd+XUQUMJ46+gHUxBH6PKmrj1Kag1fR+3v7+Eosuu1dGGXN6TF2QsLOIjXdybWRGwZmm1DnZEME9pgjqWCkCcTP2wRQzNFCP6koulVqpVE2ojovWNp4fEubEI5D/xdwRMUkdwcb7pLXi9LNNKFicxCQwHmtwtwzLCZ3GtsOs11QVX7AfdNycFkOuXR1Q/Ci+d49tdflGPRCHj27ZB21Bbf1ywvuVrZ1uQ8avBxbvstEx5pBUz7hv6CB9OF4qYF35szkPHK9nLEeNVVg3ihWTvxVI8nyiutD+9Pq7Vjxprz6XKtQBdTDJPHshGE0FDyc0X0dLIHf/m/myZ4HEdBya/vigUrZ5AOmk7JuCE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEFUR0NqQUc4ZTJZZlptQWhza2lyMy9ya0xVNUpDcEVvaUo2eWZ2S2FWeUsz?=
 =?utf-8?B?TFRGR05LWnkzZEQzaGJ2dUVGc1dFc2lZWEI5aXBzbVJRK0xpZEZSckNuUUYv?=
 =?utf-8?B?WFM3c0RPOUxscUVQalpyNXEyVFRDUGxsZXdvMTNhMHVMdGgzMHRyUDBDMW5x?=
 =?utf-8?B?R3ZORWhzQUFhUTErMUdmMnZzbHRjZTRuSlJGc3gwUk1xcm91ekVacnd3K2pt?=
 =?utf-8?B?UFYvVkRjR3lGZytyaTRCN09SMkhSTlh4Y09SVlUyT1hINHc5ckZTU0w0azlJ?=
 =?utf-8?B?VXRBVUVWcm5FRS9tanpGbjcxSXFLZXMyR3BGWWFOYlJmZHNJaVVRTU9YaFor?=
 =?utf-8?B?L1NzS2dSRWRhWnZiQXhVR3ZyVWpiQ1Y1WlNRUEY3Rlh6T0w4L1JaK2tKeWZn?=
 =?utf-8?B?NDJBTHJDK3A3V2xvT3VvNGUwUERRb1B2M3E3czVOdFBjaFJVZkZEUzNPVHI3?=
 =?utf-8?B?Vlk2Q2pWNUQ4U1U0WldTTjdSdjFPc053TUNxR0RCWk51VENTZE1aMGFESVRu?=
 =?utf-8?B?MGNDYVZsQW1KTEVCbjZSaU1oWjlxNlJPVG1YV2RLMXNKVEpmWVhnSjR3bmpG?=
 =?utf-8?B?OHc4V0lxdHoyMXZ2SXRaQW9MUmhDcFlLVXBUSEl0QzNUbEFTZlJ2ZDlCQWtl?=
 =?utf-8?B?dlZMZW9hcDVEM002MjNnME4zcGhuQ0EwNXl1bVZlbnVGN3lsV1pnNitlRkRC?=
 =?utf-8?B?a3FwbE1kcTVLZ1dRMFlNNk1BN3pPWW5XMU9VVGU5OEpiSzcrckNMTTluQXJE?=
 =?utf-8?B?YktCUWVaakVYTEpmUjJpeE11cHBCVWIwU1ZleWhlcHdHTjFHV1JIck1YK2Nk?=
 =?utf-8?B?aVVuTWVQcjhBb1dYRm41RHNONEtLTGFUVy9jWTNCeXFTekdIUXJ4MkJ4L0VE?=
 =?utf-8?B?TStRQUw3U3p3WGMrd3IvVkdUWmxnMkh3MmpzMnpHSitVUTJqVDEyOTZLWE9j?=
 =?utf-8?B?SU1hYmxCdTNpMHhLOXJVNDZ0RWVuL21ReXFXRnBQZEFyZW9GSnlzbU1zelh0?=
 =?utf-8?B?ZldsVnhGNXBRVFY4VXpVWlBWdzAzOXh4UHd1ZEIzQlFOOERtYk03bWdOMDFB?=
 =?utf-8?B?WVU5ZkNzemVHZEVrbjArQU9RRkpnZmFWSk9iWkFqNisxOGxSWm84TENlbTUw?=
 =?utf-8?B?T2pFK1FNZU4rNXZJQ241c1ZZdElrUk4rODJ0WkU2VTd2dC9RODlNNHdlKzZr?=
 =?utf-8?B?VHlBdFg1Ylo5NUtsb3FuUGNLdHA4cnFKdkNTNTA2YkJLZVpBeWdyamRHZzRJ?=
 =?utf-8?B?TEJUYWZQSk1ESHVzS0ZDS1VLWExTZm4zcXBZQm8zb3EwQ2tIMzM1UFlURnNU?=
 =?utf-8?B?aGh2ZElNblBGcHQ5MjQ4QllNSHJIUEx6dnZsVGJsSHRldDBrOG9McWIrQWQ1?=
 =?utf-8?B?L1RkM2J6QUgvZ0hta056aHJHQ0JVK2hnd0ErVTNad2x0b21BRHhYVWdRd1h4?=
 =?utf-8?B?ODZod1dyK0hMZW04YVhvdnhRRG56T1A0R01WUmE1c3VBR2xUSTlKdVFVcEgz?=
 =?utf-8?B?YWdON3RZdWcra1RMTTR3M251Qkt6TUk2RnFoQzdXT1ZUejR0clBITnd1Wjkw?=
 =?utf-8?B?YzRIL2JCVEFOZEhFR1BOeXJnMW1uRVd0Z1ZxYkZTUERDNHp6T1VyR0JRN1JO?=
 =?utf-8?B?eHJsVFo0ZTUyRHphdEtacG9GcTRQdFpYSENkYUQvSGZTbnVIemEvUXRQSXRH?=
 =?utf-8?B?b0FTQktSTTk1dDhJaEhuVk0yeWdRZWF2Z1RRa0RhYWVncUMrZU5PV0Nyc2Jo?=
 =?utf-8?B?eEt2RVl1K1NrVVJoNndVUWx4NDZYOWNNdW11KzRDRGhFYzRuMVpxLzNQQzF0?=
 =?utf-8?B?OXZaV0w3MWxWZFZGaUQrQ0gwRmJHdzhoSnZuRWhmYllHRTV1QndETG9ZOXlt?=
 =?utf-8?B?MVFZNVJlSVlLaXAxYkVxeU5aT3JmMFowa2VuMTZscU0zRHRTWkx5N001cEVk?=
 =?utf-8?B?VVpBM0tBMjBkYUI0UGg1dHF4UndzellxY1E2TjBlWnQ5MzJoemFNSDJsWDkx?=
 =?utf-8?B?Qm0rQ1VqU0YybEFGT1oya3pOU0RZZ0Mwci9sb09IdERlczU2aUxxTUVJNFdN?=
 =?utf-8?B?SXRWY29BdW5GMmJLTVNmUFNqaEVsRnJvTS9TL0s2K2RwK2RJdE9pOWhLU2wx?=
 =?utf-8?B?bmtuREVSQkJvTTl4THhueHp6TFR5bnRLSEdiUjdXWngwMUc5b2gyWmRDeUpi?=
 =?utf-8?B?OGZLaWVzV25mdG96QksrN2xjczBrU29YU2VENUY3TXorVlloRVp4K0VGaHE3?=
 =?utf-8?B?ZWR6bHlsRGdPRDdwQ016RGQzbWxwSzVOa201UVNNVHVuUm9QUEI0TDJMZVh4?=
 =?utf-8?B?aWZhamZpb2FNSVJQaHBFeWxscnN0dHcrS2VvRGtZZ0hUd2cyM2U0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dbd4c5-fac0-4856-6f2c-08df39b9405d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:46:32.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gyINvqUFGQ+qxqo4ut+agra0FesyehZ6Vvobfotw3x1k/FrcKXBvOsmwVpwJSy7MoWeC+GmdUS5o+FUQvNfQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB093331



On 11/3/26 08:38, Vasant Hegde wrote:
> Jean,
> 
> 
> On 11/3/2026 8:03 PM, Jean-Christophe Guillain wrote:
>> Hello again !
>>
>> I managed to boot 7.4-rc1 successfully with a small patch.
>>
>> I'm not an experienced kernel developer, so I used an LLM to help me
>> investigate the crash. The following analysis was suggested by the LLM,
>> but I tested the proposed change myself on the affected machine.
>>
>> The likely culprit is commit bf5bdfd1f8d4 ("iommu/amd: Force identity
>> mode for selected GPUs only").
>>
>> This commit introduced the following line in
>> quirks_force_identity_mapping():
>>
>> if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_ATI)
>>      return false;
> 
> Thanks for debugging. We we added quirks_force_identity_mapping() we assumed
> upstream_bridge is always valid. Seems that was wrong.
> 
> Patch looks good to me. Can you send proper patch so that I can pick it up for rc ?
> 
> 
> -Vasant

Can you please also share output for:

╰─❯ lspci -nnttv

This is a surprising combination to me too.
