Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011025.outbound.protection.outlook.com [52.103.14.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B63002CF
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182119; cv=fail; b=dx9HU6im4o1aeU+Xl6Rt4U6ZjjZGp2z6fHl5IUBWaMaFLHyMcymM1cX2jE+NSBDYhAfyXlYxAx++njB1cIUWBbqs7E4zEDuoYggVz2cexcz6y98zlBo2PuIjO3hyOKinGWGrgM10WIIIG6mMatSRG/PNQuJR0g3ucHmWKRzUpIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182119; c=relaxed/simple;
	bh=+vxL1RCL5rPoyI3E0ni7LJBv0IpanaIgOtVPg6M2bGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIENkadGUCBW4hiB3Mat41RhtLe0dsq3MUP4Qx2PTuZJ/jPf/zT9qKcpBg/W50mlvFVHp6fC0iwX1K2372hM3VmmIsn1Tqoz71svAGw1R/CsoYGhnNgoXSornR10l8yDBksoDeUHnVQNEOpvEhfuUvl2Zw9rWTJqvGYNvzyKqzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=d1kKVeKr; arc=fail smtp.client-ip=52.103.14.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="d1kKVeKr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyqdc16P7FMOj0WpVppZdGVz1w9xQGS7Su6CZ0WBL41SSRfOSQkroz7mllLtnRUc9tmIQWXgFZD/HXY9P+9em7sQuw+BcZlcSC5N36CVhUsQVeisGryYjW7FRREwU3LZe8bLyILfFuNblsWDcl4Bvwpki33CiPON80MmGPJ8BSuIp9aELSMWMnpuBPIFAzj/I4Dar3AUhiSgC1I2yWVNXSxnaw1JH92y6sO95S8Zir9F32Mxt37nXKLCGVyv1GOGrqf+dHwv5fQ8eEh2FG9patjtMW4f5kPIJh4GfL+jA09Ahm4VCtlld1YFrwrRpvzJZNscYGwgmjTQHqmllG6+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfhRo+f+vpzop2Tyj/mmIK/4iTL0hFypVm8WNw7bOYQ=;
 b=tVx2ox/5m4N2TgbrloPSkHNDAENPlmvpmlQv2t/YLEveFeTiBA97LoECVm5BuYkH2HwQMJOXhkKHC+wv0TQKmHQUw44oqMh5QuhGzBrnYDzarYmG0QkCqMRhZwoiUaR+CmIbD6HI8b/XTBhGTdyxoDGRlsYdwPHn3ANnoQwR2S0L2wa20iG/VKMBUyuUBww8QpD3gEB/DePs17u/RHZiw7IFL6Zv5GlnXmkbMx8TIETjgOaOJGFtSkaQ1bV/4eAc7RW7sTq35dMhBzYvvOq97UN+ed9Uovk4aKEWS3/9nhe7LvgJcXDhU/lmfaB6PyM6wk4NTdMMU1cT1Dl2PLjGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfhRo+f+vpzop2Tyj/mmIK/4iTL0hFypVm8WNw7bOYQ=;
 b=d1kKVeKr2bsn3hd4Ecnx+HkjoESVDK7XKWhbWwn6rlv8VmzBBwSNrAWxaCMlp367mSQtaGCA9KgPokESgcR499nR5yqKOW7TY8mJD878xLel2zMPgwTKd+9e5m8tB7IKoFGNllqte++Nt/mpLlrUBirae0DoQEP8zZUtBaHA/QJxRqvlM/N5RKWjvjYXG3wJjcPteqbEUbXOFxbSWIfG7Vf0515GfdR3kt5iIPKgDGDNmoZE6KMFc4X5pergbuw6wgLmNhCK13WVg5hdheq0lFC9tyHwqX9liFwRe9x050Oeo29gBrY2IxdcocZncsIEK2rmSKUXV54XuV4m0tqCrQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10512.namprd02.prod.outlook.com (2603:10b6:610:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:35:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 02:35:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jun Miao <jun.miao@intel.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "chenhgs@chinatelecom.cn"
	<chenhgs@chinatelecom.cn>, "fan.du@intel.com" <fan.du@intel.com>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Topic: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Index: AQHdAl427ISAWK+xiUOEbDzqfvGrgbZLbReA
Date: Tue, 23 Jun 2026 02:35:14 +0000
Message-ID:
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
In-Reply-To: <20260622122114.2563254-1-jun.miao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10512:EE_
x-ms-office365-filtering-correlation-id: ef70a96b-ba7c-4009-7ad9-08ded0d00e41
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19101099003|13091999003|25010399006|31061999003|12121999013|19110799012|37011999003|15080799012|8062599012|4140399003|8060799015|18061999006|12091999003|440099028|3412199025|40105399003|52005399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PaBR4yKxoy3FKatPe9dhJVbBbzp3YPrB9CkmWvndXhGqRhgYXTNLt2PL04KT?=
 =?us-ascii?Q?LkZYsORcHUvC6KDM757+VIKSGuHO5jTOgdHEy2JzwjbGPjtbSfmQL4/EmYKa?=
 =?us-ascii?Q?XP8AaQOFe2/3ev+B2NqLobPxUgm0URSPpX8OspHznnE+LrdMIdE8SMTfYEPy?=
 =?us-ascii?Q?d1RhjEfPbkPFeJ9YR9CD5XtzKCnM7SDUt2x+Ah1u5Qe8OSNMYJ2P+tfox4F8?=
 =?us-ascii?Q?YpoRaqT/LpjVmXMEGlhjapgSo5gk2833Mmk865mfsjrKwoxx6f8OKpKJ5XkB?=
 =?us-ascii?Q?ElLiY5nRj2o1UMXtSg1ntBEL3m1vQiNi3liOr7xfHSGS5Q0qlEyHyLikDUDt?=
 =?us-ascii?Q?Es5wUrq3/5mXIib5DuRDxRzjYcmhrCpXzuMy+9iuN1xqOqnZRjXswlyp+qrs?=
 =?us-ascii?Q?EW4Z4NB/Pge6JESNI7a2PM0qlPE/1hSQeG3pitrdL/DxFoKzI7oJab+cN0kC?=
 =?us-ascii?Q?wROSjq2scWAZdK0nwMAVJytLfgnaulGpDpHeL/L4Y0CWrMicK0/hLqLRkTQy?=
 =?us-ascii?Q?ICeMjl12dT9ZSjJWvW1UpCzSDybpKQ2CD57aB4l/aV7nbeC2LcZaERRy2+aE?=
 =?us-ascii?Q?jKKXaJ87HyK/vzrqdNXYBCnjNdLRYYWaP/zy1OCzE66gkV6Ot/QUN6mAc3dg?=
 =?us-ascii?Q?aeCXLZaQ9fo3wlgOtJe1DjMV1CbDwP9pLg5xGSovwKjx1eNLuxnfrQNzMnda?=
 =?us-ascii?Q?RFh8lmpYgMBf3LFuZIfcHzz5GAom8bDirDaTcmQRrnTOZ9nVvvGLotoLsDDm?=
 =?us-ascii?Q?vhpJkoxxCV3KHW2SDrJmQAOUMVLef2MMUwshIfYI3yTbfZCty/xJEwnzW0TU?=
 =?us-ascii?Q?DrV69EF1cFGbdcM8HpiPrDZteAS6fhKmkFu7oUlTEcMOotjRBN/hAfp6cebm?=
 =?us-ascii?Q?PHCVWHstpYUR+qxJ9WPWqmg7GLH1oBB9kVJRwx6kFWwOZHyVdO+4mqL318Z5?=
 =?us-ascii?Q?a0iqg6KyyAs5uSNz01bLuBwQ0HjDNxPU8O0AMB/OiifoGFY8jetMFdJcHCzM?=
 =?us-ascii?Q?esq+33Jdiiwuii+T3BnrYMpLEfZKXQvapoyfms4GAjUaDJhC5jHJiFl2fy4z?=
 =?us-ascii?Q?9X8neEqUK1pVUwVzYa2paOX5nk3MGp4f8DP0tzY+xLT3TVdmBH6SBBtayAIo?=
 =?us-ascii?Q?JoTvzRium2wC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4OZuMbSTV8isj56N8FRZKmLfxsByTqMGNA3RaCCvxOg3st9Y6uIsZS0UtV2v?=
 =?us-ascii?Q?ft2g7hzstXqPErUcw4VNDI7DQRR1TZGisnDrw+14RRfFs9UdwgyJEbRTliQf?=
 =?us-ascii?Q?DNER+P+J0mhepdnEE/SNzO5/CQG3YBKzpZloJBfy7MAt5mEQZYq7giCtVGE7?=
 =?us-ascii?Q?ALpZxitj394mBbj6iTX4Zyrtt+5f4M1+XgnS90L5a6x/4bvm6bJKd/dW/XPZ?=
 =?us-ascii?Q?9PHMrQj2tV7tr2waszXDNP9C8FxnVoqveel3un/Ce3B6UHEFIH6Zfq/16Tnh?=
 =?us-ascii?Q?fwrCBf3hkRl9OGevW8SlXbuvk0pM2uejCPehRsqsai5GXqQdz0jc2UCu2qol?=
 =?us-ascii?Q?++xlNh/4rWeAs3TcNsgJ6brpNR6ylnVWcHl6PJzMUu9TA0oQpOF0BMSG6nl1?=
 =?us-ascii?Q?/XA5s2h1IWII8DkqoFDU2CwKsG9uIyOAv+VbfgsBd53xDEY6zkFduGR7ca/Y?=
 =?us-ascii?Q?YUsapkunmF8l0ZiD/4lZdiGxiHw40MhjpIU+QlaAGEVl8UbZL8XYVnyyPDRF?=
 =?us-ascii?Q?buuFyTJzww4kY/Mnq45vjcVyYeGs6IrYic56tEiBA8AndrW3tYdxB99njbH2?=
 =?us-ascii?Q?yCJ/ZPjLUBtvCvmcKOuXQX8ioW0IjCu3SruJP7um4UQSj77jCZ4mC1SIbRqb?=
 =?us-ascii?Q?RQ1sfMRxVGS/LpnqXTyPineugPYB4nfwGBs3QlbFb6A/TwucvSgYf8H5dxm2?=
 =?us-ascii?Q?0+PnjL98eTAB4aKoSrZ/v4mAuyVzLiqHIo4nO3ejO4IsKwEKHUmpjiOtklHO?=
 =?us-ascii?Q?XqOh+iMikDM5iqy8St7Ait3Nv8TkcOip6L6Q7aElrFlbUtd2DjPiVTlmUuzD?=
 =?us-ascii?Q?ZSQPYLXVhXYZTj9dTBTPTXDyz5xHmR5FhdfIzfD6ZDMW+pGBDVF4FPf7YRrM?=
 =?us-ascii?Q?hIDOkeafD1FrJX+TQS3hX8ZEZmIsIeO69LCJShIkd6DNM+aDQsrmnelHp8Yd?=
 =?us-ascii?Q?eNCXWXbqo7oVEbKqDu7BR1L07EtmofH7MmSSeueDfaEbSo3W5zSfEgFksfmq?=
 =?us-ascii?Q?xf1D/994n4YxTDAd6HdyPOZGqIXpm7FGCDN0Oli4Wo8gC0MOCx3n81ia1Yri?=
 =?us-ascii?Q?AXNYKzFtQSIMZW/H/ru5TEeLSNVsKfBWLw0CQAsbv21G/THfOxI07b7me0zS?=
 =?us-ascii?Q?35CgWNm75j53q7YVpvWmnjupCVPPdngFpsHL9wBambVa+O4H9JXmLTDwbYCX?=
 =?us-ascii?Q?SqDM57qIHe5v4Lzi1JjqhBg3fkdAbWclqstEMSO877FHHsZdnFG+IM3VTi1X?=
 =?us-ascii?Q?yBb9lK1nLJHMuNvA34CGd8EJ+jRssUWirtX07B95LZLzgYKmmUWJr5pWQIX3?=
 =?us-ascii?Q?tjVvoNEY93xr2EsQtyRSXMC8cBMyDO18/kNcRmSoOEK+7sDF16zub4mpYP8D?=
 =?us-ascii?Q?/kCaMr0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef70a96b-ba7c-4009-7ad9-08ded0d00e41
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 02:35:14.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10512


From: Jun Miao <jun.miao@intel.com> Sent: Monday, June 22, 2026 5:21 AM
>

[Adding LKML to the Cc: list]

> Under heavy concurrent DMA traffic, inc_used_and_hiwater() performs an
> atomic_long_add_return() plus a CAS loop on the global used_hiwater, and
> dec_used() performs an atomic_long_sub() on total_used.

This statement seems overly broad. Normally the swiotlb is rarely used, so
heavy concurrent DMA traffic doesn't generate this problem. The bad case
would be in a CoCo VM where all DMA traffic goes through the swiotlb. If
your statement is based on the CoCo VM case, please call that out.

> All CPUs contend
> on the same cacheline, causing measurable throughput degradation at scale=
.
> Both counters are debug-only (CONFIG_DEBUG_FS).
>=20
> Move hiwater tracking into struct io_tlb_area, where area->used is
> already maintained under area->lock:
>=20
> - Add unsigned long used_hiwater to struct io_tlb_area.  Update it
>   inside the existing area->lock critical section in
>   swiotlb_search_pool_area() immediately after area->used is
>   incremented, at zero additional synchronisation cost.
>=20
> - Remove atomic_long_t total_used and used_hiwater from struct
>   io_tlb_mem; make inc_used_and_hiwater()/dec_used() empty stubs.
>=20
> - Unify the two CONFIG_DEBUG_FS / !CONFIG_DEBUG_FS versions of
>   mem_used() into a single implementation that sums per-area used
>   counts with READ_ONCE().
>=20
> - Rewrite io_tlb_hiwater_get() to sum area->used_hiwater across all
>   areas (locklessly with READ_ONCE()); rewrite io_tlb_hiwater_set() to
>   reset each area under its own spinlock.
>=20
> Result: zero global atomic operations on the DMA map/unmap hot path.

Another result (as I describe below in the code) is that the reported
hiwater value can now be egregiously wrong. Back when I added
reporting the hiwater value in commit 8b0977ecc8b3, there was
considerable discussion of the potential impact of the atomic operations,
and the decision was to place reporting under CONFIG_DEBUG_FS as a
mitigation option if needed.

At the time, the use case for the hiwater mark was to enable a sysadmin
to see how much peak swiotlb space is needed for a particular workload.
This info would allow the swiotlb size to be set smaller than the rather la=
rge
default that is used in CoCo VMs, and free up memory for real workload
usage. I thought about the approach you've taken here, but my view at
the time was that approach is inaccurate enough so as to be fairly
worthless for the intended use case.

>=20
> Without this patch, the inc_used_and_hiwater() accounts for the most time
> from perf assembly record as following log:
>=20
>        | spin_unlock_irqrestore():
>        | - call    _raw_spin_unlock_irqrestore
>        | swiotlb_area_find_slots():
>  10.38 |   mov    $0x60(%rsp),%rax
>   0.00 |   mov    $0x2b8(%rax),%rcx
>        | arch_atomic64_add_return():
>   0.00 |   mov    %r15,%rax
>   0.00 |   lock    xadd    %rax,0x58(%rcx)
>  66.74 |   lea    (%r15,%rax,1),%rdx
>        | arch_atomic64_read():
>   0.14 |   mov    $0x60(%rcx),%rax
>        | inc_used_and_hiwater():
>  19.74 |   cmp    %rdx,%rax
>        |   jae    43f
>        | arch_atomic64_try_cmpxchg():
>        |   lock    cmpxchg %rdx,0x60(%rcx)
>        |   jne    432
>        | swiotlb_area_find_slots():
>   0.07 |   mov    %ebx,%eax
>   0.04 |   jmp    289
>        | wrap_area_index():
>        |   xor    %edx,%edx
>        |   jmp    3fb
>=20
> Suggested-by: Fan Du <fan.du@intel.com>
> Co-developed-by: Chenhgs <chenhgs@chinatelecom.cn>
> Tested-by: Chenhgs <chenhgs@chinatelecom.cn>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> ---
>  include/linux/swiotlb.h |   7 ---
>  kernel/dma/swiotlb.c    | 109 +++++++++++++++++-----------------------
>  2 files changed, 45 insertions(+), 71 deletions(-)
>=20
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..a92496786cb5 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -97,11 +97,6 @@ struct io_tlb_pool {
>   * @lock:	Lock to synchronize changes to the list.
>   * @pools:	List of IO TLB memory pool descriptors (if dynamic).
>   * @dyn_alloc:	Dynamic IO TLB pool allocation work.
> - * @total_used:	The total number of slots in the pool that are currently=
 used
> - *		across all areas. Used only for calculating used_hiwater in
> - *		debugfs.
> - * @used_hiwater: The high water mark for total_used.  Used only for rep=
orting
> - *		in debugfs.
>   * @transient_nslabs: The total number of slots in all transient pools t=
hat
>   *		are currently used across all areas.
>   */
> @@ -119,8 +114,6 @@ struct io_tlb_mem {
>  	struct work_struct dyn_alloc;
>  #endif
>  #ifdef CONFIG_DEBUG_FS
> -	atomic_long_t total_used;
> -	atomic_long_t used_hiwater;
>  	atomic_long_t transient_nslabs;
>  #endif
>  };
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..9b4130e3f8e8 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -107,12 +107,15 @@ static unsigned long default_nareas;
>   * This is a single area with a single lock.
>   *
>   * @used:	The number of used IO TLB block.
> + * @used_hiwater: Per-area high-water mark of used slots. Updated under
> + *		@lock; read locklessly for approximate debugfs reporting.
>   * @index:	The slot index to start searching in this area for next round=
.
>   * @lock:	The lock to protect the above data structures in the map and
>   *		unmap calls.
>   */
>  struct io_tlb_area {
>  	unsigned long used;
> +	unsigned long used_hiwater;
>  	unsigned int index;
>  	spinlock_t lock;
>  };
> @@ -959,40 +962,6 @@ static unsigned int wrap_area_index(struct io_tlb_po=
ol *mem, unsigned int index)
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
> @@ -1132,9 +1101,10 @@ static int swiotlb_search_pool_area(struct device =
*dev, struct io_tlb_pool *pool
>  	 */
>  	area->index =3D wrap_area_index(pool, index + nslots);
>  	area->used +=3D nslots;
> +	if (area->used > area->used_hiwater)
> +		area->used_hiwater =3D area->used;
>  	spin_unlock_irqrestore(&area->lock, flags);
>=20
> -	inc_used_and_hiwater(dev->dma_io_tlb_mem, nslots);
>  	return slot_index;
>  }
>=20
> @@ -1295,29 +1265,12 @@ static int swiotlb_find_slots(struct device *dev,=
 phys_addr_t orig_addr,
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
>   *
> - * The result is not accurate, see mem_used().
> + * Returns the sum of per-area used slot counts. The result is approxima=
te
> + * since there is no locking across areas.
>   *
>   * Return: Approximate number of used slots.
>   */
> @@ -1327,7 +1280,7 @@ static unsigned long mem_pool_used(struct io_tlb_po=
ol *pool)
>  	unsigned long used =3D 0;
>=20
>  	for (i =3D 0; i < pool->nareas; i++)
> -		used +=3D pool->areas[i].used;
> +		used +=3D READ_ONCE(pool->areas[i].used);
>  	return used;
>  }
>=20
> @@ -1335,8 +1288,8 @@ static unsigned long mem_pool_used(struct io_tlb_po=
ol *pool)
>   * mem_used() - get number of used slots in an allocator
>   * @mem:	Software IO TLB allocator.
>   *
> - * The result is not accurate, because there is no locking of individual
> - * areas.
> + * Returns the sum of per-area used slot counts across all pools. The re=
sult
> + * is approximate since there is no locking across areas.
>   *
>   * Return: Approximate number of used slots.
>   */
> @@ -1357,8 +1310,6 @@ static unsigned long mem_used(struct io_tlb_mem *me=
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
> @@ -1508,8 +1459,6 @@ static void swiotlb_release_slots(struct device *de=
v, phys_addr_t tlb_addr,
>  		mem->slots[i].list =3D ++count;
>  	area->used -=3D nslots;
>  	spin_unlock_irqrestore(&area->lock, flags);
> -
> -	dec_used(dev->dma_io_tlb_mem, nslots);
>  }
>=20
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> @@ -1531,7 +1480,6 @@ static bool swiotlb_del_transient(struct device *de=
v, phys_addr_t tlb_addr,
>  	if (!pool->transient)
>  		return false;
>=20
> -	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
>  	swiotlb_del_pool(dev, pool);
>  	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
>  	return true;
> @@ -1710,20 +1658,53 @@ static int io_tlb_used_get(void *data, u64 *val)
>  static int io_tlb_hiwater_get(void *data, u64 *val)
>  {
>  	struct io_tlb_mem *mem =3D data;
> +	unsigned long hiwater =3D 0;
> +	struct io_tlb_pool *pool;
> +	int i;
>=20
> -	*val =3D atomic_long_read(&mem->used_hiwater);
> +#ifdef CONFIG_SWIOTLB_DYNAMIC
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pool, &mem->pools, node)
> +		for (i =3D 0; i < pool->nareas; i++)
> +			hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> +	rcu_read_unlock();
> +#else
> +	pool =3D &mem->defpool;
> +	for (i =3D 0; i < pool->nareas; i++)
> +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);

Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The approach
of calculating a separate hiwater mark for each area, and then summing
those per-area hiwater marks, can produce very wrong results.

Consider a 64MiB swiotlb in a system with 8 CPUs. There will be 8 areas,
each with 8 MiB of space. Suppose the workload putters along with mostly
smallish I/Os, say between 4 KiB and 32 KiB. If each area has 16 I/Os in
progress, the area hiwater mark might be 256 KiB (16 I/Os averaging 16 KiB
each). Summing across areas produces a hiwater mark of 8 * 256 KiB =3D 2 Mi=
B.
But then suppose a 2 MiB I/O comes in. The hiwater mark for the area that
handles that I/O will grow to 2+ MiB. After the first big I/O finishes,
 another 2 MiB I/O comes in that is handled by a different area, whose
hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have a hiwater
mark of 2+ MiB, and the total hiwater mark is reported as 16+ MiB. The
old algorithm would have reported 4+ MiB, which is accurate. With
higher CPU counts and more areas, the discrepancy can get much worse.
This is a somewhat contrived example, but the problem is real enough
to make the reported hiwater mark be unreliable.

I'm sure the contention for the total hiwater mark in the current code is
real, but it's in the context of a lot of other CPU work that is being beca=
use
of the bounce buffering, including copying lots of data to/from the bounce
buffers. Is that atomic increment operation a bottleneck even in the
end-to-end context of doing DMA through swiotlb bounce buffers?

Another approach to the contention problem would be to have a separate
CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
computation of the hiwater mark can be dropped entirely in production
environments. Or the setting could be dynamic at runtime via a
static_call, defaulting to not computing the hiwater mark while still
allowing a sysadmin to turn it on to see workload usage of the swiotlb.

Michael

> +#endif
> +	*val =3D hiwater;
>  	return 0;
>  }
>=20
>  static int io_tlb_hiwater_set(void *data, u64 val)
>  {
>  	struct io_tlb_mem *mem =3D data;
> +	struct io_tlb_pool *pool;
> +	unsigned long flags;
> +	int i;
>=20
>  	/* Only allow setting to zero */
>  	if (val !=3D 0)
>  		return -EINVAL;
>=20
> -	atomic_long_set(&mem->used_hiwater, val);
> +#ifdef CONFIG_SWIOTLB_DYNAMIC
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(pool, &mem->pools, node)
> +		for (i =3D 0; i < pool->nareas; i++) {
> +			spin_lock_irqsave(&pool->areas[i].lock, flags);
> +			pool->areas[i].used_hiwater =3D 0;
> +			spin_unlock_irqrestore(&pool->areas[i].lock, flags);
> +		}
> +	rcu_read_unlock();
> +#else
> +	pool =3D &mem->defpool;
> +	for (i =3D 0; i < pool->nareas; i++) {
> +		spin_lock_irqsave(&pool->areas[i].lock, flags);
> +		pool->areas[i].used_hiwater =3D 0;
> +		spin_unlock_irqrestore(&pool->areas[i].lock, flags);
> +	}
> +#endif
>  	return 0;
>  }
>=20
> --
> 2.32.0
>=20

