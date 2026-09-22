Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BB4D2ED0;
	Tue, 22 Sep 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067777; cv=none; b=RnuoliJDdGiVskCnUt7bmx+5E/V8iM4hVNJc6bpDL7mOY3g3+yM+NhvUnXP+/FId8/MCnTTpPdy2EtRXtU0xfwXlVaXDPjV4A5VbR+MOl84ZTvwlTDuTc8bZdCTchP7eqCzigFqI+K+afYPlxqoYmzCq/LixZoohtv0M2RuFkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067777; c=relaxed/simple;
	bh=eDrtESrCV+F2i5tlO1zl18MePWnt6NhFaqPLy+AF5xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IjI8uPv5XsBwF6jEFCt4Ti/lDsk90K5EW8YKJ30HL/wf/IeXjbUqkHmRDmI5UMdckSM7KK7fnXpfO0MnZC3BrzWGW9fLKfrAJdjTtiOJcUXaIU0GAlzBLC7JLSZEncRpBdyKIjlr+nT1XUXkN7g69eY8fofq/8B1J1uzbTCTUk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e17ouVhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e17ouVhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01541F000FF;
	Tue, 22 Sep 2026 09:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067775;
	bh=JnhzTAx413FwpdKahXPNOcr3FwWYv2J2Y6dhd+67auQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e17ouVhx7pCa4EJXvSkinhLyV94jWOdGlljXb86UFt04mTtWxN7lu6AysEmUU3QLo
	 AY/5/KTGz63a1+nHe+QBAv7i9L3bkjvPynyjRfU1ZKNv39Ud+MifCRynvPn4HfDheh
	 /qodv7Z+OrXbHXZqlzP36IohhsehpVwOMtTCPMRaUWthRowSEohGKneZhUzEIWf48B
	 +RQ0gOP/EPvltRkXJ/AL9wU/EPgrO8maZ0xKOAvkdpqMfAX5JcoShYoS+IQIzmWQkZ
	 cfWweH9aPTBakCZQdL3x6Uw1Z/VAMetOe1jYzWpZLI1Hjn9BkaGnmlNtDWAUYaCfP/
	 WkRJ8YEnGI6hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] memblock: introduce MEMBLOCK_NODUMP flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, rppt@kernel.org, baoquan.he@linux.dev, m.szyprowski@samsung.com
Cc: aou@eecs.berkeley.edu, palmer@dabbelt.com, akpm@linux-foundation.org, conor+dt@kernel.org, bp@alien8.de, pasha.tatashin@soleen.com, ruirui.yang@linux.dev, mingo@redhat.com, hpa@zytor.com, saravanak@kernel.org, x86@kernel.org, robin.murphy@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, alex@ghiti.fr, pratyush@kernel.org, kernel@xen0n.name, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-riscv@lists.infradead.org, pjw@kernel.org, loongarch@lists.linux.dev, tglx@kernel.org, linux-mm@kvack.org, chenhuacai@kernel.org
In-Reply-To: <20260922084256.1515554-6-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-6-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:02:52 +0000
Message-Id: <20260922090252.B01541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: lockless mutation of memblock.memory causes UAF in concurrent =
readers
--

commit 3e0d4f57949330268c708beeb66dc1c0fb65db32
Author: Wandun Chen <chenwandun@lixiang.com>
Subject: memblock: introduce MEMBLOCK_NODUMP flag

This patch introduces the MEMBLOCK_NODUMP flag to mark memory regions that
should be excluded from kdump vmcores. It also adds logic to clear this flag
when reserved memory, such as the initrd, is freed so the memory can be
properly reused.

> diff --git a/mm/memblock.c b/mm/memblock.c
> index ea0de4b5f3568..48cabfe5cdf16 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
[ ... ]
> @@ -949,9 +951,13 @@ unsigned long free_reserved_area(void *start, void *=
end, int poison, const char
>  	}
> =20
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> -		if (start_pa < end_pa)
> +		if (start_pa < end_pa) {
>  			memblock_remove_range(&memblock.reserved,
>  					      start_pa, end_pa - start_pa);
> +
> +			if (IS_ENABLED(CONFIG_CRASH_DUMP))
> +				memblock_clear_nodump(start_pa, end_pa - start_pa);
> +		}
>  	}

[Severity: High]
Could this lockless mutation of memblock.memory race with concurrent reader=
s?

This code path is triggered during asynchronous initrd freeing
(e.g., via do_populate_rootfs using async_schedule_domain).

Calling memblock_clear_nodump() modifies the memblock.memory array lockless=
ly
via memblock_setclr_flag() and memblock_isolate_range().
memblock_isolate_range() can split ranges using memmove(), which disrupts
array ordering, and can even call memblock_double_array() which kfree()s
the old array.

Concurrently, subsystems rely on memblock.memory being immutable after early
boot. For example, on ARM64, ioremap() calls pfn_is_map_memory(), which
performs a lockless binary search (memblock_search()) directly on
memblock.memory.regions.

If memblock_clear_nodump() splits or reallocates the array while ioremap()
is executing during driver probes, could this result in a use-after-free
on the freed array or an out-of-bounds access from broken binary search
invariants?

[ ... ]
> @@ -995,8 +1001,11 @@ int __init_memblock memblock_phys_free(phys_addr_t =
base, phys_addr_t size)
> =20
>  	kmemleak_free_part_phys(base, size);
> =20
> -	if (!slab_is_available() || IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> +	if (!slab_is_available() || IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>  		ret =3D memblock_remove_range(&memblock.reserved, base, size);
> +		if (IS_ENABLED(CONFIG_CRASH_DUMP))
> +			memblock_clear_nodump(base, size);
> +	}

[Severity: High]
Similar to the above, does this introduce the same lockless mutation risk
when called during runtime module unloads or CMA frees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D5
