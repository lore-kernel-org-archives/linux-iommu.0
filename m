Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFD2561BC;
	Fri,  7 Mar 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378411; cv=none; b=LvcXfVC/Fvv9qH5V/SEZ1KEIEEG7x6Ha9jaDjuAkum99U02rmjaMnXb+avJ+Rhmd3cN7yOcS9emDBgJHeYvERV3ucWSo3/IrEIskQEXfhWLgvHIJCwCQa86q7BN2vzgsG1Gw3H6fhGZjL01FdtOJEQ8mSgQsl1cY9zZ6NJeAUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378411; c=relaxed/simple;
	bh=jL7DgXRTAIxdsq7tMW4vNI8UHMSejygWFWiH2zOE9K0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0zEQpbJeVHkR6sA9SeBIINHDaFbPNCKH2nD8/vgYC4IYjODyf4+tUIiNPUVmo3FYwPUwnyGBBbFCFk/aOArNhhhFdsuM3tNrz7K9972aotvifpiKEOS9jnNAITUMSKsrZ93pUrnRDKzXXwGfIRbKGoThy7Ha2Gyz5ip+8FR2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1E40Tt+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1E40Tt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55F1C4CED1;
	Fri,  7 Mar 2025 20:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378411;
	bh=jL7DgXRTAIxdsq7tMW4vNI8UHMSejygWFWiH2zOE9K0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h1E40Tt+pIMu5++zslxPZ29o+au/acKWXLM/y6n4n1FueDX/ZfXd1eNDYC8uaISX8
	 2UGh3YKC+GHPNLWLzOlGHzobyPUjxWe7JrNrYeQ+Ua4vYwbWh7nNZQPhFCky7jN96W
	 p6emh55NBl6FxEW9sDrz9+EQOsI4+QBl/QElW+VrVmHSY/SYRlet0LuxSKwQ2MFDm9
	 AJAwY3JDQboJN3n4BL4RBao0H4KUkQQTj7Mj3wW5PAneZAaWeC/M4P55dZMDpFLGJn
	 12kVDYgolDaS/zdFzJ4NUH6oFHgO6Mph7NmqicvaAEClGsJKYdImlutVNsPJqxGImk
	 9J8laLKf7HeVA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  <daniel.almeida@collabora.com>,
  <dakr@kernel.org>,  <robin.murphy@arm.com>,  <aliceryhl@google.com>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 4/7] rust: device: add dma addressing capabilities
In-Reply-To: <20250307110821.1703422-5-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Fri, 07 Mar 2025 13:06:21 +0200")
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
	<nxaaNW1XIbhf7dSf8aRLVF5Se-0maF6BhX8GaUXlsOL-QOste8OMQxtmhYe_BYI6FYFEMeHEzy1s4OEy7PdGKw==@protonmail.internalid>
	<20250307110821.1703422-5-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 21:12:38 +0100
Message-ID: <877c5038i1.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add functions to set the DMA mask to inform the kernel about the
> device's DMA addressing capabilities.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/helpers/dma.c     |  8 ++++++++
>  rust/helpers/helpers.c |  1 +
>  rust/kernel/device.rs  | 29 +++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+)
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
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index db2d9658ba47..f9d3d4f60ddb 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -6,10 +6,12 @@
>
>  use crate::{
>      bindings,
> +    error::Result,
>      str::CStr,
>      types::{ARef, Opaque},
>  };
>  use core::{fmt, ptr};
> +use kernel::prelude::*;
>
>  #[cfg(CONFIG_PRINTK)]
>  use crate::c_str;
> @@ -187,6 +189,33 @@ pub fn property_present(&self, name: &CStr) -> bool {
>          // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
>          unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
>      }
> +
> +    /// Inform the kernel about the device's DMA addressing capabilities.
> +    ///
> +    /// Set both the DMA mask and the coherent DMA mask to the same thing.
> +    /// Note that we don't check the return value from the C `dma_set_coherent_mask`
> +    /// as the DMA API guarantees that the coherent DMA mask can be set to
> +    /// the same or smaller than the streaming DMA mask.
> +    pub fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_raw(), mask) };
> +        if ret != 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }

I think we can use `Error::from_errno` here (and below). As far as I can
tell, these C functions return negative on error.

> +
> +    /// Same as [`dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
> +    pub fn dma_set_mask(&mut self, mask: u64) -> Result {
> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +        let ret = unsafe { bindings::dma_set_mask(self.as_raw(), mask) };
> +        if ret != 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
>  }
>
>  // SAFETY: Instances of `Device` are always reference-counted.


Best regards,
Andreas Hindborg


