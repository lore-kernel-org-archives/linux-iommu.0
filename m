Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013081.outbound.protection.outlook.com [52.103.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770972571D7
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402837; cv=fail; b=Y4xCsIqicvKDCFQ5PCu0wRkcOvtF+EsLRMZID1KYF8BBes2YWNlq8bfP49iwMzqSRlzALfrop85zdMC3eiQ8KD3GGjLGoyCpSjYAwspEtcQWDyCk1rJGQEAhMm4g2hbICH0WAM0k9gyCktAgGI5OYgsDh3KKIwWxDAMLSaX2SIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402837; c=relaxed/simple;
	bh=6OJVQZfie6Gqigdi3r482vbYdqThkNNSjlI2iqN64uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lmpREUcGb5d18RiK/SpNMZfzoJRlUsv9v+o5hfToqNYTsnIXUF86rDmTeQ/d6barKvDvdQbPX4zN5o9s8EsRwgqbHZfAKlXWvHFpPvi/cIXXqYcNalvyBBEfRjzRaaOantV1pdrldx8SQ8iUL2330vNAw35nqU2mlnk0h9//BNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SHMsP9Q2; arc=fail smtp.client-ip=52.103.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SHMsP9Q2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+YfkeioAkESHwuAMH+tQRQAGP9z1Oxh8ePqA6OwOGO/btM/hftr5TQkTX5fzosxNdrtVKS+u7pTvt6nxbDhCz3ijl6rbYB1dEgjT2kObiUpEdrD9fKXxGIv/HRZzTFxkX9/sem2nBJllnMUIjatTeE/bguSXKzRv9wxkcCNoV6FvEYEbdq5tEjSrmNk3Z2R0hRzh0uAj3Yja+oGZcHAn7zmNqMfi0mFpz0dzdrPyGsxUVfnvAuPrlmSu80YFsD/A7P0MJV9eEiakkbx49W10ywgjGJi4141ckJssxHcEe4opk6oMPCvTDttskDaNG9xPx4aQg+pkN/WPVDsrQxAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T73PYQ8ormNa+VXYN7xGbGdrRn8gQHmKt+uqHwHtHVs=;
 b=K0CDsIz2qEhORwuWkXQdJ64Ji79kdH96w+qtW4wd+Exdsya/qOXaZwOuon2K/Ye2VwlKzI9rSytCpCkjX3diBO6XgooBKlp8BWs9VkGa2ETqW7zqT1V5Wjn3TjTA4PRSQPG9gZ/PzLslfLtAHMra288k3d21s4ECjKO/L1LGNi+QsRkxALFQTFu22o2Uob+QY+KnmJ/hPkZI4lWFzNdpM+aaRNPVU6QbXmgp8zXUCUecgqIbSV5j0dTtWyIClaZTZOYHBFDf1nxatXUAM5Lx/VY0yifklpDKfWOc2ia+ag48JhS9dnWNlUuzOsMqW25nyD/B7UT+oDU6W/zN9QnrlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T73PYQ8ormNa+VXYN7xGbGdrRn8gQHmKt+uqHwHtHVs=;
 b=SHMsP9Q21VGZ+e8DHQ/nS9ygWGJ/31gN2DQDs2MP0ZYN2X/8IpCytYTwI/EI0wl3dDFUYp7nOsop3iQKtPSkoO26QQhyoFtY3erIYVREAoSpqAViZIsSs2GZGS3bU+D2dIIhVkyFYwjJrQs1mx+YYB4oCcG+r3kj7UwChBth7QCV/Bmm982V1LppdrwF+cO/iqi8WR+clDOUkgZ9qIuMjfsME5O7x1sAYwjMagArdUoZwgRmh+lRg2nkMIhacHS8wmDhdlgCtw8kC+fWQmjIe0Q1Q3ZkyKic6kkWIN3e1Ra8nnVNsJ1CtFJBeHJhQ88c2AoflZljmlfKKY0Kj7PE1Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9264.namprd02.prod.outlook.com (2603:10b6:8:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 15:53:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:53:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Du, Fan" <fan.du@intel.com>, Michael Kelley <mhklinux@outlook.com>,
	"Miao, Jun" <jun.miao@intel.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "chenhgs@chinatelecom.cn"
	<chenhgs@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Topic: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Index: AQHdAl427ISAWK+xiUOEbDzqfvGrgbZLbReAgAN3FYCAAIy50A==
Date: Thu, 25 Jun 2026 15:53:53 +0000
Message-ID:
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
In-Reply-To:
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9264:EE_
x-ms-office365-filtering-correlation-id: 4575761f-10ae-4694-4be6-08ded2d1f547
x-ms-exchange-slblob-mailprops:
 02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/g+0UZyysfj76+TUTKkwRNXld4d11vojBjWrfU/XyEARTIFvZUI0Y1sY14Lc058oXSH7y/zxlsxM/PD4VNm1PIfeqHB1XguawWAIrX+E/yDuIBYoptTu7kh7Dh6kbyYUEfxyY18NkDJmm4D1AvHjDVm60mAoOfh14iOhpoW/gGEUafdqrRWQFeZifVuJZyJ7bw2d5rimzEfwcAYdp04XyUUsL5bF7q6PevZN14EcBHLJguD6dE1oB7lvTTw8K3t/Fg1/7FxkXCGV8UpMXTa4Y/lqikc9GAN+GtG6nkreEJjxadAiib9OXmvq05aq5WmPAtWZvld3WUprzVBrjrOMiywMqCURI6XKry7nOlDp7pYnUzxspfWVvgdAymQEeFclCpesWXP7F1zXGv8xyBvEvgZXB9g9YZY8HEJmzgdgtOhSIJ4OLrjpo0r0iqOwpblcTI2LOt/UG7jGJJJKvU1Ubv6ZTBzzq/9dkpfvP36D6tctpDUj8v7alRmWR9OIRaCpYVDJfkqUw21OyMMjrSo8VrXlrOQ+R223BwzpAVpK0Mpusv7Cz5sgWrDoRk8T4zNvOxqPJFJksHUZf9BdBMz8FzGsK0t1kJr9Hvd5jSKyr+wJwCZwufNMFVk91pXbkStj0o+9J3tYRVpygQcqYhucUJTtJdy2mbEFF3DLvj1GO5Xp/TENu/zXG+b1PB6RxqW6ZNtcsocva3IpBO51hnOUIBaKe15ASrYT+
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|13091999003|19101099003|51005399006|37011999003|15080799012|25010399006|31061999003|19110799012|8062599012|8060799015|440099028|3412199025|40105399003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DP4Pu9vYI0kvBD+UESi2biVvSpuPAVpBVM0KtE6ZWpNjl8ZNPkgPdhOEnqAk?=
 =?us-ascii?Q?LHx8h3VVCkoYWzqinhyzHiniERsfjS7ygQ7ILedDM4IqZEAZ2Xs99XPs4/QX?=
 =?us-ascii?Q?cF1/8wzgVdJEWT/drb7uQmBsD02+Xse5cjQI8OaABFuglrQ9VkbVU9OvvaXT?=
 =?us-ascii?Q?C/kOVG7s2/rnVoLi8tTXt8kZSNYA/pKHMtaEb1KZTslARGl4T35ZDpd28fnv?=
 =?us-ascii?Q?N0UrqLEbjKHzTiaYCyCgF225lIexl3EHsGq8/t5HMB1ap/Hv7Yzk15LYyiLY?=
 =?us-ascii?Q?CehWxI/CZJWfLbRvm/FNxfjlxv7vAEY86n8pDDDDkEgA8QgJwij9ASyqTX11?=
 =?us-ascii?Q?pKiWZwUPO6UEWEwkDS2cR4rM2Y394LqUf/bHBV0LpglemVGGml8Yv9g9VVLa?=
 =?us-ascii?Q?IBzEflLFoh8fqDRX3193fD236Nx8Asnee7ZG1kK28ZdmzeTDyOTsEWBBlzni?=
 =?us-ascii?Q?npK00Y1XCjXwPHi33/Y1wXV59CoE2ZAW0ET1XgJm4MUurQPTSDP+CMXF3JjO?=
 =?us-ascii?Q?5oHDFNfDFQNiUneDpekLGH3jxPDsi/BFxOqmAs0VsxCrC7pydijXRPfdo1eW?=
 =?us-ascii?Q?rcH50Bpjc+bFJXVndfJOJOhTvNeAfNtyL6UjYxUXPYbtvrxo72SW9NEM4AIY?=
 =?us-ascii?Q?065hd22zeUloLG1m3jNAzhY255XBONR+YqnF5u5CUmjfrwZeYMaI9rx/VX3e?=
 =?us-ascii?Q?CVT01blv7VBvQIWtTUsy8kgwAdmT+s38w6YzbC7izTPV85keZRdKP5Q6/XLR?=
 =?us-ascii?Q?/Kc07JXvDQmZRYCTQ8fZ5Wob7pO21uYYWclhOT/qGLZ1QGcNsrudffbtwUtI?=
 =?us-ascii?Q?vssOXc9cNyGd5wp8dQysonqGqnuzjpzMdF7wKooWqayn/HId0pea5ta6n/wn?=
 =?us-ascii?Q?F4MvhshkSjCH5tnBe3/QTk+/1VfW4VyR6pHqk/b7ZLzh7Um/D/UVYfmHUhRR?=
 =?us-ascii?Q?AjF9SfwecU0FCe9aYHJgnUg7bu1NqUBK2YVhZOpOlcX5LtNHKE2+1Dc7p/tR?=
 =?us-ascii?Q?JI/nH2YD1AV46lBcNIuwqtiV8CotSFFHNMznQF6oQSYo9tUXYb3BDBjhOY4i?=
 =?us-ascii?Q?reDHEoDC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XidlHQrFAUxzapUz1SRAlz/brzWN/xFUJj6sYgF9kqNtIGSQLk1GIPOTjD9n?=
 =?us-ascii?Q?WUMh13omc0SBl69z9RxzLA7dA8Py85saoqP4ThFlWc6OKKW+ygG6P+CW5+IJ?=
 =?us-ascii?Q?GzYY6Y4vL/lgp8c0hQK+1StaYn9XALlmVf83y9++iNU4GkOo+rcknBVEYSd7?=
 =?us-ascii?Q?h6m7BpYFJfbwrIqQKYY12em9WnzW8LrMH7RuUkv0EB1mQsI7XeWNH8SwOa3m?=
 =?us-ascii?Q?CDEtY9x8fNSkA/k9VDn586HuqMS55P1mJdJgfzjJn0quFFHTiob3j5fI0ADH?=
 =?us-ascii?Q?HGX/AoUSa7lytTbkt8H9eUPVEBB+jWkxzDP4Zsy0vPt55p5Uut3b6LJvFxW0?=
 =?us-ascii?Q?8J+qLmxcP3gwT0/gbAswzAMlI7zpZoOXhYKuTZVCj6AK0oO9DAhA8OmaLwes?=
 =?us-ascii?Q?clKXsVSgyaSUOLKPiaYbMamOPaS5wjMxcKd3k5M5pHdclK0N/7UZMUOh+T1q?=
 =?us-ascii?Q?dU8/RgcdfAVdnfHgWSvOQhhVkbvsj/Rho+U8HiqaL9MteX+zJh/f5//diTk4?=
 =?us-ascii?Q?FbL7LrdtEJgxq8GqeUw1ZTBm7qlF6eXxdxLL9B9KnOQNAwIfNniQaWWzLpVV?=
 =?us-ascii?Q?e606N5v2Uy8bEqAGmCS7I20UO8XRG0unZOl6vs5vuXNUMIHAkgNVko1PJxc+?=
 =?us-ascii?Q?dzn9iuofl6QyPhSWpxx5yVCsb8WA14PKYzLolqH8grDptexuX90jHJdmsWt9?=
 =?us-ascii?Q?Gcl4mYrD2/8aFxtDxmd3GKHsHin8LLRW93QQ2s3lxWsfo01MYEdxkrnp6nnP?=
 =?us-ascii?Q?8aF1smtUnNZw/EVOkxAL9DtRjG1YRAf0Gh/7QTduMVIpnhxrvCMSU9o9oHxh?=
 =?us-ascii?Q?1LirIhjP+pbKs0DOH533QV1cYXuvp7vhAp0kFR+LgznzTnyYCO1+w+2H4smA?=
 =?us-ascii?Q?gee/t0vtNRyOgxryikuTEtRqJXxVA46wxtAnFUGdxvvyIMFXilIeVnI1frnI?=
 =?us-ascii?Q?QQvIbLiXVtZMQoeR303u8A80Qcyp/RB2XtRKt7U3DU2kxsTxHROcwQed6oKb?=
 =?us-ascii?Q?C3ugX5vBW7MhwWskWs90sSxjF3dzLyDYCApsgrTpbLQF6P64d22DDW2/IBRg?=
 =?us-ascii?Q?CFf0eDNfGsDtGzvs9J7p6Kdlxxr+TGiVqbjA0zrluWjmS86so13P/Ka71h+w?=
 =?us-ascii?Q?zWrFFAdw/Wsge/junP3BaQuz/LMH7OwH+vjbbIJSXQP43cZN/yOqjHxEZOKH?=
 =?us-ascii?Q?NaKx9BCqyYVZmSyUaymrcUE9/NUCeSbp571zQE/CyDGiDlXAO5LGR2e96sfv?=
 =?us-ascii?Q?bnIxNCB6tcSlNcKb7exWquYUxzB9QEgjbI9arcidZW14hcds/65N0xiMOZjH?=
 =?us-ascii?Q?J90TmC2b/j+UxCeUmpgZ9cPB9RRs/sLFBBXpkU5iSyZCCwI+kH3iT+DnZ/F2?=
 =?us-ascii?Q?KNhmVJw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4575761f-10ae-4694-4be6-08ded2d1f547
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 15:53:53.7871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9264

From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 12:30 AM
>=20
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Tuesday, June 23, 2026 10:35 AM
> > To: Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> > robin.murphy@arm.com
> > Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; Du, Fan
> > <fan.du@intel.com>; LKML <linux-kernel@vger.kernel.org>
> > Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> > used/hiwater tracking
> >

[snip]

> > > +	pool =3D &mem->defpool;
> > > +	for (i =3D 0; i < pool->nareas; i++)
> > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> >
> > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The approach
> > of calculating a separate hiwater mark for each area, and then summing
> > those per-area hiwater marks, can produce very wrong results.
> >
> > Consider a 64MiB swiotlb in a system with 8 CPUs. There will be 8 areas=
,
> > each with 8 MiB of space. Suppose the workload putters along with mostl=
y
> > smallish I/Os, say between 4 KiB and 32 KiB. If each area has 16 I/Os i=
n
> > progress, the area hiwater mark might be 256 KiB (16 I/Os averaging 16 =
KiB
> > each). Summing across areas produces a hiwater mark of 8 * 256 KiB =3D =
2 MiB.
> > But then suppose a 2 MiB I/O comes in. The hiwater mark for the area th=
at
> > handles that I/O will grow to 2+ MiB. After the first big I/O finishes,
> >  another 2 MiB I/O comes in that is handled by a different area, whose
> > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have a hiwate=
r
> > mark of 2+ MiB, and the total hiwater mark is reported as 16+ MiB. The
> > old algorithm would have reported 4+ MiB, which is accurate. With
> > higher CPU counts and more areas, the discrepancy can get much worse.
> > This is a somewhat contrived example, but the problem is real enough
> > to make the reported hiwater mark be unreliable.
>=20
> You are correct here, I like your way of thinking.
>=20
> > I'm sure the contention for the total hiwater mark in the current code =
is
> > real, but it's in the context of a lot of other CPU work that is being =
because
> > of the bounce buffering, including copying lots of data to/from the bou=
nce
> > buffers. Is that atomic increment operation a bottleneck even in the
> > end-to-end context of doing DMA through swiotlb bounce buffers?
>=20
> Practical benchmark show case the highest IO performance for each TVM spe=
c.
> even if a few iperf (4)workers would cause the contention here.
> My guts feelings, yes, the real workload probably hit the bottleneck here=
.

Just curious -- what is the NIC in the TDX VM? I'm most familiar with the
Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That driver
uses dedicated send and receive buffers that are allocated and decrypted
when the NIC is configured. Most NIC traffic goes through those buffers
instead of the swiotlb, so I probably haven't seen cases where the swiotlb
is the bottleneck for NIC traffic. I do see the swiotlb as the bottleneck f=
or
disk I/O traffic, but the data copying tends to be the gate rather than the
allocation and freeing of swiotlb buffers.

>=20
> > Another approach to the contention problem would be to have a separate
> > CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
> > computation of the hiwater mark can be dropped entirely in production
> > environments. Or the setting could be dynamic at runtime via a
> > static_call, defaulting to not computing the hiwater mark while still
> > allowing a sysadmin to turn it on to see workload usage of the swiotlb.
>=20
> That's counter-intuitive from my perspective.
> With global counters, the observation, which itself impacts the performan=
ce,
> wouldn't be able to tell the practical characterization, that's commonly =
lower than
> max performance, in turn breaks the semantics of what's it for.

Agreed. If the global counters affect the performance and throughput
significantly, having an accurate hiwater mark loses some of its value.=20

>=20
> Even without those global counters, if user wants to know the hiwater val=
ue,
> snapshotting used value(sum of each area as current behavior) periodicall=
y would
> produce meaningful value for workload evaluation.

I'm a little skeptical of the value of just summing current usage. Doing so
tends to miss any spikes, and the spikes are the problem. If swiotlb capaci=
ty
is exceeded even for a short spike, you don't just get a performance blip.
You get I/O failures, which at least on the disk side tends to be fatal to =
the
application doing the I/O. Maybe the networking stack recovers well enough
and retries, resulting in just a performance reduction. But I've always tho=
ught
of swiotlb exhaustion as a fairly serious problem to be avoided at all cost=
s.
That's why CoCo VMs allocate so much swiotlb space, even though most of
it is never used for typical workloads (at least in my experience).=20

Michael
