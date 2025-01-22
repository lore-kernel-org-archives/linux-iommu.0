Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D9211269
	for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540851; cv=none; b=k17jKG+HMDCClNN63erIg56klmH60koDdxCROzT50DjFd5bfIaEVLmA8UXzP2uJr0XfQNzg+A+jv+3wn5N57+QsXQppF2IG+Ag9UCAxHH2kE95g+I4Kjx4G8cuaScBnl+R4Mncc9BtEBIR0Hyz4n9iPI/NoDQDNi+S0uurPQIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540851; c=relaxed/simple;
	bh=Hg+YhmRs1maSVmNSvczvl0dufRpcjqvvqj9c8nDtU3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smYN0DkmEAs29lk1FUKs5FuKkMy5HdFNhto53pYyNc/BK/dZMcxH1fVVdaM03n/IEl9FKbvUe2LHehN3SQlU/4nVSbXBm7DchXBMmhkYtR1LOW1B3LouDHS6RLeSPJOydvNEYOFFQ6Rv4zQd8pIG3pCIcYp6HMbpYGQD3+LqR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFBbOe8R; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFBbOe8R"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54024aa9febso6849987e87.1
        for <iommu@lists.linux.dev>; Wed, 22 Jan 2025 02:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737540847; x=1738145647; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSyxU0Ox9hnNgLjin1l5eGRDHXbLU274FDlPyNJKLZQ=;
        b=jFBbOe8RL1MfWPKNS1UX7n8TiX+lIFIG2pts73Nt811cRWq9luEwKWqV8MaQx+RDjR
         sWqz1glVWs7KclOOwZsxTKXcIh5LC61Za2CUa7ND8aFHzRAjnYP/9gCDTG0EYJkFXmkR
         1YRJdcvZSkdhISof74tINfRJ0kPcpLJvDC+sjVAJHkPD+kM3WxAWUVzsfC18mufqp/da
         bWacvqNoXy3ywYaspBMYfLfUP8Pkxj/fHBlQPped5tn0+oetaqYVUnXGp2F/+avv6G2w
         SFjjoSuC1eRpA/NBl/XdcD6PLaety/DR/rHLflPFX9TpPqQUY0BfMA8U1FJKHyE+MzyM
         nprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737540847; x=1738145647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSyxU0Ox9hnNgLjin1l5eGRDHXbLU274FDlPyNJKLZQ=;
        b=kusUWBsP6a120FsxRTmqLbdScOhTDK/5G5o5rA7cQ3pfMIkrgpXNDREJMxYmQ2KoQn
         bsz2zokC23Ezz1tY0zcvdf8libYpwiSb9imgFF7PiVYsGop8gDZtt0W+2arn0oXtRvjv
         vlYYU3y66yYS5TfwRbvvnj2eTkesd+w+cVgVg6a4OIJaoqJWyXGDS22gjA4bKlwAqrsp
         NhfZNm77lWTcCQBwmSKJ5aLNG501rNhxgeuC8iCrC/GjwphCxrXnHSHFSq07VNYOKeSw
         gpTSzSVjldC7ACjGsIYhuvT6typLBNKbTV7OmnR3qX0UiQFdyfcisdj0ZDV3/B8V05L8
         D18w==
X-Forwarded-Encrypted: i=1; AJvYcCUrhkKPmxwORJDTF+RVMuS0dLe0UsWt+XuNahn0OokgMSRmwv3mooHfO95SlyEo4NeavzM2RA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxf6mdVjVpuYW/lfHGLwY4sCqtAv4NZeQYd03J3/SinAdWPpfRG
	ExHATQzIAnPa3ssYL9VgSUQy/cEfsd9vdubTqr57x5E7fPkawWcK
X-Gm-Gg: ASbGncsAWXkJ73t7HncvPgiMo02/R5fnDyd4ggZ9CeALGRkilp3E+zWo9kq7smfPvzh
	Y0hwZh3iitz69TXhjgO4WJ/qc0NAiINWTmEGCxWQf+N0db3aImhmh2+dGfwJMSKWwFiM8u++BeZ
	V6q/CRnsiqW2yEfrPyneRGzzBJaLnmJ8Be3SiQBIYN1z+tHN8oY6yJmpRNn4q9Xfg5hsZ+wJr16
	X898qDQc2FzMyvDQGEmGV8eoLX3JEtfNLMgRA3W0HkTSApAAq/q5bLenirJjcNStwsIdo1u2La/
	UiCkxWu1ezyefYAFIN4VuT75Cas9uJ3ahRU5EVmr
X-Google-Smtp-Source: AGHT+IEE5ZJsoglNcCgqLVCj00aN8fxV/PCAVYwQejoowiKy+k6ns3brqVBN1nZVtxJXYCp3Rorfhg==
X-Received: by 2002:ac2:5187:0:b0:540:263a:131f with SMTP id 2adb3069b0e04-5439c287dd1mr5898106e87.50.1737540846692;
        Wed, 22 Jan 2025 02:14:06 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af78d62sm2150860e87.241.2025.01.22.02.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:14:06 -0800 (PST)
Message-ID: <fb2216a4-306b-4635-bc13-10647e7cdb93@gmail.com>
Date: Wed, 22 Jan 2025 12:14:04 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/3] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
 dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
 <20250121191432.1178734-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjVjAVwR+osD4ajKfyewdWPpkSyV+oy=ppaCULUdPqB7w@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgjVjAVwR+osD4ajKfyewdWPpkSyV+oy=ppaCULUdPqB7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/01/2025 11:13, Alice Ryhl wrote:
> On Tue, Jan 21, 2025 at 8:14 PM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>>   rust/bindings/bindings_helper.h |   1 +
>>   rust/kernel/dma.rs              | 281 ++++++++++++++++++++++++++++++++
>>   rust/kernel/lib.rs              |   1 +
>>   3 files changed, 283 insertions(+)
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
>> index 000000000000..ebae7270190e
>> --- /dev/null
>> +++ b/rust/kernel/dma.rs
>> @@ -0,0 +1,281 @@
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
>> +    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev.into(), 4, GFP_KERNEL,
>> +    ///                                                                  DMA_ATTR_NO_WARN)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn alloc_attrs(
>> +        dev: ARef<Device>,
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
>> +            dev,
>> +            dma_handle,
>> +            count,
>> +            cpu_addr: ret as *mut T,
>> +            dma_attrs,
>> +        })
>> +    }
>> +
>> +    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
>> +    pub fn alloc_coherent(
>> +        dev: ARef<Device>,
>> +        count: usize,
>> +        gfp_flags: kernel::alloc::Flags,
>> +    ) -> Result<CoherentAllocation<T>> {
>> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
>> +    }
>> +
>> +    /// Returns the device, base address, dma handle, attributes and the size of the
>> +    /// allocated region.
>> +    ///
>> +    /// The caller takes ownership of the returned resources, i.e., will have the responsibility
>> +    /// in calling `bindings::dma_free_attrs`. The allocated region is valid as long as
>> +    /// the returned device exists.
>> +    pub fn into_parts(
>> +        self,
>> +    ) -> (
>> +        ARef<Device>,
>> +        *mut T,
>> +        bindings::dma_addr_t,
>> +        crate::ffi::c_ulong,
>> +        usize,
>> +    ) {
>> +        let size = self.count * core::mem::size_of::<T>();
>> +        let ret = (
>> +            self.dev.clone(),
> 
> Calling clone here increments the refcount, but you don't want to do
> that since it leaks a count.
> 

You mean return the raw *mut bindings::device instead of ARef<Device>. 
Otherwise the compiler complains not being able to move out ARef<Device> 
because it doesn't implement Copy.

Thanks,
Abdiel


