Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519961F791C;
	Mon,  3 Mar 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001415; cv=none; b=LG8jMEMGOrBTFKeEVIzVIxBGu9OTx7ROArMBTHIRKQyycOhTsil/2HeD6HgxLAgUgk1r9Oc8QRkWwnhIVwcVrsyxN/HHau2oSHJY+kwThVviOPnudcwH1wGOK4HbziCh8d9fNVkj+OciXgWRXzpZL2T+Rcne8FLFBg+qP1QIq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001415; c=relaxed/simple;
	bh=QSfb1tEP+GCrXu68ufVQ5P6AVc/pou71CBN+bmPdXeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gZugCqOESqUxw5LDVLjD9jncbwpU5M/IxZoBRvuz02XdSG1EvJwuToOid8zE8ZOmlPIooIP74KyYWnuxwzNIOc0cRUsSt63EVHDQO4NlUlMnY9Ey5+yX6biWU0nSHS/UqDwqnXJUCVS2IaZTQFedU5YRBrsJlh+MQ5NkZJX2uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyJRODCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyJRODCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D3DC4CED6;
	Mon,  3 Mar 2025 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741001414;
	bh=QSfb1tEP+GCrXu68ufVQ5P6AVc/pou71CBN+bmPdXeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uyJRODCfavQFKwjL4D3k4Oo6IqxlxFb4bNZ+lGS31+PMGDqw64PSES87DnogF8Rcq
	 2OaBf2L+wW4eDpJfvf5ekwmsX7+lCP1NDFQ37BHIVLIgxOuxYZLp/CbgUbaopZryJu
	 dugWbrY81yMTB22kqvuHVBEXgZvayBJZA3ofpSCrdPbLyyfshwlbN+W4Jv15Rp8YpK
	 7p8CeE41XKJ3TaYIQmDb1ixaYJrup5fdwK8GbVzvyJsDigxzuUvB8NzJDeC2EO5orb
	 /pcrnkIqpauuDZosLnFPgxJl9eX8eax16PCr9sRYpFuJOtvJYNtW9ZabhwOKnRdXW1
	 o+fsuqdaQ3Fjw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <aliceryhl@google.com>,  <dakr@kernel.org>,  <robin.murphy@arm.com>,
  <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 24 Feb 2025 13:49:06 +0200")
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
	<k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
	<20250224115007.2072043-3-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 12:30:01 +0100
Message-ID: <87h64al5c6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Nacked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
[...]

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
> new file mode 100644
> index 000000000000..b4dd5d411711
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,421 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
> +
> +use crate::{
> +    bindings, build_assert,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    transmute::{AsBytes, FromBytes},
> +    types::ARef,
> +};
> +
> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
> +/// both streaming and coherent APIs together.
> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
> +}
> +
> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
> +}

I'm rebasing some of the dma pool code I'm using for NVMe on top of
these patches, and I notice that these methods in the original code from
way back (besides being on Device) has these methods return `Result`:

    pub fn dma_set_mask(&self, mask: u64) -> Result {
        let dev = self.as_raw();
        let ret = unsafe { bindings::dma_set_mask(dev as _, mask) };
        if ret != 0 {
            Err(Error::from_errno(ret))
        } else {
            Ok(())
        }
    }

Is there a reason for not returning a `Result` in this series?


Best regards,
Andreas Hindborg


