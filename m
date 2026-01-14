Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E841E5B7A;
	Wed, 14 Jan 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384178; cv=none; b=D1nnPjdA49Nj4GjV9FLFb/hz4vGrePlLv2AJPgLRkUn/Vu4FuAgQYxT6me+3AET4EIh0n1ejT1M9LrWloYKW4EibKHc7uuiGZfCtr7MC7zm6z2509B+egmfe7Cr7nvY5BOcbVfxWPTvvmJcDnLcLSd3UOhD9YZwOh7Dr77OqwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384178; c=relaxed/simple;
	bh=u55y8FLLXt3PA7k6Z//td6lIvEIDtfft8qfles6S5/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kt1FcVL0VRKlYydELo7a7QDO0AEx8veyNPFjtKKtl7w9HSPyeNad92nZBWx+LvCWX9a0QIsxn/zTSFDGTwlDMXTyqFF5NUF+30/dcEY3nZDsTOgl/2urKLr64rWcnutHcRKIvtdYmL2jRR6yemQRACtl473qbEQRVbQZzibsdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC5SYAwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC5SYAwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFCBC4CEF7;
	Wed, 14 Jan 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768384177;
	bh=u55y8FLLXt3PA7k6Z//td6lIvEIDtfft8qfles6S5/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qC5SYAwZeHK7TCOQ8roMntT+rill4iXmTCvtjvcsq/Gc54jPMYvMkixOtG8V3e/i4
	 Y/VBpdeV22wy+2zkqul5FtxJRU8QCuuK2l/qt7b1jlhpcB1zy7oIU60aIKWXrxR+F5
	 n0EWf+mfiSqZ4blXp7MaqImCnHb7RJ2Pe9max5JoKZAc77Iu6ohrU5m5bVfdiudiJN
	 VzUfUKnKE1Ncevzatsoqkk9ZASvZdj/AjK6ZmdWWW0YZ0GdKgSUC0WC/rG5qSM0bKf
	 q4ycrB1quZFUb24RLAijUk2TfauNbcfxHp4orpvicNn3rGXYK7hwUl5S3bT0A4jOqR
	 SmvhbXAoyxokQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, steven.price@arm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH] dma-direct: swiotlb: Skip encryption toggles for
 swiotlb allocations
In-Reply-To: <yq5acy3eet1b.fsf@kernel.org>
References: <20260102155448.2554240-1-aneesh.kumar@kernel.org>
 <cddcaeff-9652-4685-ba6c-0fda79bd8680@arm.com>
 <yq5a7btr5wii.fsf@kernel.org>
 <1290fd7e-bfaf-47ce-b12f-cca0b938b293@arm.com>
 <yq5acy3eet1b.fsf@kernel.org>
Date: Wed, 14 Jan 2026 15:19:31 +0530
Message-ID: <yq5aldi0cyms.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Robin Murphy <robin.murphy@arm.com> writes:
>
>> On 2026-01-09 2:51 am, Aneesh Kumar K.V wrote:
>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>=20
>>>> On 2026-01-02 3:54 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>> Swiotlb backing pages are already mapped decrypted via
>>>>> swiotlb_update_mem_attributes(), so dma-direct does not need to call
>>>>> set_memory_decrypted() during allocation or re-encrypt the memory on
>>>>> free.
>>>>>
>>>>> Handle swiotlb-backed buffers explicitly: obtain the DMA address and
>>>>> zero the linear mapping for lowmem pages, and bypass the decrypt/encr=
ypt
>>>>> transitions when allocating/freeing from the swiotlb pool (detected v=
ia
>>>>> swiotlb_find_pool()).
>>>>
>>>> swiotlb_update_mem_attributes() only applies to the default SWIOTLB
>>>> buffer, while the dma_direct_alloc_swiotlb() path is only for private
>>>> restricted pools (because the whole point is that restricted DMA devic=
es
>>>> cannot use the regular allocator/default pools). There is no redundancy
>>>> here AFAICS.
>>>>
>>>=20
>>> But rmem_swiotlb_device_init() is also marking the entire pool decrypted
>>>=20
>>> 	set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>>> 			     rmem->size >> PAGE_SHIFT);
>>
>> OK, so why doesn't the commit message mention that instead of saying=20
>> something which fails to justify the patch at all? ;)
>>
>> Furthermore, how much does this actually matter? The "real" restricted=20
>> DMA use-case is on systems where dma_set_decrypted() is a no-op anyway.=
=20
>> I know we used restricted DMA as a hack in the early days of CCA=20
>> prototyping, but is it intended to actually deploy that as a supported=20
>> and recommended mechanism now?
>>
>> Note also that the swiotlb_alloc path is essentially an emergency=20
>> fallback, which doesn't work for all situations anyway - any restricted=
=20
>> device that actually needs to make significant coherent allocations (or=
=20
>> rather, that firmware cannot assume won't want to do so) should really=20
>> have a proper coherent pool alongside its restricted one. The expected=20
>> use-case here is for something like a wifi driver that only needs to=20
>> allocate one or two small coherent buffers once at startup, then do=20
>> everything else with streaming DMA.
>>
>
>
> I was aiming to bring more consistency in how swiotlb buffers are
> handled, specifically by treating all swiotlb memory as decrypted
> buffers, which is also how the current code behaves.
>
> If we are concluding that restricted DMA is not used in conjunction with
> memory encryption, then we could, in fact, remove the
> set_memory_decrypted() call from rmem_swiotlb_device_init() and
> instead add failure conditions for force_dma_unencrypted(dev) in
> is_swiotlb_for_alloc(). However, it=E2=80=99s worth noting that the initi=
al
> commit did take the memory encryption feature into account
> (0b84e4f8b793eb4045fd64f6f514165a7974cd16).
>
> Please let me know if you think this needs to be fixed.
>

Something like.

dma-direct: restricted-dma: Do not mark the restricted DMA pool unencrypted

As per commit f4111e39a52a ("swiotlb: Add restricted DMA alloc/free
support"), the restricted-dma-pool is used in conjunction with the
shared-dma-pool. Since allocations from the shared-dma-pool are not
marked unencrypted, skip marking the restricted-dma-pool as unencrypted
as well. We do not expect systems using the restricted-dma-pool to have
memory encryption or to run with confidential computing features enabled.

If a device requires unencrypted access (force_dma_unencrypted(dev)),
the dma-direct allocator will mark the restricted-dma-pool allocation as
unencrypted.

The only disadvantage is that, when running on a CC guest with a
different hypervisor page size, restricted-dma-pool allocation sizes
must now be aligned to the hypervisor page size. This alignment would
not be required if the entire pool were marked unencrypted. However, the
new code enables the use of the restricted-dma-pool for trusted devices.
Previously, because the entire pool was marked unencrypted, trusted
devices were unable to allocate from it.

There is still an open question regarding allocations from the
shared-dma-pool. Currently, they are not marked unencrypted.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

1 file changed, 2 deletions(-)
kernel/dma/swiotlb.c | 2 --

modified   kernel/dma/swiotlb.c
@@ -1835,8 +1835,6 @@ static int rmem_swiotlb_device_init(struct reserved_m=
em *rmem,
 			return -ENOMEM;
 		}
=20
-		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
 					 false, nareas);
 		mem->force_bounce =3D true;
