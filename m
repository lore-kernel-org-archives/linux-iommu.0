Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013046.outbound.protection.outlook.com [52.103.14.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BB31AF1B
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572245; cv=fail; b=f8V0TaHTbr+35Qot6j/rfRyrOEKptzhu8YBkOQ35UvUn0TO8X8zNUymrBeU1f2oRvRaGitHDGpbdhBROnwiXk/kfXH5yVpmoPVjCKIWkN56Cjw5IlXGXt/7xSDlZF2cRDvmvlTQYIXtTF4bcQRbhsh7ceQYHkIcE+67L1l9TYWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572245; c=relaxed/simple;
	bh=4fHbVj6Lafv7ke7tHNMfKWtAejSDBFCm0NJm2o/g7Vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQB9Mt91TXpPwdHzE+fQBpI+Y6Yd6JJLcTyxL15ZMwpOTrHeXTFWCg+b8quOH6xsxY5OkldpXIfpsqLA4c7hYAfnYiVd3NsQFOsZvSF7YoVueRc13kqFQ4Tepued6WtYyD9JOtV8tttBU1ZvyW6X72UQ+xn6a+2n/yx7XGJSrdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lmM1jC6u; arc=fail smtp.client-ip=52.103.14.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lmM1jC6u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFpb9DOo3cBBGPdj3c6G2cJwPnZFI6xlrCWBTCM3kVwwnieUJvJgqetzAUz9XhXnfnxYH742I15B9YRbcvLIE9oS6F2BmQL1ygTa9lvCJhR6wu06P+Mo/0oVWIVQxSHC8qWoqJkkrB4kQ2N8TyHQcyJ8wTddbU4yB0bcUO+OTR7jCbh65XA+yA2D3ii+4TQxeYiiPnUuqGXjZHSPoUjrGuAn0aNITRxEFXcXr4LnNL9m7PDxMPG2d1ez4XmZMOUMLOR9+fH958cmNJ138IUzCystU+x6fRUBuW1boSrOaroEbEuLQMjpWDPFuXKKHfqwK0lo8ektc8pf0tNfHgKPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMaKZL5JbPPMZj8kvBYslRfRpeFleDgKVEwOl+6vN30=;
 b=TyGRdW3E9gR7jl+sQrzRPIefNWqcI+zs1o0V4BCzxYWyHJWzeaIZ+QOSYHASTSs0SFqNCcKHY/9rVshLZzx9AJiidkakZ3sO19Xt3woXnMTkncc3GUWE1hLaWRKOwzZPDhPHWQWKUrIqU6my+wTC8hq4CoHx4r8HJjpcItWsfrrb0H64u+MxcSV2lsobXcbf4pb6uPJzCSVOcd0STAEVjTAmJTKk1FJcF9Xvto562tfLdUwRn65vmmVD4PwL67SSlauDlp4fwDrKS7Z++eObEy83NTb1Bcpyoe4o9VIYaSztrB324k70+W9uHGLgAl0De/u6zcELp/pDRUl3Aqn/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMaKZL5JbPPMZj8kvBYslRfRpeFleDgKVEwOl+6vN30=;
 b=lmM1jC6u+aJoIX+xt16oeJFrre7VHjZqHWiuWkx6UWNmELy4RpOF5/eHXVrot9dvay23EbirkJiM/ruY5cYXDYEKVkw06jaaKe3Wa29gFbC0hNBPxPMCqsvtw+LqQlDDpm6aVYVOthAIE+dbvq/Jf9Ib4vYTAbUXcyZ3VWrJpD8YD3bcMnSQ8Rzhl60pmYtGtgL/55tl6uLLVp0aGkVG/UqwzOmRNz5BZh7YVk+DTXuoxeIGCIXE8Pqx8Q5unZGdBOZlhDmkUmqA1ds7o6zguN6Er5HNDd4BAAGU+9LrNA0oWpDMTi+Y0uqvwccnBfpwlZQ6WfUzMVA1slyRFE5Rpg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by SN4PR02MB11801.namprd02.prod.outlook.com (2603:10b6:806:21e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:30:40 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 18:30:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Frank Chen <frankchen158@126.com>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "fan.du@intel.com"
	<fan.du@intel.com>, "jun.miao@intel.com" <jun.miao@intel.com>,
	"chenhgs@chinatelecom.cn" <chenhgs@chinatelecom.cn>
Subject: RE: [PATCH] dma/swiotlb: make high watermark tracking boot-time
 opt-in
Thread-Topic: [PATCH] dma/swiotlb: make high watermark tracking boot-time
 opt-in
Thread-Index: AQHdE0B/rzk834vuuUWiLkwIiwhWZbZ2xTDg
Date: Mon, 20 Jul 2026 18:30:39 +0000
Message-ID:
 <BN7PR02MB41489054FA36992B3DB2800FD4C32@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <20260714032520.1058536-1-frankchen158@126.com>
In-Reply-To: <20260714032520.1058536-1-frankchen158@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|SN4PR02MB11801:EE_
x-ms-office365-filtering-correlation-id: 7e36fceb-5a0e-408d-a917-08dee68d0034
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|13091999003|31061999003|8062599012|19110799012|8060799015|25010399006|37011999003|15080799012|12121999013|8022599003|24021099003|55001999006|12091999003|56899033|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KL+QVq/jZskS98vijbULl6WrQ7R2Wt5uOVwdlkpvW/CvgpzxHc/fshY138m7?=
 =?us-ascii?Q?4t9BLHaSB+bjzyxnSIwKYdb3IGBY98AGPsQYtHjFIdXSBlepg+1SmkgCuRrv?=
 =?us-ascii?Q?hcU3dwuMdk7wsd72VYAppDpuFekEDGr8vDlONw9COIei1KvxCczY9savpZKa?=
 =?us-ascii?Q?VjhydfOgWV+1CQizkDOA1IaYlnjYgeVjRtXaeM7ShkYwrQWSj98z1vuK0bwy?=
 =?us-ascii?Q?4wk6eKzLZuhZEPvrV56gxm8T+mc7VGtJbe/DyrCPhUT7xjSofpiGfN/et674?=
 =?us-ascii?Q?OK+A+f/MkB919kTCUbVYqmE4J9hacP2BFtDQUSfpSWj9/bj7k9p32nBwZ4Iv?=
 =?us-ascii?Q?w/D9WYkYFTSkEVC18EkDV7QM+iCTJD1L8H7uGYKS5lCnOUr0wsUIxe07G0BY?=
 =?us-ascii?Q?0tNNDY2738xjdS2Q30U3Shm7DXLURXU5BdS4/rw8xP2ufKG436sgnwZ1AsvZ?=
 =?us-ascii?Q?giEEhyLobgLbyMz5IrPPoeICZb9ojyZCDRwAm3MKj3UC9umszB90PIcprFIh?=
 =?us-ascii?Q?ZcEhHFfAgbc+Y+pPX8K7PuN0BSUAIfcu4Yhia2UForkRSfhl6DJv46FTnyVD?=
 =?us-ascii?Q?FkcvgR82qiNVPX2cvw8ALdAAQZ+U/KV9/9l9M0uCbBmYlNCKbqMVPzM7OuNz?=
 =?us-ascii?Q?AXz1kv7uc8MS9XInhjcWWiy8WrjtlE1eJrKePMVmsr0fGLjPyUpZeKm1Q7cI?=
 =?us-ascii?Q?2ovPLrmblKr3bCu1hb25H0CdOCbsWJvJ1UoO6jGrfIuzTknA2BriizwCKj8p?=
 =?us-ascii?Q?8svQ6PgLrl2rwk+7IE9TSJdYy5Mub+oPhHeA11dYWTlrKRtbnKRA1bfEACFe?=
 =?us-ascii?Q?UNCTnEP4AwMny0RX/mBCGV7kCxu1rYgOiR9G4boYMkwIHKhJKUlWGEEKddvj?=
 =?us-ascii?Q?RlpsqDFOGyL2p3+DHQ3LEy73s7EDZUJ4Wp6g33YIOb04bii2oUr0OGQGSf3x?=
 =?us-ascii?Q?L6o22d/XUoIFg0UXxZj1TJ3xS40wIG2S/W6dTIDpferZLLolzO/e+w3433Ne?=
 =?us-ascii?Q?dyA7xfT8r8w0/EYCWpPp7Sv8TfkztJGqnWdDK8MReuwITaQOdCIiva0R9Pgj?=
 =?us-ascii?Q?vBVw1IyHnBmkcLgyjjGN8rs+BvQ4rg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r4NFyG1xQQuKSY7GBA9YXmuFh5cPGyBrV5YnFeiqFRc3E9hgZmBYT42pNd2K?=
 =?us-ascii?Q?bEaLQXPxMcCe17mBxosptEGwn+6l6fZPo5Q3Msf2+jDQHcBLl9ErsgP3rIHB?=
 =?us-ascii?Q?zF7gAC5wO9dvEo391teNujYmJa8MxxdW1daGuVFcMbFTSXgUd7Sfkc4cc8rQ?=
 =?us-ascii?Q?wWpol9ojQaKHh7Mi+nsFzaozBmm8/oF6F+eLsdhvulGs+rLoXOVghaA7clyo?=
 =?us-ascii?Q?h9gdbvQjX7XGUHr2Upmab1rd82N/+ozrbSkkpXjHl8y2Q8Vi3h0Jza6KDJka?=
 =?us-ascii?Q?eAwxVDeNZyJOGQYgs/UjRe0z7nInYfUcTf6qLoyJvfdED/SIOT/m01cTaNu+?=
 =?us-ascii?Q?a2VW36HYdWEEfWknG9B7RcWKvKQqidQeXdfxMVpU98nR228r8QSr0X+lSVUs?=
 =?us-ascii?Q?HSdqmRC3k9DPEDsNIOXMCnQYfanqQG0KYdLP1aLXPrVv81tVuUomrolhIDva?=
 =?us-ascii?Q?kr7vXwiPQ9UD2KG2ZimWiLCPucpU9ZRX0G9fb7AHdQLoXhQ5gLVLNZV8Ba7t?=
 =?us-ascii?Q?GLZbYp6yO2qkBzcys0DaBrHFE+2tAIr6M2MdHlolpCp/zuodIkHsokcS8+C4?=
 =?us-ascii?Q?JxJwZPJn2G6TsDMUQbBBM8BuWG3N2LcS15SX5ODzBtfEykjZYnyxUD+vD2N4?=
 =?us-ascii?Q?J+ZETqFG+TBxr4QiC7VGNhShs6nQ+xovp4RPmqboEm+W0wDFpz3T62vcQWtg?=
 =?us-ascii?Q?EA5Q5wb+KI7Ev48zWLdBtYLgdB5LfZ8j0npx8CD7GWLLjEKeU6iRXDGABaBp?=
 =?us-ascii?Q?+Y3h3jUYPlljkxB6PZ3qcdnslYYnggNEHWoOfVfcljBlbznjXgWXMeEuq7O2?=
 =?us-ascii?Q?LlpRDBq5fq2kBx3iWt3AFbfccI8lI0tn3DMt9en0J8x5Z1Jfc8VspUbycbX7?=
 =?us-ascii?Q?sMx9a8BEvdZmCzMjTc8BQDtv7dv4L1E24382uzqwEWpZgrcG1vQIWpCzEThw?=
 =?us-ascii?Q?RVirdvVBK4PENSiKOu5KVj0k4kXaA2i2k8cs60AG0wP2jC6dsE7Kxs+yY2l6?=
 =?us-ascii?Q?XUwd9yg2zOSPiOCerGYOM0/CSGnyj6sgbhNh/MvW7TUWlcKmVxG4++mKx/FL?=
 =?us-ascii?Q?xhNibFQdYXy+ldvxpUJrStaIA7I8NstYpg8ZDIWDon/OzBLiBT7agTLduAbJ?=
 =?us-ascii?Q?P6ZiZsH+m5saw4hruB5kO4JxN7jhDlvpiW57OhOaDh3sCiyJj+B9MOlF05aK?=
 =?us-ascii?Q?AAMntcYqvJDvXN+QyZld1lA+cAq1hTryJiHh2kdvzjDiHP9dk2to8WZgr5lQ?=
 =?us-ascii?Q?mBqV/5QIuvbWezLOiiMaZiSYIr00ruHCeNGD78ofDgIDzVVGIOrXA53Obcg4?=
 =?us-ascii?Q?SVVPWou1q0SrEsNoMGDJ0NynZoFMXcdZiEqWN/X7lg6W5nNg/RMPOCAFBLKG?=
 =?us-ascii?Q?wnp9FCc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e36fceb-5a0e-408d-a917-08dee68d0034
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 18:30:40.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR02MB11801

From: Frank Chen <frankchen158@126.com> Sent: Monday, July 13, 2026 8:25 PM
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
> unconditionally once the symbols were present. Make the tracking
> boot-time opt-in instead so that it is disabled by default with near-zero
> overhead via static_call, and can be enabled via "swiotlb=3Dtrack_hiwater=
"
> parameter on demand for debugging.
>=20
> Changes:
>=20
> - The previous inc_used_and_hiwater() maintained a separate atomic
>   total_used counter for accurate hiwater updates. This is replaced with
>   mem_used() which sums across areas. While less precise (no cross-area
>   locking), the result is adequate for high watermark statistics and
>   avoids the overhead of maintaining total_used on every alloc/free.

I'm not sold on giving up an accurate hiwater calculation. If it's
optional, let's have the option be to maintain total_used on every
alloc/free so the hiwater calculation is accurate.

Maintaining hiwater based on mem_used() is already pretty low
overhead in that it only does a global atomic operation if the hiwater is
raised. After a startup transient that establishes a typical steady-state
hiwater, most ongoing swiotlb alloc/free operations won't raise
the hiwater and so won't do any atomic operations to maintain it.

To recap, there are three levels of hiwater maintenance:

1) None
2) Based on the less precise mem_used()
3) Based on an atomically update global total_used value

The perf difference between #1 and #2 seems minimal outside of
the initial ramp to a steady-state hiwater value. The perf impact
of #3 can indeed be more significant, especially at high CPU counts.

Having the kernel boot line offer all three is arguably overkill.
I'd suggest offering #1 and #3 (with #1 as the default), or #2
and #3 (with #2 as the default and !CONFIG_DEBUG_FS providing
#1).

There's another aspect here as well. Robin Murphy had=20
suggested a sysctl option, so that the accurate hiwater maintenance
could be turned on/off at runtime, not just a boot time. My earlier
comment about boot time was probably unclear. I was thinking in
terms of a runtime option that could *also* be set at boot time, which
sysctl does. But I'll admit that enabling accurate hiwater calculation
at runtime is tricky because some swiotlb buffers may be allocated
at the time of the enablement, and total_used could go negative
when those are freed. For runtime sysctl enablement, would
probably have to do stop_machine() to freeze everything, and set
total_used to the value of mem_used() so that everything is
correct. I haven't worked through all the details.

All that said, I don't want to make too big of an issue out of this,
and end up over-engineering with complexity that exceeds the
value. I could be persuaded to have boot time enablement but
not runtime enablement. I'm less happy with losing entirely
the accurate calculation (my #3 above) that's in the current
upstream code.

Michael

>=20
> - Refactor high watermark tracking to use static_call, allowing it to be
>   enabled at boot via the swiotlb=3Dtrack_hiwater parameter when
>   CONFIG_DEBUG_FS is set. When disabled (the default), the static_call
>   resolves to a no-op function, ensuring near-zero overhead.
>=20
> - Remove the total_used atomic counter from io_tlb_mem since it is no
>   longer needed. The debugfs "io_tlb_used" file already uses mem_used()
>   to report current usage.
>=20
> Suggested-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>
> Co-developed-by: Fan Du <fan.du@intel.com>
> Signed-off-by: Fan Du <fan.du@intel.com>
> Tested-by: chenhuguanshen <chenhgs@chinatelecom.cn>
> Signed-off-by: chenhuguanshen <chenhgs@chinatelecom.cn>
> ---
> v1 -> v2:
>  - Change the patch title.
>  - Doing the exact hiwater calculation is dynamic and defaults to "off",
>    dynamic config would replace being under #ifdef CONFIG_DEBUG_FS
>  - The mechanism used for dynamic config needs to be one that is selectab=
le
>    on the kernel boot line so that the exact hiwater mark during boot is =
easily available.
>=20
> ---
>  .../admin-guide/kernel-parameters.txt         |   3 +-
>  include/linux/swiotlb.h                       |  10 +-
>  kernel/dma/swiotlb.c                          | 125 +++++++++---------
>  3 files changed, 68 insertions(+), 70 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> index b2d7d3540ded..bb60c55383a0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7485,7 +7485,7 @@ Kernel parameters
>  			Execution Facility on pSeries.
>=20
>  	swiotlb=3D	[ARM,PPC,MIPS,X86,S390,EARLY]
> -			Format: { <int> [,<int>] | force | noforce }
> +			Format: { <int> [,<int>] | force | noforce | track_hiwater }
>  			<int> -- Number of I/O TLB slabs
>  			<int> -- Second integer after comma. Number of swiotlb
>  				 areas with their own lock. Will be rounded up
> @@ -7493,6 +7493,7 @@ Kernel parameters
>  			force -- force using of bounce buffers even if they
>  			         wouldn't be automatically used by the kernel
>  			noforce -- Never use bounce buffers (for debugging)
> +			track_hiwater -- Track high watermark of swiotlb buffers
>=20
>  	switches=3D	[HW,M68k,EARLY]
>=20
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..e308792243cc 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -97,11 +97,8 @@ struct io_tlb_pool {
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
> + * @used_hiwater: The high watermark of used slots. Can be enabled at
> + *              boot time via swiotlb=3Dtrack_hiwater.
>   * @transient_nslabs: The total number of slots in all transient pools t=
hat
>   *		are currently used across all areas.
>   */
> @@ -119,9 +116,8 @@ struct io_tlb_mem {
>  	struct work_struct dyn_alloc;
>  #endif
>  #ifdef CONFIG_DEBUG_FS
> -	atomic_long_t total_used;
> -	atomic_long_t used_hiwater;
>  	atomic_long_t transient_nslabs;
> +	atomic_long_t used_hiwater;
>  #endif
>  };
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..5828163c15f7 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -180,8 +180,55 @@ static unsigned int limit_nareas(unsigned int nareas=
, unsigned
> long nslots)
>  	return nareas;
>  }
>=20
> -static int __init
> -setup_io_tlb_npages(char *str)
> +#ifdef CONFIG_DEBUG_FS
> +static unsigned long mem_used(struct io_tlb_mem *mem);
> +
> +/*
> + * Track the total used slots to determine the high watermark.
> + * Unlike the previous total_used atomic counter which provided
> + * exact values, mem_used() iterates areas without cross-area
> + * locking and may return imprecise results under concurrent
> + * alloc/free. This is acceptable for high watermark statistics
> + * and avoids the overhead of maintaining a dedicated atomic
> + * counter on every allocation and free.
> + */
> +static void account_hiwater_real(struct io_tlb_mem *mem)
> +{
> +	unsigned long old_hiwater, new_used;
> +
> +	new_used =3D mem_used(mem);
> +	old_hiwater =3D atomic_long_read(&mem->used_hiwater);
> +	do {
> +		if (new_used <=3D old_hiwater)
> +			break;
> +	} while (!atomic_long_try_cmpxchg(&mem->used_hiwater,
> +					  &old_hiwater, new_used));
> +}
> +
> +static void account_hiwater_nop(struct io_tlb_mem *mem)
> +{
> +}
> +
> +DEFINE_STATIC_CALL(swiotlb_account_hiwater, account_hiwater_nop);
> +
> +static __always_inline void account_hiwater(struct io_tlb_mem *mem)
> +{
> +	static_call(swiotlb_account_hiwater)(mem);
> +}
> +
> +#else
> +static __always_inline void account_hiwater(struct io_tlb_mem *mem)
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
> +static int __init setup_io_tlb_npages(char *str)
>  {
>  	if (isdigit(*str)) {
>  		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> @@ -194,10 +241,21 @@ setup_io_tlb_npages(char *str)
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
> +#ifdef CONFIG_DEBUG_FS
> +	if (*str =3D=3D ',')
> +		++str;
> +	if (!strncmp(str, "track_hiwater", 13)) {
> +		static_call_update(swiotlb_account_hiwater,
> +				   account_hiwater_real);
> +	}
> +#endif
>=20
>  	return 0;
>  }
> @@ -959,40 +1017,6 @@ static unsigned int wrap_area_index(struct io_tlb_p=
ool
> *mem, unsigned int index)
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
> @@ -1134,7 +1158,7 @@ static int swiotlb_search_pool_area(struct device *=
dev,
> struct io_tlb_pool *pool
>  	area->used +=3D nslots;
>  	spin_unlock_irqrestore(&area->lock, flags);
>=20
> -	inc_used_and_hiwater(dev->dma_io_tlb_mem, nslots);
> +	account_hiwater(dev->dma_io_tlb_mem);
>  	return slot_index;
>  }
>=20
> @@ -1295,24 +1319,6 @@ static int swiotlb_find_slots(struct device *dev,
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
> @@ -1357,8 +1363,6 @@ static unsigned long mem_used(struct io_tlb_mem *me=
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
> @@ -1508,8 +1512,6 @@ static void swiotlb_release_slots(struct device *de=
v,
> phys_addr_t tlb_addr,
>  		mem->slots[i].list =3D ++count;
>  	area->used -=3D nslots;
>  	spin_unlock_irqrestore(&area->lock, flags);
> -
> -	dec_used(dev->dma_io_tlb_mem, nslots);
>  }
>=20
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> @@ -1531,7 +1533,6 @@ static bool swiotlb_del_transient(struct device *de=
v,
> phys_addr_t tlb_addr,
>  	if (!pool->transient)
>  		return false;
>=20
> -	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
>  	swiotlb_del_pool(dev, pool);
>  	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
>  	return true;
> --
> 2.34.1
>=20

