Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DCF3596B
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737635792; cv=none; b=KNUnk+VxtJ74z93TnBeTjcGg0lPGO1Y4hVF/ETbqGnLFfiUjL3YZfkT/TDoSyGLFL3o5ZMj1k5fKeTBxLo48hdsSJ/Ne3nYMTnjLheTAuN1koBbe/EIhSLAq5Jo4vLwRwdP8A6UXhpoIDmyc8xLczdVuKbNTDIOh6AHxl1fV9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737635792; c=relaxed/simple;
	bh=bwHb3k0CMWm2DzAjQYvrhi+e8E2Ul8Z3iF5VhIAnfbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ65skfgyTgzqLU0g9IliYZsqRkq/3n+0eo4mYPxVwalgACMIzdu1ynsGEBldbqkxHTeVBpdUtoXMdriSX83udBAHzWIDXyGA7uqeVmv3M1bosBsOLVFT9CjgJCW9zjDQUScYqVTBo2Y/+7vFfGd7kVGuY3tC+Oboe5CS+sHWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=cAAkQUV3; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="cAAkQUV3"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 597C22113BB;
	Thu, 23 Jan 2025 13:30:14 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1737635414; bh=a9q1Fh53qZ0gTFwMyqXiOD//fC1kdAqomwhFFXs3J8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cAAkQUV3E0cfe+dLy2TE9ZFw6ZpwKfjnEOVcEQBkuAlmup6LIFJ6KiuANUkNJ0/7n
	 R60TRaqlXwkTE0RsgDn/kXz4QPXS41Y5il7E8bdkXL13yrOy0wWC/AJa7wjLDCPKvQ
	 y5hcp4zs7LwXGYkfRxbXGq97F2e0Zuve2srf/9GfyBZ/PpeUkhnWX2AhP56A0H9VPb
	 GAit4TStmGVR8ryZQtECd3l0+GdQkGPldHmAt+7epkYbL5u4sy2jY2KnL4Ht9GFmNf
	 CeV2FWq/4YygRFF/msYfsDE2bLEnO/b+bXaPJtU33xc5f6ix5sS68+veKOhci5bZUg
	 ymTzAu5fmFqKg==
Date: Thu, 23 Jan 2025 13:30:09 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 linux-kernel@vger.kernel.org (open list), Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 iommu@lists.linux.dev (open list:DMA MAPPING HELPERS)
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <20250123132940.1f3c2666@mordecai.tesarici.cz>
In-Reply-To: <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
	<20250123104333.1340512-3-abdiel.janulgue@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 12:42:58 +0200
Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:

> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
> 
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>[...]
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
> +/// large consistent DMA regions.
> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
> +/// processor's virtual address space) and the device address which can be given to the device
> +/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the cpu address is a valid pointer
> +/// to an allocated region of consistent memory and we hold a reference to the device.
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attrs,
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent memory.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev.into(), 4, GFP_KERNEL,
> +    ///                                                                  DMA_ATTR_NO_WARN)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_attrs(
> +        dev: ARef<Device>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(
> +            core::mem::size_of::<T>() > 0,
> +            "It doesn't make sense for the allocated type to be a ZST"
> +        );
> +
> +        let size = count
> +            .checked_mul(core::mem::size_of::<T>())
> +            .ok_or(EOVERFLOW)?;
> +        let mut dma_handle = 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +        // We ensure that we catch the failure on this function and throw an ENOMEM
> +        let ret = unsafe {
> +            bindings::dma_alloc_attrs(
> +                dev.as_raw(),
> +                size,
> +                &mut dma_handle,
> +                gfp_flags.as_raw(),
> +                dma_attrs.as_raw(),
> +            )
> +        };
> +        if ret.is_null() {
> +            return Err(ENOMEM);
> +        }
> +        // INVARIANT: We just successfully allocated a coherent region which is accessible for
> +        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
> +        // to the device.
> +        Ok(Self {
> +            dev,
> +            dma_handle,
> +            count,
> +            cpu_addr: ret as *mut T,
> +            dma_attrs,
> +        })
> +    }
> +
> +    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
> +    pub fn alloc_coherent(
> +        dev: ARef<Device>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +    ) -> Result<CoherentAllocation<T>> {
> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
> +    }
> +
> +    /// Returns the device, base address, dma handle, attributes and the size of the
> +    /// allocated region.
> +    ///
> +    /// The caller takes ownership of the returned resources, i.e., will have the responsibility
> +    /// in calling `bindings::dma_free_attrs`. The allocated region is valid as long as
> +    /// the returned device exists.
> +    pub fn into_parts(
> +        self,
> +    ) -> (
> +        ARef<Device>,
> +        *mut T,
> +        bindings::dma_addr_t,
> +        crate::ffi::c_ulong,
> +        usize,
> +    ) {
> +        let size = self.count * core::mem::size_of::<T>();
> +        let ret = (
> +            // SAFETY: `&self.dev` is valid for reads.
> +            unsafe { core::ptr::read(&self.dev) },
> +            self.cpu_addr,
> +            self.dma_handle,
> +            self.dma_attrs.as_raw(),
> +            size,
> +        );
> +        core::mem::forget(self);
> +        ret
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's virtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's virtual address space as
> +    /// a mutable pointer.
> +    pub fn start_ptr_mut(&mut self) -> *mut T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may given to the device as the DMA address base of
> +    /// the region.
> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +        self.dma_handle
> +    }
> +
> +    /// Reads data from the region starting from `offset` as a slice.
> +    /// `offset` and `count` are in units of `T`, not the number of bytes.
> +    ///
> +    /// Due to the safety requirements of slice, the data returned should be regarded by the
> +    /// caller as a snapshot of the region when this function is called, as the region could
> +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
> +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
> +    /// could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that no hardware operations that involve the buffer are currently
> +    /// taking place while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
> +        if offset + count >= self.count {

I'm probably missing something, but how do you know that this addition
can't overflow? I mean, since this is a public function, users can do
something dumb such as buf.as_slice(usize::MAX, n), can't they?

What about something like:

    let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
    if end >= self.count { ... }

> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllocation`,
> +        // we've just checked that the range and index is within bounds. The immutability of the
> +        // of data is also guaranteed by the safety requirements of the function.
> +        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
> +    }
> +
> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
> +    /// number of bytes.
> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> +        if offset + src.len() >= self.count {

Same here.

Petr T
