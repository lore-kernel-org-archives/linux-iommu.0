From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH v3 2/2] iommu: Remove cpu-local spinlock
Date: Wed, 01 Jun 2016 15:40:08 +0300
Message-ID: <1464784808.6283.4.camel@linux.intel.com>
References: <1464776603-11998-1-git-send-email-chris@chris-wilson.co.uk>
	 <1464779409-26711-1-git-send-email-chris@chris-wilson.co.uk>
	 <1464779409-26711-2-git-send-email-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464779409-26711-2-git-send-email-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Wilson <chris@chris-wilson.co.uk>, Joerg Roedel <joro@8bytes.org>
Cc: intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On ke, 2016-06-01 at 12:10 +0100, Chris Wilson wrote:
> By avoiding cross-CPU usage of the per-cpu iova cache, we can forgo
> having a spinlock inside the per-cpu struct. The only place where we
> actually may touch another CPU's data is when performing a cache flus=
h
> after running out of memory. Here, we can instead schedule a task to =
run
> on the other CPU to do the flush before trying again.
>=20
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> ---
> =C2=A0drivers/iommu/iova.c | 29 ++++++-----------------------
> =C2=A01 file changed, 6 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index e23001bfcfee..36cdc8eeab1c 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -390,6 +390,11 @@ free_iova(struct iova_domain *iovad, unsigned lo=
ng pfn)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(free_iova);
> =C2=A0
> +static void free_this_cached_iovas(void *info)
> +{
> +	free_cpu_cached_iovas(smp_processor_id(), info);
> +}
> +
> =C2=A0/**
> =C2=A0 * alloc_iova_fast - allocates an iova from rcache
> =C2=A0 * @iovad: - iova domain in question
> @@ -413,17 +418,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsi=
gned long size,
> =C2=A0retry:
> =C2=A0	new_iova =3D alloc_iova(iovad, size, limit_pfn, true);
> =C2=A0	if (!new_iova) {
> -		unsigned int cpu;
> -
> =C2=A0		if (flushed_rcache)
> =C2=A0			return 0;
> =C2=A0
> =C2=A0		/* Try replenishing IOVAs by flushing rcache. */
> =C2=A0		flushed_rcache =3D true;
> -		preempt_disable();
> -		for_each_online_cpu(cpu)
> -			free_cpu_cached_iovas(cpu, iovad);
> -		preempt_enable();
> +		on_each_cpu(free_this_cached_iovas, iovad, true);

This is not on a hot path, so should be worthy change.

Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Regards, Joonas

> =C2=A0		goto retry;
> =C2=A0	}
> =C2=A0
Joonas Lahtinen
Open Source Technology Center
Intel Corporation
