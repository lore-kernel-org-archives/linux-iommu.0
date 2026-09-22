Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BE2E0914;
	Tue, 22 Sep 2026 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067903; cv=none; b=b7SlO2izYAZBpCd/Y7913y53Lso3yNl3MFOyfJSJF3ZyYlnF16IiCmwx+a7qqldSuUOd+JyR0BGq0DJeUf6AW96p+gU2WT7Q2rG7nFwMRhSJSPro5jia57yYjPyXXaIp+vdKw2c47WaHZ3MP0PvuINsPJ0tgXdc6pM7L8/GtS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067903; c=relaxed/simple;
	bh=Iib6UzcABQ6xYqcy3qwfLHQr9tDa9Fk17JJoNSXf8h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAfdsqHa4QNccKNkrc+ETXa3x7VhaMXwNma4GtN1pYG+NwJy7bmd/VMEXiHZkE3rTfxr4KVqiTXCW4CQnKScJrj9ICFNI1+YWtqIYlxHUKUXz7NhDcJqDAWH427qdLsZvTrTzQwxBW6+8Oz7N0v/WE8mt9RxKNhM5yUOJXUzt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9LHr2Wd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9LHr2Wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5581F000FF;
	Tue, 22 Sep 2026 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067901;
	bh=gVJZTypgXfKJStNVi3R0a2JQB/tvx6NLIBfpEAfH+Ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9LHr2Wd4Rxx3+1boxWUT9I2oXWCmuvgxijo5nc6bPCgxtO998Rsh7NKemCZPMZ7q
	 jCqEgkFPjzxPK4mReOTTd/elY+ciGLQH0sdAs9Gj6meNVO4LfN2kzV+4LXR0oVx6SK
	 7ZH/T7Wv5A2AUNswlgh8q3cB2VzM3drCJ2lhSUow3TBR7t+5QqoSZi80Bp+U336otT
	 6+pWL7hrOojomJ2u753Enniueu6LZnlrBvU6X6vwp9prGtDnyfBK/IXM5CJdbxbR9Z
	 4Y6VvuOiSdy8+S0cHn5PGHelRvFyfDPZFS7siU3DaFG8DB1NQi0pi6gHzGpuQPP6oN
	 01swkhQ7UyoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] of: reserved_mem: mark /memreserve/ entries as
 MEMBLOCK_NODUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: robh@kernel.org, baoquan.he@linux.dev, "Wandun Chen" <chenwandun1@gmail.com>, rppt@kernel.org, m.szyprowski@samsung.com
Cc: saravanak@kernel.org, pjw@kernel.org, conor+dt@kernel.org, iommu@lists.linux.dev, ruirui.yang@linux.dev, linux-kernel@vger.kernel.org, mark.rutland@arm.com, loongarch@lists.linux.dev, tglx@kernel.org, bp@alien8.de, x86@kernel.org, pratyush@kernel.org, kexec@lists.infradead.org, chenhuacai@kernel.org, hpa@zytor.com, pasha.tatashin@soleen.com, mingo@redhat.com, linux-mm@kvack.org, robin.murphy@arm.com, linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu, linux-arm-kernel@lists.infradead.org, alex@ghiti.fr, catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, dave.hansen@linux.intel.com, akpm@linux-foundation.org, palmer@dabbelt.com, kernel@xen0n.name
In-Reply-To: <20260922084256.1515554-9-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-9-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:04:58 +0000
Message-Id: <20260922090459.2B5581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] of/fdt: silent u64 truncation in fdt_mark_memreserve_nodump caus=
es nodump false positives
--

commit 070ed699ada4d456618a640c6ad541abbec98f95
Author: Wandun Chen <chenwandun@lixiang.com>

of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP

The /memreserve/ entries are memory reservations made by the bootloader
or firmware, their contents are not needed for kernel crash analysis. This
commit marks them MEMBLOCK_NODUMP to omit them from the vmcore, while leavi=
ng
overlapping dumpable regions unmarked.

> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index f29a07e8fb23e..a42cf6eac55b5 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
[ ... ]
> @@ -251,6 +251,39 @@ static void __init __rmem_check_for_overlap(void)
>  	}
>  }
> =20
> +void __init fdt_mark_memreserve_nodump(void)
> +{
> +	u64 base, size;
> +	int n;
> +	const void *fdt =3D initial_boot_params;
[ ... ]
> +		for (i =3D 0; i < reserved_mem_count; i++) {
> +			struct reserved_mem *rmem =3D &reserved_mem[i];
> +
> +			if (rmem->dumpable &&
> +			    base < (u64)rmem->base + (u64)rmem->size &&
> +			    (u64)rmem->base < base + size)
> +				break;
> +		}
> +		if (i =3D=3D reserved_mem_count)
> +			memblock_mark_nodump(base, size);

[Severity: Medium]
Is there a risk of silent truncation here when passing u64 arguments to
memblock_mark_nodump() on 32-bit architectures?

The u64 base and size variables are passed directly to memblock_mark_nodump=
()
which takes phys_addr_t arguments. On a 32-bit architecture where phys_addr=
_t
is 32-bit, if the device tree contains a /memreserve/ entry with an address
greater than 4GB, fdt_mark_memreserve_nodump() reads it as a 64-bit value.

It performs a 64-bit overlap check against dumpable regions in reserved_mem.
Because the upper 32 bits differ, it concludes there is no overlap. It then
calls memblock_mark_nodump(), where the compiler silently truncates base to=
 32
bits.

Could this incorrectly mark the lower 32-bit address as MEMBLOCK_NODUMP,
mistakenly excluding any dumpable region located there that the overlap
check was intended to protect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D8
