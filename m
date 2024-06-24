Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87F4C637
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244960; cv=fail; b=A9WNjHtAM0x1Sb2Jq8xw1OLW9qKnbu3RgJHCWPC73LVMvoWEPVtgCmdNUkfeuxRJnALn+5Pbnm5ZbLKfv2TNMr9DtUz7vHhUHDMa/y20OoYwtbLrIhgsZqYUJnQ5SZi1OHeeFLFtQ4WHomNlbSDojf4pAULkzx0npG2VER1towI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244960; c=relaxed/simple;
	bh=S0JNUg33F149lt/lZ9z2XbOUy/CpoypNdQj5L0KhHBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jL7lPWJl7PDwxQ3txxwj/6o1Z327JiSX451HYFwdVDgnMunn/7QRASh2PUNOGyVe8rBdFsolEyJ9bJ+yvviKuNv1DgVSjj6thfRXY52ldMAhN+XjxGm5TzZB5v5ZI3uhRm/KQ678oXL7/11cqOQRcJvcD4uqHr8/VucxClEH3aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmUbV7An; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmUbV7An"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeXCAv3m7GCM6WSeSc1OzVb0g4IYnSqbUcjzBcTtYdkPcDQ63mN+xmIArigVKy2HHPcc0ySAr+/Vsc1yS4Mm4aqeEAPljkNs8aGGlCRfZ1Rv+GkgOwW5bZdO43+5tSylT3dbg69BDVwrqCxCjTlx4RfnXGxnO8kII5BkJigdGazltbDkE0icDR7/Mix/ovj/sgjKg1dbSh7fvCkYhmuiG4IiVgRB+KCD8nu+1lGvysWUuQyEna4rSjZ78c8bxxOyVT2/Uh/lDGhmDAqHe/cGn9lahtw+9bflcAM6VATsFNZuiRLHQc0UqVrWDepFiQgEJpJwq3SxGmM8nh8YR9zuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXGebMI13TIqrXX0mFB0yjG7a+X2/31kHrgf9jXUVYs=;
 b=ieJXgaj2iiP6YdE2k3hsfJnNGHt4KNHk7YiqBgWpKr34vpGYlqCniBq+E5jlAOFikrERKZz7WQJkj8iBxcn6r8AH5tjL+WIsCMeiFQPyh4irb0b+PT/Lxo8jiWmTCbyPY9ZrjsgYbu6u5l3YLoc4KGq+vNUJ2WC/xWcbnVyFEexuQIXNVRVKZjNDofcJYTSs3LXDAShOQa94i6YtohhGwSIvO3NX4OteemYhysRAKxPlDoeIiW91cj7C1LtSLHaXFjZgLHK0CTZwStIq29CWyLy/zdDzfhTFJt96ToMzB7RyeONmHsc5OrmQvyVHeSH6XnndtISc8RaJz1bTBn/Klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXGebMI13TIqrXX0mFB0yjG7a+X2/31kHrgf9jXUVYs=;
 b=nmUbV7Anw4p3kQYSd80KCGyrnKAdiFBiKHygaJ5AuE/OIioYCdf0Jis/lAPFa4LotecMGkEAbRxes2x3DeLKpi3h0M8hzf582WBoGfr4Een/2xcrUctkiWdPpIGTBV6IHbdZHRkHk8BsVsGNcF4hWdUQ3yLTJd8eyLOouteFqtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Mon, 24 Jun 2024 16:02:35 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:02:35 +0000
Message-ID: <fceba6c2-e0eb-4968-bf3d-8a4a8c3880b2@amd.com>
Date: Mon, 24 Jun 2024 21:32:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Take group lock before attaching device in
 iommu_deferred_attach()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Lianbo Jiang <lijiang@redhat.com>
References: <20240528163940.48789-1-vasant.hegde@amd.com>
 <aaf7b619-1826-4db2-aaa6-235a25f46299@arm.com>
 <029a1733-4e7e-4deb-92d2-874040679bd2@amd.com>
 <20240610174407.GL791043@ziepe.ca>
 <1bd088e9-8cb3-476a-b397-4257d3ec1b46@amd.com>
 <20240624152534.GR791043@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240624152534.GR791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb1688e-ed05-40e0-b249-08dc94670fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RllYYUFZdjc0c1djQ1grc2ZFODJBTGJ2WENFMCtBaGdKRFMxb1hBSjRueDQ5?=
 =?utf-8?B?cURDVjdZVXdHaEg0QTNmc0c0VmUwT0k0Wjk5M2NURkpnYzg5VUVjRkZGYjk5?=
 =?utf-8?B?dUpFRXhCUWplaW5Ld2l6dUEzcFdiM000a3RIbVNsZXJzSTRMTEQ5ZHMrZi8x?=
 =?utf-8?B?UGRrRFV1a3VpdUNiQnRDUlNtdklPNldFTGRHVm44Q3VaQ3RqZDM4dDNKRXdn?=
 =?utf-8?B?a2JIcmlXTUpFd2VGSVJmV1dNZnFLTGhDUTUzK3Y4RFlEU3l2NUFMbDRmYU81?=
 =?utf-8?B?M0Q2cnNRdHl5THlQUFJkKzl4Z2R4N1ZpcVNvbnNUdzR3cTQvNkVkYkR3ckRX?=
 =?utf-8?B?S0ZDOUFCaG8rWGtqUXhsV2x1VU1idldRbWZaa2NrUlZ4ZTJCTkVteUNFZ1Fp?=
 =?utf-8?B?ckp4WUUvZEJIVERlZ1crQTE5QWZBdGcwTW0wOTg1YXRjdmpwcGdHRC93enV5?=
 =?utf-8?B?WWJjbTVBS05aOUxrTkVvbzNhVjVBelNQOEtTMTQ3ZjBNK3NiUVFjdXlqTFZw?=
 =?utf-8?B?WUFZdkFSMk9zRGErOCt3Y0l6dDBBMWRhdHNrZlllaWVJb1Jyc0llRSs3c3U4?=
 =?utf-8?B?RVdib1FPb25BNk5KazlNZWNlOWtXd3VqdTNETjBjcUhBZXZjTm16TENrMkRq?=
 =?utf-8?B?VHFQeGVqakYrMnd6SUtORVhSSUV5Vm5tV2hjdm85c2VkY2pJRUdGQms4Tk85?=
 =?utf-8?B?ZjV2NjJCWWxKM3c1ZmVrUERmVW42MjVCT0g1Nnk4bVNrbzhoc2pSWElyNG9X?=
 =?utf-8?B?MWxkRUdCUEVReit6K0tEbjl0SVRvc0VDaWp6SlU5YTd6WnVIdHpFTDNaQTg5?=
 =?utf-8?B?LzljR0xtbHZYc3oxZk80dTg5QmpjTy9pWWg3MGdJRFVQcXE3SnFmSEZjbmkx?=
 =?utf-8?B?UXRSYWtMelVPYXUvNmNzaGRRQ2JoOFJxZWloNFJXZTUzV1lKOHVSU1lpaUZV?=
 =?utf-8?B?Nk03a1BlWisrU2kxL1Q4TjdrUVpHK094QU5HWDZMTHRKZ1cwcXV1bGp3YTlG?=
 =?utf-8?B?WmlERE1ZbkRIRWpLdXlJQWR3TnFPMSswa1NBSldWVjdXczRrWms5V2hGaVhh?=
 =?utf-8?B?YUJKNnhZeDVodU5oRzJZaFVYSU1XSDhBT1hhQWZrQWpGV0prRUhrV050Mkcv?=
 =?utf-8?B?NXhmQ1pXak1XUHM2ZFAyb3ZYSGFIZjljYkF1aEo4VnhPeGE0SXgwa0MvYjBu?=
 =?utf-8?B?OG5Xb09GbUdvWlN2T0d4VXpQd2ZydGFmbEZNdGlUa1NPa1BRZTVIVGZKMzd2?=
 =?utf-8?B?UWlobEI1UTRoUG9IVS9VOWlCZXJVT0U4cWpRSml5YnFUZ1RwamtmWlpaU0xt?=
 =?utf-8?B?Y3Fod0U2dlU4RGVUUkFvRGRaZ2JYUGtGTzE1TUk5UWEyNDk4YWpiS0dZUE4w?=
 =?utf-8?B?a3doN01MSzhJNzNnN2lic2lrRHoyNU5OcUJGb2w0VDk0bTZNQS9Wdk43dVRR?=
 =?utf-8?B?S1o2aEVLWWJNdVdHL0YvYzZHZVhqUElwMmRsOU9Mb3U3RUo1ZXVUcnBwWGto?=
 =?utf-8?B?V2dWVVlRY1pUQlhVUXYya0pxeVNsaThXbzcvaENTZHRCVnRCZWt1Wk1IbWpZ?=
 =?utf-8?B?a1BPTkZobnQ1RGpqREhZTzZEYnA4UGV3Q3JKaEdLMHdQMjh1MDZHazY4YUxN?=
 =?utf-8?B?TUlFZ3lCUnczVWY3Z1JBME1GQWhxMU94d0J3TVJrOWtwUWJWMkhoQWhZdExk?=
 =?utf-8?B?VHZYMzIya1BDK01Ca2JTbU44M09MVVJKbHQxT0Zqa2NhNU1PZmM4T2Q4U3Fh?=
 =?utf-8?Q?DTuDnNh5Rcx/m0X/RFYONejEu1AzgKEzv32jvam?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1N3anBZd1dLcmVEMU1XUVZQN0hIcVcvWi9BOVVxaVpsNFk0T1hJRE9oYlJj?=
 =?utf-8?B?a3NUVllRamtTTmN3SUtSN2dQakM3K290aHVIbmF2cUFuc1QvUDlwR3dGQXJP?=
 =?utf-8?B?Z0hBb3FBYzRFaXpQOWIwRzdGaEQrb01CaTVVM01LR2sxOTdidVBQRkgvNE52?=
 =?utf-8?B?S1ZQYWpLdHl2YjJJR20wVFJMRlRYTmc4RUhLeUF6OUROdS96MGUvYzg2M3M5?=
 =?utf-8?B?M2J3czZzUGw2MXB1QVkvUkpjSUV1RFdBVTdwbmxQZmF5QkdGU09sM3pzN1dI?=
 =?utf-8?B?aFFJNnhTTElvdUpIMTRoY051Ny80NW9qVkhpZUw0eExLVkRLWEhFY3liSmxv?=
 =?utf-8?B?YkRwdmlIT0pOWU5mRjFBb1luK21FcnVpR294NFJYQTJSOCtRbUFOYUwwalUv?=
 =?utf-8?B?YnF6cmRNRmplYStsakJtMXdsYVM2YUp6SkIrMnEzVmtRajRFZERjQzd1dEE4?=
 =?utf-8?B?ZEI4Q1pScTBQUmowNjY2NEV4VzVmQld1SU9ZemNLNkJTRlVQcHhIdG9Rc2tK?=
 =?utf-8?B?QVFQRnZWNHZ1YkhTd09jUE1lckNFRHVpOXdBUCs2Qm9KSC9HZzVxaXA0SURu?=
 =?utf-8?B?TWUvMlQrbHZuYzdOc1R5S1hSYXNIdElCTmJSUGlaYm8yNndFeWVXSEVOTGRX?=
 =?utf-8?B?VisyQjdCblc3NlA2TkhxZWdiTVgvbVBmaFp4OHBPOUxCelAyWTBlQmJJQXYz?=
 =?utf-8?B?a3JmNDU0SWkvdmtmNjdRUEMvbnJRU09ycHZsUllURmpEdDNaMlYzKzFYZ1Az?=
 =?utf-8?B?YmZOeStjdjFGOWc4NTJPVjArOE0xVVFWbm56YXY2UFNGblFvd2JTVEl5aCtB?=
 =?utf-8?B?c2EyUTVEMWhTeDFieUNXd2twd2l1NTE3a2VPYUFrb3UwK1lON2F4RFc3bHh6?=
 =?utf-8?B?NHZOckFZNVlJOFZNbGRpRTZNUUIwZ08rZVA1M3FFK0F4dXdmQkpweEdMekpW?=
 =?utf-8?B?WGs1V0owQUo0S2ZJTTRqaFhqUlN2Q1Ruakd6Wko1UGpDWG1iTEtsODdOei9D?=
 =?utf-8?B?bXBKNW85WjZnTFR5MXFuRVRaVElWbWp4SVZCM01kM3dmU3Vrbzc0N2U0Kzg5?=
 =?utf-8?B?NjM1b0c2eUl3U3lTdUwwdXk5ZmtGdlpaSE9OZHh3VnVXNVlNTkZTQTlQMDBw?=
 =?utf-8?B?bmEvbWJrZ2k3TUU1ZjlZNWozcGVrQ204YnJHdm5mTEJwZ2UxVVpuamdZK251?=
 =?utf-8?B?T1JNOHk5OEI4QWFGVWsxNkVmVVJrN3NiNmZsWFpwWWlCRHZSVmF1Zk5VQmNU?=
 =?utf-8?B?SHFzcW8yTElZSklPTTlFZGZNZ3Nvc1ZvYldEb3BSV1p4dDhuTzROQnRWVlNZ?=
 =?utf-8?B?U0hSb3V0ZmFvcGRuaDR5dzZhY0ZYRnlWMmtBd3NsSWFlM000cjBaRTRBZjFK?=
 =?utf-8?B?UTFMRDIrSW1oYS84WFErMFQweW5BTnhFeWNOZjFOVXRoVDdZYjRsUEFmdU1y?=
 =?utf-8?B?Rk41UVcydnZmQTNrZmZPcWFrOGRPcUV0Y1k1MVJuL1k1YUd6SW01RXFxMmc1?=
 =?utf-8?B?ZVhBRnBWRTBoSU8xMDYyaVNCN0hyV0lxWVFSZ3ZLcDVwS1IxWis5RzVDd2U2?=
 =?utf-8?B?b0F6bGZRMzhrQzNDY0h2UWZzSHQzZTBnQ2gzMThBbTVkZ0l1YmxtVXZMMjJa?=
 =?utf-8?B?c3V5RTVJWTV0d3F6VnJ4RzIzWUVsZVB1WWFWSkZpdnN2eGtMWEE0MDdpdldN?=
 =?utf-8?B?N3Q1V1RNUXQwOStnaUowSnE1a3NQajdyMCtuVVZlRDg3RGN4cURVc1g0dlBx?=
 =?utf-8?B?YnVJaG5UTGVBQWhSWXhOOHprand6bWVFUC9DbnRzVVcxZmZFYktTZzZUVzFq?=
 =?utf-8?B?d0xEZ2tDVnpDOWo4MXVqN2pNU2tOZ3pIWkJhNmsvTlgxbjdKTmdpQW1wY3Bx?=
 =?utf-8?B?bTQrWEZJU3ZrSmxtbnZRSzRiN3pFNmZlakV4T05HNysrSjJTaGJnRmtjRFo1?=
 =?utf-8?B?bDJKNk1aTGxHSFVFdDdxekhaWnc0Q0tBR3I0aU5BUzBtcmZDU0R5cmovSWM4?=
 =?utf-8?B?dC9YZGw2QWtsMmpnWTQ4ZjNFd0lSMnFFK0oxQmRva0Q1YkpFdytCOHN4amNj?=
 =?utf-8?B?ejhqV2d0VFFIOElHUk43bnBVempFRVczaGdud3Rpalk5VGRkdnNjUmpaa2Ev?=
 =?utf-8?Q?UclHIUMmCZnTXB/hSdp8dydk4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb1688e-ed05-40e0-b249-08dc94670fb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:02:34.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJZNM9k0VVDFPgMQGke80qwszdQXNuLNE7IQ023bQarCeRNzjwjQm3GC/3udYK527W8z4aA/ZxfyyL0Cf0bfIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

Jason,


On 6/24/2024 8:55 PM, Jason Gunthorpe wrote:
> On Mon, Jun 24, 2024 at 07:50:46PM +0530, Vasant Hegde wrote:
> 
>> It may be good thing to add mutex here.. But if any of the caller of these
>> deferred functions hold spin lock again we will hit the similar issue that I hit
>> with AMD driver.
> 
> My point was that Intel doesn't support non-sleeping attach, it uses
> GFP_KERNEL, that support seems to be a uniquely AMD thing of the major
> drivers.

As I understand we don't have any hard requirement. We can sleep in attach
device path. I do have a patch to replace dev_data->spinlock to mutex in AMD
driver. I need to do some more testing before sending it out.

> 
> So, I don't see an issue with formalizing the lowest common
> denominator in the core code - the context must be sleepable.
> 
> Presumably things work because the kdump kernels only run drivers that
> reliably trigger first dma from sleepable contexts. Unless there is
> something AMD only that relies on this special behavior??

AFAIK AMD driver doesn't have any special behaviour in kdump path. When we jump
to crashing kernel (kexec) we don't disable IOMMU and try to init IOMMU with
existing info.

Having said that I have not done exhaustive kdump test with mutex lock. I will
run some more tests and get back to you.

-Vasant
