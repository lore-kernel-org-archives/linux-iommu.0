Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34527AC48;
	Wed, 15 Apr 2026 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257005; cv=none; b=b77Eq6WtcIWIMHHLy28OnBBjgy1fjLjngpgubtnrqey/6KE10JSMjmafNw2yyneNIIz25IdBHpznNsHkmsUFeb6aa9wYgH8Y/n5zXEKWOMhS8mEkP8ezna48jGfRgHs66EQ4MewfMcsv4dT8RYlE264ptFiXh0w55rXNI+Gmsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257005; c=relaxed/simple;
	bh=wVLD1V0csrOxUqDY67CfzrsuSWsBE8HPZFqwwWqKrsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ObHoikpOC6eBYje9Bq8MaoEPbMTn85+au0+wJq15SPdgA5v9cHUrfn9vPt6f6KxSbC6pHK9O9SIn05YLZnXtNSayq1g5ECPZ+EVGEbL4q8K8kPdiqgYk7BvsjPcqrCojqCTQ9tACAd+bDUhvqbqfH0+haE/prBA9d9l9sdbdFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRKhS2m8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRKhS2m8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4660BC19424;
	Wed, 15 Apr 2026 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776257004;
	bh=wVLD1V0csrOxUqDY67CfzrsuSWsBE8HPZFqwwWqKrsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MRKhS2m80TEwpuLdUrwUv8mH7S/tb6Td6O96A4aqiL9AWB/U6kkwUL9DN5i28lL3e
	 9VwLCQbKr3y9aIyPVnahnZ/1M1RencKcviVq7aCP1SAAkMmhSyA6AvYEc44e3Bdur1
	 iTeZ8vEGK6NGwhPAU6gfdR1mAeC5CpP9wyAMGP7X5E1TEtgJUmGJHZUPpLx7UTUh0Y
	 J2xzeNP0wwJs7NmY4OCUhwNueyJCaHkW7pr8ayGuYWJN6RkwxX5PlZAv89tqqYmCA7
	 b8Qe+uB2kXdsBGkeSLCp1WJvt3N+acO9EIHKt0mOf+jIakax3fg4wQGPFKV1IrHDJN
	 eoZ1zJYJXK7HA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us
Subject: Re: [RFC PATCH v3 5/5] dma-mapping: Fix memory decryption issues
In-Reply-To: <20260413124248.GJ3694781@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-6-smostafa@google.com>
 <yq5a5x5vba49.fsf@kernel.org> <20260413124248.GJ3694781@ziepe.ca>
Date: Wed, 15 Apr 2026 18:13:17 +0530
Message-ID: <yq5aldeo9yxm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Apr 13, 2026 at 12:49:34PM +0530, Aneesh Kumar K.V wrote:
>> > 2) Using phys_to_dma_unencrypted() is not enlighted about already
>> > decrypted memory and will use the wrong functions for that.
>>=20
>> Can you split this into a separate patch? I=E2=80=99m finding it difficu=
lt to
>> understand what the issue is here. Adding the unencrypted flag multiple
>> times to an address is not a problem in itself. Even so, I still do not
>> follow when we would end up doing that.
>
> I think my comments show how to address it right..
>
>> phys_to_dma_direct should depend on the device state.
>
> No, it depends on what state the CPU address is, which in some flows
> would have depended on the device state, but by the time you get to
> generating a dma_addr_t it should be based 100% on the current state
> of the phys_addr and nothing else.
>
> Assuming that a T=3D0 device must be presented unencrypted memory is an
> easy hack but it doesn't work when we get to T=3D1 devices that can
> handle both encryped and decrypted memory. Then we need to track it
> explicitly.
>
> The only places we we should check the device state for T=3D0 is at the
> very top when we decide if we force it to swiotlb and inside swiotlb
> when we decide if the allocation should be decrypted. Everything else
> should flow from tracking the phy's state, and be tied into the new
> DMA ATTR UNENCRYPTED.
>

For things like

#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)

Where do you suggest DMA_ATTR_CC_DECRYPTED be set?

Right now i have it around

static inline dma_addr_t dma_direct_map_phys(struct device *dev,
		phys_addr_t phys, size_t size, enum dma_data_direction dir,
		unsigned long attrs)
{
	dma_addr_t dma_addr;

	if (force_dma_unencrypted(dev))
		attrs |=3D DMA_ATTR_CC_DECRYPTED;

I am wondering whether we should do earlier. But we have only audited=20
dma-direct for memory encryption.

-aneesh
