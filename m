Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D523D7C2;
	Fri, 29 May 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067332; cv=none; b=IF33EBpIbeVeIWgLADNtEryaDbWT+epffyUrQD/IHsmG1iuRCmvSTceiWgb6Ykj6f85+fH1n7ksMST0I4bEJC3BkN5LD5934EPHKR3rLo7ji84v+Or4U31Mv11rMQNBmddNncfwkGCVPic2xjyW3FKZ50or+dtN5dQv3jvE3tw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067332; c=relaxed/simple;
	bh=1bbXIq51DuToLc697H/y4vnrxG/K8cvg3p+FPcmg9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvO/FCAOdW6ElQMOBo4+mP1uAB2Up4NBDd9Z1wnUvhFAnnmaGG6VjxtM7qjwtxbD3q+z2uxbzdNwn0I/MhuVYOlomZixvICwVVprynpzfLzVgYAio0wy3YcQPZzAryHNFwJL14CNE7HCidUXTqCNyEoulexR1CJU+i4e06lHjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR2pXawp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR2pXawp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879E21F00893;
	Fri, 29 May 2026 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780067330;
	bh=Z+neS3Llvyfy3P4tauMZpeOCQxOmOPM92PXLEWzDVW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lR2pXawpPwU7zOlNmNYRWyqr6Rs8IREQyqXMAgYbEUQnkqvx5JDHA1xCz0bi7n4E5
	 FvbfKcblWQTnP5e/D/SsEZl0f8k2dCUK+A6vkCoMuv0DrYH6JlkQ8mzfqdsO2rb3yy
	 Ii03QBrvON1RZGmF0snsD1x+dVkZ74002GDXbRNsK3428w0kwgNIABDZygdD2YlsyK
	 Et+xwQ2V5wuhOItthhp2u/f1mFJ/EAX7OrQ1vi30I0PkzggRH6bRUz60RJJwtEplpE
	 buDUncSPwMsci9bBxMrD7aHU3hDo4xpDCHbrh5H8bQOLqgyOjvPiHe3IFaYQXPN3hU
	 NRKVFqyew03qQ==
Date: Fri, 29 May 2026 16:08:41 +0100
From: Will Deacon <will@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 09/11] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
Message-ID: <ahmr-UjoApj2j5JS@willie-the-truck>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-10-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527032917.3385849-10-chenwandun1@gmail.com>

On Wed, May 27, 2026 at 11:29:15AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> Reserved memory regions are excluded from vmcore by default unless
> marked dumpable. Honor the dumpable flag to filter out device firmware
> regions (e.g., GPU, DSP, modem) reserved via device tree, since they
> typically contain data not useful for kernel crash analysis and can
> significantly increase vmcore size.
> 
> Use of_reserved_mem_kdump_exclude() to perform the exclusion, and
> pre-size the crash_mem array via of_reserved_mem_kdump_nr_ranges().
> 
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index e31fabed378a..1d65320c6ba4 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -17,6 +17,7 @@
>  #include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> @@ -51,6 +52,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  	nr_ranges = 2; /* for exclusion of crashkernel region */
>  	for_each_mem_range(i, &start, &end)
>  		nr_ranges++;
> +	nr_ranges += of_reserved_mem_kdump_nr_ranges();
>  
>  	cmem = kmalloc_flex(*cmem, ranges, nr_ranges);
>  	if (!cmem)
> @@ -75,6 +77,10 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
>  			goto out;
>  	}
>  
> +	ret = of_reserved_mem_kdump_exclude(cmem);
> +	if (ret)
> +		goto out;
> +
>  	ret = crash_prepare_elf64_headers(cmem, true, addr, sz);

This looks fine to me:

Acked-by: Will Deacon <will@kernel.org>

Although I do wonder whether there's scope to consolidate some of the
arch code here. Now that you have a helper for reserved memory, perhaps
the core code could also handle the crashkernel reservation itself as
well? If the arch code passed in its number of memory regions, the
core code could take care of (a) allocating the crash_mem ranges array
(b) excluding the crashkernel and (c) excluding the reserved regions
(the part you have here).

Obviously that would be follow-up work, but the fact that you're having
to apply basically the same diff to three architectures is a bit of a
giveaway that this could benefit from some wider cleanup.

Will
