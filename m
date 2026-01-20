Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934F4611E4;
	Tue, 20 Jan 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922756; cv=none; b=I0hjEARxP0ZLtgs6yXvUaI8mhouvtFgfXe19CfOmuoO0oFDjIaHRxdi7DckZyN8hU561ZUe0ZVoMT93l4qipFCb7VPCb5r8m/OhuQBEESvv1KE24knYKPYD3El3VqAQWzez6ilTLga3Hwve1K2vCd5SPRQUPiF5ESYFSFxNbkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922756; c=relaxed/simple;
	bh=Mg/68e3LEEGJSTTdPENAhwglczVsOIEKZGwGh9E8eOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iN0+nq2PDkvL0JanQOSGh4Iv1zui12TrKZomgibzBNqNgH10/5Wqqju5fI8DqqA47vscJBvnmkutQALV5z6J42aadNI2RWlgyKOjmZnSnuB5INb+KqMVyq3cRTk6wxPYJ9ajObKU1a+2vyJI4fUustqDI1ACoonSb9nq3yujZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAOVOUcN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAOVOUcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96717C16AAE;
	Tue, 20 Jan 2026 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768922755;
	bh=Mg/68e3LEEGJSTTdPENAhwglczVsOIEKZGwGh9E8eOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZAOVOUcNyww8YZyJQoZsTa9P/L615VRDFSRUhucRmqyuhscPM5OKTI2zG7xx2oO3w
	 cYsZ7PqOJUq4q3ipnRpERAyltXdJJutFkLADmiUOF0K2hutZW+4G1gcsMI6YrDYE1z
	 qgvmX9NDsLNhejBr9VsbLOkZvO3RIyMAcpg3o7nB1FuN8VVMCq4KyGJn/5ezZk/EVj
	 b5YfOMIoVw8oL8SzJi02DIn8n4+sufRXRdgUoZ89qVkfmrfy32JWBEePHm+G4V7y8x
	 tJbfRLYVxsUY3gshmxt856TQ0r4xqwt4SQBwTu9k9dxYhWwPgUIBn0DyiQTR6cTZku
	 EBLqyxuw9xlvA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, suzuki.poulose@arm.com, steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
In-Reply-To: <20260120132657.GO961572@ziepe.ca>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <20260120132657.GO961572@ziepe.ca>
Date: Tue, 20 Jan 2026 20:55:43 +0530
Message-ID: <yq5ams28jog8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Jan 20, 2026 at 12:12:54PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> On systems that apply an address encryption tag or mask to DMA addresses,
>> DMA mask validation must be performed against the canonical DMA address.
>> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
>> can incorrectly fail capability checks, since architecture-specific
>> encryption bits are not part of the device=E2=80=99s actual DMA addressi=
ng
>> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
>> addresses.
>
> Huh?
>
> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>                 phys_addr_t phys)
> {
>         if (force_dma_unencrypted(dev))
>                 return phys_to_dma_unencrypted(dev, phys);
>         return phys_to_dma(dev, phys);
> }
>
> dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
>                 enum dma_data_direction dir, unsigned long attrs)
> {
> [..]
>
>         /* Ensure that the address returned is DMA'ble */
>         dma_addr =3D phys_to_dma_unencrypted(dev, swiotlb_addr);
> [..]
>         return dma_addr;
> }
>
> The check in dma_direct_supported() is checking if the device's HW
> capability can contain the range of dma_addr_t's the DMA API will
> generate. Since it above is generating dma_addr_t's with the
> PROT_NS_SHARED set, it is correct to check it against the mask.
>
> If the IOVA does not contain PROT_NS_SHARED then I would expect all of
> the above to be removed too?
>
> Can you please explain what the probem is better?
>

There is no specific problem identified. The motivation for this change
is to ensure that the trusted device mask check is accurate.

>
> I just had a long talk with our internal people about this very
> subject and they were adament that the ARM design had the T=3D0 SMMU S2
> configured so that the IOVA starts at PROT_NS_SHARED, not 0. I am
> against this, I think it is a bad choice, and this patch is showing
> exactly why :)
>
> IMHO you should map the T=3D0 S2 so that the IOVA starts at 0 and we
> don't add PROT_NS_SHARED to the IOVA anyhwere.
>

But how will we support a trusted device access to both shared and
private memory? Commit  7d953a06241624ee2efb172d037a4168978f4147 goes
into some details w.r.t why PROT_NS_SHARED was added to dma_addr_t.

>
> This logic is going to be wrong for T=3D1 DMA to private memory though.
>
> Jason

-aneesh
