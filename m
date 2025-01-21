Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C01E766E
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737454133; cv=none; b=qkPxivXQh94L6gIMqyd2fN7Ycjb/Pqo4r1lu26Zv0f+dL67bQNH3bf2X6wuQVXPmj9SCXqZzSRZGq0CiGNiLFFjwOOjx1hBiukhrLHW6Qb29XMRzLolrNM2nVZLC6jC9ygYO1Gj6zPjmqOOveA9iqtKLAWxnxa231TktvUOWauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737454133; c=relaxed/simple;
	bh=RgROe1uTkRvlRV+DYmWfsEa0vpNlU4PD34hng6WZyh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ce/D15B2tmP6neAAq8nX4l0oReugnyyur2jW6Uu40wpUt2ci8Jr7fmY9tzeLbqXCh3Xznv3BrdT7O08xR1Hus0h4lOTT4oim18z5m/q0d6ngmBJAFev6MHapuIBeI+WHyhIqAgula6HHYckO52ytSDPf7ZfvpeFZeJ0oILY28qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3uxyzYZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3uxyzYZ"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-304d757a9c1so53534991fa.0
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737454129; x=1738058929; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxATdoBboMl8YHvsPZQ4+QCK2SQ+GJUEg6s0+E/IMHY=;
        b=R3uxyzYZMuDfnklH+vKllOM8tI+sA/wOBLaz1fNXC8o7ysJ+v/chtV4LhNC1WVoZvU
         hocjzNa4UXkjTBFPodKmKxabSRsbk7yB+veWV4xTyC2RoIwBaKGsnN5UK8j72AnhlJX8
         +QlDJ5Oq71JRh/cTe/faaNsf3TKrDH8trngryqdf3XMXC94z/5bwBDWm1o+y7aex0pS9
         EQntARqPJVk1EUgGlukPjl+k1awwGvdcIMh8yZpgGeci7qZKQukkZC0SayoM7J317Hbu
         L+B7g0y6Uq1qh4zYDZzdXeGUn7Pi7npu5Pv5gyf1Ck7RG7a+TzgY4jp9Y5iBgNVkBoqo
         PrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737454129; x=1738058929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxATdoBboMl8YHvsPZQ4+QCK2SQ+GJUEg6s0+E/IMHY=;
        b=j2duKlz9NvQLw+49Tkeyi0B5eXNg6JeFiG0lqqEj1iZ2d9SLwuH4hVnEWRTMLEfJ2G
         TYjuoiMOYZ+cJjKWJalmitHitx2MwH/qOIHNHkChJvq/4ASQ6pBswhnuiP8fjTebJUux
         YubuZMaKi9E0xyess3sP5vJ0T5jzF8whBbtBisvNbpXwPKUqs0uihiI4ObNGteviSisb
         UmEgheqkGNoUVny6osFX5RGWuQm7AZrZbbXkFeeX396Q1NXN4lDX1jbft2G3qrM2N1WU
         nE/EeXRu89z1ROGf4a9GeshKGK9h0f78XyGWeHstN+MrIDODSuWa4vBip0FYw1Xb3obs
         Q2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCULb8YlQUYJlVDR1L4LmjdqwpSOEA5dMSOyh16UlEKC62OVF0HR5QpSalmElvDFck02atSJNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4dMwU/qJ6vpJgj/2pJh3TC2r6c/C5QZEXuEwUtQoLvtr6FmK5
	hv4E04XfHyaRwFif43/frWCtNjepje2qE9JG3uSlKOpkWRdyGOxPKsxJbWRyrf8LXkpFwT12XB6
	8c8gFMyslvuRcB5FXh+0l3rzPojbtb4tHnuh4FfqT9eZfprmSmQ==
X-Gm-Gg: ASbGncvmdJiPqpiWcB1LKLV0Pwi8xxoujMUOlsPW7DcVdGTRIB1cMKpsXTwyYA0YFsp
	tf3KQtuQyleWI7aLt6DP/ljVoJzxmG/E5EOEX2JlvN73KSzuQfGWDMllyvMmJxBQjfijIicTabc
	2TYaVEXQ==
X-Google-Smtp-Source: AGHT+IGHo0ASfN45RlGW1XS2NPq4qfoX7WwEeBfZrH5MLkWb5LtVP2ZVRUvvpg+Oq92vq9nYK7rMBzai3r9zu04BgmU=
X-Received: by 2002:a05:600c:35cf:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-438918c6162mr125898835e9.6.1737454110230; Tue, 21 Jan 2025
 02:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com> <20250121084756.1051758-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250121084756.1051758-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 21 Jan 2025 11:08:18 +0100
X-Gm-Features: AbW1kva1NVZ-RHQbUzMEuvm2mGRrHbaGxmEeGHMYIfYJvWCJDpvp5lz1jk6dhqg
Message-ID: <CAH5fLgjjS5CP724bgU5HoRFjaS_by_U3gQMY1mQ1sRbRRw676g@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	dakr@kernel.org, robin.murphy@arm.com, daniel@sedlak.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 9:48=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Overall looks reasonable but some comments below.

>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/dma.rs              | 272 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  3 files changed, 274 insertions(+)
>  create mode 100644 rust/kernel/dma.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 5c4dfe22f41a..49bf713b9bb6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
>  #include <linux/cred.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/errname.h>
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> new file mode 100644
> index 000000000000..66d1bed887d3
> --- /dev/null
> +++ b/rust/kernel/dma.rs
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Direct memory access (DMA).
> +//!
> +//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-=
mapping.h)
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
> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`attrs`] module.
> +#[derive(Clone, Copy, PartialEq)]
> +#[repr(transparent)]
> +pub struct Attrs(u32);
> +
> +impl Attrs {
> +    /// Get the raw representation of this attribute.
> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> +        self.0 as _
> +    }
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Attrs) -> bool {
> +        (self & flags) =3D=3D flags
> +    }
> +}
> +
> +impl core::ops::BitOr for Attrs {
> +    type Output =3D Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Attrs {
> +    type Output =3D Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Attrs {
> +    type Output =3D Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// DMA mapping attrributes.
> +pub mod attrs {
> +    use super::Attrs;
> +
> +    /// Specifies that reads and writes to the mapping may be weakly ord=
ered, that is that reads
> +    /// and writes may pass each other.
> +    pub const DMA_ATTR_WEAK_ORDERING: Attrs =3D Attrs(bindings::DMA_ATTR=
_WEAK_ORDERING);
> +
> +    /// Specifies that writes to the mapping may be buffered to improve =
performance.
> +    pub const DMA_ATTR_WRITE_COMBINE: Attrs =3D Attrs(bindings::DMA_ATTR=
_WRITE_COMBINE);
> +
> +    /// Lets the platform to avoid creating a kernel virtual mapping for=
 the allocated buffer.
> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs =3D Attrs(bindings::DMA_=
ATTR_NO_KERNEL_MAPPING);
> +
> +    /// Allows platform code to skip synchronization of the CPU cache fo=
r the given buffer assuming
> +    /// that it has been already transferred to 'device' domain.
> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs =3D Attrs(bindings::DMA_ATTR=
_SKIP_CPU_SYNC);
> +
> +    /// Forces contiguous allocation of the buffer in physical memory.
> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs =3D Attrs(bindings::DMA_A=
TTR_FORCE_CONTIGUOUS);
> +
> +    /// This is a hint to the DMA-mapping subsystem that it's probably n=
ot worth the time to try
> +    /// to allocate memory to in a way that gives better TLB efficiency.
> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs =3D Attrs(bindings::DMA=
_ATTR_ALLOC_SINGLE_PAGES);
> +
> +    /// This tells the DMA-mapping subsystem to suppress allocation fail=
ure reports (similarly to
> +    /// __GFP_NOWARN).
> +    pub const DMA_ATTR_NO_WARN: Attrs =3D Attrs(bindings::DMA_ATTR_NO_WA=
RN);
> +
> +    /// Used to indicate that the buffer is fully accessible at an eleva=
ted privilege level (and
> +    /// ideally inaccessible or at least read-only at lesser-privileged =
levels).
> +    pub const DMA_ATTR_PRIVILEGED: Attrs =3D Attrs(bindings::DMA_ATTR_PR=
IVILEGED);
> +}
> +
> +/// An abstraction of the `dma_alloc_coherent` API.
> +///
> +/// This is an abstraction around the `dma_alloc_coherent` API which is =
used to allocate and map
> +/// large consistent DMA regions.
> +///
> +/// A [`CoherentAllocation`] instance contains a pointer to the allocate=
d region (in the
> +/// processor's virtual address space) and the device address which can =
be given to the device
> +/// as the DMA address base of the region. The region is released once [=
`CoherentAllocation`]
> +/// is dropped.
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of [`CoherentAllocation`], the cpu a=
ddress is a valid pointer
> +/// to an allocated region of consistent memory and we hold a reference =
to the device.
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attrs,
> +}
> +
> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
> +    /// Allocates a region of `size_of::<T> * count` of consistent memor=
y.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::device::Device;
> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
> +    ///
> +    /// # fn test(dev: &Device) -> Result {
> +    /// let c: CoherentAllocation<u64> =3D CoherentAllocation::alloc_att=
rs(dev, 4, GFP_KERNEL,
> +    ///                                                                 =
 DMA_ATTR_NO_WARN)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn alloc_attrs(
> +        dev: &Device,

Instead of incrementing the refcount inside this call, I would
probably just take an ARef<Device> as argument.

> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +    ) -> Result<CoherentAllocation<T>> {
> +        build_assert!(
> +            core::mem::size_of::<T>() > 0,
> +            "It doesn't make sense for the allocated type to be a ZST"
> +        );
> +
> +        let size =3D count
> +            .checked_mul(core::mem::size_of::<T>())
> +            .ok_or(EOVERFLOW)?;
> +        let mut dma_handle =3D 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on=
 `Device`.
> +        // We ensure that we catch the failure on this function and thro=
w an ENOMEM
> +        let ret =3D unsafe {
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
> +        // INVARIANT: We just successfully allocated a coherent region w=
hich is accessible for
> +        // `count` elements, hence the cpu address is valid. We also hol=
d a refcounted reference
> +        // to the device.
> +        Ok(Self {
> +            dev: dev.into(),
> +            dma_handle,
> +            count,
> +            cpu_addr: ret as *mut T,
> +            dma_attrs,
> +        })
> +    }
> +
> +    /// Performs the same functionality as `alloc_attrs`, except the `dm=
a_attrs` is 0 by default.
> +    pub fn alloc_coherent(
> +        dev: &Device,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +    ) -> Result<CoherentAllocation<T>> {
> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
> +    }
> +
> +    /// Returns the base address, dma handle, attributes and the size of=
 the allocated region.
> +    /// The caller takes ownership of the returned resources, i.e., will=
 have the responsibility
> +    /// in calling `bindings::dma_free_attrs`.

I would add a newline between line 1 and 2 here. That will render
better in the generated html docs.

Also, is it the case that the allocated region is only valid while the
device exists? If so, the comment should explain that.

> +    pub fn into_parts(self) -> (*mut T, bindings::dma_addr_t, crate::ffi=
::c_ulong, usize) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +        let ret =3D (
> +            self.cpu_addr,
> +            self.dma_handle,
> +            self.dma_attrs.as_raw(),
> +            size,
> +        );
> +        // Drop the device's reference count associated with this object=
. This is needed as no
> +        // destructor will be called on this object once this function r=
eturns.
> +        // SAFETY: the device pointer is still valid as of this point du=
e to the type invariants
> +        // on `CoherentAllocation`.
> +        unsafe { bindings::put_device(self.dev.as_raw()) }

Instead of dropping the refcount, you could return an ARef<Device> to
let the user do with it as they please.

> +        core::mem::forget(self);
> +        ret
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's vi=
rtual address space.
> +    pub fn start_ptr(&self) -> *const T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns the base address to the allocated region in the CPU's vi=
rtual address space as
> +    /// a mutable pointer.
> +    pub fn start_ptr_mut(&mut self) -> *mut T {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may given to the device as the DMA ad=
dress base of
> +    /// the region.
> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
> +        self.dma_handle
> +    }
> +
> +    /// Reads data from the region starting from `offset` as a slice.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// Due to the safety requirements of slice, the data returned shoul=
d be regarded by the
> +    /// caller as a snapshot of the region when this function is called,=
 as the region could
> +    /// be modified by the device at anytime. For ringbuffer type of r/w=
 access or use-cases
> +    /// where the pointer to the live data is needed, `start_ptr()` or `=
start_ptr_mut()`
> +    /// could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that no hardware operations that involve the=
 buffer are currently
> +    /// taking place while the returned slice is live.
> +    pub unsafe fn read(&self, offset: usize, count: usize) -> Result<&[T=
]> {
> +        if offset + count >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: The pointer is valid due to type invariant on `Cohere=
ntAllocation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.wrapping_a=
dd(offset), count) })

You can use .add() here instead of .wrapping_add() to give better
hints to the compiler.

> +    }
> +
> +    /// Writes data to the region starting from `offset`. `offset` is in=
 units of `T`, not the
> +    /// number of bytes.
> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> +        if offset + src.len() >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: The pointer is valid due to type invariant on `Cohere=
ntAllocation`
> +        // and we've just checked that the range and index is within bou=
nds.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(
> +                src.as_ptr(),
> +                self.cpu_addr.wrapping_add(offset),

Same here.

> +                src.len(),
> +            )
> +        };
> +        Ok(())
> +    }
> +}
> +
> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
> +    fn drop(&mut self) {
> +        let size =3D self.count * core::mem::size_of::<T>();
> +        // SAFETY: the device, cpu address, and the dma handle is valid =
due to the
> +        // type invariants on `CoherentAllocation`.
> +        unsafe {
> +            bindings::dma_free_attrs(
> +                self.dev.as_raw(),
> +                size,
> +                self.cpu_addr as _,
> +                self.dma_handle,
> +                self.dma_attrs.as_raw(),
> +            )
> +        }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 545d1170ee63..36ac88fd91e7 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -37,6 +37,7 @@
>  pub mod build_assert;
>  pub mod cred;
>  pub mod device;
> +pub mod dma;
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;
> --
> 2.43.0
>
