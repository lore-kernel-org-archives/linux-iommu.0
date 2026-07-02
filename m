Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A303EAC84;
	Thu,  2 Jul 2026 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990671; cv=fail; b=Hw4LZC4nchltInOu9jG7INw6L0mX/PXoOtv1sZK6+5CgZ7h3DXrJA7JKiD0hCYL8XVj/rdbeRwHmOoX9gRDcz2zQKIgoN5KQOk0EXUHGhRUmDdovDROt4w1LYVBgjIuw3Y5FB4oE9+9C0SkC84QoIrAKxfRkKOzyqfxSqJT1rqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990671; c=relaxed/simple;
	bh=xR8DKJqAOOqT+oHkmbW7CB/Vx3FcGelsHgrTSmbJYW0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Isv2AY2/5E5p8P/YYscMnBDkGutu1CtKwks8rmMsBVIZZ50Fqvwv4DyI5WMYo2znjcgF7KYZlDRQPGzs17sczT1whOECnxb2bXsQE8FJhUgzlBAQzQ5iq9/DrXZE45RaAkL1Pgl/nD1AFesPW5R2EytyBsz8dwuU3VAMIaXgctM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RDKuiGE3; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RDKuiGE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cow+EElfUlUg611y/2vEkblLSKcsYk7kJjY17TJrIR7ibQDm/hUl84Wl1lzx70oVLmKWSY/95gE5lZF3jFwTnmjNe6CHlRwwNQRh8IQA8OwA4cWU5IfY2MSElwB7fK6JCw1coxGLIV7pRibzA9PGLeg8xvqT9/Z2WRuYW7adP3VwV3fDbqHo+84AxMUsZ5a+lWnUbsz3WyiFfxrcZQZOWtMHf45Ni5CYKrQMlaqxA6hPST/tSzNqPDog9SR8BjjMKBhIhDQ5rsSV1kfQ8CoaPUOWGT+Q4YhDWv/gjcOO5UY8v64pdoNR8EvFMHjYH5o5buQpqxEMQfl7W7rq+ZmuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy23mlVrp7XqSSlIrAHH5RUG1Od/NeuCBeGGs958/co=;
 b=M1KXgW630o9gLrr9uTodxgE4Nshz+nu3fs6p1l9y9rSNWD36woAP6mDysXg5G88F+dUcfYssp6+wRFALv1pz1PWMZ89wGkSQV6CORi9BuXaW03Anldq/6xXiksxgyFz4T5znBxwp0XSpj1BSuNwLa2HemLw9ABX8L5Y5CTMcat5AXoqSUkndxB72f7INjdbVbjSBY1kI6sFWQY8LrMHA/fMk+qLzIlXgheQTq26S6GAbX88X27dvSvSy4Vlc/CgUNEcNA/nNNIklVTNz4qPW6z6OXUmGTJfmppf7KuH8aADU/sQP5XyRbpX798844KdM1R9MNv1Y8t7OJEwXJwf6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy23mlVrp7XqSSlIrAHH5RUG1Od/NeuCBeGGs958/co=;
 b=RDKuiGE3gzTaIj65keg/pUGlvMXZr0NXivmKuIa/0UqCtSFz3GuTkiPmtFt75wbOe8F1seZ6dbwZN8GH8DG7RM7ACQmTAjkXIt5NOgB2NNLWxDD2dX7e2BV9B6RTsnaqnX9aU8BuXZ0i1DlYe9nlbLOPIopYeQYPIOfNixRELHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2646.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:11:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 11:11:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 12:11:05 +0100
Message-Id: <DJO1FVUK9ZD5.31NEM51PY0WJ6@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Boqun Feng" <boqun@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda"
 <ojeda@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Robin Murphy" <robin.murphy@arm.com>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Tamir Duberstein" <tamird@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-kernel-mentees@lists.linux.dev>
Subject: Re: [PATCH v2] rust: iommu: replace core::mem::zeroed with
 Zeroable::zeroed
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "Joerg
 Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260629201046.423464-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260629201046.423464-1-nico.antinori.7@gmail.com>
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2646:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc17748-69aa-4b93-1304-08ded82a9c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|10070799003|376014|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/ssZioQE4sKaKhn+eGMOEs4EKHebtzRq3iknykuWfswHxeR6WTGDBQeWGtysaXX9EGh29/oSoU6qvVW6XQmGoigRAb/cQyR8/yjxmsANV2zuRvJnfYaYjphDk+t0MBpFq5R86x7UX/LxjmliZcdFL4Irkls7er41c/dxeDdGN3/0HOxrOHZpBIDyJuYLkkAY4Njgpzw/yUWUuiCznbu/RULyJnMri79sWc7xEGiuir6gbLB+Enl48m+Y72QHgpLrpSNbN459fLZ6svDMY/YmpLJ+HyRbAGa7hwP/n072+SyTVHFZEWeq/UTmLhwgLhUEYKSTNdt+3qdFdpBw93cR8qe1PUddmFb9KpY0OU7GY/nhrKW15yoK9AaVwu5bP1mTp2tIZsm57XC1YwPe2w+nO0javQA+5TDWlz6IDMc6xKxAKm75fdgZ/fL01v8rQTmxR2R6yDGXtdxf78X1NQahDW1j8KXuq+8ZWStZGM520kYm9biLTBqtRr2GhMLZW8OXbcUTRjjlBjfF3HeTPYJuNFK0T0sKr4ov4vxopi6xZxedFa2NIZ7DAayzKaMfJ7ZUbGLOZSeQYi0rf0iD+HIeyhpOcn5ZfepR2tQMyZIWELo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(10070799003)(376014)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WktzaGxqckhxT2lMYmRjaVFJeHkwQXl2UW83OWJIZkhvVzZ1c1gvRVB6N0F3?=
 =?utf-8?B?OFZQQVJlbEdBZU9CMVFZVUVueVdyUGR1V0QzU2NMNGFUUkVKVGRnYXk4cllm?=
 =?utf-8?B?WDBLa1BRclQyZ1U0TExiK0RDc3R1YjZaUE9VOWlTN1k3WmR3N1NTTFZoTjlO?=
 =?utf-8?B?dWtSRmlJakpHdzYvVjdiT0xLV0FHejlEd2JHdWZyaGE3cmE2MVhRbDJ6LytT?=
 =?utf-8?B?NG90SkJrMGZVQU5wazJhWEg5K2NFWWF4WjdPVlpHNk4wdXFTcVZ2WUo3QkhO?=
 =?utf-8?B?ZkRzOXY5dE9EazQvak16VktjemhYa0FZNEVoUVBmSml5OFN5bm5TVnd2VTZK?=
 =?utf-8?B?WlMzekZRZjk0ckppUGxvV0FYZTJZT3VzdDRINDhkTmppWUxaK2trK3BuYWJK?=
 =?utf-8?B?ZW5teHh3eEFBTUdHajVEVFptZzExMmlXQllDWnpSc21Edjk3OEZvQWZtYWp6?=
 =?utf-8?B?OU1KZDlZRzArL2JKOFhheS8zczBwZHlGY3hwVXRlNGNUbE5lUkUxSHdLbitE?=
 =?utf-8?B?Y2dObEtkdzFlRjI2OEJRMEpXUm9Vd2M1RXZCVWFoZExMdTFhdTF3V0hZNi9v?=
 =?utf-8?B?QUFZd3h2bXM2ZHRxbWtGQmtySlU4YjUrR1VoUlo2b0RBVHk2aHMyeDA0OFgy?=
 =?utf-8?B?ZnlSRXpoT2JobDFWWDFjVWowaFhNb3phekoySi9PNzhIbnNLR3B4ME1TZ3M2?=
 =?utf-8?B?MjBRVG9jYSsrcWVaOVVuTXAybmFzdVpCMmxCZUk1TzJzencxZGJlTURmeVNG?=
 =?utf-8?B?YXZsWUdCWERVT3ZxYlhVNnF2NlJ6YmwrMjRaUVcxeGJ4NklPR1lWK0JxbGtr?=
 =?utf-8?B?OUlDY3ZlbFBTSHAyc3JtR08xRnRWSW1TV2tUOW9oenM0OUR5N2s3QlNwMG5T?=
 =?utf-8?B?MFpiRERubEVpclNVY3JvdmJkTjFoLzNjQWhmcWJMd2Nabjl1Z1lwbWtmYnhn?=
 =?utf-8?B?YldtK1VjQnkvVGF4OVY2bEhRYllSQUlrdnRNQ3ZhTDRCMlQxb1JQZWNlbTdz?=
 =?utf-8?B?NDRuUjZranBBZGI2NjM4VVZ4MUNzM0daQzArK3pFU0FkVnZLTE9wdHhNV2lr?=
 =?utf-8?B?RWNJMDZWUW90VkdDYklDaXk3Tlpua29FZzdRT2xDeFdRR1pHTmdZR1hBejJa?=
 =?utf-8?B?U2hSVVEvekRVRndLQW1OMEpBdXc0UFdyeVpMUTlaNldNM0d5eFpROEowWnlz?=
 =?utf-8?B?blJZeU9EdmlqaHhBSk1XVHRHMTlhNFBoOHpsajlITnBsY3V3Vzg0cWsvRlBK?=
 =?utf-8?B?UlFrekl6KzNJS0Jvdm9QcUZPWC9aVkdtQk9YUldpYVY3ZEZFZzZBRnFocDRs?=
 =?utf-8?B?UEdsbnBSSnBFM1pCdkZlbzhvQ3lvdHNCcW0yQnhIOHhyRndTMUNRZFRIVElO?=
 =?utf-8?B?Q1ZyYkxGNU02bUt4NXljVnRQaUIrb1hDdUNOQmt0VzZISjJNdlYvYWNNNnA5?=
 =?utf-8?B?Rm81dHh0b3NFd1RxZlhzNEFrZVZsb1BMN2JGdkFmSVFBM2xCcXZMZ2laZUM1?=
 =?utf-8?B?dktQejZBMDRTZlgvTDlXZDBPUkR2c2NyL0hLbjBudTlSZlQ4cHJScUhtMUk5?=
 =?utf-8?B?RVNGRFNLeWgvUEJGOFloaWRlM3V6M0t0a25COW9ZVmVrV2hxY2RYS3BXTEQ0?=
 =?utf-8?B?TFBkVDV1d2t5R2tDSlp5T21mMVh1VzNsYk5Da1k5TG5JN1Z2Wk5LRXROOTBV?=
 =?utf-8?B?QXUvWk03Qk9oZ0d3aUNIZ0wwSUxhSDFONHpjZjF2eXlQNkY3bkQwWG5GRGJG?=
 =?utf-8?B?OXpPVk5EOVNZb3JXVEhwcmVWcnFCNkdTa3BEczJtbDNIbmIybzN3VUNhS0xh?=
 =?utf-8?B?bFZNZURFbXV5UnFlZjJUeCtwdFFQSWxZK2lmU0QyQlcrUlVqbnBDYURvSHE1?=
 =?utf-8?B?K0lVWFFUVnBNR1YzeHVROHpJMVZuYnI1bkliOTFEeWhZZkNoRTZHVUNJOWJZ?=
 =?utf-8?B?Z2R5SEJDUVNnbU9MNVVsSWU3cmV1N2gzdlVqRkNna01ncWs1MG1DcFI1QmpE?=
 =?utf-8?B?Y1V4dTUxenN3bW1YUE45OGkwWGlTa2VSTlVMY2lmdzBHL254bnhnUnFGazJX?=
 =?utf-8?B?ek5OL1hVU1VQM3J0ejVtRWRwaWl6Y05IRjVuKzJUUzFQdEhydHljMzcrelNy?=
 =?utf-8?B?YWNYbkZua3lzY2w2OFR4NmtaUjNJSmlHM1lKMG1SQnRrWDNCbUEwZGd0bEU0?=
 =?utf-8?B?MXk3akpRc0FzQURYNzBsRCtEMktXVGZ1R1FHR0tTWG9zUG0xZjB0MDdBVHhT?=
 =?utf-8?B?MHdDUmlBWlJGdno0clJIdDFuZDE3akgwdTdCbTJFbE5JdnhpT2dUZmpFT3FV?=
 =?utf-8?B?QWhrSmI1Q3huMGdQRjFkTE1wY2xSR09jK0VadWc2a0xNU3d6cEs4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc17748-69aa-4b93-1304-08ded82a9c57
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:11:05.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVaveT6v2dTiPD3ejtgo6jKgqzO8ddTz939THXWtDjyOOR4K6JMXCDqpMbIHscTkHuR5n5l0bWvoASM98v8PCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2646

On Mon Jun 29, 2026 at 9:10 PM BST, Nicol=C3=A1s Antinori wrote:
> All types in `bindings` implement `Zeroable` if they can. This enables
> using `Zeroable::zeroed` for `io_pgtable_cfg` initialization instead
> of relying on `..unsafe { core::mem::zeroed() }`.
>=20
> This change improves readability and removes an unnecessary unsafe
> block.
>=20
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

Acked-by: Gary Guo <gary@garyguo.net>

> ---
> Changelog:
> v2: replaced `..pin_init::zeroed()` with `..Zeroable::zeroed()` as
>     discussed in v1 thread.
> v1:
>   https://lore.kernel.org/rust-for-linux/20260626203122.713317-1-nico.ant=
inori.7@gmail.com/T/#u
>=20
>  rust/kernel/iommu/pgtable.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

