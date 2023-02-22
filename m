Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2042.outbound.protection.outlook.com [40.92.91.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79352904
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 11:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVZ4Kuj4DJYjSF5Bhb5cdqFyCD7z3315f2ZKMP5c24j7RCAqOHnOJQyJWp7zUM06T5ycLXcIYqvDTJTuf8UnYl3eUuDVm0Zd0cQwRUV0SeWmEvZtUjas0rmSXJP/4tl6QID3vzoRW+HgdoNerADC7rQGfns+CWeVTvrCP7DMZOhghLARoq2Y/yhka/bSkff5RUU7kTicZb+mvCBVCr0vfCQZV75dK36atwnwqHVKtJXsVARCQ1rA1CQL70SfIVrmOeqaPdpcsUOthyzCrxOsdWlffQyOJ1qNE8AKD4S3IAw1eoAt/N1zYD/nznJcmTvw8PVoLKSZ0lIcuKtS23MpGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lfYLwCeaKhKYuycZ08K4wZ8mZo6NgS1cmYJ1udeP/U=;
 b=JkLEf+I1PoHW3s32v4lfIE81DHH4Ng5tmSAH9BRiazkx3uSBVLlm37BaJqv5CYU5zCIQgsSv68Mu4A0G81O5nyjGI5RYkgISQwAzUATbLJInKbJ7I7G6gWnZX0w5D3kEt1zewVQgSIhEX5BJjrV5InpuCTiOhVdj/4CdddB8LyxDfxIxvaQSjDTXB96UeZC6IkkKMgiRiyWyZKhkqrB6yGdQ9hvezUxUunKUHjhaFdDObGClKf0qANk1O09DrlrCNfAyi6otOR5mrOpxZOesGQ8nXhfchiGzzQiWjDaGBGt7LvplbBwEsjrlEAANF2Ms8gqfeUhKo3q175k2+3hp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lfYLwCeaKhKYuycZ08K4wZ8mZo6NgS1cmYJ1udeP/U=;
 b=sl5gxY0BnSBhDqfya1ssIgOUA052+THsvYXcuN7ZG9fVZafG9UH5I719j9+u7OJDSx47meXdV6GGCOzTe5nUDrnwE9ZwXjf6zYpqtQQ2fWBMxP/Kdu6zpaX1L5LC31tk/TfduNXUW/gtbXebXxCGpBVvoKwqDPTrtj9FB2htZKe125Rl7rG8yZecp4CcI2gWPd7JL910ZEuKJyi9Tahl5P2d0YZarEEl/JjEVlMa7WN7qTlGKx3K3WVin0iBYv79oF4KqAYVvv7I+qrY3jdZqHIL/d4Zoia8Gzpai910s4BmDWgDnUXRN2mgasmatWS9I9bYw5McSlxIRW88DFFT+A==
Received: from PAXP193MB2105.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:227::18)
 by PAXP193MB2281.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 11:53:27 +0000
Received: from PAXP193MB2105.EURP193.PROD.OUTLOOK.COM
 ([fe80::41a1:b397:cc3e:2ad5]) by PAXP193MB2105.EURP193.PROD.OUTLOOK.COM
 ([fe80::41a1:b397:cc3e:2ad5%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 11:53:27 +0000
Message-ID:
 <PAXP193MB2105A8519929AD3E4A508F25D2AA9@PAXP193MB2105.EURP193.PROD.OUTLOOK.COM>
Date: Wed, 22 Feb 2023 12:53:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SR-IOV on ARM64 system with SMMU
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
 <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <77bf61fd-485e-7162-c0d3-c1bd7735deaa@arm.com>
 <AS8P193MB2095CD44400D95C79C262249D2A59@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <e182594b-5cdb-881d-59c8-a20dc90b62fb@arm.com>
From: Martin Bayern <martinbayern@outlook.com>
In-Reply-To: <e182594b-5cdb-881d-59c8-a20dc90b62fb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [qUORHxQqbEKMYtMBwUCFdQrjhAH8vHPu]
X-ClientProxiedBy: ZR2P278CA0051.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::6) To PAXP193MB2105.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:227::18)
X-Microsoft-Original-Message-ID:
 <f7cfa685-9757-7b1d-ed41-757bae77e48f@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP193MB2105:EE_|PAXP193MB2281:EE_
X-MS-Office365-Filtering-Correlation-Id: b247ae7f-df70-4854-6c21-08db14cb686a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V+7E6v882Mw2SvwejIGrpUyywVpueikDjM0LU2KBjEntoyuC7qUZJ0mQ2YKng2Gwg9J5JEKZPO9oly4c8AfbzVX+CsFKRKtifTYnUIhlvwY95y+lEIrAV8Ro5gUP7EK3EQcZXC3t+PZvr4Jfoioy+kyYZ8XSfkAmEhoZyKkxwWLnO5V+gr5hhgrwwDVKARrNobaT5VczuJu637b6KWmViPkO/2c6fnSUEwLTQABhoZsClHkb3Z43sqg6AwDXaa8SGZ0Y+zkSiavgVAwfL7cpkcdmaP6pQG8SxkY86Yky1ttERVQYi0XzFhzmMAYSyUcV8erHYl4jkh1x8Shy062H5EVqJBP3/oMusLOpUXSYICJ1FUCl77yaemr1fX5NXwRopZR0T6vOrsPNEXQLlnOtK1jr5mfZUy6pmfXFUQtYMwaZgh6juGqcEp/Su7US6scLo8n6F6DhE8f8ZsUGkqgkCPa9nAGHqtoqmd2FtfUEuSZ+N4Edegi35/33oSxfgqGyVXBWLTAW4TonmeMBRH/fOLindEjbsS19BH+eWHEW27RdGU1cHlOTV9oNR8BEtZlQfrTclOanJPiYaR6yQvXP6+JaKdIvAw/gK8T09eIjuZoBZkcfD/0sZ+17MdsXJyd7NSDfIrxwQE+70MQ6bhJ//w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGkvcnVTc2IrZ3k1SVRrWm5ReldNek1OUC9yTVRBdDV5TklaQzAyOUF2R3U5?=
 =?utf-8?B?V2NGNUdTNTlmc2xuRHZXTEppM29qR0RZVjlxRTBlOFFhUzJXZ2k1K2U1WXFv?=
 =?utf-8?B?dzV1RndzcWJLU0RtYkpaa1FDMmlzcURoU3pUZWFRZ0gvTElQUzc2Wi9TRVcx?=
 =?utf-8?B?Z0RwWXV6TTEvT3JwL01Vbm9LQXJqMEZHTHBRdHNGK1pDS2lsSi8zNHNPa2xs?=
 =?utf-8?B?dGU0MHBUSjFpWW5XWktwN21TZ3IzUUhWZWJxbHdHVDJ6UHlqS3ZvNWFscTln?=
 =?utf-8?B?ZHYyS0ZsWnA5c09wTFlQaXRTdHUzTTBUNHNjU3FhcnpENmhaTjROdFg5NlVy?=
 =?utf-8?B?bUJQRU4reGxvL1lKdUZGcm5LQWtrekhDVCtFbGIvZ3ZhQVhWdUlBQWJ1NWdK?=
 =?utf-8?B?V0JHMUtsTkFPamFYZVFKbTgyaFpBVTV5eGUrQUMzeFZxWWVCOUgvQWNjSTBK?=
 =?utf-8?B?Y3JlcHM1VkVHUGE0d1FOUDczbGd6SGlPTXRiRC9DekVQLyt4aDN3akV1ZTBD?=
 =?utf-8?B?MjVlS0hyWnBIUk1SemtzZ2ZmcjRlVHZDR1dqYzgxRXZBcWttZzVsRW5xVW1D?=
 =?utf-8?B?U256cEVUM2lPUTZTV3ZWRVFGcTMreGJ2SlpXREtqOWFROWNFQU0vcFhNWEZI?=
 =?utf-8?B?a1NreUx1ZmNSbzhlc3pDbnhXcEc1S2dqdmdYTHpzdFNoTVV4ZHlLcElycFI2?=
 =?utf-8?B?RDg0NlcrajJ3TVlhcEo1VWlwS1QyVG04cmZNbUtad1dzdGJWaWswVTNLRzIy?=
 =?utf-8?B?MUliblp5MGhJSW5jSHU1YU5Dd0xYL1hVa2R3YTFRQy9zS3FIRlE0QU0zdWpP?=
 =?utf-8?B?dk5reWYzRFJ3U2psWnBQdklVSTA4VmZpWGdQZEN5RkZuYU9EcG81V093d0Zv?=
 =?utf-8?B?RE5nQ3hETE1PRUdOeHlVblQ5cnp4S1BFUXV6VlhkNzMwN1ltUGJiMFRBZVpy?=
 =?utf-8?B?K0RpM3BDaXN4Z0hCRHI0NTVFZkVRNXNLa3FTVDlVYVE4VkZIM21yamRxVUtX?=
 =?utf-8?B?eUJzTW81cUtmSXZ1NHdmbUFpVUJuNUpGelB3K0FwVkJtZE5IZWdpOG9UVTdF?=
 =?utf-8?B?SHBnY3E2TEhXb082OFZibW5yNlZ0V2lkYndVbmhRSnZ2S1hxeXhlMVgyZS9O?=
 =?utf-8?B?SkF3SklHZWt6YlA0cWtGalFvbXdNb2JWYW1VNTB0REdjbXh3NGZKRmNYc01Y?=
 =?utf-8?B?Q3F5MWpkcHFwZFlJRTBkYmlGR1B3TlZVdjViNjZhRFpOaVNhdUw0dGh5NktK?=
 =?utf-8?B?eTFwOUlXZFZ6TGFZZXA0SHVjK3dVQjhzQ1F1UGY5QWRXZ3hqZnM5TVJIb3dI?=
 =?utf-8?B?UjQyMUhhWk9uZ3M0R24wNnRhQ3ZIT0VMTng5K2pUQ0MrcWtxcGJSVFNaRFhz?=
 =?utf-8?B?WUtrMkpwVCsrekJTOWZIaHUydnJLUXJUYUlJVWFaN0FGU0pNZGhIdGdGOTV4?=
 =?utf-8?B?aXp0Lzd5cFhraWk4ekwrMGFCc3NIbXlRSk9aSGU1STJUUzNqazFiT2ZlWmwv?=
 =?utf-8?B?M2NONVM0MmdzbWVvTUw4M1NrcmxEc2lacEFlRmgrc0E2U1hjNkNSbGFLcGx5?=
 =?utf-8?B?K3R4dXZsWXgrcHJodDVFMWhWUzJDbWlYLzBBMVNtdnBpVFUwOUhsNEc2NEFV?=
 =?utf-8?B?M3NmVXBOeTRla2pHNWFHVStLY3R3ZmpXalNCajJpUVUxZVM0alE5eU1GVW9q?=
 =?utf-8?B?cmdoWmJRNE90bTAwTUhvbjVHMUpPYnV1ekg3WUFyTmhZSUdsWnNpU2RVQXk3?=
 =?utf-8?Q?zoF6LoiZv6VlBNOvHo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b247ae7f-df70-4854-6c21-08db14cb686a
X-MS-Exchange-CrossTenant-AuthSource: PAXP193MB2105.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 11:53:27.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2281

hi Robin

Thank you so much for your support on this!

On 21.02.23 8:30 PM, Robin Murphy wrote:
> The only actual solution to that problem is to make the platform 
> device not be in the group to begin with. As mentioned, that is 
> presumably because the PCIe node in the DT has an "iommus = ..." 
> property (not to be confused with the "iommu-map" properties which are 
> for the PCI side). I'd expect you could probably get away with 
> removing that - the only reason I can imagine it being functionally 
> necessary is if the root complex has internal DMA engines that the 
> downstream kernel is using.
>
> But yeah, by that point it's arguably just an exercise in achieving 
> satisfaction by making *something* work, rather than a really 
> practical prospect

I search the keyword string "iommus" in NVIDIA Orin/Xavier related 
dts/dtsi, but there is no iommus attribute node, nor iommu-map. Relevant 
questions have been posted in the NVIDIA forum, and I hope NVIDIA can 
respond. Please let me know if you have any other thoughts/suggestions. 
I'm currently working on study of the drivers of smmu and iommu, trying 
to figure out the root cause of it.

kind regards,

Martin

