Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310023F40E
	for <iommu@lists.linux.dev>; Sat, 26 Jul 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539040; cv=fail; b=ostLkLc3POEfcdGwP5supSU5h9f8m3K3TbazhSLdRUeimd8VpOtRRbIYfPGECAAyHOeLjZ2JDH3lAZ9lSES5xoz6zP14H3qwRGVYFarSv+sgHknqE1XuMouFAo4GXWct7oGdmQZOHOXlJy6FJp+4zy2AvyQGVuGa4D/qzaCvFS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539040; c=relaxed/simple;
	bh=3sgrVhmArvVLzgtvN4qiHrEQQ6ZAFofqxhxH/HS2aDI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Nl5Mnwhb46Pw0XKKwRbvXRZ6ME7V3wvnF05CR/unNMjZw6kWyQnjzxQaG0kYlzeaZMdC3Ai7R66/rqXHHtRTj3o0kBpT9JjXSAGmS2rokmfKv/S5TgUnVytazz8I4eGE4YBenzz4sA5eMHpJKFvMiCSuaj5tG0SlAfPfFMthXAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NyLMuQ29; arc=fail smtp.client-ip=40.107.212.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NyLMuQ29"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUUAZYuRvMywxYGNtXpHUWPaBq7g9gOGibpprAu82HNKXrtT2WAkbBUFDEVoZbIn38vuQvrg6FWy2eOYuR5EsCEKevdoMmHYOuSXIqU5XjFrt1H897YQgDEz5TNSPfnIgrOeThcKYhHKEZ4JKCJ8YHl2lIk8FnkZdySkBrsbVHievvtHvRQxMhE50aXOGlNL9w+u1Gxjs1qj6YVLf7u4k1/YV+7gd5s+9bPNTVDCavMQ09hyCXO1kePmhIn4kCe724IF6o247L2wJXLIJppjEgANY4FVX3hE4PzVtwnhsfQjZJsPL6jNHa4NLaGj2nFJ9ezSnFBn7QJJoPiesE0Sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJBCcnKv5cZnMie8X4T4X+Pp7HqxNyo/ddVLWTWsg2Q=;
 b=y1sQGl/FToi5n0tp1/iim2HVaifjs26Yu0VrrmISzqeZzRUfNMLts52TF5BMgVJJAZBEygV7+EgNkmxBDtZqFCleag9ApFhOcPuPahSEqsyXgWRU2uuZaqrkSAUmJiOK9hRjh8SaFB8vOXuHs/ixgLrBTwp5iWTPRhGqsHJM8WOl1727HJ8y/Mt2vHt1g0vUZGLtKwK2mLRyJbYBFuWp9bJEITkEKLReYzzRcs94K5DHUMTH/QZnJs4in4BxBsBMNC/Wt0rvhrJp5OeOz9ZNRnRP7730FimQ61PT8wd7eSX4h6RKNY/1Ep5k0nQ0iG0DNB5cGMmHtBrJC6HMuButtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJBCcnKv5cZnMie8X4T4X+Pp7HqxNyo/ddVLWTWsg2Q=;
 b=NyLMuQ29mmUCxb5pYGgJ64uUEX1WhjSstxJq84untBUysQhDQUzTr5JIO0FuEODlIAdv0ESJ5K5zsZFeOpECI2e3LEl0OSWHyJ+KoRur7pcyHryZzEFIZt5H5OxOR3cybrGi7N6t7ZHRCdGIb5xxop5gxenUcnZkXiKaaVCFPa2BXuYX8nD4LnKpbAU7u+zl8usnF4GW9c7P7A+jD6Aj5BMLbxFzn47ooyF6ggGb0XblhObJRCBBvpqxkVKjg32GJ7T5TijGxLowidyl4584dfLxbrFFHDE0ONy/VDXOe1GtOC3+OogOUMOdaWCu7Fn6J9+lF6UjWT4oK3t7Zb4VCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sat, 26 Jul
 2025 14:10:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 14:10:32 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Jul 2025 23:10:26 +0900
Message-Id: <DBM1PG1UD7WP.7BNZGU3B7YMH@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <dakr@kernel.org>, <jgg@ziepe.ca>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@gmail.com>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "open list"
 <linux-kernel@vger.kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, "Caleb Sander Mateos"
 <csander@purestorage.com>, "Petr Tesarik" <petr@tesarici.cz>, "Sui
 Jingfeng" <sui.jingfeng@linux.dev>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Robin Murphy" <robin.murphy@arm.com>,
 <airlied@redhat.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <d0b11f8578d4b39f4eb5c1de8f17afb382429192.camel@redhat.com>
In-Reply-To: <d0b11f8578d4b39f4eb5c1de8f17afb382429192.camel@redhat.com>
X-ClientProxiedBy: TYWPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 69384914-c4cb-403c-4a6c-08ddcc4e2d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amVwb3NENUNscHZpSXZxcmtlbU05d0tMV2dOMFZYanpsS0hBb3hJcG9BR0h5?=
 =?utf-8?B?b3dUOE1XWnpWT1p4N0ViOUZLdVZrN0ZVODVPVzluRVRveEVka2k2Q09Uay9R?=
 =?utf-8?B?RlBHeG9wWWRjMDdlSzVYQ05EMGwycXFMbGpuZkc2NTVTSWJBRnRxMWJtSU1D?=
 =?utf-8?B?TTArSVViVzFnOTZ1K1lNRFo4dEN6a1ZlcHpqVjhveExGSVhZZXVkL2VyNk5B?=
 =?utf-8?B?dE9XdjlWMFpidmFoekN1a01idEhUbzdveU0rMmpPd3NCK28xT05Ddmk4ZGJi?=
 =?utf-8?B?TFk0eFJkUHJHVDFKaFNUK2JZYXduK0JDQXNLT3pRYTRFaSsyWHJGa2RqMWtW?=
 =?utf-8?B?dVBRRE1ETVhlQzdVK3NDTEROZ01YMjc3QkM5Yi9QL1JqVTl0dlp6T01YdjFy?=
 =?utf-8?B?SC95NjFIQjRZTkFYVmw2TkQ5aGw1UkdWQVpLdnczVGdnUW0ycnJlV0gwdWhy?=
 =?utf-8?B?eldYbjNhUlRUMzJwQU1Xcm0rMGtjbzNGaXJwNHNzMjFGL01jRTkrQWIvSjdG?=
 =?utf-8?B?bEduNTUrUlk5M3lVSnl5dlBVelVYWTlFVTQ1bXhJQWp5bXpKcTk0TVVVZDNP?=
 =?utf-8?B?alpSSCtHclQ4ejNvelVkKzR6TVBrcEs0ZXR0OElURm5iM1I5WFVxQkVMUzRX?=
 =?utf-8?B?SmRTNmV4alpJd0ZPYTM3Q1JrQW1xbFMzTXAydDVPWTNZWEdsT1RXa1V0UGU3?=
 =?utf-8?B?azRNekE5aFczNmh1cXFQT3BMWVpNNGY2eVlISXZJTnN5MXFPU0FHSHYzblRK?=
 =?utf-8?B?R3dHd2FuTnFueTNNMForK0ZFdmt4K01ZVnNmYzZtSm5UZ2lWL2x1QVo2Nkh5?=
 =?utf-8?B?STlIY2p4bkg3YitSU3poQXB4bE9FaXNJUTVYTm5EU2wyV1pCVVJxbHMvMVhS?=
 =?utf-8?B?eFYveEQ1NDVPNkVQa1ZCWjdaZmVyMHhDdzVuNWdQK3A0cTFEMDZsYUpGTUJN?=
 =?utf-8?B?MC9UdE96eFRyQ2lpMUpDMHBCZVdpUWtWQ0lGUFRsVUhLempNQ1Q3RS9qVmFj?=
 =?utf-8?B?dFZEbk5zVjFDNnVFRjNwcmhIVzZDOFV4aUJId3ZHMjVyWnJvYXRxWmxYZGhh?=
 =?utf-8?B?MUY0WVh3YlpQbFR1NE5OSFJYeUt1R2JlM2JkdDFucnp4ZlE5VThJRUFRcE1V?=
 =?utf-8?B?OUcxcllFTUswNUQyZGdoMFF4QTlUbklSZXJ3ZHlaQ2huUmRlckhvVFFsd2lJ?=
 =?utf-8?B?ZzRiRmxIanhOK1NZa2hXbjQ2akR2TzRPSjQraTkyM1pHQWNVQlduOENQMUpt?=
 =?utf-8?B?aFRzem5WK1B4V1MwWktpbi9hOTJHSktQa2VTTHl1MzJDcXkzekVHRGF5RGU5?=
 =?utf-8?B?RE5Sd2NBbjdlMSt3WEU1WG1RT2ZaV0FZRVRtWjFxVjNCVEIxK04yQnluNUht?=
 =?utf-8?B?RG9OaStEUkJGcWlHZDA0MXpaNWtLdm1vSHBibkRuRGdxc2RoQURUSWJGRGxU?=
 =?utf-8?B?WjNuRlIyc2xNZlZENGhjTkZJcXZxczE3blNERU0xdGd6MGVxRFdJOVhzQXRj?=
 =?utf-8?B?clRhL204TVJNZmMxL2JSdmE2VXdRd21YK1NvV0JNb2R5RE41eEw4VHlLQmhW?=
 =?utf-8?B?cVFQa0lidzlyQnBBbitRU084cEIrUWF0SFdpK1N1c09iMzRWSlNnVUtIenQr?=
 =?utf-8?B?RXJ0dzVTNGFPR0FWbU9rSExvMW9BbDB0czFWbFhUc2JvSEhxL2dhUnhBcHFn?=
 =?utf-8?B?SWpDczFmSGN2U20veUZuMnRqOTJuUnRYUWhRWlVqbGxvUkIrK2FYQk1VN3Zh?=
 =?utf-8?B?cGR2NmJzRG1qRE1QQVNGcDZKc0RkaEVYK0c3bjI0SnlGbGF6WVhseDZ5Sk8z?=
 =?utf-8?B?WXJnUjFCeEpJNThzTWxnNmpJSEdXbjdDZzlMTmk4cGJndWJ5Vmh3UnVlRVZG?=
 =?utf-8?B?dWtFbXZkSHZIQXdTUmkwbnVzSjJ6eWxwaFhZMndnK0lyRFdlbWQwUFA2T3p4?=
 =?utf-8?Q?YOtZ4Nm/L1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0J5d1l5RXE0eGZFallnODNYYmtNYVlNdE9RcEVVVDIzT0gzUjBVT2Jld29J?=
 =?utf-8?B?U0VVNThmck1kZUlqd0dCU3QzZWxnNngxanRtek1YM3ZHTEwzazBaQXl3SnlX?=
 =?utf-8?B?NTk0TmY4TDJGMlRmNXJsM1ZWakk4U0xBMUppQ3hMTkI0d0ZscHRGQndRdlBK?=
 =?utf-8?B?SnFXUmx0bXA3RkNDRWFjR1B5TkROeUpKNjBHNUpVbi9STUhWR3IwcGlrcFkx?=
 =?utf-8?B?QmtSM3BFallQWnNWcllUaHNOdEFnekZTR3lXcU04NDNJd2V6bWZOL0lvN2NY?=
 =?utf-8?B?UzhjbVQxRmtYZjZpVURwOWJXM21Uck1icEFNRUJuWU1yZUU0cE1uT3E1dSth?=
 =?utf-8?B?RkwrWkZySGdqSnhTNkF5YVJydVJIOW01ejl1eVZwVE5DUGJ1aWU4UzdoakQ2?=
 =?utf-8?B?aEMzYUEvMlg5ejRLU1BQclIzcm92RzMxcysrMEx2cjBVL2kwUSt6RmNFN3Bs?=
 =?utf-8?B?V3VhZ3k0L2ZSV3J1cS9kZ1dySDROak82dmo2OUQ4Tkc4T1lreTdXb0I2Vm9S?=
 =?utf-8?B?MW9aV2FuQWJzUnhmN2kvaE9sbFF4cEp2SmpXd2FuQVRQTVFuY3ZhMHFoMVlo?=
 =?utf-8?B?b3dtM1RkcVhwenhRN1hTbkp0MFFHWmRuemhUZmxwc2pTOU85THZQdDVRbURJ?=
 =?utf-8?B?bjdnV21HT3FYTkJLb3lmTVBPYjdkZlRBU21OVjZHOThDMFo3K0I3eDB5U3pr?=
 =?utf-8?B?NjZrTUhsbHpTUXZHTVNpVXVRd2c4QjJvblNYcnhXU1hzRHUrWFNIV1VGam5i?=
 =?utf-8?B?eWNHZ0ZlQmJsSzFKZnIzaDdlSnYrTGhmVTk1VlJpMkhUZzNZWlVzaTk5RVdG?=
 =?utf-8?B?eEExcHpJWUFBRGY4cDJlUll4bnNQNS9JMGR2OU9ReE9GaEJrZlllQVdkMlEv?=
 =?utf-8?B?NVRqdityUnBUdkxOeGx3dlZJYkJ5TFU0azVubkdqMEFDTnJHTi9FbXJkTTN6?=
 =?utf-8?B?ZXhvWHVBTHJUUEdnSkZIY21Tb2EwYVVWL1FqelVIa3FxQzNoQXhuay9ha2JW?=
 =?utf-8?B?TzlpVmNOOFVNMWtwT2tsQy9RWG40QkJtWjZBOFUveGFPM0d6NXhMcmVBNGZB?=
 =?utf-8?B?Mmd2WGpFYTJySHY2cXFLWDJGaGtLM0ZVMjRUQXMyaTZLY3JoMEFNWGZocXRw?=
 =?utf-8?B?cXRwUkZlbGcyUWFFT0pUbjZLOGk5L1dMVm5nc0xWVkRuZGRIcllEckFIUC9D?=
 =?utf-8?B?V1liaG5nN3ExZWhCWklpRG5oYThpWUd4a3dDQzVDRzFjWHhoeHdSVTlkUVpw?=
 =?utf-8?B?OEtXOXJwUVFpdWF1K3pLZDZjQWw2L0FYNWpwTW9VbWdmMGd2d1d0Z1NENGRI?=
 =?utf-8?B?bjI0WUpqang4aG9TWksrUzA4RU9GU3BxVTBFczIrcDJENkVlUmkwV2NVekhq?=
 =?utf-8?B?aFJWMmdQTHZObWF0UVdEZVBUWEpyd0xhS2UrcmE5N2FaeGRaclJUNkVzZ3BL?=
 =?utf-8?B?S0VCNU5kNVJibHVkbUpzYnpGS0sxVGRKKzNrTnRZc3I1LzJPTTcxaDZ6bGZ0?=
 =?utf-8?B?TitjL1o5VWd3QWVvYWtFUW81UVduWGpuM2gvSG9MZlRvVlhQLzJZbW9tVUtm?=
 =?utf-8?B?VFVMb1hzZGQ5UFM3ZTRsa0tyNG85YWxnNFBUSHFSK09lZTR5NUMwS2RSelBP?=
 =?utf-8?B?QUdxUnJldUE3UTh5VnZWdmVvUCtQUHY5OEpWTUEzcVlzaGJsblFXaEp5UWlR?=
 =?utf-8?B?Z2VyRDBLRUgraDhYMHNGVjU1aUVVMzgxVndiK1A4TmdwTm12R1lDQ0prclZJ?=
 =?utf-8?B?N3JQNHM5VWpPR2dWVjEvaXJpRittNEcvRUhTVHdDNkdFWkw1VytyTGRPRERB?=
 =?utf-8?B?TjdUVStBc29sd2kyMkFNMzBCQ2t4TUJRNVlIZUZnT1JvMU0zWmtuVVB4Y3h2?=
 =?utf-8?B?a1RwQ2NvSUNBbEQzMkFZdDE5b1FLRFczRGdRZ1NuL0loRHd2L1BVSmRLZ0lN?=
 =?utf-8?B?bW5kMDJrSTFpcHFPdlp4aEY3QmVrT3NQSytOb2hORGs5Vzk3UWdGUjhoTTZ0?=
 =?utf-8?B?cGlid1hKaXJyaFNObytRajVaRVc1UlkvcGVEOXg0NGVHRmY3NXZrcjRkb2tK?=
 =?utf-8?B?eVI4L1RaSmQxNHRxcno2ZjhubUU1dUNZQ1BNTnpJTGt3ZHQySkUwUENmUHh6?=
 =?utf-8?B?M3RCY2NSd0p1aGxBd1dXcE5LTkJVVmtpMTBtZDhLNTlrNHFSaVp2MUo3eERz?=
 =?utf-8?Q?QxmEqRXNA7+kpX3Ldo7TlVJ0QnKoT8A7gpknNIfMAXig?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69384914-c4cb-403c-4a6c-08ddcc4e2d85
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 14:10:32.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOwsWyml73/HSdXpHwiYFBF4jEyxcWel5qvTTBRht8Yq6DAdgtaxAgfLSfzrNFjPYgMh7/OQBOPqZ1RqeDJSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860

Hi Lyude,

On Fri Jul 25, 2025 at 5:19 AM JST, Lyude Paul wrote:
<snip>
>> +/// Trait implemented by all mapping states.
>> +pub trait MappingState {}
>
> We should make sure this is Sealed so that crates don't try to add
> MappingStates that we're not expecting

Agreed.

<snip>
>> +
>> +/// A scatter-gather table of DMA address spans.
>> +///
>> +/// This structure represents the Rust abstraction for a C `struct sg_t=
able`. This implementation
>> +/// abstracts the usage of an already existing C `struct sg_table` with=
in Rust code that we get
>> +/// passed from the C side.
>> +pub struct SGTable<T: Borrow<bindings::sg_table>, M: MappingState> {
>> +    /// Mapping state of the underlying `struct sg_table`.
>> +    ///
>> +    /// This defines which methods of `SGTable` are available.
>> +    ///
>> +    /// Declared first so it is dropped before `table`, so we remove th=
e mapping before freeing the
>> +    /// SG table if the latter is owned.
>> +    _mapping: M,
>> +
>> +    /// Something that can borrow the underlying `struct sg_table`.
>> +    table: T,
>> +}
>
> So - I notice that instead of having `SGTable` just hold the `struct sg_t=
able`
> as an Opaque<> we're now relying on wrapping the SGTable around another o=
bject
> that defines it's own way of returning an sg_table.
>
> Are we sure we want this? There's a few issues I see here, the first bein=
g
> that we're now providing the ability to acquire an immutable reference to=
 a C
> struct to all users (including ones outside of kernel crates) of SGTable.

Note that the Rust `SGTable` itself does not provide access to the
underlying `sg_table` - only the `T` parameter, for internal use - it
isn't exposed to clients of this API.

> Maybe this isn't that bad, but IMO I've always tried to avoid ever exposi=
ng
> anything from bindings outside of kernel crates - with the exception of t=
ypes
> like c_uint and such. My reason has generally keeping things separate, bu=
t
> also making sure people don't default to trying to use these structs dire=
ctly
> in driver code for functionality that they may just want to add into the =
rust
> bindings.

Hopefully that's not the case, but please feel free to elaborate if I
missed your point. Or maybe the problem is with the fact that
`bindings::sg_table` bleeds into the public type of `SGTable`?

>
> The second being it just feels a bit backwards to me - I'd intuitively ex=
pect
> an object to embed an SGTable if it's adding additional functionality on =
top
> of it, rather than the SGTable embedding the object. Especially consideri=
ng
> that not all users concerned with SGTables that they get from C code will=
 even
> want their own wrapper type and may just want to return a plain &SGTable.

Mmm I have to admit I am a bit lost here. But FWIW, you can get close to
a plain `&SGTable` by creating a `SGTable<&bindings::sg_table>` - since
`&bindings::sg_table` implements `Borrow<bindings::sg_table>`, this
works as one would expect.

Layout-wise it should even come down to the same, as then the `SGTable`
is just made of a reference to the `sg_table`, the `MappingState` being
a ZST for these cases - so even if you cannot simply cast a pointer to
this type, at the end of the day the result should be identical.

>
> However - if we're expecting implementors of `Borrow<bindings::sg_table>`=
 to
> potentially need to grab locks or such whenever they need to access the
> sg_table, then I suppose Borrow<> makes a lot more sense here and this de=
sign
> is probably fine without being inverted.

TBH that's not what I had in mind - I wanted to make sure we can support
both the owned and borrowed scenarios with the same base type.

>
> Also BTW: I assume this might be clear to you already but in case it isn'=
t,
> with the design I suggested above you'd still be able to safely cast from
> `*mut/*const bindings::sg_table` to `&mut/& SGTable<M: MappingState>` sin=
ce

Is there a benefit to being able to do a cast vs. the construct I
described above?

> MappingState is a ZST. As long as you can guarantee the struct is the sam=
e
> size as the one on the C side, you should be good. You might want to add =
a
> #[repr(transparent)] and a type invariant in the comments mentioning that
> `SGTable` has an identical data layout to `bindings::sg_table` due to
> repr(transparent), but that's really the only downside.

MappingState is a ZST only for borrowed mappings, i.e. mappings that
come from borrowed sg_tables. In case we want to own the SG table, we
also need to be able to unmap it on drop - and this requires some extra
data which we store into `ManagedMapping` mapping state (which is not a
ZST anymore).

Now I think I am lacking a good understanding of the model you have in
mind - could you share a few data structures of what you are thinking
about? I do understand the SGTable simply embedding an
`Opaque<sg_table>`, but that's about it. :)

