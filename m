Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498C1EB5E3;
	Thu, 16 Apr 2026 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329594; cv=none; b=QXtLqoMzScppkax5xbI+o0VQAu7dUg1RzcN4E6TY8qNJfc1W/uTZcpzJ/dXQ/N+TFFdYB/ZHsw5lUIyUGtebJGj0gpdiQFHYT6Hn/oIKnJFfzQAQf4HTo12ShaQg+BapaC+MQqr6lXzuD2oiTkoyxsHQq0A4i8e0WcuF0ImPws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329594; c=relaxed/simple;
	bh=jdNjLZ6hHmaZsDcc17CfQFw1yshlagxIJr7bRP63jKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nJqIOBKknPxKXI23hMe+WO3dEhHK7uN13xZG4cMLlHs6749cCqzDnR3K+TkB4TGsRfvt2QLpBvbvMF9fCICtyygrGLz0TmIGPD5HHMpxK9f6zBhgxCWG+AGOdGqwf8HlyEK6DQ1Nmp+ZriIN5IEMQp1T5qqK2WS9VXAYwLH5v3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaucGoyJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaucGoyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D47CC2BCAF;
	Thu, 16 Apr 2026 08:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776329594;
	bh=jdNjLZ6hHmaZsDcc17CfQFw1yshlagxIJr7bRP63jKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iaucGoyJyTf49sFd/blOSNRldLD1EKIpvohYWIAcDlAPP+sqts8tRka+wSjt3MHA6
	 XTLqfjqtqUImHAw0nH94PHCjsjoozFkEafzAH+VPAZ7nO9vaqoHpu9YjnLf76fjF+2
	 Lw12p9QwWqgghgv3FQ1E+lyq1C7xZG8ugil0YNFUhNJZwiD8HMuRxJlhEnVHCfBruI
	 GlOKgRSBqRYT9wVSmj4JgemYRLmAvG8NdzfCEoJjXhWjGQ0V6YP6LK/ZC7HRxi6z0G
	 RQW1h8FRtQai3029OzDFcsbG8ZCTu/MV1RiS53GTCVEuMtZPP5sPvavD76lCPgMUUo
	 rbDvs+uRBjp4g==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v3 1/5] swiotlb: Return state of memory from
 swiotlb_alloc()
In-Reply-To: <ad_4WtW5uEZlDdLU@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-2-smostafa@google.com>
 <yq5awly9ao6q.fsf@kernel.org> <ad_4WtW5uEZlDdLU@google.com>
Date: Thu, 16 Apr 2026 14:23:08 +0530
Message-ID: <yq5aeckf9thn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, Apr 14, 2026 at 02:55:33PM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>>=20
>> > Make swiotlb_alloc() return the state of the allocated memory, at
>> > the moment all the pools are decrypted but that would change soon.
>> > In the next patches dma-direct will use the returned state to
>> > determine whether to decrypt the memory and use the proper memory
>> > decryption/encryption related functions.
>> >
>> > Also, add swiotlb_is_decrypted(), that will be used before calling
>> > swiotlb_free() to check whether the memory needs to be encrypted
>> > by the caller.
>> >
>> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> > ---
>> >  include/linux/swiotlb.h | 25 +++++++++++++++++++++++--
>> >  kernel/dma/direct.c     |  2 +-
>> >  kernel/dma/swiotlb.c    | 23 ++++++++++++++++++++++-
>> >  3 files changed, 46 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
>> > index 3dae0f592063..24be65494ce8 100644
>> > --- a/include/linux/swiotlb.h
>> > +++ b/include/linux/swiotlb.h
>> > @@ -63,6 +63,7 @@ extern void __init swiotlb_update_mem_attributes(voi=
d);
>> >   * @area_nslabs: Number of slots in each area.
>> >   * @areas:	Array of memory area descriptors.
>> >   * @slots:	Array of slot descriptors.
>> > + * @decrypted:	Whether the pool was decrypted or left in default stat=
e.
>> >   * @node:	Member of the IO TLB memory pool list.
>> >   * @rcu:	RCU head for swiotlb_dyn_free().
>> >   * @transient:  %true if transient memory pool.
>> > @@ -77,6 +78,7 @@ struct io_tlb_pool {
>> >  	unsigned int area_nslabs;
>> >  	struct io_tlb_area *areas;
>> >  	struct io_tlb_slot *slots;
>> > +	bool decrypted;
>> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
>> >  	struct list_head node;
>> >  	struct rcu_head rcu;
>> > @@ -281,16 +283,31 @@ static inline void swiotlb_sync_single_for_cpu(s=
truct device *dev,
>> >
>>=20
>> Should this be a property of struct io_tlb_mem ?=20
>
> I envisioned that this would be mainly used by restricted-dma so in
> that case it doesn=E2=80=99t seem to matter.
> But generally, I guess it would depend on the discovery mechanism of
> this memory property and I can imagine a memory allocator that has
> multiple pools with different attributes. So propably it's better to
> be per pool.
>

If we are going to make this generic, we may not be able to look at only
restricted-dma. Instead, we will have to consider other SWIOTLB code
paths as well, such as swiotlb_map(), swiotlb_alloc_pool() etc. For
example, in swiotlb_dyn_alloc(), how do we determine whether to use
decrypted or encrypted memory? I am thinking we want to use struct
io_tlb_mem.decrypted field to determine that

	struct io_tlb_mem *mem =3D
		container_of(work, struct io_tlb_mem, dyn_alloc);

	pool =3D swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
				  default_nareas, mem->phys_limit, mem->decrypted,
				  GFP_KERNEL);


Also, for things like swiotlb_tbl_map_single(), we might want to =E2=80=A6

	struct io_tlb_mem *mem =3D dev->dma_io_tlb_mem;

	/* if phys addr attribute is encrypted but the device is forcing an encryp=
ted dma addr */
	if (!(attrs & DMA_ATTR_CC_DECRYPTED) && force_dma_unencrypted(dev))
		require_decrypted =3D true;

	if (require_decrypted !=3D mem->decrypted)
		return (phys_addr_t)DMA_MAPPING_ERROR;

-aneesh
