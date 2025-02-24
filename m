Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC438155CB3
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427664; cv=none; b=GzIp8CmzCgdaAtjObZDN6era+VMqK3o8NneX2KY3CxMNT13UIaCJPRMcE/gBIyu7J40Fx0i1O+yROUiO9Qt6mHSvIWHqlxWpW1MTybrwDkKHuqkZfJHZdP1kBqwcAETilpCJYE0qV1XbEFiKEsadWd1EqE7LRR8A9CS9ocQHl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427664; c=relaxed/simple;
	bh=W8agWAkJQ4qEb5Xf2v/wl5q2ztC1L8qG1DX0SUA/Btg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a16qnUD/4jbFsgvqBa2h4UXTuS8263YUpFks6PjhmI82pNwrzbXNMyV4XRZOEnCWmM+zaONbuGb15O/ViU5CnUT38fl365GRAHIK5EBuLvg3WV4OuTbgLZEJKRbDCRLFFNy5sWt5TdvZn6DqcfsS199ejU9xl/AsulJF0wVGakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H0GsfNZs; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H0GsfNZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=u6kbzhtirbdbbg3x3eyamfopf4.protonmail; t=1740427658; x=1740686858;
	bh=uzx5RvJMG+CQZ8DlJ8ILttk6XusJHkh1+t3Z0yjVKq0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=H0GsfNZskjN8tWkMniVwZsAmxPxiWUydALjT+/1nNciNQjUMxduIbZARuECeITUUz
	 ja5NVPdx0WfsGCfmF0mUK7PfRXonAWA3H+gMsrGOQkOMCSbSOnzPp+o5rN/GoTB1rg
	 4NU/JQ0amZRrv8KqJ9GiaeToiLwpkU7KpyUbYKZyW03m/FVPt+5Hjab3+lzSLnJns+
	 Xw9C8pnA1ePzdPFbBqS1XdP93tsPz4ycv+9O7cEB5sxfyOms/bcPPS4cSEDZ1Dj4LM
	 o79mho0YBqZURCmjwu2rcZt6M9n6EogcE2J9YPW6zbwu7woXV9i1r14QMKrstWfCiI
	 BKBHoaNASrnXg==
Date: Mon, 24 Feb 2025 20:07:35 +0000
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, iommu@lists.linux.dev
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com> <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 262f217c8de342379e0359f3eeba308328676db0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.02.25 12:49, Abdiel Janulgue wrote:
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>=20
> Nacked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/dma.c              |  13 +
>  rust/helpers/helpers.c          |   1 +
>  rust/kernel/dma.rs              | 421 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  5 files changed, 437 insertions(+)
>  create mode 100644 rust/helpers/dma.c
>  create mode 100644 rust/kernel/dma.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 55354e4dec14..f69b05025e52 100644
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
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> new file mode 100644
> index 000000000000..30da079d366c
> --- /dev/null
> +++ b/rust/helpers/dma.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-mapping.h>
> +
> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
> +{
> +=09return dma_set_mask_and_coherent(dev, mask);
> +}
> +
> +int rust_helper_dma_set_mask(struct device *dev, u64 mask)
> +{
> +=09return dma_set_mask(dev, mask);
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
> +/// Inform the kernel about the device's DMA addressing capabilities. Th=
is will set the mask for
> +/// both streaming and coherent APIs together.
> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `De=
vice`.
> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
> +}
> +
> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for strea=
ming mappings.
> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `De=
vice`.
> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
> +}

Why aren't these methods on `Device`? (i.e. inside of an `impl Device`
block)

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

"the cpu address" -> "`cpu_addr`"

You can shorten this to "`cpu_addr` is a valid pointer to [...]".

> +/// to an allocated region of consistent memory and we hold a reference =
to the device.

Isn't the "we hold a reference to the device" part ensured by the
`ARef<Device>`? Or did you want to specify that `cpu_addr` must come
from `dev`?

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
rs(dev.into(), 4, GFP_KERNEL,
> +    ///                                                                 =
 DMA_ATTR_NO_WARN)?;
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

Is this a safety requirement? I.e. the `dma_alloc_attrs` function cannot
handle a size of 0?

> +
> +        let size =3D count
> +            .checked_mul(core::mem::size_of::<T>())
> +            .ok_or(EOVERFLOW)?;
> +        let mut dma_handle =3D 0;
> +        // SAFETY: device pointer is guaranteed as valid by invariant on=
 `Device`.
> +        // We ensure that we catch the failure on this function and thro=
w an ENOMEM

The second sentence is not part of a safety requirement.

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
> +            dev,
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
> +        dev: ARef<Device>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +    ) -> Result<CoherentAllocation<T>> {
> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
> +    }
> +
> +    /// Create a duplicate of the `CoherentAllocation` object but preven=
t it from being dropped.
> +    pub fn skip_drop(self) -> CoherentAllocation<T> {

Why does this method exist? It doesn't do anything.

> +        let me =3D core::mem::ManuallyDrop::new(self);
> +        Self {
> +            // SAFETY: The refcount of `dev` will not be decremented bec=
ause this doesn't actually
> +            // duplicafe `ARef` and the use of `ManuallyDrop` forgets th=
e originals.
> +            dev: unsafe { core::ptr::read(&me.dev) },
> +            dma_handle: me.dma_handle,
> +            count: me.count,
> +            cpu_addr: me.cpu_addr,
> +            dma_attrs: me.dma_attrs,
> +        }
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
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// Due to the safety requirements of slice, the caller should consi=
der that the region could
> +    /// be modified by the device at anytime (see the safety block below=
). For ringbuffer type of

What is a safety block?

> +    /// r/w access or use-cases where the pointer to the live data is ne=
eded, `start_ptr()` or
> +    /// `start_ptr_mut()` could be used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that no hardware operations that involve the=
 buffer are currently
> +    /// taking place while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset=
), count) })
> +    }
> +
> +    /// Performs the same functionality as `as_slice`, except that a mut=
able slice is returned.
> +    /// See that method for documentation and safety requirements.

I don't think this is good documentation style. I think copy-pasting the
first line and second paragraph is better.

> +    ///
> +    /// # Safety
> +    ///
> +    /// It is the callers responsibility to avoid separate read and writ=
e accesses to the region
> +    /// while the returned slice is live.

This safety requirement is worded quite differently compared to the one
on `as_slice`, why?

> +    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Re=
sult<&mut [T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(of=
fset), count) })
> +    }
> +
> +    /// Writes data to the region starting from `offset`. `offset` is in=
 units of `T`, not the
> +    /// number of bytes.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Re=
sult {
> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> +    /// let buf: &[u8] =3D &somedata;
> +    /// alloc.write(buf, 0)?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> +        // and we've just checked that the range and index is within bou=
nds.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        unsafe {
> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.a=
dd(offset), src.len())

Why are there no concurrent write or read operations on `cpu_addr`?

> +        };
> +        Ok(())
> +    }
> +
> +    /// Retrieve a single entry from the region with bounds checking. `o=
ffset` is in units of `T`,
> +    /// not the number of bytes.

Please add some information on the returned raw pointer, ie when it can
be accessed.

> +    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
> +        if offset >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> +        // and we've just checked that the range and index is within bou=
nds.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { &mut *self.cpu_addr.add(offset) })

Why do you take `&mut` here? The return type is a `*mut T`.

> +    }
> +
> +    /// Reads the value of `field` and ensures that its type is `FromByt=
es`
> +    ///
> +    /// # Safety:
> +    ///
> +    /// This must be called from the `dma_read` macro which ensures that=
 the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from `dma_read` m=
acro.
> +    #[doc(hidden)]
> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F =
{
> +        // SAFETY: By the safety requirements field is valid
> +        unsafe { field.read() }
> +    }
> +
> +    /// Writes a value to `field` and ensures that its type is `AsBytes`
> +    ///
> +    /// # Safety:
> +    ///
> +    /// This must be called from the `dma_write` macro which ensures tha=
t the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from `dma_write` =
macro.
> +    #[doc(hidden)]
> +    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) =
{
> +        // SAFETY: By the safety requirements field is valid
> +        unsafe { field.write(val) }
> +    }
> +}
> +
> +/// Reads a field of an item from an allocated region of structs.
> +/// # Examples
> +///
> +/// ```
> +/// struct MyStruct { field: u32, }
> +/// // SAFETY: All bit patterns are acceptable values for MyStruct.
> +/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
> +/// // SAFETY: Instances of MyStruct have no uninitialized portions.
> +/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
> +///
> +/// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Resu=
lt {
> +/// let whole =3D kernel::dma_read!(alloc[2]);
> +/// let field =3D kernel::dma_read!(alloc[1].field);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +macro_rules! dma_read {
> +    ($dma:ident [ $idx:expr ] $($field:tt)* ) =3D> {{
> +        let item =3D $dma.item_from_index($idx)?;

Please replace this line with:

    let item =3D $crate::dma::CoherentAllocation::item_from_index(&$dma, $i=
dx)?;

This ensures that you're actually calling the `item_from_index` function
of the `CoherentAllocation` type and not some other user-defined type.
(this is very important for the `unsafe` block and safety comment
below!)

> +        // SAFETY: `item_from_index` ensures that `item` is always a val=
id pointer and can be
> +        // dereferenced. The compiler also further validates the express=
ion on whether `field`
> +        // is a member of `item` when expanded by the macro.
> +        unsafe {
> +            let ptr_field =3D ::core::ptr::addr_of!((*item) $($field)*);
> +            $dma.field_read(ptr_field)

$crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)

> +        }
> +    }};
> +}
> +
> +/// Writes to a field of an item from an allocated region of structs.
> +/// # Examples
> +///
> +/// ```
> +/// struct MyStruct { member: u32, }
> +/// // SAFETY: All bit patterns are acceptable values for MyStruct.
> +/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
> +/// // SAFETY: Instances of MyStruct have no uninitialized portions.
> +/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
> +///
> +/// # fn test(alloc: &mut kernel::dma::CoherentAllocation<MyStruct>) -> =
Result {
> +/// kernel::dma_write!(alloc[2].member =3D 0xf);
> +/// kernel::dma_write!(alloc[1] =3D MyStruct { member: 0xf });
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +macro_rules! dma_write {
> +    ($dma:ident [ $idx:expr ] $($field:tt)*) =3D> {{
> +        kernel::dma_write!($dma, $idx, $($field)*);

Please use `$crate::` instead of `kernel::`.

> +    }};
> +    ($dma:ident, $idx: expr, =3D $val:expr) =3D> {
> +        let item =3D $dma.item_from_index($idx)?;

Same here as with `dma_read`.

> +        // SAFETY: `item_from_index` ensures that `item` is always a val=
id item.
> +        unsafe { $dma.field_write(item, $val) }

Again (and below).

> +    };
> +    ($dma:ident, $idx: expr, $(.$field:ident)* =3D $val:expr) =3D> {
> +        let item =3D $dma.item_from_index($idx)?;
> +        // SAFETY: `item_from_index` ensures that `item` is always a val=
id pointer and can be
> +        // dereferenced. The compiler also further validates the express=
ion on whether `field`
> +        // is a member of `item` when expanded by the macro.
> +        unsafe {
> +            let ptr_field =3D ::core::ptr::addr_of_mut!((*item) $(.$fiel=
d)*);
> +            $dma.field_write(ptr_field, $val)
> +        }
> +    };
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

Can you move this drop impl directly below the struct definition?

---
Cheers,
Benno

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0911..5081cb66b2f9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,6 +44,7 @@
>  pub mod device;
>  pub mod device_id;
>  pub mod devres;
> +pub mod dma;
>  pub mod driver;
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> --
> 2.43.0
>=20

