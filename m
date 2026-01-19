Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB421A285;
	Mon, 19 Jan 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838050; cv=none; b=u39yxyjrtA3tzWSEaDdbIyyCtIoegjShaPzsjNvor8hRylakGGx1B+UmgCIw8DrW2yD5/AocgG6sUme4gBbwQvbSiSg/8AG2Fl2CExIOjd4uc0HS5ozza7tET1069kjsY4IglUujWbo51M5q8yqLOj4QWVcLhsWfOondUaEFNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838050; c=relaxed/simple;
	bh=4xRqPduLRh757hKt9aJQlwobF21dHeqdPfui5Q8RFbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=neiEkON9AzJdQ5PMFUryNKLy/gZPbI3EMl3QnUyy7SJl4UwmNsuV1WeZTFJzMwrAUD6kC8tCVwDYxuzdDNFcIKeKB8U2nG8zN/v7KotHhSEnoICU2IEZyfz31GVXKxINVRbJsUCN0XVlFklDnFAqvrHmdK5NO3Q6/frXmoKXq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M70jDlWr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M70jDlWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC2EC116C6;
	Mon, 19 Jan 2026 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768838049;
	bh=4xRqPduLRh757hKt9aJQlwobF21dHeqdPfui5Q8RFbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M70jDlWrt1zhGswmo6xqi1meQ3onx4yC7WfjZetJV+4sOzvOLrKn00diUbFeMy+oH
	 QJhJGeuaRPLe288xWUml+ZUlcZKPAqW+MfNMwi2OO/HvXPiuZTom9Ut1DJ8lTVc+0J
	 dLpmUMC0xq40RR2rMTRHqTE32XBv1X6kkRgAPPVHBxgrXPKjVQEAMNjCndLYC4crzR
	 rz3KmzTI7fFNp07nl2oFu1wTe5CicUS6NeOpcko2cQ8Ec/QyDSrARnwV9fax6OmR7t
	 v60eTNZ7uMSJJK3wDdxTEI/Z3+DoJDs2i5U+2xXlYDHDRcFceEbgRmz9J26vNVVTBi
	 Z83emyirVagJA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: steven.price@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for
 swiotlb allocations
In-Reply-To: <3110c452-22d7-453f-bc60-7578b2458089@arm.com>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com>
 <yq5a7btr5wii.fsf@kernel.org>
 <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com>
 <yq5acy3eet1b.fsf@kernel.org>
 <CGME20260114094941eucas1p2b2985accee8c2eb5ccd48f94463adffa@eucas1p2.samsung.com>
 <yq5aldi0cyms.fsf@kernel.org>
 <0ad7a059-8c51-4d26-9d7e-055abb702b66@samsung.com>
 <3110c452-22d7-453f-bc60-7578b2458089@arm.com>
Date: Mon, 19 Jan 2026 21:23:55 +0530
Message-ID: <yq5a8qdtlht8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robin Murphy <robin.murphy@arm.com> writes:

> On 19/01/2026 9:52 am, Marek Szyprowski wrote:
>> On 14.01.2026 10:49, Aneesh Kumar K.V wrote:
>>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>> On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>>> Swiotlb backing pages are already mapped decrypted via
>>>>>>>> swiotlb_update_mem_attributes(), so dma-direct does not need to ca=
ll
>>>>>>>> set_memory_decrypted() during allocation or re-encrypt the memory =
on
>>>>>>>> free.
>>>>>>>>
>>>>>>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address a=
nd
>>>>>>>> zero the linear mapping for lowmem pages, and bypass the decrypt/e=
ncrypt
>>>>>>>> transitions when allocating/freeing from the swiotlb pool (detecte=
d via
>>>>>>>> swiotlb_find_pool()).
>>>>>>> swiotlb_update_mem_attributes() only applies to the default SWIOTLB
>>>>>>> buffer, while the dma_direct_alloc_swiotlb() path is only for priva=
te
>>>>>>> restricted pools (because the whole point is that restricted DMA de=
vices
>>>>>>> cannot use the regular allocator/default pools). There is no redund=
ancy
>>>>>>> here AFAICS.
>>>>>>>
>>>>>> But rmem_swiotlb_device_init() is also marking the entire pool decry=
pted
>>>>>>
>>>>>> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>>>>> 			     rmem->size >> PAGE_SHIFT);
>>>>> OK, so why doesn't the commit message mention that instead of saying
>>>>> something which fails to justify the patch at all? ;)
>>>>>
>>>>> Furthermore, how much does this actually matter? The "real" restricted
>>>>> DMA use-case is on systems where dma_set_decrypted() is a no-op anywa=
y.
>>>>> I know we used restricted DMA as a hack in the early days of CCA
>>>>> prototyping, but is it intended to actually deploy that as a supported
>>>>> and recommended mechanism now?
>>>>>
>>>>> Note also that the swiotlb_alloc path is essentially an emergency
>>>>> fallback, which doesn't work for all situations anyway - any restrict=
ed
>>>>> device that actually needs to make significant coherent allocations (=
or
>>>>> rather, that firmware cannot assume won't want to do so) should really
>>>>> have a proper coherent pool alongside its restricted one. The expected
>>>>> use-case here is for something like a wifi driver that only needs to
>>>>> allocate one or two small coherent buffers once at startup, then do
>>>>> everything else with streaming DMA.
>>>> I was aiming to bring more consistency in how swiotlb buffers are
>>>> handled, specifically by treating all swiotlb memory as decrypted
>>>> buffers, which is also how the current code behaves.
>>>>
>>>> If we are concluding that restricted DMA is not used in conjunction wi=
th
>>>> memory encryption, then we could, in fact, remove the
>>>> set_memory_decrypted() call from rmem_swiotlb_device_init() and
>>>> instead add failure conditions for force_dma_unencrypted(dev) in
>>>> is_swiotlb_for_alloc(). However, it=E2=80=99s worth noting that the in=
itial
>>>> commit did take the memory encryption feature into account
>>>> (0b84e4f8b793eb4045fd64f6f514165a7974cd16).
>>>>
>>>> Please let me know if you think this needs to be fixed.
>>> Something like.
>>>
>>> dma-direct: restricted-dma: Do not mark the restricted DMA pool unencry=
pted
>>>
>>> As per commit f4111e39a52a ("swiotlb: Add restricted DMA alloc/free
>>> support"), the restricted-dma-pool is used in conjunction with the
>>> shared-dma-pool. Since allocations from the shared-dma-pool are not
>>> marked unencrypted, skip marking the restricted-dma-pool as unencrypted
>>> as well. We do not expect systems using the restricted-dma-pool to have
>>> memory encryption or to run with confidential computing features enable=
d.
>>>
>>> If a device requires unencrypted access (force_dma_unencrypted(dev)),
>>> the dma-direct allocator will mark the restricted-dma-pool allocation as
>>> unencrypted.
>>>
>>> The only disadvantage is that, when running on a CC guest with a
>>> different hypervisor page size, restricted-dma-pool allocation sizes
>>> must now be aligned to the hypervisor page size. This alignment would
>>> not be required if the entire pool were marked unencrypted. However, the
>>> new code enables the use of the restricted-dma-pool for trusted devices.
>>> Previously, because the entire pool was marked unencrypted, trusted
>>> devices were unable to allocate from it.
>>>
>>> There is still an open question regarding allocations from the
>>> shared-dma-pool. Currently, they are not marked unencrypted.
>>>
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>>
>>> 1 file changed, 2 deletions(-)
>>> kernel/dma/swiotlb.c | 2 --
>>>
>>> modified   kernel/dma/swiotlb.c
>>> @@ -1835,8 +1835,6 @@ static int rmem_swiotlb_device_init(struct reserv=
ed_mem *rmem,
>>>    			return -ENOMEM;
>>>    		}
>>>=20=20=20=20
>>> -		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>> -				     rmem->size >> PAGE_SHIFT);
>>>    		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
>>>    					 false, nareas);
>>>    		mem->force_bounce =3D true;
>>=20
>> Robin, could You review this? Is it ready for applying?
>
> But wouldn't this break the actual intended use of restricted pools for=20
> streaming DMA bouncing, which does depend on the buffer being=20
> pre-decrypted/shared? (Since streaming DMA mappings definitely need to=20
> be supported in nowait contexts)
>

Only if we are using a restricted pool with encrypted memory.

If we assume that swiotlb bounce buffers are always decrypted, then
allocations from that pool can safely skip the decrypt/encrypt
transitions. However, we still need to address coherent allocations via
the shared-dma-pool, which are explicitly marked as unencrypted.

Given this, I=E2=80=99m wondering whether the best approach is to revisit t=
he
original patch I posted, which moved swiotlb allocations out of
__dma_direct_alloc_pages(). With that separation in place, we could then
fix up dma_alloc_from_dev_coherent() accordingly.

If the conclusion is that systems with encrypted memory will, in
practice, never use restricted-dma-pool or shared-dma-pool, then we can
take this patch?

If you can suggest the approach you would like to see taken with
restricted-dma-pool/shared-dma-pool, I can work on the final change.

-aneesh
