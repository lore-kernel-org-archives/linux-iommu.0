Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21602451C3
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754298302; cv=fail; b=oHAdSv558TLw48sFaHbb6VHCpgOM/c3geM6GeaVVax2jlAFU+9+EYPKnGxvZ56aG0DWKYwgfinFltDz+1MsS9LKdWA2IPYEgDxBzJsQ0m0CMoUW1tpIM5vEVg4L+tLRrg6w3duE12Ho4PgFEFtyOy2a6LNIIG7KvjJ6LidnSmE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754298302; c=relaxed/simple;
	bh=wgJx9kCNgj5ArvqOHoWvVMRRUV5qfQdpQgSNxZlGzFM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gjCSfp+kgBkAZtl+D13DRGo4tbtOsgWZrxEvSsTBdxJVqTi54gOuyFzMB+gMXeW2qu3arLzRHKD6lKHvc1tcC1BYLFSUTrUxxL7DVg75ChyQImCUbjpQE5ghTUGsIqwyV4WjrjRxXiEl/YhayGaaYTV//kmAEAkz4PnOwhJwcN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VKnTUnyP; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VKnTUnyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZlCvqalF0LYH1EJ3GLC01+C11nph2enghzJWtDOv14K9G4sbor20s5e4oKtakOHtpjVMccgVAR+Morve8LolTXTj3iFt/ZIfFqOV0t3qytHFO8iBw5fF7lX6OCuvhJrUUvRKHFYbFKVJ91x3jFVazfCD23v/Kn/2sVvDpLBi0UNND+lKkcF0uIj4M4v4yNLYeu4nXBnlW4Z2T4J78d0nfGGP1aJp9sUhPoP0HfIcFmogkcut1aKpQX/jRjBCSAH8AbGRlz8WEbq2GNrTjBg52MN1kre9r/fP4DuowjTf8pCR8U94gfiZOnt7FACR37za7b4wnP9FGN1Fb7GU8XK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFgnko+oe54tsKMt6hkl2rbf4ax0Pu0w3BnmsJNHkbc=;
 b=Cns7VwhOz1BjmzOeo1pxtZPlf7HDZnoRVhzqrPeo/XTMe4bDoGDRnIgloVWlI60uGV1m3jv5RcxyGE29fjPZbQ3VvltkDM+dRB9iZmJB8eXzd8VVePDsfQnE0gpj7c74nWg3t8IHFgQZiZEaJyEAyMjJ6TtLGlyPptwErwr2jVRPFF0b9nArF0+VpmT9n9KNp7+h/o3V0/ljqtPsOZsFVnR/IDHdp3zmupNRju2R8ijpeQstjgxQoV+SoJk27wjOh4KFdE4zazmrPiyuidBitjpkv2y76diIBJguTHbdiutNuCgN7cSnz7oFl0s8v7BNr0Gb/4AGuTIL/Ef+9vmfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFgnko+oe54tsKMt6hkl2rbf4ax0Pu0w3BnmsJNHkbc=;
 b=VKnTUnyPOODOosLYaiLhuHlVcarn7pLqDrTDODanvvp07tTyAPuLoG85i9npMEApNC2RNccsKtoT+vw3cxrsGyWXI+kW9EK9DNmSdAHgJN/ikCCYcIdmEsH3sQ9+9Wyq+/o8TY7ACIQ3aboTpsa0jb+DYrmlI5EKzTISZS0JayusPw5JkNvCEz7+XwcHuIFrjzfgceU4YvDw4t5KSSFgZGMjGKd8l6CW+95eBX5n6Z3y7I9v1j2KD0SIzqTOUwQgpvyylXOJBm/xt74jKCAorMVM5UdrxLjNCO3zZ+92G3K8TfPLt/WPywQAlOV2WNz2/05UG11nkuoTvYiAmxT1IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Mon, 4 Aug
 2025 09:04:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 09:04:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Aug 2025 18:04:53 +0900
Message-Id: <DBTIUE9O5HWS.2SMVEMRGNCN5A@nvidia.com>
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
 <m.szyprowski@samsung.com>, <airlied@redhat.com>, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Robin Murphy" <robin.murphy@arm.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <dakr@kernel.org>, <jgg@ziepe.ca>,
 <lyude@redhat.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <8bc8b565-6bc9-4fa5-8677-192ed969c9d0@arm.com>
In-Reply-To: <8bc8b565-6bc9-4fa5-8677-192ed969c9d0@arm.com>
X-ClientProxiedBy: TYCP286CA0184.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e336f4-2bd5-4885-25ea-08ddd335fbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkZrM3VoVzNLWGRqZ1Vhd3pxRUQrOHZRaFdwY1dyeDIvM2ZTcUxPc0llNTd3?=
 =?utf-8?B?OWNyemt4a0pYeTlSQ2lqY082OVRBeDJ0Sk5pb0EzZm1WVm9qSTJuek9NY3Zz?=
 =?utf-8?B?Ynp5SE9uREwrYVdVdDN5bkQzOEdUTUNwRVc5UDlZRDRKTlRBVFJRK21wNm1z?=
 =?utf-8?B?MXBqZkJiR2hLMmFQWlUvUU1xVVZxK1VKNEc0UlArbjF0cFJES1MzQ21xcnpX?=
 =?utf-8?B?cHZoSFBlcGZ3c01SMTRQaEU3RXpIYXM1ZkZMNHZjdzZVWXM3VzF6Y2NXTVhU?=
 =?utf-8?B?UHR0azRWVU1ubUpLVVA0MjJ6N0pCL213QVVrdFRKZXoyQ2tmNUR5aFFIb3R4?=
 =?utf-8?B?SFFBSlpJa0tFZ0h2UXRpMVEvSXNGSVFNRjZ2elNPMWVHQU0xUnhoQWdQMVla?=
 =?utf-8?B?cG40S3NHd205ckhKV1doR0VwUVJjcy9SWmtsTDByREs5dHBQYWY2K1pJcytu?=
 =?utf-8?B?cWhJakpjUHF6dHdoNWVwZmYrU3JiN2k1aVFIblprdGhhTGhSMVh3YVFHSEUy?=
 =?utf-8?B?ampvQmFIVmRDL3poWEpzZTJtaTZWSUpIZk00U2R0YkovcnBxWG14OEZNZkV1?=
 =?utf-8?B?cHFlbTI1WFJIZEhxNCtmZGVHRHdtZ3VWTEpEcjVJWlhKUXl4amROWkZ2c3V4?=
 =?utf-8?B?bHh6TGRldERSTjdDMTM0Tkc1ZUpENlpOUDVGQVdlZEF4SjlxeTRGaEdMa1Bx?=
 =?utf-8?B?K2txSGJmWHpxbU0rUUVCb2o1MCs3cldNN2pLTUVUcHdEM3paaEttTWZVR3N5?=
 =?utf-8?B?TndwNTQydFNHcU82a3h5VnF0R3dwbjAzRG0xNzFJT1U3aEt3SW5SeEtRdHRP?=
 =?utf-8?B?eWIxaGU2Q1hzdHBIaGpoSUNCOHBSR0s2Q3NsMzROWGEraWhwVFdWUWtwSWZH?=
 =?utf-8?B?WXdPaU5KelplcmtBMXA1K1BGaUcyaWdLQTlHSmRRU0YxNXM0VTBiT2lRT2x1?=
 =?utf-8?B?OFIxbERCQmdtaWRiVjczb3Z6SlVwNjVOYkVSYTV6MjI3a0k4MlRLS1l0SXFV?=
 =?utf-8?B?bXkvVzRHNDhpbVNqbm44QWxtQjYrQUliTEQxTURVaUV5T1o2VWNwTi9IYll3?=
 =?utf-8?B?Mm4yaFBlZ05NWGhTQmEyamErMDg5T1FKWU04YStrTVJNbWxTSnNEd3dFTWV3?=
 =?utf-8?B?bGFWejBGS2xQRkdOM2dYNXlQOFVtSkdtc0JyTGRaMTh2SEhRSTNHR0lER0cx?=
 =?utf-8?B?d3hjN1haTUtKNkJRU1g4UmVTNytjTFRzemhkY1o4QitiS2FLSDdURzV1MHVS?=
 =?utf-8?B?RkNNSE9lbmtTYVd6OTdHenlVdmsxZmJKeVFaVSt1YldVSE94di9sMGI0eURz?=
 =?utf-8?B?ZFAyTTRYSVB4ZkdHMlpPRjl4djhhUFRTRXFLZHZhS21PY2xJVzNmSlFRYlJO?=
 =?utf-8?B?WGg0Y0ZXNUNzajVZN3Y1dGJVUDJsTy8rMEcrQnNRV09wREZJR3duTEI1eEx2?=
 =?utf-8?B?K3BtRC9GZEFNUUgwbEdjdUhMREZTS2g0eTJxcWx0dXZJV25KYVJtRFNvcTcy?=
 =?utf-8?B?eVBJVHMyTzdZbVVvK1YwQ1pCN3dFdnZkMCtmUkZ4N20zeCtiZ1FFaEJWaWtY?=
 =?utf-8?B?dU1ENGVBSi8wOHRJQVp5UFViZ29SN1YwMEVhQnJ1eDY1eCtaTVZHMWMwZzlV?=
 =?utf-8?B?KzlTRklOM1NaRnlaNHdvbGd1MkNOTnF5bncwOFlLRjcyMXpzR2xId0ZLM1I1?=
 =?utf-8?B?cy9CTDREK0RtUmpBQWxVb1BOM2dscGp6WE5pWk9YY0Eza3VLM3BqUExqdDFa?=
 =?utf-8?B?NkovYnRnam1xZ3d0SkZOR08vb29kOU9YbllFLzAzQ0VqVXZIQVY4SWo3Y2Vk?=
 =?utf-8?B?bkpKNWUrYVdTTHhRaEIyRHE3TGxkZTFxd1pIdTY4VUg1NmFvTmtDNUJ1ckpF?=
 =?utf-8?B?V0RxaVlxLzR5Sms4dTltZzNLZ0pKdklpQm5XbzZYQWttcjV0UC9MbWhYdFZB?=
 =?utf-8?Q?5wRP1/EBWY4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVOT1pVdVRhMG5Zait6SVAxRHI5NEllT1F0MVk1WnJqUnBCdkdRMXFoMVpD?=
 =?utf-8?B?Wk5XZ0JIZzdaamRQL2lKdHJVc1R5ZGFURFJESm5wYzljL05la0xjNnFQQWZw?=
 =?utf-8?B?Ky8vNXJHQktaOG04ZzcyeTdnNWpaVzdNV3Rzdjg5M01YZlRZelVGbmsyUUFC?=
 =?utf-8?B?eU9FQ3duclF6dS9WNHIzNnVPdmZvNy8zRnlNT0t1Z2FRQkVzUzRxWTcweHRo?=
 =?utf-8?B?ODlEMjJSbC9oRFpkUEVYNllUYmJiU2NGVjRxRXBPV2I5V0srSDV1Lzdhc2Zw?=
 =?utf-8?B?RnZOY1hZQ3k4cWxnQ1VnQ3o1aEVBWndieS9MZDVqa0VCL21uYlY1TVRnNWEr?=
 =?utf-8?B?WkYxRVJrblgzeVFNcjI1dHdHOHhuaTF4ZkdMZTFpbU5VdWpoVXBDbEpUdzBU?=
 =?utf-8?B?aGZ3b3FSblA5SU4xb1NOVFNlamxWcHRMd09FcmNwenZ3ZElhMG5VVW13QzJ0?=
 =?utf-8?B?RTYzZjFERTgrYlYzVGlQYVhsalFXVjU1UmV0OU1MSTRNUTdxazNLeThTdER0?=
 =?utf-8?B?V3o1NHpZalo1U1FHcmRtbHZqYThrSW5FZTYyUzJ5UU9TYlVLbHRmZk5hMHlE?=
 =?utf-8?B?Y3FPNXdOSlR5V3RYMXNuWDFqRVlqQ1cyaVBhdUNSL1JpdjJFT1h4ZTFFeVpE?=
 =?utf-8?B?SklFUFJZUnFSc1NpSjB4K3QvZ05pRldhSGczMVhHRmJsS3JuYUR0UXVUaE03?=
 =?utf-8?B?TWN1bEc0a0VyelIrdW5hRTg4YTFGSmVWT3JMN1RRVG5HSlptWDlqd1NPUzRK?=
 =?utf-8?B?MERQSlllaUt3Wm81SFkwQTNJOHhzYmNiUEZKNkFZcURzRTlZOE1zMUIzajFk?=
 =?utf-8?B?dVd0UzZTRXVVc2lwb2NqS2d0dzJiWVByZThIWGpyU3JiMTZzMGI4dE9ONW9i?=
 =?utf-8?B?WStsRklDRDNTOE1EbVRvMkwrT3Myb3g4cFNaUHVONFpWS0hkOFFlTUt6UUxP?=
 =?utf-8?B?d0FCRTI5cjEwTmNiK2JzRWZpcUpyMnpLcE1mUnp2RkVVa1RlWUJzQmdIcjEv?=
 =?utf-8?B?c1VBWnROblBHdW4wbjBjT0JZS2NIcW5Cd2x4a002clNmMnc0T1lZSXdINlh0?=
 =?utf-8?B?M3ZIaDAxNFBSQXJBM0p6MXFVUm51REg3WHFXb0pnek5MZExyR2toUk5kTVJi?=
 =?utf-8?B?R21RZDRKYmlEeHVqcFJ5ejUrc084aGhndHBrRWVGK2FPc1B2QmVSOHYyMEth?=
 =?utf-8?B?T2pzOWo1SitqUWtmVjVOOW5GUTRSS2VYVHRpN2ppM1RuNnZtSzBKYmNqQzdo?=
 =?utf-8?B?LzhsZ0l3enpkbW5nZmlOa0MvSHZMbTRXdnJVMGxuN0FRL3UzVTZzOEtZMXFu?=
 =?utf-8?B?dkdKRlp5WFR1dlQ5UVV6T3NhNmR3T0pvb1VkNWF3NElKUDNIUjU4elV4RVhh?=
 =?utf-8?B?WHZ3QkljS1V0VkJrQ2hqTXBnam5MZlZFcHZnaEVQQjBDY2ZKU1hyaTlXN21Y?=
 =?utf-8?B?allnZ1ZsTjNFemhHb256TndTYXhSczMvOG93cC9EenlmY0tGQ20xckdXRWk3?=
 =?utf-8?B?MUN6QUdZSm1oUE5pVHI0dlhlanF5ZEdheFg4VnowK2RPNGRlR0UzMXhnODJR?=
 =?utf-8?B?dGIxZjQvNU05ZDVmeC9BN0xOWStqR2pla2Vua3ZyaXJrVlY3SjRjaVJsM2hK?=
 =?utf-8?B?SytSM2tkeWtVcGhjVUlWNU9qTmo5dGxqRURiRHZVK3FjaUpyK0RDN25xaU5n?=
 =?utf-8?B?YU1mTGJoWmJIa2lCQ3lPVndOUnZpQXQ2dEVHaER4MU51cStlVWZidVIxL3Z1?=
 =?utf-8?B?NkYvWXBXMjlQbURSUGlpQlZxOWEyWng5MzFLOFFqRVBVQ3A5dksrMTcxUU9H?=
 =?utf-8?B?aDFxWko5TVJrNGl5R1ZpbnpJZ0JybHluQ0t6WnlhQU0yTjZlOGI1RmU1a1Ir?=
 =?utf-8?B?RG1DY2lveWJveGRrMGFRbG94c3RsYnloMUhmdW0vS2hSSmpQVWNKNlg1S1lB?=
 =?utf-8?B?KzF5RVJlYkVlQ1hSallycVU2NFdJMjY5b3gxWVoyUXdHSElxcGcrYmtsVnlq?=
 =?utf-8?B?cG9TTjczbHA5OTk5b3lZY2p4T0dmZFlIdWZyc2hmNWE5czg3NitrYkxSM3ow?=
 =?utf-8?B?WHRsOXpyYzllbU1scW92eW83emJDNXRQWnhJU3l0RDBTY3QzWGUyOFZReDQr?=
 =?utf-8?B?RElpRlZwOVNSZEs0cDZGSUV5Wi9LcE1QWGRqTTIxRmQzUHdCSmZrQ3lHbEMw?=
 =?utf-8?Q?K1PkLK7K+xNsKKN0ltVLeidu/8i0H8EK9l+sBr1Idpi3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e336f4-2bd5-4885-25ea-08ddd335fbc9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 09:04:56.9366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KPMZ31eLIwZTgy2l4NK7IlXo7xOG6X28xy0Cdrhk093dKxaI1TOCbciSTD9VI3eaFw4zUTJPUNd3swbVTBYsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047

On Sat Aug 2, 2025 at 3:26 AM JST, Robin Murphy wrote:
> On 2025-07-18 11:33 am, Abdiel Janulgue wrote:
> [...]
>> +impl<T, M> SGTable<T, M>
>> +where
>> +    T: Borrow<bindings::sg_table>,
>> +    M: MappedState,
>> +{
>> +    /// Returns an immutable iterator over the scatter-gather table.
>> +    pub fn iter(&self) -> SGTableIter<'_> {
>> +        SGTableIter {
>> +            // SAFETY: dereferenced pointer is valid due to the type in=
variants on `SGTable`.
>> +            pos: Some(unsafe { SGEntry::as_ref(self.table.borrow().sgl)=
 }),
>> +        }
>> +    }
>> +}
>> +
>> +/// Provides a list of pages that can be used to build a `SGTable`.
>> +pub trait SGTablePages {
>> +    /// Returns an iterator to the pages providing the backing memory o=
f `self`.
>
> This seems a bit unclear. In the C API we have 4 distinct iterators:
>
> for_each_sgtable_sg
> for_each_sgtable_dma_sg
> for_each_sgtable_page
> for_each_sgtable_dma_page
>
> The first one is for iterating the segments in CPU space, i.e. simply=20
> each SGEntry, "orig_nents" times from the start or until sg_next() is=20
> NULL. This is typically what you want for copying data in and out.
>
> The second is for iterating the DMA segments once mapped, which is then=20
> "nents" times from the start or whichever of sg_next() being NULL or=20
> sg_dma_len() being 0 happens first (since "nents" <=3D "orig_nents"). Thi=
s=20
> is typically what you want for building your actual device=20
> descriptors/commands from the (dma_address,dma_length) tuples.
>
> The last two are for slightly more specialised users who want to walk=20
> the whole list effectvely linearly in literal PAGE_SIZE steps, in either=
=20
> CPU space or (mapped) DMA space respectively.
>
> The comments here rather sound like they're trying to describe #3, but=20
> (based on looking at the C calls and taking a vague guess at what all=20
> the Rust around them means) the implementation below sure *seems* a lot=20
> more like it's actually #1... For a useful abstraction I'd think you'd=20
> want at least #1 and #2, however I know the main motivation here is GPU=20
> drivers, and they are the primary users of #3 and #4, so I suspect=20
> you'll probably want to support both per-SGEntry and per-Page iteration,=
=20
> in both CPU and DMA flavours, sooner rather than later.

This trait is actually to provide a list of pages in order to build a
new SG table, so IIUC #3 is the correct behavior here (for as much as
the comparison holds, since there is no SG table yet when it is called).

As for actual iterators on existing SG tables, it looks like we are
heading towards device-mapping them directly at construction time for
simplicity, since we have found no use yet for non-mapped SG tables.
This should simplify things quite a bit, and in this case the iterator
would implement #2 (and we might add a different one for #1 if the need
arises).

>
>> +    ///
>> +    /// Implementers should return an iterator which provides informati=
on regarding each page entry to
>> +    /// build the `SGTable`. The first element in the tuple is a refere=
nce to the Page, the second element
>> +    /// as the offset into the page, and the third as the length of dat=
a. The fields correspond to the
>> +    /// first three fields of the C `struct scatterlist`.
>> +    fn iter<'a>(&'a self) -> impl Iterator<Item =3D (&'a Page, usize, u=
size)>;
>> +
>> +    /// Returns the number of pages in the list.
>> +    fn entries(&self) -> usize;
>> +}
>> +
>> +/// An iterator through `SGTable` entries.
>> +pub struct SGTableIter<'a> {
>> +    pos: Option<&'a SGEntry>,
>> +}
>> +
>> +impl<'a> Iterator for SGTableIter<'a> {
>> +    type Item =3D &'a SGEntry;
>> +
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        let entry =3D self.pos;
>> +        // SAFETY: `sg` is an immutable reference and is equivalent to =
`scatterlist` via its type
>> +        // invariants, so its safe to use with sg_next.
>> +        let next =3D unsafe { bindings::sg_next(self.pos?.as_raw()) };
>> +
>> +        // SAFETY: `sg_next` returns either a valid pointer to a `scatt=
erlist`, or null if we
>> +        // are at the end of the scatterlist.
>> +        self.pos =3D (!next.is_null()).then(|| unsafe { SGEntry::as_ref=
(next) });
>> +        entry
>> +    }
>> +}
>> +
>> +impl<'a, T, M> IntoIterator for &'a SGTable<T, M>
>> +where
>> +    T: Borrow<bindings::sg_table>,
>> +    M: MappedState,
>> +{
>> +    type Item =3D &'a SGEntry;
>> +    type IntoIter =3D SGTableIter<'a>;
>> +
>> +    fn into_iter(self) -> Self::IntoIter {
>> +        self.iter()
>> +    }
>> +}
>> +
>> +impl<T> SGTable<T, Unmapped>
>> +where
>> +    T: BorrowMut<bindings::sg_table>,
>> +{
>> +    /// Map this scatter-gather table describing a buffer for DMA by th=
e `Device`.
>> +    ///
>> +    /// To prevent the table from being mapped more than once, this cal=
l consumes `self` and transfers
>> +    /// ownership of resources to the new `SGTable<_, ManagedMapping>` =
object.
>> +    pub fn dma_map(
>> +        mut self,
>> +        dev: &Device<Bound>,
>> +        dir: DmaDataDirection,
>> +    ) -> Result<SGTable<T, ManagedMapping>> {
>> +        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures =
that the pointers are valid.
>> +        let ret =3D unsafe {
>> +            bindings::dma_map_sgtable(
>> +                dev.as_raw(),
>> +                self.table.borrow_mut(),
>> +                dir as i32,
>> +                bindings::DMA_ATTR_NO_WARN as usize,
>
> This should probably be up to the user rather than baked into the=20
> abstraction. For streaming mappings (as opposed to coherent=20
> allocations), NO_WARN only has any effect at all for PowerPC and SWIOTLB=
=20
> anyway. And for the latter, the warning is commonly hit by unexpectedly=20
> trying to bounce an inappropriately large buffer due to not setting a=20
> DMA mask correctly, so more often than not it is helpful.
>
> Users trying cleverer things like i915, where they anticipate failure=20
> and can deal with it non-fatally, should of course still have the option=
=20
> to request NO_WARN if they want, but I'd expect them to be in the minorit=
y.

Indeed, we can probably take that as a parameter.
