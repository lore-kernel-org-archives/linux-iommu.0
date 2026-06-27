Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7432BDC0E;
	Sat, 27 Jun 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782549311; cv=fail; b=LQ2gUz+jixFNsIs+JzgDMuSkvtgXZMd55BSock1WQIF9GOe7R2V/Jx+hx7evPElholoUF0IzLCy1UvohQ5GkMNZZgAbgwOwQ18KpcVFr0pgOnk1FgW/CFU5oFXn8klyo2nEHF5CHtrGgrX/14Oc9Dq8dhAyNFy0DP6LqNYjOTkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782549311; c=relaxed/simple;
	bh=UMdztxafF6HQmcUZSsyd8y8VQ3WznDrgEJXHi4WKOSQ=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=HwZvZd+9LsfIk2Ua67Ds5riCSm6fvcVeUlsG66DGcLEuuyqFoSr4d6pwl4O0NeNfB9zmZvCKDLeY1KfjqpDmxwA8UHwGdahTZh/QxdV5PAQNccAFvF6l9YyTArXH2ZDSZlAn1eaRPcp/769ucg5dtiNwx4xbS5q2kZOt7ATvwjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kPBPYaxH; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kPBPYaxH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLwwEd8izuhu9ozVVDNYnI9Djx0HjO9v+wg2UlWUpdyvLRvQbMKS0hFGZmf7lJuRG/TiXdPA+5O0QWNhYGn8RVoI7Rs/iSKtND/R9qPW2+G66l222uDiUpd4WwM0wAELClMy/485WAmk/65SsivkQtJfS9XkzA6JW1Uw8tDlmgJjLnK3mxyL2Fl0OZuvQjooP82jxnDWJsem9Amvy2RlLjnZzCz9lzFeMBPzF+senjD6ykzUqsw3i0pIGZLn4zXfCPLK1DGBN0Kp3MFiTuQ45sgg3uENuaUU22GvVPQUY9/7Ul7fS6N+mecZaf60iUwF3DgBpQ7hiAbi07FEsMqKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpmTB5WxFoJVzGbNVsbe0DYzdYzxr2pFzgmSMQWoa+8=;
 b=and312SIeJJyO5Rf8W6ZFOoW4jgLTyyY6ibQNVrZo/pJaJ5muwsuGVtfoLRl6iHIN75jSaM7PtNPDoIh9rHVA8KX/jfRfLRYkNVPL0bIbFAK0542F3AnIPprtJiHkk+W2Vx/sDr6F/2ElpfeWT2pxJuWhT6AiztTY+0sAhGj2T0NHx2PqZ8d4DZBcUe49bdLX9I4zq2bPdVeRN2A+erneFJJLW+/qQNW2Hz2A0W3F0nPuqMvJaHhnHgPrxX6VbYexg5bmVtnfyGRHEebvf1y0wZTATiX811vXHt7puh6CC0HHmgVlnvi5l4mfj17VC6xJNhJ4NM/M5oPnqm++F7/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpmTB5WxFoJVzGbNVsbe0DYzdYzxr2pFzgmSMQWoa+8=;
 b=kPBPYaxHOoP5/I2avBbc7jeEYrHqwXZT5GBnmp4eOKVdnxYKkdupY7IqMx6U9rFGAaxepTojb5Yn90+9LcBGXuVj/ay31gFAqlxbiBQdwG5mtCkvOzNnuXyEHmOiFIQM5WBip7vIa5d4ww00wur5fRsmZMSxW7ALGd6lfpoxPqNF33A0ufwmm1Vg0y8ACws3J7ylZMuQy3Cs/NRq55GtJjLEhkiGCLf/480rLdaoXoiwx/geZ/wUYtAD4m/ow2oJvN6FGyn90wjMBFXZB+uOobmVBB9vxnNB+azHX1M6yD3XtqLGnTTRxrWntvmDmT+6nH9BzBENBS7LQVfp+Dtt2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Sat, 27 Jun
 2026 08:35:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.016; Sat, 27 Jun 2026
 08:35:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Jun 2026 17:34:59 +0900
Message-Id: <DJJOZNFW51LZ.IKTXQ8ZIVO55@nvidia.com>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
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
Subject: Re: [PATCH] rust: iommu: replace core::mem::zeroed with
 pin_init::zeroed
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260626203122.713317-1-nico.antinori.7@gmail.com>
In-Reply-To: <20260626203122.713317-1-nico.antinori.7@gmail.com>
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d68fd4-4cde-4448-8a20-08ded426fc11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nWqXllGLpJVM5qLvbEFaiXxh4oo1T1VKLqGOwe3oYgAXjrhcUu1qW40kHrgmqFGFpfDsReUSJwnWI3dkh64+EpCKcpU2IUsXLTBAIVuwoUiav0pSWyNYhPm3vkjThT/E5Zoxi/IowR3myeRDaikeJOe2gXIkW238DsZMXiAaMFG592fnE5R/ndOzwY0lw4aH3DgiUcTZnNlkKYNCoGChBXbaT8CrMu7ToGKWLui/RIs5OQIgr6+mX7OUhODPanI5wCb6+seSsJVDTqoaBTAL9h5vPyiCiY9zyNpuQBj3Wj72ZO1L1U7tj7gMLwMiQFKfbzwSkzHN8byC6x+aglQRJapvSV2o3HFqGJhzZ98uciBv0jthslW/hOitYaS7Q7pm+bYPW1dhphclMxKsOMZvcvYrV/R0molmNa4ACB42r0o4zmDIt3tmUN7Of4qHZ9zgNRrbDmyIB/kd2b6X5yQEnyuwalTnH+VIoqp3ICelX2pl0rpEiKWKisgKH/5FIS9E4vlRa9hOJKtrDTw3uP5spWM2+Qkbtc7LxjHbxUaeOk8W8wyQaHYPrdyVMJxJzkhsHqcCxb/37PDNCx/kGIeDvNeItVvjdLplA7F5/s9zCc0DXdwZYyLKYS2qvzgQhwhIKxZb++5cwl+n/Bes7tIVKPghqeepP6h3RTE4FmZdt/M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGU0TzVMQUFvZm5PR3ZSeTJBdWJWMWRhQmdCRXFMTk92YkVtUzJkREFxeVly?=
 =?utf-8?B?ZUVqUzF3VXNSVWJYT3FHblZ4RGQvd0lMYlI4Y2pzV0xyZVZMNkxQRFgxMEVa?=
 =?utf-8?B?TmtaOFlLaml5eUNpVXlzSEFrU1cvQkpzM2JZaDJNeFB0cFcydS9PMkkwbEth?=
 =?utf-8?B?azhNMEJ0NjA2L0VYTzkwakg0VjBoNTUwSGpSOXlBbDR0R1ZaKy80dTNWZEVx?=
 =?utf-8?B?QVkrSFQrS0hONXhKV3hmK0VJblUyMUlZS09xMFlCM0hTVFg0RVBnVFNKM1Vl?=
 =?utf-8?B?TTljanJKVjV2Yit5eENPamMvbkcyUU5oYUNEWkh1UEFMT0x0ZXlxcjJpb09y?=
 =?utf-8?B?WXh0a3B4ZlplT3V1RTk2cUxXMVNUdkZsSWZNNGJIMEtaSHlma1RyQVF6UDBj?=
 =?utf-8?B?TXNjcnhmZUMvKzFld1NGSlExS3FTa25rZlJ3Q1J4dGlDZ2RoMVpuaHowYjlD?=
 =?utf-8?B?TFdYZUs5WWVJU2NzeHQ3R3lCVzlhRmx4SDBkcnFYa1Vic21ROHNIaVdQaDND?=
 =?utf-8?B?MnF2cjZJWWV5eGF5dW1SZTk0UTZ5Z2NLdVB0d1ZLeFREbXIvTmVtUGpMZlVJ?=
 =?utf-8?B?RlhUN25ZZnFhQnlmNDl1WDRJSjJ2SVlNN1NCMUxRSCtWNytJT1BiUmpmQTJX?=
 =?utf-8?B?dE9QKyt2MlFvS1NqU1grK2NTL1dVVmV0bWc5Q1p4TWZIUS90REQyNCtuM2x6?=
 =?utf-8?B?em45MEVoTFNvNDg1eFZ3dFM5TUI0SUZxbDFJd2Q3dnlIdG11WmJ0Z3lqbjB5?=
 =?utf-8?B?SVpDYlVVZ25KTHkwdXdqb2NyY0VnZ2t3VStmTWdSeUlVYTYrL042Z25rT1Yy?=
 =?utf-8?B?UERZUFphem9FYTNMMjZlNitYVU4vTHU5K2l3NkpsM1p0OUh1M01ORTVHeDJz?=
 =?utf-8?B?ekRhMTVSbzFCM25wK0s2Ym44c0hJNnd6cU5IeDRFUHpCMVlSa2FYM2JVQkpu?=
 =?utf-8?B?SkVqWjd6MEN1OVN3MzI2ejJRbG1TZFphMzhnMCt6c2x6MWlHdmJhNXdHR0Jv?=
 =?utf-8?B?dDJJT2QvWFhrQ0NKU2U5dkxka0tHOGxqUFZVOTdNTU1Jc0R4S1FSMm5kZG10?=
 =?utf-8?B?K3VYdFJmVE42U0d0NGJLT1ZXd3pTemc2WGV4cTRoS3g4eVkxWThsN3RXVS9p?=
 =?utf-8?B?cnQvTUlRaE9TQnpKUTlsTUh4ZEhXZ2pGRjhFdElCalpRTG5HdTFlOWs3bVRk?=
 =?utf-8?B?UlFZN3IzNnVjSk40L1JoUG9qSmhhQmQ3d29hZlVzQkR1NlVFbzFSaFhJZlhR?=
 =?utf-8?B?M0tTc01PcU0xNVVVSzNnZWd6TWNhYmxyRERjKzRpRG5zNHAyakk3UEloN0Qw?=
 =?utf-8?B?dUc5aW1pd2lxcW5JZjArekFMcU4xVnMwL2dEVG8yd2xmWGlka1owZTFmdlVo?=
 =?utf-8?B?LzBxOGJ5ZGVHQkNscVB5S1F2MnZGK21ucUdVSktINW9EZGxkeEt1RUhOWXRp?=
 =?utf-8?B?K1V4b05KUGp3WWtqR25QSWwzblVLSS9LY2NnazJ5c2hmbjRQVkRpTHlrZTJG?=
 =?utf-8?B?VnllNEU4TDAwUnRmakx0WEMyQkJIc3VlNjdkR0VJbzUvNlVRVXp6TnMxQnpj?=
 =?utf-8?B?N3hNN0xvemFSdmlMdTRVRENFeDBFM3ZTVjZIRElNYmh3Yk1GSVMvRVJsM3NC?=
 =?utf-8?B?SHVMR3hEdFRwUUF6Z2l4K0xLY2ZKOWZ2SzgxNlJwU01BNWowRWVJZzlnWVhv?=
 =?utf-8?B?aW9URW9zeEJZSjdEWTYrYldPWUZwaDZJVG9PYTl5UW5Ddk1YOWxvTUlRK0lp?=
 =?utf-8?B?OEVXa3JkbGJnNStCOGJQNTdSOG82aTJMY1B1VkNBZmZVSGRFcHdJZzRjVXI1?=
 =?utf-8?B?bnBuMDh6b3VBM3JlekF6S1FPUVRjSS92V3hTLzFhOFZkNmMvdmFGSmxGSHQz?=
 =?utf-8?B?WmhOc1pmWVFiMUpVK0xZa2JXYUhnd25VWmpManpzcXZac1B6MWExUllXKzc3?=
 =?utf-8?B?aFJwS3VZQklXYkZNNXEzd2ZnZmVUMXRaSnc5Y0JlYWowUFRuUW96QlpVVzJm?=
 =?utf-8?B?MDMzQkRlMThnRVVxcTV1WTRWRHBxRHpTdlU5V29ucVoyTFdQT0Z2UXFTOWNt?=
 =?utf-8?B?eDErT3N1TmEyN0tLV1YrbXd4cDB6aVV5THp0OTZqd21aVi9lV1M4cWVZNjdt?=
 =?utf-8?B?OHg0M01oOXRCVENuVmpDdEx5T2l4dWlNWlhxR3RqVDl3TkJQTWxNSUlHMWh2?=
 =?utf-8?B?ZEFpc1A0U0tMVCs0NjZwK29ESCsyZnhTckZuczlINlBzQjdicWZQMjlUaHlL?=
 =?utf-8?B?UDVOL0ZJL0owWmZwRzF5TVFseEJMNnJOWnRpSTRlanFDRk83RFdLeUxpNitR?=
 =?utf-8?B?bVJGMmVqZm1FTzVURG9OMVNTSlRHZEFwVWpDd0pPYUc3a2N4UmtpdHFhbG1k?=
 =?utf-8?Q?+pNNnWx5bPLFfBMyD9tvbAmGTX9v3ZyAO4dGR+fYgRYBv?=
X-MS-Exchange-AntiSpam-MessageData-1: d4LdVKNeMyIuBw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d68fd4-4cde-4448-8a20-08ded426fc11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 08:35:03.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP3iqHeuKYNuEcd/BOdcv8ls7BVjsxUYlMySbI15+FTLbIJP5eL82rqIPwDqe/s2ZFFvqZ7ZM/tRiLI2EtElxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

On Sat Jun 27, 2026 at 5:31 AM JST, Nicol=C3=A1s Antinori wrote:
> All types in `bindings` implement `Zeroable` if they can. This enables
> using `pin_init::zeroed()` for `io_pgtable_cfg` initialization instead
> of relying on `..unsafe { core::mem::zeroed() }`.
>
> This change improves readability and removes an unnecessary unsafe
> block.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
> ---
>  rust/kernel/iommu/pgtable.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
> index c88e38fd938a..8faa1d8d9fad 100644
> --- a/rust/kernel/iommu/pgtable.rs
> +++ b/rust/kernel/iommu/pgtable.rs
> @@ -102,8 +102,7 @@ pub unsafe fn new_raw(dev: &Device<Bound>, config: Co=
nfig) -> Result<IoPageTable
>              coherent_walk: config.coherent_walk,
>              tlb: &raw const NOOP_FLUSH_OPS,
>              iommu_dev: dev.as_raw(),
> -            // SAFETY: All zeroes is a valid value for `struct io_pgtabl=
e_cfg`.
> -            ..unsafe { core::mem::zeroed() }
> +            ..pin_init::zeroed()

Note that you can also use `..Zeroable::zeroed()` here since we are not
in const context. Not sure which one we prefer in this case, but I'd
personally err on the side of not referring to `pin_init` unless we are
dealing with a pinned object or need to because of a const requirement.
