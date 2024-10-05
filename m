Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F27231C96
	for <iommu@lists.linux.dev>; Sat,  5 Oct 2024 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728093215; cv=fail; b=oR1fGQ8ReX661ZhZahP0l+crFiuqdZz8HTLDzx1OLfw2gtUx1LzmZzD51T8bhYhsKf5md0RdgrkXjCVDj3Jgm572wtcxR/lT2k+MlVPCRcFqexi+f20AMdKIZ4MwIconAcXvYEl3jrEGUH1r1aI97kern7iiOLp2b2yQhihOKSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728093215; c=relaxed/simple;
	bh=/gazBL+g08SF7pLxG8huFrO/EH9JtGWvHNTVtdEaD9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RSDdquGOFI9W7aLvTSwmgZl4xAR1CVzm7Jj0jsDjEvuwwYKejlEwOm68htCh4+cvn4OO7FXS3LfI5uza441f77UliKov3pb10ntC730K3VnguF4MUFL5TkJF+16rl1w95whBu6OVAODVOwnFyyySdw5GTcnO1/fOlKTSxdXDiDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=E2b1M6PI; arc=fail smtp.client-ip=52.101.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="E2b1M6PI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIc7IIMKibJwKDVLle1vPB8cJ97AHN4RFUYDlo0EkWLkfImYqXK6TlbIG/rbv6xWskZIWQ1CnMOrI2QmTToGgID3/S8R/oWwkM1LhOg5+I2Hz+VeWOhmqUG58+ZYfxZDNeryriEGhbxAPqbaVEHp49B5RXlwSk+gMlEN7kdSIUtLZ7MS7KKmrItVSZIxy9/RZGRb9/rC90biuEobPI42VzX3CAwzrlmFS7h2wQEWYhrKC3zdLg+sILU2ePS7scWRfuGzeZOkQM6VVoQOu6YH9/D6gVY39Z0rUVQ2GXc15reKmMJ2jQ9h9kTgmr2wzuyK3jPxXIvDujCZdmmPDuwu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgpcqnVcFIYMu9s7kUmyM/2LD2FaKqOcf2VB5FejMBQ=;
 b=hiA8LpK+hbTMyjcEDpCSM641Ken7p/E0bvMBWHctbsJcOfKQJQrfCpGCY8XfrIeJn7p7F3GIpVPOLS+8f91LOfBtxbfFgfkQg9zVGYTfw8kBNrEKaF1Xb0EIBbLO0CD5SK0seKIaThUAsgzgHNqHMDT6POq87nugVh/GZoHtbscaWAj6TUqEIwO6iUj3EuXqR4WTr6MEDXPRu8a4qmK8Z9DFIH706Kynibls55I6iJjgYy22mbtDQHFy2H6KnXwgSDk7/vegZrcsS7SzTUH1ZzlmScgz3tlCTdInp9F/xaE6p49MeKM8EeV+st/G0LKB5xwyAZz4p1yWVRFHDxjf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgpcqnVcFIYMu9s7kUmyM/2LD2FaKqOcf2VB5FejMBQ=;
 b=E2b1M6PIZ9iO+Jjq5i6wka2kIzqP7yMF58vwvnsQE3ZR0pOnxe1kil/PqPd8iSbVs/oQtzkNw21hwgx20s23ckLf6RGZWwZXMrkvGWCL2hvMzzADBjE/xUbSIi4P2pwT4ghmwQAR0bDO8/fTdtoWNCAkXVeaJ9WJ9s03KWuS0xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6257.prod.exchangelabs.com (2603:10b6:303:7f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Sat, 5 Oct 2024 01:53:29 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Sat, 5 Oct 2024
 01:53:29 +0000
Message-ID: <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
Date: Fri, 4 Oct 2024 18:53:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Daniel Mentz <danielmentz@google.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 349985cc-fbc5-407e-6e99-08dce4e0826c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2gzUlMzTnpud0xRKzhnYm1sY1hnTkVtWXpBZm10bFZJclU0SGpCLzZHS2VN?=
 =?utf-8?B?TGQ1Qld0UDRZdDVVbEQ1enFpUGhYeU1YSTZIaUFKN2pGcG85VXlIejhLMk05?=
 =?utf-8?B?M01MZE9vaURvNzBLM2NpK29IZWdzVGtDQTh5YmdsV2hKaXF1MTRoVEdyTDk0?=
 =?utf-8?B?MkQyZEpWNUV0UGloMFBtamZEZEJaMWNZRzJHOTg2SnE3TFFzL0hwV1BNSHJu?=
 =?utf-8?B?WWhZZU9WUEhkbnd4WVJWdTNqV1E4NnEyaE9TWXpuMGttR3NHcTBLS21RZU1Q?=
 =?utf-8?B?TXJWb2tjWDh5N2lzeDdHVE1wcDI4aDZNeTRkdkQySVFvZTB0R1dBaUhKcHdt?=
 =?utf-8?B?TlBSU2xtZHFEajJpRVg0YnBkSWVEQThWMGE2TkNFQnBSWWlXZnBnU21hZ1g0?=
 =?utf-8?B?OWFNTTFzMlUwZEFwSktVWk1pcGV1Z0FWTmhKWkFIZmwrS0V5UXk0RCtlN1VN?=
 =?utf-8?B?RC9tVmFUaEk5WjRIeDlISkFRNzYvWTBuUEJzdnVmMlRiRWtvN3IyQnc5dllJ?=
 =?utf-8?B?V1lCNHBLT3V0ZjdGMVBTcTExZFNRWkNtR0FheTBTRWdZSHRwdTlBOUM3Vzhl?=
 =?utf-8?B?NE9CaWJRbUZxUWJ5QnRxc2xKNk1JdlE3ZHFDaHpNVHVoOTQ2VEVrRkhVRzg5?=
 =?utf-8?B?cHc3diszdUlwWWJBRWZBRkZGdGNSVnMvRUVKSzl3S29ldXZIWHlQYko5T245?=
 =?utf-8?B?a3JVNFBieHBCM2ZTbklOSzJPVWVuTVh5N0JjZnB6TkxIaDRQVkE3ZHZaV2FQ?=
 =?utf-8?B?OXg5dkRMMGtpYVVOMW1MUUdpVVNHWExoS3lzekJ6QXdwUGJnY240ZlZCY3R5?=
 =?utf-8?B?bTJwN0ZYOGVlZWJTVGN3TEZ0K1BXS0hia2x1SGh3NTUrOW1tTUdoWEttR3Zu?=
 =?utf-8?B?ZkdtYmJwQ3JNTk5rYjBUQ3ljSnBkN1hYUjFaRHF2RzR3NXg2K0t2cmQ2TGV3?=
 =?utf-8?B?ZXdZTEdBZG1sV0twSEJ5OS9BeHBud28xT2V3blYzemZDcVN3RGdnOGxVQjJ4?=
 =?utf-8?B?dkkrSUxmQ2VHemlrT2VraHVTTXJObndDZHFPYmpheUtmTG1nMkpRK3lkRUhp?=
 =?utf-8?B?b1hlMExPWWJrcVViSDMzZk0rOExlR0h5dTR0U1NyM01Bdk9XdmdCWDl6TzBv?=
 =?utf-8?B?ZnViSEkwUVRyRGFBL0krRzFyZlRlTHN2ZHJvc1JlbzBzNE10SDJGN3JMQXVB?=
 =?utf-8?B?Y1lCM2MzSTlxY1FraWUwWGs4WCtmb3o1SWwrU0UvZVg5b1hPV1dDRTN6OTJJ?=
 =?utf-8?B?WU9WSHdkSXV3REdYZ3lOM2xGWWk3MVRMNWxuZktiZXh5bHUwWE1QQTE4UGxV?=
 =?utf-8?B?L0Y2MVk1SEI4VjNxejRzSFFxYi95YUhtdDc0MmhNVnV3UVpaakFpZkJSdmJr?=
 =?utf-8?B?WDFxVXd2Wk9DZGthVGJKMmtaMS90UitDV2x4cnVYL3dBTFJXblMrRXp1bklD?=
 =?utf-8?B?UHowWkFtaEM2Umk3QVpTQnB0cE5aTVA0MVVCMkIvVFVnNUkwak5iM3g5REFP?=
 =?utf-8?B?VlVYTlB5V2xDWDJlcWZrNzNDQnhNbUt5ejNsUWsyNDRWZzR2ZVhneXgra0JR?=
 =?utf-8?B?QmhVdC9xVjhhelBCN2JHS0IrZkRiV3lxQXY0bXdEc1VCN2pUd1BBbW8xSzNq?=
 =?utf-8?B?SmJhZ1QrNmRKNm0zalFINTRqNmpFd2JETzJqYWtYZkZmeEU4SmRXMzF1dnlT?=
 =?utf-8?B?dkxCRkxmcGRkQWUvVGh5TDJDSEYrUDRKVnpOZS85WjhYU3k4QVNVNm1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVRmRk1sbkJzYnhYMGtJYk9ZT1hQL05ZTExnZm9VRXU4cUswalpzUkpBUnQ0?=
 =?utf-8?B?MWdlYkxWRERnaU1uZDJQRjB6U0hQbnkrWG1YNU9SSTRnOTRLaWpVUEZId012?=
 =?utf-8?B?b0ZIYnozVHJ4WHBlSWpCbG03YWJnSFZLSnh2RWJsQlRtWEljVHl2YitCUEx6?=
 =?utf-8?B?Z2ZlY3pvWmp5WU4zNVYwaVoxWHl0VTIwR2FidVk1TWJRd3J3SWF3M2dpZ291?=
 =?utf-8?B?QXBiTFkxSW5nYjV3bUZVblgwNWJFcEQ4WlF4aGloaW91Rm9OcSt4aXJQOHRS?=
 =?utf-8?B?dzFrSk1wYlZZUUluTFZaWFpCd29mcnRGblJuQUNoTXZTcmg1MVd1akY0eEUz?=
 =?utf-8?B?YnV0a0xjSnYxU21DUmdUT3lhUHFTQ3BGSUcwaTFYUFVNaThrSHJreGtSdXZz?=
 =?utf-8?B?blRWQkdnbUNwaE9nclBEV0xZK3dMNEhkQ3VvQ2RrV3drNkxReTl1ZjZ5MjZT?=
 =?utf-8?B?QXh1QVM4Qk5Bdm51bkNWNExtbThpbU5ZN3dxUDNidGFiMUpkZWhmeUowbERN?=
 =?utf-8?B?WGJGd0d3eUtTOGlhUzRoMnFHTS9Ka2diN1RrZ0JETTl3eisvZG1zU2dFdVd0?=
 =?utf-8?B?MGNuaWlFZWlBS3lxSUJsSXk5Y3lpRzIrS1A0MG5EY3NLUUZOOGZhQjBhZTlC?=
 =?utf-8?B?ZDFhbHJja2ZFTGkydHZrOGdlcVRQcXpmb3E2VUord0lpbWVaUnZROWdxK21O?=
 =?utf-8?B?SEF2U1BaR1dIY2NHMEg3cFE3QVZ5WVpNUzlnSm5WK29OMVloTG5xTDJoNW9H?=
 =?utf-8?B?cnRtN1k1WTQwdDdZUEhkVURza3BaeEszaUZpaXBjYUtDenBNMzVPdUVsUE0z?=
 =?utf-8?B?VThqa09zUEpVK0hhNVBZZ093bEc5K2pReGRCczFGK3ZkUEhXNnZTYlRLRThV?=
 =?utf-8?B?SW4vWFJKcWFvZko5K1AybENQK3ZqWmJkL0lwTHNBUWtNRGNFU0ZyUHAwZHgv?=
 =?utf-8?B?UFdDelJGaGlNazF5Z1pqeVRJMmxNUkZQU3FqUlZyOWtjQy9CNER6aVh1Tkds?=
 =?utf-8?B?V01yaFV2NGJJMlJFeUFtN2Q0VTlJYVN3MWlXamZQVDJ6eXZ3RWNkcXRhUlNu?=
 =?utf-8?B?SmhGZi9HK0hZR0luNjNxbU9samhmeHNnZTRWMEsyc1ZkT1h2aVUySUdjTVBK?=
 =?utf-8?B?TTlCa3FFdXRiUHFtQW5pUy9qM21yUG5jUmMwVENOTkRHL0tYZGhWamtzTUNB?=
 =?utf-8?B?RW03azdqcnRzNXBTZmhKS3VROGd4Ukd5eDZ1dFRxNVo2amY2VXVKaytWZUpj?=
 =?utf-8?B?ejhXN1VLUmtZb0xLdHhXSkltV2g4YjAzMGpFbUNrSkxWRXZWdUJXRDJsY0w0?=
 =?utf-8?B?b3U0Rk1XMGdzSUlzUHkvZTUvc0JaZDl5Mml0aHRtVStzdWVJMVNvWWc3c0Z2?=
 =?utf-8?B?L3c3NUxJaFdHNjZXMGpwYncyOVdnNlVWaW4wTGFrYTVlQXY5WlhaSGdCQTBm?=
 =?utf-8?B?TjZYOXpydEdjZjd1V0xzRDZkY2ZxK3g2ZlZycVkwTGp3N2hIeHdYVWFhb1dn?=
 =?utf-8?B?UGozMFV6QklyaFB6SndSOGJtWC9INnh1YkRZbFRicXFHZXZUN2dQYWsvemp1?=
 =?utf-8?B?blNCMkpCZ0ljR3Z4SjFNUGdVZlFpWFVHVEJXam5LOWgraEQzRXNsOEZ1bGpT?=
 =?utf-8?B?cFh0QXNjR09INW5zMzNMZm94WXo2djRQczRhd09WWmdDQTl4c3BUOTNqNkcr?=
 =?utf-8?B?UnVCbU4zaTVNaWlkTzRKTG9nMWMreVMrWWlCRXdKUEpRMzdJU3A5aDNGcTBo?=
 =?utf-8?B?OEN6VmxqQ1pFenJOajc0WUVJNHNxczFuR1pldWtpb1ZNbDhXVUxxdWFjUm1M?=
 =?utf-8?B?UmtjNG5JejAyS1hpcUVGcDc3Y2JuWVk4YTJpYUI4L1R1Y1lLZkRvQ0JtNUN3?=
 =?utf-8?B?Z0RlYkM3K0hFU0kwUkFRMjdHTklQcVBjVFI3ZkkzVVhsSTc1NC9FT055ZkQw?=
 =?utf-8?B?UENPN2Vmdmk5bWtrZ0diTjQzOEVBVUNyLzAxT0VKMERicGwrZGduNDcxSk4z?=
 =?utf-8?B?ZWVLdjIzQW9OelNQOTZlSHJXZklGWWtOQ0ZReUtXM3FmQzRwbkpwYVlEczk3?=
 =?utf-8?B?eDJaR2V5cTFGK2VldEY5a1puc1hUNHlMbTNlL2NRZlR6Z1VyZk5jR1lJYVRq?=
 =?utf-8?B?akQrMEw3TllCYW9EYXh6Z2lMR29xU1hNSW1yN3QwdkgxVUw3ZERQajVxQjF6?=
 =?utf-8?Q?fzTEqfh9ZXqVVfhnWbUW3fU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349985cc-fbc5-407e-6e99-08dce4e0826c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 01:53:29.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhcdEZsGWVFLrrMK74RMmkIl+Mpmbt5yUPmhFCbRK0N4tmGMq+RZwMzfDqD9jlI2DsZKpdRYg8fbAXt9L3Y3FAxU6d89EWhte3ilsMoOeRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6257



On 10/4/24 6:03 PM, Daniel Mentz wrote:
> On Fri, Oct 4, 2024 at 2:47 PM Yang Shi <yang@os.amperecomputing.com> wrote:
>> On 10/4/24 2:14 PM, Daniel Mentz wrote:
>>> On Fri, Oct 4, 2024 at 11:04 AM Yang Shi <yang@os.amperecomputing.com> wrote:
>>>>    static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>>>>    {
>>>> -       u32 size;
>>>> +       u64 size;
>>>>           struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>>>> +       u64 num_sids = arm_smmu_strtab_num_sids(smmu);
>>>> +
>>>> +       size = num_sids * sizeof(struct arm_smmu_ste);
>>>> +       /* The max size for dmam_alloc_coherent() is 32-bit */
>>> I'd remove this comment. I assume the intent here was to say that the
>>> maximum size is 4GB (not 32 bit). I also can't find any reference to
>>> this limitation. Where does dmam_alloc_coherent() limit the size of an
>>> allocation to 4GB? Also, this comment might not be applicable to 64
>>> bit platforms.
>> The "size" parameter passed to dmam_alloc_coherent() is size_t type
>> which is unsigned int.
> I believe that this is true only for 32 bit platforms. On arm64,
> unsigned int is 32 bit, whereas size_t is 64 bit. I'm still in favor
> of removing that comment, because it's not applicable to arm64.

Thanks for figuring this out. Yes, you are right. I missed this point.

>
>>>> -       cfg->linear.num_ents = 1 << smmu->sid_bits;
>>>> +       cfg->linear.num_ents = num_sids;
>>> If you're worried about 32 bit platforms, then I'm wondering if this
>>> also needs some attention. cfg->linear.num_ents is defined as an
>>> unsigned int and num_sids could potentially be outside the range of an
>>> unsigned int on 32 bit platforms.
>> The (size > SIZE_MAX) check can guarantee excessively large num_sids
>> won't reach here.
> Now that I think about it, unsigned int is 32 bit even on arm64. So,
> I'm afraid this could (theoretically) overflow. On arm64, I don't
> think that the (size > SIZE_MAX) check will prevent this.

Yes, SIZE_MAX is ~(size_t)0, but size_t is unsigned long on ARM64. So 
the check actually doesn't do what I expect it should do. U32_MAX should 
be used.

>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>> index 1e9952ca989f..c8ceddc5e8ef 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>>>> @@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
>>>>           ioasid_t ssid;
>>>>    };
>>>>
>>>> +static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu)
>>>> +{
>>>> +       return (1ULL << smmu->sid_bits);
>>>> +}
>>>> +
>>> I'm wondering if it makes sense to move this up and put it right
>>> before arm_smmu_strtab_l1_idx(). That way, all the arm_smmu_strtab_*
>>> functions are in one place.
>> I did it. But the function uses struct arm_smmu_device which is defined
>> after those arm_smmu_strtab_* helpers. I have to put the helper after
>> struct arm_smmu_device definition to avoid compile error. We may
>> consider re-organize the header file to group them better, but I don't
>> think it is urgent enough and it seems out of the scope of the bug fix
>> patch. I really want to have the bug fix landed in upstream ASAP.
> Understood. Thanks. We could move the changes in
> arm_smmu_init_strtab_linear() into a separate patch to accelerate the
> process. I'm fine either way, though. I don't want to get in the way
> of this landing upstream.

Thank you for your understanding.

>
>>> On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
>>> number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
>>> tables. I'm thinking it would make sense to limit the size of linear
>>> stream tables for the same reasons.
>> Yes, this also works. But I don't know what value should be used. Jason
>> actually suggested (size > SIZE_512M) in v2 review, but I thought the
>> value is a magic number. Why 512M? Just because it is too large for
>> allocation. So I picked up SIZE_MAX, just because it is the largest size
>> supported by size_t type.
> I think it should be capped to STRTAB_MAX_L1_ENTRIES

I'm not expert on SMMU. Does the linear stream table have the same cap 
as 2-level stream table? Is this defined by the hardware spec? If it is 
not, why should we pick this value?


