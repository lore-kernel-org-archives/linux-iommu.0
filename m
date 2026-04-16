Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C3311583;
	Thu, 16 Apr 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322216; cv=none; b=Rg7/5FrVoVGkOdqLKkFfNM26Zb6ZECjmVsnsMTHjNnhKFWrYpamCkvSSZNkQCz4w7AmCVoV7IznKvo572cQZkmZKAMwIpTwsnii0GBYES0nvCYv/fi+JNHw/KMgoD3GJXedDWNWfUssIJcbo3yJu9NZKVlXM983qJZmYa71frzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322216; c=relaxed/simple;
	bh=TyGLNA2L+TLVfMGfdJ6tW3fcUR036/9snLN+83rn8zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIx8gsKiE2WoBx1xB2z68yz/qPSnfvb+R9ELdIx3EcZQUeenCw0xmK0lcHGe1QpQfTMiuwWwaqFsOaYlz6cBv1qMiUm79e5X3S+D7qekWFdAPnBUrukiA81cW0nY0M89sgdJFdO3Z/k7T7H0iIjW6gR2tIJjvl3MibyyQXn8WJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxUKn+C9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxUKn+C9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A102C2BCB5;
	Thu, 16 Apr 2026 06:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776322215;
	bh=TyGLNA2L+TLVfMGfdJ6tW3fcUR036/9snLN+83rn8zQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lxUKn+C9ualLsRdz6BNxdK17ZrC1GF8MDfOScB0+9xHxV3aHz6NJk0940Y5Z17NE6
	 j01JczdRksCZ09D2nOPzPSnmq1Mg01j97UObZnZNV4ZGc4Cxj9oTAToELI9Oln3pDb
	 KvmfRfOBEn8FZSoCyGTvY+f6yZNI8ABIQz43M6e6NOKDSLeHouhGr7Io2L4c8LNN+v
	 VIOAKJny8IKVqYm3Gf9vXPXohUu5bsEWZ6AjlGVZr7rhnxLmJrsMRzFzjss+PMs+n9
	 y3ckCjOq82TItRnUkSSDIDRj/q52im3CNsCFV/93G1Q+d4d3+h+Szkza/8jxVWrRqw
	 NjYNGzSGuu8dw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v2 2/5] dma-mapping: Use the correct phys_to_dma()
 for DMA_RESTRICTED_POOL
In-Reply-To: <ad_0pqI0uWZH7D8k@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-3-smostafa@google.com>
 <yq5abjfnbdej.fsf@kernel.org> <ad_0pqI0uWZH7D8k@google.com>
Date: Thu, 16 Apr 2026 12:20:09 +0530
Message-ID: <yq5ah5pb9z6m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Mon, Apr 13, 2026 at 11:38:36AM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>>=20
>> > As restricted dma pools are always decrypted, in swiotlb.c it uses
>> > phys_to_dma_unencrypted() for address conversion.
>> >
>> > However, in DMA-direct, calls to phys_to_dma_direct() with
>> > force_dma_unencrypted() returning false, will fallback to
>> > phys_to_dma() which is inconsistent for memory allocated from
>> > restricted dma pools.
>> >
>> > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
>> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> > ---
>> >  kernel/dma/direct.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> > index 27d804f0473f..1a402bb956d9 100644
>> > --- a/kernel/dma/direct.c
>> > +++ b/kernel/dma/direct.c
>> > @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init =3D DMA_BIT_MASK(=
24);
>> >  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>> >  		phys_addr_t phys)
>> >  {
>> > -	if (force_dma_unencrypted(dev))
>> > +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>> >  		return phys_to_dma_unencrypted(dev, phys);
>> >
>>=20
>> So what kind of device is this? Is it a trusted device that needs to use
>> swiotlb in unencrypted form?(is that a valid use case?) Can we add addit=
ional comment
>> explaining the type of device for which we are allocating the DMA
>> buffer?
>
> That=E2=80=99s used for devices that use restricted-dma pools which are
> currently always decrypted, typically virtio devices that are emulated
> by the untrusted host.
>

Why would those devices not force unencrypted DMA? Sorry, I may not be
following all the details. The pool itself is decrypted by default, but
the device does not force unencrypted DMA?=E2=80=9D

-aneesh
