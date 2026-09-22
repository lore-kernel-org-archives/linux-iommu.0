Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B54D7D25;
	Tue, 22 Sep 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067691; cv=none; b=bos5jTsiDwgaUf9Fz5oql0NFPJX/K/I6ZU8qkBEyERNvp2qqf2A/S8Jc5M2SsTHbYWgFZ9IJDqCSm/dxpe2p6isK1k7AXR7vp7VCm8/xlMz2Ob2N+K3aTv/iXvRdTT85Q3SmlUI9MGiLMEGjiw77Wy7kfUM4rc1E0rbEcQh8QxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067691; c=relaxed/simple;
	bh=LFptJeZ/MOXnuUtOnXU11IKoEE1FtGg7p0aASVn4Go0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CRKbPntKMYRBwbKt/Dgn1Y2M9ujgD8+nyUt2FqfB6aLW39ZF4ILlIUvaFDk3EzRFXriaRFLrw/sKloMns0V5YQM28CING+iOzTTgiSIcnICgS6enEn/tdki52opNsF8GWahSRSoplcKxuWoIJ5vglE9x8jljDIGQBT9Cs+Dm/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKTk+bn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKTk+bn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DD21F000FF;
	Tue, 22 Sep 2026 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067689;
	bh=mjGPVOew5ysCF3WUc2TZ8QW0kJr9lTS0DgEOW24GPw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RKTk+bn3+WrRh+uEPi4QsKpCQMBXdiVXaebzTyFMU52JIHYsRCsBMfXvtU7rub77Q
	 c2fEr37xSa/FgKfpQbOmr0c9p9pK/zq6q4W/drmX1lPcv3vRb3icWMD4gg0qNqTTVp
	 uy4jqLPrcnvvlNYaJ71axxVw70rxXcvMAz1o7bQwK2I4DFT70VIVpDD/fsuuwVCvnA
	 gq5CeO6ZT33+PfALex/ZbfH0KlRpf3mb8fEQaBSo3yx6fPOHe5xxnwc1aQjElG4KjB
	 rL3CjuBhz5Xe/jnj1pnhwqK3B7MWS+9TGPt1ZlARHlpTuVgUjv3joyNdav1qEFlRuN
	 0jXrGWn1YgZuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] of: reserved_mem: mark /reserved-memory entries
 with MEMBLOCK_NODUMP
Reply-To: sashiko-reviews@lists.linux.dev
To: robh@kernel.org, "Wandun Chen" <chenwandun1@gmail.com>, m.szyprowski@samsung.com, baoquan.he@linux.dev, rppt@kernel.org
Cc: aou@eecs.berkeley.edu, akpm@linux-foundation.org, pjw@kernel.org, chenhuacai@kernel.org, mingo@redhat.com, kexec@lists.infradead.org, palmer@dabbelt.com, pasha.tatashin@soleen.com, hpa@zytor.com, ruirui.yang@linux.dev, iommu@lists.linux.dev, pratyush@kernel.org, kernel@xen0n.name, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, robin.murphy@arm.com, devicetree@vger.kernel.org, catalin.marinas@arm.com, alex@ghiti.fr, linux-kernel@vger.kernel.org, x86@kernel.org, will@kernel.org, loongarch@lists.linux.dev, saravanak@kernel.org, linux-riscv@lists.infradead.org, conor+dt@kernel.org, tglx@kernel.org, mark.rutland@arm.com, bp@alien8.de, dave.hansen@linux.intel.com
In-Reply-To: <20260922084256.1515554-8-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-8-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:01:25 +0000
Message-Id: <20260922090126.03DD21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] of: reserved_mem: unconditional MEMBLOCK_NODUMP breaks firmware de=
bugging
--

commit 70f4cbca539766519d8967f7e857d2db27db4c13
Author: Wandun Chen <chenwandun@lixiang.com>

of: reserved_mem: mark /reserved-memory entries with MEMBLOCK_NODUMP

This commit marks non-dumpable reserved-memory regions with MEMBLOCK_NODUMP
so kdump can omit them from the vmcore. The marking is guarded by
CONFIG_CRASH_DUMP to avoid splitting memblock.memory entries unnecessarily
on non-kdump kernels.

> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c

[ ... ]

> @@ -677,6 +677,21 @@ static void __init fdt_init_reserved_mem_node(...)
>  	reserved_mem_count++;
>  }
> =20
> +void __init fdt_mark_reserve_mem_nodump(void)
> +{
> +	struct reserved_mem *rmem;
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
> +		return;
> +
> +	for (i =3D 0; i < reserved_mem_count; i++) {
> +		rmem =3D &reserved_mem[i];
> +		if (rmem->size && !rmem->dumpable)
> +			memblock_mark_nodump(rmem->base, rmem->size);

[Severity: High]
Does this unconditional masking prevent debugging of coprocessor memory and
firmware state in vmcores?

Since only the CMA driver sets dumpable to true, it appears all other
generic /reserved-memory regions (such as DSP logs or ramoops) default
to false.

Because fdt_mark_reserve_mem_nodump() unconditionally applies
MEMBLOCK_NODUMP to these regions, and there is no Device Tree property
provided to opt them back in, is there a risk that system administrators
will lose the ability to inspect these regions after a crash?

> +	}
> +}
> +
>  struct rmem_assigned_device {
>  	struct device *dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D7
