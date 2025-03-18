Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB120D502;
	Tue, 18 Mar 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304492; cv=none; b=rXknN7yxFRqmN5gHNQf1qFv3bZunnbA3Mae05bSRTM7y2ggdyp5aBV9iUPljGjbTb4/uETI75rEJ8lcKMA0D9D2Qu+t0fugHsVdWR/cMimUTsldm25/FqSdwAkwUIpaicBrGq0+x/be3TX0glfFQOvcafcAfIE58ei10YaFdFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304492; c=relaxed/simple;
	bh=Y19lGFqI1feFU+EfLxPKy0E333YJeT3tALgbehX6FA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AvbNKMxBO5tdySy78RcMRPNP/8PBYifJ9cIUb95LOm9dTESUR66Bsd1E8Msu07MvxUwA0j4jpPu9jGpAWLjLY+soNIE8XfbJo7D5O/IjpvUmZWFUnGHY3HmVv6P5N5wq2ai0ZhaT9pEtgmIIiYqifqH5nFkC09PffsxAHYYffkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdbmWyaB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdbmWyaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C160EC4CEE3;
	Tue, 18 Mar 2025 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742304491;
	bh=Y19lGFqI1feFU+EfLxPKy0E333YJeT3tALgbehX6FA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YdbmWyaBKCX17M+dS+mJYXo2PtJQ84WswFCHk287ISI1T5wivztkiz0IyOk1mKpO8
	 xBu5F0YzmLqgo3NtunoLNjDek/U1U/HhZIbg+F8PhYQHABQdDKILDLurbOyjsjkc2G
	 SI5UfY4l2J/3irW5H+AH0YUU+y4rZRJTcHa66aIU147XKqYAyTNn7JNr21P/46VQgL
	 TMOUBRYU6sZvFP0mJHW3SMulP/vaBjgwpWtvXBPa9+M6PRyPC9HalEh/kSEuNWJsJm
	 UCoO3vN+s5G5kluVW84ChfxnvWGadnBb/PmTRiJAY0MxkcjF5gURdN4/OViyXF7fN0
	 WdN/txXRNX0Fw==
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
Subject: Re: [PATCH v14 03/11] samples: rust: add Rust dma test sample driver
In-Reply-To: <20250311174930.2348813-4-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Tue, 11 Mar 2025 19:47:59 +0200")
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
	<20250311174930.2348813-4-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 14:26:45 +0100
Message-ID: <87frjajwq2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Abdiel Janulgue <abdiel.janulgue@gmail.com> writes:

> Add a simple driver to excercise the basics of the Rust DMA
> coherent allocator bindings.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  samples/rust/Kconfig     | 11 +++++
>  samples/rust/Makefile    |  1 +
>  samples/rust/rust_dma.rs | 97 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 samples/rust/rust_dma.rs
>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 3b6eae84b297..e2d14aa6beec 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -78,4 +78,15 @@ config SAMPLE_RUST_HOSTPROGS
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_DRIVER_DMA
> +	tristate "DMA Test Driver"
> +	depends on PCI
> +	help
> +	  This option builds the Rust dma test driver sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called dma.
> +
> +	  If unsure, say N.
> +
>  endif # SAMPLES_RUST
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 0dbc6d90f1ef..1a9aff6e8d6a 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_DMA)		+= rust_dma.o
>  
>  rust_print-y := rust_print_main.o rust_print_events.o
>  
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> new file mode 100644
> index 000000000000..1740140faba6
> --- /dev/null
> +++ b/samples/rust/rust_dma.rs
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust DMA api test (based on QEMU's `pci-testdev`).
> +//!
> +//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
> +
> +use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
> +
> +struct DmaSampleDriver {
> +    pdev: pci::Device,
> +    ca: CoherentAllocation<MyStruct>,
> +}
> +
> +const TEST_VALUES: [(u32, u32); 5] = [
> +    (0xa, 0xb),
> +    (0xc, 0xd),
> +    (0xe, 0xf),
> +    (0xab, 0xba),
> +    (0xcd, 0xef),
> +];
> +
> +struct MyStruct {
> +    h: u32,
> +    b: u32,
> +}
> +
> +impl MyStruct {
> +    fn new(h: u32, b: u32) -> Self {
> +        Self { h, b }
> +    }
> +}
> +// SAFETY: All bit patterns are acceptable values for `MyStruct`.
> +unsafe impl kernel::transmute::AsBytes for MyStruct {}
> +// SAFETY: Instances of `MyStruct` have no uninitialized portions.
> +unsafe impl kernel::transmute::FromBytes for MyStruct {}
> +
> +kernel::pci_device_table!(
> +    PCI_TABLE,
> +    MODULE_PCI_TABLE,
> +    <DmaSampleDriver as pci::Driver>::IdInfo,
> +    [(
> +        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
> +        ()
> +    )]
> +);
> +
> +impl pci::Driver for DmaSampleDriver {
> +    type IdInfo = ();
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
> +
> +    fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
> +        dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
> +
> +        let ca: CoherentAllocation<MyStruct> =
> +            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
> +
> +        || -> Result {
> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
> +            }
> +
> +            Ok(())
> +        }()?;

Why is this placed in a closure? Left over from deferred error for pin-init?

> +
> +        let drvdata = KBox::new(
> +            Self {
> +                pdev: pdev.clone(),
> +                ca,
> +            },
> +            GFP_KERNEL,
> +        )?;
> +
> +        Ok(drvdata.into())
> +    }
> +}
> +
> +impl Drop for DmaSampleDriver {
> +    fn drop(&mut self) {
> +        dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
> +
> +        let _ = || -> Result {
> +            for (i, value) in TEST_VALUES.into_iter().enumerate() {
> +                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
> +                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);

We should probably change `dma_read!`/`dma_write!` to return `Result`,
so that we don't have to wrap these calls in a closure for obscure reasons.


Best regards,
Andreas Hindborg


