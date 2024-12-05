Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB691773A
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733404047; cv=none; b=tYfxhZd+aeghdR5stRl4YWy5vpcaHi/oh5JUViqDqK6RijARD1nC8c9J6ZbGdSGKoRdq7UwlTlkJ0eJevsQ8KWU415s28MA0KHHhkYBx6u6GUbICfU+uCU5fLh/HqqjpB7LG3QNWMoONED4V4nI2mAtK5FKHFNl2L9KPjJlY65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733404047; c=relaxed/simple;
	bh=hXQ5wZu61uFc7V4ocZVh1IUQhjIFXGv8g9nffLwiDps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpUmNhEn4BHSr9hOBSpydqbZ1QsTMhoJT5yEgE2BIVVCCDvueZu5cL8yiWT9ed7NWh9CQjMq1iYbSR4UXzb7/Srgru72O6jZvdKpCF4LUgqx1lY/MlhfSylPE9T7shcQz01GovWrliTVeyJSj3nJhM5FNwVezD2/ISs+DwjPleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E7741063;
	Thu,  5 Dec 2024 05:07:52 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E9533F71E;
	Thu,  5 Dec 2024 05:07:22 -0800 (PST)
Message-ID: <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
Date: Thu, 5 Dec 2024 13:07:14 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 "open list:RUST" <rust-for-linux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
 <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 11:32 am, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/kernel/dma.rs              | 136 ++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs              |   1 +
>   3 files changed, 138 insertions(+)
>   create mode 100644 rust/kernel/dma.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 5c4dfe22f41a..49bf713b9bb6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>   #include <linux/blk_types.h>
>   #include <linux/blkdev.h>
>   #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
>   #include <linux/errname.h>
>   #include <linux/ethtool.h>
>   #include <linux/file.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..dd725c571ff7
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
> +
> +use crate::{
> +    bindings,
> +    build_assert,
> +    device::Device,
> +    error::code::*,
> +    error::Result,
> +    types::ARef,
> +    transmute::{AsBytes, FromBytes},
> +};
> +
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
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent memory.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::CoherentAllocation;
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_coherent(
> +        dev: &Device,
> +        count: usize,
> +        flags: kernel::alloc::Flags,

Might it be worth adding at least a placeholder type and argument for 
"attrs" as well, so there's less churn involved in coming back and 
adding it later? Or is the intention to have a separate 
dma_alloc_attrs() constructor for such users?

(I assume adding an mmap method as and when needed won't affect any 
existing users, so is fine not to worry about right now)

Thanks,
Robin.

> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(core::mem::size_of::<T>() > 0,
> +                      "It doesn't make sense for the allocated type to be a ZST");
> +
> +        let size = count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
> +        let mut dma_handle = 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +        // We ensure that we catch the failure on this function and throw an ENOMEM
> +        let ret = unsafe {
> +            bindings::dma_alloc_attrs(
> +                dev.as_raw(),
> +                size,
> +                &mut dma_handle, flags.as_raw(),
> +                0,
> +            )
> +        };
> +        if ret.is_null() {
> +            return Err(ENOMEM)
> +        }
> +        // INVARIANT: We just successfully allocated a coherent region which is accessible for
> +        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
> +        // to the device.
> +        Ok(Self {
> +            dev: dev.into(),
> +            dma_handle,
> +            count,
> +            cpu_addr: ret as *mut T,
> +        })
> +    }
> +
> +    /// Returns the base address to the allocated region and the dma handle. The caller takes
> +    /// ownership of the returned resources.
> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
> +        let ret = (self.cpu_addr as _, self.dma_handle);
> +        core::mem::forget(self);
> +        ret
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's virtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr as _
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
> +    /// Returns the CPU-addressable region as a slice.
> +    pub fn cpu_buf(&self) -> &[T]
> +    {
> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
> +    }
> +
> +    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
> +    {
> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
> +        // is valid for reads for `self.count * size_of::<T>` bytes.
> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size = self.count * core::mem::size_of::<T>();
> +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
> +        // type invariants on `CoherentAllocation`.
> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
> +                                          self.cpu_addr as _,
> +                                          self.dma_handle, 0) }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e1065a7551a3..6e90ebf5a130 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -35,6 +35,7 @@
>   mod build_assert;
>   pub mod cred;
>   pub mod device;
> +pub mod dma;
>   pub mod error;
>   #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>   pub mod firmware;
