Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010033.outbound.protection.outlook.com [52.103.10.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB11381EB2
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007309; cv=fail; b=AOBMVJr+mUYgFK/dZkQcDqrKm/EecmOAN0tApSr74oibB5ZtVniuQNV4uyGB3kxEDoSL+MXsqYlfolKheDqHX6WeRD7mS1HO7cetKQlAuOKavMaiTFitH84QHQWeqBMq/un0HNeZxqKBTWQpZFWRnq1mwi9OINI664GrA9i/xJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007309; c=relaxed/simple;
	bh=NlGYyFfb2Jwr0LBZ4f8PsEH4fPwcCKBPO84QN33octk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X4o0CXCnAarvgNSHVV3x2IWbqKzfSmNGnvwy7Y9N0niYP5lZSxzelUNcOEqwZUv+7TpnJRKXbVDEZl9vwOr71CsJh94GgJoQDdatfSLhTEkpbEl4JASLQVg0qnxVgf/TCKwJ5XmV9AMtn73Y4DQREoqG2KNsP5Q7cMpOGZ+O+/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PCMiFyoF; arc=fail smtp.client-ip=52.103.10.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PCMiFyoF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4h8Nr4+V3EPA1hQ7hTgpfZvpy3KRWhKfYG56CtrSSrfjftJM5pQhYW6SS+4zyoV8iUSAjk4A9abpn30shIP3fgsL1C1EcVOBoqv0kEw2TTifRSBEt35LvDfHGVoBSfuBhGE0pb0kQbG+KGEMZBO3FpC6ibB2A0xT4gi+fF+lP/7tSDK91Oqsm6LZgWyecUrf6u5PjwxCemGQ5DVaH0AYgdRsx4Zd3RJShLNf1rkK7GiAATki+bFtr3FxsckQpPbTLDdGob5FIocnXEwFh2LUWdzjlkbGMTZ9ETZQlVmkb0ix7MyAM8Zx/P46W1BHFta/lcwkU3SEAgWTWfg321FZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlGYyFfb2Jwr0LBZ4f8PsEH4fPwcCKBPO84QN33octk=;
 b=imUTUgkezLiPHYe3NDAbiEwvMqjPTL3+8FK6f253lqISUFHX3ibgF0kMFaM0uea/QZknHASfihYqaVJdkZRXGKz/kd6XRmJIyeueSvODvbT15StMfjcSeCXWMzW9DVawUVsCbA2X6z91JGr48QmajHdfVNzjNPnDss3Y3UZDyey1pvJPmKam8zzWJqg/SOsba1W7jdaFzZup3s+F2ZGLZto7L2p3LOb20uZvrkFVIU/Qpc6JMZafvpTr1YJuVfj/CKWHQ9gg7dNVvAj3qGnSCfEzHb/9zuEINHY8h8BZGklNl+O+jQblSY+3F5pxXfiopHd4WzkXIxJ6TvcuyTQfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlGYyFfb2Jwr0LBZ4f8PsEH4fPwcCKBPO84QN33octk=;
 b=PCMiFyoF3TKX6X+bj9I0jdte7I7vJG4WIg5RnMSQF5M+/LHnuXc8OweOovbGr/bjrhWRaNlcajTx2i1+3rDx6N5uEa18+phYknRUIppPo9sYYefngK6RhrME30M9PjRiFZ4L7Wj2oCL+X7P7ZiOnmcgl45UKljtFkMJMZvjY3IvfE5zIWTzFSP7vT87+Tzp4hPHIK/kNiUUDko+e/JgORVraY25xGt/t+FdP+fU5j1pn/CgTyD0dDkkyV9SWyGHfMV5554kHEfvU4+dRSrfiky7qo9RsssidzCQb+K36iIYz1s786XdGqF/R9VT5rRSgws+bHBvKsgVifQUXu40rTQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8242.namprd02.prod.outlook.com (2603:10b6:610:eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:48:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 15:48:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>, Michael Kelley
	<mhklinux@outlook.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jagadeesh
 Pagadala <jpagadal@qti.qualcomm.com>
Subject: RE: [PATCH] swiotlb: introduce Kconfig option for compile-time
 default pool size
Thread-Topic: [PATCH] swiotlb: introduce Kconfig option for compile-time
 default pool size
Thread-Index: AQH4qD2tdB95A8nBZfFMqdhHnVG+1rYNJVoAgAY1nQCAD6ZmgIAAIpPw
Date: Thu, 2 Jul 2026 15:48:25 +0000
Message-ID:
 <SN6PR02MB4157CBBCC92990D2216D20ADD4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
 <SN6PR02MB415703094466F2E2B9025868D4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
 <75e435db-a24a-4852-8ca2-23f46e161fcd@oss.qualcomm.com>
 <70dd2528-e0b3-4bbf-af8c-7dcdd3bd4008@oss.qualcomm.com>
In-Reply-To: <70dd2528-e0b3-4bbf-af8c-7dcdd3bd4008@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8242:EE_
x-ms-office365-filtering-correlation-id: ce702f62-22d0-4d14-d30a-08ded8515a5f
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|25010399006|19101099003|31061999003|51005399006|8062599012|8060799015|19110799012|13091999003|41001999006|3412199025|440099028|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?SEtpNzNTeHlPVDc0QWdjdDN0eCtPUE5wb1pjUmc2MXlvQnlEN2lnMUtxa1NM?=
 =?utf-8?B?ZWdPdVYwdGlwOHFkWElHeHExNUxIQk43ckpNMXJiWWRNa0NrdW15Z2N6YUdW?=
 =?utf-8?B?WkJLOC9jTWl5Yzk0QUlOKzB3MkFOUlpIL3R2NHhDakp6WUc2RlRWditTTHJh?=
 =?utf-8?B?eTcvQit0UGVtMjBaU2duUzBGbWFHRE1zaTVURXlZaUphRXhuWmxxcDdlQkRD?=
 =?utf-8?B?dFBYb2NlQmIvQjU5V0czRFBsUjdWSjVyRXhRWGdQY0tDWUJiTnRXV2ZsQXh1?=
 =?utf-8?B?MUw5TUU0NTduMjhMck9ZWWZFUkxOV0k2SXJEbnV1QnlXZjI0VUNKMENZT0M4?=
 =?utf-8?B?Mlh1OXRsUnlNbUw5Y1lwZ2dVdzNVQndHVDZJT09CWTBwb09VNjllTlM3OGZL?=
 =?utf-8?B?WmI2NkNtcmR4dkpxcExxbVJ1V0srdXZZL2t3Q0hLUWFVQlpVU2tyeHpQTlNj?=
 =?utf-8?B?UTRtc1V0Z3ZLdmFBZUN3aEpuMFcrcnlLYTZMVkpBWUlTRUZWQTQ0bHdiUmRi?=
 =?utf-8?B?Ykc3Tkx0TGZiRHp1eTMrQTFvRGMvU2lkTUpjT3Y2NXhrbjRvVG5Pdi9EalEy?=
 =?utf-8?B?ZEJ2ZWd6cm5kS2FTbUgrMDhldVhtMDlUOCtLallmcDNkT1ltNXRWa0xLcVRQ?=
 =?utf-8?B?K2szdjVVWFd0MEtGRzlIWC9jT3lSU0dDZU5IK2JQay9tYWNxMmNsYkpZRU5G?=
 =?utf-8?B?QVJxWlhGNis5UFVsSmR1TXZWOTlvdTR5TmcvbzA2NFRGcHptUHRqZzhKbDBo?=
 =?utf-8?B?MmF6MWZ1eU52ZG1XWUg0di9YVWhFekl6Ly9aQkRYejlJNTFPMEFNRUxyQkVy?=
 =?utf-8?B?TUtqSTFub3ppajVkbUpxSlVwcWc5cGpWZmk2Q2U1K2RZSGtISDI0TDdJRlY5?=
 =?utf-8?B?MGpEM1NTVGN3dStwYTRNcjdneGkyMDNTbUhZeHZxWTJmYnlUNmVQSExLRmNx?=
 =?utf-8?B?YUQxcDNCV1NDRXcxS2NkbWFjT3BmdTlRNFNBUlF2ZVhSN3hlaFJBSHUvRlEw?=
 =?utf-8?B?Rnd0MDVPSDE1L0pLK08rZlhDRTZuV0RRaWpvSHNOVy9NQS9RR2FrR3hxM0xE?=
 =?utf-8?B?U1ptL0RPZ0tqN2drSHBVQnNDY2FTNkQ2UUMwY2txZjNtQTdXdjZqL2k2RTV4?=
 =?utf-8?B?cXJpQXc5aytseWJjMTlvd2p2VEpubHlyVXFCK2p1eUdTYk96UzNRRVFzNEdx?=
 =?utf-8?B?ck8rbkVReHJuN1hvalZsT1JxSWxhMHFTajVsTzJxQXBuMEdFODF1TjhhMWd1?=
 =?utf-8?B?VGFQMmJZQUo3bkxIVlRWN0IwVTkyWXhGMm5JWC9ZTVcwak5ndDdsTjRrOEhw?=
 =?utf-8?B?VU05VTNBTWJpRS93cXpPWmtvK2czMSt3bmFybzIzZXJpOThscjRFQWRIMGl0?=
 =?utf-8?B?V1pMMHhqd05RTHJjb1lRTkJzcUVNQlRjYXdJTVJ4K2ZjVmxha2lvUXgrOGlM?=
 =?utf-8?Q?9xpmEVlv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUt0YWhxd0ZSSnNxaFpSVEhhSUNyYkYvd0czMFdaUldJMHRlZDNhNkVwbHQz?=
 =?utf-8?B?VXpaK0taYjR0K2JpOEFocndrUVBIZDlEWEFCUUVuZENWS3dPajZteEx2bTFy?=
 =?utf-8?B?UXpnTzJLWXNLZkF6RmhDcm5NL2tBWkdtTkFIWlZ6bXJpdTNVK3o1c3BrRUM0?=
 =?utf-8?B?bC8wSCtaUENnRnErdVZ3NjRFazF4UEtGY0Jybk9WS01RdEx4bk80TjAyVnBJ?=
 =?utf-8?B?eHlUUGdBQzVXcFJ4VVBiMWU1YWpGUThzUU1LdGxjdXhEbTBzUEVqdHlJTkZ6?=
 =?utf-8?B?Tng0MkhkMEltRVRJcG5pUGJZUXlOc2tndFlOeFlJaU8zSjh5ZUxlaFBqdVBp?=
 =?utf-8?B?Y0orN0Zab0FiOVNLOEJ0eHFoMTdOV1BjSTNXa3ZJRDYyK0Z5R1FmczhJeitT?=
 =?utf-8?B?b3Yrc0IvMmdVSjhMT0JITGFLbTUydzlNR3hSWGFwbUU2c0pZK1RXTFdaNG1Y?=
 =?utf-8?B?aXFqV2V2emM5MXpFc2VsQ2Y3VVI1TWt1ZDhwVDMxcVkvTFNMeURWSnRkSlJC?=
 =?utf-8?B?USt2UzRWRDkrYzlHc1lTZEZoenNkV1lKekNFY0gwNjd0NkhYS2dWVCsxYXRr?=
 =?utf-8?B?aG5DZDFRM09sZ2RyK1REQmJXQVFudk1veTVFUFk2R2V3WVg3ejU1bkVQdkc3?=
 =?utf-8?B?VmYzMUZlN0JENjJSNUE1RE5EOFhHMG4vQ0JpMnBlbFROSmJ1cW5UK2MyRjEw?=
 =?utf-8?B?UjIvWWFJeitaczhlUE1aYjZhU2dvcWZGbFRvNzk3M3hEWTd5NTk0S2lkVlJ1?=
 =?utf-8?B?K2NDOHRBSVNBOGx6c0w0WkF4UVJqcHQxVW5icDIwbnlxWWxQSDJmS0kyRCsw?=
 =?utf-8?B?SVJjV0NpUkQyY3lxdFNYRFB6R2dEWkZXNjd5bXN3ZzErd2kydk8rYUxCQlBv?=
 =?utf-8?B?QVAra0FuQSs3ODl6dmtTTnlKbWxuODZVYUpXOGpTQWFKQ3VMRnlGR1hRN2hy?=
 =?utf-8?B?UXJsUjZJTk1nSVd1aHYzMkgrQTZUVlZkNWZZMnlJa2YyL2dqM0hnTVpteXZq?=
 =?utf-8?B?cEp1TjhYemFUSkQ5TjRYQytLOWtLc3g4SGg0NlhMMytBOWtLS2ZkL3lHejFV?=
 =?utf-8?B?QVR6ZU95NFRLeEN0Uy83ZGNWVzMxamZQWGgxdXJDUDJaR2ZMZW5zZGdBOENW?=
 =?utf-8?B?amUvUk44M3gxS01kYW9Fdm5idTdEQURYR1AxNWlSZ0Z4bHZoTm9CYmJVc1RT?=
 =?utf-8?B?eG50ajNRQmlhdEVyVGxpQlQxeGc1b20vdnJEMHp6Q3Nyd1dkUjdKTkUzdDJt?=
 =?utf-8?B?WVVXTXlEeXFqTWVrVXRsa01DWEpBK2lPb0J5L0QwWmtRdDZ6eXpYVEkzYW0v?=
 =?utf-8?B?WFd4cGQ0c0RJZlYzdWVxb05uWmN6Wk0rNXdpd0xlcFRhbnB1TTZIUkJBUmVq?=
 =?utf-8?B?a2FHVXM1R3JsaWRoU0xWQ0dwd1VRclo0M3dJYWJpZGxydDVxZkUzRGExK0VR?=
 =?utf-8?B?ZU1sdGdJaGw4L0FPMmZMc3lEM2JZVHhxeGZIMENqN09Za255UEZYVVdnaTVs?=
 =?utf-8?B?Vm5mMmZOMGJ5eE1WRkdFTXVZbXVKV210S3pQbUlwQjA3M1BuNkdST2g4cVNE?=
 =?utf-8?B?OGpSUnA2RCtyN0loeGd1RmFlR2ZBRnQ2YUhWZVVjQ2QydUY5UVVVQUhuaEFi?=
 =?utf-8?B?dUgrNDR4OSs0d2xHeEVzdG12Z3VoUVNPMVBuSllCdXlQQnNBMFlmNU0rS2pO?=
 =?utf-8?B?WVdPdENRd1FEL3hteTlDM1NQWkN1Rlk0YWQrdEFKZnpUcHNaU2Jqc3hPamRT?=
 =?utf-8?B?NkpEanZ1d1VGRnFJK005eTRUUXcwZ0V4S2djamRBekJHOFpXYXZCZE5MTksv?=
 =?utf-8?Q?4F9z2elKCgdBEQtB1MP7s1dTdtLcdx74VZcZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ce702f62-22d0-4d14-d30a-08ded8515a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 15:48:25.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8242

RnJvbTogQmliZWsgS3VtYXIgUGF0cm8gPGJpYmVrLnBhdHJvQG9zcy5xdWFsY29tbS5jb20+IFNl
bnQ6IFRodXJzZGF5LCBKdWx5IDIsIDIwMjYgNjo0NSBBTQ0KPiANCj4gT24gNi8yMi8yMDI2IDg6
MTUgUE0sIEJpYmVrIEt1bWFyIFBhdHJvIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiA2LzE4LzIw
MjYgOTozNCBQTSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4+IEZyb206IGJpYmVrLnBhdHJv
QG9zcy5xdWFsY29tbS5jb20gPGJpYmVrLnBhdHJvQG9zcy5xdWFsY29tbS5jb20+DQo+ID4+IFNl
bnQ6IFR1ZXNkYXksIEp1bmUgMTYsIDIwMjYgMjozNiBQTQ0KPiA+Pj4NCj4gPj4+IEZyb206IEph
Z2FkZWVzaCBQYWdhZGFsYSA8anBhZ2FkYWxAcXRpLnF1YWxjb21tLmNvbT4NCj4gPj4+DQo+ID4+
PiBUaGUgU1dJT1RMQiBib3VuY2UgYnVmZmVyIHBvb2wgc2l6ZSBpcyBoYXJkY29kZWQgYXQgNjQg
TUIgdmlhDQo+ID4+PiBJT19UTEJfREVGQVVMVF9TSVpFIHdpdGggbm8gY29tcGlsZS10aW1lIGtu
b2IgdG8gYWRqdXN0IGl0LiBPbg0KPiA+Pj4gbWVtb3J5LWNvbnN0cmFpbmVkIGVtYmVkZGVkIG9y
IG1vYmlsZSBwbGF0Zm9ybXMgZXF1aXBwZWQgd2l0aCBhDQo+ID4+PiBoYXJkd2FyZSBJT01NVSAo
ZS5nLiwgQVJNIFNNTVUpIGNvdmVyaW5nIG1vc3QgRE1BLWNhcGFibGUgZGV2aWNlcywNCj4gPj4+
IHJlc2VydmluZyA2NCBNQiBhdCBib290IGlzIHVubmVjZXNzYXJpbHkgd2FzdGVmdWwg4oCUIHRo
ZSBTV0lPVExCIGlzDQo+ID4+PiBvbmx5IGV4ZXJjaXNlZCBmb3IgZGV2aWNlcyB0aGF0IGJ5cGFz
cyB0aGUgSU9NTVUgb3IgaGF2ZSByZXN0cmljdGVkDQo+ID4+PiBETUEgYWRkcmVzcyByYW5nZXMu
DQo+ID4+Pg0KPiA+Pj4gSW50cm9kdWNlIENPTkZJR19TV0lPVExCX0RFRkFVTFRfU0laRV9NQiwg
YW4gaW50ZWdlciBLY29uZmlnIG9wdGlvbg0KPiA+Pj4gKHJhbmdlIDHigJM2NCBNQiwgZGVmYXVs
dCA2NCkgdGhhdCBhbGxvd3MgcGxhdGZvcm1zIHRvIHNldCBhIHNtYWxsZXINCj4gPj4+IGNvbXBp
bGUtdGltZSBkZWZhdWx0LiBJT19UTEJfREVGQVVMVF9TSVpFIGlzIHVwZGF0ZWQgdG8gZGVyaXZl
IGZyb20NCj4gPj4+IHRoaXMgdmFsdWUgd2hlbiBDT05GSUdfU1dJT1RMQiBpcyBlbmFibGVkLCBw
cmVzZXJ2aW5nIHRoZSBleGlzdGluZw0KPiA+Pj4gNjQgTUIgZGVmYXVsdCB3aGVuIHRoZSBvcHRp
b24gaXMgbm90IGNvbmZpZ3VyZWQuDQo+ID4+Pg0KPiA+Pj4gVGhlIHJ1bnRpbWUgInN3aW90bGI9
PG5zbGFicz4iIGtlcm5lbCBwYXJhbWV0ZXIgb3ZlcnJpZGUgcmVtYWlucw0KPiA+Pj4gZnVsbHkg
c3VwcG9ydGVkIGFuZCB0YWtlcyBwcmVjZWRlbmNlIG92ZXIgdGhlIGNvbXBpbGUtdGltZSBkZWZh
dWx0Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEphZ2FkZWVzaCBQYWdhZGFsYSA8anBh
Z2FkYWxAcXRpLnF1YWxjb21tLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEJpYmVrIEt1bWFy
IFBhdHJvIDxiaWJlay5wYXRyb0Bvc3MucXVhbGNvbW0uY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiBU
aGUgU1dJT1RMQiBib3VuY2UgYnVmZmVyIHBvb2wgc2l6ZSBpcyBoYXJkY29kZWQgYXQgNjQgTUIu
IE9uDQo+ID4+PiBtZW1vcnktY29uc3RyYWluZWQgcGxhdGZvcm1zIHdpdGggYSBoYXJkd2FyZSBJ
T01NVSAoZS5nLiwgQVJNIFNNTVUpLA0KPiA+Pj4gdGhpcyByZXNlcnZhdGlvbiBpcyB3YXN0ZWZ1
bCBhcyBTV0lPVExCIGlzIG9ubHkgbmVlZGVkIGZvciBkZXZpY2VzDQo+ID4+PiB0aGF0IGJ5cGFz
cyB0aGUgSU9NTVUgb3IgaGF2ZSByZXN0cmljdGVkIERNQSBhZGRyZXNzIHJhbmdlcy4NCj4gPj4+
DQo+ID4+PiBJbnRyb2R1Y2UgQ09ORklHX1NXSU9UTEJfREVGQVVMVF9TSVpFX01CIChyYW5nZSAx
4oCTNjQgTUIsIGRlZmF1bHQgNjQpDQo+ID4+PiB0byBhbGxvdyBhIHNtYWxsZXIgY29tcGlsZS10
aW1lIGRlZmF1bHQuIFRoZSBydW50aW1lICJzd2lvdGxiPSINCj4gPj4+IHBhcmFtZXRlciBvdmVy
cmlkZSByZW1haW5zIHN1cHBvcnRlZCBhbmQgdGFrZXMgcHJlY2VkZW5jZS4NCj4gPj4+DQo+ID4+
PiBCZWZvcmUgKGRlZmF1bHQgNjQgTUIpOg0KPiA+Pj4gwqDCoCBbwqDCoMKgIDAuMDAwMDAwXSBz
b2Z0d2FyZSBJTyBUTEI6IGFyZWEgbnVtIDguDQo+ID4+PiDCoMKgIFvCoMKgwqAgMC4wMDAwMDBd
IHNvZnR3YXJlIElPIFRMQjogbWFwcGVkIFttZW0NCj4gPj4+IDB4MDAwMDAwMDBmYmZmZjAwMC0w
eDAwMDAwMDAwZmZmZmYwMDBdICg2NE1CKQ0KPiA+Pj4NCj4gPj4+IEFmdGVyIChDT05GSUdfU1dJ
T1RMQl9ERUZBVUxUX1NJWkVfTUI9Mik6DQo+ID4+PiDCoMKgIFvCoMKgwqAgMC4wMDAwMDBdIHNv
ZnR3YXJlIElPIFRMQjogYXJlYSBudW0gOC4NCj4gPj4+IMKgwqAgW8KgwqDCoCAwLjAwMDAwMF0g
c29mdHdhcmUgSU8gVExCOiBTV0lPVExCIGJvdW5jZSBidWZmZXIgc2l6ZSByb3VuZHVwDQo+ID4+
PiB0byAyTUINCj4gPj4+IMKgwqAgW8KgwqDCoCAwLjAwMDAwMF0gc29mdHdhcmUgSU8gVExCOiBt
YXBwZWQgW21lbQ0KPiA+Pj4gMHgwMDAwMDAwMGZmZGZmMDAwLTB4MDAwMDAwMDBmZmZmZjAwMF0g
KDJNQikNCj4gPj4NCj4gPj4gVGhpcyBtZXNzYWdlIHNlcXVlbmNlIGlzIHN1cnByaXNpbmcgdG8g
bWUgLS0gdGhlcmUgc2hvdWxkIG5vdCBiZSBhbnkNCj4gPj4gcm91bmR1cCBpZiB0aGUgZGVmYXVs
dCBzaXplIGlzIDIgTWlCIGFuZCB0aGVyZSBhcmUgOCBDUFVzLiBJIHJhbiB0aGUNCj4gPj4gcGF0
Y2gNCj4gPj4gd2l0aCA4IENQVXMgYW5kIHNldCBDT05GSUdfU1dJT1RMQl9ERUZBVUxUX1NJWkVf
TUI9MiwgYW5kDQo+ID4+IG5vIHJvdW5kdXAgd2FzIHJlcG9ydGVkLiBJJ20gY3VyaW91cyBhcyB0
byB3aGF0IGNvbmZpZ3VyYXRpb24gcHJvZHVjZWQNCj4gPj4gdGhlICJyb3VuZHVwIiBtZXNzYWdl
Lg0KPiA+Pg0KPiANCj4gSSBtaWdodCBoYXZlIG1pc3VuZGVyc3Rvb2QgeW91ciBxdWVyeSBNaWNo
YWVsLCB5b3UncmUgY29ycmVjdC4NCj4gDQo+IEkgcmVjaGVja2VkIG15IHN5c3RlbSBjb25maWd1
cmF0aW9uIHdpdGggOCBDUFVzIGFuZA0KPiBDT05GSUdfU1dJT1RMQl9ERUZBVUxUX1NJWkVfTUI9
MiwgYW5kIEkgZGlkIG5vdCBnZXQgdGhlICJyb3VuZHVwIg0KPiBtZXNzYWdlLiBJIGRpZCBhIGZl
dyBleHBlcmltZW50cyB3aGlsZSBkZXZlbG9waW5nIHRoZSBwYXRjaCBpbml0aWFsbHkNCj4gd2l0
aCBDT05GSUdfU1dJT1RMQl9ERUZBVUxUX1NJWkVfTUIgYWNyb3NzIGEgcmFuZ2Ugb2YgdmFsdWVz
Lg0KPiBDT05GSUdfU1dJT1RMQl9ERUZBVUxUX1NJWkVfTUI9MSBnaXZlcyB0aGUgcm91bmR1cCBt
ZXNzYWdlOg0KPiANCj4gICAgWyAgICAwLjAwMDAwMF0gc29mdHdhcmUgSU8gVExCOiBhcmVhIG51
bSA4Lg0KPiAgICBbICAgIDAuMDAwMDAwXSBzb2Z0d2FyZSBJTyBUTEI6IFNXSU9UTEIgYm91bmNl
IGJ1ZmZlciBzaXplIHJvdW5kdXAgdG8gMk1CDQo+ICAgIFsgICAgMC4wMDAwMDBdIHNvZnR3YXJl
IElPIFRMQjogbWFwcGVkIFttZW0NCj4gMHgwMDAwMDAwMGZmZGZmMDAwLTB4MDAwMDAwMDBmZmZm
ZjAwMF0gKDJNQikNCj4gDQo+IFdpdGggQ09ORklHX1NXSU9UTEJfREVGQVVMVF9TSVpFX01CPTE6
DQo+IA0KPiAgICBuc2xhYnMgPSBDT05GSUdfU1dJT1RMQl9ERUZBVUxUX1NJWkVfTUIgPDwgOSA9
IDEgPDwgOSA9IDUxMg0KPiANCj4gV2l0aCA4IENQVXMsIGRlZmF1bHRfbmFyZWFzID0gOCwgc28g
dGhlIG1pbmltdW0gcmVxdWlyZWQgbnNsYWJzIGlzOg0KPiANCj4gICAgSU9fVExCX1NFR1NJWkUg
KiBkZWZhdWx0X25hcmVhcyA9IDEyOCAqIDggPSAxMDI0DQo+IA0KPiBTaW5jZSA1MTIgPCAxMDI0
LCBuc2xhYnMgaXMgcm91bmRlZCB1cCB0byAxMDI0ICgyTUIpLCB3aGljaCBleHBsYWlucw0KPiB0
aGUgcm91bmR1cCBtZXNzYWdlLg0KPiBJIGhhdmUgaW5jb3JyZWN0bHkgbGFiZWxsZWQgdGhpcyBs
b2cgaW4gY292ZXIgbGV0dGVyIGJ5IHBvc3RpbmcgdGhlIGxvZ3MNCj4gZm9yIENPTkZJR19TV0lP
VExCX0RFRkFVTFRfU0laRV9NQj0xIGluc3RlYWQgb2YNCj4gQ09ORklHX1NXSU9UTEJfREVGQVVM
VF9TSVpFX01CPTINCj4gSSB3aWxsIGNvcnJlY3QgdGhpcyBpbmZvIGluIHRoZSBjb3ZlciBsZXR0
ZXIgd2hpbGUgc2VuZGluZyB0aGUgbmV4dA0KPiByZXZpc2lvbiBhbG9uZyB3aXRoIHRoZSBkb2N1
bWVudGF0aW9uIHVwZGF0ZSBhcyB5b3Ugc3VnZ2VzdGVkLg0KPiANCg0KVGhhbmtzLiBUaGF0IGFs
bCBtYWtlcyBzZW5zZSBub3cuDQoNCk1pY2hhZWwNCg==
