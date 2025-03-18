Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8020CCF2;
	Tue, 18 Mar 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306492; cv=none; b=HAGrZDeoer3TkyVo/zPl0ReYo3sTseeLyxrN1jgVyQUqvXJLqGszT+EtccF5v36b7D5SGDTqLT/wydOnDLxlHfEGyy+tEZKMndAwvFayhUeZpw6x4LdjBmvGiOGv3/c9o+IcMWltK/9DkginHLW4DvjJK2IXatFXpAKI01QteAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306492; c=relaxed/simple;
	bh=NOx4Rsl32vZVRPya08wPUcqbZZLByyXHlZ0bv3+F8/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EKqaowpEDRxlrhmL0FtZEk5kqWCXo4hqmf7GL5X5Ozdq62pKYdGIl5tuhwsUgRRMgzJ0BrmMujNVYKDYVEgmj5x1LkNOs2YHgRcAzA9hXb1s9W2XbJ6ahLXJ8g375LFBvHIEC4f65PCIfp2WozFMPe6DYPE3Al+Kg/pSKZGMTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScYDcNdZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScYDcNdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2A7C4CEDD;
	Tue, 18 Mar 2025 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306491;
	bh=NOx4Rsl32vZVRPya08wPUcqbZZLByyXHlZ0bv3+F8/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ScYDcNdZzwtK7Gc8sLGTC/LgL5OL/fVAXzw1VYvwOOgERdXP3Dt3cl2sJiTLtoZY3
	 mfE5u2lnmkKAOiVj1jocl+Cm2HkrgxPzNjhIK+bD3x1L9DckChfUkV9vTXpoD6Nz/Q
	 dh4qHCgl7Dj059BEvCezDpSMqCT2APZGO0CjDAwSlhpGAeP7GPz/gPqWFnI88L4k1i
	 7v3p8HBkH+YlhDMNtxCCAtXG7n2WvKUXi/Uwbpeoh6xjvXxBd6ciCOvuachtsbRz77
	 9SFWmrjQpmczT9ar7MA6v5ioo0nEjVGOQ12NgIEG4A+IWJNHg+wTgypusrf2rpZsDd
	 4FgJq0X85oQ1A==
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
Subject: Re: [PATCH v14 09/11] rust: dma: use `dma::Device` in
 `CoherentAllocation`
In-Reply-To: <20250311174930.2348813-10-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Tue, 11 Mar 2025 19:48:05 +0200")
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
	<20250311174930.2348813-10-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 15:01:20 +0100
Message-ID: <87y0x2igjz.fsf@kernel.org>
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
> Require a `&dyn dma::Device` in `CoherentAllocation`, such that DMA
> memory can only be allocated with devices on potentially DMA capable
> busses.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/dma.rs       | 16 ++++++++--------
>  samples/rust/rust_dma.rs |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index ac3ec0042327..d0c6569cfc70 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -57,10 +57,9 @@ fn dma_set_mask(&mut self, mask: u64) -> Result {
>  /// # Examples
>  ///
>  /// ```
> -/// use kernel::device::Device;
> -/// use kernel::dma::{attrs::*, CoherentAllocation};
> +/// use kernel::dma::{attrs::*, Device, CoherentAllocation};
>  ///
> -/// # fn test(dev: &Device) -> Result {
> +/// # fn test(dev: &dyn Device) -> Result {
>  /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
>  /// let c: CoherentAllocation<u64> =
>  ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
> @@ -178,16 +177,15 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
>      /// # Examples
>      ///
>      /// ```
> -    /// use kernel::device::Device;
> -    /// use kernel::dma::{attrs::*, CoherentAllocation};
> +    /// use kernel::dma::{attrs::*, Device, CoherentAllocation};
>      ///
> -    /// # fn test(dev: &Device) -> Result {
> +    /// # fn test(dev: &dyn Device) -> Result {
>      /// let c: CoherentAllocation<u64> =
>      ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
>      /// # Ok::<(), Error>(()) }
>      /// ```
>      pub fn alloc_attrs(
> -        dev: &device::Device,
> +        dev: &dyn Device,
>          count: usize,
>          gfp_flags: kernel::alloc::Flags,
>          dma_attrs: Attrs,
> @@ -197,6 +195,8 @@ pub fn alloc_attrs(
>              "It doesn't make sense for the allocated type to be a ZST"
>          );
>  
> +        let dev = dev.as_ref();
> +
>          let size = count
>              .checked_mul(core::mem::size_of::<T>())
>              .ok_or(EOVERFLOW)?;
> @@ -229,7 +229,7 @@ pub fn alloc_attrs(
>      /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
>      /// `dma_attrs` is 0 by default.
>      pub fn alloc_coherent(
> -        dev: &device::Device,
> +        dev: &dyn Device,

Is it possible (and would it make sense?) to make these methods, or even
`CoherentAllocation` generic over the `D: Device` to get rid of the
dynamic dispatch:

    pub fn alloc_coherent(
        dev: &impl Device,
        count: usize,
        gfp_flags: kernel::alloc::Flags,
    ) -> Result<CoherentAllocation<T>> {


Best regards,
Andreas Hindborg




