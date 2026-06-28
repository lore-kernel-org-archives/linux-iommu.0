Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012014.outbound.protection.outlook.com [52.103.14.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B47081E
	for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782610221; cv=fail; b=Sy5hm0sRn/7ka7st8IrAEMs4CIO+S4FTX9RfI5ZO8ltLBaHeKEMpxjNzumYL0QtWyii7f/xzOEOGFjXBFS4Vf1R7fWA1C/QlYpmi1JbR3/ZkpB9iclkxjqistmJ/R1U2rUciFATjsCrVF3xmbFFbECx89xicgvelPIukT8swFfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782610221; c=relaxed/simple;
	bh=Eq1fwDN2tAcoDxiRrHeuyZuU0J6eNUHGOa3GxCO4klI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vGJ+mPTO5Ph1pg0xNL//NhTFNany7DpAk5Uva0Qr0OZe0CFK5ZpAPz7q6xy5vFneHeYe6IZmR76XYHfHV7iybzM+Ec7MvooiqesUrVuGsWWeYOZcZuRcPQlWFv7t+6DJljh3Gt6qWBh+dOFQsvKXMlt9z13oZwy0/g4eDTPw5q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fdaK2gXg; arc=fail smtp.client-ip=52.103.14.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fdaK2gXg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWnmZcjgtz0UQWEvQwv6as1AJqp5hmmwGR2oI2ePBoQFbstWTzlYW3Hures7sek/XOwPgaMyhbOQ8kkUgkWg+pSinUwYyTq0gL0VqkzHDBNnf0/NWGQudt9KLMSESHBx4NO1ZZ6snhjqf7czChQJFPnzJs+gG53egm2An+j1ZcFcG3tzAAHI0lIV6bBpir2uR4G44s1r7gsTacogJlGEQ44X/X+hN8YrS90pCuDJQIbc59rJDmKaS/pDoKtkKcVWM4wAoSTismVta82LfWuP2+Jy5wUASk/2WA7EJUXNQjW6ZkL6OP/PpZavz6J9mo8fWjqOYBJnHZA1w0xgUigUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDEhqw2dRjn3s1/muZv+UQgWQ34eFzzd0xiKVHD2vIk=;
 b=Txxw3fFrqvKdcCrwDv33PeT1BtltwBQNn/EE7+/uljfh0zvm7bedXbGwUKpdfHjCGfLnnPu5TR0eEEPP0TJBIW41wtECT3A+lo+/LMsQVH4M7QSoek6JsJYGM+V+ucBTYxw9pIRqTH/D1kH8DnCnrWdo0WEh/RwgHQezQZAGUXi8UnStsX+ClG2LYgqCzgFD+mlD29t68IqvVCJ5T+x7wk/a85iI4g4eWMVFJEyqr4ibjebJcck6WVvbwZvws8AuCJhR4tl1DXE0gCy6IbgvAFTBoRjPErpsP0SoOotgwGZXokzA3UPOmbpjvdaj5BXs5KmTy+AXHcPxkLFJiIAttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDEhqw2dRjn3s1/muZv+UQgWQ34eFzzd0xiKVHD2vIk=;
 b=fdaK2gXgQMCi7T/qO6Vk5AkWi9u5/ZWUT5r+ZKi4OQ9AtwLDH5KN4iymhOQ3hCz1vzVjIIoxjra679joxj75XYIN0wWDaMJzQYjbJ6nPWmWR+Wg8Cwp1ehIhAgAGXogP8F/Q2F0gSUhFBEUPzt/nlVCo9TX2B3pt+gvy1f5xpZrI1OHB3yp2X2mNwKCYWnAnn9gWL4Fm7XcMzDKkRmLwqiRKwA2KJ2PWBKOW4uTRs/MSYX4LBfGdE6s+TjXhnYhtHWTOPfuIjMERZ6+0Dp3yubXkW0gjlY5YbmWyvXnhOYwrfphw2fR4X+Z8Bf2bU3Snh2EQpRgS4tED5HbNUmIkFw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB11612.namprd02.prod.outlook.com (2603:10b6:8:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sun, 28 Jun
 2026 01:30:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 01:30:14 +0000
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
Thread-Index:
 AQHdAl427ISAWK+xiUOEbDzqfvGrgbZLbReAgAN3FYCAAIy50IAAvYmAgADWmfCAAg1oAIAAJCig
Date: Sun, 28 Jun 2026 01:30:14 +0000
Message-ID:
 <SN6PR02MB4157CD254526EE6A93FC5B28D4E92@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB84984BB3EE01F44D466EE39E99EA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
In-Reply-To:
 <SJ2PR11MB84984BB3EE01F44D466EE39E99EA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB11612:EE_
x-ms-office365-filtering-correlation-id: d2d4e424-6190-414b-efab-08ded4b4cde4
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|13091999003|19110799012|8062599012|8060799015|19101099003|51005399006|25010399006|31061999003|40105399003|102099032|440099028|3412199025|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hRu+khfJ5CMTSpBwrv/Tfu/lsRZQw5ELGp5VVFmmSHTOUUsitJrR3Y8jVDff?=
 =?us-ascii?Q?lbXLYPFepJBT9wuuIVn/C4IEKp1KUyk7sqAS7pmr5ZoY50TK7JDkjt2dr+Rf?=
 =?us-ascii?Q?rp+fCHa1W0AG9guKq9UAvPfpq9IoO3Y6FJf29Q0csLz0QLsQWTpBWBrorHDU?=
 =?us-ascii?Q?BPQlrpz5DkGybiNtnCKGPvo00FdAOt/knnXq7Ijbb/D5klwL9DZyT5lJPWnN?=
 =?us-ascii?Q?ODyePnAup0yTkTMQHAAYxvkXVEkGJdPyQt1h8KZpGE/Ua9M3c1f7ZaxcW4FK?=
 =?us-ascii?Q?ULiKHkGYOSpi/Z1p5A0x5xNcwVkIQWT3Sy6KiIdoCiGY2VbJ+7zKpSv/kMjQ?=
 =?us-ascii?Q?9k0ZZY3dxHX0GoWGkfijmRMBLZ3TdZ10qE1IOY2oV1hk3I96a1dSfB3YCauM?=
 =?us-ascii?Q?nnbF7J8rMnXnV8cX+MvQE1fG/Xj50mfvDlcx11b1/q8RuNH2jPt3spROQjJC?=
 =?us-ascii?Q?aMCk/vqbLCLAglljpVnfesxfDFNVXIZVp/8V34ugnjhq354NYHNbaTnsdaGy?=
 =?us-ascii?Q?LcoIRj8qifjAc1rTRzTOdXi1g7d0SWLrzl2dA542b+ZFWA2c5aJaxThDwAP1?=
 =?us-ascii?Q?04zqs2o+SylzSVfyxXe7HM98jF6/V4RpZYBO4mwKaKVmKlYpTIv3ixcWz89B?=
 =?us-ascii?Q?qy/CtphK9Rt60aOLJ+SqWoi2FBmm9mqWW6/4ZiyWx5fRizbQ0hvzIWkYBKib?=
 =?us-ascii?Q?IBrBSWE03A7dGZBKN7dMNoS7YUjFBRy+wuoqO9M8DnVq5JMuiTAN0ZANSA4C?=
 =?us-ascii?Q?bU0zI/A9NwOVlXRl1mhcc9NUfyfjOD6RMDcxlZ1NrFMt60miaxVBSidVkMAm?=
 =?us-ascii?Q?x6XsyDbxd/nykK1Y8rlzTNXQBdN0G/tPiNjoekbIhkjRVOvnLLQcwEbzhrOs?=
 =?us-ascii?Q?6NR9HfWR3IYA7v9ICsfww3O84oKP/OMgTxr6xJvmhDb7XapmpSM/dZcRwcgy?=
 =?us-ascii?Q?JAwfM2jkntTT/BGUK9Mhjvi1br+0EsnxuoWhfIi+bDcWnr+HWekfVCjieGDt?=
 =?us-ascii?Q?LhSwOEt5+koq0LUHIN8pBrAuOw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/vGAduxK7REwDuySTl72kLweYRFXi1/bb3qNuOjmoiBQz7FWZZVB++z4ZvA0?=
 =?us-ascii?Q?yREtFJH4KL0S3xdplcq4ustf2slApPeCt1V1GMvIwIebAikSuVyOwPrLFqTc?=
 =?us-ascii?Q?jGF7AaM4uu1RhSBx/8aDl+8csdtoUWaknUjE2pV0GG6tw+RW0JXU4dKqCl5N?=
 =?us-ascii?Q?YLv4LG9Ix8xq/d8HbY80RfpxzbcC3jTFfORH7uA4bf/v01UGgt9k6NDIELK8?=
 =?us-ascii?Q?kWZxEkpi05SGdiIzXrxAAPusgbJEa3UEUcUWkna25wZw5gwHFCiMhIQ3VLu9?=
 =?us-ascii?Q?/CJ1G+K84S4lhX1rNUv6zbDHJtdJelglDc/xv5rhYE/qAH2NDeMaSwCrUNIP?=
 =?us-ascii?Q?sn9Q2RGWrvHYwv1EfLtbWWK56naBjQ/0dpLo+Qfl6LuQCyeDL+Lk4apDUXIt?=
 =?us-ascii?Q?nVlt19uM1c5+u7Aps+bdtvHTt13HcCcgCCWa6bw3F16bDl3v6H1aF2HKoxPP?=
 =?us-ascii?Q?SgFG2/G/rKJGC/7sVzsRvOghFn2K19BJP7nsTf/RhwtExqERvNYKqzGyM8i8?=
 =?us-ascii?Q?kUrbKRT/CkRNOCbcGmD1K+ImcqQl71GQVxChWdLnPOwMosBYkFp3Ldkf/+fP?=
 =?us-ascii?Q?vJuZgzitO9iRO0oZ7ahBKAZCdMnpQnHcaDTSshVA6E7GeyKZN3jESNRa0hqW?=
 =?us-ascii?Q?3UgDtCTlWbrnAHwfH7o/GbE3fnYLXZtz0ca001m5EjYKprK4D41lRWl5MPI1?=
 =?us-ascii?Q?WhZg5At8yYBS7NpxhBpj7wyE0DZd/pxkTcN5y0SJ9JvcZ3Oz5dsSBFYX7+iF?=
 =?us-ascii?Q?ltuWwDRgzmkNJjbsWZDZP9Tten1zVTN6f9bCOlVAkM9ETRuZffXyV5S+tiGq?=
 =?us-ascii?Q?Z0BNbgzB9O2rEtQWwcoOWq5VYim2aT+STWC917YYSMthx3VEdnsFPFC8jdi+?=
 =?us-ascii?Q?tvlVlPdCZNFYRYG5TXfm4fX7QZOo1PBR3NilSDbcsudk5rnKs9aULlZ2bXBl?=
 =?us-ascii?Q?v+Np509e++YUiITccUt2rwJA+qVcsOapUxQD/ae+NwMcXS2ImoBdSOoxhtco?=
 =?us-ascii?Q?5I4sx3lUp1HC7V/x57ALB6lqzy2P7uLYH83UWZiBr4srjr9IGIqma4teEnVK?=
 =?us-ascii?Q?zlDDKWjGG4qriw7reqQBhQ6R+85Q42RsSrQJYrkTiDi/9SGu1z9ONJZ1PHGb?=
 =?us-ascii?Q?s/1us9qQEvZ1c2wYzE/aYMKGN7Jsk64Q55l8QgtyWVbJ1cHb7qvUmCEoJfD/?=
 =?us-ascii?Q?jBxdJJHu7LArJyO4S005iIKstTWZ1FmAOcFaDQAL8Ac7oYaoKbLFJRpu2Q6O?=
 =?us-ascii?Q?IaF1kFp4TWOIAHkj/xPpI7h0blL+58uKp6RKwwWuLHPryKBLbQ9CyGAoLEqD?=
 =?us-ascii?Q?6K1Sn9VY1XPNkkZ6pM402oQ5jyCnQqiVJaA1E6Rj53qVsf49sUrcozZJK7bP?=
 =?us-ascii?Q?tbPAtHA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d4e424-6190-414b-efab-08ded4b4cde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2026 01:30:14.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB11612

From: Du, Fan <fan.du@intel.com> Sent: Saturday, June 27, 2026 4:21 PM
>=20
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Saturday, June 27, 2026 12:00 AM
> >
> > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 8:12 PM
> > >
> > > > -----Original Message-----
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > Sent: Thursday, June 25, 2026 11:54 PM
> > > >
> > > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 12:3=
0 AM
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > > > >
> > > >
> > > > [snip]
> > > >
> > > > > > > +	pool =3D &mem->defpool;
> > > > > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > > > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > > > > >
> > > > > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The appro=
ach
> > > > > > of calculating a separate hiwater mark for each area, and then =
summing
> > > > > > those per-area hiwater marks, can produce very wrong results.
> > > > > >
> > > > > > Consider a 64MiB swiotlb in a system with 8 CPUs. There will be=
 8 areas,
> > > > > > each with 8 MiB of space. Suppose the workload putters along wi=
th mostly
> > > > > > smallish I/Os, say between 4 KiB and 32 KiB. If each area has 1=
6 I/Os in
> > > > > > progress, the area hiwater mark might be 256 KiB (16 I/Os avera=
ging 16 KiB
> > > > > > each). Summing across areas produces a hiwater mark of 8 * 256 =
KiB =3D 2 MiB.
> > > > > > But then suppose a 2 MiB I/O comes in. The hiwater mark for the=
 area that
> > > > > > handles that I/O will grow to 2+ MiB. After the first big I/O f=
inishes,
> > > > > >  another 2 MiB I/O comes in that is handled by a different area=
, whose
> > > > > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have =
a hiwater
> > > > > > mark of 2+ MiB, and the total hiwater mark is reported as 16+ M=
iB. The
> > > > > > old algorithm would have reported 4+ MiB, which is accurate. Wi=
th
> > > > > > higher CPU counts and more areas, the discrepancy can get much =
worse.
> > > > > > This is a somewhat contrived example, but the problem is real e=
nough
> > > > > > to make the reported hiwater mark be unreliable.
> > > > >
> > > > > You are correct here, I like your way of thinking.
> > > > >
> > > > > > I'm sure the contention for the total hiwater mark in the curre=
nt code is
> > > > > > real, but it's in the context of a lot of other CPU work that i=
s being because
> > > > > > of the bounce buffering, including copying lots of data to/from=
 the bounce
> > > > > > buffers. Is that atomic increment operation a bottleneck even i=
n the
> > > > > > end-to-end context of doing DMA through swiotlb bounce buffers?
> > > > >
> > > > > Practical benchmark show case the highest IO performance for each=
 TVM spec.
> > > > > even if a few iperf (4)workers would cause the contention here.
> > > > > My guts feelings, yes, the real workload probably hit the bottlen=
eck here.
> > > >
> > > > Just curious -- what is the NIC in the TDX VM? I'm most familiar wi=
th the
> > > > Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That driv=
er
> > > > uses dedicated send and receive buffers that are allocated and decr=
ypted
> > > > when the NIC is configured. Most NIC traffic goes through those buf=
fers
> > > > instead of the swiotlb, so I probably haven't seen cases where the =
swiotlb
> > > > is the bottleneck for NIC traffic. I do see the swiotlb as the bott=
leneck for
> > > > disk I/O traffic, but the data copying tends to be the gate rather =
than the
> > > > allocation and freeing of swiotlb buffers.
> > > >
> > > > >
> > > > > > Another approach to the contention problem would be to have a s=
eparate
> > > > > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so that th=
e
> > > > > > computation of the hiwater mark can be dropped entirely in prod=
uction
> > > > > > environments. Or the setting could be dynamic at runtime via a
> > > > > > static_call, defaulting to not computing the hiwater mark while=
 still
> > > > > > allowing a sysadmin to turn it on to see workload usage of the =
swiotlb.
> > > > >
> > > > > That's counter-intuitive from my perspective.
> > > > > With global counters, the observation, which itself impacts the p=
erformance,
> > > > > wouldn't be able to tell the practical characterization, that's c=
ommonly lower than
> > > > > max performance, in turn breaks the semantics of what's it for.
> > > >
> > > > Agreed. If the global counters affect the performance and throughpu=
t
> > > > significantly, having an accurate hiwater mark loses some of its va=
lue.
> > > >
> > > > >
> > > > > Even without those global counters, if user wants to know the hiw=
ater value,
> > > > > snapshotting used value(sum of each area as current behavior) per=
iodically would
> > > > > produce meaningful value for workload evaluation.
> > > >
> > > > I'm a little skeptical of the value of just summing current usage. =
Doing so
> > > > tends to miss any spikes, and the spikes are the problem. If swiotl=
b capacity
> > >
> > > That's current design when CONFIG_DEBUG_FS is off, and used as swiotl=
b
> > > shortage indicator for user.
> > >
> > > Statistically that sampled value is approximate to the true value as =
always.
> >
> > OK, yes, statistical sampling could work. The kernel queues a work item
> > that runs periodically to sum current usage across all areas. That sum =
is
> > compared against the previous sum to calculate a hiwater mark. An
> > experiment to compare the statistical hiwater mark against the current
> > exact calculation would be interesting. I wonder how many samples would
> > be needed, and hence how frequently it would need to run, to get a good
> > result.
>=20
> Kernel doesn't do that sampling, kernel only report the sum as user space=
 requested.
> Take a look at the flow when DEBUG_FS is off, and essentially it works as=
 vmstat,
> user set query interval.

Agree -- the kernel doesn't do that now. I wasn't clear in my comment that
I was envisioning that the kernel *could* be enhanced to do the statistical
sampling and report the result via sysfs.

>=20
> > >
> > > > is exceeded even for a short spike, you don't just get a performanc=
e blip.
> > > > You get I/O failures, which at least on the disk side tends to be f=
atal to the
> > > > application doing the I/O. Maybe the networking stack recovers well=
 enough
> > > > and retries, resulting in just a performance reduction. But I've al=
ways thought
> > > > of swiotlb exhaustion as a fairly serious problem to be avoided at =
all costs.
> > > > That's why CoCo VMs allocate so much swiotlb space, even though mos=
t of
> > > > it is never used for typical workloads (at least in my experience).
> > >
> > > That's dynamic SWIOTLB is designed for.
> > > Only when the IO is so intensive, transient buffer/DMA pool is exhaus=
ted quickly
> > > before new shared memory pool is created.
> >
> > I don't think dynamic SWIOTLB in its current implementation is very use=
ful
> > for large CoCo VMs. Exhausting the atomic DMA pool is one problem. The
> > dynamic swiotlb also can grow in a max of 4 MiB increments, so if 400 M=
iB is
> > added dynamically, there's a list of 100 entries that must be searched
> > to find space (and that list is currently searched linearly). Furthermo=
re,
> > the pre-allocated swiotlb gets 1 area per CPU, which mostly avoids cont=
ention
> > on the area spin locks. But a dynamically added 4 MiB pool can have a m=
ax of
> > 16 areas because each area must be at least 256 KiB. So there's more ar=
ea
> > spin lock contention with higher CPUs counts. And that all assumes that=
 the
> > memory allocator can provide a 4 MiB contiguous area for the new pool. =
If
> > the swiotlb needs to grow after there's been memory fragmentation, an
> > added pool might be limited to 2 MiB or 1 MiB or smaller, with a
> > corresponding reduction in the area count and increase in area spin loc=
k
> > contention. Overall, dynamic swiotlb in a big CoCo VM results in comple=
x
> > and messy behavior with new failure modes and bottlenecks.
>=20
> Fragmentation indeed undermine the requested allocation size as dynamic
> swiotlb grows by default 64M .=20

Actually, I don't think the dynamic swiotlb ever grows by 64 MiB, at least
not for systems with a 4 KiB page size. Yes, swiotlb_dyn_alloc() requests
a new pool with size "default_nslabs", which might be 64 MiB. But the
memory ultimately comes from the buddy allocator, which can provide
a maximum of 4 MiB (unless MAX_ORDER has been overridden).
swiotlb_alloc_pool() tries 64 MiB, which fails, so it then tries 32 MiB,
etc., until it gets down to a size that the buddy allocator can provide.
The most it will get is 4 MiB, and perhaps less if memory is fragmented.

Michael

> In production practice, for large TVM, we see admin will reserve
> majority of needed size, and let dynamic swiotlb works to add additional =
buffer.
> Current dynamic switlb doesn't support shrinker to release unused memory =
back
> to buddy yet.
