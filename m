Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CB2586E2
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014242; cv=fail; b=ZREOPgq/Hh+rI0PWiTtJsgg4AG+T8YlDMtArc2wePCBB/1B/6iVCDqF0EeEO2nHDBHF5WRz5/M2HLoAI1EdUfVFtNa7d6pKii0VUdBOu+Igm0N5BQ1q5+nhwv9NA857LvbrI7ZSp27tdFOV8lRStoW48ilbYWb3OJwcbEeRx3zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014242; c=relaxed/simple;
	bh=Q/UTdgZ+zAAKIID/arc2EAQfeXhzpk3rn4xPYNLjIPo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NNLDS6qSFv1/mY3SfTVXgI59GB9w3h0c0L0OG2BohFvlSG9gCBC0eg5phu2gbS+aWucaM0g6pHaSXnWnBIAnM2LJLwoSheKuoC4x6h9MqdmTGGFMSYh6U19DhVNM5T6Af6Ra7BwcY4dLIxethfPygz6DTbbbNQDJ1QvqZ6YB2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YpooWo7M; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YpooWo7M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1YVjRTswJ2HjZFNBooKmYSy0CqRqt81aJa7kCdBRfMTftCkFolKlG2TM4jny/4KBT72a7XyMNdcJha5zMFelbVn9KN92LDfHh2wDxaJx8ZgKkFPt0k+LTMcoIUdlAe2Jg0+IrsVd/j8E7xqwlNdv42Bo30Y1yYA+XQZjsATNHP9Zzaas2WzlGRR6YPx376ZnfHHmrEElTWWzHVgIkS6Dr1S7LCwPlqqwUJ9zsWkhLcuUDnG41g88KrAhwVwPPDAFXd7C6wigYz+4MUUiuosAoY2XnGK6VJhk4HmUBWEYOE4M+ge+uUMbhuBNFm1BfTXr3i2QA5JLNBRmMoR3Kc2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctX7wxSv7l+F72SnhNhcS/BVRHwHMXmZxXbTyllTHX0=;
 b=H3ZyW5NoCwqF/eyWFFv5vK6irvxDtD1t7JK3XgbQ6EmE75rhunGKHjl+626YrAT7vpk5C1wiPz+J3M1ZursEC+7EzJr4MXPGBrrVxh7NB7SYJ4quBFH5n60OTN4dmAh6NbGNMYC9u8z1rZH3MOei9LA2w8jerh+QGgBOafyU43LTLNhW2WxJ9lgUQoFqc/cuA+fP4jEoTIVvbjVMVZTSeMUpR1Ra4ppV1RkJVGDJRJFtmw4/ifXyHf5v9JbTHER0rEoY27/rPSholiJXBRpPBp3CDGXqyo4CoJ6vowZFFg4JnKYKPQgjGXP6sBMkaLA+9BdMhrFGMOWuIZ7tMUoDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctX7wxSv7l+F72SnhNhcS/BVRHwHMXmZxXbTyllTHX0=;
 b=YpooWo7M5c15w4Ut3Add7RlOFm96vuJga6qahY8UUEG3ak1jLvn8QeVfDekKILlsh/TjDkVoB6b0HFBdkGQ5PI49bnFMf3GGBNCNY3WGsDSCLcZ3ewPx1nnMwNjd9qtiY5fU2iwnZSnlk8CP4dALAkKoIUJO4A+qGr7EXDFHigQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Wed, 30 Apr 2025 11:57:17 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:57:17 +0000
Message-ID: <252eb71c-9913-4199-8645-59d8a7513b10@amd.com>
Date: Wed, 30 Apr 2025 17:27:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Add efr[HATS] max v1 page table level
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <e11bcff900090636a547f03c77baeb35b43234f7.1745389415.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e11bcff900090636a547f03c77baeb35b43234f7.1745389415.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fff2d41-bce1-49cd-494c-08dd87de2750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHB5clg3MXNUajhrSlZHVWdjSjRBTThoaDl0UENIdGVjSUtKWjV2MmN0TDJ3?=
 =?utf-8?B?ODZmNzZZQW1EbmRLSEdtVWdpSW1uTi96bnVpbk5SRjdIOFJZTjFkTWZaeEFy?=
 =?utf-8?B?Q1hhdUxmRloxVVV3UVhBWUljY0xnbzZXRlk0bWZhWmx2TTZFSkEybjA4aXBl?=
 =?utf-8?B?S2c2NHJ6TDBHbnEyT3pkbUlJN2w5dDA1OWJrSjBQMGtYeW9BNWxsMVozQ0pr?=
 =?utf-8?B?dzl0ek5DbURhWFNHempqZDNLaldDdGRIRmFzOGRETFpwaUtwZ1E5RVhxblN1?=
 =?utf-8?B?clJPZDhhV0hPRysxNm8zdFc2QWFFcThnTitsNWU1Qk8rQkRmWllLTUt0V3VE?=
 =?utf-8?B?d1JJL2Jtc0tJUi9NTG5MdWxocDNjT3VzVm42RSszMUYvQTVjamRBeGxLcXlW?=
 =?utf-8?B?bEZVN1BMWXhhQVJCYmZXanRjeGs3VnYxWHY1cVNrTk9wZ3g5QVQxOXI2Znl4?=
 =?utf-8?B?TXR6Yk96MTZPUVpqRHdtUUdmcUt0NmJHTnBNT3hkV0VDdTlTS1FUeUsrcW9K?=
 =?utf-8?B?Sk1KZlVHbEphc0ZPYnpWVEZjcDByeUdyNE5WNkgySjVJL2Jkd2c3Z2hWTUtl?=
 =?utf-8?B?ck1qcFNIMC8yeForbm9XMGYyL3lFVnVkL1B0YlB6UGY3RUxlTGdnZmZEdHFJ?=
 =?utf-8?B?OHVsYndXakVLemdOdmpUYzR0ZGRrZFBFSWJzZzFKaTAwTEhmbGcvb1FiSzY2?=
 =?utf-8?B?MkozT2tvRHgxOW4rOHd6L0tXeWpDSG8zdlNVTEhHQmFlSk0wMS9qQkhwOG1w?=
 =?utf-8?B?cTF2d1ZIS050eDJMOXg1S28vUWM5RUQzd21iK0lMekFVS2RKcUQvNTI2emNR?=
 =?utf-8?B?aFpkK0FNMlRGQWo4THJ5M2hsczdwTHBKNUpSbHc1MWhabXFHRk9tYTBOeDI5?=
 =?utf-8?B?TTRpZk5jVlcrVTlhTWlabUFYeGdzTWtBb1NnVWtHTS9qZlBMYWdSSUttMTFN?=
 =?utf-8?B?UkE1cnc4ejRVNEUxZEpGbGtMaGo0QjdJYkFJa2R6STdEZ0p5d2sreFVCWGpL?=
 =?utf-8?B?OExjdVVzQVA5RFYyQW5EWldTbURLZXFqbmNhZ1lGaldTKzBaa3NaVzJCSG5s?=
 =?utf-8?B?OFY3OG9UUVZTNU5TamI5MUgxK2hJVU1TcmxJQy8rSEJvWWVXVXZWRndTSmFE?=
 =?utf-8?B?U0J1djYxRFIxSXFPOUtXV2R5ZUp3VVMwbkVlVmUzRU5QRXVUSHViZDVETXE0?=
 =?utf-8?B?WTVpakVBMXVoZ3k2Q0dNQUZHN2JKWGJEaSsrVXRGZFk4Qi9Na1VFZjd2eDBo?=
 =?utf-8?B?VitpZlptT3RmeTVwaGZtT3IzWlpnVGZ6UWtEbEg4Yi9aM2ZpdWllQlQ4U0U4?=
 =?utf-8?B?WElxQlp2TFZseEY3K3lVL05OdDZhL283NzFoRjhadzJveU5NN21qZStKWUJG?=
 =?utf-8?B?OC90NTMwd3hScUdPcEZSUWVzbDk1bTlJZ01aRWNZSmVONzhiTFZDWndjWFkv?=
 =?utf-8?B?SEJyaXNaN2tSM1g2K3pjbkpCcTNMNTB5U3BJbGYrK1hxdklTc2xLa1RaRGQ2?=
 =?utf-8?B?UjRjd0IyZktYbGlMMy9YWUVRZGN6ZGdsdmtlR3lKbFA0a1U5Y2piTEVUWElQ?=
 =?utf-8?B?V3ljdHljeE03djU0TnUrYy9MeHlVWXRQVWlGcUFuaTVCbDlHKzhZeW4wVHp5?=
 =?utf-8?B?LzBrRVJPRkJIRzB3T1d6Mmlya0I0ZmVEYUVSbG1TRWpwRm5FU3BmYWZJSlZi?=
 =?utf-8?B?cE5vcGxNZGhxWmNTR3Q2WHdQL3VtazAyajc5aFVodE1JNi9USE5pemVUYUFr?=
 =?utf-8?B?eUJjN2Znd0dRV3QybXRNYjl6OXVJbFNFeEhWbDlZdWtvQlBHaG56SVUyN3VB?=
 =?utf-8?B?TXRLeEpBVnh1STFRdkZ6bk9PUGVSeE5hSmRjZ2Q2V3Fzb1dPY2RKdkpXRjRx?=
 =?utf-8?B?ME9oUm5DMEZOUDlRbEd2bk03OVRyNkwvdG4zeDZXQ2hJM2U1b2hPSXBCMTY1?=
 =?utf-8?Q?Kw/124yJzuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVBZd2llVXdTT2g5OHlTLzJlbitOWmRja0N6RWlpc2k5SGowY2wyZ0RYcGgw?=
 =?utf-8?B?aTFkSzB3eXVKeENaS3JYTWowRFdtSDUxMlFvVnBHalY2R1ozM0hZN00zZzNl?=
 =?utf-8?B?eDAzK0R0YVFTMElEWVYvUVRiZEVZRndlZ2laelNadWxBd0FRWGJvOXcrTnJt?=
 =?utf-8?B?NmNFcTBhdVFkQkFwOFNlaHFiOG1zdkJ5ZmdRaVBqWlJvQnRLUWxsam5OM2VS?=
 =?utf-8?B?RVFtazNkaGlvU1VNU3ZoWjZqelhUNGhQYjczNHUvQW9rUlVlMUxDUW00cW0z?=
 =?utf-8?B?ZlZpT01ad00vZlpGSC9leXpXN2x3Y3JzbHFxR3RUZTgvR2NZMk9aYlBOajZO?=
 =?utf-8?B?Wk1uYUtzNmNOSnI0SVp1amlCaTFzNnZIQkVKRmJIQkpUTk5OMXBpQ2k3NUti?=
 =?utf-8?B?QnlzM0c0SUUwdWZVTmhDdkk0WjVFakF3NFMvR3BReUNFcnk0R3Bia0xzZFdT?=
 =?utf-8?B?NllXVTQ4SXZPV01Za3QzRTJCcE5uTFQzTjUrYzVpOThRbUpiYmkyMDhMMjhL?=
 =?utf-8?B?bW1la2x5dWVlLy9mTDdiTXBzbm1LTVFlQzEzeEZlWjZQTUVaT01la1dDR0NY?=
 =?utf-8?B?SStjV1M0ZFVmOXlWUkJLVkRyK1dIeGJ2eVdTZE5id0E4dGo4RGdqeUhnM3po?=
 =?utf-8?B?R1NtSjB0bFFJek5SL3N5UnMzbXJNMXlzQzljZ3ZWOG1hVnRiOWg3N2JSb3Zt?=
 =?utf-8?B?ZCtkcDZ1cTl1TGovajlYcjBpNlhMaUFrNXNIM2ovejVmTUJabWlJdFpPUTVV?=
 =?utf-8?B?eFZKSW1xWGpSeUlVT0J3SHg4c3RUT3h2Q0VyM2h6NlIvSFNWelVJNXFwdE9T?=
 =?utf-8?B?ZGJsNnRTSVk5RExFQjZnSzdLVTI3NkdqU0pVaG94Rmg2SW54M3hHRDBSR3BR?=
 =?utf-8?B?bVJYeGRGU0k1Y3Zwcmh6bHZmYStBVTJOR2IrQTJLZDNoc3VzZCs5NVFTV0o0?=
 =?utf-8?B?UWs0M3RJY1FoQVBTckhxVUthallWTGUrdUFaZEh4b21Va0RVRER4ZjVNN2Vx?=
 =?utf-8?B?Tmh0dmRLQVRhQ0l5R01nUlFZQy8wRFNOUTc3VThpZmY3SXpMeGFUbzNEWitk?=
 =?utf-8?B?dmNYNDl5ZEtkZnFtT201bTJFZTBJTUtpbU84SWo4TXh4QzFsZlNMendtWE9V?=
 =?utf-8?B?ZlloRzliSWNzRVBrMFdEb2lBYnpSTmlkRW9LK01iMUpDQmhDWlcwcEJlS25K?=
 =?utf-8?B?b0hEQUpIbFFibnRHYWNJZ0pMVXJDNGlabHNRWGlSYm5GNEVKenhmdTdYV3Fw?=
 =?utf-8?B?QW5QU2NnQzRpTWYxQkhwZjVlanlBU2RFS0tZQnhYV2lnZEloUVE5T21YYVNB?=
 =?utf-8?B?NmJ2dytWVmlpa3NXNmxUcDY5cmxab0NQOEh3RURDN1NRYzFkcHdaMXczd005?=
 =?utf-8?B?ZnhZNERuUVNCSEFqMjlRVXEwVWxjNjlqMHJ0MC9maFBsK2c5NGQ5ZnBpVmdy?=
 =?utf-8?B?cU81L2FNUDg2WFhNN3JEYmNUMWM4Mlo0VnRXb3E3a1NVYVBMM0ZvMXZxMjVB?=
 =?utf-8?B?ZThqT2pYTGJaTjZPZ1l3dWtaUWgwZEY1azY1akZyTUVqVGVDbFN3SG1HRDVG?=
 =?utf-8?B?eW16bm9yZndYanhaRlBxN2JseTcvcmptMWJBTTh4c3BIaFhhbEhHNzdKSGh6?=
 =?utf-8?B?YndMVXg5VmQxNUQvMnJyeHVFWmlublJQdkpvYndwUm01YkpnLzZvaWQ4d28r?=
 =?utf-8?B?VnY3VVZ3RGZ1cCt5b0U1TEpaQWRzMWN3Q1hKaktxK3VTUnlDSm1wSk9oL0xX?=
 =?utf-8?B?d3lUc2Y4cXptZk45UTh6d2d3UGlZLytvWTFIdXlhNnV0YUxNUXNpUTUzU281?=
 =?utf-8?B?RGNGMUZ4cVBIVm9ZbHEwd0Qxa2ZDTG9GcUlpZWpQSGhWQkg0eTN4bzhCd0RO?=
 =?utf-8?B?a0lKMHhoaHViQzVNSkhwdnljOGg2VlVDVjhaLy95THFsYnBsb2NXTC96eTht?=
 =?utf-8?B?Mi96TkNxdG9sVXFDNTM3cTA5eStqK1JWUWliMElKcHVCQzBUWTVVVWUvR2sy?=
 =?utf-8?B?dzZTNFVDQWZONUdRU2YxM1RKZ1ZCWnhyK1JlVVd0RThqTlcvYXI4YWk0SjVK?=
 =?utf-8?B?NFN6bTFCUW94bUlvVDViRUpYWjJ0NFRyazIyMWJFczlnRytTOSs2N25QZ1hp?=
 =?utf-8?Q?hmGQOItRu3YVUZMH7d+BowvWa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fff2d41-bce1-49cd-494c-08dd87de2750
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:57:17.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm23DSL8ot3hA/QjdaxOwiYC5WpVimraZ7ewkmPmq46ossLS0F3wvXreKPB6IlTtLo7nJGhblLQB+dFhWHSc9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

On 4/23/2025 12:20 PM, Ankit Soni wrote:
> The EFR[HATS] bits indicate maximum host translation level supported by
> IOMMU. Adding support to set the maximum host page table level as indicated
> by EFR[HATS]. If the HATS=11b (reserved), the driver will attempt to use
> guest page table for DMA API.
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

Minor nit.

> ---
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/init.c            | 16 ++++++++++++++++
>  drivers/iommu/amd/io_pgtable.c      |  4 ++--
>  drivers/iommu/amd/iommu.c           |  2 +-
>  5 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index bb14c4800dd0..0286120ad4a5 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -42,6 +42,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
>  extern int amd_iommu_guest_ir;
>  extern enum protection_domain_mode amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
> +extern u8 amd_iommu_hpt_level;
>  extern unsigned long amd_iommu_pgsize_bitmap;
>  extern bool amd_iommu_hatdis;
>  
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 284ff4309660..6bf81197c2c8 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -96,6 +96,7 @@
>  #define FEATURE_GA		BIT_ULL(7)
>  #define FEATURE_HE		BIT_ULL(8)
>  #define FEATURE_PC		BIT_ULL(9)
> +#define FEATURE_HATS		GENMASK_ULL(11, 10)
>  #define FEATURE_GATS		GENMASK_ULL(13, 12)
>  #define FEATURE_GLX		GENMASK_ULL(15, 14)
>  #define FEATURE_GAM_VAPIC	BIT_ULL(21)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f71b236c2af2..c713756fa44e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -152,6 +152,8 @@ bool amd_iommu_dump;
>  bool amd_iommu_irq_remap __read_mostly;
>  
>  enum protection_domain_mode amd_iommu_pgtable = PD_MODE_NONE;
> +/* Host page table level */
> +u8 amd_iommu_hpt_level;
>  /* Guest page table level */
>  int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
>  
> @@ -3052,6 +3054,7 @@ static int __init early_amd_iommu_init(void)
>  	struct acpi_table_header *ivrs_base;
>  	int ret;
>  	acpi_status status;
> +	u8 efr_hats;
>  
>  	if (!amd_iommu_detected)
>  		return -ENODEV;
> @@ -3096,6 +3099,19 @@ static int __init early_amd_iommu_init(void)
>  	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
>  		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
>  
> +	efr_hats = FIELD_GET(FEATURE_HATS, amd_iommu_efr);
> +	if (efr_hats != 0x3) {
> +		/*
> +		 * efr[HATS] bits specify the maximum host translation level
> +		 * supported, with LEVEL 4 being initial max level.
> +		 */
> +		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
> +	} else {
> +		pr_warn_once("Disable host address translation due to invalid max level (%#x).\n",

s/invalid max level/invalid translation level/

-Vasant


