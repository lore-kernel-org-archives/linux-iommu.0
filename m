Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012011.outbound.protection.outlook.com [52.103.14.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CBE3BBFCA
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546900; cv=fail; b=PjdtmkNaldaFH5Oi1QHBOyPcOkcphk2WevWTI/woyXIyqrd7WgdyIVRM6JaB+stdlEM/qCeaLVrsGpkp8rXGaeyk2LcEuaV3RFpRaBfZntM7if12oQB3f6GSX4lz1Yac/+IQ8gP56Fkncu+ipC6RxH0bi8VAeSTbfTjCWe7zbOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546900; c=relaxed/simple;
	bh=9Nn7FTpdKoDFy0sKgk2SP38sSgxrH+4QUXTJHe4yyMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TDAC6aecHKrGtAOpg2bwa9eYF12LRpPpR/tuO/7S4cxY8O1/P2R0/iw61y27bu3/JuUTMsLkIbOrPNWZ2nWLKsFgGLW2NeSPqyvTZ14XFWKaz/Zyhz+PPxRpEvFl2jNJoRY0SKvdlfVm/+fnKcJ1q70Kp+8dgs6eRXLs+6GUqmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MzzG6whW; arc=fail smtp.client-ip=52.103.14.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MzzG6whW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC5y/2zbFhyfPd/I5Do6+eFCqzdfDXp62LhwrTSXtpvOKA/nt+mjZNBh0FJz86PlLIllfo7whkdmDEdl32OKtjiYjlZf3ZH4dRRI/YPyJgpD9zgfug2BvwgMoBqLRk6a6hSJLSVAMhnX0hJkKgEBBOHP12lMW9M3FD/s83KeDVQ2oinOk0ruo88FYIqEzrjBVPBjWB2VVBwF7/gcRxoXvBgvYAF7BYVrryzSU6U3Z0Nn36O0OLr/UaJL0YdvFidCM3T16yb0Fcw9kHVX0Au+kAo84+VSGgrRQvsH8QV/LV0BGTVf14slvhN3rpohJKHeOYTF6eOSkh5uVRwqQ7wz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T27XJJbr9PGxydlo4BGjH+H6b2CE7ZpTTFMQ5QfRSjU=;
 b=yymVluEKT610ns732UeZAOWRtLI434HXx+GHZF+AIp1rpZOVFdeYjjXxZiINbWmpOGaMfqHHpGObAIZB5G+/zDhZyYVsHL/Ywq2svX6OJZvc8UmiWSwqN0Mwf1Lc+Kkc2MIFVh5EJO20Y315svyTaTCnJdL9ttsJZZESMe0Dm8fiD7YNwhy/W4B4OEp6v448bPB+OhbFIP/0IVxwaNAEx+7+RAZ4S7QG/XTjt3ylwMswT+cDWr1zU888RpN6AnOagwg2CdaalR1bVx0wh0BdbBHY5j5FRHAJ0vvFbQ/Z78/toMBS7CyHa78mqxuXllvpROck4DClPvOPnoO2a9Leeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T27XJJbr9PGxydlo4BGjH+H6b2CE7ZpTTFMQ5QfRSjU=;
 b=MzzG6whW8Lr/ImTIVBmLDInms01Hrd3rsYyphirlDEXdW0ftGckcGXtXq4VqNtKZJnHgDh/YVKHYQMMCFNc648KbdiocuTwZNp54J46sTO3Jt0x4Q3RepmP6zQnnU4aojE+BTdtClDknIApritrAFoczqbczC+hLTLjLAp3ElZgJFwn3WvNhvl1Tud9KEheiX2PbkmCT7sG44+79c6zqHWDCb49kdPSq2EVOuBCXzoo1Xa2UbVWxWbhV3aTW5wnhTC2dO06pb5adHnl3xOBA6avsRRtU3retE9dkiisUz5yHEqYgHz64veaFp55mfVWszhuOyELgYEablLte3z0tVA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 15:01:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 15:01:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Frank Chen <frankchen158@126.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "fan.du@intel.com"
	<fan.du@intel.com>, "jun.miao@intel.com" <jun.miao@intel.com>,
	"chenhgs@chinatelecom.cn" <chenhgs@chinatelecom.cn>
Subject: RE: [PATCH v4] dma/swiotlb: decouple high watermark tracking from
 CONFIG_DEBUG_FS
Thread-Topic: [PATCH v4] dma/swiotlb: decouple high watermark tracking from
 CONFIG_DEBUG_FS
Thread-Index: AQHdKikC/6g6jF14fkq62v9tLQNoiLaago/g
Date: Wed, 12 Aug 2026 15:01:26 +0000
Message-ID:
 <SN6PR02MB4157EA729E64A69A5F41427DD4DC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <20260812070459.637077-1-frankchen158@126.com>
In-Reply-To: <20260812070459.637077-1-frankchen158@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: 9dd95191-3b5c-4f3d-2403-08def8829576
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|25010399006|15080799012|37011999003|41001999006|13091999003|24021099003|55001999006|19110799012|8060799015|51005399006|8062599012|3412199025|440099028|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f1+PflA5Kd3wUXJrWn4yNFvSTdsshzRSJVJkOfKS5Pxg8sU8Q0cSqKtMH/Us?=
 =?us-ascii?Q?FeBDgIaD4lDiYe8CJA6HcnWsiKDzvg/xDTgrAIQF6LwgRiCg1Uh+JfCiq5CT?=
 =?us-ascii?Q?2Fmx8R7a07AALtxFgqSh6j5MwYy8Hk03mz1dmM5jBEXgmJlXGBk78xahURFf?=
 =?us-ascii?Q?1Z7rNWgk7YDAaPUb0iA7Fv1mf1NFOKCkCozGu/INLoFzZJpALseTds9K23Gr?=
 =?us-ascii?Q?jKFiSGn0eeRd65yCSWfaPauvxlxMMroXZnHZeb7GDmpJzd1792oUVhzqv54m?=
 =?us-ascii?Q?QtRPzcxUS+ocmSvK9OP69n4Dpiu84QUol+ECcmdVc+B7x/qpl07LyWMsDO9n?=
 =?us-ascii?Q?/BLkfp1Cos9z9YxiYct46ULFsCerhDydbGHoqXeU1G307FyuBbgb8360dxO+?=
 =?us-ascii?Q?vTu+lGBzKbc2n0uj1UWWnIEqPs8ViKYrmPLt8qOLDoNku2O7j+LIk0XiSCBz?=
 =?us-ascii?Q?Ns1UKD3OgKGEMxYVyJ1IjR6HU374ZUqpK5G4BbdtAivffEEkGSh2pm9qMir6?=
 =?us-ascii?Q?ItmGCNwBAOyMMPmDElNPjwuPhWsLVa0TT6ZsUDhOF6nei1cHoPyiGaI7DJp4?=
 =?us-ascii?Q?SkxuiiClSWtikmkamrDoIhJwUlbT0qiRXndXLvOesDIUA0X/mYm/5brXuUCF?=
 =?us-ascii?Q?pnTOqGFqy8mX4ezG3QxG0wi/jM0EszwZwr7MebiKTRArxShjfSGDx69hBk8D?=
 =?us-ascii?Q?kBFaJWDCZz2U4LxWtL5+UB6hMXrlTkrpQBOB28iCbp15iLNtlBpXbKLLgt4a?=
 =?us-ascii?Q?WSub9VHqjXq7yWfjX3tTh7uiTszYw6OyODgWrR0iDnl43z+2+NDRrJta7qs1?=
 =?us-ascii?Q?8kxObjygiHdFvp9yDbHqrWNXyZXOnnNyR+4biMkWCzZBJD29MPD82jhwLwgT?=
 =?us-ascii?Q?CXp/NWaSI5dG5NXpdpzEXD5rOlrEU9BwQLCeAN9vmb2mKGuUlelniR5JnvQH?=
 =?us-ascii?Q?mORTB9IECJZP0627L3s9Msj+8NrqC7212+xCuhpSr3aXlzmAlWk9auOCgdZl?=
 =?us-ascii?Q?fCbISn1WBvNfoHu9dEcdyhhTFhRz0xrMcpSY/6rJdwMdz8Tb0CWnUDRwHznm?=
 =?us-ascii?Q?iAgAvG0N?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5eHaAjXPU6HjBVwFBYZCbz3vVcQE4NL9YXB+oduijNPVcL4U3Weg4QuKUNUO?=
 =?us-ascii?Q?Vokr3/cQIZDKDFQxhuZHqMNj0ArCDdfrM55+IHUXCQdnY451VZru6MiWTVJu?=
 =?us-ascii?Q?kRrjUcLvJ5otI/WzThoirXolx6uHspIvLK078zPJGYnBeFIlYFshuFc+FJYG?=
 =?us-ascii?Q?fseMZ9dap4B6P9wSMVwMxOl7KNjgzaUH9vDPrFhjXSOOJ3Nd6k+m0y7vU5KT?=
 =?us-ascii?Q?2uqltGTpIJGrj1gRUUhwFgbTF61+UP6eP6tJDZe4lql3BBDmEwt/N7xoPHvN?=
 =?us-ascii?Q?SFDbgzIJHWtKdnQUmFzToLlfzkPz1PMaQWK8XzIwB5tuB8aD9b7exZ5dPIYJ?=
 =?us-ascii?Q?AUXEKG+cJwe401teJei3Wl5rcn32GATvptJ5GNKBy/1WX5DFIlcz1loK8U8H?=
 =?us-ascii?Q?9tyeQgAEybngApMMVODxmkW9FNjm4OZEgS/zlf6j4n8lU9YpatqiBGfYtFVI?=
 =?us-ascii?Q?lUHGKINzJT2TchNed4eIrX5oTfJp5q26PyoAGeFIIbJlorG3pjam4+l8rPbT?=
 =?us-ascii?Q?rtEbCStCjeot1HYeJygmNfUszWguQg7hxBCy22veRqXpaixM9TosjPwaMXya?=
 =?us-ascii?Q?fF0KR4voyjWfzeHVx/sD750w3eyhxkDzUN02Bd6yILP/wbp7cFO0HR36+imi?=
 =?us-ascii?Q?8+4e/ju8F2v85ujHoB6x+Pv1/UNq+qyzz4DZ4R/yo7NyNNpNrFHVgkOHhwyI?=
 =?us-ascii?Q?wBcbXCcNUVG4NbLzeLHLi/aC0TBClYpMr1vREQyfQ2pEvC3EB7lIoMjc2hLw?=
 =?us-ascii?Q?i0o4KklHWn9I96Vw+YAnMO/Ib7EVv6ZzJQxm/+gAwuFTEEdjJxUD1/SurHaD?=
 =?us-ascii?Q?lmAj08M83eaKosR8tWG3griFKBuLsEsI7JjntBWL8cRF0QVSpwNl0faC5UnZ?=
 =?us-ascii?Q?Y0V8HhHaW0twLT3td/ySPDyEHnul/JMMnPPK8h4z5r2OXlLhmp93W2sLJucr?=
 =?us-ascii?Q?tYyzz0EQttRsDA4IdE/H1AQdhOEc9r4O3GKLlcYJ1YQ2F2+8/FeyzVynjyCm?=
 =?us-ascii?Q?x/4DpZoL0g/O+RBjNPXbE5FXwsswWA6i/tkGIFEbJ35ArT64n3Rjb/Vsg1eo?=
 =?us-ascii?Q?l8MXpD5dXpurIu4Vkmg3sP402wXuBbyo1uzgy8oPDcl3jBV1j5KSYqzAhF+A?=
 =?us-ascii?Q?ahQpzfFZJMU52JvVSXrcinL3fL0IuRjjB41y3AElqpnzOFpXm3J7gQPu5xjV?=
 =?us-ascii?Q?vHNep0z7TsNhjwaOVLigrzag1zTPkzuEXK6kHVa9GBFS65reKFWU4YHugcqr?=
 =?us-ascii?Q?GfXvSHqWZljdGtT64MNzV+7DQIx+Sp2S2cvGy4QtIxid5ubiVf3ninI7tEd1?=
 =?us-ascii?Q?iYaeT5LR+FcaR2ZGR4hyj34DPLOksFmXqmBjVBc+xsVVj0jzTghCdijiKRAW?=
 =?us-ascii?Q?eZeyVIk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd95191-3b5c-4f3d-2403-08def8829576
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 15:01:26.9904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044

From: Frank Chen <frankchen158@126.com> Sent: Wednesday, August 12, 2026 12=
:05 AM
>=20
> From: chenhuguanshen <chenhgs@chinatelecom.cn>
>=20
> Under heavy concurrent DMA traffic on CoCo VMs, inc_used_and_hiwater()
> performs an atomic_long_add_return() plus a CAS loop on the global
> used_hiwater, and dec_used() performs an atomic_long_sub() on total_used.
> All CPUs contend on the same cacheline, causing measurable throughput
> degradation at scale.
>=20
> Historically these counters were only compiled in under CONFIG_DEBUG_FS,
> which means production kernels with debugfs paid the atomic overhead
> unconditionally. Make the tracking boot-time opt-in instead so that it
> is disabled by default with near-zero overhead via static_call, and can
> be enabled via "swiotlb=3Dtrack_hiwater" parameter on demand for debuggin=
g.
>=20
> Note that when CONFIG_DEBUG_FS is enabled but hiwater tracking is disable=
d,
> the "io_tlb_used" metric reports an approximate value rather than an
> instantaneously exact one.
>=20
> Suggested-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> Co-developed-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Fan Du <fan.du@intel.com>
> Tested-by: chenhuguanshen <chenhgs@chinatelecom.cn>
> Signed-off-by: chenhuguanshen <chenhgs@chinatelecom.cn>
>=20
> ---
> v1 -> v2:
>  - Change the patch title.
>  - Doing the exact hiwater calculation is dynamic and defaults to "off",
>    dynamic config would replace being under #ifdef CONFIG_DEBUG_FS
>  - The mechanism used for dynamic config needs to be one that is selectab=
le
>    on the kernel boot line so that the exact hiwater mark during boot is
>    easily available.
>=20
> v2 -> v3:
>  - When track_hiwater is enabled, we keep the original precise hiwater
>    calculation backed by the global total_used atomic counter. If disable=
d,
>    we switch to the approximate approach that sums per-area counters to
>    derive the total used slot count.
>=20
> v3 -> v4:
>  - Change commit message and documentation.

LGTM.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>=20
