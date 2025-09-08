Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5DD2EA48F;
	Mon,  8 Sep 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321093; cv=none; b=oJlL0b84lWWUhVduiXcu/4Od2WsUgCzHMH/BreRm1yA/IjoyUMKSyZGHl8uyDgI9+oZLu82zpNTcs172UNu8ASZcwaGqVqLNNPJAEuWhfw4//AXQa/NJMk9SUcn8YmgdayZDvb/HfmPEGpIT9sfnks9CtvVasCcKSoZxTlboXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321093; c=relaxed/simple;
	bh=ql8XpPO4pnIk/zTdzShz8B907yhVPgqDuC2qlrQt4G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SvLPefQpKOGUQjs+dMco+DzwSoXTbFR+rohik6k0yEPUC3gi8PDSj5lSqIef3b34IYpFQRkt8XyP6ykLIfRbVtjDCjRQ+8zhRiaCUBwRSlSq0KAZBuW110J3DKnd3UG6b1VjcAws7n+b+WjXthCnHbpG+D3PVc6xrZnxObDW6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My3mFvQb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My3mFvQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B3C4CEF1;
	Mon,  8 Sep 2025 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757321092;
	bh=ql8XpPO4pnIk/zTdzShz8B907yhVPgqDuC2qlrQt4G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=My3mFvQbWhTD7RqJwOV798lLE6KqZciudShEGZsVIO/jkxa4ZlRB7xLl+adLgylVf
	 6kUXkd8i7lGp2+n8437K7WbYldGD3nMM2nph4prK0uxO6dzTC/s5BpGaNBG2U+iV8+
	 5fXXZ7FE+gfNcxNk9uhiNPGwU5Dg/EiXUKlFclCZFtg5se+2iMOhrXTI3EG+OrwVbB
	 GX3xbuJE3pFL/wOHr4QmSnjR1Fd5DD4KmwIWfziT2Nyck1392RX5Mo6glYqJ+CDgiL
	 HtU/xxPj3btXULO20vmLH3QPYeKBTocuX4cdsc98Tbm3Cm9Sf9jUBWLIm29OADf9Jm
	 RZ2Noevv6Mmaw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, robin.murphy@arm.com, suzuki.poulose@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
In-Reply-To: <87qzwlwciv.ffs@tglx>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <87qzwlwciv.ffs@tglx>
Date: Mon, 08 Sep 2025 14:14:31 +0530
Message-ID: <yq5aldmp1ggg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, Sep 05 2025 at 11:24, Aneesh Kumar K. V. wrote:
>> When running with private memory guests, the guest kernel must allocate
>> memory with specific constraints when sharing it with the hypervisor.
>>
>> These shared memory buffers are also accessed by the host kernel, which
>> means they must be aligned to the host kernel's page size.
>>
>> This patch introduces a new helper, arch_shared_mem_alignment(), which
>
> # git grep "This patch" Documentation/process/
>
>> can be used to enforce proper alignment of shared buffers.
>>
>> The actual implementation of arch_shared_mem_alignment() is deferred
>> to a follow-up patch.
>>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/include/asm/mem_encrypt.h |  6 ++++++
>>  arch/arm64/mm/init.c                 |  4 +++-
>>  arch/arm64/mm/mem_encrypt.c          |  6 ++++++
>>  drivers/irqchip/irq-gic-v3-its.c     |  8 ++++++--
>>  include/linux/mem_encrypt.h          |  7 +++++++
>>  include/linux/swiotlb.h              |  7 ++++---
>>  kernel/dma/direct.c                  |  7 +++++++
>>  kernel/dma/pool.c                    |  1 +
>>  kernel/dma/swiotlb.c                 | 28 +++++++++++++++++-----------
>
> This does too many things at once and breaks all swiotlb users except
> arm64. Seriously?
>
>> -void swiotlb_init(bool addressing_limited, unsigned int flags);
>> +void swiotlb_init(bool addressing_limited, unsigned int alignment, unsi=
gned int flags);
>
> Why do you need this alignment argument in the first place?
>
> In quite some other places you use arch_shared_mem_alignment(), which
> defaults to PAGE_SIZE if the architecture does not implement it's own
> variant. What's preventing you from using that in the init functions as
> well?
>

This patch is required to ensure that a guest using a 4K page size can
safely share pages with a non-secure host that uses a 64K page size.
Without this, the non-secure host may inadvertently map protected
memory.

Memory attribute tracking in the non-secure host (via
set_guest_memory_attributes()) operates in units of the host's
PAGE_SIZE. Attempting to set memory attributes at 4K granularity=E2=80=94wh=
en
the host uses 64K pages=E2=80=94will fail with -EINVAL. This makes it impos=
sible
to correctly manage mixed-private/shared regions without enforcing
alignment between guest and host page sizes or introducing finer-grained
handling.


-aneesh
