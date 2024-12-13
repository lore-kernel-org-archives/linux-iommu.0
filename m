Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2C1E00BF
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101257; cv=pass; b=uh261xr3yn+X/qdKl7xku7uYtFfoFCInVBqU8Dg6p0uDOglXAKju1uSuOGh/IZxkOZkoSXBbKjkfCrRyPtj50Kf8ZOtECHXiJKltflR1wDPOrXpsL81S0obQIfpF0yRiCBw2ZdnnNbdngCKfTWnj6i2asvqZe+lSgdgDr0s+xJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101257; c=relaxed/simple;
	bh=oFRP6W2ayKGhSQ1buQYlZLPuoOLoO7M9Ul0OWDwvCv4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bEoTUkaj+ycAdwTZHOtQ3Ty1Khdyo8XYOwgiTIP/zBBK5zp5H61bZFqc3gTniI3vVMi1hYm0SXLZKth7ilECbQlo55dad5SzDOUclGquKCAzaQsMNUCZWs+rTjkQEoEPNa7rvADGrx8S6WaYC7yX5+RfrjnpaQcq9el3EvSLGvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BbRQF4o+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BbRQF4o+"
ARC-Seal: i=1; a=rsa-sha256; t=1734101241; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l3MLVkB6SANiM+0e319HV03xJJ0ywRCX/Lewejehlc5WBu4p/99Ld9XmxZ6NOmgyPQ9QyB/VBKZ/QnZ3HLA0Iog/n0wevZ3rkyuu/lTMvAZ8Evqh7vI01OuwUlzF7gpN7xUFl7f3PrK8zwa0YvpL1VulfSrBVx8x/H4aJFg2Y3E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734101241; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6qVqFJs/to4ewOC7jHzNGVatUt9cqwzXAUAXNA7kl3o=; 
	b=IZWa0aJRUhf5+6P+skeVzwOMB4lCHn2lNcZUhEGZMydq2ZoblYihOEl6adPrGkiiUCfU6KQpEJnnt4gpA8x01litTJGSb6yWHwMcvjuV2Sg88WXtbjJYpF3amrIclTJht5cpjTbu1JiSnG5NqOXmh8SxSdYUKhvgzcvy/l6J0Zw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734101241;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=6qVqFJs/to4ewOC7jHzNGVatUt9cqwzXAUAXNA7kl3o=;
	b=BbRQF4o+JrfT5uP/bod4QrNLalMJmjE8WmBSWBlqHt1i/hQpLVN7WROrJItoNkcb
	tj/2BmXltUqDcW1VVkTy7t43ayVT+6STBrEofcrFWMFY2tJuYO0nKSsUV1fxm5gwuDQ
	Hx461Iz4FIIYOGcaq2LFN/CWghHPTZM/cCpJj+Z4=
Received: by mx.zohomail.com with SMTPS id 1734101239398238.18140512738648;
	Fri, 13 Dec 2024 06:47:19 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
Date: Fri, 13 Dec 2024 11:47:03 -0300
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F719804-2AD3-4C4E-A98C-2862295990BA@collabora.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External



> On 13 Dec 2024, at 11:27, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Tue, Dec 10, 2024 at 11:16=E2=80=AFPM Abdiel Janulgue
> <abdiel.janulgue@gmail.com> wrote:
>>=20
>> Add a simple dma coherent allocator rust abstraction. Based on
>> Andreas Hindborg's dma abstractions from the rnvme driver, which
>> was also based on earlier work by Wedson Almeida Filho.
>>=20
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> ---
>> rust/bindings/bindings_helper.h |   1 +
>> rust/kernel/dma.rs              | 223 =
++++++++++++++++++++++++++++++++
>> rust/kernel/lib.rs              |   1 +
>> 3 files changed, 225 insertions(+)
>> create mode 100644 rust/kernel/dma.rs
>>=20
>> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
>> index 5c4dfe22f41a..49bf713b9bb6 100644
>> --- a/rust/bindings/bindings_helper.h
>> +++ b/rust/bindings/bindings_helper.h
>> @@ -11,6 +11,7 @@
>> #include <linux/blk_types.h>
>> #include <linux/blkdev.h>
>> #include <linux/cred.h>
>> +#include <linux/dma-mapping.h>
>> #include <linux/errname.h>
>> #include <linux/ethtool.h>
>> #include <linux/file.h>
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> new file mode 100644
>> index 000000000000..29ae744d6f2b
>> --- /dev/null
>> +++ b/rust/kernel/dma.rs
>> @@ -0,0 +1,223 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Direct memory access (DMA).
>> +//!
>> +//! C header: =
[`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    build_assert,
>> +    device::Device,
>> +    error::code::*,
>> +    error::Result,
>> +    types::ARef,
>> +    transmute::{AsBytes, FromBytes},
>> +};
>> +
>> +/// Possible attributes associated with a DMA mapping.
>> +///
>> +/// They can be combined with the operators `|`, `&`, and `!`.
>> +///
>> +/// Values can be used from the [`attrs`] module.
>> +#[derive(Clone, Copy, PartialEq)]
>> +pub struct Attribs(u32);
>> +
>> +impl Attribs {
>> +    /// Get the raw representation of this attribute.
>> +    pub(crate) fn as_raw(self) -> u64 {
>> +        self.0.into()
>> +    }
>> +
>> +    /// Check whether `flags` is contained in `self`.
>> +    pub fn contains(self, flags: Attribs) -> bool {
>> +        (self & flags) =3D=3D flags
>> +    }
>> +}
>> +
>> +impl core::ops::BitOr for Attribs {
>> +    type Output =3D Self;
>> +    fn bitor(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 | rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::BitAnd for Attribs {
>> +    type Output =3D Self;
>> +    fn bitand(self, rhs: Self) -> Self::Output {
>> +        Self(self.0 & rhs.0)
>> +    }
>> +}
>> +
>> +impl core::ops::Not for Attribs {
>> +    type Output =3D Self;
>> +    fn not(self) -> Self::Output {
>> +        Self(!self.0)
>> +    }
>> +}
>> +
>> +/// DMA mapping attrributes.
>> +pub mod attrs {
>> +    use super::Attribs;
>> +
>> +    /// Specifies that reads and writes to the mapping may be weakly =
ordered, that is that reads
>> +    /// and writes may pass each other.
>> +    pub const DMA_ATTR_WEAK_ORDERING: Attribs =3D =
Attribs(bindings::DMA_ATTR_WEAK_ORDERING);
>> +
>> +    /// Specifies that writes to the mapping may be buffered to =
improve performance.
>> +    pub const DMA_ATTR_WRITE_COMBINE: Attribs =3D =
Attribs(bindings::DMA_ATTR_WRITE_COMBINE);
>> +
>> +    /// Lets the platform to avoid creating a kernel virtual mapping =
for the allocated buffer.
>> +    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attribs =3D =
Attribs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
>> +
>> +    /// Allows platform code to skip synchronization of the CPU =
cache for the given buffer assuming
>> +    /// that it has been already transferred to 'device' domain.
>> +    pub const DMA_ATTR_SKIP_CPU_SYNC: Attribs =3D =
Attribs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
>> +
>> +    /// Forces contiguous allocation of the buffer in physical =
memory.
>> +    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attribs =3D =
Attribs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
>> +
>> +    /// This is a hint to the DMA-mapping subsystem that it's =
probably not worth the time to try
>> +    /// to allocate memory to in a way that gives better TLB =
efficiency.
>> +    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attribs =3D =
Attribs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
>> +
>> +    /// This tells the DMA-mapping subsystem to suppress allocation =
failure reports (similarly to
>> +    /// __GFP_NOWARN).
>> +    pub const DMA_ATTR_NO_WARN: Attribs =3D =
Attribs(bindings::DMA_ATTR_NO_WARN);
>> +
>> +    /// Used to indicate that the buffer is fully accessible at an =
elevated privilege level (and
>> +    /// ideally inaccessible or at least read-only at =
lesser-privileged levels).
>> +    pub const DMA_ATTR_PRIVILEGED: Attribs =3D =
Attribs(bindings::DMA_ATTR_PRIVILEGED);
>> +}
>> +
>> +/// An abstraction of the `dma_alloc_coherent` API.
>> +///
>> +/// This is an abstraction around the `dma_alloc_coherent` API which =
is used to allocate and map
>> +/// large consistent DMA regions.
>> +///
>> +/// A [`CoherentAllocation`] instance contains a pointer to the =
allocated region (in the
>> +/// processor's virtual address space) and the device address which =
can be given to the device
>> +/// as the DMA address base of the region. The region is released =
once [`CoherentAllocation`]
>> +/// is dropped.
>> +///
>> +/// # Invariants
>> +///
>> +/// For the lifetime of an instance of [`CoherentAllocation`], the =
cpu address is a valid pointer
>> +/// to an allocated region of consistent memory and we hold a =
reference to the device.
>> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
>> +    dev: ARef<Device>,
>> +    dma_handle: bindings::dma_addr_t,
>> +    count: usize,
>> +    cpu_addr: *mut T,
>> +    dma_attrs: Attribs,
>> +}
>> +
>> +impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
>> +    /// Allocates a region of `size_of::<T> * count` of consistent =
memory.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::device::Device;
>> +    /// use kernel::dma::{attrs::*, CoherentAllocation};
>> +    ///
>> +    /// # fn test(dev: &Device) -> Result {
>> +    /// let c: CoherentAllocation<u64> =3D =
CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL,
>> +    ///                                                              =
    DMA_ATTR_NO_WARN)?;
>> +    /// # Ok::<(), Error>(()) }
>> +    /// ```
>> +    pub fn alloc_attrs(
>> +        dev: &Device,
>> +        count: usize,
>> +        gfp_flags: kernel::alloc::Flags,
>> +        dma_attrs: Attribs,
>> +    ) -> Result<CoherentAllocation<T>> {
>> +        build_assert!(core::mem::size_of::<T>() > 0,
>> +                      "It doesn't make sense for the allocated type =
to be a ZST");
>> +
>> +        let size =3D =
count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
>> +        let mut dma_handle =3D 0;
>> +        // SAFETY: device pointer is guaranteed as valid by =
invariant on `Device`.
>> +        // We ensure that we catch the failure on this function and =
throw an ENOMEM
>> +        let ret =3D unsafe {
>> +            bindings::dma_alloc_attrs(
>> +                dev.as_raw(),
>> +                size,
>> +                &mut dma_handle, gfp_flags.as_raw(),
>> +                dma_attrs.as_raw(),
>> +            )
>> +        };
>> +        if ret.is_null() {
>> +            return Err(ENOMEM)
>> +        }
>> +        // INVARIANT: We just successfully allocated a coherent =
region which is accessible for
>> +        // `count` elements, hence the cpu address is valid. We also =
hold a refcounted reference
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
>> +    /// Performs the same functionality as `alloc_attrs`, except the =
`dma_attrs` is 0 by default.
>> +    pub fn alloc_coherent(dev: &Device,
>> +                          count: usize,
>> +                          gfp_flags: kernel::alloc::Flags) -> =
Result<CoherentAllocation<T>> {
>> +        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, =
Attribs(0))
>> +    }
>=20
> Please run rustfmt.
>=20
>> +    /// Returns the base address to the allocated region and the dma =
handle. The caller takes
>> +    /// ownership of the returned resources.
>> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
>> +        let ret =3D (self.cpu_addr as _, self.dma_handle);
>> +        core::mem::forget(self);
>> +        ret
>> +    }
>=20
> Not only does this skip the destructor of `dma_free_attrs`. It also
> skips the destructor of fields including the `dev` field. Did you
> intend to leave the refcount on `struct device` without decrementing
> it?
>=20
>> +    /// Returns the base address to the allocated region in the =
CPU's virtual address space.
>> +    pub fn start_ptr(&self) -> *const T {
>> +        self.cpu_addr as _
>=20
> This conversion happens without needing a cast.
>=20
>> +    }
>> +
>> +    /// Returns the base address to the allocated region in the =
CPU's virtual address space as
>> +    /// a mutable pointer.
>> +    pub fn start_ptr_mut(&mut self) -> *mut T {
>> +        self.cpu_addr
>> +    }
>> +
>> +    /// Returns a DMA handle which may given to the device as the =
DMA address base of
>> +    /// the region.
>> +    pub fn dma_handle(&self) -> bindings::dma_addr_t {
>> +        self.dma_handle
>> +    }
>> +
>> +    /// Returns the CPU-addressable region as a slice.
>> +    pub fn cpu_buf(&self) -> &[T]
>> +    {
>> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
>> +        // is valid for reads for `self.count * size_of::<T>` bytes.
>> +        unsafe { core::slice::from_raw_parts(self.cpu_addr, =
self.count) }
>=20
> Immutable slices require that the data does not change while the
> reference is live. Is that the case? If so, your safety comment should
> explain that.
>=20
>> +    }
>> +
>> +    /// Performs the same functionality as `cpu_buf`, except that a =
mutable slice is returned.
>> +    pub fn cpu_buf_mut(&mut self) -> &mut [T]
>> +    {
>> +        // SAFETY: The pointer is valid due to type invariant on =
`CoherentAllocation` and
>> +        // is valid for reads for `self.count * size_of::<T>` bytes.
>> +        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, =
self.count) }
>=20
> Mutable slices require that the data is not written to *or read* by
> anybody else while the reference is live. Is that the case? If so,
> your safety comment should explain that.
>=20

The buffer will probably be shared between the CPU and some hardware =
device, since this is the
point of the dma mapping API.

It=E2=80=99s up to the caller to ensure that no hardware operations that =
involve the buffer are currently taking
place while the slices above are alive.

I think that adding that as a safety requirement to `cpu_buf` and =
`cpu_buf_mut` will be sufficient.

>> +    }
>> +}
>> +
>> +impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
>> +    fn drop(&mut self) {
>> +        let size =3D self.count * core::mem::size_of::<T>();
>> +        // SAFETY: the device, cpu address, and the dma handle is =
valid due to the
>> +        // type invariants on `CoherentAllocation`.
>> +        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
>> +                                          self.cpu_addr as _,
>> +                                          self.dma_handle,
>> +                                          self.dma_attrs.as_raw(),) =
}
>> +    }
>> +}
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index e1065a7551a3..6e90ebf5a130 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -35,6 +35,7 @@
>> mod build_assert;
>> pub mod cred;
>> pub mod device;
>> +pub mod dma;
>> pub mod error;
>> #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>> pub mod firmware;
>> =E2=80=94
>> 2.43.0

=E2=80=94 Daniel=
