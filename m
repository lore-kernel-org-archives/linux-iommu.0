Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630080;
	b=LVATKXD2pEtb4+nS/1NIJtOg8HAYCDDXyRffQBHgujnM9IRD5tJhonCLHVsACVbBvGWg
	 MU40XLLE2mzelr+kpnJu2svW0dmh0nP5sdoD1Ocou61RSN55aB69Y+4NFK5+YaTgPuqpC
	 MVlApXgnxKyLVSyuyRfTCnzfkjJfekx+BKGnrA8LqaH1ll+SMMNqGAFDO/380EMJRrlSV
	 8ytFY2vVAKWXwTAmUGlJg9iolrsl30wJN+kXEodtH5yHHvFt7Ud7Xe0weeExz+Of2cCT/
	 k7JA0lLf3ULXPB34hk8TIDroVrrax3RTPRq2VaYXa8H+PO612oNEfqf7c7cd5tkiPDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630080;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=BbIhqEfCLhk0HfcQz37LebBgbesy+1hoqB4gNOEFfMI=;
	b=r8gqLMJbYVfzajCULz4ghiZv/Z9ogrANq/FPgRwEvbRT/Ke5V6XaWFRHfDeckqXdryg1
	 Z8nZQZ/gn/bDpYAcEC7pK8jV2To5vrpyHozOe3oKDOTJCKM/bZuszouYF+W27gIKAmfDC
	 Z9jSNqMPUT73+kSjiPN9SCex3oQNJUoVOdmfGS4UHKkXF4bndLBt6nvLYO551jk0RKCX/
	 nlSpvE/0BQZF6gRkcNby3Ez6+KMp2nZL5npyf5b4O0LMyS4IzLwGWxUro1IuFctU3RByC
	 lizYozB05+uAHNToW86dt5sd/3ro5bXFQ3YRydHfqsoe7Zk1IX8XUaPeqy2WVQ2FVFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HGwde5lO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.29
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EA606A336;
	Wed, 25 Nov 2026 18:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3EA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HGwde5lO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ9I6wfzyvQ1h3bl6ldB8iM4+4SysOErEOkriOuzKNYPuMHjZkH2e9hRw69H+VSf4qLZV9p/xe3u0PdZ1NFnTYECEtM/7476pB90TaTeIoZkXRGlNgT6/uov1zOjKug6mGyl2r68ZfiuXgyArzY5aSrpyax0z94KusvUCKCbGjJTcdKllxe2skrrFM11CLKFpSewFKozRNVUCs3TlhFJKhhsR5GTt4Q7E7LpTJqhvsHAtCtKIkMX3Cy0oRRYmPaYWyI6PyyURWKTHTEv3U7Sz8E8SF/601rssRHmSY3VAHQg8bitxUvaGiQOAnU4aLaXkZ81DIvE0GbjXxEKBVMG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbIhqEfCLhk0HfcQz37LebBgbesy+1hoqB4gNOEFfMI=;
 b=QtdR8U0Mi0h+NWdexu0bY4LBBWrIRVCLyQpcgJgPJtZt+3JKvlzYWN72PzAeQOJSrzw84/4hxiVKTEwnaaddNwJW1Uo6tBgFbV41N3oSDHRWF6nFrkCgoGR5Kx3QVofVLuWylbdPHLBDEnYSykFqyxJ+hrRqvHRQTtarFWjk2nbX7HUOVC9YNcW9CFbVxmojU6t1TQ5fYyaJcYncIh3hquUDxTMtwhLP6C5DZp264Fj351nGtC8zq0qQ3aaxmaHSX42nngBX7dfDF59ayC5IT5HGtWQYUN3pk95DsBorLD+pB2Of7JgJQQ6BW5GHxcbu4v4G36IhUyk8zH+c7aDBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbIhqEfCLhk0HfcQz37LebBgbesy+1hoqB4gNOEFfMI=;
 b=HGwde5lOMFciJx2F1vEHSz9zmimSNp6x2Y1m79bCl6I6Z6tykyMHGD7cKJstNGcWHE1XAQEpbWIfps23Hltsh4ku7nWxdpgxkNj+lkuglcEagWIn9QXPz+6EqFYG+UgcEb7HLM1vzu8fE0lwIohcbvx5Qgt51Ff/cYI9NHBUfmdvKd37ovrhIHUuDDuUYfB65vE1XK34juGQwdt6s18hyl96BKcOv0FS0cLjFJxKZMRhFyFNKKTIwdz14EsYjdbsh4xtkig+0NTgBMU22fmGSC0xj7IGCs+p+kMv5IkxUff2mySH2KbRUuBrirRCuJSt3/3LiDxwSqzILmQhCtbBbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by DS7PR12MB5815.namprd12.prod.outlook.com
 (2603:10b6:8:77::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:07:53 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 18:07:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 4/7] iommu: Let a driver mark an IOMMU as
 confidential
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Pranjal Shrivastava <praan@google.com>, Mostafa Saleh <smostafa@google.com>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 driver-core@lists.linux.dev, Sonang Patel <sonangp@nvidia.com>, 
 Ankit Agrawal <ankita@nvidia.com>, shameerali.kolothum.thodi@huawei.com
In-Reply-To: <0f84aed0f943d1a66836ee9c21fdd5f1669f5c46.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
 <0f84aed0f943d1a66836ee9c21fdd5f1669f5c46.1794343501.git.nicolinc@nvidia.com>
Date: Wed, 25 Nov 2026 14:07:45 -0400
Message-Id: <179563006502.253973.12731230432671430516.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::19) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2039ce43-97be-44e2-6317-08df4b1f02c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|261026121527099003|261026140227099003|261022105027099003|261021135927099003|261028144727099003|11063799006|261102123227099003|261102130727099003|56012099006|261021121427099003|4143699003|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	xG1SvN54SGzvo9UfCW9/O6q23++aFPMBBvp1Akjf5giw8UwPAuAT5tXFFvmHyxgohPvP9jmv2NZhOrk2seQjQLM1M2QnBr0R9QsJpHxEgsz+I6xb+v7v1xQrP3e9UwJ2fn3NXX2Q6PWgU6bjXhmsERy20kdhMEdBLVr0bobBWAgZeFhYXpC4WCLAk9TNvC5k/9jaPl7O71DmyPENpV2HxGt37hciIFJ+CP241hvist3CpFx/OfPdNjJRNES1AIQzPa27RKNlfedBd75CXXEuXxloNFj3UMUJoc7Q7636IlJLLFFwjN3N1TAyMJhIq9gVZ797cdFN0pgFZ8ghznYqL76D6AD7VVM14rqe0kpqwHlsVhGzSRlENRz30jDrwlsxe8lZ5TTpoQyHnoDl3twIzFMD3ysR/SBRRtQ7rTA3bz+FceWH7Sn0Y7n5wVXRuPGgFCHqLP5lQZWX1/H7UaS0qyMspSpPXBGdUVDP1BQS/hLAekrVJLjDVykOfcqP3Ol4jIjoiZfMghWk9FdX/t0ZUOBqx3Rn3ALvF9yj9qY/5RGlwl0+zZDotMkV7nbjUl16xJdAL+MR9xM2NkqxwGg3bVeWOtn4Z4UPJ2JRjxZ3WE+CRJnkh/pzRIs7gwTnSc9HdQ59hUP4yPwjYqYsABRuAQ9EpzUO5V+HkRixgtYciaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(261026121527099003)(261026140227099003)(261022105027099003)(261021135927099003)(261028144727099003)(11063799006)(261102123227099003)(261102130727099003)(56012099006)(261021121427099003)(4143699003)(10067099003)(18002099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rzg3TUlwYTFWbENWWWpXWWFCaTNXaEg1cVRobG4xc09VWlpFZmlrMmdiWGU5?=
 =?utf-8?B?YXM5bUdoZkIwczFCZXJLNnd2QjQ0NEdWdDU1VExJQkZ1V2NKVGY0Ym9LeURl?=
 =?utf-8?B?STNaZlVLMFRpSGF0MjlweElUaEVsM1p2cmMwVm1JRDNYaTk5cEpqeXZxNWJ2?=
 =?utf-8?B?d1NiUnhodnpKWkwwS1pyRVRJTGt1eUJYd1ZEalQzM0o0OXZpZGVleEI0YjVv?=
 =?utf-8?B?QVVCV3VXd3liRU1Xd3czZ2NmQW43WFJRek9MYlYxaHhIU2h5bUtObDloMG5U?=
 =?utf-8?B?S2EyU1lSejdNejRUMU1KSStHUTJRVlZVY0R1M3FZVmVsZWxOQ29RcnRpWFll?=
 =?utf-8?B?LzhYelZiVzdiSXdCYVRRckh6OHd1NkxKMnNna0I1QmYxcllIU3g3N2l0cnNK?=
 =?utf-8?B?T21mdGVvL3I2TStSTmdNN1pBaHZ0MTZPYnFyVU1GTzJUVjRMU0VKUmdzbTda?=
 =?utf-8?B?TlZrTk5vSXpxN3psVlBBdTY1TUlJeFpyNDl1d3E1SmgrWjRORlJBdG41K3do?=
 =?utf-8?B?ckVhMHp0akd2cDg2UWV1anByQStCRnZldGJxbGVPcG1kQktoamxNY1hpMGJs?=
 =?utf-8?B?amNmTVhzTnZpanI3cWdyMFVyVm4zYmtoQWMwUWRuYkhjVzgxSlFzOXFKTkFt?=
 =?utf-8?B?OVNJRUpkd1dhTm5SN3M3YnR5ank5T2J3eDBRRzdUbEFPUzhoMkJudnJFVWVs?=
 =?utf-8?B?TFp6aWx6bU5qcFp6TzRjZVNWY2MrRmYvQXM0NzNrY0FEdE9xRnJlSndoNXdy?=
 =?utf-8?B?bGJYM1ZqbWpBd21BbXVkTWlQaEduZ2NOUWdjQ2JjUE5VelpnWWhjNEZ3cElG?=
 =?utf-8?B?QkdRaE5oemZmWE9INFVYeDhEZ1ZiOUhmRlhQL1NDVVRmNDNSdU9nVWlXUmNi?=
 =?utf-8?B?b2hGbjVCMHl0bkQwZkx0bjhOZG9DL0tPaTBVcHE0NWY4cHZWKzEzbUs0Wm91?=
 =?utf-8?B?aWZNZjYwbTJDVXpzTElZUXpWV3pKTEd6Rlp0eHJ5ZGRCTitySTVIa1QwNTJH?=
 =?utf-8?B?NXkyVzd0c25nTWZDdWtpbkRSaGFDYWFoWVRucHJ3emtYYkpXang1Skc0WXo2?=
 =?utf-8?B?WW1LWVNNM2d6UDFobjYybHFoQkgwMkFUNGtjZE1yMVZzNEI2TWFRM0tlcXZW?=
 =?utf-8?B?SUpUcDhsdUxxMnkzdDM3QWE2cC9kSGNTRGQzRTRKMHdabS93ZnFLRElMeUdT?=
 =?utf-8?B?NCtYY3c2cWhjVlBjK3c0aTZtbFd6Zm1OZytKN3dMT2FSWFVOQVgwMW5oeXY3?=
 =?utf-8?B?QlJpVFJGUllnVUliNFI3TkVzSFFnOEJPNS9KK3VaOFQyUW14bVZLNGZjdm4y?=
 =?utf-8?B?TXl4THZtVVhvNDhWWitlM0U3endRcWlSNjhmRERCSkk4ZHFGMTdKY1BtZ0Zv?=
 =?utf-8?B?b3RnYzdYRjNLNFdXR0xqODVTN20wWkZIcXRwdW1nQnFEYWdzQ1VQODFtYm9x?=
 =?utf-8?B?UGFGRGJEVFBNc3RRRFNZZTBkSCtIcVpYTEx6WWpHajdreHQ5NU9XWE1LcVcx?=
 =?utf-8?B?QlZIcDkxQWFQK2RENVBlVjlnT3FGMW9UTFpUOThRVHRTdHRSZ2hjbmsza1pu?=
 =?utf-8?B?MklpZXRlaE42eGllTTBadWNIZDhVZlRQN2ZkbVR6OHZxbVdIcEpWcWN6Qkx4?=
 =?utf-8?B?eXB5KzhmNHl2WEd2TmlTb1M2MGx0MHkzOUNaN3lqZTc1bjU1cGt1OElqYVJj?=
 =?utf-8?B?b0loeDVDOXl4T0QxdHdhcHBtdVBwUGxkRlJTeDVVS0hORG4yZDIvMi9WYUNq?=
 =?utf-8?B?WEEvemppOHQwMUZvTC9qU01yNUQwaGtlRzZJUmpwVmJqc1ZrbU1GbUhpS2ox?=
 =?utf-8?B?R1V5OG1UeUVxYWtndWh1aE5leXFYNTJ2RU45blRQZi9PRmovcGt2VWw4ZWlQ?=
 =?utf-8?B?L1RDWW5NRU5sSW5UYWh3QjNrTlNWdmxDRUp1TjBTOFpxMFpYZmNkZXhid0w4?=
 =?utf-8?B?cHRsWDBPeFF4S0g1YzhneUpnOUdMWmhCR1JGSU5hQ1R3ZjFvdEpmQitGVDgy?=
 =?utf-8?B?T0hQL0t3bFJwbzJsZnpIYkZmd2g5ZUg4ZXdxbkh4c1k1U0tYWWtYUHplcFpX?=
 =?utf-8?B?M1A0M0N1QzkwNGRuTnRCN1huRUZIZG5hVUljazBGc25nbzBoV1dxY0REMWpU?=
 =?utf-8?B?M1JEYitWUTU1Q1djWDBWSnV2c1dDZWIwaVQ3dG05ZEJIUGFJRlRLanAzM3Y1?=
 =?utf-8?B?NlpJVkJ3dU54bUZUa2lzT2x5OUpQMDhQTFZlUjhMaG03cDNhbXFLRDVRbzdj?=
 =?utf-8?B?ZlgzVy81Ukxjb1ZQU3ZLeDZMVzRvZnEwd2Zsb3hrQTFNdkQ2dDdvN1VXSU4v?=
 =?utf-8?Q?/NJ6NVHxukSNgFHyhX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2039ce43-97be-44e2-6317-08df4b1f02c3
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:07:47.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUQ6Vftv+W5Rbu1HI1ijNRT0j4zeAXdZUGrYkEuPQ0HKmSEqjNE8pFWMVYUzdzxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

> An IOMMU inside a confidential VM needs private memory for its queues and
> tables. Later changes also need to identify it when handling TDISP devices.
> 
> Add a confidential marker and a helper for IOMMU drivers. The helper also
> marks the IOMMU device as able to access private memory. Drivers must call
> it before iommu_device_register().
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h | 10 ++++++++++
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fcdc..ba98a0bb800a58 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/iommu.h>
>  #include <linux/iommufd.h>
>  #include <linux/idr.h>
> @@ -313,6 +314,25 @@ int iommu_device_register(struct iommu_device *iommu,
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_register);
>  
> +/**
> + * iommu_device_set_confidential - Mark an IOMMU instance as confidential
> + * @iommu: the IOMMU instance
> + * @hwdev: the struct device of @iommu, whose own DMA reaches private memory
> + *
> + * Declare that @iommu runs inside a confidential VM
> + *
> + * Call this before @iommu makes any DMA allocation of its own, and not merely
> + * before iommu_device_register(). Queues and tables allocated any earlier land
> + * in shared memory that the hypervisor can read.
> + */
> +void iommu_device_set_confidential(struct iommu_device *iommu,
> +				   struct device *hwdev)
> +{

I might suggest "cc_private" here to keep with the naming theme.

> +	iommu->confidential = true;
> +	dma_set_cc_private(hwdev, true);
> +}
> +EXPORT_SYMBOL_GPL(iommu_device_set_confidential);
> +
>  void iommu_device_unregister(struct iommu_device *iommu)
>  {
>  	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ef5043752a3651..e8fb5ee59883e6 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -824,6 +824,8 @@ struct iommu_domain_ops {
>   * @singleton_group: Used internally for drivers that have only one group
>   * @max_pasids: number of supported PASIDs
>   * @ready: set once iommu_device_register() has completed successfully
> + * @confidential: this instance runs inside a confidential VM. Set by the driver
> + *                before any dma allocation.
>   */
>  struct iommu_device {
>  	struct list_head list;
> @@ -833,6 +835,7 @@ struct iommu_device {
>  	struct iommu_group *singleton_group;
>  	u32 max_pasids;
>  	bool ready;
> +	bool confidential;
>  };

And Linus isn't a fan of lists of bools..

But otherwise seems OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
