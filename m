Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3312080E3;
	Tue, 18 Mar 2025 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304991; cv=none; b=ue+G8QXKEcvBQHt17JSXYYQpYjXy41QwHA0aTDtP5CZFT9gpTNJW7Af0cusUTfnZ9x7JdZ9qWO58p3YyDeptgVLGZl1UrCv88UWIQPsjRO5thX6Tm6LHXJl69TUyLMd1hJU8wS/sHMPhJVe+t70A/R2BCp5n8s736zwkk/H/Z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304991; c=relaxed/simple;
	bh=saqQlotH+Iko5JWXDkpcuXeW/I/jiikTSlVoCkm/io8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sD+3zQ71y9GFUfpI4KaIQ+Z/x19ASj/4dYc7gIDxqrf3/eDH0lKjtpELkNb+gXROhUaX22T23ciaNzmC6JGVChEs3ANAyzCA8a7DLyxsy7vfR9XPHIh+wfoLvlyXn51A3HJtuQxs/OU9HWazmOJGm5w4Ct2wUBhALDH1ko6UODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHftMO0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHftMO0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EDCC4CEDD;
	Tue, 18 Mar 2025 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742304991;
	bh=saqQlotH+Iko5JWXDkpcuXeW/I/jiikTSlVoCkm/io8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vHftMO0P17sXxnoh7unZEUFm8mSAXeLyXskKc173VT8TwjQlWibbOIxYoWIpAAkTL
	 bo2Vq3K9t81II6b24lVxj9MgI0y53ZV0WunUm46dvdr2TGvVey9iZtPmCqRVziSfNm
	 LFirI2Q3kwW5/xgrIFxUiXJAcsLDDmRkd5/OmeEhlpgbYUPPGzPycRnt9lwbjREBco
	 V+JCTmv1fX9D4bPMBvqlIx8409N3Dt5vGuPXv79CJAXxxWlKyPI2BAtiJZ6wQnQVWp
	 bBArlzjFO7/h0eONGdExoGRKVDQa9tK06rbMLV2KY7KfPRZsQC5sDsTJbr7LHRzOjB
	 /3ouFSzKuSn2A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org,  daniel.almeida@collabora.com,
  dakr@kernel.org,  robin.murphy@arm.com,  aliceryhl@google.com,  Miguel
 Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Trevor Gross <tmgross@umich.edu>,  Valentin Obst
 <kernel@valentinobst.de>,  linux-kernel@vger.kernel.org (open list),
  Christoph Hellwig <hch@lst.de>,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  airlied@redhat.com,  iommu@lists.linux.dev
 (open list:DMA MAPPING HELPERS)
Subject: Re: [PATCH v14 06/11] rust: dma: add dma addressing capabilities
In-Reply-To: <20250311174930.2348813-7-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Tue, 11 Mar 2025 19:48:02 +0200")
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
	<20250311174930.2348813-7-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 14:35:45 +0100
Message-ID: <87a59ijwb2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:

> From: Danilo Krummrich <dakr@kernel.org>
>
> Implement `dma_set_mask()` and `dma_set_mask_and_coherent()` in the
> `dma::Device` trait.
>
> Those methods are used to inform the kernel about the device's DMA
> addressing capabilities.
>
> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/dma.c     |  8 ++++++++
>  rust/helpers/helpers.c |  1 +
>  rust/kernel/dma.rs     | 46 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 52 insertions(+), 3 deletions(-)
>  create mode 100644 rust/helpers/dma.c
>
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> new file mode 100644
> index 000000000000..8eb482386f93
> --- /dev/null
> +++ b/rust/helpers/dma.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-mapping.h>
> +
> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
> +{
> +	return dma_set_mask_and_coherent(dev, mask);
> +}
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e115be..8f3808c8b7fe 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -13,6 +13,7 @@
>  #include "build_bug.c"
>  #include "cred.c"
>  #include "device.c"
> +#include "dma.c"
>  #include "err.c"
>  #include "fs.c"
>  #include "io.c"
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 7ff797a7ad18..ac3ec0042327 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -5,10 +5,10 @@
>  //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
>  
>  use crate::{
> -    bindings, build_assert,
> -    device,
> +    bindings, build_assert, device,
>      error::code::*,
>      error::Result,
> +    prelude::*,
>      transmute::{AsBytes, FromBytes},
>      types::ARef,
>  };
> @@ -18,7 +18,35 @@
>  /// The [`Device`] trait should be implemented by bus specific device representations, where the
>  /// underlying bus has potential support for DMA, such as [`crate::pci::Device`] or
>  /// [crate::platform::Device].
> -pub trait Device: AsRef<device::Device> {}
> +pub trait Device: AsRef<device::Device> {
> +    /// Inform the kernel about the device's DMA addressing capabilities.
> +    ///
> +    /// Set both the DMA mask and the coherent DMA mask to the same value.
> +    ///
> +    /// Note that we don't check the return value from the C `dma_set_coherent_mask` as the DMA API
> +    /// guarantees that the coherent DMA mask can be set to the same or smaller than the streaming
> +    /// DMA mask.
> +    fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
> +        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
> +        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask) };
> +        if ret != 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }

As mentioned earlier [1], I think we should use `to_result` here.


Best regards,
Andreas Hindborg



[1] https://lore.kernel.org/all/871pv3l3vi.fsf@kernel.org/


