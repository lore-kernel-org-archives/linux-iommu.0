Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010023.outbound.protection.outlook.com [52.103.7.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6D282F14
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290658; cv=fail; b=NT1vIAmnN9sqoHY43+VTprN9on6KhRLDhO/27MWYCuqSI7sJaLwF0zK/kzWTDU10w6vWGs8svUVSDCdL/Un7QWRGK96TVHpm7j8n2LRmioLDG/fFwykcKyLlSQGfMiqeLFU+txLhU4ICAw2g0PeeMAmdzOeBfcFv5tKX0MiA11M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290658; c=relaxed/simple;
	bh=HdT8VFC+3QT1pZ6ocxDhiApjJg1SYiQEX/ebDG8RcSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gCuOmv6HxwYOd03+hIUx0DeADSVVegXLPQzFDZRPtZupKQ5penp13swgPN4HsmSXBIfakPWjTJjqDYcLtgBor+ceIUVGUHxjhOOnX8IQJd/8j5+an+Kvv5RgIVcWeVWnlsHj9TtsR7nF0azLaj1SSeULf09vap2l+Ar/tF/a3yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YoJCSM/p; arc=fail smtp.client-ip=52.103.7.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YoJCSM/p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrPiysTrZgexMV177X+FAtlgpnjapvOXUDP4wyLV4PIREYrnk+hN/CqfZ6yWrBKdexwStPhQKjSgwZl3s+eas6dygeTw8rYn5MPqLCErvRYYn5FJfGcSS5g5VpqB2ax5uReoBExOdjloZA0zAoOcciG3JAD3bVjUSqlxf9VrbMcqHXrTTYlr2RmPgVtiGCSDIn3mxn78sfFRNAUbJ0dkwknpnB0qrOcm/58zbxwU1nE0zi+epzTaj0ZF1jQKkBiKGzrCwqp6RFWsffzcsAGwC0NfuTre/ozzmnM8QEpfEQuIjR4BzSEzehrvqRgClWgZe5OyzK7UvhpDfaeh77WGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8J5BFi/oPM7U0QouOQ4ImBhqUPkBwAajpvLdiDhBIXw=;
 b=qL5kfiagXnaxf+lIBQUv27m+4PPgRU92LJyS5HbW5ljnYhSKunGQ8I7/8c8tyMwKs8p/UKka930GMU7cH/jEr9RADwmTY1WEG+MBCAOnOfif1xqJLZQZeucrSQbindya0hnziqwon0qBmwxg7a2zYlabyDdEyLIvCPsIkcnOu7K/iT2W2wqBd0dFKBpoJczF5oGaL0nrO+3HlH+o/eHiy/Ytz1Rf6LMfjqxpqsYtHWraAuzR9T7HJQF6cYeM56c/Ybc3xm6VrNy3SLk8NdTme9wkr7C8ksIEhY9xNCSTpCoVXhv1ZPVcY63bJxgyQaBLwmVrem7Ul8td3M5LrY/8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J5BFi/oPM7U0QouOQ4ImBhqUPkBwAajpvLdiDhBIXw=;
 b=YoJCSM/puhmPg6/p4Tjjlw1UyqLtqQXe2H3Xd/VRwpFf/JsWMYXD37iOjd+OA/KuQUgLlK+CWq3w3jLWimNGaYI/c+K9JAloaR2CuPkpne6F9CKf3HSvw7YwxpGCVBYeRou1K2TtkLgWJiSDFqgdrVPURXg/Ox0fgrbaewpsSvTmPluL5ZKaLaO2pmZNuEfz+xW+XOk99pXlNQbhiLTETZ38LJSHBv4G8mrATGkHPMN7xqrBnXAGt46Njx4bKUzDuxwbRJXxVSJrgFyhPr3gdbes8alxWuUMzT9899vYNsHiKqxyWGdngAY/xmsUc4A3jz2rF5kL656SNHSKw3Bn7Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA3PR02MB9277.namprd02.prod.outlook.com (2603:10b6:806:31c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 15:50:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 15:50:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Frank Chen <frankchen158@126.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "fan.du@intel.com"
	<fan.du@intel.com>, "jun.miao@intel.com" <jun.miao@intel.com>,
	"chenhgs@chinatelecom.cn" <chenhgs@chinatelecom.cn>
Subject: RE: [PATCH v3] dma/swiotlb: decouple high watermark tracking from
 CONFIG_DEBUG_FS
Thread-Topic: [PATCH v3] dma/swiotlb: decouple high watermark tracking from
 CONFIG_DEBUG_FS
Thread-Index: AQHdJIJySrMf3XhO20W/60aosBssa7aV5KqA
Date: Sun, 9 Aug 2026 15:50:52 +0000
Message-ID:
 <SN6PR02MB41571E8D138878C3CFEF3979D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <20260805022958.329840-1-frankchen158@126.com>
In-Reply-To: <20260805022958.329840-1-frankchen158@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA3PR02MB9277:EE_
x-ms-office365-filtering-correlation-id: 690a40e2-2a30-4b3b-6d19-08def62dfdca
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|31061999003|8060799015|19110799012|8062599012|37011999003|8022599003|13091999003|55001999006|24021099003|15080799012|25010399006|2607281247196008|3071699003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AGSkaQu84vwwVEbDvZsx3ywRPqiDh4UumMm5okzh5hcz4eO7oon5cgNucf32?=
 =?us-ascii?Q?Jn3IAKQ0B/TNNp/jriL9Bj7wIa0eM8A7QHNQlSoNnY6REB8ttwS7pxJpv8UJ?=
 =?us-ascii?Q?BkEiQOkfivU1HZotppWw4L9pdtNAUJ2TV1M4EJMDDzwVZhXDkMopry3RPAr1?=
 =?us-ascii?Q?Dbe3Pxu1/ivFRZxyWgvxd9gUZxu6ZLVo85aZD3awdXpUjGwY6V3WuU53AO82?=
 =?us-ascii?Q?iTs8wh4TUoFVZq8NLyEOEZwyZ5wR90EM+zGwvj65Ny6akEnMSW0hfuF5/xzD?=
 =?us-ascii?Q?8fl7Dh2kE2FU8DEvTYhoY1Xd9wSon8RHAIU9/GNq8S16/9a7D5aHzrAO3ekG?=
 =?us-ascii?Q?MrgXOcYYhXNbVnZluh4MUO/ByB/fxpthEOsJWJboDVCpkrDZ8m2RzfcwFA0u?=
 =?us-ascii?Q?PJURg859F9abRXRTtuRk8CH7FmL6gZnYvYO9eHVHn1RSWfzhnESsjuDMMPoy?=
 =?us-ascii?Q?V71Muu0gNA/isVLiBcUjljvXZ/cw24NEcOE2OS3gHM/t3Mu7RCtqvcBUO2nq?=
 =?us-ascii?Q?6E9Rz7Zx3kpKBeREHWs8D577EMXqwOkR7MJhIpg51rkkgOaqOXnWgSwPretx?=
 =?us-ascii?Q?2s5WChTXxk2TWMl6RZfDzd0GKWisLlwxab/Z/bG2s7GvBnDpG+5JQmBMLM5r?=
 =?us-ascii?Q?3EoChGicUeuTxJS28Af/zgwbbza1Wz5Y3S/5Ov2MhFZC+dfatF4GlzeQ4nRy?=
 =?us-ascii?Q?r8MCLXvZnMiOTj21uDBjkKTqLseGe5BI/GrLOEgwUcUmA45/k/gARknFUJC5?=
 =?us-ascii?Q?pKJ27e9XTffnKou9uGH+tHo6fYaG5Br36ivmJhEgfZyV3leAJaMXV9Ix1//h?=
 =?us-ascii?Q?PwOpBb/NUAC6Tn2rckpL8Kxe0JG3ttN/Lx+AHaRlnorkbGZ2+lR3YYBgrRRt?=
 =?us-ascii?Q?GN29//wRH2F8BtDxpOV8rWiIlWFP0g5w2w+vqnsQPQ1wMHD25ocrst+96nmQ?=
 =?us-ascii?Q?fIXCHCoXT8GAwHPWVL+iD2AwLaWQTk3lmmfb3Kx5C5y4C197KefpPbkAjf2P?=
 =?us-ascii?Q?IzwPoukeuPSr4jmeR+8yfyfF6/pgie2OEnZ77pRb9uoE60etbMOyH10YDAv8?=
 =?us-ascii?Q?5G36wQkq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Snit39vTjNTW54tIaSTUX9T6GEyUhjMuY999V1HyRfobZa2a0NcXvrJKRwLT?=
 =?us-ascii?Q?Mz5J8moNWMj7y3e+9yxHCwJ0R7zl4D2RAq++7o1MDXBsw14Q70TN1KdoOAAV?=
 =?us-ascii?Q?rQq7vvtP02uCQU1isXghpsvKRDSTMvAZaJnw2Fz/WEiIS/dy+QdjVpCSlguu?=
 =?us-ascii?Q?2D/V2j794FdE0xM/zYwQZrGKiVOsw8PupF7MRbRfKlVIll4GJ98OAoey2eA1?=
 =?us-ascii?Q?Uy7GbhGakJySnAy4Y5ZjDUV4KsKXJG63ApzDU0JfijryCE9QhkayfS0tz2sh?=
 =?us-ascii?Q?amfNor1zhuGqMBNXLNtACbwsYuBrDg33WbRaiecA4BDGJ1fpm0QI/J3J6ddr?=
 =?us-ascii?Q?NhrJ1nwhm1VDyBPPgPoTpjuf//PWCFAy7YFSh1U0dT+F7AP1rcJ9q1s0h+jD?=
 =?us-ascii?Q?uCiZ1pwWDzfnsQbhUT5owsVNJa6bebzskEntj45NOE+6xhQTPHRLViNc3emR?=
 =?us-ascii?Q?c/MuuqR1Xj8Acd7yl7PSWK81I3TJoeHCVJGfgj1BjKMyiRkbTfuJwNl+x5gG?=
 =?us-ascii?Q?b7tCbQZ/a6JsJS4ur6iADgSCb+/9hCMkJspQfhVLTGmejgIU5Nc2vTmlgBlQ?=
 =?us-ascii?Q?qaKkuebxrvPc0oD5JmKVHMZk/1paHERRHo/SZezMBwnPk0jZkYq2f58S9fDN?=
 =?us-ascii?Q?GT+X0i9joclW55ltPhrcR/4suUM6zIADoFHvBGx8oq6RdDpgf982oOLgEl4p?=
 =?us-ascii?Q?T4mtLkYrnSJNShypznZJicr1ea+o5oPJXc5mhOHiFyc1YjB/CL8bCXqqjQLx?=
 =?us-ascii?Q?DWQ6qAHj1+q98hJjlnT7VOSpmhI2gjuDasHkhOls7aBBqH+HjkBKx0HKYzNd?=
 =?us-ascii?Q?oT9SwJ+j0eVued5FCvK/mbU0jVLwyjQwqYw04QJv4AFAvYsaxds5ZInoqguA?=
 =?us-ascii?Q?apIfm6y2OEK8UVL7HeRXjq5WZppJp3VER6hqQ6qhlTEvZbw7rM3c6d9wMnkt?=
 =?us-ascii?Q?mPmRzi6sV1hh4j61iDi1BAtsqgXx1HKO/Xs6ydV2LPHQ25/9yVixwC8/mFwz?=
 =?us-ascii?Q?RP8oL3yAQdqxy03qbRTlcJvHyvhVX2pzAIHR4IXKK4EYbYJgpi/y1jN1KbWx?=
 =?us-ascii?Q?WCkFkhPdruQV5KG7o5K0Q2sZkmex0olcrKowG8Thq0eHd6J2B+JyeVHlECKV?=
 =?us-ascii?Q?QrE79FwtyljxkYIouLxCrQkIETEBgl4VMnWZg+6wAa6aGDWY7ZI47/5rPf/b?=
 =?us-ascii?Q?27tGqKlZXRnETN1b6kD6KAUvvOcxtI/mVs9WYEGIHsTj6mDScxOoCR7r43CR?=
 =?us-ascii?Q?yVQza38UILs/iXdXsz6x2Ex88b5/2BWBKd1rLBIe2e1J5DCdWdPRGzSC8F1a?=
 =?us-ascii?Q?uJ6OVxPg0J9IeeZu2+6a78D2XfhKhTw7zKWbr4GFItg1/Lo9L5eITWuQyGZ4?=
 =?us-ascii?Q?b/dQDEo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 690a40e2-2a30-4b3b-6d19-08def62dfdca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2026 15:50:52.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9277

From: Frank Chen <frankchen158@126.com> Sent: Tuesday, August 4, 2026 7:30 =
PM
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
> which means production kernels without debugfs paid the atomic overhead

"with debugfs"?  "without debugfs" doesn't make sense to me.

> unconditionally once the symbols were present. Make the tracking

I'm not clear on the meaning of "once the symbols were present". Could
you clarify?

> boot-time opt-in instead so that it is disabled by default with near-zero
> overhead via static_call, and can be enabled via "swiotlb=3Dtrack_hiwater=
"
> parameter on demand for debugging.

There's another functional implication here as well: With
CONFIG_DEBUG_FS and when high water tracking is disabled, the value
reported for "io_tlb_used" is approximate instead of instantaneously
exact.

>=20
> Changes:
>=20
> - Introduction of static_call infrastructure: Under CONFIG_DEBUG_FS, real
>   tracking functions and no-op stubs are defined, with DEFINE_STATIC_CALL
>   defaulting to the stubs, making overhead near-zero when disabled.
>=20
> - Parsing the track_hiwater boot parameter: setup_io_tlb_npages() is upda=
ted
>   to recognize track_hiwater, which triggers static_call_update() to dyna=
mically
>   replace the stubs with the real tracking implementations.
>=20
> - Removal of old compile-time-gated definitions: The old #ifdef/#else blo=
ck
>   defining inc_used_and_hiwater()/dec_used() is deleted, as its logic is =
now
>   replaced by the static_call approach.
>=20
> - Unification of mem_used() implementation: The two separate debugfs/non-=
debugfs
>   versions are merged into one function that checks track_hiwater_enabled=
 at
>   runtime to decide whether to return an accurate or approximate value.
>=20
> - Update of struct field comments: Comments on total_used and used_hiwate=
r are
>   changed from "used only in debugfs" to "enabled via swiotlb=3Dtrack_hiw=
ater boot
>   parameter and exposed via debugfs".
>=20
> - Documentation of the new boot parameter: The kernel-parameters document=
ation
>   adds track_hiwater as a valid option for swiotlb=3D with its descriptio=
n.

To me, the code changes are straightforward and don't need a detailed
recapitulation in the commit message. The commit message should focus on
the "why" (which you've done) and perhaps a top-level summary of the
approach. You've mentioned using static calls to make the overhead near zer=
o
when disabled, and that seems sufficient.

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
> ---
>  .../admin-guide/kernel-parameters.txt         |   3 +-
>  include/linux/swiotlb.h                       |   8 +-
>  kernel/dma/swiotlb.c                          | 153 +++++++++++-------
>  3 files changed, 100 insertions(+), 64 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..2caa9c0b3d7a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7477,7 +7477,7 @@ Kernel parameters
>  			Execution Facility on pSeries.
>=20
>  	swiotlb=3D	[ARM,PPC,MIPS,X86,S390,EARLY]
> -			Format: { <int> [,<int>] | force | noforce }
> +			Format: { <int> [,<int>] | force | noforce | track_hiwater}
>  			<int> -- Number of I/O TLB slabs
>  			<int> -- Second integer after comma. Number of swiotlb
>  				 areas with their own lock. Will be rounded up
> @@ -7485,6 +7485,7 @@ Kernel parameters
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> +			track_hiwater -- Track high watermark of swiotlb buffers

Add: "Applies only when CONFIG_DEBUG_FS is set" ?  I see several
other entries in kernel-parameters.txt that document dependencies
on CONFIG_* values.

>=20
>  	switches=3D	[HW,M68k,EARLY]
>=20
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..008f169e4006 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -98,10 +98,10 @@ struct io_tlb_pool {
>   * @pools:	List of IO TLB memory pool descriptors (if dynamic).
>   * @dyn_alloc:	Dynamic IO TLB pool allocation work.
>   * @total_used:	The total number of slots in the pool that are currently=
 used
> - *		across all areas. Used only for calculating used_hiwater in
> - *		debugfs.
> - * @used_hiwater: The high water mark for total_used.  Used only for rep=
orting
> - *		in debugfs.
> + *		across all areas. Used only for calculating used_hiwater via boot
> + *		parameter swiotlb=3Dtrack_hiwater and exposed via debugfs.
> + * @used_hiwater: The high water mark for total_used.  Can be enabled at=
 boot
> + *		time via swiotlb=3Dtrack_hiwater and exposed via debugfs.
>   * @transient_nslabs: The total number of slots in all transient pools t=
hat
>   *		are currently used across all areas.
>   */
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..799eee3bf9cf 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -180,6 +180,74 @@ static unsigned int limit_nareas(unsigned int nareas=
, unsigned long nslots)
>  	return nareas;
>  }
>=20
> +#ifdef CONFIG_DEBUG_FS
> +/*
> + * Track the total used slots with a global atomic value in order to hav=
e
> + * correct information to determine the high water mark.
> + */
> +static void inc_used_and_hiwater_real(struct io_tlb_mem *mem,
> +				      unsigned int nslots)
> +{
> +	unsigned long old_hiwater, new_used;
> +
> +	new_used =3D atomic_long_add_return(nslots, &mem->total_used);
> +	old_hiwater =3D atomic_long_read(&mem->used_hiwater);
> +	do {
> +		if (new_used <=3D old_hiwater)
> +			break;
> +	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
> +					  &old_hiwater, new_used));
> +}
> +
> +static void dec_used_real(struct io_tlb_mem *mem, unsigned int nslots)
> +{
> +	atomic_long_sub(nslots, &mem->total_used);
> +}
> +
> +static void inc_used_and_hiwater_nop(struct io_tlb_mem *mem,
> +				     unsigned int nslots)
> +{
> +}
> +static void dec_used_nop(struct io_tlb_mem *mem, unsigned int nslots)
> +{
> +}
> +
> +DEFINE_STATIC_CALL(swiotlb_inc_used, inc_used_and_hiwater_nop);
> +DEFINE_STATIC_CALL(swiotlb_dec_used, dec_used_nop);
> +
> +static __always_inline void inc_used_and_hiwater(struct io_tlb_mem *mem,
> +						  unsigned int nslots)
> +{
> +	static_call(swiotlb_inc_used)(mem, nslots);
> +}
> +
> +static __always_inline void dec_used(struct io_tlb_mem *mem,
> +				     unsigned int nslots)
> +{
> +	static_call(swiotlb_dec_used)(mem, nslots);
> +}
> +
> +static bool track_hiwater_enabled __read_mostly;
> +
> +#else
> +
> +static __always_inline void inc_used_and_hiwater(struct io_tlb_mem *mem,
> +						  unsigned int nslots)
> +{
> +}
> +
> +static __always_inline void dec_used(struct io_tlb_mem *mem,
> +				     unsigned int nslots)
> +{
> +}
> +#endif
> +
> +/*
> + * The tracking of used slots high watermark can be enabled
> + * by appending "track_hiwater" to the swiotlb=3D boot parameter.
> + * When disabled the tracking functions are no-ops with near-zero
> + * overhead via static_call.
> + */
>  static int __init
>  setup_io_tlb_npages(char *str)
>  {
> @@ -194,10 +262,24 @@ setup_io_tlb_npages(char *str)
>  		swiotlb_adjust_nareas(simple_strtoul(str, &str, 0));
>  	if (*str =3D=3D ',')
>  		++str;
> -	if (!strcmp(str, "force"))
> +	if (!strncmp(str, "force", 5)) {
>  		swiotlb_force_bounce =3D true;
> -	else if (!strcmp(str, "noforce"))
> +		str +=3D 5;
> +	} else if (!strncmp(str, "noforce", 7)) {
>  		swiotlb_force_disable =3D true;
> +		str +=3D 7;
> +	}
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (*str =3D=3D ',')
> +		++str;
> +	if (!strncmp(str, "track_hiwater", 13)) {
> +		track_hiwater_enabled =3D true;
> +		static_call_update(swiotlb_inc_used,
> +					inc_used_and_hiwater_real);
> +		static_call_update(swiotlb_dec_used, dec_used_real);
> +	}
> +#endif
>=20
>  	return 0;
>  }
> @@ -959,40 +1041,6 @@ static unsigned int wrap_area_index(struct io_tlb_p=
ool *mem, unsigned int index)
>  	return index;
>  }
>=20
> -/*
> - * Track the total used slots with a global atomic value in order to hav=
e
> - * correct information to determine the high water mark. The mem_used()
> - * function gives imprecise results because there's no locking across
> - * multiple areas.
> - */
> -#ifdef CONFIG_DEBUG_FS
> -static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int ns=
lots)
> -{
> -	unsigned long old_hiwater, new_used;
> -
> -	new_used =3D atomic_long_add_return(nslots, &mem->total_used);
> -	old_hiwater =3D atomic_long_read(&mem->used_hiwater);
> -	do {
> -		if (new_used <=3D old_hiwater)
> -			break;
> -	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
> -					  &old_hiwater, new_used));
> -}
> -
> -static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
> -{
> -	atomic_long_sub(nslots, &mem->total_used);
> -}
> -
> -#else /* !CONFIG_DEBUG_FS */
> -static void inc_used_and_hiwater(struct io_tlb_mem *mem, unsigned int ns=
lots)
> -{
> -}
> -static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
> -{
> -}
> -#endif /* CONFIG_DEBUG_FS */
> -
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  #ifdef CONFIG_DEBUG_FS
>  static void inc_transient_used(struct io_tlb_mem *mem, unsigned int nslo=
ts)
> @@ -1295,24 +1343,6 @@ static int swiotlb_find_slots(struct device *dev,
> phys_addr_t orig_addr,
>=20
>  #endif /* CONFIG_SWIOTLB_DYNAMIC */
>=20
> -#ifdef CONFIG_DEBUG_FS
> -
> -/**
> - * mem_used() - get number of used slots in an allocator
> - * @mem:	Software IO TLB allocator.
> - *
> - * The result is accurate in this version of the function, because an at=
omic
> - * counter is available if CONFIG_DEBUG_FS is set.
> - *
> - * Return: Number of used slots.
> - */
> -static unsigned long mem_used(struct io_tlb_mem *mem)
> -{
> -	return atomic_long_read(&mem->total_used);
> -}
> -
> -#else /* !CONFIG_DEBUG_FS */
> -
>  /**
>   * mem_pool_used() - get number of used slots in a memory pool
>   * @pool:	Software IO TLB memory pool.
> @@ -1335,13 +1365,20 @@ static unsigned long mem_pool_used(struct io_tlb_=
pool *pool)
>   * mem_used() - get number of used slots in an allocator
>   * @mem:	Software IO TLB allocator.
>   *
> - * The result is not accurate, because there is no locking of individual
> - * areas.
> + * When trace_hiwater and CONFIG_DEBUG_FS is enabled, the result is accu=
rate
> + * because the total number of used slots is tracked in mem->total_used.
> + * Otherwise, the result is not accurate, because there is no locking of

Rather than saying "the result is not accurate", I'd suggest saying "the
result is an approximation".  "Not accurate" sounds like it is of dubious
usefulness, while an "approximation" can be useful. :-)

> + * individual areas.
>   *
> - * Return: Approximate number of used slots.
> + * Return: Number of used slots.
>   */
>  static unsigned long mem_used(struct io_tlb_mem *mem)
>  {
> +#ifdef CONFIG_DEBUG_FS
> +    if (track_hiwater_enabled)
> +	    return atomic_long_read(&mem->total_used);
> +#endif
> +
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	struct io_tlb_pool *pool;
>  	unsigned long used =3D 0;
> @@ -1357,8 +1394,6 @@ static unsigned long mem_used(struct io_tlb_mem *me=
m)
>  #endif
>  }
>=20
> -#endif /* CONFIG_DEBUG_FS */
> -
>  /**
>   * swiotlb_tbl_map_single() - bounce buffer map a single contiguous phys=
ical area
>   * @dev:		Device which maps the buffer.
> --
> 2.53.0
>=20

Modulo the few nits about the commit message, documentation, and comments,
this looks good to me. I've tested on x86/x64 against linux-next20260726 wi=
th
and without CONFIG_DEBUG_FS, and with and without the swiotlb=3Dtrack_hiwat=
er.
All seems good.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
