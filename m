Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30B2686A0;
	Fri,  8 Aug 2025 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655530; cv=none; b=M2SIfIx3Wi5BaBXyZbSUSktNhKoEn+3sFBfgusMOd66W3k8b5Ag7POs69F5gRE2SdX7h7vzEebtC/BHOJxkEjtLg1xu17jq5zL9mKksh23CVfxV5GGHBQMOIK4V3cr7tVN9aJ6kfcRalwPdGW+TBH51SB3cB16y9/1dCEH3fXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655530; c=relaxed/simple;
	bh=F7tb5lTFFPLSB0Eciw8hAvvjQDFPIiUrB4o3KSIztZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jb/ydgPBfK/fbmhoStcR9PbigvhmqKbChUT7V+fXChqgpt8HnTFxL821OR6gjrNH1v/27uWO3oseGjkDs4BmLHiqwe6SBJ4nfRJZFd04nPu6ZOiLhgsgDVh8ZukriH10BudLgIkW4CmG8u/VzM7i42Jm+bm4pCSDM55siduVKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOJMvRiT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOJMvRiT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF17C4CEED;
	Fri,  8 Aug 2025 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754655529;
	bh=F7tb5lTFFPLSB0Eciw8hAvvjQDFPIiUrB4o3KSIztZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MOJMvRiTkoCjCsZDaDiLgFP/fMhKxU7zGC3lkncZ2fP/t3d9G+9z0vfYRr6ckRHkx
	 29jKmjJ4DmXVYPIFVZQa9UbAm+3pLE0eSroF23aqMx8IJcT2gUQ7slW+Dkm3QwHkOo
	 Yk3sG3x/kPtk2X/l+MCCGtYGFexCtLFjgRGph3DYWAUuTApmspkzmxZ+T+gU/NCSpF
	 9D/Hq7jbVS4PWg8TdifZFNeHoGgkXoVkf0/KsJRmOwpJ3mWMbSfnGlooey7UtjkTMJ
	 kc8vtFIMw2nLXuvNh2mIyImqpyHNTX5h2QIj/SOLQk3liDh7tRprdKpUWyBbOz8JL7
	 TyDSPxxEha9xw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, acourbot@nvidia.com,
 dakr@kernel.org, jgg@ziepe.ca, lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Tamir
 Duberstein <tamird@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Herbert
 Xu <herbert@gondor.apana.org.au>, Caleb Sander Mateos
 <csander@purestorage.com>, Petr Tesarik <petr@tesarici.cz>, Sui
 Jingfeng <sui.jingfeng@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com, iommu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: Re: [PATCH v3 2/2] samples: rust: add sample code for scatterlist
 abstraction
In-Reply-To: <20250718103359.1026240-3-abdiel.janulgue@gmail.com>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <vdYZDYMXRnQEadlW9C4I5MvuQi9SnRXgNF-ACtJ9C3Xh1pq6Ajc673GIIOtqJ4VZ13FzSeH_iAvA9vVKQii4DA==@protonmail.internalid>
 <20250718103359.1026240-3-abdiel.janulgue@gmail.com>
Date: Fri, 08 Aug 2025 14:18:36 +0200
Message-ID: <87a54a57mr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> Add simple excercises to test the scatterlist abstraction.
>
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  samples/rust/rust_dma.rs | 49 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 9e05d5c0cdae..1fa278e8e29a 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -4,11 +4,33 @@
>  //!
>  //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
>
> -use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
> +use kernel::{
> +    bindings, device::Core, dma::CoherentAllocation, page::*, pci, prelude::*, scatterlist::*,
> +    sync::Arc, types::ARef,
> +};
>
>  struct DmaSampleDriver {
>      pdev: ARef<pci::Device>,
>      ca: CoherentAllocation<MyStruct>,
> +    _sgt: SGTable<OwnedSgt<PagesArray>, ManagedMapping>,
> +}
> +
> +struct PagesArray(KVec<Page>);
> +impl SGTablePages for PagesArray {
> +    fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)> {
> +        self.0.iter().map(|page| (page, kernel::page::PAGE_SIZE, 0))
> +    }
> +
> +    fn entries(&self) -> usize {
> +        self.0.len()
> +    }
> +}
> +
> +struct WrappedArc(Arc<kernel::bindings::sg_table>);
> +impl core::borrow::Borrow<kernel::bindings::sg_table> for WrappedArc {
> +    fn borrow(&self) -> &kernel::bindings::sg_table {
> +        &self.0
> +    }
>  }
>
>  const TEST_VALUES: [(u32, u32); 5] = [
> @@ -58,10 +80,35 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
>              kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
>          }
>
> +        let mut pages = KVec::new();
> +        for _ in TEST_VALUES.into_iter() {
> +            let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
> +        }
> +
> +        // Let's pretend this is valid...
> +        // SAFETY: `sg_table` is not a reference.
> +        let sg_table: bindings::sg_table = unsafe { core::mem::zeroed() };

I think this initialization can be safe with recent pin-init patches
[0]. Perhaps rebase on that, or add a todo?

Best regards,
Andreas Hindborg

[0] https://lore.kernel.org/r/20250523145125.523275-1-lossin@kernel.org

