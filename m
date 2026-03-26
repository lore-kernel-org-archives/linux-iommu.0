Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012060.outbound.protection.outlook.com [52.103.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0925366072
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513229; cv=fail; b=oazekd8vlSmLkk31RIlCyMtW99vXjtoYwgGGHGVB92cbuCNJqy0ay+hRYJKTFzyv0KGh9RH3YGYCwmIR1caT9V/SRc5/VTs1BK9247eO0F7J6SYAtjakeyoM3jLsAGNvGlFg7AX0WOrrM7qEiqwrfvw2KGXhaygR15joJCEgzf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513229; c=relaxed/simple;
	bh=rAMKQ7hFIyt6Ue4sG7E3sP2gf+60ShNU9mQOz+B2aFk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H8Eg1eTavCAixR8XeSD/Q8/fsS2adClH0dHCadpaC3HvXrxm07kDQv5V8OZHrSKlPFznl0v46hqDrG81TvFnR68YNemB1pfQFdykJXWtQjHKl89j/8FVC8DfarJxETUO2NxQPOi0lsgSGbodspiZhioZRI+GN8rTWYxRQwurAPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=uyuqyXMR; arc=fail smtp.client-ip=52.103.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="uyuqyXMR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvFxAv+DtJhuDbfVQ+XjCQnY0OP1YeCJwwMRBlzPmufZlYOi1GpENpwjb8IsQ+BUKRQ0gLtdKAJ5uWi9QCad9Elmaxs+wAofTH1XuW22oruBlrGq68lm8VjmLTGtJ+6fWE8b4gSV1cWu/rUfJtL7iY08iURJxJg345+p42IG3d4zNJeI+YQIbKOxXtdGihHKaIly7NTyN4wBksaJ9l2kX07UqyS9P1/z5QSmjHWl7Gqe3+uTRAvev97OC+NuvKf4fMJijbGG617fj4+howyTchLKA8iydk/SWWUp0c9iBhIYTSnQ80VK9V0rtWOXVL+RBe7j3A8ZGgnPHXC8v6VbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtK/J8sHEaiWrRbZDMExkBtfCbvLn8F1/j2voyg+adg=;
 b=drlw0gOOhglN6Yl1jOVaOt/wOHSFX9lfV84oHu5IICJqntItrWFnWsv8nrCmpxqjmG+T4OPkQoH1q5ERVzOqjuIEN9o9y93U79p7M6LXjwt2enCDbodFSo1254lnPXaep1CQcG8gNlfhPJMf+Trz0s8siVrRL3s3/MOtt4fOwnb/Hc5/ZJH70eXxQCzeoDMNaNfqu3SKTnkQjBQorxWG0051huVpwOPNf8+/rvZ82JTOAZAiuu16kyBtYc7bMHGmmsGrtniWqK+GZSGmc11i81DTrMaQODfeFMdhUSIdWA/WizeLqc05giMfuckDtvw9F1YstFdPabTrHj/SbVR0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtK/J8sHEaiWrRbZDMExkBtfCbvLn8F1/j2voyg+adg=;
 b=uyuqyXMRN/PtgP4Mxqrv4Ij+7kEBwhVA/ghgPrT4zLLCZwT8yqLgQVueFH/IQmUqaOXuz6fzAr5Ty6US6qQhBkshZl/W+CBD1CRJ4LSGwqPPgPiRpg3HfZp9NMxsR4n04l9TDCXgLFiwpluKt8qPST/I5JWjyj2ejgF2SAzOqzC+/Ofb0gBhwfbzsZdLZOEbIMegZ14bnM1i+/NgIYwsii98AHZ/Nb8wZP6sqNWTpWx5T/Ncu8BtYrkGaMjE5XCdretu7a3qjV9ptBKegLvKT+cqc34nKc85M0W/VDb68zZFY5qGsp4C4LuZP7Iu826AGRpwqVmLSF46/ZNyyei01w==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY2PPFD25626FA6.apcprd01.prod.exchangelabs.com
 (2603:1096:408::3d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Thu, 26 Mar
 2026 08:20:23 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 08:20:23 +0000
Message-ID:
 <SI2PR01MB439380892F5AFD71B95B9B5CDC56A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Thu, 26 Mar 2026 16:20:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/amd: Recognize Hygon southbridge IOAPIC for
 interrupt remapping
To: Pu Wen <pu_wen@foxmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
 vasant.hegde@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB43930F54C5B058A26D768C5FDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <tencent_EA83212045B49C785F5B55047CD670E8FB0A@qq.com>
 <SI2PR01MB439392D470CAB8EAB472839EDC49A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <tencent_EEE4C4F7FAB342FCD386C3DB1F07C12E2205@qq.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <tencent_EEE4C4F7FAB342FCD386C3DB1F07C12E2205@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0081.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::7) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <6b893e71-2117-4d74-8582-b5d569e1c5cf@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY2PPFD25626FA6:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc17e97-74bc-49fc-4be1-08de8b108658
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXZ5XHxNrJCjRnjimRBgM6Sjuj6dVl+/NqHCgLGOd9lWbyq/Hq1/F48+7sYkqoTC+goLVTlKqqE/o5afkAQ2KUgWg9S1BReKmMs0kZOKS7ojgwRhXbw5uFP0osG3F6SpAfcLCcWOLiswKOXYdDHC18OqDMBejqKBKXpSoC9Ovs7RttpgxAnwYvY6UqFob6FF/SlN5SiDzl1HVbVLOcSfAQo63HJ4zqv5ODnI8zFqkElxK3yL1u6N6LAXH3lLJrAzQLBmlehjflEzG8bTMg89NSibDb+Uh0NLBsl5sEfXDu2xhbdyKOF6gegCrXw1bSFQcNGquZYhF+i0k9pG2ufZ9MaOrlr03u63X/feY8R5a8woUGJ4M6uElH/aoVdFAvDhqmYZOSFx/uWXAGw+W0+Mzj3g9MXZa7O/cRldrhn2szQv8AGoIKvWC5aR2KGdaZG+fjpCiwJyl7WAD8wb4UWcWRFbhep0DkdQCzfIRU9h63310w/xSVWvJnsS6Z68lXebTHGyO5zGOkMqRjG3JlDkO72Ryi+DYD92HMXdZuUQ09l7MKO9dCQr5BzeZTnc2iszrJrUlTt8N92sR+Wkutnp568XXy9saTVNou0rtELxHORO7euOkHq0RERPy/c5fz0dxZjW86JAKop6V3Fcb1KVe8Wdw7dQoHYyIUhCJYEnyKZEiVoeYa/c41+wpcw3dkAzkrghbGfb0swdzaz/zAN43gn2QjL8zicErPBc4uDxPFK2OCpTj7c5oo0NGC92lg8Fwc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|12121999013|51005399006|19110799012|23021999003|8060799015|37011999003|461199028|7042599007|6090799003|5072599009|15080799012|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFFHVGYvbllGblVMOEhPUW9MRDUyOHJCN2tiaW95bnlTaDNacGc3eDc4MWty?=
 =?utf-8?B?MDR2Y1RCdmQxak1kZFhDeURkamt0QitEMTB3TG1HMEVEa2h0ejNsdHZRRnpD?=
 =?utf-8?B?WkY4L1ZOaUhFdGIrakZTYU1KUmxrcHdWVm1iSEpCNTBybkVGOFJXdzJiVjlN?=
 =?utf-8?B?WktVMVFWVDBsNk5oeElVTHgxWU5wVTRNTFEzUVdVK2p3dHpXNzZtak1sQlJI?=
 =?utf-8?B?b2dyZFZNeVJzUy9Vcnh2cjFaZVN6aU16bUdMQmtZenBWUTNBVWlKVWVHOHFK?=
 =?utf-8?B?UUZEcEIrRWNYM0hyQ3hRbXFta1R2c2U3VFhaYklWVnRPSWhhYnhrSWg3UGF1?=
 =?utf-8?B?dDBtVlp4cE1TYUkzMVFtMDVpVHZ1WlYrTjBmTFRqZmRMQ0ljMWFDc3hOcVll?=
 =?utf-8?B?Y2p6YXM0dmpadUx1cDAwdUlncGhHS3prdExqSkJ0ZmwrendBeVlVSDkydVJo?=
 =?utf-8?B?VjVaZ1E1QmFtTXFNNmNTSUV0Vnh2L3NtbTE2aFhYZlZGc3JmSTdoWldGY3A3?=
 =?utf-8?B?NEEvUHk2RDlRZ21NVlR1T3FZUDdvMDZiZjB1ZWpZTmtlTHhNMzhUTXpQaFpl?=
 =?utf-8?B?c2dhMFBxTjRPVTJEVGtCVTJHdWZkcGZqM1lVSGxkRVNJOGdMSFdvM1NMOEhv?=
 =?utf-8?B?LzM1VU9KaENSWlZOd00rWGtJaEpMNFpMempQM3g5VTVvME1WZlByaUpyUXpz?=
 =?utf-8?B?VkhtUlhxbzFYalJJWkFiMWlQVGl0ZWErTFhITDkwSlg3c2k4L1RMVVFmMHVD?=
 =?utf-8?B?TDBxcnEza2ZCaXgzcWtrcFo3R2d0czRQY3dmTytjb0d4bjFLRStiVHdRL2hw?=
 =?utf-8?B?dWErRVRramNyOUhGOXUyQXB0MEJVcW85U3UvcXJaSmJRNWVSM0ZaTDlqSTYy?=
 =?utf-8?B?KzZwM2lDQkcwY2VZdWpDRy9UZ2pmSkN1RjR5ckV0K1AzTGtPUmdJdFJYd05j?=
 =?utf-8?B?MU52eWEra3NjZ1hrcVcyVngxNTgzQ2ZJODNNajROVzhOaEE2MGpJVmNaK3lv?=
 =?utf-8?B?cG9vcVF5cUVTdHhGeW9zNkRkbDlNdHBoL215a0hlMktaUlJTQk94ekF4eXBO?=
 =?utf-8?B?ZWJUcFBOT2lDcS9mVGVTMkxDWmNrM2lucHVaVERmK1QvTzN1WENYMG5UZFJh?=
 =?utf-8?B?bTE5QmF5aVJiZU9aSjF0c1ExcnR6dDNtYi9PYm1LcytwSzduNldBbm91b3VT?=
 =?utf-8?B?cldZQVBDR0ZudnYycmlwRjd6YU1WQVg4dGdvbS80NGFWVndCd21mTlpnVGlD?=
 =?utf-8?B?aHM1TENmZW12Rm9JclA2R1I0WVJLSHNacUhTcmFoTVpod3lhVFRUVEJ4REkz?=
 =?utf-8?B?OWR1YkxQR2QrQ0o0YnNtNWQ3aEErOXdNcGEzVXB5T2dTbERVNCtKMFBTb0dj?=
 =?utf-8?B?a3JtZHRrYUlSYlRlRzJRaTRsTEVVcnhnYnI0bk5ITGM1UERrQXFMWExhTGVC?=
 =?utf-8?B?Y2ZrcTZ1bG5Iei9ndE9ZeWV5NXd2WFY1b3k3eWdBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW45aGJsajhmTHQ0MHd5eDVJKzU0em1DOWpUNTV4UGdTY2FyRlZTQlIzSzFa?=
 =?utf-8?B?S285dDVpUWZtbzZ1Q2I0VU1UUXpIUXlGZ2JacVlBUTh4aDNRcVpqa1RnYUJS?=
 =?utf-8?B?cGtZMVB3S3lNVTRwaC82Q2hqR3RvRFZrd0lPTDNuNkNPeEFpVWpoL1Q0eDFx?=
 =?utf-8?B?MFdlVk11SFpoUllOU3VRamt5Q0d4UDdVdVNqL3V1R01MYldxR2hmcmU2TzNa?=
 =?utf-8?B?SjFBSkFJdFl4cHJpUGhLMzYyVkE5VEJxRXhyOStXd3hqS2pBWEs3djBJUzBO?=
 =?utf-8?B?SGFMdXlpdDU1MUUyUXo3cFhpRmRIOEI5OGVSUHhOSzJMT1pZcndMdWo4ZCtJ?=
 =?utf-8?B?dmQvRTNqSW1XQWhLK2lRakVKWHE5NVpnL2RLdDQ2WnhCamZBZ0VjOEpPaXYz?=
 =?utf-8?B?a25LbmM2RnJwYnk2N01YTms4WDRXQkMrYUU1OXhnVkh2N0Yya3NOc25YQzBR?=
 =?utf-8?B?NkJIaUtnNmhBZk5aU0pJQUpuWEN1VkZhaVNaKzk0TjFSQ2JzRzlzVUN0dTFi?=
 =?utf-8?B?QnRvSDQrN3dhdDNOWDYyanpncHBpVm15aXdRNmdPWUNBT3NmM3duZkgxM0dV?=
 =?utf-8?B?ajVTSlYxUkpBZmNkUVFNczN5MkZOUEFKd2NnZjRyNkdHekxHM0ZDdVQwTHMy?=
 =?utf-8?B?VksxL3N0WVRtZS9IMFgvUTQ0OUtkZHpnRkI0ZThZSnh3dmhzd2dMSDVJNXhs?=
 =?utf-8?B?bFBuRW9mK2JsSU9teGkySXF2bGNDMHBHc0RBS0I0UTc1RWFBd3d0bFRYaW13?=
 =?utf-8?B?SGs0cHh2dVFYalVUM1NueHN5K2lCTVJ3eUdJRnlFbGRoNmo5MHRDYXZPV3Nv?=
 =?utf-8?B?c1M5NHJFejNKMlpkZExlaHhmWUpKVlRDUTRVL05XT1ZZdS9IcHpTU0lRSE1E?=
 =?utf-8?B?RUY5b0NzNk1JVzZwM2E2L2JTMm1tRXBRdUdRNzFHKzZNSDBpanV4M3g2QjV4?=
 =?utf-8?B?MWN3cWhJRHlwRm5OSkxpREM0VEtRWmhvOUxxdkdLRmhoQVl6dXVXMXBqUStB?=
 =?utf-8?B?K2dKaUQvV2VwdGs0RXd3am9zb1l4aFo3dGY1K3JxT0d5RFMvZUtCQ1UraGYw?=
 =?utf-8?B?akVoajVCd2QvblpEWWFLWVJJOWxUdUpLcTkrRWVCZjR3VGRWTFNZY1JyZC9D?=
 =?utf-8?B?UEttWDlCWU04YXRvMDZ1eklZM1JITG9lWVkwQVcvL2NlUmF2VlBxcCsycTBZ?=
 =?utf-8?B?cmRIWjBZTGorYklyQzhxU2c2YnY2VnpxY0h6Q1YxWkxKU285NFRrZ1BpdG9N?=
 =?utf-8?B?dkFXdzNDR0pFZ2Q2Q01TOGhlRjhrbzJzZnVNcGltNzF1T3pVTUUwWm9PQjRH?=
 =?utf-8?B?NW5oeVZLUVdlZExMeFYzaHR3RVExZ0Q4dVpiMzFDdmJPb0FUNlcrVklMaC9T?=
 =?utf-8?B?TVNLc2VhK0hsZmIrb0taWGRaNkRDKzZPQWlrblRYdUtwVy9jNXdoR3BWcXIr?=
 =?utf-8?B?MjZCeUMyb0laNEpJSXhObGRCcVhPekRjbkh5OG9tbUZlZENhL0hERzUzbWJk?=
 =?utf-8?B?QzRHdEVlRE8vSC8ya21URHp4MnE1eDdhUVMwbjVseVQwQkZnUXI4aU55SldL?=
 =?utf-8?B?VlNGQXVlSVhad0VrZFFhclNWUDFGR2lTbGNKVXVOV2RUaFMzQml0N0RSbEo0?=
 =?utf-8?B?cjc4SWVOUjFtejZwVHZIZWJYK0FZZ2ZWZVdkN2RNdFdaaHZJR2FBY3dWcmdQ?=
 =?utf-8?B?VlBZT0VKNkoxa2pLaWFIRk96M2w1c0pBQWJWMUpIYnlzMmxGR0hqTHNoZ0N5?=
 =?utf-8?B?QWp2Z3FXRGpLZ2kxd1B4TXNLRzJ2MEJUMXhxSzBaTW8zZWdvY25TYVRZQ0Zt?=
 =?utf-8?B?VkZvZVlKajRnRTQ1bnNUYml4VWM3bWpTWUIwZmRaTGRhekxIcWRCWUgrK3Nn?=
 =?utf-8?Q?Ldobkt0uQodvl?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc17e97-74bc-49fc-4be1-08de8b108658
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 08:20:23.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFD25626FA6

On 3/25/26 7:37 PM, Pu Wen wrote:
> On 2026/3/25 19:23, Wei Wang wrote:
>> On 3/25/26 6:54 PM, Pu Wen wrote:
>>> On 2026/3/25 17:39, Wei Wang wrote:
>>>> Hygon systems use the AMD IOMMU driver but newer Hygon platforms report
>>>> the southbridge IOAPIC at a different PCI device (00:0b.0), whereas AMD
>>>> systems use device 00:14.0.
>>> ......
>>>> +/* SB IOAPIC device IDs */
>>>> +#define IOAPIC_SB_DEVID_AMD    ((0x00 << 8) | PCI_DEVFN(0x14, 0))
>>>> +#define IOAPIC_SB_DEVID_HYGON    ((0x00 << 8) | PCI_DEVFN(0x0b, 0))
>>> These macro definitions is not accurate, old Hygon processor also use
>>> device 0x14, as you mentioned device 0xb is only for 'newer Hygon 
>>> platforms'.
>>>
>>
>> Yes, I noticed that. I mentioned this in the commit log:
>>
>> Older Hygon systems still use the original AMD device ID (00:14.0) while
>> newer systems use 00:0b.0, so a strict CPU vendor check is insufficient.
>>
>> That is also why the code uses the logical OR:
>> if (devid == IOAPIC_SB_DEVID_AMD || devid == IOAPIC_SB_DEVID_HYGON)
> 
> IMO, if only newer Hygon processor will use device 0xb, the macro should
> use a exact name(eg: with a new Hygon family/model), let IOAPIC_SB_DEVID
> as the common macro for AMD and Hygon.

Yes, that's one naming convention. The one I used is based on the 
origination. IOAPIC_SB_DEVID_AMD originated from AMD, though it is 
reusable for Hygon.

The naming might not be that critical. I've been thinking maybe we need 
to make this more robust and scalable. Rather than hardcoding 
per‑vendor/per‑generation device IDs that may require patching every 
time a new architecture is released, we can actually get the Southbridge 
IOAPIC devid (the southbridge IOAPIC is part of the FCH) from PCI topo:

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 56ad020df494..c3940fafe3a0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3096,18 +3096,44 @@ static void __init free_iommu_resources(void)
         free_pci_segments();
  }

-/* SB IOAPIC is always on this device in AMD systems */
-#define IOAPIC_SB_DEVID                ((0x00 << 8) | PCI_DEVFN(0x14, 0))
+/*
+ * Find the Southbridge IOAPIC DevID before PCI probing. Scans Bus 0 
for the
+ * FCH (Southbridge) by looking for the ISA Bridge or SMBus identifier.
+ */
+static int __init get_sb_ioapic_devid_early(void)
+{
+       int dev;
+       u32 val;
+
+       /* Scan Bus 0, only checking Function 0 of each device */
+       for (dev = 0; dev < 32; dev++) {
+               val = read_pci_config(0, dev, 0, PCI_VENDOR_ID);
+               if (val == 0xffffffff)
+                       continue;
+
+               val = read_pci_config_16(0, dev, 0, PCI_CLASS_DEVICE);
+               if (val == PCI_CLASS_BRIDGE_ISA ||
+                   val == PCI_CLASS_SERIAL_SMBUS)
+                       return PCI_DEVID(0, PCI_DEVFN(dev, 0));
+       }
+
+       return -ENODEV;
+}

  static bool __init check_ioapic_information(void)
  {
         const char *fw_bug = FW_BUG;
         bool ret, has_sb_ioapic;
-       int idx;
+       int idx, sb_ioapic_devid = get_sb_ioapic_devid_early();

         has_sb_ioapic = false;
         ret           = false;

+       if (sb_ioapic_devid == -ENODEV) {
+               fw_bug = HW_ERR;
+               goto out;
+       }
+
         /*
          * If we have map overrides on the kernel command line the
          * messages in this function might not describe firmware bugs
@@ -3124,12 +3150,13 @@ static bool __init check_ioapic_information(void)
                         pr_err("%s: IOAPIC[%d] not in IVRS table\n",
                                 fw_bug, id);
                         ret = false;
-               } else if (devid == IOAPIC_SB_DEVID) {
+               } else if (devid == sb_ioapic_devid) {
                         has_sb_ioapic = true;
                         ret           = true;
                 }
         }

+out:
         if (!has_sb_ioapic) {
                 /*
                  * We expect the SB IOAPIC to be listed in the IVRS

