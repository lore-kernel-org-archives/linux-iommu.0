Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED13491FB;
	Tue, 20 Jan 2026 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901767; cv=none; b=YG3TszEs6uFBSCOTY5EhXVxfcoK71QJDxl7dNhmExbu2/SUkIDwp7xOD3l2yoioMaeXpnJ6fx5m6cHgyx6dMLbT3+xiLoDA4iM9SFsI/qSU/Eei5+YH2tAmfOgIsJDh6f4ASw3t0WJtAPMkVPAAxF1S2NnB14fEOVw/I+K12zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901767; c=relaxed/simple;
	bh=Ik7+hCi7qotoji5MZwX1z+0LbyV0p6XkBmANZO52zUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWMFRDqfSd5VrhLOPxT175MrcnM7ZEEKGhkWd35XxfXp+r/lH59yw89n4iZk9JOp0EAP0EfdJc8kJTz/JQFQdNqEx5hoeHMnMoP8tuCpGs8dujuxRjNUdV3nAc01ln/Nd2WHgffvBEDSWmSqOj/lu/yObD/I8wXeE0cJw2xExJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q69/3yXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q69/3yXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3759DC16AAE;
	Tue, 20 Jan 2026 09:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768901765;
	bh=Ik7+hCi7qotoji5MZwX1z+0LbyV0p6XkBmANZO52zUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q69/3yXuRKezFNKmRdM+0JtKXCTPDSWakQAJbkCrK/18vyBw3JlMFN/TnPqz6prV7
	 HK9hNLMwBi1q5sUdSsRCkKs7Gg056uS6iwjpPUz6vk5A3dQEa7i2mBXzxMwVEb96m4
	 TSRcLnpwgNuwfXFFPMgfQKIjIKek1vt/Le03cwv5kcTlzMnr3gxIx8QXVDBHwf6CJz
	 FaKdGtDNUcS7PHzI9/ze0OhH82CO/bzaRAIi1ojQk5UvqAIuThAYRjxw6qIuOSyhOs
	 kto0WVdIO9B2DOzGGkoiYcEQMbDgos/ug/52X47JPpqSQ3r+5Oqxos5or5z9XEIgRj
	 9lpGc0WEMqQoA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: steven.price@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for
 swiotlb allocations
In-Reply-To: <4f42d3b1-9eef-417b-9937-36578f5db6de@arm.com>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com>
 <yq5a7btr5wii.fsf@kernel.org>
 <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com>
 <yq5acy3eet1b.fsf@kernel.org>
 <CGME20260114094941eucas1p2b2985accee8c2eb5ccd48f94463adffa@eucas1p2.samsung.com>
 <yq5aldi0cyms.fsf@kernel.org>
 <0ad7a059-8c51-4d26-9d7e-055abb702b66@samsung.com>
 <3110c452-22d7-453f-bc60-7578b2458089@arm.com>
 <yq5a8qdtlht8.fsf@kernel.org>
 <4f42d3b1-9eef-417b-9937-36578f5db6de@arm.com>
Date: Tue, 20 Jan 2026 15:03:40 +0530
Message-ID: <yq5azf68k4qz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robin Murphy <robin.murphy@arm.com> writes:

> On 19/01/2026 3:53 pm, Aneesh Kumar K.V wrote:
>> Robin Murphy <robin.murphy@arm.com> writes:
>>=20
>>> On 19/01/2026 9:52 am, Marek Szyprowski wrote:
>>>> On 14.01.2026 10:49, Aneesh Kumar K.V wrote:
>>>>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>>> On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
>>>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>>>>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>>>>> Swiotlb backing pages are already mapped decrypted via
>>>>>>>>>> swiotlb_update_mem_attributes(), so dma-direct does not need to =
call
>>>>>>>>>> set_memory_decrypted() during allocation or re-encrypt the memor=
y on
>>>>>>>>>> free.
>>>>>>>>>>
>>>>>>>>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address=
 and
>>>>>>>>>> zero the linear mapping for lowmem pages, and bypass the decrypt=
/encrypt
>>>>>>>>>> transitions when allocating/freeing from the swiotlb pool (detec=
ted via
>>>>>>>>>> swiotlb_find_pool()).
>>>>>>>>> swiotlb_update_mem_attributes() only applies to the default SWIOT=
LB
>>>>>>>>> buffer, while the dma_direct_alloc_swiotlb() path is only for pri=
vate
>>>>>>>>> restricted pools (because the whole point is that restricted DMA =
devices
>>>>>>>>> cannot use the regular allocator/default pools). There is no redu=
ndancy
>>>>>>>>> here AFAICS.
>>>>>>>>>
>>>>>>>> But rmem_swiotlb_device_init() is also marking the entire pool dec=
rypted
>>>>>>>>
>>>>>>>> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>>>>>>> 			     rmem->size >> PAGE_SHIFT);
>>>>>>> OK, so why doesn't the commit message mention that instead of saying
>>>>>>> something which fails to justify the patch at all? ;)
>>>>>>>
>>>>>>> Furthermore, how much does this actually matter? The "real" restric=
ted
>>>>>>> DMA use-case is on systems where dma_set_decrypted() is a no-op any=
way.
>>>>>>> I know we used restricted DMA as a hack in the early days of CCA
>>>>>>> prototyping, but is it intended to actually deploy that as a suppor=
ted
>>>>>>> and recommended mechanism now?
>>>>>>>
>>>>>>> Note also that the swiotlb_alloc path is essentially an emergency
>>>>>>> fallback, which doesn't work for all situations anyway - any restri=
cted
>>>>>>> device that actually needs to make significant coherent allocations=
 (or
>>>>>>> rather, that firmware cannot assume won't want to do so) should rea=
lly
>>>>>>> have a proper coherent pool alongside its restricted one. The expec=
ted
>>>>>>> use-case here is for something like a wifi driver that only needs to
>>>>>>> allocate one or two small coherent buffers once at startup, then do
>>>>>>> everything else with streaming DMA.
>>>>>> I was aiming to bring more consistency in how swiotlb buffers are
>>>>>> handled, specifically by treating all swiotlb memory as decrypted
>>>>>> buffers, which is also how the current code behaves.
>>>>>>
>>>>>> If we are concluding that restricted DMA is not used in conjunction =
with
>>>>>> memory encryption, then we could, in fact, remove the
>>>>>> set_memory_decrypted() call from rmem_swiotlb_device_init() and
>>>>>> instead add failure conditions for force_dma_unencrypted(dev) in
>>>>>> is_swiotlb_for_alloc(). However, it=E2=80=99s worth noting that the =
initial
>>>>>> commit did take the memory encryption feature into account
>>>>>> (0b84e4f8b793eb4045fd64f6f514165a7974cd16).
>>>>>>
>>>>>> Please let me know if you think this needs to be fixed.
>>>>> Something like.
>>>>>
>>>>> dma-direct: restricted-dma: Do not mark the restricted DMA pool unenc=
rypted
>>>>>
>>>>> As per commit f4111e39a52a ("swiotlb: Add restricted DMA alloc/free
>>>>> support"), the restricted-dma-pool is used in conjunction with the
>>>>> shared-dma-pool. Since allocations from the shared-dma-pool are not
>>>>> marked unencrypted, skip marking the restricted-dma-pool as unencrypt=
ed
>>>>> as well. We do not expect systems using the restricted-dma-pool to ha=
ve
>>>>> memory encryption or to run with confidential computing features enab=
led.
>>>>>
>>>>> If a device requires unencrypted access (force_dma_unencrypted(dev)),
>>>>> the dma-direct allocator will mark the restricted-dma-pool allocation=
 as
>>>>> unencrypted.
>>>>>
>>>>> The only disadvantage is that, when running on a CC guest with a
>>>>> different hypervisor page size, restricted-dma-pool allocation sizes
>>>>> must now be aligned to the hypervisor page size. This alignment would
>>>>> not be required if the entire pool were marked unencrypted. However, =
the
>>>>> new code enables the use of the restricted-dma-pool for trusted devic=
es.
>>>>> Previously, because the entire pool was marked unencrypted, trusted
>>>>> devices were unable to allocate from it.
>>>>>
>>>>> There is still an open question regarding allocations from the
>>>>> shared-dma-pool. Currently, they are not marked unencrypted.
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>>>>
>>>>> 1 file changed, 2 deletions(-)
>>>>> kernel/dma/swiotlb.c | 2 --
>>>>>
>>>>> modified   kernel/dma/swiotlb.c
>>>>> @@ -1835,8 +1835,6 @@ static int rmem_swiotlb_device_init(struct rese=
rved_mem *rmem,
>>>>>     			return -ENOMEM;
>>>>>     		}
>>>>>=20=20=20=20=20
>>>>> -		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>>>> -				     rmem->size >> PAGE_SHIFT);
>>>>>     		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
>>>>>     					 false, nareas);
>>>>>     		mem->force_bounce =3D true;
>>>>
>>>> Robin, could You review this? Is it ready for applying?
>>>
>>> But wouldn't this break the actual intended use of restricted pools for
>>> streaming DMA bouncing, which does depend on the buffer being
>>> pre-decrypted/shared? (Since streaming DMA mappings definitely need to
>>> be supported in nowait contexts)
>>>
>>=20
>> Only if we are using a restricted pool with encrypted memory.
>>=20
>> If we assume that swiotlb bounce buffers are always decrypted, then
>> allocations from that pool can safely skip the decrypt/encrypt
>> transitions. However, we still need to address coherent allocations via
>> the shared-dma-pool, which are explicitly marked as unencrypted.
>>=20
>> Given this, I=E2=80=99m wondering whether the best approach is to revisi=
t the
>> original patch I posted, which moved swiotlb allocations out of
>> __dma_direct_alloc_pages(). With that separation in place, we could then
>> fix up dma_alloc_from_dev_coherent() accordingly.
>>=20
>> If the conclusion is that systems with encrypted memory will, in
>> practice, never use restricted-dma-pool or shared-dma-pool, then we can
>> take this patch?
>
> But if the conclusion is that it doesn't matter then that can only mean
> we don't need this patch either.
>
> We've identified that the combination of restricted DMA and a
> "meaningful" memory encryption API is theoretically slightly broken and
> can't ever have worked properly, so how do we benefit from churning it
> to just be theoretically more broken in a different way?
>

I think we should go with the original patch. I do not see it as more
broken. It is based on the simple assumption that swiotlb buffers are
always decrypted. Based on that assumption, it moves the allocation from
swiotlb out of __dma_direct_alloc_pages() and avoids the decrypt/encrypt
transition for swiotlb buffers.

For coherent allocations from the shared-dma-pool, we need to ensure
that every architecture does the right thing. For Arm CCA, we use
ioremap, which should mark the memory as decrypted/shared.

When we add trusted device support, we must also ensure that such a pool
is never attached to a trusted device. Therefore, there should never be
a need to mark that memory as encrypted/private.

-aneesh
