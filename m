Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7230E85B
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 05:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195806; cv=fail; b=vGAXXCWo2tYO6vcQdAuqYXnVBwuvrgT7XyzCwupp54l1T4qtb6xSCiAXUsSYdb7gi33zvpggvLndwDDdy4iJvvDrm4EemDPHhrkEjMV9Cq0kqjDMWpLuvQCd+lSdPhYPlMshDyhl6+6Bry174ctQ/chPxXau0WuLcFcx36Xsg1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195806; c=relaxed/simple;
	bh=YSKY8/fGEPlC+TrWhy0KHevJ8GxDVXGFJ2Jp+wJQcxw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jeA4/8+YqLk9Wh94AbQG+gh4d1gnZ/GvYK2+VagzdTdP0UhUeIlwaVEJcbylE+RjaEsh7JaxubL0fAOOzvuArRRUsqnAO3MsSMcMCwIxcNwG48c9EEbekSCMSjNm861UuhdQmMet7cETRUulfIak2/UjHxGLJXw1aJq9Gs1II50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y0iyCU0X; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y0iyCU0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7/RKUK+g51IomLWxgi2rQSM/+NlIOPN0o3j5GIKnX7mYaQ0RfkNU0nt3iVRVzrowbgeb7Y31MuLR2l/XbPMD2aBXIP8P4j4hQnMkSjsWd7UwaVrerY0iEDxY1sLgRWiYLLk4dxSMn9wFUrCWrlGJDcYc/PCXCudn74zadQywWw8Ql36mZtjp2x097jh5zjvEGtKU1apnW+Rkg+iZTKTnwfsxiBp8iRFxTsQC0egog5nloe1kCdEKSVlKGZeI91cWNM8y77MK8fY50lVYyX/g9QYz+PubmD73gMcavUTAO+yianRtfBRPskD0JKzUIb26VL8NXc4ERo/UF0zMPfirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYsTTap70XfslyjJI2/mQLe5xl2Zz9Gl4qSswJwmBok=;
 b=YzF7TS3lahktROiXlbmS0M3C9rriXy+L7LZus2bk8XrQQ4yYj68mdJWJXEgbt3bYaYMMpGMdTbZLeUWx16sM40WxIG17BZQ2kiVDho+gFpoMPZ4cjBPdhqFQHEC86hTl7UvCdq8SdSyCvVhq5Y7LYi5jOdW6XIqeq8tMBaAgDaR/93oDppjkSbUjY8wpBLLIlrTCQc6Dkw5vrqS/DvXMP+rbI9uEF++xLYf/AeaexDP1eE5d+2T6ExDkMYusihgDDUGIgx+jjrt24ZH6AN1P3bEnEu78qKxeRKg6p8QAzw85MiiUIQ0A9I2ItlZO+/I3nc5bFFaMNZQiQ3ky2pJoHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYsTTap70XfslyjJI2/mQLe5xl2Zz9Gl4qSswJwmBok=;
 b=Y0iyCU0Xi51lcTunmT0txPHaJuR+Rw2nmGMoLaIfhcpIYTlTAe9oBaCSvZPsUJwuZIdHYomKIMxAF5FZWiGhE0I6tXmV5EgoC689b9SiFBE4Dw3WYcCRPFf0vnoh7zhpVkekHkggqUfEJFhvsL7OED/vF9E0CJopYpbiRU1wYnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 05:30:02 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9499.003; Mon, 12 Jan 2026
 05:30:02 +0000
Message-ID: <4526ca31-71a4-4b3f-b378-32546eb8133d@amd.com>
Date: Mon, 12 Jan 2026 10:59:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: simplify list initialization in
 iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
To: Can Peng <pengcan@kylinos.cn>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, Markus.Elfring@web.de
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260112032116.49781-1-pengcan@kylinos.cn>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260112032116.49781-1-pengcan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: f1889a9e-123d-4574-d903-08de519ba297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1Ybm1RWVhVR0pQSi9TeTJDMDJuY2REZ1R5SEZseDJyRmlteSsxTjZuRmJU?=
 =?utf-8?B?VWpVaGlROGQwUHBBSmF1MkppbnVJN1NkUStiWGNwdWx3Mm1ZYjhtcFdzZDY1?=
 =?utf-8?B?NGtxRUFxUldaL3dTdDVLU2JZb284UjFzcTBSb2pYZU1pOHhRellvTURUVlZM?=
 =?utf-8?B?a0ZQakZVblI2NWtmMzdlWXhoY2ZCMjZoQ0tBaDlhNlNuWEJkWEpPK2IxR3dk?=
 =?utf-8?B?T3krVUw5amMzcVZyUEJmZEIxbU90MXJaVkUvOHhHN09RQmdpU1R4bU1lOWxl?=
 =?utf-8?B?MGF6Mzd2elk0L3RxSXJCcTBnbWtocllGcVA4NjNqRk9UTlh6ZUFVcVNlb2pj?=
 =?utf-8?B?bHdHaEVrbVMxRDRaNk11dnhKTDlDdnJaM3VhQ2NUM09UbFpnM2xwQ28rTFN1?=
 =?utf-8?B?LytDTUEvN24yNmJBcmlHcGFaSndadEgzT2JRRjZxRnBxV0dYSnV2T0NaS3hI?=
 =?utf-8?B?TlFqVjFnNHo4Z1ExWkJnVEpBSkVzRGlXZkRYZkM0TVdDKzE1ZkdlbkJLWWtG?=
 =?utf-8?B?eVAzTnV3OUlUZVpIS05QeUFFSDJqREU0MTh0dWQ0Mnlma3JKSG5oVnNVTEZ0?=
 =?utf-8?B?ZVhHY2M4MkhEYXBiV3pySGphUUkxRXEwVTNEWFRNSVpuYmZ0QmQ3bkIvazZ4?=
 =?utf-8?B?aU1Kenc1VFpZQU5BelNQNTZzakNzMWk1bHhjL3V6ODk0NUxOS0VVK0hnN2E3?=
 =?utf-8?B?Vm5VWDg2bER2Uk5uU2tOclE5ZkdmczRUVFVQRzcxRk9iU3gxME9Qc0JtdzNL?=
 =?utf-8?B?T1VTV015WDJ1YzFEeUw1bGNGeFhhY2hDZGRxOEZxeHFZYmdiRXREYU03Wkxw?=
 =?utf-8?B?ZjM3a21DSTA5ait2YW54bHIwWkJhSmJPaW9TMnV2QXM5R3NhNnlMaUFxUndz?=
 =?utf-8?B?cDJYMkVIS282cmxQVDNnRXcrTFhhenpNSzJ3VVljekdsa3ljbGROdUJRVFU5?=
 =?utf-8?B?bmlRK3A2cUZoVEZ6T3dsODFHc2dkaUIrOE5JbVFpSVI4T0hNTklPQmJDYlBQ?=
 =?utf-8?B?OVQ1VkZHZEljYmswKzFXQkVlQ2t4V3R4QkNEM3VYR1F5dmFMUWVKUmVvZ2V6?=
 =?utf-8?B?Tnppd3pQUUJKNFU1WGxkMkNYeEdGblg3NXFHd1haaGlzL0RCYUJZTTZYdTRa?=
 =?utf-8?B?TTVMQjY0MTV1aUdwZ0R0QlBQd1RjNHVYRDVUbFh6QWtxWHc1cDJpdFZIeVdS?=
 =?utf-8?B?aFlHMWV0U3RZcW91NFR2MGw4am9YdWZlQko3MEVSWGVtUWZQTjRyZ3U4Z2Vv?=
 =?utf-8?B?MytkSjgxeitFVkNOOS9sRUorRElDRm1lR0Fpakl5M0NpS0luamVkaHg4MHVu?=
 =?utf-8?B?YjVHNit6QzNYaEVxQXpQN3dmUCtnV203SFU2SjlNRGlXY0FhUU9CSWVIV0lT?=
 =?utf-8?B?dWRUS2hoZWhUS2h4RFpNZDdvZUdjdnBuU293dEJwblg5VXpqODlmZVRoaUtx?=
 =?utf-8?B?dkxhNkZya2tkSTJqVWF6aHZxR1NKdHpMSXZDVS9Rb2FlV3JvSUlTekhjL2x1?=
 =?utf-8?B?TkZIN3QwcmtjV292SVNoVHZtY3ZGRitKbHJLNTRlaTBRK2kxVlpZOExyRlhU?=
 =?utf-8?B?ZlhPbVlxS25NWk1LZm1WZHNBYmVaK0VTU2xSalljYS9FRk9UeWJGZXd4d1ZP?=
 =?utf-8?B?djVmRnBPMlJaVHppKzVKU3RZR1RoV3pCTE1FTGNlV2ZpczlJZWw1WWFyVjRx?=
 =?utf-8?B?bndaZk1GdzBhSExpRjAraE4rSW1Ba3VaYmh5OFhaSXlZSlFmVEVsak94THdD?=
 =?utf-8?B?SE93TUxiYXZheC81TDFVWVJNKzNpcTNrbDA2dnllelVFTG5Dbk1QVVZ2c2s0?=
 =?utf-8?B?NnhWTWJFNHlJckV6b3EzYWxFWXdzZjJ0UWpWUHZ2ZTRHVk5IeWplZDRjTzM4?=
 =?utf-8?B?NXVSQTU3UjdUeGlweUFsejRxYnQyQ1E4ZUp3dytSVjFXcGxDMFNPOXUrZU10?=
 =?utf-8?Q?fq4p7yDH7BB4t+TY+N/AxYGxa+vP11LS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTluR2pZTlZFcGN1ZVdSUDJuSjJJak5ncUM0OHZ0SmRqcHlKSGZQZjY0ZnJ3?=
 =?utf-8?B?SWJqcmpCVDlPQXNVRVE1T3ZGV20rV29PT3hJV04rNVpSWEdCMzNCbERIQmEr?=
 =?utf-8?B?L1QzUUpyb2FzVXVyRHhJWTlXaUxQd2FuMy9OVHJGb3VycXkrQU9RbTRORlB4?=
 =?utf-8?B?YzdhSC85SUFhVFlYa2xWaEpvRDBaMW1VQUNhNkZVR0tseUc3c2FLd1Qwa1N4?=
 =?utf-8?B?cTRnazMzTFh5S08zTHd2aTBrOHZubXFWYWxVL2lTMytaZUw1VEtFWlRvc1dw?=
 =?utf-8?B?SkRFYVU0Z2YyVGRtL2RUOGwwUUFpNEt1Slh3S1gvV0t0L1V2cHI2TkkwL0pK?=
 =?utf-8?B?Tm5QbWFXTDNpQzhOT0NBSVdldlF6UVpqd1Y4Znl4UTNNU0ZKcTk3K1RjY1R1?=
 =?utf-8?B?T2dxSlIyQ0J6cENTZHpPei9hbW9JNStIMTJtcmdZSE9pQTFrWUVwRUE1TklG?=
 =?utf-8?B?a1k1SldKMVp2R2xuZ0MyQTdCeGxHUHM4SkJZaG1HaklHVGc5T2RoM0dadW1D?=
 =?utf-8?B?OVNrL1d1VGFZWkh0UCtTbmlLaExNb2JGWEthRXZjbFlobjUweFNLZktYM0RS?=
 =?utf-8?B?ZE9UMWdTb3U5WmIwWTd1QUF6QzJ4c3J3YldCekFSYnZKU0tBTTc0VVBhTjVs?=
 =?utf-8?B?eVZ5NDFQclluUXhFQ3FKWUlBaEhaa3FxdEk5Nk90d2syZWFTbktZMlhmd0pU?=
 =?utf-8?B?RzZlMER0enBzUXlkK2UzNllYRHFDdkoyYVpIdmdkYjEzdk5YNEY0UTZxN2RC?=
 =?utf-8?B?OWVsNEpVdjZjR2J3Y3JpSEZRMFFHRHNnNWI4RmNZWnRZTVl2cDFyL0lvQm43?=
 =?utf-8?B?MVloWUs1cUt3eHNieEJ0MVQ2YTRSV3BGSG5XMUFEcjdQdWxodDBJMTE3T1lQ?=
 =?utf-8?B?UFdPeUo3b2x5dlNnVlFiKy96TEJ3Tm8rNW8zQ2xHNjdwK0x1V1B6eEZLNWdE?=
 =?utf-8?B?NnhldDM4WndpSGNUMGdrUEpieDUzVmE1OERoTHNNK21jR0RpWnUvaCsyNTRW?=
 =?utf-8?B?MmdINjBDbU1WaXdGTE5EOEJuNGpFSzFSa1hxdG5Nd2VkR09tdU1ocDlhNXRi?=
 =?utf-8?B?ZzRSRHMzK3hIb2JxSnRwOTJBc3JGK2EvVENJalRvYUVyaWkwZnY4VG5hUFZh?=
 =?utf-8?B?eEMzU3ZxUjBjR3g1QjJlUUtCM01jQ0NLaE9ackEvVlcxZ1kvbVRTT3BKWmM0?=
 =?utf-8?B?ZUtDM2NjdUVOWEF6K01XUnFLUnhVQ0g0dnNMTlNJZ2M4Nk42aTFUeEcwMmlU?=
 =?utf-8?B?K1p3OTdRSVJDZXlYcmtwNEZVaG1nakNQU0JqR0ozZXI3N1JmYmUxZlhLMkZx?=
 =?utf-8?B?LzdKeGZWcmxjeUJwUVZjVWhLYkl5dE43MUNoc2Z0NjQ1Wm1TbENjNUV3VTJC?=
 =?utf-8?B?Q21lcXlQazQ4WnhaSXB6L04rdWN0SnZSQzNNUGtJUTRnZmFrVXMzelZEc3hI?=
 =?utf-8?B?RkhVRWpQd0tLeGJSNUJ6T3Nqb08xdUh3VFQ5RXhDbTZabzVRQjZqUjQ0dklD?=
 =?utf-8?B?QmVXdTFXRXJzMjB4V3gxNExraW5iNlBNTTg2RXowSmF3allNc1dKcDlMZUlW?=
 =?utf-8?B?V2lOWTlLWjZubmdjYnQzdURNbENuR3pPL0dKRUtPWjNNb3RGdjcxS1U2Y3RC?=
 =?utf-8?B?OVM3Tk85WEUwbWJOUWMydm41VnJyTVdmaTluS2hRdzBCMVhhZm9DUFVlYlR3?=
 =?utf-8?B?K052Vkhob1lmemZJTU9KajlDUkdjajlMRmxKcWFWNmZtRzE4OWpJOUVmMnF2?=
 =?utf-8?B?QW0zbTFNTUU3c3V2SGoyNGc3N29OQzIzVHJZNlN4SG9yK2prbm02aHJhdWlG?=
 =?utf-8?B?KzhNRStFZHYxODFlM0wwdjB0T0E2VDV1WjRibTh3b0R4SHlESDBjb0VhdVAx?=
 =?utf-8?B?VEthTUh3VVZuand6K2RMUWFGdk5pUFg0NUdCK1BFQmFheWFZaFhHTU9GbTlT?=
 =?utf-8?B?d1U0dXNhM0RCdmNsRTNYNmtvOTFiOCsyQVhxMS9SOWx2SnFyZGs5RXpLaUIy?=
 =?utf-8?B?Y2t6eUZIejVKdnpuNjhZNVEzcHpWSUhaNnlqb09Hc0doUG5yQlF2ZEFSc2Y3?=
 =?utf-8?B?d3F2STFseW5TTnhMTFNZeXFUWm1oY3U4YWZ3bWdCY1ZuQmNWMThkN2JWc3ls?=
 =?utf-8?B?V2RuUFZraTUzOG5KTThnL2tJNU0yM0sxc2lJbUxBRDFPNXlJbWlaRHA3QkE3?=
 =?utf-8?B?UmlCRjlzMnl5WmhhTmNkYkpoOWpuemdWd002ZDQyaDdxMXV5aUZCKzcrZ0h6?=
 =?utf-8?B?TXMwbFJZenlFZkQwQzl3REFyQmI3RUs0YVN0TjVDdHN0WVNiaFlVNWwzTWI1?=
 =?utf-8?B?NEdMVllvNVRXc2RtdnhJRStHRVlIOFNmZWR3S3FDbFgwb2UwbUVvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1889a9e-123d-4574-d903-08de519ba297
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 05:30:02.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRDZgZr6CN9iSHg5VGQoIZE9hKZFT5Ggzn6xY+L2IoJndKbuOmuGU/oNP1zL7g6Rk0pm4sTqU4fJPpaKrJeRow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

On 1/12/2026 8:51 AM, Can Peng wrote:
> Use LIST_HEAD() to declare and initialize list heads in both
> iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
> instead of separate declaration and INIT_LIST_HEAD(). This simplifies the
> code by combining declaration and initialization into a single idiomatic
> form, improving readability without changing functionality.
> 
> Signed-off-by: Can Peng <pengcan@kylinos.cn>

Patch looks good.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

