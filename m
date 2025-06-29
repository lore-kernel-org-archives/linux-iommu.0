Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256B4C80
	for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751175992; cv=fail; b=Jf3XBKDeL++CZMKBICbrZKpHT8KvRacpC7kmdKULQrDPfQnqJ3P0crZSbqGhqljZC0W85Fo74XMQ4xLXaVCTjDpxc6x5mCg008RDHipIHIn/SmlH+ZatHg15bLljyTIgUj0NGIpfPQgtX9H/LXhjhVIA11VjPXRCIRoFT7LZwVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751175992; c=relaxed/simple;
	bh=Ppgsf7KWOA8JtHZQnluwbro07D1tcwmksXReFcqdNQ8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t2W0Fpi6P7a8lJdqZoOyTIK+DeZAaW/9ZUZankSJrQINdvnJpo81yoVFW/ztlPjymB6BV2bD+cD0vjn69EnovXhZdmNGZFN0HTp1Mom5BtdAI6ok5oucRIk8agrCmMC/kS5W/Olj/K2ySUWVE0YfSroYL4BhGN8fKs1jxIoaH+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VunURldI; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VunURldI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egLEMoYIwZx3l84uv0SsanDeD/+DUPCqWTH8gjJcmbpGEsv8fbeFSP/qBXnCRysLhyUa8yJXw6pzWfnSiDszjB/qAzKdoncgqwwuy4Omej0GgdSyB8DCSfXsBjKTtZvJLlA6ayKwrKAMKeY4kIYfM+0i5pZCJ4PzlnBzJM7Tohzc4dQyT9joDfGNZUji7wZ1WbySEhJxG5Bmag+rAbe8p2jZAjzpu1jOfMsR9LIdbg7MmaEO2Lbyy2/ypZG4XNLt30StbriHSfvslehaCTj5VdvDqL48Kap+x47wi5bsMH6ABF+GdLWOuf+cm83NgzV227usT44rb3UyqgjJSg1gQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvQHbSPQuu3Zst2Wwcsu9WnZ0xsgKvC5RjRzH+Bh/zw=;
 b=BqTh+GsX9l3zHsRNOwSg12lXwCSM+iH1C+Z1l10WFEbrELvQZjyHgzy8MofdufeN1YI+U8jj/IP3a2pxYbg9huy2bqgfBMk/bJrp6A/819NjqHkQcHg+yHNcSweQRH04of1+K6LlpdM8YQNbgP3Z1J/ZR0flhZjtUgqy1yUY/8CAlMJ1wZ/ZnKs5WSa0madmj/JNrxn+d5sCoRpScs4Jamx/rB9grSdRqfWeYGr0m8/RXyNxBcP+LJZRhHvqs/AGY8CzCbHN9EvXX7x0PFRa2lgC640FmsjUnfk3yaZWWj9BOeD1KUiHvmw3isvOJ/OaMgksmRQ5Q6W4gs+surzN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvQHbSPQuu3Zst2Wwcsu9WnZ0xsgKvC5RjRzH+Bh/zw=;
 b=VunURldIJtC576OYsqo7S5DDPiH1OgGBd7AJB7MQSrgULnNNB4ZofPOaMnw8y5bRKHmcXYM5EhSFMb5PcDv7h0erAyRJaQ+4wYWcX/4+4C0u1UTVTTJqifoERj2KDfLO0PEOPmDneMt8i9HbYCdB+SkyDx20YDoJwVpEb9KGmtw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Sun, 29 Jun
 2025 05:46:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Sun, 29 Jun 2025
 05:46:27 +0000
Message-ID: <5ff3f926-b57a-4fd0-ab75-52e82373c422@amd.com>
Date: Sun, 29 Jun 2025 11:16:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
 <20250604163647.1439-3-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250604163647.1439-3-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0075.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fb3df0-6175-41cd-a86b-08ddb6d04a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEpwSGZqc3FkeVRlL1l2eDR0MFFwdHBnWVRVTDFuNXJvaVpzbVdNNWhkdlo5?=
 =?utf-8?B?dm5Rck5OcldRV05wWm50NEtJSG5zdmpqTXQ5Q25wc3dROGJSYkkxRm8yeVVn?=
 =?utf-8?B?YXJpSnlyVVVsRUdXM3gwZ0wweHByUUw2QzRra0tkQ2NGUGg1SjBKODM3YVNj?=
 =?utf-8?B?SXMzMFNUL0pPOHZzdzBhUy9PVnR4SXNCTXBXWFZOaS9jL2duRE9PaWFrN2xp?=
 =?utf-8?B?Qm5KQlVEMzZPQ3NlbTRuRVZOVXFsWTlOcjJranIyUjRBWk5kSFRYZmFRQkNX?=
 =?utf-8?B?SmcwdnhKbTNJS0U2a1dzS09hMUVTYXM2dzc0cktNM3lmMjE4eS9jY0F6VjUv?=
 =?utf-8?B?blppYTZLOGJiNi92eUZXSUlUeG9qWk0xK2pqNGJsRlFQTU96aWRoSHNHM0Jw?=
 =?utf-8?B?WU1aK0tFNzhQNXVYeWVRMFp0eDJhQ1l0elZpdlZXTnQrdjI1aVRoR1dVVjBI?=
 =?utf-8?B?VGx3d3cxUUlMWkNpQ2w0SmdUdDVJL0V2amJtZWpTQkdVYkJLaWY4emFBRW1V?=
 =?utf-8?B?cUJ0N2s0MFA5OE1RMHpvbzRzek5BS04wcTVyOWhxK0N3TWVVbzcxb2Qyancz?=
 =?utf-8?B?MFBUcXZjUXRMbk1oSE44bjVjMWZlbHJ6VmlDbkdVMHdCK3d0bmhBQ20xMjlv?=
 =?utf-8?B?WDlkSW91T0s5cXZMc041cTBETlUwM1ZCNFNXTTQ4SEVtbis4Y2wxSENQZnY4?=
 =?utf-8?B?NjBWaE9qSXRPQlpmektCTkd5YTlVZmJpZ2dDZk5EdUNlc2x6VTR6QUpvYmxh?=
 =?utf-8?B?S1ZWUDhHWkYyVXJaRERHaktWQ05tZ29uYWtHV21MOVBWR2R3T0t5bEJ2bjlx?=
 =?utf-8?B?bWNpZS9iZFBrRGJpa01wQnlhS2haVWtXN245VUY2cmZiQVRWWXRjcGVDUTNY?=
 =?utf-8?B?bGlSZ2NGTFZUdnBhQW9GWldWTTRHUTNKV3lVL2dwUUdmcDRNV1JQMjZKenZV?=
 =?utf-8?B?T1FWQ0V5YWJTb3ZaR1RUZm16VEdjVG5EUXE3azB0UVR5ZFhwZVB2eVlFc0hq?=
 =?utf-8?B?bms4VmxvbVltZm0vak1ka3Bsc3E0YlhiUWEzVGRXb2ZQdjVPQXkrd2ttQzRh?=
 =?utf-8?B?UVBFSnlVUDRXUlhzbThrRTVpYlRqVmh6RkNhanh5Uk5Od3BmNDNCVU5pTWhF?=
 =?utf-8?B?U1RnSGU4N1hBTjFjWSt1bWUvSjlOZ21oaXB1aGpRMEFwMUZEWlpzQXpOTFp6?=
 =?utf-8?B?am9QN1NvaUcySkZ1NWp3VDAyMWtiUFIzT1d4MDEvVkJiYXErejVsM3pJYW1U?=
 =?utf-8?B?bEt0ZktLUGYyUzU2U2hKb0UxejdQRWovNWx6cHR0c3BUN2p2aU10dzIzTXNk?=
 =?utf-8?B?Z1RPTnBMOXgwa3AzUG9JWlBSOGZmOWd5R0Nmd016VzJhQnZLN2U5UkdHb2lV?=
 =?utf-8?B?N2xJZ3dsR1puRlR3bEVBSGh5c0dMQUEyeGFmUWp6bEZROXFBdUVQWG5zYUdV?=
 =?utf-8?B?NjlTQWZFTUU1L00wZ3ZIT0lOZWZyUE1ud3gyYjlhVWFaNkovdTZETk96MHdq?=
 =?utf-8?B?ejFnVDY0a0hXMGlhZnlvRHpKcGh5ZHk0N1lJdHBObWVEQzJROTVacUxicWFU?=
 =?utf-8?B?b2N2V0c4RFNoVFVVMWlka2haUWRLM3FtN2FMSjVxWUhyU3VPSUpKUXVUK282?=
 =?utf-8?B?TWRicW9jMkkrUCtiQmRWREZFVWlKQ0xLckc5NlhmWEZqWVZqRTd0eWVtRlNI?=
 =?utf-8?B?dkRyNURhM0hkT1VMZFRLQXNEbjNGNzgvakxhZTh4SzUycGtEZ0cySUZ0TUYz?=
 =?utf-8?B?ZXpCeFR4T2I3VTZYZ2huMXNIVDRaajFzL0pTMVhlMVozTVhKb2VGMXFGQlor?=
 =?utf-8?B?V29seFdyRS9paFIvRXRtMTdISnJmTmoyR0t6eHJYYWNFZVJuMUtHZXlLMW1j?=
 =?utf-8?B?NmptSTNSTHh5UFY3ZUovcXdsOWJ3bEt0MlVCNEFxaFZwZGh6dTRGeC91d0hT?=
 =?utf-8?Q?Bm/crZLR97k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0llTTZmcWFJSnFJUVZSRlFWbzhObXpiTW5uT1lzclNBamJoSXQra1gzeTF3?=
 =?utf-8?B?OUVkVWZlV2tQRFIrNVhnb2NOL3ZibDlCdStRSFBjZ01GTjFOREgrT1YwYmpQ?=
 =?utf-8?B?NTZnRTlsaDZqdzU1My9zWVNFaVhRTGRRR3lMVm90cUExaHhRYXNEeG43czVj?=
 =?utf-8?B?VzY2aTZqcVdYTGZoSmw0QkJNUUJHWkt0RWVWaG9tNnVKVFo1UG5STllJODZm?=
 =?utf-8?B?TUV3b0x5T290dlpRL2d3MVJwc3lYWTBFVUFLUWtERGRlZ01EQWU4SUYzam95?=
 =?utf-8?B?OEx1QmZnYnVUd1JYeG5veDJiZGhuMDRERlk2MlZ4d1FaL3pMRnlIckgraFpi?=
 =?utf-8?B?aURlL0RZcE9XZHhwRE44cUFNL0w1bSswV0o3NHhaYTAxbzJkNzRxT21KWHds?=
 =?utf-8?B?THVEU3ZYdStuSnRNdjZFUURwQ042MVRYYmM5UWxGK0NFWlFCQm04VHJGNXFR?=
 =?utf-8?B?RlozZlUzWE5ucjRWQ0lvQ0JWM1lIOGJ6Y29DT1FaNEQ2R0ZrcnppNTIvQUph?=
 =?utf-8?B?RUQzcmxPNElvNVhINzRVdW9UTndFcEplZnNTMTBGTHZyanUrTEovajVVQm83?=
 =?utf-8?B?NlFrdURBbUZnOXkyNWwzNDl4N25aTnZ4d1FhelppR0NtTENNRWJlSC9OODNU?=
 =?utf-8?B?Z3lJaXlQd0o5cWZRSHh5UTlic0NJZHdtMGo3TDc1YXR5bEljYy9kNXVkOVQy?=
 =?utf-8?B?QjArNGJ4d2lWd0dPZFNVdyt6Nis3NThDQWlaU2V2ZnhDdmNHOXFuUDFsMi9t?=
 =?utf-8?B?VVJoZVhyZnFCelRTNElaZ2EyVFlCcHY0VjVBdExPYWlHZlJmOWRoaXR5dzRs?=
 =?utf-8?B?SkFPaG9NQ1RhK2Zza2FCRjRIMzd4MWl3Uk0zb0x6MDJPQm5McTdhVzNUblIv?=
 =?utf-8?B?YWtyQU5BK1M5RXpzU0pmYzF6NzVXZFo3T2xMMTNDeEJyVDJtYzNyWE1nYVE0?=
 =?utf-8?B?UmxiRUlaOWg4eWdHMXVWMDNYQzZWQ093UWVzUUo4U3cxVmVHRGNYNS83cVNS?=
 =?utf-8?B?Y0k3cWZlRmtubTZ3dEd2eXZEdUpkL3RwOCt1OVNNMHE2T0xRZnhCOXNSbCtK?=
 =?utf-8?B?cHd6SzZNQUlnd0RWNjlMMXJRU20zejhaWnJPQ0c4NStucUdOeUY3bzBGbGhF?=
 =?utf-8?B?aTZ2TDEraVFCUnFYWitCNFNYWjBTeUlKdkZvcllQLy9Lb1U5b1JKSzRhMGE4?=
 =?utf-8?B?N09vRndOMzQ4RlFXa0FLOXhzSXRNRnYvMDlpYW95MUNZYnBrL3ZSZFZlUXBF?=
 =?utf-8?B?NFl3SjlwbnFkaDZDWGNpTU5mT2pxakk4Z0NEUHUrSUdUMnBuYjF6RUFKZ2ds?=
 =?utf-8?B?ZFoxWTBCcTVodkREUlluY2c0TWVwQUorUzI0TlBDbHNER2xuUG5EUW54RlNy?=
 =?utf-8?B?ZUUwaS9IbkVYMVJlMTV0bTdTZmEvT3FXYy9SWisrWWs4M29lSDZzTEt0dEdV?=
 =?utf-8?B?U3E0MC9yUWlqS2VXWVBwazdIUlcydTBESUVkYmNlNHkvV0UwSFNLZUJ0RTF6?=
 =?utf-8?B?N1dkMDlxLzRHSThQQXBtTndDUW5icHFwaHUwNFdzVGVFODNrdHdxVDROWFVS?=
 =?utf-8?B?R0ErR3ZWK0J6enYxVkRuYjc4RGdHZExmeGt0YXY3ZlFhdW1VT2FHc2pRYXRu?=
 =?utf-8?B?OVI1WUZ6YkZVMFdTUHk2TCtCRzZIbGFEQndKLzdLRlk1MUR4TFRLSGptTjJX?=
 =?utf-8?B?cTI0Uzg2NjRtdzRXQlhLSlNod0h1Qm1xZmpSZFlFS0ZacytXeW5wbGZmREdn?=
 =?utf-8?B?MzF4MDBlYldkd1hpSjZjdTJlWlhHZnAvODBFeFNjN3h1ekNENG5Sb1FTajZM?=
 =?utf-8?B?SjB2TTVVNEVRQ3ZzMXp6MTRhNlBibDZab2ZQQkozQ0krMi9ET3ltZGwwTk5p?=
 =?utf-8?B?RXI1aENSaXRLOWF5cXhOWmswNXRrYk4xVkU3UUthZFQwYTJSRDB6cVBZTXl3?=
 =?utf-8?B?R2poYUFsa3B6QTRJR2VTTlBkSUl1bVRuclJIb3E4Tm12TldNdndHdk1zZTNs?=
 =?utf-8?B?QUYxbUJZMXEreTNnejZRQ1pYTTlteHc5Sjc2U1IvTHdQN1Avd3IxdmNESUh5?=
 =?utf-8?B?d1ZLQmkrR2xTZDhYUUlHRk1WKzZqV3J6Wmp1K1Q4cUlFRVovM29xR2lKR0x6?=
 =?utf-8?Q?4C7ZV46dY8Po/e85MRr2begL7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fb3df0-6175-41cd-a86b-08ddb6d04a64
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 05:46:27.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbcnYJdfzPojeQ433ny/MCIrNUIseGRKuYgswBIVfKwWZPAcaEAg1hQME1h2WpzJqS+f021ireLCqJtajirMXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472



On 6/4/2025 10:06 PM, Dheeraj Kumar Srivastava wrote:
> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
> configured with on the system and is helpful to debug issues
> with IOMMU.
> 
> eg.
> -> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
>    # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>    # cat /sys/kernel/debug/iommu/amd/iommu00/mmio
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/debugfs.c         | 47 +++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5089b58e528a..38eca75f6ef1 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -796,6 +796,7 @@ struct amd_iommu {
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  	/* DebugFS Info */
>  	struct dentry *debugfs;
> +	int mmio_offset;

This is covered under DEBUGFS config. So this is fine.. but its nice if you
rename the variable such that it indicates its usage.

-Vasant

