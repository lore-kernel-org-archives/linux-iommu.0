Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FD38947E;
	Mon, 13 Apr 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776060045; cv=none; b=h7+g/8Kx2qa7Sj17r1UV4IJPfmhdkh2t0F27I6Meqkke8WW/g6kVMOrmR4cMDX2S2xjFXPHib01gSsiT9hQSM9boQIZR9sTzf9sTGrPMK1ELWB5fkVwPR/D8IRls+iEmlRs9f4JD+gCOdgqQcoYOpe01UZHbXS1WnIYBYDNOJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776060045; c=relaxed/simple;
	bh=dbPV0ATaHuqV3Hurh/SApD5QkYlEMvfHFosSxFzTIZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNI95h3pku9wtzkdkASRIgBwZlibLqTthYA5SNFWoDklVPA7amM067R6sujvUtIuMNhf7h4fbxp9KZgeK67x5x0Y0p3uGwsbaUbgDpPfrBdUEg8bpTl++RKEbQn/nosqONUQmpq9/DjGdZ+m8XVJHt5rDIuVvyUli6DkUX8A7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T69PHVQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T69PHVQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C16C116C6;
	Mon, 13 Apr 2026 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776060044;
	bh=dbPV0ATaHuqV3Hurh/SApD5QkYlEMvfHFosSxFzTIZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=T69PHVQ3mwGpWvSeqmpbX3rT71ztZRjxvPQqO6Xu9TQJAEfRg2kHlMlnG4AZ0oSvZ
	 +WWSlcO+IS8Mqx9L4yFwym/7cWtvrXi+76Jtz9PaEzDrnk3ZkkAHbMvCQzSO7Pmd1J
	 CHJt9Lku7v2trFwDAQFag1VFEmEqqi1OLs+m0GQunfM6107ZQgDprJMtdBukCgrjay
	 a2plBW8Wr4afohMvaHCQfZRHV5iv1H6WNqhEzhtihT6ufqtj+8sy9df1EfdopPFtcF
	 87aX3D+LTlncmgPD9bSBT1+fcQ/wZzbxBg/uLTUtC3Q0/ilJxRJT8/nMmJ2cs9wWXI
	 kSdsTJPiXmC4A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
In-Reply-To: <acrgYotBExJhEJkK@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca> <acrgYotBExJhEJkK@google.com>
Date: Mon, 13 Apr 2026 11:30:38 +0530
Message-ID: <yq5aeckjbdrt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Mon, Mar 30, 2026 at 12:06:54PM -0300, Jason Gunthorpe wrote:
>> On Mon, Mar 30, 2026 at 02:50:39PM +0000, Mostafa Saleh wrote:
>> > In case a device have a restricted DMA pool, it will be decrypted
>> > by default.
>> >=20
>> > However, in the path of dma_direct_alloc() memory can be allocated
>> > from this pool using, __dma_direct_alloc_pages() =3D>
>> > dma_direct_alloc_swiotlb()
>> >=20
>> > After that from the same function, it will attempt to decrypt it
>> > using dma_set_decrypted() if force_dma_unencrypted().
>> >=20
>> > Which results in the memory being decrypted twice.
>> >=20
>> > It's not clear how the does realm world/hypervisors deal with that,
>> > for example:
>> > - CCA: Clear a bit in the page table and call realm IPA_STATE_SET.
>> > - TDX: Issue a hypercall.
>> > - pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
>> >   uses a share hypercall.
>> >=20
>> > Change that to only encrypt/decrypt memory that are not allocated
>> > from the restricted dma pools.
>> >=20
>> > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
>> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> > ---
>> >  kernel/dma/direct.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> > index 8f43a930716d..27d804f0473f 100644
>> > --- a/kernel/dma/direct.c
>> > +++ b/kernel/dma/direct.c
>> > @@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t=
 phys, size_t size)
>> >=20=20
>> >  static int dma_set_decrypted(struct device *dev, void *vaddr, size_t =
size)
>> >  {
>> > -	if (!force_dma_unencrypted(dev))
>> > +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>> >  		return 0;
>>=20
>> This seems really obtuse, I would expect the decryption state of the
>> memory to be known by the caller. If dma_direct_alloc_swiotlb() can
>> return decrypted or encrypted memory it needs to return a flag saying
>> that. It shouldn't be deduced by checking dev flags in random places
>> like this.
>
> At the moment restricted dma is always decrypted, also it=E2=80=99s per d=
evice
> so we don=E2=80=99t have to check this per allocation.
> I can change the signature for __dma_direct_alloc_pages() to make it
> return an extra flag but that feels more complicated as it changes
> dma_direct_alloc_swiotlb() , swiotlb_alloc() with its callers.
>
> I can investigate this approach further.
>

I know there is a v3, but I=E2=80=99m commenting here to check whether we r=
eally
need to do this now. In my opinion, we can keep this much simpler by
treating all swiotlb allocations as decrypted allocations. We also need
this to simplify the IPA change alignment updates I posted

https://lore.kernel.org/all/20260309102625.2315725-2-aneesh.kumar@kernel.org

-aneesh
