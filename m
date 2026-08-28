Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F864466B00
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927260; cv=fail; b=jFXV+xO24ockBoW9iRez/j9Cc+n9pbLNdhQcDGez1criM09qleW93iEna5W9kRezeg+bQ68pKGshAkcsEjwqTCr1wJ3DdTKggehSbWqIVD5B1dzMz8Vmostbdlc9sm2vG/eWV+u9/w7liyt0Pw3ZmWOVEsMZSjuwcgA7k78XZaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927260; c=relaxed/simple;
	bh=YZTMOAp4uiYeOFa95JEa58vP0NYBqrbAzg10ow3sQ+0=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=YGHVFJnU+gA84taELpfBlHumNaDNnlWB3I1u4VfJsBYxEClBqDDJqcvwHDH49eJVeVayBQKCx5qG5fvC9c3V7iAzy0khwrykaaYYY/Q3ZVkZ2IAnX4ibhfhh6hSzi1DtRQHZIVzofap5uPUlDAo06fTzTnFWFTzAJmXOjtcW34E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdaRudnQ; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdaRudnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvFgs6mlkoQMftk2CWcMqnV8PKiJJbc7aPT2LUKcck0pue22bAAjxUJ0u8zfrD48xbX8PfxsudMhDqE9pJNG6yXPst/NUlq3nspxx3Pp88o2iKndig14olCJ9hBMo3zIDLIHpJ3PQw7atjbd0sc+tE44+leCRs4TkACuIGQzOIIP7i4xPe7jkQQsCksxNDXL7WtQXHmkLlQEFQEoIRuJpj0nNsZy0VG0CblVrZcyW5G8b74yPv2kbdk3pjRlVYUigLJPd2ijUlFpsGvotIJHcGrYFl7Vqtj0mKus2a4ooM1wmjQULs6weNlBJqpdKsrN4urnXqT80xoKJe20lzv4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn7+SQrOtfmWV/zwQxSkpPn1LN2mYRBe1UfdiYPOrQY=;
 b=cakJKWAsPUeOSbWM4f67UUj2xD5NVk7oFd8J/UDXIdpk/ZYTLvNJhTV4bhYgLKZ/Ky/EkpWXZuC1mUXFuopPtQ8PT318Ui6y58nqTjpzuB12cwm7tAWcUFAUGa80K/fEZdJ1VU2A8c8tmHz3YQJVhhiFvORoUR8K4KOoZ4kLvwH0qsut4V/23vFJJy3twZH7ZKQyf2iGc7t6peyI4l64qqHG8SiTAN+b7Wupkk66lAt6RXoFBbwdZs95lpvcF4vtAEOeuZYh89eWT/mQl+GHl54/dlRWs6Zq53vPc6lJRc7FkHnwEcjW5PGjaMYxr6cX1DZT81sGtVqIEv5W6H/XNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn7+SQrOtfmWV/zwQxSkpPn1LN2mYRBe1UfdiYPOrQY=;
 b=fdaRudnQtYtAn0IniQ4lCZ/Wru5vFz3qXvz5G3DGm6c159OELGJj6GOuCVsfCm15KtJG5ViouUlL2GHZ0X/dDfsKFIPucZqI45GrxwJ+ZW/y3jh6vOwxTj68nDynM1NA9ZpNzw1lAnrjY5/3o8o+O8VxIMuPlkpFgU9S1Rwsu1HEc9xaKzoaTrDPFlIQbkW6WEPVL/7e6THy7xjP0wu8yCFjpj8/Yux9rAqu62wRA/1vHWEA6iAM2P60sfGYA/CFZw5g28d1ySUtAHRrIsvsmE51knzoPd2ij5k3WIP3u8DOGc3jhizhf8TzO2i14wZV2LRByTX1xsoqayVxCd7+Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 14:27:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 14:27:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/7] iommu/arm-smmu-v3-test: Fix
 arm_smmu_v3_test_debug_print_used_bits()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, will@kernel.org, robin.murphy@arm.com, 
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, praan@google.com
In-Reply-To: <20260828125409.1921538-5-smostafa@google.com>
References: <20260828125409.1921538-1-smostafa@google.com>
 <20260828125409.1921538-5-smostafa@google.com>
Date: Fri, 28 Aug 2026 11:27:22 -0300
Message-Id: <178792724271.3808739.13064650313614314283.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BN9PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:408:f5::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: defb7735-fb74-4cec-db39-08df05107bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0UGrdDGytKBYqCUn411rF50ck48rVXcp3c1znhGjSA+uwlUBlShS4F2toxpcODyBQkNPIwzDx2IBlYDn39X24FS1hMIC6A/vE+B8hnpsxNTOtRVuwr5tKOQALOqzOE4vtk+oeqoqYugS21LTPm+GsJFhol/4YUSb7sIwPTIIYrQFSCR6aglkPCukhaKVZ3juL4RBV2TCKerJa/NLXRZWqqZuKWol1KsSBRI/TP2oY32Wk637B2fM755z63uo5MYgue7mSu+wr/awTGo3wfacISI/KamJ0BOwUIl1IPr62dr30niFnKJZZ/77HAjuDHSLbh1djcEYpsAPPKdmFCAXMpFWvrBm1CEJ51j9x9huy9UuZK6rILQuE2zmFTqqzYLmFf6Qj5U/rxIfAbsykm5iKsB4WAeuXV3ONB6slmssGJJo8GxejH0jz2KTBGOeM+xCNhjfoRy9DPvtnHI5ULi+bnJfQJzeIlhO4dHwBdlF4MHxPgpmhmgSmLuvA3OZpIVyAltrJm8cORQS3nYjxJRx3WnrLkwrbXaIAbK6nDC8jOfVhKLM1hpxmCHSjZv9cmHa4kgm8JhErjYzkiOyhc9teOuCMoZS2msSL/bfQ0J0mEw36UPSk2m4l99rKApzPC1PGJRvtht2cJ7pPC6qO0NFp4ujGoDjAsq5k5bI5XW7/x4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHExek9BRHhaVGdoZktCcFdxNFY1WkNOYVcxemJKWDVQM1ZzRG4vNGlDWmcv?=
 =?utf-8?B?WXBXdVJqWHFBVEJJR3BldWZHNnhpazg0SnNWZUxJRkdPank4amFQQ1NzS0xW?=
 =?utf-8?B?MnN6RXhlcjhScG5QdjlqSG9vTVhlY1RpckxPeFBCMXAyNDY0M2pKdlYxbzQ3?=
 =?utf-8?B?eDcyNGpQTUJHazE1dXJlYzIvdFhNL0JIR0pvVVNQd1NXTHVzRWdLbjFhbjhm?=
 =?utf-8?B?UVJmVkdSelMzMFhLOGZFdjBSMkRQdGZKMlZvZjhMTGk3Q29uM0tmc1FnQm56?=
 =?utf-8?B?VzF0RGJHUG1JcXU1N0U1Snc0MmFSQ2NUYzFqMjQ2eDEzVlQ5SXByeUduSnln?=
 =?utf-8?B?ZTUvMEtBUFA2SWhVbGFrZmM0NlFyQ3Q4QW5kZUtWZ2IyRnFzN1VWUXJUZnNn?=
 =?utf-8?B?R3c1bWphd29ZTStTU1ZHV25hM2dTT3BsSUJuMGVOeGFvVzRjVjRZNjhnczN1?=
 =?utf-8?B?ZmIrTnVFTEk1TlBsU3NRS0F5cDBYdkgxc1FwaHdXRjZvb1hVeWVhUHNmZ3JX?=
 =?utf-8?B?WWJ1NjFzTzFnRnVrbDlwa29FT3c4SXE0M1ZKemdvQTBFcGFoK0hLaVFhVWw2?=
 =?utf-8?B?dWhhSURqWDVMUGV2UXp5QTRpdU1KL2s4UXc4YnZsK1ZaV1g0OTBrUmcxL1lT?=
 =?utf-8?B?TTE1Q2lyMlhJTm5ybTFHdEZMeUdid1M3cDRzNDNZRzR1cmtqVS92ZDNQS0VO?=
 =?utf-8?B?emhza29kQUNNbk1MTkpoYjM4dXdCOUt1c3U1Q2hCVUJSR1YzTjF4TTQwNHpG?=
 =?utf-8?B?M1NnTlpnNXlhaVYrZGNBYmVBNkY2RlJaQ2VNVy84eTlPbzQ5cUZpMmRYemJL?=
 =?utf-8?B?WDNEUVpINHM1c3UrVGR1bjllbGJMZEdHK01EMUdPUVV5NGtQSXRIbnlyQnhu?=
 =?utf-8?B?S3lpSWxqRE9IT3RNYUtPUmtWb1A2czhqcEo3RjRRQlVqa1FXL0k1a0JNQXEv?=
 =?utf-8?B?NjJEQ3pPZGhhWTAvd2NQNWswSEdTNlpMWm5RSVB4MC9QdjNQT3NqVnVTU0ZF?=
 =?utf-8?B?ejBSb0RSc2dHM05mQ1p0V0NodUM0cUwxcEIvYWpNaU5kMlN6NVRva09jS0lD?=
 =?utf-8?B?czRwaGo5cytQZ3RXVmR2THFsQzBTb2QrczVyQkpHWkoxWEhKc2ZQWlFta3RC?=
 =?utf-8?B?b0ZDdzNodXZPQWl2YUx5a0tRRmV5N2FQN1FwZHdzdDhTVHRZNjZ3SG5SV1hG?=
 =?utf-8?B?UTdHWVFoSFdUYjRIU1JWMUw4VFpKTzA3c2VndWY1cjFrYi9WbXNWalZJVXNz?=
 =?utf-8?B?aFdKcVg3aEhNdHh1Z0h5RjdBUDQ3OFRyTDdEUytOY0JER0Jlc0h3MlBzbXJr?=
 =?utf-8?B?N3Y3cHhCaWdsZ253MGdZRjdpdlJYMyttMG1tbVdad0N5aHJuL0NOaDdhM1Uw?=
 =?utf-8?B?ai8xam04NE5QZDZyN3ZrblhhYWtoSG8wbjBta081WW1GSDM4eWUzdnpKRUZq?=
 =?utf-8?B?Yjhod3ZWamhLMS9iK0ZEaStGSm1IVjRMaEl4bVN0dGxZMW5Ed242MnRDR1c1?=
 =?utf-8?B?WmZGOWJjMlVrM0pQL2JlVGh6a1BiY0tqTDVBMjI1aHFBSFk5TkJJZnlRaGh6?=
 =?utf-8?B?bVJkTEs3WUdNcUhnelNNeWNsUkVhVXh6VHRibnMveThGRVlPNXBnNDdOZjlY?=
 =?utf-8?B?SVR5ZnU1U3FMTjRtTmlVK1I0dm43aUc4OXg0cTNpT09rYXNzMlBQbnVKaStU?=
 =?utf-8?B?NkxReEttYWJnQTRRMUxmYXVZcE9MZk9pMllpamUvZkZ6ajRBOHN5alJqMngy?=
 =?utf-8?B?eFMyUDJ4bEdYK05NY1ZBVHlXaExEdmFKblVnVzVvOW1NVHR1VmhSM2dEeGYr?=
 =?utf-8?B?UFNjbXlnSlhzd3ZGVkVsYkI0OGlRRE9Ia2VZU20rOStNa01qRXZtVXgrMjBK?=
 =?utf-8?B?TWZsc0IvckNZY1VETEJJeWMxZk80b1haNXc3ZFJEc1N0dlV6T3EzQWZkTEhZ?=
 =?utf-8?B?a3BrNk41THF2YnJxcDJqQXJIWXhPR1cva2ozbkxsRTVJODRjYTM5bjBlQnE2?=
 =?utf-8?B?UjlJeW1YVUlTWVlOSWlpdURCRmllbFZaakVoQjdBU3MvSnNmSWJqTGZjaGo1?=
 =?utf-8?B?cHJxQjI4NER0N1U4MzBPVU9iOGl4M0M2ZHFuRmVvcFZycUFSa2g3NWZaS2lF?=
 =?utf-8?B?K1hTQlY0QnA4ZmZPMkt4T1dEd1RleXB0MDdVM1RrUHVTSml3NXR6SFFWVTd1?=
 =?utf-8?B?TGtWWlpFZDVaUklJVXk2b2E1Q0wrWVkvVmU3Q1JuM1hadysvbnZCQy9WdGMv?=
 =?utf-8?B?YTNLdUtoZEU1VXpYbEJEYkhzeGpBR0ZYQW5tNDM5TlJ2ZlE4VDRjQlNETWRY?=
 =?utf-8?Q?bqK3Htq30kmxiCEaDc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defb7735-fb74-4cec-db39-08df05107bc3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 14:27:26.5537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB28c9kp9nBiw1Bl5PvYU2Ud8G1ECWc1Bm5SioD2ZNXcQ8mUhpkw2q8dXy0Z0z0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

On Fri, 28 Aug 2026 12:53:39 +0000, Mostafa Saleh <smostafa@google.com> wrote:
> arm_smmu_v3_test_debug_print_used_bits() hardcodes arm_smmu_get_ste_used()
> instead of using the provided writer->ops->get_used() callback.
> This caused Context Descriptors to be incorrectly parsed as STEs.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
