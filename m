Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAC2798EC
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258041; cv=fail; b=pBrR7FTkKGQGxAyVqOXGVFrWmEBYfmhxwrBlWY5P/2A3XL2ZwVVXcvurA5eQ5cGA4vx6ygtj/UCAtArinnqewtrMoxhDxEOXuJuZkNVFGrw1IK+TJUdGCbR2UG//bTqFfveAAF602CMjXXdsr5WMveOKA6DA9Wzdm6XAW+zjhxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258041; c=relaxed/simple;
	bh=bqI2WL/jBfPXkTNs+aGO308UTK5Zkmuu+0NRe8vT4qM=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=Aw4x14jjxhaVTyT3QKfvM5Pt85ipkdpJr12Pvn4DENLgvxp27DmZzA5B6Z6fR/lbEL/BdQ/JMtQF9g0fi1S1dWaLRW234pTdx1AcTxcGSoEI3w6hUA+xK6sSQuur3XxbzK4/mXd/qIYfT0fLXp5RJpx/I6XbOHMoM25Tjv86pcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GfqiRF/3; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GfqiRF/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql8LuxeDPUHt2f/Wdy/rfCJKkhBxkX4u/pOnFIA4bwkyq4cJGSaS8nOcRU4A+fNU25JYT8c3bLja6vl0CwRux9YRvYuPo7ycnqhondHCKhbDZ4IYhnFKk1bwTPssItLybanu1vV2H41vXzQ8J/P7ViMLX5uO8lz4+ac49ENYFavR8wefHi+GcPQSNP8mn2ngWGLu/ncQk96Bpa8pY686unrtwXSVEBbfd9Z4MHGI04C1MTrlSbyopV09h+hFsWQyKe7WGRurJDKcSn6xcwL7sZnRGhXNTlMeqNmaa9lOTwqhsMJJSKkxniUo/MRFQRsSiKfGHXqQ7xIvQOPio+Xn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKDVCSZERCkoQOI+TBmW8AcWjKQ1ezg58mW+vzdB5N0=;
 b=NeDqbWNpINS8q9X3BBCv1N/V1T7xc28ni26Er1DiGfKhK35sHsF84WJtn3+dqOjV8PSlflFcXhx8D9hM6gk2NF7zIx5CJM/KL/5rN68wrfgNCHZxPF3A+q5acUVZRo8pSyfs9ybSimcfiMOiGMkiWGD0euIc7HRwaLsFbciuSS1d58ieIL9bExRp3FKGIxmf2Viug7fjfyqSipTd/H3l7uyLKueiJg8pNc6Z+04OuC3KkW6rGlhmBvAzofxKxsM9Aksa7Xnkd+8nPFPeSlQ95YM/3P17E3t/WzjKcxv8FGc3BbIW2aplWjl2U7ayxdPClf+DVpdzfjeVQ+PqaL4cBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKDVCSZERCkoQOI+TBmW8AcWjKQ1ezg58mW+vzdB5N0=;
 b=GfqiRF/35IZqDxN7ySA4qlMH+C9OEKlZ/vWqS/jeV0fVXXA+HeHL8dxrAtnZe9DvdpWk1rA489KgVkKZZYStEAW943nPS1U8jgNWaC4TGAv+ACRrvJfamKBsc2AfkKjTy6cznDyIez6AofooPC+SN1ondUmkkytYmYNMq1l7rXE6dqax4utyBTagT6INxOZB6vOHwL7RDdNx+yDC3/Gn5Of5BC9g0Lc5RheoP8IrFv/SS2A7LkVit93bvxCl/lRvE/nyarrGGmCNKwDOG0DqhGDKHF2B6ra90Fhe1eRYAB9NRsQvhZK/civ2r/j/E83+1/r4esfv4I1hWQMIitJA7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 23 Jul
 2025 08:07:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 08:07:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 17:07:08 +0900
Message-Id: <DBJA3N5Y07XL.D3SGP2VFJZ01@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>
Cc: <dakr@kernel.org>, <jgg@ziepe.ca>, <lyude@redhat.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@gmail.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "open list" <linux-kernel@vger.kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Herbert Xu" <herbert@gondor.apana.org.au>, "Caleb
 Sander Mateos" <csander@purestorage.com>, "Petr Tesarik"
 <petr@tesarici.cz>, "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] samples: rust: add sample code for scatterlist
 abstraction
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-3-abdiel.janulgue@gmail.com>
 <F13AD3DF-6045-45FB-B3A8-9F4BA99BC485@collabora.com>
In-Reply-To: <F13AD3DF-6045-45FB-B3A8-9F4BA99BC485@collabora.com>
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 097af083-0d06-4545-ae13-08ddc9bfeddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEkwUTVqNHYzSTdJS3B0WDlGMmVUZGZqMzFWMXE0TERjRUFJaytyUjJ0MEtJ?=
 =?utf-8?B?VmpKRENNZXRtK3UzazBEUUwwVlE1NFhOTjMvR3JQMURNQjEwdm9wY1g0UDUx?=
 =?utf-8?B?c3dxMkltaFAvWjg0QkRGZWxScjFqM1FaTHJaYkxmQnIzek9Ua3NiekJVMjVI?=
 =?utf-8?B?dTFNc3FxL2xTUGdKTkxoZ3JkZVBFV1V5THlCQ0xXd2MrUUdpY3ZTU3VaRVRt?=
 =?utf-8?B?R0QyTXdDUzFocnkxbndqR1RWK0YxaUNBUkhuQnRpaUk2R2hSTU0rckprRG5U?=
 =?utf-8?B?QUwvaFNObXA0YnVOZTR2c3kzaXFlM3dOQXozZnROanBxNDlCUXlnL3NQckNP?=
 =?utf-8?B?am5XSGxESXh3OWhuRkZVRC9uWGsrQ21EOVJXVnovUFdOQWxWTE0wbDlHQ1FU?=
 =?utf-8?B?UEJHcGN4UFhjM3hqVEE2RUtpRDJROWFwQUxpTEtXNmhiKyt1ODdHaXBpaU4z?=
 =?utf-8?B?aWlOUUNkZ3k3OTd2SDBDNTduYXpYMnhrVXBTVStjMlFaWkZ6KzZobnRyNTNx?=
 =?utf-8?B?UnVnN2dTU0ovUm50UlpqNjQrSzFOWVkzVWhLVmwxa29FT1htNERDOC9pdDhi?=
 =?utf-8?B?d2tOY1BGenI3T2d4S1BUeEpCMHhDK2Fid1JURkkzM3V4VCtjQ3pRaGlhR0dT?=
 =?utf-8?B?Yit1TjJhS1RGVEptNDZ6cFBuVXA0dVQ1OXdlOENHNmc3TWxCN1UxWElXRnBn?=
 =?utf-8?B?RFpjZ2x1RVByK2tDYXdhMFErWUtIcFJpSGZ3anYrcEc0dzJJdmN4by9oSG4y?=
 =?utf-8?B?Q2I2MEgrQXAveTZnKzEwWE1Td0dkNXhtOXUwVGh3cVlyU0I4bUthbTRmazl4?=
 =?utf-8?B?aFQvL3gvUERKeFNUZDBrcXJuakdaVU9QbEd5RmNjM0NuQnRxYjhGV2kzQW9t?=
 =?utf-8?B?VlhvdjNtYnFQTExHTmtKRVlBNGo5QkVISE1wTzJrTmozalA3bmU0aEEyYTds?=
 =?utf-8?B?SEZuS2RiMlNKRGFIREY0ZFcvelFDSk5wcFVTdFlLZnpGTlV6V0owc1ZBTmtI?=
 =?utf-8?B?ZDVjRnFyMkw1aXlJdG1LZmpJbkxuT013OWlud0VXTFkwN29ObVpNRXM1YldL?=
 =?utf-8?B?MzFrN1I3c3dFaWl0Qk11K0xlMmxMaHVJOElkRUI3RVVmUVhyeDg2VGRaZkFL?=
 =?utf-8?B?Y2I1WmJhTzg0WU11bDFDcmVTUXAxc1NKN080R0MzT09SUnZXTzNLOHdUTnZy?=
 =?utf-8?B?MWs1M3B4NXlRM3lnenZZb1lQRHRJVlVFaHFyajgyWDd6TzJwTmJoeHVMRXBD?=
 =?utf-8?B?M2pWUzB5Tnl0SlZhbVVkTURMNmtKVDNYbTkxVUdTS0FSUnl2YithajVjdnJn?=
 =?utf-8?B?dHRNcDlaMUhSR3BiaFZNNjR2ZmhmTjErQ0w4Z0VLWWNnWnJubk9HcnExSnVm?=
 =?utf-8?B?WHB0WXBENm03QUx3SThsak0xYitqeFlsQUtkU0dTazdKKy9ORmgwZ2hEVXg3?=
 =?utf-8?B?YXhEeWM2c0Y3L0NrazMvM2Z6ekJBcm9nRkhQb1NLU1FBdHpLZGVDSHR4NkdB?=
 =?utf-8?B?NmsxdFZISHUwZjRkZGt3cStzVTR1WEV5M29KSTFjbXRvWFBJOHF1WC9Id0ZY?=
 =?utf-8?B?WFNGN0ZLRXhqUzB5OUM0TXZLSjNEQU5PY242cUlRRUZtNkJMZ25xMzhJV2Nl?=
 =?utf-8?B?TmFpTndtc3c1cmRLdGphRTd4ZFVCR1lCdU9kRkovVU03TWFOTkxXeTM1cXVU?=
 =?utf-8?B?eHJQQ0dkdXJJaW5YMFRhdjNBY3ppSzlwcXlEN2FIeC92aytlQnF1RDN5SmdS?=
 =?utf-8?B?M2QwOHR4aWU0VHR3K3lwaHB6SVdVVkQ4dlk5UWdVdENnUDR6azFEWlZJbDQ4?=
 =?utf-8?B?emEwWGxjbzNlOS8yTzNGSjU5NHpCamY5M3BHU1pGMUZqNldtUUlkeERWcW1U?=
 =?utf-8?B?THozZFpsSzFKbDk3bE5qM3VkZHNzR21QRG43VDV4YkZFdGVUK3lKSHkvR2Fq?=
 =?utf-8?Q?kKygwL2+2/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NksyLzJCZjBiWXVCSHo3a2lDMytDR2FiYjFMZlU2UnFlajRCdzZINFZLTFZW?=
 =?utf-8?B?NEh4ZkVTckRjbis0bXVnR3Y2aWVUTC9WTTVjb2cvNEhQcU9UK3Q5R24wWWNX?=
 =?utf-8?B?MHQwNlN5THdxR1dQZ1NQRkRHb1QzREM5aTN0VEN2U0M1cEMrMW1BTEFzNWpH?=
 =?utf-8?B?QkMybzdlWWRadytGYjhPT3BYVkhxc2hPOTdzRGxBc2tpV1RHbnlmR2JkbWEy?=
 =?utf-8?B?VXRkakdOS1V0UThRVGVQMmVVV0g3ZjVKUXV4M0h3NUhmVFloT3FUT1g4Sng0?=
 =?utf-8?B?VkJTWjhESnVMbGFSSXRvdlUrVWhPeStQRUZCSHBlSmJiNlpGa3l0MldzdTRn?=
 =?utf-8?B?ZDU1MC8xT2NHMHl4ZTBjemxsZDBVb2E2czQ3NSswbHJ6Y1RiMGhib0Q5V3kr?=
 =?utf-8?B?NlE3M3ZwWlFaUFUxcGd3bjIyRWtUa2hmdG43d09CUlpKTGppYVFpQlBaWHQr?=
 =?utf-8?B?LzBOLy9MUEpMZml2SWVWZ1MyT0xDZHZkdUcyYVZVSzdsbm1EWG1HbjdNNUNJ?=
 =?utf-8?B?eFhrYTFyZ1I1bVVkVmg2emZqVVBndU1hUy9IbmpnTlIwblJFYlZUUEhDS0xl?=
 =?utf-8?B?MGFOWDVnQ0FaRW9SLzQ3eDE5R0xld2lrSDh6aVlBYk55NkFCMDlSQlJUNmNj?=
 =?utf-8?B?c1c3eWVhdk5mbmZSVlk2eGFVb21JQ3FpV2N4TjdOYjdyci9mdzlwYktaZldo?=
 =?utf-8?B?OFBKckpaNTA3RHdaZDIyeTJXR2VYMlhreXJlNHMxUVhnaDRubmZ3Z3dRVTNH?=
 =?utf-8?B?QWdzWWtzZUpXWkhNWWgram84aGtHQ1VxSFJnaHBVSmZHQi81REErR0JnYU02?=
 =?utf-8?B?em9qVSs5Y3NKT1ozYlo1Sm5nVG5ENCtwSmpsNXlmbW4vY2dlNlMyN1FmYlph?=
 =?utf-8?B?ZDA3b0NBSkd3d0ltVVdSbTZJQko0QTFIT0lNeXBGeTZXN05FKzd1YVZES3pv?=
 =?utf-8?B?bzlUTjc0S0NQSnR2Q2VrdDNod2NvSk14NUxoUHRwNnpud1VDNW8xcGU1L3Fw?=
 =?utf-8?B?RGh1RGxPM1FzN1Nuc0VFWU9KSHN1cmF6di9aNmMzdU1XdllPQjVMYVN0ZGNZ?=
 =?utf-8?B?aXduWDV6MlFIMUowL1piaUxjVFNpQTZRam1SY245VnlMUDFGN1VTM3h2ek16?=
 =?utf-8?B?UnBhajJFMHUyNkNnN0Q3MXZZOG5sb0tGWHBzTXFuS2VXSkN4ZDVpWm5md0Jk?=
 =?utf-8?B?T2RQWTJxLy9QUnlNaHk1SzV4MHdldVBXVmd4VWo5S1FGbXd6RTMzUFNxczVW?=
 =?utf-8?B?djlXT1lEd05TVXpDOUsvU0liby9GMmU3MitCc25GTHhkc1hEZlpmNmpVWGJt?=
 =?utf-8?B?bGlZYU0vdSt6dTV2TDlnNDA5d2U5WmR4R0MybFRmajZ2cjFZZytmNmFwWUVK?=
 =?utf-8?B?M0tkY1hXU1VDUDNwWGNQV2dMT1RvT21RQlBXZ1V2L2dwanBxMCtCem1WdVlu?=
 =?utf-8?B?TU9EQm1Oelc4ZW43UGNST2hUT1FxOEwvVzdhTVF5VGtJR1hhdHJScjM2SlZJ?=
 =?utf-8?B?ZmVqYnQxNjFScHlFV1hLV1lZOWJWWlFHUXVCNlZ6RjQ5ekJ5RzN2alRMTkt6?=
 =?utf-8?B?K0Yzajh6eGxlaHFzQ3FSWGJwS0lQMEJySGF5ODVIaWlLVzJTZXl5a3RWRlp1?=
 =?utf-8?B?WlFJNFpoVngzcW04VkxBWEZ3OXpKVEtCUVdUcUNHRlJSY2QrYzlDTGxiOER6?=
 =?utf-8?B?VXcxUG41M3lBOGQrZUdGWERxMWo0bnlJUytmRVFTOUtwT1NRdWhsOEZiMUxu?=
 =?utf-8?B?eTdjUVdCSW90c05meHgydFFKZXVDZDZsNnRKekIwaXZqMk91Z2E3RFEwYmJ5?=
 =?utf-8?B?aTduVEE2L1F1VWVJdTVOSzExTDlqeTYxbzVRTmUyWE9hRmJhU01zVGpiTTBP?=
 =?utf-8?B?KzhsTk80VXJqWTVsdGpka0lUSFNQMlVEcTFHd3daR1FMWDlHUXZZTlpVNTFj?=
 =?utf-8?B?Mk1JWVR1b1g2cGJGdmRUMStSclJNUXVJclhSVmhlbTRWSTNqZXNPYnFsSnJm?=
 =?utf-8?B?ekp5NHc3b2NZSmRBalVKb1k5R1l6RDhlUy82STdQQU53MjluRUh2R2xobEsr?=
 =?utf-8?B?R2ZkWXJZR09pM0Y3TSs0TS9TQ3E5YzNPWDdqbTRHWmlEU3NDZEtudFRBT3ZQ?=
 =?utf-8?B?dmhrMDhPUGpZODl0Q29qV0hWdmJoYUQxbE1NempzS0JUSVU3ckhBTDNpRzk5?=
 =?utf-8?Q?hVtFjvbL6h+K/H5eeLX5EiZSH6J1DkiSkEQWRjOwbaSc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097af083-0d06-4545-ae13-08ddc9bfeddb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 08:07:12.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAmJNztWYERnmUOV7wTLkEP3uwS1/GoOmHHuQkeztYlzsqo+L8EhgvCqUfUwXacBPIn1yv3waubxZ9ZYTRhTcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

On Wed Jul 23, 2025 at 9:54 AM JST, Daniel Almeida wrote:
<snip>
>> +struct WrappedArc(Arc<kernel::bindings::sg_table>);
>> +impl core::borrow::Borrow<kernel::bindings::sg_table> for WrappedArc {
>> +    fn borrow(&self) -> &kernel::bindings::sg_table {
>> +        &self.0
>> +    }
>> }
>
> I assume there is no way to get around this without compromising somewher=
e
> else, right?

This should be undeeded now that [1] is in rust-next. `Arc` should now
be usable directly for the same purpose.

[1] https://lore.kernel.org/rust-for-linux/20250616-borrow_impls-v4-2-36f9b=
eb3fe6a@nvidia.com/

