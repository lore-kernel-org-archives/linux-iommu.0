Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12471F0E36
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482917; cv=none; b=glK7t2cBadcgZpEueEmVZXGx3NoBZIJXoYQjh6YGAqi2z6LM9/fOKmvnTePqko6D26Ie8vHYcjbnZ4rldEJZufjJheO+PgVxhPH7x8p+/tx8+4EVvdy3LOJL0DMbN+n6dV9FjNeqVLQdTTGlooPjSMe5Mh4l5uhWNpIkTlCzGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482917; c=relaxed/simple;
	bh=VY/cvca0HUwpqkSsQYr3AJehmzqE5Jiokff6xUMtuJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2yOOlWaGGwOfiGtZqjwudRWFvI/9DtlqMG55RdvyGMVJUFDkVegUUdQiI9K7pdUWKCtoY0Ti8yGUocg2jEHJrwILAyRp4a6Ab7kzWLkuRAqSAuICQNNKNhSDlZPaj6eBpcdY4neVVrK4MLCQiSIpRzQj3UKPvcxXSKRtv1sJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWJLGy9P; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWJLGy9P"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401e6efffcso6587911e87.3
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737482913; x=1738087713; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3RLXhkEWX2W2lkPbgPSDvojgR4wTSkuDLRO7ilCZzU=;
        b=SWJLGy9PTiQYoWWDDPKcrfIQ9ZmjdaIkZz5SWW1qTX8OabSpOL9VAcHmJpy1hq/igD
         D9KLnsAdODHjC4P08zYXECWn5fUAEz/al8fcK3pt6m2O1xY0bdyr4veY98NhnL/Qh5Qt
         75XPqfn5HyRnV9wgBtH/NKAEoI4VYg2jFsy1qQsZrqep80q+BT2GqCmYh+RwpkntlHUI
         Ilxvhm3zqizSimqkwRyVYPC9u+BjGGlIyVffVljCGCGqk9/J2pOfSGyP4jEYfCxd8Vi1
         xDKp57JzNwGtidqVkKW2vI1nhCK7IhtzfTP/vNO68px7r+0KJQEdFxDHg4OaIxjD8TLZ
         KkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737482913; x=1738087713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3RLXhkEWX2W2lkPbgPSDvojgR4wTSkuDLRO7ilCZzU=;
        b=JudK9wBgoHy7d9th6kxcAi3p5yALwZfJ4LevXm+GfAEVLvlsPsx9RTugPevW7W596q
         b22mV3XHjMS/KanVjyLzKnONDQcP5g3aw46ecMqyHn6zNEFvnIpZ0VXof/sVbHSjku1n
         +NnqbC1waQIHWK33zWYrxwQVDtb7vELxi3OdXM1yGWP8fu9vqccGnTTtUymqI0kIPSGW
         A5atp6RvyJf/f0gSH9r9usSGXxlV4v7MfqMgapEmZtIxGCI314m57R7+GwtKnwH1xxNN
         11nDnbVwRbuWiRWq0xXLlk39ehoIXcKJiyuigqdU7HLskrNbSgoHqmGCbuFuBsP+LhSK
         7g3w==
X-Forwarded-Encrypted: i=1; AJvYcCXf7KdZhxUgkzCHwzz7OHX49KE/+217wia6pfn+FpgAWE53o0gaUqsxE6MvEQ2Gl+040mvyiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdBsE+XqUKUgMBsAKQQqOYcZXoD+DER2nXdo4GMedn7jCCNAOy
	P0rHWC/bvYaje/69LnfVJQeo5jG5SfYhnn7DDGiufItlRLAdhBzS
X-Gm-Gg: ASbGncsstdUslVptg5Rg8L/x/GTn1hGQxMlpp34nstj8iD1+V5TmGyH1W0bLe5msxGl
	mVK1X/ON0OeINloMCkf0VsBu4HKaNHxiQ59fyuwd5u+gYVgI0RMQ5OLzZq3UEeTCAP7/QMN15Xm
	J1xKs3d9Gnwr1KotN+gTEUhK+sev5PEHZZne1+NKIFyRoq6IvC124SzJVuJ7cTBdDArawXRw6kC
	Q9HMyknpU1VSDDxFl/sYZ5hKy/OXAET5JWzlm4RuTWuBCrZQgVD1ldDYMfdQBCXgOOceoLLnaKa
	ZVXli6HPNbsBIOJzdyjkSxYYYk+l/QYRh5hkF/7c
X-Google-Smtp-Source: AGHT+IEsRPQfhf68qwI/e0t1PcyQw2KdkLOvL31cD+z9wywFtkYSK/O4aDBvOrM1ZWWO3gLUWlyuVw==
X-Received: by 2002:ac2:5586:0:b0:542:23c9:43ad with SMTP id 2adb3069b0e04-5439c282b4fmr6011091e87.34.1737482911685;
        Tue, 21 Jan 2025 10:08:31 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af79e2esm1923978e87.256.2025.01.21.10.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 10:08:30 -0800 (PST)
Message-ID: <6b4eb75e-ba77-442b-9384-948bb0f70dfa@gmail.com>
Date: Tue, 21 Jan 2025 20:08:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, daniel@sedlak.dev,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
 <20250121084756.1051758-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjjS5CP724bgU5HoRFjaS_by_U3gQMY1mQ1sRbRRw676g@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgjjS5CP724bgU5HoRFjaS_by_U3gQMY1mQ1sRbRRw676g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/01/2025 12:08, Alice Ryhl wrote:
> On Tue, Jan 21, 2025 at 9:48 AM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> 
> Overall looks reasonable but some comments below.
> 
>>   rust/bindings/bindings_helper.h |   1 +
>>   rust/kernel/dma.rs              | 272 ++++++++++++++++++++++++++++++++
>>   rust/kernel/lib.rs              |   1 +
>>   3 files changed, 274 insertions(+)
>>   create mode 100644 rust/kernel/dma.rs
>>
>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>> index 5c4dfe22f41a..49bf713b9bb6 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/blk_types.h>
>>   #include <linux/blkdev.h>
>>   #include <linux/cred.h>
>> +#include <linux/dma-mapping.h>
>>   #include <linux/errname.h>
>>   #include <linux/ethtool.h>
>>   #include <linux/file.h>
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> new file mode 100644
>> index 000000000000..66d1bed887d3
>> --- /dev/null
>> +++ b/rust/kernel/dma.rs
>> @@ -0,0 +1,272 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Direct memory access (DMA).
>> +//!
>> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
>> +
>> +use crate::{
>> +    bindings, build_assert,
>> +    device::Device,
>> +    error::code::*,
>> +    error::Result,
>> +    transmute::{AsBytes, FromBytes},
>> +    types::ARef,
>> +};
>> +
>> +/// Possible attributes associated with a DMA mapping.
>> +///
>> +/// They can be combined with the operators `|`, `&`, and `!`.
>> +///
>> +/// Values can be used from the [`attrs`] module.
>> +#[derive(Clone, Copy, PartialEq)]
>> +#[repr(transparent)]
>> +pub struct Attrs(u32);
>> +
>> +impl Attrs {
>> +    /// Get the raw representation of this attribute.
>> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
>> +        self.0 as _
>> +    }
>> +
>> +    /// Check whether `flags` is contained in `self`.
>> +    pub fn contains(self, flags: Attrs) -> bool {
>> +        (self & flags) == flags
>> +    }
>> +}
>> +
>> +impl core::ops::BitOr for Attrs {
>> +    type Output = Self;
>> +    fn bitor(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 | rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::BitAnd for Attrs {
>> +    type Output = Self;
>> +    fn bitand(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 & rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::Not for Attrs {
>> +    type Output = Self;
>> +    fn not(self) -> Self::Output {
>> +        Self(!self.0)
>> +    }
>> +}
>> +
>> +/// DMA mapping attrributes.
>> +pub mod attrs {
>> +    use super::Attrs;
>> +
>> +    /// Specifies that reads and writes to the mapping may be weakly ordered, that is that reads
>> +    /// and writes may pass each other.
>> +    pub const DMA_ATTR_WEAK_ORDERING: Attrs = Attrs(bindings::DMA_ATTR_WEAK_ORDERING);
>> +
>> +    /// Specifies that writes to the mapping may be buffered to improve performance.
>> +    pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
>> +
>> +    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
>> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
>> +
>> +    /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
>> +    /// that it has been already transferred to 'device' domain.
>> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
>> +
>> +    /// Forces contiguous allocation of the buffer in physical memory.
>> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
>> +
>> +    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
>> +    /// to allocate memory to in a way that gives better TLB efficiency.
>> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
>> +
>> +    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
>> +    /// __GFP_NOWARN).
>> +    pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
>> +
>> +    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
>> +    /// ideally inaccessible or at least read-only at lesser-privileged levels).
>> +    pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
>> +}
>> +
>> +/// An abstraction of the `dma_alloc_coherent` API.
>> +///
>> +/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
>> +/// large consistent DMA regions.
>> +///
>> +/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
>> +/// processor's virtual address space) and the device address which can be given to the device
>> +/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
>> +/// is dropped.
>> +///
>> +/// # Invariants
>> +///
>> +/// For the lifetime of an instance of [`CoherentAllocation`], the cpu address is a valid pointer
>> +/// to an allocated region of consistent memory and we hold a reference to the device.
>> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
>> +    dev: ARef<Device>,
>> +    dma_handle: bindings::dma_addr_t,
>> +    count: usize,
>> +    cpu_addr: *mut T,
>> +    dma_attrs: Attrs,
>> +}
>> +
>> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
>> +    /// Allocates a region of `size_of::<T> * count` of consistent memory.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::device::Device;
>> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
>> +    ///
>> +    /// # fn test(dev: &Device) -> Result {
>> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL,
>> +    ///                                                                  DMA_ATTR_NO_WARN)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn alloc_attrs(
>> +        dev: &Device,
> 
> Instead of incrementing the refcount inside this call, I would
> probably just take an ARef<Device> as argument.
> 
>> +        count: usize,
>> +        gfp_flags: kernel::alloc::Flags,
>> +        dma_attrs: Attrs,
>> +    ) -> Result<CoherentAllocation<T>> {
>> +        build_assert!(
>> +            core::mem::size_of::<T>() > 0,
>> +            "It doesn't make sense for the allocated type to be a ZST"
>> +        );
>> +
>> +        let size = count
>> +            .checked_mul(core::mem::size_of::<T>())
>> +            .ok_or(EOVERFLOW)?;
>> +        let mut dma_handle = 0;
>> +        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
>> +        // We ensure that we catch the failure on this function and throw an ENOMEM
>> +        let ret = unsafe {
>> +            bindings::dma_alloc_attrs(
>> +                dev.as_raw(),
>> +                size,
>> +                &mut dma_handle,
>> +                gfp_flags.as_raw(),
>> +                dma_attrs.as_raw(),
>> +            )
>> +        };
>> +        if ret.is_null() {
>> +            return Err(ENOMEM);
>> +        }
>> +        // INVARIANT: We just successfully allocated a coherent region which is accessible for
>> +        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
>> +        // to the device.
>> +        Ok(Self {
>> +            dev: dev.into(),
>> +            dma_handle,
>> +            count,
>> +            cpu_addr: ret as *mut T,
>> +            dma_attrs,
>> +        })
>> +    }
>> +
>> +    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
>> +    pub fn alloc_coherent(
>> +        dev: &Device,
>> +        count: usize,
>> +        gfp_flags: kernel::alloc::Flags,
>> +    ) -> Result<CoherentAllocation<T>> {
>> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
>> +    }
>> +
>> +    /// Returns the base address, dma handle, attributes and the size of the allocated region.
>> +    /// The caller takes ownership of the returned resources, i.e., will have the responsibility
>> +    /// in calling `bindings::dma_free_attrs`.
> 
> I would add a newline between line 1 and 2 here. That will render
> better in the generated html docs.
> 
> Also, is it the case that the allocated region is only valid while the
> device exists? If so, the comment should explain that.
> 
>> +    pub fn into_parts(self) -> (*mut T, bindings::dma_addr_t, crate::ffi::c_ulong, usize) {
>> +        let size = self.count * core::mem::size_of::<T>();
>> +        let ret = (
>> +            self.cpu_addr,
>> +            self.dma_handle,
>> +            self.dma_attrs.as_raw(),
>> +            size,
>> +        );
>> +        // Drop the device's reference count associated with this object. This is needed as no
>> +        // destructor will be called on this object once this function returns.
>> +        // SAFETY: the device pointer is still valid as of this point due to the type invariants
>> +        // on `CoherentAllocation`.
>> +        unsafe { bindings::put_device(self.dev.as_raw()) }
> 
> Instead of dropping the refcount, you could return an ARef<Device> to
> let the user do with it as they please.

Good catch! Indeed having the caller have the reference to the device 
would enforce the 1:1 mapping of the device that is used in the region.

Thanks,
Abdiel

> 
>> +        core::mem::forget(self);
>> +        ret
>> +    }
>> +
>> +    /// Returns the base address to the allocated region in the CPU's virtual address space.
>> +    pub fn start_ptr(&self) -> *const T {
>> +        self.cpu_addr
>> +    }
>> +
>> +    /// Returns the base address to the allocated region in the CPU's virtual address space as
>> +    /// a mutable pointer.
>> +    pub fn start_ptr_mut(&mut self) -> *mut T {
>> +        self.cpu_addr
>> +    }
>> +
>> +    /// Returns a DMA handle which may given to the device as the DMA address base of
>> +    /// the region.
>> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
>> +        self.dma_handle
>> +    }
>> +
>> +    /// Reads data from the region starting from `offset` as a slice.
>> +    /// `offset` and `count` are in units of `T`, not the number of bytes.
>> +    ///
>> +    /// Due to the safety requirements of slice, the data returned should be regarded by the
>> +    /// caller as a snapshot of the region when this function is called, as the region could
>> +    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
>> +    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
>> +    /// could be used instead.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that no hardware operations that involve the buffer are currently
>> +    /// taking place while the returned slice is live.
>> +    pub unsafe fn read(&self, offset: usize, count: usize) -> Result<&[T]> {
>> +        if offset + count >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation`,
>> +        // we've just checked that the range and index is within bounds. The immutability of the
>> +        // of data is also guaranteed by the safety requirements of the function.
>> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.wrapping_add(offset), count) })
> 
> You can use .add() here instead of .wrapping_add() to give better
> hints to the compiler.
> 
>> +    }
>> +
>> +    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
>> +    /// number of bytes.
>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
>> +        if offset + src.len() >= self.count {
>> +            return Err(EINVAL);
>> +        }
>> +        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation`
>> +        // and we've just checked that the range and index is within bounds.
>> +        unsafe {
>> +            core::ptr::copy_nonoverlapping(
>> +                src.as_ptr(),
>> +                self.cpu_addr.wrapping_add(offset),
> 
> Same here.
> 
>> +                src.len(),
>> +            )
>> +        };
>> +        Ok(())
>> +    }
>> +}
>> +
>> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
>> +    fn drop(&mut self) {
>> +        let size = self.count * core::mem::size_of::<T>();
>> +        // SAFETY: the device, cpu address, and the dma handle is valid due to the
>> +        // type invariants on `CoherentAllocation`.
>> +        unsafe {
>> +            bindings::dma_free_attrs(
>> +                self.dev.as_raw(),
>> +                size,
>> +                self.cpu_addr as _,
>> +                self.dma_handle,
>> +                self.dma_attrs.as_raw(),
>> +            )
>> +        }
>> +    }
>> +}
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 545d1170ee63..36ac88fd91e7 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -37,6 +37,7 @@
>>   pub mod build_assert;
>>   pub mod cred;
>>   pub mod device;
>> +pub mod dma;
>>   pub mod error;
>>   #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>>   pub mod firmware;
>> --
>> 2.43.0
>>

