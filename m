Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA13F9F3A
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430378; cv=fail; b=jCkpu883MGGsZaxjl+QhusEUu6tlZ/xB/RlURqzlTAlfsZs2WVf+2F73j1feeat5F9i5hGBIGQDkBcEyR3he8TUd64fATGeLo0WVgzH+OadB+pWckymWuQpIeutSG5tv+v1N83RSbprYMEa4IdE6zTgtHODZw5zVwMvlcu1DFDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430378; c=relaxed/simple;
	bh=N1L5XQdvvFXSEElo7fUP5/Uu7AfcQ5iZiQbtn6H0Yfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ef8j+szMESwGooNDpgzZKqHOAVChkylstA3Mx+lk01WZXyCjGHRL53wsqvFN6dwO8BJPVOxf9HTfriZ0NvnevjG/LKf0Hlcs5ih/Gq8mgYgMfeLbr3ExFQMJUHyUkhM148bIhVvZKxRF9JZaXJKTXmvpq10G5DGiYYgcDdqBtJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TIV6VIDw; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TIV6VIDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuMB0y4z5f/ugR32mEN4jAo4bNSw8XGijir8PWJqtps/Jbjm6ljQMKFi2TlneehjH0hlfNAEMt5wwRzQhFYDC2JFVf4fgVtBZkmOgDcbBUyLc1UZWNON6PfRkc4BP9ay5S8eMxsa35a0NlO7DN5vPlQloWWRlD5Dw1aRbtJ3SW7MqCjCTatIQeCHqZ2Kp+xcjYeDKW8CyT6K6n0BbyMJYxpkPvhxHol245i/TPbuH/5YpKFPKtIbLjb9WccZef+gGaSYNb8TkI0UkesP9iiMLwPZQvF4wXBR6U4bkYxgrY+WqVFmgTvBgU7v5UNaMLLK8bJPl7KcUMArLY0RZFsP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEMMBwr/73nxs+B/p9BICFWaH/qVWnCOj070PmWMTTs=;
 b=gWIPvoYKTK4gYd5kMKTEx/nYHPitzv/cDzH+BuU6LTXYloGacLiI3jABibMW9nFh9Byi45hIA/FhttUFu2CF2br4DocfXUVkzVcMZa4kCWqzAfE9Kb/kCXLVMWFD8+GHaD8L1QJCEqMWO/YlKMznW8+Vq+cWkJf3bb97K60ZY2kSIAOeIscCcefDv2Uq2aQLuPvBwj3nPRpGpni81BgcP8CobNCuxr7aK1Mox8naBj2SlrYMz0jzqFYZXGd5ofkMZSDhfOCIv4i1N7rcrn93q1d8nEYxIS+iI+wSsnstTqNCfVtgE7yeS4z8Qlou5dyZfYOScIrS8LxiXcpC5b3uKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEMMBwr/73nxs+B/p9BICFWaH/qVWnCOj070PmWMTTs=;
 b=TIV6VIDwv8FF70+o8ejTUXlPX6QJtTF5jdHJZak8N2opByQFeaJ8+biZdeab3QZcroP/mOpjdFK0B51kkIwxmNe4k0TScPx7OHlJozep0fEXUkv72cO/p/AQPGTVk0N3mEWKVrlbVDJK8lkLktpy728tQzf/zy480I3dtWzmJ3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Tue, 11 Aug 2026 06:39:20 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Tue, 11 Aug 2026
 06:39:20 +0000
Message-ID: <f2076b03-c5dd-4efa-9ee1-1c1574378e11@amd.com>
Date: Tue, 11 Aug 2026 12:09:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add SNP page mode 0 support
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com,
 Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>
References: <20260723084332.11008-1-vasant.hegde@amd.com>
 <d7ba7ef4-cea1-4a2e-84ba-a0fb85af2824@amd.com> <anmCl1aePQO3xZhz@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <anmCl1aePQO3xZhz@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0204.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::14) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4a4ec1-7b0a-44f1-033f-08def77345ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	U0yA5IH2XP91c5Yxss7zJ5ugWxzQs4FpjZyuk+K7NCy6zUHrfhvGj1oyI/Tin8d/TcD8uTuYA94YRBfcHQIMBkmpsout4gqrFT1m3ejDC5lvZZKeM/Uk91bJyGlfpTCjU55n7+RmgzUb522wYlOtEKOv2doi/fMlRLWY0zqkZ+gk9b1v0JtywQfUZRxozqrGfxlyG5TVvRJA0rhCJAzBH5gWAptsV2qx061YOnKq+Rfnchyq5GFMFxM4fVzSbgFSfJHesP4+ThVAIrKj5iFowvJ7hbeYhmm9GhHvDvCFo2C9jxWkzs5XzOaydFnPQd58/zPbgzo0d5wREAxLcYBe7TW7RVggfFtsLIiHqosz85UTzw35Dwxxs5Yzc7iATkE7r8sSmrzBeooPnwlfaJL88juu3+5vCW9idr48BIZMoUeBo4s4Wm1cK/ZZvijw/Y6Lr7F6R8CflJwOK2HpOXd8Bercfp/hAOEZgvBg1dCyg3H7oAcskEXx2vWoYW51st50at76c68VyYIyVI8aYZBfbnxGEyMSK/lxJks0UOE/HR1QgkL21pFcfgNSa04sCMv9GttM1vFZODiga9GzNyaOoGNTP4NbIx0zKOuC7YnPFKgyZlVXwa/Q+hVCHMVsmAQ5G2y7kTvRFRHR1j0PXAho4QopPwsQ2SMs2WEzTzQzo5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2NiTlhkdzAyV0tUTGJ4QXRJZmtqR3ovYVJ1NzhWRmR0alljMXZsdVhYeDNl?=
 =?utf-8?B?REltb3hjZGlNVm9ZajA0WHdvWmNHRWhvK2o3ckRRRnNLZ0xxQUZQVzAwTEFm?=
 =?utf-8?B?OStqSlZUMyt0MStxeUMzV2Z0dFQzR0tUdUVlMXZ1cEhlMFFBNGdwQXN4MGpP?=
 =?utf-8?B?WWM3UHNZQjRoT2NFTjJBUmlkRHVqc0t3S0x4WHIvTDcyeHduZVg4OU96OTU2?=
 =?utf-8?B?alFtSkp3ZXVCMnVOTnFpK2FoYU5IL1BEUU93VENYdDByRkg3L2kwWmdVL1VE?=
 =?utf-8?B?SWsxT2VsR21jRFpHMWsvbE9aVWRja2w2RW05V0VtWko4d1hRbnVYSG9VZmZ6?=
 =?utf-8?B?VWhwYnRxMmg0YkthaW5IZGxOZk1PK0JyTUw0NWk1bzBDMFE1ZEJ4cGxIUDA3?=
 =?utf-8?B?aUsxR2FtNUdtV2lOcTFvVUhBbWt0NTJXUFJxRGVtMVFadTZ2Q2JEV3g0MGkx?=
 =?utf-8?B?eVo2bzZrUk44SEV5M1JWMkQveVFsTzgrTi92Q3BxNm00clA3V28yRHNOZ3FR?=
 =?utf-8?B?WGNUKy9UeVpNQ1M3aFZwbFZDM0hsOEV4T2kxekZVODgxUHBSbUVNUW1MUklt?=
 =?utf-8?B?RUdJeE1nd2Fpa21KTjMrc3hnNVIxbHdqcDBtVHAxTmRtZU9EemZBZVZ4bnVv?=
 =?utf-8?B?bnZjR0dVM1pxcVlqRjZyN2lINkcxbkh5S3hOUThnOVNZWUhhL240NTN5MVJX?=
 =?utf-8?B?eENodjdkcHZiOHRsM25JOUFTVVkzK2dDTnJIOTRwR3M0R1lEUldDVGZtYllM?=
 =?utf-8?B?UGdOTU1TZE8vRFBuc2xlZm5HUkxDQU1qY245KzlnMEtVckUrZ1diYUx5RFRL?=
 =?utf-8?B?Vzl5bkNNd0dmMUg3WDhDdDdmR1RWZmxhelhrbWtOVVZGaFBHTm9kOU5JYitC?=
 =?utf-8?B?VEs0NXVnVjhXcTh0Vm9CN00rQmVRZzcvY2pMaXdxcUdSM2FtMlhKbGZwR2Ja?=
 =?utf-8?B?aUpwdlc3Nmk5WGR4TFlrblAwNGY5RUR6YW4yZ0Y0blJScytjVWRlR2lubXUv?=
 =?utf-8?B?ODhCU3ozZTFkMzVZL3preWtVRFpyTmhDNmZ4bTlRWnA2d29WekxldGVub1h2?=
 =?utf-8?B?VHkyZW5PS0E1b0hsZnQrQ200TjdPM21ZcG1ZM0tQcnI4OHhpNjl3aitIL3Nk?=
 =?utf-8?B?OEtVRUFDTysvM1o0TjdCdmpZZFJSU0xIM0l6M2JkOWhjZDdpaTQ3cG9MeHN5?=
 =?utf-8?B?ZWdVRG11Y0VlK3lsOWxZTlhOQXdVdzJTcnpHRVU2VHRFRCtFdGFmcXlYN1A5?=
 =?utf-8?B?UWtKbVp5c283QXV0WVJURnl3SjdmQXA4cDFSNGc1K1hKMlg1QytoYXNOVXF5?=
 =?utf-8?B?anBEdjc4QkJpYW1TVEpBV0VQVDRuUzVoSkcybmxac3FLUzEwd24zU3JYQnl0?=
 =?utf-8?B?UkZhcmc1Uk9CaXVnOWc1QWx0NXlWVThQM3kxR0M3VTFIYVdhOTliQzU5UVJY?=
 =?utf-8?B?L3RFZldMVEM2YXVGaXV1eDN1ajRmZDZ5eWZMak1Fc0VJTUozYU1jMzFDTXlp?=
 =?utf-8?B?SmZXdy8wMStTN1JLSEE5VWVWaGx3QitVdmRwUXF0cUdJM1JjTWdiYjc2anVj?=
 =?utf-8?B?WjFSdHpQTUthUExydE5Zd3VsTEczMzJzejllS2tCN0xQR1o5eXh2UkhieU1x?=
 =?utf-8?B?dnQ3UUo1dExOU3FTMmplWW8wdzJCYmJNWXZlTTh4VnNlNHVXVGQwUER5SGR3?=
 =?utf-8?B?UEh1Y0luSkpQYm1Jdyt3eTFIOCtlZTZ5WUR5RW94UlNMNGZFejR1RFg2cW9s?=
 =?utf-8?B?QTZmb3NDSDRnY1ZwMmNrNW5TbkxyV0oxQ0h3eURVUUNFb3VOc1JTMGQxNWR5?=
 =?utf-8?B?bjVxbGY1RGRpTlJxMmxHYkZHWUp2cWcxc0ZGMlJ1UldGcW1VRU5MSFVKR0hn?=
 =?utf-8?B?VVl3bXh4VmVzaC94ekVlb0ZmTE5rSnl1KzlKR3dOR0orcnlKcGZrUFZqTW1m?=
 =?utf-8?B?aGJ5MDlkUTNJd05EajNFK0syYS9OcmpQWTZsWnBtbDBYLzdxRUgzMUY2OUdq?=
 =?utf-8?B?NmNBaXVRQnQwZFlxV2N6MGROZVBVdUluYmRqMWFhSlgvOWZibndoUGpjb1pQ?=
 =?utf-8?B?Yk9MMEc5OGd3aTBkNnE4K2luZ2lxOHlVd3lpbit4dU5CaFJzRkMzRVQ2Q2NY?=
 =?utf-8?B?SVZMWVFZcFZsSFNvRTk4WEVKbGFSeW1pR0w3anFaSHFTSi9aOHNQUys4T1o1?=
 =?utf-8?B?MFZzUFE5a3JSSUNXd3BoRlkzSzV6WElqeWREVUJjcS9NQlJndHpxeDl1cjVw?=
 =?utf-8?B?RGR3ZVlvYUhTZzF6REdVcHdQaE1acStZMkFBenZmczFWenZlY1RNQWpwdnFM?=
 =?utf-8?B?ekNaL2NRZmF2OVZRMmRiK2hCdjFid0E3WXhZdkUwUDFHTDQvaXFLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4a4ec1-7b0a-44f1-033f-08def77345ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 06:39:20.0138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge6cPzvAZJOzSafdoJGEflr9xlrPxpoGP0PqpHb0ZQuDCEOZKHpuSRLUVwgj3o1qwdNfj5vGJa7hQGuzYM8poQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168

Joerg,


On 8/10/2026 1:20 PM, Jörg Rödel wrote:
> Hi Vasant,
> 
> On Thu, Jul 23, 2026 at 02:16:37PM +0530, Vasant Hegde wrote:
>> Missed to mention. This patch applies on top of
>>
>> https://lore.kernel.org/linux-iommu/20260723061548.10187-1-vasant.hegde@amd.com/T/#t
> 
> Please include this into the repost of the above patch-set and base the series
> on the amd/amd-vi branch.


Sorry. I missed to send it as single series. I have rebased and sent v2 as
separate patch.

-Vasant

