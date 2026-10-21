Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588990;
	b=aEPNiCnomqIOsvrI4qZnh1e9OYq5Nz7iHHI0RgsFWksZEhFWEXG+wzx6T++qioMHjGYJ
	 2Imwa9Fzmw54qyf2Mg1Gob6i0+Q5hia6ojbP2tpwTBmo2awmMX4tOie79PtdR3JzjTm8d
	 NYfCEC1LLjMMDvQa1saMO5j3papKjwTPcPcI+xWhQecGqP6HTLaFQ9lmTaeB8I64PbhjK
	 V6wESdR5QJ4GwHZsJKcJ8JegfOj+A8gJKCx7y6XbO2A/CY67zuCq1DZvtdsQ5otumgRTZ
	 xGVG0pASSmQdAbahcHeuBMxhNUV9a4eDxbHbfYabPEjqfJf5y4CbrTtpy5NMdW78I9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588990;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pAAU30bwGvhgKc2fcWmaPUnM+q1nxRImGaxZJ4BonqU=;
	b=AbE/7N3t1LAA4DgssqqmX8LtJfAqXtmZlQiT45Z889uZtBajXpcFl2KTnUgChc2vTsSm
	 hRACr/Gv8g5G9hFbL11/zZTsRApvK4baxyrvAiwdITG+ctGumv2jn3yGmv2qvoA/J57wP
	 k+jNxokaCBQGyh+aMBFn5fdKa+C72hVZ7ecrvqYD0JEcJ96op+svo+MGUlHlvY0pCKg9h
	 GyqIrGyTiBqlntTbi8bKQqsaIWyEe60CJoG/oyUUpWM98HCUsPzW3kAse+zfzH5wBuv7i
	 DsaYBxyvYVVGntn/Q5L9cpEhGMUFimsofoqZ8Whwg83XvxxFpe+q6DohwvnwHSFKFtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt3hXrxe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16A606A326;
	Wed, 21 Oct 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt3hXrxe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039AE1F000C4;
	Wed, 21 Oct 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588990;
	bh=pAAU30bwGvhgKc2fcWmaPUnM+q1nxRImGaxZJ4BonqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mt3hXrxeKJoJfLibADZIcsXR7rI+NO9d5jFB7CsWQi7wKkA7Ivi+NuujoLsu6N0Sj
	 xeAk+R1NrRVYx1sYEncPNYK1tOB4gOmoV/soXvOeMmPj9evSIL4UZE8ME5ru4NQo5h
	 rdmao/ez90tKUwo3/XUgCH2iLLiz95UkX5/e2YrP1miGaCfo8O/R8cfIYLVig3VVnr
	 r1iNDVPFLS7bpM7kU7EAqqH+8hkxOiLRbqqi3tb+hZaOnZwWSQEHk7khqjrR4q7t3A
	 S0lU2etMBYUN25UboD24fjrlEjMmDt+fIwEsaB4T+GmpTzCmxcQVMevggk/I2FaJ6K
	 4dRr3m+UTBq7A==
Date: Wed, 21 Oct 2026 08:23:08 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	saravanak@kernel.org, akpm@linux-foundation.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v9 0/8] kdump: reduce vmcore size and capture time
Message-ID: <20261021132308.GB3667411-robh@kernel.org>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>

On Wed, Oct 21, 2026 at 04:30:03PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
> 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path: firmware reports those carveouts as unusable in
> the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
> (is_usable_memory(), efi-init.c), and the ELF header builder has
> always skipped nomap regions; only DT-based systems currently fail
> to filter these regions, which is what this series addresses.
> 
> This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
> memblock to filter reserved memory on DT-based architectures. A new
> flag is needed because MEMBLOCK_NOMAP can only express regions without
> a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
> linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
> so kdump omits them; reusable CMA regions are different because their
> pages are handed back to the buddy allocator and may carry crash-relevant
> data.

There is little point in continuing to send new versions until Mike 
agrees with MEMBLOCK_NODUMP being added. You didn't answer him on v7.

Also, I intend to apply this[1] before any further reserved memory 
changes which will greatly simplify the code.

Rob

[1] https://lore.kernel.org/all/20261015082315.56876-1-m.szyprowski@samsung.com/
