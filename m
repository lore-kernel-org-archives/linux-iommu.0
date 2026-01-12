Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A742EDD63;
	Mon, 12 Jan 2026 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232583; cv=none; b=S+Pyx2NyVQmhCGrr+oTeuGf6HDIvRfyQOlwSNlG8GydkDXe10YRwAAKEtH8jAqphipgzzAAjADCGjqRrkSeL3rgSszWX/O4qBIB1FT0yzEnpyPMTfri/GtVVE616mZ/BEVR051GHgiaB1urzukC6AUSXY81Col7x6GHnpSfzxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232583; c=relaxed/simple;
	bh=izSRihgLKHZ+DoHsO5bDEFKmHV3B0RnYMw1wVE+GmXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RB3YcaBcKawTzeX2+OMSjZrFApnpX9hehuAFPA49fEMrXZcnc8297PBPWTawYspKvCkduajDqbHK4qQbzhUq/CH6tq0FN+Ok+DM9u4dzW7Dt6+9BfsubJv/P4pj/bRtvwrLEvWAtTJVoomOQF+2Wasz7CJbZ4cr45sULuQKkLoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQSWTtJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQSWTtJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A61C16AAE;
	Mon, 12 Jan 2026 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232583;
	bh=izSRihgLKHZ+DoHsO5bDEFKmHV3B0RnYMw1wVE+GmXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EQSWTtJVq61nQT5LeZGFJzDAatd2/p2fAjVWfAOIESaV47dDFAcxbJhs5iVYMXXOH
	 GodqhQGn8o7SJn4vki7BebEPlsEbZYqSeNLZN56agsp/Aaa9rq08/SJqNIGvBD9k9q
	 Y5o5Am37XvQh0K0c8mqNpztyEjQV08fFs8TPSO8hF2uLYNeB0EGfl7AnZQrA04VHHU
	 BKExUr2AuiU1WRvzHiwIIPM6MMAD/Lw/QhqIV/rRZd9fkLQFU1F0F6B1KLF71V1Z9p
	 o6UN/2kTqjCa+tf/qBZX+ouVah+GOI5aCnZoXk5FXmxRyoj8qD8fCHpFFOUaCdsVUd
	 NNfHUJCQRrn7g==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, steven.price@arm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for
 swiotlb allocations
In-Reply-To: <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com>
 <yq5a7btr5wii.fsf@kernel.org>
 <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com>
Date: Mon, 12 Jan 2026 21:12:56 +0530
Message-ID: <yq5acy3eet1b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robin Murphy <robin.murphy@arm.com> writes:

> On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
>> Robin Murphy <robin.murphy@arm.com> writes:
>>=20
>>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>>> Swiotlb backing pages are already mapped decrypted via
>>>> swiotlb_update_mem_attributes(), so dma-direct does not need to call
>>>> set_memory_decrypted() during allocation or re-encrypt the memory on
>>>> free.
>>>>
>>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address and
>>>> zero the linear mapping for lowmem pages, and bypass the decrypt/encry=
pt
>>>> transitions when allocating/freeing from the swiotlb pool (detected via
>>>> swiotlb_find_pool()).
>>>
>>> swiotlb_update_mem_attributes() only applies to the default SWIOTLB
>>> buffer, while the dma_direct_alloc_swiotlb() path is only for private
>>> restricted pools (because the whole point is that restricted DMA devices
>>> cannot use the regular allocator/default pools). There is no redundancy
>>> here AFAICS.
>>>
>>=20
>> But rmem_swiotlb_device_init() is also marking the entire pool decrypted
>>=20
>> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>> 			     rmem->size >> PAGE_SHIFT);
>
> OK, so why doesn't the commit message mention that instead of saying=20
> something which fails to justify the patch at all? ;)
>
> Furthermore, how much does this actually matter? The "real" restricted=20
> DMA use-case is on systems where dma_set_decrypted() is a no-op anyway.=20
> I know we used restricted DMA as a hack in the early days of CCA=20
> prototyping, but is it intended to actually deploy that as a supported=20
> and recommended mechanism now?
>
> Note also that the swiotlb_alloc path is essentially an emergency=20
> fallback, which doesn't work for all situations anyway - any restricted=20
> device that actually needs to make significant coherent allocations (or=20
> rather, that firmware cannot assume won't want to do so) should really=20
> have a proper coherent pool alongside its restricted one. The expected=20
> use-case here is for something like a wifi driver that only needs to=20
> allocate one or two small coherent buffers once at startup, then do=20
> everything else with streaming DMA.
>


I was aiming to bring more consistency in how swiotlb buffers are
handled, specifically by treating all swiotlb memory as decrypted
buffers, which is also how the current code behaves.

If we are concluding that restricted DMA is not used in conjunction with
memory encryption, then we could, in fact, remove the
set_memory_decrypted() call from rmem_swiotlb_device_init() and
instead add failure conditions for force_dma_unencrypted(dev) in
is_swiotlb_for_alloc(). However, it=E2=80=99s worth noting that the initial
commit did take the memory encryption feature into account
(0b84e4f8b793eb4045fd64f6f514165a7974cd16).

Please let me know if you think this needs to be fixed.

-aneesh
