Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACE3002A4;
	Fri,  5 Sep 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059488; cv=none; b=H9y27z6xtOsluFimtJb5rmrp4qaFpBqfBaU/xtovzjG4G5S5a6LArXuc2XZsMPuWZ+xdR/XhLWGpzWdmSIdrrynw70Cu4HgNBz6/but3maYtuCB/Vb51gAi8m3CEvKASgvDgSGc+8P2bpvBxwGILdviiQgzQAs69T9354rqAGIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059488; c=relaxed/simple;
	bh=QGKVrHrnICzFMyVbArbD3ExeehPmsCNYREmmPa7haEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmjaW4wv3nDWMF+ihgtNf5vYJOJT5WUivfxiA7DfVZa1yxLvBKngWkNaSpQpVknnkabgT1nMh5ErluKw/vmlVpSmq6OkAYxGwSzqAJsSekmVphUeLg3WiXwlUe3ApTV1Ne3x2VZ3JHIW+94zCk2GMHOPyYGFSdp/YrulGCgaVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/RQbQLv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8wu+DKsG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/RQbQLv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8wu+DKsG"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757059484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qptmhWEow2XN769eIxUwWzfBidCXD8AJeNJEY12zhuQ=;
	b=T/RQbQLvnHHzaa3kcgAR+LLn5ai0Ux033UjJXzWe3BHLGjUJPqE0zIGOS3UULgAsiVYO9j
	9leLirtrAXGc4SG8sOMyOUHFH1YJkZPefOOvbLMSdBkphuwAx4r4MIyypm9DAjyBXb1ESZ
	vQCfP5CmcPZAeFsAocnxOUsuczDYK4TQKn5JUddsnAkoFTwNLZ8F6nwPvf9oEOmwxkVtwY
	NO/mdeBq2qaLHMsz66TmiIty4B9JnzfGdi24JVGEjxF4eGk8P5NA410zSDBto9s5hfPrn3
	sshPFMS5tSeDOAZNt07YHUekjlRQ+c5qq1e6F4DoJgZsPD/KJJNtlvJQXlsiZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757059484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qptmhWEow2XN769eIxUwWzfBidCXD8AJeNJEY12zhuQ=;
	b=8wu+DKsG3vM3/aRuVuIpOUINZJ1YBmZRRaiPqIlTPXUcQoy5TYiboN5Rk+ECsEOUJCP7HC
	AfEh8nI6ryrtk+CQ==
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, suzuki.poulose@arm.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com, "Aneesh
 Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
In-Reply-To: <20250905055441.950943-1-aneesh.kumar@kernel.org>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
Date: Fri, 05 Sep 2025 10:04:40 +0200
Message-ID: <87qzwlwciv.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05 2025 at 11:24, Aneesh Kumar K. V. wrote:
> When running with private memory guests, the guest kernel must allocate
> memory with specific constraints when sharing it with the hypervisor.
>
> These shared memory buffers are also accessed by the host kernel, which
> means they must be aligned to the host kernel's page size.
>
> This patch introduces a new helper, arch_shared_mem_alignment(), which

# git grep "This patch" Documentation/process/

> can be used to enforce proper alignment of shared buffers.
>
> The actual implementation of arch_shared_mem_alignment() is deferred
> to a follow-up patch.
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/mem_encrypt.h |  6 ++++++
>  arch/arm64/mm/init.c                 |  4 +++-
>  arch/arm64/mm/mem_encrypt.c          |  6 ++++++
>  drivers/irqchip/irq-gic-v3-its.c     |  8 ++++++--
>  include/linux/mem_encrypt.h          |  7 +++++++
>  include/linux/swiotlb.h              |  7 ++++---
>  kernel/dma/direct.c                  |  7 +++++++
>  kernel/dma/pool.c                    |  1 +
>  kernel/dma/swiotlb.c                 | 28 +++++++++++++++++-----------

This does too many things at once and breaks all swiotlb users except
arm64. Seriously?

> -void swiotlb_init(bool addressing_limited, unsigned int flags);
> +void swiotlb_init(bool addressing_limited, unsigned int alignment, unsigned int flags);

Why do you need this alignment argument in the first place?

In quite some other places you use arch_shared_mem_alignment(), which
defaults to PAGE_SIZE if the architecture does not implement it's own
variant. What's preventing you from using that in the init functions as
well?

Thanks,

        tglx
