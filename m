Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FFE1F3B87
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749102677; cv=fail; b=ODnOprwXsxmoOjZ8MD73zJeugNQNUr3nvRpNQLv1VYv7ODtulE1e13Xt4cYDl09fNtylbkAsNnk8zTw/pBA6mAgJw6S0kGBmbrZT0SrF+zsXIvJVMlvWlUeD2nFI9ACLLPu15BNnJlMDYca8vOfRzfvgYfKlmptpV1oxwAdT/ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749102677; c=relaxed/simple;
	bh=EXp1zOW/hb2UiHD73hB8WLmA4AG5q0Ijq+ZHGgJM2Ww=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=f44X3zk68dMwyQ3v3TDWr0hKqx/UApxPN94D0n5zdIvfVlnk3mnXFYu/c5ANKtJpX8vZUw6HvTy4AL5tLmJfgjrmfNpqT4MMwtDv/4T78CWEh8tHTl//O8RgXB0pE5i+es42y5NpnfzXzicawcSh3UaYJeBX4q8Rxzn35Ag54CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UDNPkpIe; arc=fail smtp.client-ip=40.107.212.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UDNPkpIe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzmU9RdnFHy9kYFfzCT5Q4llzcPc977SPxcCJEKQk3Duzm9ilhQy1FvUTo1pWP5OKdc3zCrzaRkY1TWraQIEfkfz4BLpl+GGM7cWJIhdXxPL92C4/7Cnmq7GVhYFe1CPIZ2Lmqbh8Wz8V9YF40IKkfppoet3GJykA24YSvN770DOMOe8d1yrhT8xCPcCNcqZEftN3Qsua8obPNC7hsGiNUh9DQWrtsgyr9iNxbQRfF03HdUfrhDbAeLmd4OQtmsgnXt4J6+TGq7PkRp2/oEPQXfPJyVIHGG+JI2dH0xHv3phE0JEjvNm5gcOCLakIT9wXP5h7UOX6jr1Pagq0SzGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrlR1rwPM4ug+EFWTRveV06HWA3jb2Jonv5rydn9gQw=;
 b=JyMpXF++WHhBWIks8Q4Twcc9fFLbCXbGnf4YlSJQ8VvwiW6JEOr7Mnw18Bb1+BnLVMVqZ+K0NEs8wHVeLFRjgiTLznQQ7yAIGeYv1u1oIwWnG7vtQhGAXczarR4XU000ZUPGx0m53C80GBdHWsaFwSXNti2ouukx/eaiZHHBuWpxZpi2/nQdsCvHkkjWivLRx/3MzUsAJnp2S1HMislmjlNAoFMSUXFVROmhgFzTHDUB/EaRtmHhU+qHrRBY9v5C9daJSu8zQuv3VPNOhawN+KHMNRgzLXZ3vZyzBJRAziTnAMIZS8i6GRlLqnK7392ftlxkYRROfiFd/APbTRkghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrlR1rwPM4ug+EFWTRveV06HWA3jb2Jonv5rydn9gQw=;
 b=UDNPkpIevKxnb6Rle6jMWmWfZjlJ++jWAwf1Zr5lXnznrxmyst6omA/RrdEhAbCKF4qKSKKCYSEo7Wf1OdunlhRs/KY7mY+pInw9SXbeALo7v+PF11zq1pQcgPeHHesyLbgf9WdYzAa849ajeviuSqFF2R4yQzEVV8bSCJgyg6N5FSHlwl9wtYQS0HQmjyhXiU5bS4Ug+Jttg5wL8hnjAxH7KhrHnTJqf/xHhNaFBLMGl6vbf1hwpqFgXuxSwNky/wllzGi9IvOri0PV4p5O47PmP6ohWdsJOTHBC9Bo1Wyphze4aP0o77pTU9xcgaJnU+KdAySxdWAYVpS20nrrWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 05:51:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 05:51:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Jun 2025 14:51:05 +0900
Message-Id: <DAED5BUK7TUQ.4JRHFMWZ99W3@nvidia.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Lyude Paul" <lyude@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca> <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
In-Reply-To: <95ff963ddabf7c3cd2cfd07d0231a0073ff6847e.camel@redhat.com>
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: cf21436b-73ee-4502-49de-08dda3f4f836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2RQUzZWYjNYLzlzTS9qc2RvSE9yS1Z6cG1DS2hGSlFSUmVHNFE1bUJSSnRI?=
 =?utf-8?B?Q0JvYkRzVXRvY2JLTE5rL0RGYnA2a0gyMjhadTE0TmJsb2x0bVFGMmk0M2pQ?=
 =?utf-8?B?ang4MVR1QXpGQkJ5Rzl2T1EwUWc4Rnk3c0Z5R29xWDRHeTcwWmY2dy9BQnFI?=
 =?utf-8?B?cFdyVlNxVUJvSXlKbW8ySVp6eXBVSlZUNjNMckk0M0lTVm5rdG9HNlU2ZHNn?=
 =?utf-8?B?WWtwdTEvaWNZNkR0MHhXTHV5SkoyOHZlL0xtOVpPL3BaM1p5UjlUbUdoRGg0?=
 =?utf-8?B?azlnTkRoaFVVZWdsNVpHbFQ3N1N1M1IvbWV4RmpBcFQvVERMMDlRaEJsMElj?=
 =?utf-8?B?dXpycFhhbkRpMFJoK1phV2NoWDRMY1prMUk3Z21UcytzQ2s0WW9rYUVGM2l3?=
 =?utf-8?B?RWI1a2hYeE1mT3lCQTljWklhb3k4dGtsNzc5TmhXT0VqZElVNG9NaTB5TmhV?=
 =?utf-8?B?OWtFYjQ2VTVlazg2T1dXTFhCK2V5V2ZuN0lFb3JRdTR3aU5LWEJQL2I4eUlO?=
 =?utf-8?B?WDhYSWNENXh6MFhGK2lqdUkvMnVTVW5kejFYdGF2ZmxxeGp3VnJoSnV2Slh1?=
 =?utf-8?B?M2VMSm40YmdoOXlodjNJRkZnZytIRTNjeU1EWlZZK0lBZm9wNU94NzNEYldS?=
 =?utf-8?B?TlNCTm5scW9xaVhpNkZoR3JjaUNFWU1pNnUwR2RzdVI4UldzaVZWTy9yckdT?=
 =?utf-8?B?bE1FSDh1NzhudVhYTktrZGZ1d1NtK2QxazduYlNDV05wT2locUVnUFNLSHdC?=
 =?utf-8?B?dW5yLzNrN2krM2tZNkk0T0pZWVhTb0QvdEN4OGx4eWZIRUVvSlIwcE0vWUUw?=
 =?utf-8?B?WmNPRVRNOVN4SjU3ZXBRMVNSUVhUSUtYakRnY1dXbTZ3RGMwVDdCbWdwcWYy?=
 =?utf-8?B?LytUQzl3VTNiTExDTXBvZDZxbTlhV2xReDY2bnk3Y2lLaks2ZjlFNDR3bkh2?=
 =?utf-8?B?T055U1A0am5DWHYzb0E0RW1oZlY4L1BSQ0hOT3FDbVZCVDlUeFdZNWJ3cTFa?=
 =?utf-8?B?TGQraDd5N2tVcEMxalRYcnZZWkhsK2dLeXFreVBveGtQUmZTbVlXWDNnR090?=
 =?utf-8?B?RzkvRG8vQkY1aGUrNEx0NGwxOEV0S1hZaTNPQ01ybUV1bis2SHBXMUVnWnFL?=
 =?utf-8?B?WUozVU0xUnA1MENaYWhyek1Bd0dGbjRXUHY4dkRrYkxiKytSc3UzaUg0czIw?=
 =?utf-8?B?YmNSR3VJVTl0RmcyQzVlUUU0UXpvVmVaS1NKdVVsa0ZFVUxOZjdNZWxXZWxC?=
 =?utf-8?B?d1M2SnFJTkk2WkttVGZZRjh1V0tySUJuS0lFekFybVFPQ1B6VE1Ocko4QktE?=
 =?utf-8?B?QStidng1dHZLYzAycWFMQ2JsQ1ZCT1NIUjkvYmdFb1NWUTcwcjBXTUYybWww?=
 =?utf-8?B?Z1BBMWtuMEJnaE0xUkwxTEhzVUZXTGFWUzBEY1E2SjNHTHl4eTRsMUdvajR6?=
 =?utf-8?B?UjlMMnJRRUFYVGY0Mnp6bHpOcXhhOXZFU2tUQlVKUXZiSmcwb0Z2a3hYME1k?=
 =?utf-8?B?WXVuY1J2Qzc5N2ovN2EyZ08vZmpOQVhoSjIrREMrRkhtdXhEK0Z5VUJvYjQ2?=
 =?utf-8?B?ajhaUWRhVTRqUHZTSjd6OHZpZkgxRE1SRzg2Sml1Y0dXQzBPaGc3MHNmYWNN?=
 =?utf-8?B?c0lITjR5Tm11TW11L0xOYWtyRnJVSXdkak0yaXZTd3FDcXdNVGJRRTFTek11?=
 =?utf-8?B?TXRCWGcwb3h2Y2laUVBHT0U2b2VxYkh0cmJTUjYzb0MzYjlHUm8xdFNtTzUw?=
 =?utf-8?B?UFBKSmt5T0I5am45Q0x4V3FzdzlLQ3V2Tm5OYWVqQVJ5M3JVL09SNEpxcEh0?=
 =?utf-8?B?Smxud1YxVHorS0ltNStSRFB2VTA0TmZ1d1I4S013WDh0dlZoZjVqVXN4SEln?=
 =?utf-8?B?ck9rcUpJREx5S3IyN0dCVnd3U2NRMkVFM1VwOVdkWkFpRFBqQ1BQOWFhMk5W?=
 =?utf-8?Q?LqjX7u/SRvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0phejhXQ0Y2NDRrd3U4Y1BzcWNOZXZmdUN1R0krM1A0d0hScWt3SmhnVUFi?=
 =?utf-8?B?eHZmOUdGMU5xSk5KRThaZ1R2YzlQY0RIZHFySU02V2pveFFmVnhTN2ROZHpp?=
 =?utf-8?B?NnlLTnR1OEtWSHNrY2h6MWdhanMwTGhvRXJ2NEYxYTBHMVRSeFd2RC9KaEp1?=
 =?utf-8?B?TnJweG1Eb1VZNVBCWUoyM0NDTVFYQ3hJUDZ4SUJBd3JpZ29iK3ZRSlZxZ2wz?=
 =?utf-8?B?QmxkakdqUkl6dzNjbElHaVY5YU0zcWtFWmxoQkx0bXVsTWRWWVpzYmNyQWlW?=
 =?utf-8?B?TXg0NEFHWVVua09DWUVIdXBtKzJnOS8zS0RCT2JFN1ptNm5qRTdhVmlvaDM2?=
 =?utf-8?B?czZUbnBnV2g0QkpkU2xOT0NCYUExWU0rMHZ6LzN4cVNqTDhrNVlSUm5hcWNu?=
 =?utf-8?B?YzY2VUVGZzlDazQ0UEUxU3FZaXhSZDRHVVZqWjBDeHU3WHRMaW5nR1BzMjZZ?=
 =?utf-8?B?SUx4RDNNaDNJbVlXL1dDZUpuTEJFRkhCQ2w1ait0V3Bzd0hyVkk4d3NLdFp0?=
 =?utf-8?B?MzhCc0pndmRzbHV3VTcxNmpJUnYxSlVILzZxMkVKNUN0Z1Y4cURwM3VLYTR6?=
 =?utf-8?B?NWdzV3AvNWV3d1RqTUVjWUpNc0JoOVhpWHU3NWlaUGpyVDB1TVhwOWg1QkFK?=
 =?utf-8?B?Wjc4b3piMmoyaTVjMFkwQ2NWYitNelRZRjRHNDUxMFFZYkYvM2JzVzI5dzZ1?=
 =?utf-8?B?VG9sMzZTd25peTk2NlpnYTNmRjdWb2dMTSsrVkhJNTRXZ0F6T2RLbmZBZ0Vr?=
 =?utf-8?B?Q1JDR0xOZFNSMTJTTzRHWEJuTS9FRVV3TGVSNzBSZWJJbmxWWjZkMzFwcXR0?=
 =?utf-8?B?N21vUkNzMW5hMm5HSWtjUTB4RmMxelJvRFNDSlozZTFDazV1enc3MHk3NGdW?=
 =?utf-8?B?cVBDNUZweEFkNDBhak9Rc1lkVGtXc0p2WWQxNmpEQ2N1ZHRUem9qOVJXdTVq?=
 =?utf-8?B?L0pRRlptQWhtUWZPT3k1V280WjZIcldLMUlESTR6UTI2bmozUitoSzR1V1RK?=
 =?utf-8?B?V1dsd2c4enBlOGpYSEFnZWR6NDQwM1FFZDNnVXpVZXNDZ2tkUlV4Sy81d1dR?=
 =?utf-8?B?cXk0U2E2azJMVWdhSmc3dFNDQ2pKRUhiTkdrUmZVTk5xcnFSckxLbGhTbERI?=
 =?utf-8?B?d1ZpWHFsR1FwU0RodStLb0hXY004cFhQMTZXb3RuQ0FOQm45MFVnamNZdHRq?=
 =?utf-8?B?T0NjY2VEemRXTDJ1Z3BHMlhJM3lmTXEzTndTRFB0VmxmNklKZ3VVektQaTdq?=
 =?utf-8?B?SXFXWGZUVlR0eEdaNXU1Nk0yNVFMMFprQ1R4MEFqYWxVTmJKQkJFbzE5Q1pF?=
 =?utf-8?B?bS85c2pFVDJNVmJGVDUyekhyUFZ6YmExQ0NMaytxeUJ0ajJiZzAwaGZyME9m?=
 =?utf-8?B?dHdFZ2VzQ3NMQ1dxYjE2a3hvaUIrNEs5ZFVhWGhGQjFGYjhQRWFUMkxJN09F?=
 =?utf-8?B?WXNFeWxEUlUxZzlMWkc4UWtuMG9JZXdoL3VaNjZzQ09wZ0ZNazZidVc2Si94?=
 =?utf-8?B?eGlTbEs3b3ZtcHRSNWkyMERlUHFEVVJzWkF2WlVMSStveTJrSzZ0WVFrZ0Ni?=
 =?utf-8?B?ZE1FMWxwb3JOY1VENGlpRlRwMzNjRmJnT2tjb3dBUUVsV2ZUN0dxRThCOFhj?=
 =?utf-8?B?ZHRVUHFQbkRmZnhGQlNoeWdXUitKcm9OOU52RWVvY08zNU5tZWhYMDk3RnNM?=
 =?utf-8?B?VUNNdThXb2JoM2crOFRRNEdnUWNFb0tKaWxIMTIwNUFFUEtnKzkvMWxEc3pP?=
 =?utf-8?B?YzZRZnhlb05PWkYrSDdLV3ppMENReHlJcEIzYjl6QnU4OENheXZMbGhVeC9G?=
 =?utf-8?B?STZvRnJONG9tdHBOMGJkY1hTeUlLM0lzbTJSNXBTSFU3TS82b3RWeDZJR2d3?=
 =?utf-8?B?c2podHZKVzVrbzdwY1UvVG5vVlR4QnhZU0RrUlo1RGloNlFDZGxzRXhPOXVP?=
 =?utf-8?B?QTMxbWdnNlNvckNqeHdUOVdNS0RaY3hNNHFCZENsb3hLcXI3ZlRML1VCODBF?=
 =?utf-8?B?N2ZWbk9TdVhKemo3MmJ0cG5tNWxRSnZXK2JZWTBMTGJ4aHhxSzE1UHFacHFo?=
 =?utf-8?B?VmRkMXlsMjQ4aFE1bEVJZ0ZPTWs4MDBlNmdleFV0MXdCTnpZRkhSWEdKQy9M?=
 =?utf-8?B?WThFR0RSaXlrRVFpaE4ySW5YVjM0S2oycllGdGN3ZGVFVFpvVzJJOFIzT1VL?=
 =?utf-8?Q?ueD9K7tIYPaJeYBUb41KvuC9wM6HG9t7IvrYRmbysFqS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf21436b-73ee-4502-49de-08dda3f4f836
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 05:51:09.0577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrOsCYEL/MwFVdS6348zR3yM/GbgyjusUT0aAi0McjExKkZa3ABAEzsUxhxW1WJBUMhZHl9Z9tn6owk3tqQzFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

On Thu Jun 5, 2025 at 3:21 AM JST, Lyude Paul wrote:
> On Fri, 2025-05-30 at 23:02 +0900, Alexandre Courbot wrote:
>> On Thu May 29, 2025 at 9:45 AM JST, Jason Gunthorpe wrote:
>> > On Thu, May 29, 2025 at 01:14:05AM +0300, Abdiel Janulgue wrote:
>> > > +impl SGEntry<Unmapped> {
>> > > +    /// Set this entry to point at a given page.
>> > > +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u3=
2) {
>> > > +        let c: *mut bindings::scatterlist =3D self.0.get();
>> > > +        // SAFETY: according to the `SGEntry` invariant, the scatte=
rlist pointer is valid.
>> > > +        // `Page` invariant also ensures the pointer is valid.
>> > > +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, of=
fset) };
>> > > +    }
>> > > +}
>> >=20
>> > Wrong safety statement. sg_set_page captures the page.as_ptr() inside
>> > the C datastructure so the caller must ensure it holds a reference on
>> > the page while it is contained within the scatterlist.
>> >=20
>> > Which this API doesn't force to happen.
>> >=20
>> > Most likely for this to work for rust you have to take a page
>> > reference here and ensure the page reference is put back during sg
>> > destruction. A typical normal pattern would 'move' the reference from
>> > the caller into the scatterlist.
>>=20
>> As Jason mentioned, we need to make sure that the backing pages don't ge=
t
>> dropped while the `SGTable` is alive. The example provided unfortunately=
 fails
>> to do that:
>>=20
>>     let sgt =3D SGTable::alloc_table(4, GFP_KERNEL)?;
>>     let sgt =3D sgt.init(|iter| {
>>         for sg in iter {
>>             sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32=
, 0);
>>         }
>>         Ok(())
>>     })?;
>>=20
>> Here the allocated `Page`s are dropped immediately after their address i=
s
>> written by `set_page`, giving the device access to memory that may now b=
e used
>> for completely different purposes. As long as the `SGTable` exists, the =
memory
>> it points to must not be released or reallocated in any way.
>>=20
>> To that effect, we could simply store the `Page`s into the `SGTable`, bu=
t that
>> would cover only one of the many ways they can be constructed. For insta=
nce we
>> may want to share a `VVec` with a device and this just won't allow doing=
 it.
>>=20
>> So we need a way to keep the provider of the pages alive into the `SGTab=
le`,
>> while also having a convenient way to get its list of pages. Here is rou=
gh idea
>> for doing this, it is very crude and probably not bulletproof but hopefu=
lly it
>> can constitute a start.
>>=20
>> You would have a trait for providing the pages and their range:
>>=20
>>     /// Provides a list of pages that can be used to build a `SGTable`.
>>     trait SGTablePages {
>>         /// Returns an iterator to the pages providing the backing memor=
y of `self`.
>>         fn pages_iter<'a>(&'a self) -> impl Iterator<Item =3D &'a bindin=
gs::page>;
>>         /// Returns the effective range of the mapping.
>>         fn range(&self) -> Range<usize>;
>>     }
>>=20
>> The `SGTable` becomes something like:
>>=20
>>     struct SGTable<P: SGTablePages, T: MapState>
>>     {
>>         table: Opaque<bindings::sg_table>,
>>         pages: P,
>>         _s: PhantomData<T>,
>>     }
>
> Hopefully I'm not missing anything here but - I'm not sure how I feel abo=
ut
> this making assumptions about the memory layout of an sg_table beyond jus=
t
> being a struct sg_table. For instance, in the gem shmem helpers I had thi=
s for
> exposing the SGTable that is setup for gem shmem objects:
>
> struct OwnedSGTable<T: drm::gem::shmem::DriverObject> {
>     sg_table: NonNull<SGTable>
>     _owner: ARef<Object<T>>
> }
>
> So, I'm not really sure we have any reasonable representation for P here =
as we
> don't handle the memory allocation for the SGTable.

Maybe I need more context to understand your problem, but the point of
this design is precisely that it doesn't make any assumption about the
memory layout - all `P` needs to do is provide the pages describing the
memory backing.

Assuming that `_owner` here is the owner of the memory, couldn't you
flip your data layout and pass `_owner` (or rather a newtype wrapping
it) to `SGTable`, thus removing the need for a custom type?
