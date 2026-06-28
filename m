Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673102DC765;
	Sun, 28 Jun 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782668097; cv=fail; b=fUgCO5C7xSP3IjTYgFd/8SBUMH2OWSa1H9pCTkWiX4NLgBlHtfZ1p8F4+BtnQpbQm3IHgfBIwacMdwB+LxULG2O94bEZ52w6g8L46R/SqiQpDcHid1Ss3O7AI9b4QpZ8Va4J5gm0k6/N4RwC2WVUPfXXbbI6kmRZtuYvUufELhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782668097; c=relaxed/simple;
	bh=5ed8HqsKbtoxoRyjp2VDMwDp0e0mVdcucX0p36pRSYY=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=i7DVJtTKg/Xiq9LVDzCIgbikOIjh7r7NJhVD5jrKopN/g2J+g10GriaCNXv1ntCx21NRdzkwU+HME60BpZgLKqrfH+IT/hg0tJwIQUADdpqifou3KpWgKE4NqFPkHE22SYeExpLjyv74k6nn3KFm4hucKdsCKugDPBIBXOjiGvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=jD0KRnFd; arc=fail smtp.client-ip=52.101.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="jD0KRnFd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6Zww4dhN/g/r51RxRANkugQ+YDaH2vDUeZp+CgybgoMFpKq4WRJhr/+ryeC2A9oRCuPKbjX40ycsa4f4987SHo7sXQ9JlVnnPmtd0I6fsnGafd7HA+U97UIbNRZ3lgNwce2BB8760x4GzLLuDjCQIJwxpq88lpfOd8EuwUz2cE6oAr9Ia10CqxdKFmevxy5RWD7EhOmKp9N2Z3cruIDUWs6niucjxCXi7ON8qKtB4DbdOfM+Tciy/tlq46tcD+Lk27mLg2VRiaiOoGxbU1rs/PikFATZ+LcKmapU+gJ3HSu0gYjNaOBhape8FG9h/FFtxmvQR3ROzL2YKU+Z8eIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ed8HqsKbtoxoRyjp2VDMwDp0e0mVdcucX0p36pRSYY=;
 b=WpsYM+KYhR27j9DE11zOB3qWBUIOmCPTmIYRyfkN/v6tbyMiaL57yFYgDEjC7IU2Yv5MGrEO0M0v8j3GygwoXrF9Zci1NW8YmPfNW3pVHUdrw0gxqReLvWVy9unbKPCIQw5cQemg6kREzjn345+Ity4RCocCmHsRBy/5xDIBJFTqbmhrJjNJ8xGzsB96dZp/ruvlL54zbOaUg9zRe+S1kUBPNWt8MqQnwUJy85SRkHSpO4TxOylZSfCAR12NX3iuwaD8+TxzfTeWJpRiNrVE3CQMwMUJO+TKFufYjNWpN34lGdPBeBqE2YeGsTPUE+22ntHml+N93ANBIkLNvvA5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ed8HqsKbtoxoRyjp2VDMwDp0e0mVdcucX0p36pRSYY=;
 b=jD0KRnFdWrZuk6O4c4t36arWXThBodgH6f+C3xrMZRfFPfw66uRjjYB9apFzvjNGSs+mckfhLOTD4qkyccHJnKQpN51KgE22UQrcpOki9Z3igwZG4WP44IpZzHsplapamqkDen6zkxlpO5wIIuzlHA4Y+8s3ox4K8BfTKCgw3fY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6607.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:302::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 17:34:50 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 17:34:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jun 2026 18:34:49 +0100
Message-Id: <DJKV3IQ0SXA1.30T5Y71AL6KV7@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@kernel.org>
Cc: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "Joerg
 Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
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
X-Mailer: aerc 0.21.0
References: <20260626203122.713317-1-nico.antinori.7@gmail.com>
 <DJJOZNFW51LZ.IKTXQ8ZIVO55@nvidia.com>
 <CANiq72kdCAyRUmXFcqQfkHpk1miG8Gagsn0_5U8p4WpKxv9d_g@mail.gmail.com>
In-Reply-To: <CANiq72kdCAyRUmXFcqQfkHpk1miG8Gagsn0_5U8p4WpKxv9d_g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0230.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 905457ed-4dbe-4295-b67d-08ded53b8e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|10070799003|376014|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oK1JQgfkAxqNYV/5aj6Y7Mwx7L0ts77Frgn6OIjHUJ+9A6ocjUFmauRCH1Vp5ZNHi8Nvz3QGdGuINTOsYkQGVx30WbdTZuIOE6b4aLrBuAshglPbueQ21xjZGQ8YByYOAFl37cCIDftGfgXdonq0QPT51TrVkWn5rkAVqPNNJBhe+pULgcGrwVOeSGgSuapEhueIrLWj+jxe0OQ8x7SL45FCV0OjHiODZgJbbf/TGGGZrB0Dqvkzv4ZH25RMU4htEbab74qP7ub1HEaxiEt+gXNcBr7rjwb1GrvzJEuDhx8PEp89vZBjJi05KmCpo/vjII0oSfBVrlI+kIXrGipzV/Q2XqW6+ZQ6SQwLN8wudpcJ/Kjqaibl6qIAMcDxaPZm0gtsD0pvMcfaCrw6T3rx9ROVC+SqsFCWMHd0BdHAL/eYZ8800cINc2lzYRB00w3byiKl4gdQIFHA3Bga/7ZRLhikCPPT8jF3whNmlpLpvLVJbwLOShdHnaX8WysEFn3ZkXh0RuHWlCYRD7S/zkj9JJtwSzpocNZNwsRQAuc5hkAqapXyS3GFEsYc85yz1AXgoBgM0TGC3eFZahQa6mee8+gtVfpXZIwuzdU4fHTtZ+SIg2wZhh49GB38kfJ1/7rY+ia0yTiSBlGBn7j05LlebIrcRTtEoea8ru6DjUIeL6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(10070799003)(376014)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNxSjJvM0prRHNQd2pwcitpc1NKbXltRktLOEJ6NUR0c1JZUS9tUDgzZ3JQ?=
 =?utf-8?B?S09WVGtVTFhTNkZyTi9VZWlMc3liNzhXaDBCZ01DVEZtNDdtZzdvQzdaVWpY?=
 =?utf-8?B?Qkw1dFhMQ0ZpN3pSRUgvRktnV1RmQ0dZMXNtWTVKK01MUXF6bUtqNzhtMXZo?=
 =?utf-8?B?NVBaWjY2bFVEalBYanRrYXpwaWw0WlFudzJTcTYxM0FpTlZyK1NyQXU5SXV5?=
 =?utf-8?B?QXpiSHozelJSUDUwVTI1WiszNDI1ampsOW9uTWVCTldhNVNoanNpRWo4YXhZ?=
 =?utf-8?B?aFBTOG1rT2M4UmRpWnlTWHYxN0QwR01qQnU1Q01qa2FHQnBNYXZiSkRER0Jo?=
 =?utf-8?B?Mm1mY0c0ellsWFI1ZDdLSnF5RnM2c3RUMG1LY0h3QjJYb2RIcis0YjJ4cWRL?=
 =?utf-8?B?L2NGUEVuTzBXbkI3N2hhditCMzZBTnBuQ21WZWd1anBTUVhUUDE1aXk5N0kv?=
 =?utf-8?B?R3pDenVjVEFSbVFsaUlETkdkL04zdzZndGdMWG5oQkZKRjNkTDlSTmw4TldZ?=
 =?utf-8?B?NlRkOTZQQXpCYUQvT2h0LzZ1UE9tMk1oSWxkdnNJWHNuL0dSSHJzVmo3RVdm?=
 =?utf-8?B?RmlMQS9RWllBVGNGS1JERFN3QlNoOENPZmZ0dzdQazNuOUdXTi94RDJVc1B3?=
 =?utf-8?B?YzhubFdpb2dncTdONmFubW1JWWQ3VzE0NEZYNHl6STdycFRnMEpYcS9Vbmpa?=
 =?utf-8?B?L0NMSFNDcTMyemVNR2VqdThJWGJvSlFRUVdGczFxbVFodkJMZS8veTlqWmJ4?=
 =?utf-8?B?bEZxRVUxK2hnTFl3TUw0MlpMSW5SL21Hd3NObFJqMUFNNkp2Z2s1cGZqOU02?=
 =?utf-8?B?OFBpTnNMbER2WHMrYjJsSFkwNzRueTFNcWtOSXMvUmw2TzgreVltWkJuWTkr?=
 =?utf-8?B?SHcxMlRBQU54clNTay9kdklSU3V2WmMzMWVlYXhpZGlkQVZ0cU9XQWdlb09X?=
 =?utf-8?B?Zmo4bmRsdVlIa2swODNqMEc5Q3ZDbll3WlBXdlJlV2lwOGhqb2srdCsvaTZF?=
 =?utf-8?B?b0lTMXZJN3FKb1VGUDR2Qnk2UUZ4bGxyMmMzdGdGdC9FWlZJbHcvMjRoRWtW?=
 =?utf-8?B?cmprNmZiOW9LcjJJRW8vQnJKWmhrY1loVFEzZFhDQ1hXcTNHa1Jib3RaOFRR?=
 =?utf-8?B?UjlQTE9XdUc4SWRiTjNTWlBDY3ptbGVSZmlHWUhxM0ZJdFdlWTgzOW9RT2Jq?=
 =?utf-8?B?YkY4Z2I1ZkNreWxOSVhDTTU2RnNFbmlaVlR2MjNWajROUDJNYnlxemg0S0t6?=
 =?utf-8?B?OGFmbHE0MmNGMmZJbWZCMHZIODRqcDJnaTMyVzhLa21rNndPcUtwakdJM0JY?=
 =?utf-8?B?Slc2N05CSXdQUytVdDBTbXBTOVFaWFFsQk5oUnlOVFlXaHdVaUFsWUJ1RjBH?=
 =?utf-8?B?bUNYbWNYeTFGYlc5aFNoR1JUeFI5S0dLTWhrdWh3YUJDbGNWUXo2VU9NdmZj?=
 =?utf-8?B?OHh4bzBlYXZBL3ZrcWh0QzVzWVk4cmpVdmNhTnVMa09DaFRSRjloK0JlTkEy?=
 =?utf-8?B?MjF2WGlaLzNtbldnZUFYekpTY2RPWWYwWGR0Rk9mMSs2NnhJT0pjVyswVTR1?=
 =?utf-8?B?Rkd0bkNEZDhha1RJajlzaUVKd0thbllmMmRqdjhmQlJkUUxpSzVYbUtRRFk4?=
 =?utf-8?B?RmkrSDdNNkRzT0RUeVBPNnN2a2xkSEJRcHNjVFoxMFZXV3hyUWQyL05Zb2Q3?=
 =?utf-8?B?RUZ0TVNacmhMaWpuZ1ZxbFhlV3ptSDM3eGRQOHI0SnBXRmZ2bDNtRGRNS0dY?=
 =?utf-8?B?bWpvM2VlWERSNUs4R0pUVUxZUEo3S2hIa044MGxLYlVKT0RMWWNVaElwdThl?=
 =?utf-8?B?Rk5QWTF0VG91cXRkSnNvbXdHaXNaNUZNQkhZMC9nYVZ5akdSN0Y2ZmJuaEN6?=
 =?utf-8?B?NVJUZjFLaU5pQitOeGowa2JuVHQ1ejlteHNTc2dTckpGakNuOGQ3Q2Z3NDh3?=
 =?utf-8?B?WkRRTEZ5YUYvYnVtOTF4a1RnYTdqS2pwcEg2T295YmIrdDhORWR0UURya1JG?=
 =?utf-8?B?OU9hOUg4SVp0M0cybkJlalpXTU0rL1lUTFUvUDFxSE02WkVxeThQNnJUZ09i?=
 =?utf-8?B?REVQeURObHM4VG9kQXZheDNsSGlCdlB5amd1bUI5ZEpZZG1JK1AvVWt2YTV6?=
 =?utf-8?B?TzlDdk9reXRSeVpmT2Q5VTZPM1V5ZXl0WjVEK294S0NmZmhVVEVQdk5OMlky?=
 =?utf-8?B?RVQ3SjN3S2w0ck1VdjBoWGNCT2RsZ0t6amx3MERkMW1ueTZWc3RyL25neDJn?=
 =?utf-8?B?QnZtb29xaEQzWCszRDNSbkhqM0FTL0xOS1U2WUQ0Qk8vUDdTWk8vTmUwT09l?=
 =?utf-8?B?bXBsbGZXZi9LVEpVZ0xNcm5EN3VRZjhXQjhDeVdQOU1vbE1hMWk4Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 905457ed-4dbe-4295-b67d-08ded53b8e7d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 17:34:50.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hVkNkrwdwmy1fxbLiQYjb8ftA1y6YYCqjLOg6cFV2jWrEQUoM8awmkSlZfZq0tLtr1vORmWUQ7LaLyRJlzdHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6607

On Sun Jun 28, 2026 at 11:31 AM BST, Miguel Ojeda wrote:
> On Sat, Jun 27, 2026 at 10:35=E2=80=AFAM Alexandre Courbot <acourbot@nvid=
ia.com> wrote:
>>
>> Note that you can also use `..Zeroable::zeroed()` here since we are not
>> in const context. Not sure which one we prefer in this case, but I'd
>> personally err on the side of not referring to `pin_init` unless we are
>> dealing with a pinned object or need to because of a const requirement.
>
> That sounds reasonable -- Benno/Gary, any comments?

`Zeroable::zeroed()` should be preferred where possible. Currently init mac=
ros
also recognize and turn them into zero-init if used inside init macros --
outside init macros they don't matter, but in a future where const trait me=
thods
are stable we would want to prefer `Zeroable::zeroed()` anyway.

Best,
Gary
