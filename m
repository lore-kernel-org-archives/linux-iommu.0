Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0E25B0A8;
	Tue, 30 Jun 2026 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782091; cv=fail; b=V5NXHUejv7JXDHTs/YRumbAcMYTNa7U/p8J8GDhrdVyE34SP07IlSM9DP0iUDRoVxWeWUhHXazCuUQ5TTrHy9m79XHsHwpc34A0f5vF2CAhaytC1Hkw/zWsd+pEw/adAbcnJyWu8gSqyLKkG4+p/F+zGlAIWqDk40XlYBP03FPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782091; c=relaxed/simple;
	bh=ipgJXfJ4c6YuFf8t4A6HHGrVv1YMl1xWg82finvj5q4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XXLIhEJXuiKtYtVNe8q52qOaAWIiOn+55Euzw4yXIphqeMvQvZstXxid0q8LkgkWCPaemvkEMnqIS6tcpuEma1I6Oxvww2zv2TcefbCTaEZdvnPvo0XaQB+LabD2I9a9ki+D806kMvKBqtVtsylUDjqjxKpu1htXQ7RawiuGZ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T5vZyU0H; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5vZyU0H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfZXEVXRFsnVrWLRjdHNFZKbAjr2ApTY8Zwv1AKuSS7Px464/8b6lDqT34SsmcKw8tpKWm6U7ueAbW0HlJNW+jA9gEhXHYkJft9fyKxApq7hCQDTbHJa7p2YDOth6V1jkNREtmVbN4A7ph21WFUsBtpq8UtLwuwcM9/zOWDotdk7EpCdUOwmgAk81ueH9pkgz/GwdjRRreh6fVm8Jb7VHKdaSy/ND34YqXTJI3ZtjFK39WMCzHQdXk691VNfxO84U/2SxGwhwMTpuLgGXwDtbDgv0+DU6JQAlqr5f6MdhkaKEa18+B8BrV/HcO41AXjHqs8fLrf409Bh1zg11fbT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipgJXfJ4c6YuFf8t4A6HHGrVv1YMl1xWg82finvj5q4=;
 b=k3laAtc16t53eUvoAsr6+SwfD4PYx+hRgvC+KqSS5KqDE00wfoopPfyh6CLfIW51+OYqz6mroTCRLr7U4qlsMs8wLzNL418fh/MGUmXIiHP86/m1BasOO95AagzM8EDSsZ6H3v3SHnDQbhCAQTv2PZu90Rn57VVmK7bQPx3+V4ChhkOaQ14Izq2eBKiVkLS5LFaJ6YZX2R86/nvq+NyBmDTiITgcdjzEJKqa21IhGeyvncLVwO24ZIAkwgb16jnOG9YvLp3wioiwlHsb+jNQGv0ZSrVqd3cuJuAKX+a4J3F3s7uBcFoq5YLJBzAfKBFeSCBVcUzoBqUl+1REUSn/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipgJXfJ4c6YuFf8t4A6HHGrVv1YMl1xWg82finvj5q4=;
 b=T5vZyU0H6OFbF+tZptT9GoXTqjARjYMGJcgCA2fyK1SyCaGqc3q26k+BVfez++Zvsv5glnpYZM9JUkl2Ck6EpnWODtrple791jBGeVQV1sfoTLqGF67ZS9YS2FKz6B6ntmQqB+gZB0Fpypt2vfGO3npfEctATF3i5NVi3vyEA8aIxaOEiG4OwBGvRLwe/7is2opBkDqdMnw5i8PmsOjF+7v4WuQ0bBCjDKVbbw0l9AfPbakjrnhbzp8J+usZXzp/RK60nndTFo8/Xz8BG8m31Hz2+fXIRT0U16QqlLcJDh8N8rEC8oYxNOolZvnNyMCsE1hVxxCJB756Z2AMWNUA1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 01:14:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 01:14:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 10:14:32 +0900
Message-Id: <DJLZI1M9JV9M.1Z8DFJS8QERKS@nvidia.com>
Cc: "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Boqun Feng"
 <boqun@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Robin Murphy" <robin.murphy@arm.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Tamir Duberstein" <tamird@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] rust: iommu: replace core::mem::zeroed with
 Zeroable::zeroed
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
References: <20260629201046.423464-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260629201046.423464-1-nico.antinori.7@gmail.com>
X-ClientProxiedBy: TYCP286CA0111.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 03703a7b-c76a-4d87-8223-08ded644f317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|10070799003|376014|1800799024|366016|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dtnbbWJf75EThXNi83zGaVPGGIs3c+jFG/VbqK1ZZrDXswnKW63Fk5wr9AYGoRaxnWpOU6hX3qM0WyJcs610yiJsGIzyO6Y0QsfT1bspqnMvE09mp8gGL1n+rNlTfZNmFhTq+BHSTfvps2M9UolKE9VJWvGV2Yr1dPIlaHbVIwxbNdJOHU6qhz007OkUaAGY5rBHK81T0xC5S5EdgzxlNRRaHif63n5BrPVBOmgNz8DWfu2kLefJlLaD6L4IoW/Vxtz9Zdtr5kN10h54IDLp37bYwwASULtKOaYfXH9gG8uKK0B8WloqYzSb5AF4adDrpsOv/wA1KM6l2er/e5FWhq6cbgQlYx3WMzcul7fLVfObVLhcbnKSQ2B1gWyXwU5fxvXu/8FyNU/L8PU6mOIdWO1QVc2NkfHVvxnsgXuFAco7H1GXqOBRwPzhUfoaRr4f8nsnI2qaelWUszX1S65LXzj7/5flxQF3MZBpqzHK9Hr90UH8Urck0A6FpGLTFHcCmAhGkpKVYE56dW1zukscerhomhl9tQkDxRvtfOP59h1DI8DH0GYQ87AdYd/nMC+lrnxQUTr1axjEaeT6nUA7wtI9oEL2kwLJFrZwCaMNYqmcobzXeOqxjcG4T4pAO6ayLUPGBXFeQ/ca9HnUTd9jAqh0eu0OLZh0aJCzSNKFb7s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(10070799003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MC9WeFpSTGJ0S3VNZmZNNHAvV0FvT2cxeUtianR2K2YvVER1YVVyMGlaeER3?=
 =?utf-8?B?ZWN0UnQwUFc0OVJJZXNSUWZqZmRvUCtnWkphdkcvTWduUUsyUUc2dVN0NnBG?=
 =?utf-8?B?VW1lTjV4aEd4bnlOZWIzZXA4aGZwRDJlaXJMeWhscXk1b2dJZGUzS21uV21q?=
 =?utf-8?B?bkVSUURhd0loVnFmbjdtZEo4OXhOT0dnZEppdmJKcG5JTDVCSkpYbU9NdGlS?=
 =?utf-8?B?N00yL2FhMGhlUmg5N25MNmhrWkZoTDVxTWltUGlwSHNMTS83Y3BoNE5TWDJW?=
 =?utf-8?B?K0Z6U1QzOTlRWVlwVmt2UG5RN3YzU3dWK05hNGQ2UnRBZ29oZWQvWEt4cjRo?=
 =?utf-8?B?VG9Fbld4Sk5YYmx4NmdiM2l1dm9MQVhIVHU1YzZGZkVlZjBOZFVyQmlEZzlq?=
 =?utf-8?B?dzJoQk1lWDFwTGpGaXBTTU8yS2tCeW1DNUplSnRnS2xnSGNMM2cweDJ1RmZG?=
 =?utf-8?B?RmlGZkV0czFuY05pM1ZOWkZ1SE9zOWF2cUk2RTVEeGJJc0llbVVaOVcrdlZa?=
 =?utf-8?B?WnlvVUQ0RVpYbW1lTDNRclhRL0VlSzNWMjROR2Z6Qm1jbUpwTm1reUYrWjQv?=
 =?utf-8?B?OUZrRnFGS08zQUJUaFRmaGJiS0plZ1RJQkExVlhxVnhxODlGU1ZOdi8yMkRa?=
 =?utf-8?B?TmFKRjRucU0vbWJzRmdNNGZvNUEzRFhWUmo2M0hNWVIvUUIrMmxlMlQvS3BQ?=
 =?utf-8?B?TFhXU2lRNUYrb3Q1VGwwNDNUanBXRktLd2l0MVdYRnNoNjdjUFl6cU1YVEIw?=
 =?utf-8?B?cUk5bUx1SU9MMXE0V1FFTithWjJ6bzlkUXorRU1kOXpmSU1BejMxNThYNktk?=
 =?utf-8?B?VlhqOEpraElGMHNvZjlKSHQrSGJoWnIraXdUZnQyT0cvUm5vL3dackUvZVkr?=
 =?utf-8?B?Uis0cDl1SXZmRjhjRG16YUNqbDNlQ0R2MEkzNHpHWDFWWVFFUXdCclZwNXBG?=
 =?utf-8?B?aXZUYzEvYkJIdUZYZlk5enBUWmVhZHRsT0xHTGRScm5OVTR4KzFzRXFVdnJq?=
 =?utf-8?B?VmhxNmpZREFDQ1dPWldxamZFSG16OWFxYkxJK0FIdzBnQTlKQXp2VldyZWg0?=
 =?utf-8?B?SE9rOEJGSWRaK2xXdkhodGlsZlZWcDVsZGtmSDlMTy90eWJ2R3plbXlrUFZ1?=
 =?utf-8?B?cjIwRTREdGhmL0JxMXVtZGFqN0dwRkRCVWlxaE9qTVlONzh5bTFBVzhZd2dB?=
 =?utf-8?B?ZURpZVAwTEJHdlNzejhUajBTRlVwaFhvS1JvWlFzYTlJY2JyaW0zbm96ZHdL?=
 =?utf-8?B?a29oYVRGS2tNR2crZDJpV2p1T3lhbUFZZGtwNXRqWVVON0RJc0FsUE4ydkh4?=
 =?utf-8?B?YWtnTXdIYTFMekN1OExtRHBtdFRldTFnZklEQ1NUWksvMmgyMGh6b0RXTFlu?=
 =?utf-8?B?TThoK3ZCdDRRNkdnYjcwdG5jNXRFVkJOa1h5VndEM281bDlTY0tiM3lpSGVO?=
 =?utf-8?B?VFVlZlZ0R21oQjZ3YjR5dUROb0NERDhLdlJVNUlBTnpHLzRPRG1pU2NpM3lC?=
 =?utf-8?B?MkY4anFpZzVWZFVFU3RuZlNtOU5EbGlPSzdnS00zZXY5RWRsdWhyOU01R2pM?=
 =?utf-8?B?YXB3NWhncnB2VnhlWDJWUnRvL1Q5cEt4L1dVQUgraHhhM1ZlRHFvTHV2M2Rp?=
 =?utf-8?B?eFpjQ3Noa1FTRUJDaEFiV1c2K1dmSFBqNDNHVDhoaUsycWwxdUovODVMVXly?=
 =?utf-8?B?d2QwU2pHQndmeFlXTGtwZSt2M2k5dTljMUhsWTBtcDFqc0ZlRm13c1ZBMzZJ?=
 =?utf-8?B?U2M0YXFYNFV0SEZhNmVIMGZiUlU3SE9NVDZqTjNXVW9ZSEltYitjR0Z0dkRn?=
 =?utf-8?B?UnprbGZHQjVwZ1pJM1hkK3BkYmF5SUwvN0lvUUlNZFlKMjNQRU03MlpxY0JS?=
 =?utf-8?B?RjBzVlFKcjBpTlJaQnc5OWttOU5iZ1M5aVMzUTFMTWZtUHpvSmU2MHVkQ0ZZ?=
 =?utf-8?B?SEJUOXpDLzNXM1h1YUtXRDhoNEU4MFFzeitnOENZNFJheTdIdloxWnhwWGU4?=
 =?utf-8?B?bWpnaWloaFhyWHo1aGpBa0tBU25ac2dPcklsL1B6VW0wWGpRV3BJZHFlbTQ5?=
 =?utf-8?B?cm5iZFpDL0ozRmpqUHV5Q2wyRWlMMGV6dE1zREorOXR1dzJUV1RmbFdQZWtk?=
 =?utf-8?B?YkJQZWorTVZ6bmJOR2M5RTk5RW5GS2F4SzZodGQ3SCtvdXhyeURGOU5pZkdt?=
 =?utf-8?B?Vlp5RWQrdlJlaThmNmowUlp0bHhGR3RlNDFuZXdCQ2ZQTTRMckNFZ1daY3JU?=
 =?utf-8?B?ODBqWUJBV2NJVDdsa1pFa3VkSmhFMmUvQ0hhZklEM0Y0aXRRUUNzRTR1OVE5?=
 =?utf-8?B?bTlrakhhbUVySCtGQmRTbkNiK2wxdnFTTXRmSVhmd2VydlkwdGU3Qk9EaUVZ?=
 =?utf-8?Q?/CgHSJ/toq9HUxY+fUZWkme9TqVp4g2s5HoiL5mXyY089?=
X-MS-Exchange-AntiSpam-MessageData-1: MXsrrRrYwECZrQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03703a7b-c76a-4d87-8223-08ded644f317
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 01:14:35.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EuK/ix/QTXsxMHg27XR5lePf8RlOIGRPs/zWqHuYFXxuZiB+vrVxmlYlxq0R4vMVdk4rJpt7kJU2iLUB0zVaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138

On Tue Jun 30, 2026 at 5:10 AM JST, Nicol=C3=A1s Antinori wrote:
> All types in `bindings` implement `Zeroable` if they can. This enables
> using `Zeroable::zeroed` for `io_pgtable_cfg` initialization instead
> of relying on `..unsafe { core::mem::zeroed() }`.
>
> This change improves readability and removes an unnecessary unsafe
> block.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
