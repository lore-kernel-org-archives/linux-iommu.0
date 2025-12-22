Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D403093DD;
	Mon, 22 Dec 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766418162; cv=none; b=mtXzntpeSir1ayjT6p/qgD3L4dEYsLwe01nnVKx4dKKm0ELLnutVZS6ne9/3EW/Fm7FukR+dLIOHdWQVRjaazOE8+rG/gUh8kgGw9lWP22GU3eWwamydULuIEZksU1nMX/8Nu0m37WmCixvCCliyJr3Ln5k8izIvr34QDQTZrgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766418162; c=relaxed/simple;
	bh=DZ9MQdQlLj+fAHZ8H/c/3L5qLsNS/RkUfwAIfrxL0lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eUWyVYiLVl9FwNmn1V9QDuHjcELrk++y0PQmZpmG5kL3yXyF8CLqm2gXPtCSHmeMVHeoUxWuAzVAaDB5YwCT1IoRm3G+q2DWlaHWSXQli8eFudq/34bK59ku5R6URGd35p2ccyFeTjP75Y5/oFg1sTefyNU5n7TH9P3e1PW/QwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs4PjRJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs4PjRJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05940C4CEF1;
	Mon, 22 Dec 2025 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766418161;
	bh=DZ9MQdQlLj+fAHZ8H/c/3L5qLsNS/RkUfwAIfrxL0lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gs4PjRJELpOk+8/sXzJ3vEOQZO0OK52BVlpYBM14veFGmVbbzKVdMTYoPmfEackeF
	 3f9cKN+NYkpZdAfKysXRdiktSRJ5S9NBrCAB+sZypbHKp05jeCjWLbqpc8sIqO+flG
	 u89POiAbJV0bKsc/1KDkMA5ONCfVRgzv4gIfeYeoCGPoV8V7PFhL+ctgrlVJ90bEq/
	 rBzwA113JX+zMVyx8euYQCkAeZEEXXKB7CNlVPLse0bJ8T/QYdlj0yKPJ+JiafSiMr
	 GnPi1pQYEXMzUyuHttK3Ajqbbwx9Pn0Ut8TMuP0Cxxk1+Cdq8pHk6s3TIDz67pkeg/
	 Rzo/HNIuywv3w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	suzuki.poulose@arm.com, akpm@linux-foundation.org, jgg@ziepe.ca
Subject: Re: [PATCH v2 1/4] swiotlb: dma: its: Enforce host page-size
 alignment for shared buffers
In-Reply-To: <4a34ed21-f1e0-4991-a367-d6d2f9ad705f@arm.com>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-2-aneesh.kumar@kernel.org>
 <4a34ed21-f1e0-4991-a367-d6d2f9ad705f@arm.com>
Date: Mon, 22 Dec 2025 21:12:31 +0530
Message-ID: <yq5apl86tteg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steven Price <steven.price@arm.com> writes:

> On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
>> When running private-memory guests, the guest kernel must apply
>> additional constraints when allocating buffers that are shared with the
>> hypervisor.
>>=20
>> These shared buffers are also accessed by the host kernel and therefore
>> must be aligned to the host=E2=80=99s page size.
>>=20
>> On non-secure hosts, set_guest_memory_attributes() tracks memory at the
>> host PAGE_SIZE granularity. This creates a mismatch when the guest
>> applies attributes at 4K boundaries while the host uses 64K pages. In
>> such cases, the call returns -EINVAL, preventing the conversion of
>> memory regions from private to shared.
>>=20
>> Architectures such as Arm can tolerate realm physical address space PFNs
>> being mapped as shared memory, as incorrect accesses are detected and
>> reported as GPC faults. However, relying on this mechanism is unsafe and
>> can still lead to kernel crashes.
>>=20
>> This is particularly likely when guest_memfd allocations are mmapped and
>> accessed from userspace. Once exposed to userspace, we cannot guarantee
>> that applications will only access the intended 4K shared region rather
>> than the full 64K page mapped into their address space. Such userspace
>> addresses may also be passed back into the kernel and accessed via the
>> linear map, resulting in a GPC fault and a kernel crash.
>>=20
>> With CCA, although Stage-2 mappings managed by the RMM still operate at
>> a 4K granularity, shared pages must nonetheless be aligned to the
>> host-managed page size to avoid the issues described above.
>>=20
>> Introduce a new helper, mem_encryp_align(), to allow callers to enforce
>> the required alignment for shared buffers.
>>=20
>> The architecture-specific implementation of mem_encrypt_align() will be
>> provided in a follow-up patch.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/include/asm/mem_encrypt.h |  6 ++++++
>>  arch/arm64/mm/mem_encrypt.c          |  6 ++++++
>>  drivers/irqchip/irq-gic-v3-its.c     |  7 ++++---
>>  include/linux/mem_encrypt.h          |  7 +++++++
>>  kernel/dma/contiguous.c              | 10 ++++++++++
>>  kernel/dma/direct.c                  |  6 ++++++
>>  kernel/dma/pool.c                    |  6 ++++--
>>  kernel/dma/swiotlb.c                 | 18 ++++++++++++------
>>  8 files changed, 55 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/a=
sm/mem_encrypt.h
>> index d77c10cd5b79..b7ac143b81ce 100644
>> --- a/arch/arm64/include/asm/mem_encrypt.h
>> +++ b/arch/arm64/include/asm/mem_encrypt.h
>> @@ -17,6 +17,12 @@ int set_memory_encrypted(unsigned long addr, int nump=
ages);
>>  int set_memory_decrypted(unsigned long addr, int numpages);
>>  bool force_dma_unencrypted(struct device *dev);
>>=20=20
>> +#define mem_encrypt_align mem_encrypt_align
>> +static inline size_t mem_encrypt_align(size_t size)
>> +{
>> +	return size;
>> +}
>> +
>>  int realm_register_memory_enc_ops(void);
>>=20=20
>>  /*
>> diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
>> index 645c099fd551..deb364eadd47 100644
>> --- a/arch/arm64/mm/mem_encrypt.c
>> +++ b/arch/arm64/mm/mem_encrypt.c
>> @@ -46,6 +46,12 @@ int set_memory_decrypted(unsigned long addr, int nump=
ages)
>>  	if (likely(!crypt_ops) || WARN_ON(!PAGE_ALIGNED(addr)))
>>  		return 0;
>>=20=20
>> +	if (WARN_ON(!IS_ALIGNED(addr, mem_encrypt_align(PAGE_SIZE))))
>> +		return 0;
>> +
>> +	if (WARN_ON(!IS_ALIGNED(numpages << PAGE_SHIFT, mem_encrypt_align(PAGE=
_SIZE))))
>> +		return 0;
>> +
>>  	return crypt_ops->decrypt(addr, numpages);
>>  }
>>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-=
v3-its.c
>> index 467cb78435a9..ffb8ef3a1eb3 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -213,16 +213,17 @@ static gfp_t gfp_flags_quirk;
>>  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>>  					 unsigned int order)
>>  {
>> +	unsigned int new_order;
>>  	struct page *page;
>>  	int ret =3D 0;
>>=20=20
>> -	page =3D alloc_pages_node(node, gfp | gfp_flags_quirk, order);
>> -
>> +	new_order =3D get_order(mem_encrypt_align((PAGE_SIZE << order)));
>> +	page =3D alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
>>  	if (!page)
>>  		return NULL;
>>=20=20
>>  	ret =3D set_memory_decrypted((unsigned long)page_address(page),
>> -				   1 << order);
>> +				   1 << new_order);
>>  	/*
>>  	 * If set_memory_decrypted() fails then we don't know what state the
>>  	 * page is in, so we can't free it. Instead we leak it.
>
> Don't you also need to update its_free_pages() in a similar manner so
> that the set_memory_encrypted()/free_pages() calls are done with the
> same order argument?
>

Yes, agreed =E2=80=94 good point. The free path needs to mirror the allocat=
ion
path, so its_free_pages() should use the same order when calling
set_memory_encrypted()/decrypted() and free_pages(). I=E2=80=99ll update it
accordingly to keep the behavior symmetric and consistent. I also
noticed that swiotlb also need similar change.

-aneesh

