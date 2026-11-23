Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425493;
	b=DbuykTeRMz2K6EBt3UBD1iSeiUpj5MqZa74LXmIBcQ50X7H2lYMPigbVT7tNYcBdIarO
	 +pkVUHEANPYNWt5QH+Pz3OGcVs1+7qBn0KLyQd4G0wm5lIbecVybLU4No0FT8fyX9fFq0
	 OPaOVGVTPjRb0iFMM+Kjm9D726RPHPPizQ+P72Be7NAd4FnpdxIhQllx6pkKh0REpO5Bg
	 AzcZ96O/K/jDY8zyiabRezRtQyPkTF+r4aAvmOq88DQ68b2Z88IWZS4RQy98afKIdRuBu
	 dgc4Qx8z0qyUJi1vTMT2AxmKSZk07qbPNO+qMy7wpIFY5JWGmQexg3j4xL/M5BuE75Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425493;
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
	bh=RNha+b5ghOYPtQTvrFC0LCdN61qRtCI2WrlmZ2tq10s=;
	b=CUcRFeTjIBAXFvy+0xN0iWyX6qotoRJ4k0lSoC7Rmtvnt1neg6N9UPaP230LM8pfLsIQ
	 Sqnj+dhrHP2nfDRKRwzkfA/dPWL6GZccEeTtk38WRtkPRLrHmwABsrpxWn28XZgLGaDZC
	 TvK2nYMZvQhnfb1z0ybrYqgE7pYNxfkYduIgsWNrie5ALVNGxNvApOk5eH0Dbs6/BF+2C
	 oN5R9MsNrviya/yHCk50DcInhKwXQnaJ7JTpPIIqp9pv7BLmu9KaLRxjS4/YF6h8eSUl4
	 G4vNNOz6jUj4+vdCEMqXTe66OAKftEF3bujWDiVoxvxxDRsK3aV2OqcrcPrkhp+v9Ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n9N7wTiV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.20
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B9606A330
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 791B9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n9N7wTiV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfG2SFTTmhEVYdNZjvQDxer3gRXjcESb1tzxKxfskiV6A/w1ms2pvko7zKA4gc4qbQTZeW5CQjPWSD4paxY6XwJZg8MBHXeudT3W6y+mihGG5wytnC7v8djvsfqofVb9zCYSE+J01uGwu46mFb2UJvwT7Um1IMee8nVnEVOLafgBLCQaK+c7S34z7ABSCKmyr2hyBoDZJPX5deKcbnhPtg5reJJsVacZiZCk0Enku612948ke5f8s+8m9octl9HVhwLVb7UiRoWx6FIrYI+znJgAO+cfcSc+IYiNJQ8v5tkw+6ET2Xekxl48oxM1zr+ID4dtxqIzO9uxrqMpoT96Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNha+b5ghOYPtQTvrFC0LCdN61qRtCI2WrlmZ2tq10s=;
 b=i9eedC/EFBkA5ASSxFYzER0G2Ac3OW4STDhJBjKL0sawGMI/RQIRTDG6vfJqNLHnivSZiiamPFXQ2JZLaIx6NQkAwcLBWe3JD8pYS/Pmjipypq1siTdV4ifBcPWSTd9E+KWWeuJkuBlJ0MW6ClGmcFSGGlJGXmCTZcnf2ICYrWBjEQG93gqpk8Mwcdeh8zuCgxZe4aumHN7N01OAfqzamHCGlUIley4FSGXmb4sX4+QUidC6aYnvm24BxCNttf5xx3BVe3QmqXmWEsBaUJ3fNenoLH1W0KgU/Gd7MlBpLuQsW4roSSzsc+YeON2t4knhZ4ZJLwnlv/wyNeD28iA9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNha+b5ghOYPtQTvrFC0LCdN61qRtCI2WrlmZ2tq10s=;
 b=n9N7wTiVk4QnlaDaBxyJwks2I5tPtU3uCCYGaP/aiiRvv4dV0fAlGxvLC3xJ0VJYFwxr74hsaYpvtUZZXq2sa7U8GtHTweFI37i0L7VovhrF0HRg5FHhJsVxMGUB3tu5roRa7li48eaI/v7KZL73etnpwQb6hQfkXQLkWah/rQ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:18:09 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 09:18:08 +0000
Message-ID: <1ad6f235-ac3f-4afd-927f-246948c6b4b6@amd.com>
Date: Mon, 23 Nov 2026 14:48:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Skip device lookup when IRT caching is
 disabled
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261113095017.1835921-1-guanghuifeng@linux.alibaba.com>
 <20261113095017.1835921-2-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261113095017.1835921-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0331.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::9) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA0PPFA19DE7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 72890b3e-ae8c-46b3-f674-08df4942b071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s1egEQtHkZBqs66axPMJ1aOk1nHbMB6l4m4+bao0uD9Okwc+0J+bI854rWRFt25Rt77+GoQXfsJlUYQGl55hgNafAsLLL0RxGmcgF0xIcGuug/6sQHLFDF0ePxGni0XSj3aqyY1TtMz/UnzCtp/ZS7CXwAQm6CC4/+fHSmm5bhMQyqPWDHV/m3EB1S6hhVIQf25sid4j6jsw7D9eL7XTL7gyNSdkaVis9Fbm7bXcPQUvrTIXPca5eIHvktjDMkVvMccY+VU5FIVMScIIfVxDdR11+DF4J3ihAFpnWCNyapWqCHYVl7BKwsamU1zffGCcoAnDNb50v+4LArTgVbnL/T2hN9bgG2b9PU5YWL6bg1unF6MZwMqN0JnNWmt87YPofEwdGKlyQoRz7WUW6sOTvpP5wGvQxFOk+3zqknRup1pJUxFe+eSbOiOgXLvN8FK+5JBMtNXwaIRbcEpK5suBRpPs7BlzMzqiflUZOnVdOpru606XnVWW/SMhiEhCIjZEMGbac7B10m46tnMQ+KhhYcPAxrWFzy3Nx+tHknNR6m3oUXPqUU1Ln3nZ0PK+anhSpfukIM23UJLZkCQarU882IOF1P2JNz/y9IzvOFNMCMjIG4yY1p8Nv9azdFbIK+TNWdowPeWT3ZbwACIdPc9dfTgOTXxMjrwO6uhaKhfCKrE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xjSW9kdk1sOUhneVBQN0VLQUhjVDJlbk93a3RvTG5VcHFuNWhsM3ZpYTlo?=
 =?utf-8?B?YXJ2dHNmVUprMU0xVndqUURDaXRmOGJuZ3IxS3VFeitnc2xkRlN6bWp0WWJm?=
 =?utf-8?B?dnhkZ00vZ2x6YXQvWit1dmJVV1p2VnhsR1JQMXg3VXhKeXJYSWVWWlNCMTJr?=
 =?utf-8?B?MHpXV1diSENLN3k1SHhsNm84KzRuWWxqQmlka3R6N0phaHlZREY5OE15ekJx?=
 =?utf-8?B?bWNvQlhTYlJPdjlKMXIvZEwvLzd2RUVZelBTTE9aZ3pHNm1CZ001RU1yaDZU?=
 =?utf-8?B?dEZwOGZzd09tcTlUS3RWYTJ0M3h6SVFkTm1GVXRnN3FENGFuQ2tVeUVYV1F0?=
 =?utf-8?B?WFdGZ0dYbVRobHhRZGI1WlpmYzdhd2ZuRmpQRkRlZHNSVTFjVXN6dXJ5aE41?=
 =?utf-8?B?Wlo0UXB6TXpObEdkY2M3b3puMUN5c3hJYTRjLzZqQ1MrYlM3MmlWcGorNFM0?=
 =?utf-8?B?ZDNYVGZzZTRyU2hMR21XVVUzdXVGMDZpTzhKL09WWGdnd3RHN0JMOHhtaDlM?=
 =?utf-8?B?OHgwc3VOTHlMMEFrMDN6SGJqdHlrVm1HRGpCb3ZGMEdwQS9nMW45YjhqVEo0?=
 =?utf-8?B?VngySEsybWMxOHdKNjg0WkdSdkVYdUlqM0hMenhld1ZxUFFzaEZzS2gvUmtC?=
 =?utf-8?B?VmZCYkh4YXlwOW1malBLUTFGNXVMTWV2clEyUlQ5Z0NrLzdrc2o5alZwc3RK?=
 =?utf-8?B?amk4RW8wL2MvS0MvUHhYVEdBc3poTGROcVJTOWZmUnNMNnQyNCtGTWZPNU96?=
 =?utf-8?B?Y0pVYVJUZWExRE9iWmM1eHJzM08zMTRiT0EwTndER2x6c29aK3FTSnM0QkUw?=
 =?utf-8?B?RCt2RStuNVJIdUN4b1F5UkNGU1N1aVdLVW92b3JRS21lVmpuV0tSV0tYdy9p?=
 =?utf-8?B?SDJJNE1yOE9MR1NjM1FtRXZXOTdpMHdVTFdaeXBHaXBITXlpeCtpWWFpSTFR?=
 =?utf-8?B?bU9uUFZCUU9LblpjUjFGUUx1R0Y1clF2djZDa1dYcmxUaGhsbzdHdzFCYTVo?=
 =?utf-8?B?cVQzVDNPM0NCRmdwbXJzSy9wcDRQdFg5NGdRbDlWRmFhZlpCTXhRSWpUczMr?=
 =?utf-8?B?bEFKLzdsNGlSNVk1WXdRVGZBRnI3R1MxZlBmTmtxcFpjNk1HQWVIdm1mQ1hL?=
 =?utf-8?B?UWp6REkraVQ1V3pqMGdjZWtPSXpoeVRRYlNKRDFMRjVzUDlDT2RoZzd4NmxS?=
 =?utf-8?B?UWJ1WEhkZUoxZzZvRWtFTi9pZndCMTVpMGU4VXlJTkJGenV2NzN1NHVVZGFi?=
 =?utf-8?B?aldSZElHb1BzQ1QrUkRCSmNyeFB6eFB6eEdwOHA2N0JFYjZwNDN2bTkvV1dW?=
 =?utf-8?B?NlZRbmg3WExwQ0xreVl5YlRyYzdlSHMzL2x2cjh4Nm5zanpRVFFhVEp0V1J5?=
 =?utf-8?B?R2JaQUNkWlhWZS9FOG5zNGVoeDJuWTRQOVhvQTQ3SEdSUEE4WVB6RE45VnA5?=
 =?utf-8?B?eERvalFBV3ptNTlNOERqRmZtUjlRUDJmdXl5b2xwMXdZU3lyUFhCeGlmZ3U4?=
 =?utf-8?B?LytXZlBEUVFHZVp0cE0wcWpNWmozTTFmdHpmbU1vWkQ3RDJNdm5tZ0pJbmJQ?=
 =?utf-8?B?TTZsMFFUVXpVZGxCVXc2Mno3c2JnNWtWald5QXQ0YWV5Um1GT3RYWjJ0NzY3?=
 =?utf-8?B?Tmd0aWhheU9jMS96dlJuSGtyTjJXMHRpQTd2alhtVHdNZkJtSGh2ZHNaOUdt?=
 =?utf-8?B?bWx4ZUhvUy9jQmJ3VnQ4YitJejJGQ0RObUlwamZZR1U1V2piNmNxMHRuN29m?=
 =?utf-8?B?R0xZMS9PQlE1WW53V1VMOHFlZHZkcDVTV0dIeDNpdUk5cS9OSHg5bjFMODBq?=
 =?utf-8?B?Unh2aThBbzVVRzUwWFlaRUxydUJCYW5TVVU3ZDhYK2I1QTBEUlpnOU1uRUlk?=
 =?utf-8?B?WUgxa1lsN01RUm1vT3c3cjNBSjVwWDkycXhXSXliMHdqbnNqTjNuRFIrZ3pw?=
 =?utf-8?B?SjBQREhpdTBSbUxsK1UvRm5iTC8xeE5KTENjdFBQZVlxcTJzQU9kRVJOaXJG?=
 =?utf-8?B?cHFnbUNTTHc4VDZTR2Joak1xVlZEM0hLNGo5LzNTbzBNbk1HVldLSlZDOHZa?=
 =?utf-8?B?OGduYzZEQVR3WitxVGRHQjRveXVwMVNncWdoVFYrVTR0S3dhY1F3LzA5Y3lI?=
 =?utf-8?B?MzRMYnVmUCtGRm5nYnZYVW1LcHY4ZkxBbUpadG1OSWJYdW04MktxSEVCL0ZX?=
 =?utf-8?B?WVpGRlBnNUhab3BGWVlUNW5qNHZoUGRnS3FFSEpLRnllUWlSaFF1eG92NHlX?=
 =?utf-8?B?aEFiSFpCWGRnR3NrSzc4cWVGVEtFcSsvTlc4dGxUdHd0U3R0aXRyVlpybE5P?=
 =?utf-8?Q?VRU0tF0PzcDaWLzjPG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72890b3e-ae8c-46b3-f674-08df4942b071
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:18:08.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8aZpcUmUd5RkDWhfN/b2MJaWct9wdAIPTpfTVOkLTRkFsLy30VbDH08ioP7NOLsC2NYOvkS1iOYRLeKRe4ABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612

Hi Guanghui,


On 11/13/2026 3:20 PM, Guanghui Feng wrote:
> The DMA alias invalidation path looks up the device before checking
> irtcachedis_enabled. The lookup walks the PCI segment's device list,
> but its result is unused when IRT caching is disabled.
> 
> Nested VM entry and exit can switch multiple interrupt routes between
> guest and remapping modes, repeating this lookup for each IRTE update.
> A reported nested virtualization workload scans 4334 device entries per
> lookup, with median lookup latencies of 22-33 us despite IRT caching
> being disabled.
> 
> Move the lookup after the early return. This removes the unnecessary
> list walk without changing alias invalidation or completion handling
> when IRT caching is enabled.

Thanks for the analysis and the patch.

Patch 2/2 removes search_dev_data completely as dev_data is passed to this
function. Do we really need this patch?

-Vasant

