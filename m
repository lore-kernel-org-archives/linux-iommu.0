Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013074.outbound.protection.outlook.com [52.103.43.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6322FF22
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758684379; cv=fail; b=JVHJZVnRU3QtLG/xZBYnwB60dWVlEmQSdY/wmn7q/trZVwTGcOu4+FEu5xxd3zthTXAC82ZoVaqK3V5uOzv1tlF3o6G2yqvkz10rYLrWbBfiiHK0glrX6IXSUHVK0MQdYrpJ1+ainloicFWWoys+x0JLp2ZlpHXIyYEWBlcNiS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758684379; c=relaxed/simple;
	bh=ZmqftwQ3aYqCSvcIVm4nCbv1n95p5NTSZSvt8WMOtbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jq3LByNZw1oGfY7zdZSZX5G4HmMjZV+zjTr2fWGGnW8eklkoWmhBSG8jliGJGxFWQUHVlgpE9YWvZ+WQ3ZG4qRP3wyMGCrj0cfjlaSOrmBOSvP1QBnd5G9EUiCDwLTU128A12IMnlIB6Os4F1Rn81nTcgdIsipLqVKMpCELXP6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GtRjHAJB; arc=fail smtp.client-ip=52.103.43.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GtRjHAJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSd5W+taLrvpSONv3OETj0yFdddOf4NqcWKJRvLpfpmYUDUocJ9uJk7RKB4dSPal1bsFZeQC4l06gMCfH8TnmwNr6lTpk4jJrPBP0mYmzS/bPyRsRaD1cI43Q5I+vs//EtTuYTbvjVN6WbME4FvNsd5xcDEBOtEhAzc5sfPfXnT5K6WVg1C181MBff4saUbCESAh7prSvPZYfJ//m6+xSvR2RlMzjDVxAh+8URnMpaeFn5f9VCOeEDybMDMI5S6Bxb/nMi/Z2RfijUOtLmZcwex4N0XV73bpljZmIQOWGGAaioK6FjyTNRFBEsZ9dcpa/dVBCLzH/P5l+4v9qbaYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayx9WvDUZrTZJlH/BJfuGxr0Ao+g8XvqgFIopJUDn5Q=;
 b=UIKNhZDM/Ozh6kp3STdIAqDZYpRujLfli4Lzv1xoR2FrkKeRD/uskjdpBwhANwIEKmTPZbuWO3M7E3jlLjtv0+EN0yeh3JssUznGfjDkN8ejwDyxu6NDHzwD+JacPTU9vftxq4+FkBFQ/bfJ77o/sdkK63+TGI7r9qj5IvTJKJsI5AjvzbRGL2lWtkOnNko33+WQ1dAv9QikwhQRVJsBHhYjgKlDt7cnnRVefpBXOSRtnM1LWtpNaFHwaryp4WCbvBDBJyUTLZGWNALUr//uoFwwAU9mJ6IKXeh29msEuaDU+aHEnN+GDr0S9kd4XqAECThU9lGL8UOQenGOmQY4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayx9WvDUZrTZJlH/BJfuGxr0Ao+g8XvqgFIopJUDn5Q=;
 b=GtRjHAJBSOLyJqmcV0oyZTTDOot9SW62DRu11SZdY/dROIYgybxRn/GrKhVSPdO+ubXc48iM7FIp+Eq+/4UP4O4ePTGW8DO2Ap12ztbjS19WP7eOkjgWn787sB+uwY1O1CRecKzD++gwKnBpS03ugIPrDbKj4oc4QPPnDTbT6FwVdrAeONKKu5O3nEGG6pHzxjyGHGXkScajNGrGpx8fVsjDHsvGrL1uNSsuzaRSC5F6JAx7HGu/t4VKWMSTCfr43ImEwFhrSNHwNggehu6K2GaTko1QOV4T7kbsl9Pjqy/LDc7GdFw5fDRFesb248Qs2ZcQFKESRh9S7Din/vkPng==
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com (2603:1096:408::966)
 by PS1PPFCF247DC44.apcprd02.prod.outlook.com (2603:1096:308::2ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Wed, 24 Sep
 2025 03:26:08 +0000
Received: from TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da]) by TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 ([fe80::209a:b4cd:540:c5da%6]) with mapi id 15.20.9094.021; Wed, 24 Sep 2025
 03:26:08 +0000
Message-ID:
 <TY1PPFCDFFFA68A794163FFB7BFAAAC22BEF31CA@TY1PPFCDFFFA68A.apcprd02.prod.outlook.com>
Date: Wed, 24 Sep 2025 11:25:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/18] iommu/riscv: Use data structure instead of
 individual values
To: Andrew Jones <ajones@ventanamicro.com>, iommu@lists.linux.dev,
 kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com, zong.li@sifive.com, tjeznach@rivosinc.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, anup@brainfault.org,
 atish.patra@linux.dev, tglx@linutronix.de, alex.williamson@redhat.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-23-ajones@ventanamicro.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20250920203851.2205115-23-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
 (2603:1096:408::966)
X-Microsoft-Original-Message-ID:
 <5b61e653-16d2-4856-9484-9aa72644be65@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PPFCDFFFA68A:EE_|PS1PPFCF247DC44:EE_
X-MS-Office365-Filtering-Correlation-Id: 16986495-9b84-4e5e-fa64-08ddfb1a19f1
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TVWrg+fxRScxfg9v9HXnUFlbw5cc4owDazxVhvKGSp4vz8xMMl7LgklMWWKqGQDlc+TqAb0IAVkpinsJrXNq/ld0cRPloSt+t7JDezo7b7cVfN94YDCtpKwymGGqz6LYCDJY9wZ8/wD1XcOtA0nFtiZjKzuuqeVCnidF6Ha0xw3LzvnOotZVe5pjRpTFuLx4qm1f7rsJHhWiq/BBRqrGars9iVluZzxWgnDL12s9WWWODQghhB5EJvlSie9VyS5FK89ZtRwZwKL127ryMbHM25RBb9re3+1862XLNpDCJ3VrOfNVQswQR2Y4mvmjgW/uWWA0UQpGz8pFODoph87meBla53UMizwWzIFbKYcXwlBR38xhe8jaO+5dpMqjHQaiqyalr2O5uG1P3cQneOF+apMUDRsda2VuA67QTUfm1flUgZBTQrsH8zA6JAG+dujnowxLiKcDjpRU947QEE8SMTMG7P/LruFDUzo52nprpJRG1aLNaMOhzgVN65ao2ymR2HNovU1KioGm4mRMg5VqXwrLQSw4riEm3ev2q2gSsgj2WJKUD2RDUkGZeIHqeXciHxQjDtJt9kWRkIv+RJRGIvUjnXUjaCmZ4gzDggmr5Ckko9/j3MF5ge4r8eVpN+V4pKlzNQyAuGQbo+ymbR4A+ICJ47p/hsAnFGyBR39u+4JXmjpQ6MpnsRQjK4+9tVjCxBOJ5C3uiZDgDroNE3XNCtttQr8L0N9H36x7UhaLsy7tO4pVIcC7qeA4vdIG1CDqxViliOy6b2CzhJNmht5RV1gceC/sG1JFyI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|461199028|6090799003|37102599003|15080799012|8060799015|19110799012|41001999006|440099028|3412199025|40105399003|51005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlkzYUsxTVJJOS9tR0xiaWxSOHlCcmxzeWpTSGxTbTJyK29MMkFCVEtTSi9J?=
 =?utf-8?B?eGVRWC9xd3FYOTlNSUJuY0JtTExhaU8rQVQzZFRQSnE0QWhCRmQyYUZkTzBI?=
 =?utf-8?B?bGhhZFdCVTJ0bXlRTnFMdHMvTzB1ZWR6aWRaOWtmemRwS2YrcUJ5c2NtRmwy?=
 =?utf-8?B?UlVObS9CdmpxTmFjeVVHOGgvMVpmNDBIbWtxOHhYbTRzYTFmNzQ1d0dWR3Ax?=
 =?utf-8?B?ZzgvRk1FeVVSNHVOVFBRbG1LYmVvR0V1ak16NkVsbEpoalYyNy81T05vZHEv?=
 =?utf-8?B?Z0JPZnZnc0Q5d3JnZzVjZ0p1TENoazBrbFRJTUIzUTZBK0hhTS9PSmRORmhN?=
 =?utf-8?B?MzRTS3k0RmNDVnJNNWJsd0txazlzaGxCR2hGWW83YlovSm5RZGNUSmNHaGcw?=
 =?utf-8?B?WDFjTTlPWEVLSHdmQm0zTG9LMUsydzV2VzJzZTlVSGtaQlpINXVITFk4NEZ5?=
 =?utf-8?B?TGIwY056SmFkdER6Z1ZOSXZhQnJ6WFhRRGVJTGErdzZQWHhhdFpJV20rNWtx?=
 =?utf-8?B?aS9GQVRqSDRHRkUvWGM5eDkxTUdVb1AzaG9HYlN5dWd6cEtIQUR2eHBpb1FN?=
 =?utf-8?B?MFZvK0hNek16UUJSRFFGeWtFK3dUeUFoSGlLTDVJTyswMzJTa0FUL2JrREFJ?=
 =?utf-8?B?RCt6dEtSVEJqY0FHL2krNE9hdlhEWk5Eci9iZjNBMU0wZmpITktvazZlWkR2?=
 =?utf-8?B?Z2FGTEtkWkdBdlM0M2RxTHVLNHA4V0pObGEyT0hORGpNRm42MG9zYjJ2VEVL?=
 =?utf-8?B?eGp3YVZVZnpRVExYRjhLUWxSNFRWeEpkZXl5a3I4L0xPWG9jRVZIS2t2RWxY?=
 =?utf-8?B?ZTd0ZFFDUHh4bWZxK2JhTmVOZmExQ21nTGlXSmNYRkhzbzNER25Xb1B1Q3o2?=
 =?utf-8?B?RjNVOWhDOVp4VXpMbjJyR1ROUkNqcytrRFV6cXhLY1RUSzRKUjhpaFJUeGwv?=
 =?utf-8?B?Rll5dVdrL0FpWDB4UlJ4L1c2eisxUFVqZ0tLM1h2NnkzZDBQTFFJNG5lRll0?=
 =?utf-8?B?UU9YQlEycmU5NWhkeWtMZTdhS2Y1QjBYcll2c3N3MEM4eDJFM0pMRFZreFRo?=
 =?utf-8?B?bDJGaFAvbm1WTE5Tek5XY1dzMU1mVGdBQ0RCVDJJRFdtS2ViVWVEYmxpRzZY?=
 =?utf-8?B?alRkV0x2cEl4YmVKQ09aaVlFdS9QaUFOZDM4Q2Z0WllBMzE5cXJMeE4yTFhq?=
 =?utf-8?B?bGJwZVhGSk5ZdktSNGwwTWZLSTNpWUtGWUVNd29yWTRPM056T3drUHFBQ21D?=
 =?utf-8?B?anpxQkcwVTU4TExFRHVxNlJrRDF0bEVtSW9STElDUGZUdi8rbXFhN3lRMW9y?=
 =?utf-8?B?cVBWVXNDSE5wSTBFWXk2T1plVFhFVWpxTEtMclhDRThWSnk4eDNob0VYaVJ0?=
 =?utf-8?B?bEFYVUtia3NtRjRsZ3pmV2xBQU96WTJOcjhVejNEZmE5ZEI3N0prMVhoQmMw?=
 =?utf-8?B?UXlXenQxNWh2VjM3b1k5Z2ZiNE5OTWljekJIeUovUVdubnpIWkM0R3BkLzdX?=
 =?utf-8?B?WXF3bzV3RkZhcGhNN2tvN2hVYjhPM1UxTVdNdjdkNE85MUpIVHVpQWVVWTlV?=
 =?utf-8?B?bWxIZlBlSG9HSHFuWmhSWDhrTXVodDBCei81ZFgrVENWN3VIVWZCRXpiMjZE?=
 =?utf-8?B?TVZIVUJZeThFNWpuOWhBcktJSU01ak44NVdYL1g2YTFweFA5K3RsUGkrQVRU?=
 =?utf-8?B?NEVCYTFnaEl3YisxT0RFTFZFdUsvY1pseitnemVPNkN3RGRTM2hVMzlRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGRna29nOWc2b094R05uUlM3eUllbDBOems4QnBtMUNldWVzK2NBYXdkRFpO?=
 =?utf-8?B?RVk3c2ZoTzRHK0sxdDZ6YWJUU0g3YkJOS3ZDZ3RWYWFYT2crUmh0NVU5dXV2?=
 =?utf-8?B?MDZPc1ZGdkpYOXNvdldnYnlKZGZIUTZ6WkNSU2RUNHMxZ0hidUJSaTdiS3Fk?=
 =?utf-8?B?Skx2NGVlVmV6d21wRGJHcUw4RTYrTk5ka0NPUUJwaDIzYjFuTEgyakplb3Q5?=
 =?utf-8?B?bXBoM3BEM0xqdkdWV0cvYkhaMUZFczhqYTQ2N0ZNTHdPeFZCcWFQblNNZVNK?=
 =?utf-8?B?cXRTbFdhRXluMThxVFJkM2V1VFpjeHRKbWV3L3ZFeVYrRXBSRzkvcHd4TzJR?=
 =?utf-8?B?NURiSUtYL21vdU5XK3VRbythd1VDWm5mT2JHSGZXMmZZQzRtTFRQelE0dW4w?=
 =?utf-8?B?VW1mcHNtMGVoYnA1WUE5QnVmbWEyMEx2KzErenluUm13SzVNZHdCVnpGNW9i?=
 =?utf-8?B?OEJhaTkyNUh4REhiMTFKU3BQdUp1MWJWbi9KdmNlTFBmM0NXeXJuL1I2YXIx?=
 =?utf-8?B?cTA4YzBXRGp1WUlYVWx5dWlWdllFa3N4VTJmWEV5U3luOFkrN2lFZGtQZEo2?=
 =?utf-8?B?ZzBobVNBV3BaQ3hvNHg0QTRibGQ0NERHd1RzZ0YzVDNFN1puNXVzUVh0R3ZJ?=
 =?utf-8?B?VUp3eWpHTGVUZS9ZSmFLWEJBSnFvelo4RTRaM2dCd25IM1p1YURvUmpMVndw?=
 =?utf-8?B?aHBHTTZaUDJGLzJGMDVFYWNyWHBzdTI3dlphdFRSdklRa2Fqem1jMVlWOGZZ?=
 =?utf-8?B?L004bUlFeVM5ck9ycDdOV1RXbXEyVW5oaHF0TDlOQmhMMDdaeTBKK2xheUJx?=
 =?utf-8?B?MW5aZm5wYW5oQTI3cWdLU0pkbGtTdmNLcTFaNXJYbnJhK3h1QVQwZnN6UStP?=
 =?utf-8?B?S2pnSWVPTnowKzZEelNKSThNYTQzKzJ0a1VNRnBsMHB2REpCVVVObWQzM0Fy?=
 =?utf-8?B?eXcwdGNIZW5oNXFaTUhZdHVwK1Q2NE4xZ3JFQzI2c1o2U0l3amJnK1d0VFZq?=
 =?utf-8?B?SXFXMGdYSUFKK015Y2dsMDVBTXBaaGgwUkJhVGFEN094MTlKTm16N0Rzb2I0?=
 =?utf-8?B?bnlhbEZiQU9kZlN0elozejhLb1ZjZGxIWm9jTHhxZHBqZ0tObVJtSUk3UzF5?=
 =?utf-8?B?bzRqRi9qZm9iRzROcnJNcm5JQWlPRUVhT3VTd0JVNjdxM2prTFlJMTdhUzN5?=
 =?utf-8?B?WWRIMHozK01FMkNHS2tGdG9rb3Q2a1kxWTBGYkkrNG9NVFJvaTUyQ1JlNlNT?=
 =?utf-8?B?eHNHSllDSE4vSmRta0I0dGpiV05EcGE0djN6RnpFekpvdlExdklKQlFnN0Fp?=
 =?utf-8?B?OVA2MXcxWHNCM2NyekRFbHVnTHp6STJ6WDZNNng4MWE4S1VicHFweWQ1a0dS?=
 =?utf-8?B?USt5bEFSZmYzVHhmaE0xRWJoQTdEUS83M1RnRmxya0RpSFRiNDg2NEFacGxE?=
 =?utf-8?B?RVlObFZWRktwWkI3SUg0MitsdWxHK1hPcFdTTHlISytzU3k5SWdtTUJoM2Jq?=
 =?utf-8?B?a29ubWN4c0l0WE1MYTRRcGpVUHNMcjZBcWZHUnk0QmVQT3UxNFF2SGZvUC9o?=
 =?utf-8?B?dnlLSnd5NG9WRkhNNFV4QW9XNVBBcWxiaVM3dnBnSWlSYTJEdzdHdEgrdWRR?=
 =?utf-8?Q?4IWVtYJn8gUdAF8JkfH077LZWy3DEHurvKjC508ZUlpM=3D?=
X-OriginatorOrg: sct-15-20-9115-0-msonline-outlook-a092a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 16986495-9b84-4e5e-fa64-08ddfb1a19f1
X-MS-Exchange-CrossTenant-AuthSource: TY1PPFCDFFFA68A.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 03:26:08.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFCF247DC44

On 9/21/2025 4:38 AM, Andrew Jones wrote:
> From: Zong Li <zong.li@sifive.com>
>
> The parameter will be increased when we need to set up more fields
> in the device context. Use a data structure to wrap them up.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   drivers/iommu/riscv/iommu.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 901d02529a26..a44c67a848fa 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -988,7 +988,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>    * interim translation faults.
>    */
>   static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> -				     struct device *dev, u64 fsc, u64 ta)
> +				     struct device *dev, struct riscv_iommu_dc *new_dc)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct riscv_iommu_dc *dc;
> @@ -1022,10 +1022,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>   		tc = READ_ONCE(dc->tc);
> -		tc |= ta & RISCV_IOMMU_DC_TC_V;
> +		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
>   
> -		WRITE_ONCE(dc->fsc, fsc);
> -		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> +		WRITE_ONCE(dc->fsc, new_dc->fsc);
> +		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
Seems it will override all other fields in 'TA' except for the field of 
'PSCID'.
Should the other fields remain unchanged ?
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
>   		/* Update device context, write TC.V as the last step. */
>   		dma_wmb();
>   		WRITE_ONCE(dc->tc, tc);
> @@ -1304,20 +1304,20 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> -	u64 fsc, ta;
> +	struct riscv_iommu_dc dc = {0};
>   
>   	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
>   		return -ENODEV;
>   
> -	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
> -	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
> -	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> -	     RISCV_IOMMU_PC_TA_V;
> +	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
> +		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
> +	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> +			   RISCV_IOMMU_PC_TA_V;
>   
>   	if (riscv_iommu_bond_link(domain, dev))
>   		return -ENOMEM;
>   
> -	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = domain;
>   
> @@ -1408,9 +1408,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc = {0};
> +
> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>   
>   	/* Make device context invalid, translation requests will fault w/ #258 */
> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = NULL;
>   
> @@ -1429,8 +1432,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc = {0};
> +
> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
> +	dc.ta = RISCV_IOMMU_PC_TA_V;
>   
> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = NULL;
>   
