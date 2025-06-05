Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48394272E54
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131775; cv=fail; b=NQQY46COHdmW65imUH6c1VxFkXkpmw4BGKASZeIV9yUAZ5JML11CjXkjIfVO/RSur4hbNqKmDrq3Y0vw5TDX7if5M2jAHLsx9Zq18u2BxSvxNMhrAEsmTjX/eWjra9XEoLnAkXX8BXncoT9Z3bBKJhGhGTXbGRy9pfCFgKsO/qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131775; c=relaxed/simple;
	bh=NNFvRe0SOvsgW6QHR+0tQfa0D3UKcpgQOPmiDTKfo4A=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=a0w1lNLOc6MwDl3DMZLHnyamyIKXFGRcb0Bn4d23l9LlkgOqhrCJUQIz9vqHSuTNeRHpSc1j47W/IhkxNBZucte+5QbqWRe3PWK1zQxO6Mtpe006H+Ze2mJgupPxJ/gzr+6Yi53YfNlJK6fNslYUh8xJSMFwDiSmI9XrWcFB0Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gEicDXpw; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gEicDXpw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+/vLWXJOlOxhEI04Zt5hEt5KoJ//W+MWNeAxZh89mxANR/Edn7a1aVVVNP667yyBqpxSyXmgJ5vTRkcFP7mNy7YMMwKXJL2CQO4w5pYgudg0DbRdyVaFlpn29Z2lOlxhLx3J8yE18TfocyiBlO4MohrosorUzZMkEGssNBu+exeUXqKMl1sdfdPg0lfVDizgxcnq3gXqBN6AZb51X9jX5uxmhzqaCIJ5BgyJ2dRkDzRjxj8nK92y0CTQjY7Vuihwv0gbLqSy4zU8xsTodf2yYEu9A3EMifQOlDAXjimgj2bDer1jdwixRIZorES7fBTaE9+bezOFsGj+TKTvfA7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aTVw9/cBcOYPFMmpZNSfT3kBCIuuzErH4mit1Ezn5g=;
 b=rLd34ZVOXPr1cxMAd2lSViQFI+NrkEcwBlsYN3dU+hkhCkUf7GplMCsq7VkVqnE6GnvgsJ7RBlAgk5aaYm/orc5GMJ94jW/QzHlu4oRtx1QJIeukRC5LKfpJzM+iL+DRy6zsQLguyDJldeTf18gVMJdjWIC/4rQDKSytyXV94/Yu4S2YYyscWE01DTOWnIMN/z8Pf05EAKXmyS3QaTjZtbQ7mDz2dz9vcAOe7pcaQG7bezA9S2b43c4pD22JNAB8TtUpL9/oDSrBXmG4PLNRc2Vqt8L93BTOEF7rjlU3AeQY6xEiKEWOpmQnRDClvuaba0CoP2+2AvYfbVf0WfnnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aTVw9/cBcOYPFMmpZNSfT3kBCIuuzErH4mit1Ezn5g=;
 b=gEicDXpw25uVvRo4MA+OQG0o9DYHqRQX++jN5auLzFFgCsJN63P1cWBz9KsEE1SbSXU/SJYjXY/Czsw2VHKNhjx0lJdWi9h04RUsZHuX1EEJw4wxovUHy6DNb0LWNyfLS0qfYLYlYNMfWnrhmAKvOuw9UIZMwQk3998x29sPtc6HKj38HqjNMmWlgVKXAfO+gG0xJLAAEE1dKZU5f3jcKxsVG62zE0HN68EFoaAn6BIouBRXVKNgNBmUjh3gxohaxLqJtU13kaKNVoiapP/LkOKSGLa/ROdfMYTuWjAYBwTVXQ9OsXl+1NlHHApmitIb5jaQHQCtJDrp6HISozEDOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 13:56:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 13:56:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Jun 2025 22:56:07 +0900
Message-Id: <DAENGORNRVZH.2KIGKFV5C5G3L@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Lyude Paul"
 <lyude@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
 <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
 <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
In-Reply-To: <27e17dbf-df6a-48fc-a652-ad48a776f668@gmail.com>
X-ClientProxiedBy: TYAPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::28) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 29544206-dc20-48c0-a599-08dda438b9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFlsMmwwN2lzMmVmeTlZdzBoN3lHTjlOMUx5UzBxOUxONlJsWUNKVmdDbjhz?=
 =?utf-8?B?aU9UaDhhdkp3VTh6eWRjV0JlS3NQSzNWb3RlOCtkTnNhUkZBUEpTaDQza2Q1?=
 =?utf-8?B?NjFYZW16bkVWZ1ZYY1Bvcmg1QnNmd1pFQzFmUHVkZ2NNUFRpc1EyTVFFNnZt?=
 =?utf-8?B?VFBQWW9Da09yS3NmRWhDc2tuV1pTUTB6d1IxNVBucDFrK1RXUVZiZENRY1Z1?=
 =?utf-8?B?OWpnckV0TGs1bDVzL0lhUm45V3JqejhkZWFhRE44UFJDaFZ5WjFLMGRMdUFS?=
 =?utf-8?B?MHlKREgreEhxaXl1MWVTUGJxNXhiT2MyaitEMnkwVTFINVZtMCsvQSt5a1Vm?=
 =?utf-8?B?R0VpVEw3dzRQVmNOSThuNHBGWmxlNTJRYnNpU2VNcUxSQVN5VTdBdVJjcC9t?=
 =?utf-8?B?aVFSTzR3WHNQVlFOa2ttZGR6M0dlQmNHanNLbkNHZ3hIZ2QyTzQxK2gvYU0x?=
 =?utf-8?B?eWNjazVPU1VGWkdBWHFNV0dxMFYyaVZmakpWNDZXRE42a04yRk5CWXlZNExD?=
 =?utf-8?B?bk9KRnRmd3A4aXFRUkx3Q2ZzNXRFUTNlYmgvMjZwTUo1M05XM1VFQlBmQlFm?=
 =?utf-8?B?YktrRDR1TDgwQnV6VG81Q3ZTdERGR0FEOGR5TmZYNTFhNzNhenFaaUhRZkZO?=
 =?utf-8?B?N0kzMExrL0JOREFCSGgzWnA4cVNNS0JiMGZESFM4c1VYbEE0MHgzd2hBUE9D?=
 =?utf-8?B?czNtZUtFdkNkNVpEZjBRUXR1aGFnUWhTaU9KcCtzOGF3NDVpQnEvRVhHem5X?=
 =?utf-8?B?MnUrR2FLdEZaYXNQcGdNVHN2Y1VHNmVGTVcyaWFMMnpLaHVoRThJTHBWTjRI?=
 =?utf-8?B?OVc4bWRFK0xRZTV3RlZUR3dsdzVXdTZUVGNWU2NDUkJMQU5XVXlrb0d0UDVD?=
 =?utf-8?B?TUV5T0FyZmRtOEpEM1FabC9GbGVKK200U1lsR2lCWTI5SE1uak5VeS9Ha1Aw?=
 =?utf-8?B?RFlmZ2daaWg4eTJOSHFEUE00ZHJUZGFDTXMvRW94eEhwaUxuL0I0QkREb1N4?=
 =?utf-8?B?b0dUb3BGOE0wVERsVTViM0NOcUZVdFhBd3BpUHJJZGZBQTNyMldSd2ViR2g3?=
 =?utf-8?B?NzhRdm4ybmhENWMvN0lrRjdkTGpPQ2pYTHFtVHZtU0Z3VVRNM0c5ei94T0Zw?=
 =?utf-8?B?Sk44Z1FpNUJpT1JPTThwdElvaTBnMERxdXVqdVNNaU9KMHg5ZnNHclNkbmlr?=
 =?utf-8?B?VzhlckhkWnR6elh5WjAyZTlWbnMwSG51QWtIcEZZYld6cFZZUWZrQmUvaGdx?=
 =?utf-8?B?QVpaTklrNU9EODh4cG5TdlRjdE1ET3dkbkdJM1FFVFVNdWRqTUVxMmZpNEJJ?=
 =?utf-8?B?bDRJemU4RHlKRlhzRGl0Sm0waXAyVDNtb3J4MGJWTWRGN1N6WWtZSUNJbjI1?=
 =?utf-8?B?UXpVN2hmUytQT3dodE9EREtKc0JkVDVEdlgvZXZseVRFdUdzK0VmdVFPS25D?=
 =?utf-8?B?OGQ2VDk3TVR5WU9FQkNFMHZXbmpjaWx6R1B5RTliTHFiQVBQMjhKSHNsT21h?=
 =?utf-8?B?THZCOTlZQkxsc045N0Z5Qk9lbWpTZ3plS2hFTVU1bFRFdTNxREh0dUxoNERs?=
 =?utf-8?B?ZFlQbFM0MkE3SWYzTW5ZVFFqbzJIdFB3RUg2NUluVno0d05vYmRxYU1EUmJw?=
 =?utf-8?B?SlUwUU5EQllrb2xiQkNLeXRISXE4Z1d6Yk5JY2VYUzNnR2dhdG1HTWx0NXBU?=
 =?utf-8?B?MDNFbzBIaWRnY2l6QzI3UmF3MTIxZC8ySFZkRE1JY0FHTUgzUEwyTTMwNzJu?=
 =?utf-8?B?Mlp0TWd2bVNCVzQvUmFjSG5INjFTbFVvd3IwVHVpT2Z4UTMzcTNNVWJweWZT?=
 =?utf-8?B?TnFFbndmc0NhUzNrSFQwUUt3T2sreW1Bbm5MdEVYTU5sL2NkRU5Bc3p1TTBU?=
 =?utf-8?B?cmF0TnJLSzRKWWVEa1BKK2RUYVlnaVZKQVhjczMwTnNlaTkxdStmOE84SUVr?=
 =?utf-8?Q?nPIgja9Vwyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk1OcytQcnhuY2tqUlhibFR2SUxzMHNiTzhIZUFGTlFWQUhua2VHZWFFZ21n?=
 =?utf-8?B?NjVNeVgyRHFoc3dKOVRMaEdCZE91WWZIdWpWSEdYeCtzMkNRUGMwR1dOY1dn?=
 =?utf-8?B?RHMwNzZRaW1IRW1HQUVIaW1HdENtbVlDc2thV0o0ckt3R2xvYUZKcCtMWGNG?=
 =?utf-8?B?cU0veXpuU29vZmNMdkI1MXNKMm05RFo4OE4zZXdMTjVVRzltSjlpWHg3Zk5O?=
 =?utf-8?B?azRPOUg2TWtEMjI0N2hMRUxQVm5pNk1DdU4wTWpjWWRKSkxyUzRzZTVhczVz?=
 =?utf-8?B?blF2RlNaMmY1cDdNTmpZQzNtQ05PNlI3UFNSd0g5N0JEeTA3TjBIb3ZVem9N?=
 =?utf-8?B?VFdzV0FUUFZIdDZDa2lDeEZHRWlzd2VEbENhS1VsZE1WZ295YnBVOElKVGZD?=
 =?utf-8?B?V1lYR2hNazc1cjFWR0hNL1ZxMWpWTkUwd1lzdzhEeDUyZUk3WlYwNUFuSm5r?=
 =?utf-8?B?bUJVUCs1YXV6UmN6NnJCWU5yTVBUa0tONHE0NkI5akhoN3lXRTVKbFN0KzY0?=
 =?utf-8?B?aEJJRk5QLzNtTjl1ZWFaNk9iM1B2RXhHNnZZaVlMK1c0UHpuY0tZMEc4c0FC?=
 =?utf-8?B?S3VjKzJRSFJDS1Btb2JuYzhjZ2x3NTU2WU9tMGREeGMvWFNvRzdTYm5XSExo?=
 =?utf-8?B?RjBQL3I4TUdkMFV3VThWZ2VyMUJqNktjMzRZQ3A2djRUUmtWV001TDQ5MitZ?=
 =?utf-8?B?eTRkdWZKanpCSldWVUFFdU1ndG1jM0pGTzRYSnB3Y0dyaHVrWDh0SGNocFdw?=
 =?utf-8?B?b1llMHN1L2gyTTR4OU1vVDM5bnpNSnRKdnYraTlRczlJSXZreFArN2Z5eWgy?=
 =?utf-8?B?eUhBbmxaQjBxT0RlcGhIeExJQXM4cVllQVpwSmcySzhQRWk4dEVaeGlmUFhW?=
 =?utf-8?B?UzQ5SHo2S09SNXNYdFF0M3RJTkUxcTFJUklRZS9VZnJiZ2d5RStqVldDc1B5?=
 =?utf-8?B?MDV1dTFVOVF1aDNKL0R5SnBrcUZTR2J2UTFSSkJsd2Rta2FjMVYzWk9kUjda?=
 =?utf-8?B?dDh6QnhTVHVrVDFLYzh1SnRhU08yWUZKckgxeFRjR2dJYTkyZmsrVUdwYlYz?=
 =?utf-8?B?YVc0aEV1Ky9hdWJHa2NxQnR3aEFoMS9jU1FiYVdVcFJmdFBBclRLUmI4cGpp?=
 =?utf-8?B?djY1c0lHYlFWTFFMRldVWWVHQnh5Qlp3NjA4MXJITEZHZGN0YnFYYUV0Q053?=
 =?utf-8?B?ZzMwQStnQjFHYzNYWWY2SjErYURaZ2ppR1FhWlQ2NkdsT2xKaUc5NmRXZTJt?=
 =?utf-8?B?WnFnZ2xEeHZ6UW5qKzJqVTIrVWYxaWVoUTMzcDBPQUwyeEUyUzZLYUErQ1FG?=
 =?utf-8?B?RU8xZE1OUFppaFh1eDNCNERnZUJpVDlQK2VGdkk3RHYvKzBhTFo1QWhKWnBU?=
 =?utf-8?B?WVlhS2pkRVUzNDg5Tkhtd1BXbW81Nm13U2FyTjhVRjYvZk5icUJ5eTZYb2I0?=
 =?utf-8?B?ODZEM01BR3I5MDYwK3pnVGRHNjViUFFpZGpRMkNvSmR2NmJvWVJVSGJXbTlJ?=
 =?utf-8?B?T1ozUlp4WnRjcnFDT05rOVd0aGU3RjNUOVJTbkl1RHVBK2JDbTR4TjgzYjlM?=
 =?utf-8?B?eE1YT2ZGazZQMDBicmFJV0x0V2tEUnBualZOUVQ5REZGaFBlSUlHNFVuV0hK?=
 =?utf-8?B?dWtTZ0tRSC9aSTYvVjlBbDN6ZjRDaW50eUhYY1cxSjI1YlVrV3B4d1VYck5v?=
 =?utf-8?B?OUt3SkllOENqTEU5b0FwSU9nRWdQWENkUWx0NUtuTFhHOEVZZ0MwUE1ndzRI?=
 =?utf-8?B?YzlRaXlmQXhaSU9tVzZsVmFmWU85TkNWMlVvWG9wdGhpNGQ3ekJsdFB5b2NC?=
 =?utf-8?B?ekg5WTZ1aERjUmRQZlVpRVBJZ3JxNy83TEF2ZUs4aTJtMURGY01tejRZMkxm?=
 =?utf-8?B?ZGwvRHcwWFlFeUFubkxRZWN3cklzMmJyUzArY25EM1BYZXAwMEFzaWRSaFd1?=
 =?utf-8?B?eFZyR2Qxa0F5cURvc3Qwanp0M1ZhUUhUV1A3T3RNRnR4SGoxMmxrSGYxVGxH?=
 =?utf-8?B?UjNOUXhxSDkrU21ocEdscVBjQVhpc3BjQTZ2S2JwV2xHT3U0cHJEZ2c1VmZU?=
 =?utf-8?B?ODV1YU5NR3Y4cWE0R2NINWZMVmZidU5PcUkwL3FrcU0xRXd2MzhEMG5uNzE0?=
 =?utf-8?B?Q2ZnQ0pIbWErNi9zUVNZUjVCWDVRVzQ4TDRGcnVMVndGaDEvbjFLYUhJd01k?=
 =?utf-8?Q?puR/QtJLy48ERfIqW5E+ocz/gOsSn4hbXJoLBtOOfQWf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29544206-dc20-48c0-a599-08dda438b9df
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:56:10.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGzegzv4IwM5ACwDkLoetOYYkIP4godvQD17FkJ0N3bYaAiv/ebhkZj//F5LaBbSiVuN3wdEZvdh13/LvZyDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570

On Thu Jun 5, 2025 at 10:30 PM JST, Abdiel Janulgue wrote:
>
>
> On 05/06/2025 08:51, Alexandre Courbot wrote:
>> On Thu Jun 5, 2025 at 3:21 AM JST, Lyude Paul wrote:
>>> On Fri, 2025-05-30 at 23:02 +0900, Alexandre Courbot wrote:
>>>> On Thu May 29, 2025 at 9:45 AM JST, Jason Gunthorpe wrote:
>>>>> On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
>>>>>> +impl SGEntry<Unmapped> {
>>>>>> +    /// Set this entry to point at a given page.
>>>>>> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u3=
2) {
>>>>>> +        let c: *mut bindings::scatterlist =3D self.0.get();
>>>>>> +        // SAFETY: according to the `SGEntry` invariant, the scatte=
rlist pointer is valid.
>>>>>> +        // `Page` invariant also ensures the pointer is valid.
>>>>>> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, of=
fset) };
>>>>>> +    }
>>>>>> +}
>>>>>
>>>>> Wrong safety statement. sg_set_page captures the page.as_ptr() inside
>>>>> the C datastructure so the caller must ensure it holds a reference on
>>>>> the page while it is contained within the scatterlist.
>>>>>
>>>>> Which this API doesn't force to happen.
>>>>>
>>>>> Most likely for this to work for rust you have to take a page
>>>>> reference here and ensure the page reference is put back during sg
>>>>> destruction. A typical normal pattern would 'move' the reference from
>>>>> the caller into the scatterlist.
>>>>
>>>> As Jason mentioned, we need to make sure that the backing pages don't =
get
>>>> dropped while the `SGTable` is alive. The example provided unfortunate=
ly fails
>>>> to do that:
>>>>
>>>>      let sgt =3D SGTable::alloc_table(4, GFP_KERNEL)?;
>>>>      let sgt =3D sgt.init(|iter| {
>>>>          for sg in iter {
>>>>              sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as =
u32, 0);
>>>>          }
>>>>          Ok(())
>>>>      })?;
>>>>
>>>> Here the allocated `Page`s are dropped immediately after their address=
 is
>>>> written by `set_page`, giving the device access to memory that may now=
 be used
>>>> for completely different purposes. As long as the `SGTable` exists, th=
e memory
>>>> it points to must not be released or reallocated in any way.
>>>>
>>>> To that effect, we could simply store the `Page`s into the `SGTable`, =
but that
>>>> would cover only one of the many ways they can be constructed. For ins=
tance we
>>>> may want to share a `VVec` with a device and this just won't allow doi=
ng it.
>>>>
>>>> So we need a way to keep the provider of the pages alive into the `SGT=
able`,
>>>> while also having a convenient way to get its list of pages. Here is r=
ough idea
>>>> for doing this, it is very crude and probably not bulletproof but hope=
fully it
>>>> can constitute a start.
>>>>
>>>> You would have a trait for providing the pages and their range:
>>>>
>>>>      /// Provides a list of pages that can be used to build a `SGTable=
`.
>>>>      trait SGTablePages {
>>>>          /// Returns an iterator to the pages providing the backing me=
mory of `self`.
>>>>          fn pages_iter<'a>(&'a self) -> impl Iterator<Item =3D &'a bin=
dings::page>;
>>>>          /// Returns the effective range of the mapping.
>>>>          fn range(&self) -> Range<usize>;
>>>>      }
>>>>
>>>> The `SGTable` becomes something like:
>>>>
>>>>      struct SGTable<P: SGTablePages, T: MapState>
>>>>      {
>>>>          table: Opaque<bindings::sg_table>,
>>>>          pages: P,
>>>>          _s: PhantomData<T>,
>>>>      }
>>>
>>> Hopefully I'm not missing anything here but - I'm not sure how I feel a=
bout
>>> this making assumptions about the memory layout of an sg_table beyond j=
ust
>>> being a struct sg_table. For instance, in the gem shmem helpers I had t=
his for
>>> exposing the SGTable that is setup for gem shmem objects:
>>>
>>> struct OwnedSGTable<T: drm::gem::shmem::DriverObject> {
>>>      sg_table: NonNull<SGTable>
>>>      _owner: ARef<Object<T>>
>>> }
>>>
>>> So, I'm not really sure we have any reasonable representation for P her=
e as we
>>> don't handle the memory allocation for the SGTable.
>>=20
>> Maybe I need more context to understand your problem, but the point of
>> this design is precisely that it doesn't make any assumption about the
>> memory layout - all `P` needs to do is provide the pages describing the
>> memory backing.
>>=20
>> Assuming that `_owner` here is the owner of the memory, couldn't you
>> flip your data layout and pass `_owner` (or rather a newtype wrapping
>> it) to `SGTable`, thus removing the need for a custom type?
>
> I think what Lyude has in mind here (Lyude, correct me if I'm wrong) is=20
> for cases where we need to have a rust SGTable instances for those=20
> struct sg_table that we didn't allocate ourselves for instance in the=20
> gem shmem bindings. So memory layout needs to match for
> #[repr(transparent)] to work

Thanks, I think I am starting to understand and this is a problem
indeed. I should probably take a look at the DRM code to get my answers,
but IIUC in `OwnedSGTable`, `sg_table` is already provided by the C side
and is backed by `_owner`?

