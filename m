Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1729290E
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050037; cv=pass; b=iTIvT64zQp3VUbaFTuFWdPAlMkZPauvqoCkt04Tp3Lq3kV9Pq/tGito1OCVwCb44qoBLzaU5Hiw/olUF7XTzRZBozI6Y/wRnTqCsSLzZNFEwdYQkmO209z+RdOeLPaYBiDROG45PnO9bcxS8+aFKXXEeDUGXks7u12mXBPg74EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050037; c=relaxed/simple;
	bh=UYf2oyQ/NLxkABw1mepobORwzL7Tq//9bbO8hq69gqg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=stiSaT4W3RRmTUQ60tIYviGmtZkVkecLLUPZ7edCMICnPU5SfaZ3+yafjM5vkvZpkv19eEuNvwnhw0FxtT8UUfn71uzzTQMqEwe0tTezoTrwTmJaz3X893vZJJjsmNuKtmfsiFW5cSKl6ulFEDeqFFboOlo3NdWZMhZ6oUIXwQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=C8nVbFDW; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="C8nVbFDW"
ARC-Seal: i=1; a=rsa-sha256; t=1747049996; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JAFuyNkJHi2Yd9FRz94SBCnbBHMF+0lR/Xc5NOeoHBScm92l6JzVZAtPXJX4SGl3kHDGDFpKOUnsneWIVUhTsEczN3rfHyg+PZUL98FS+cvg6UfDe/pIPq8M3S74THRGtPwDRIZQunIuggRXS8RDpHGBPhDTatQhy04u38BR2q8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747049996; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BU9MLc37uG9xUwQT3nIi5E2jvqZnsiURS1FSSweAuXk=; 
	b=XTIZzV1B1iMVCJOWExSPZKELt4hr8Xt5CXrM7OQx0xL83CGs4c6M00vqZkJB0e7IIn4qPNaUY4cNWlFqZwBPnxcMgniQk9OOD1JNXeB/2qF9h1o/0hq7VEwqdL8t3ThzvGPZ21jKyfLYo7yf3+8ddZ2gRcn8rCYoPV06DxWejp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747049996;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BU9MLc37uG9xUwQT3nIi5E2jvqZnsiURS1FSSweAuXk=;
	b=C8nVbFDWo58aSfMdh5NDkUHhfV55MxD+64Eo+mgn1AknHKoYURs3G0R6EaWPfmUP
	mSKQyO+CrWskCKuUbj5uYcZ388N+QzK15dLZuJP0yHADE/G/UbvIQui7c3ltafHMauR
	980V0nayZCdlrrQWTtUyMwL9qzn0YKIXuq/DI3fk=
Received: by mx.zohomail.com with SMTPS id 1747049994257794.1632307548268;
	Mon, 12 May 2025 04:39:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
Date: Mon, 12 May 2025 08:39:36 -0300
Cc: dakr@kernel.org,
 lyude@redhat.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3564D77-9E26-4019-9B75-B0C53B26B64F@collabora.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Abdiel,

> On 12 May 2025, at 06:53, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Add the rust abstraction for scatterlist. This allows use of the C
> scatterlist within Rust code which the caller can allocate themselves
> or to wrap existing kernel sg_table objects.
>=20
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/helpers/helpers.c          |   1 +
> rust/helpers/scatterlist.c      |  25 +++
> rust/kernel/lib.rs              |   1 +
> rust/kernel/scatterlist.rs      | 275 ++++++++++++++++++++++++++++++++
> 5 files changed, 303 insertions(+)
> create mode 100644 rust/helpers/scatterlist.c
> create mode 100644 rust/kernel/scatterlist.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index ab37e1d35c70..a7d3b97cd4e0 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -14,6 +14,7 @@
> #include <linux/cred.h>
> #include <linux/device/faux.h>
> #include <linux/dma-mapping.h>
> +#include <linux/dma-direction.h>
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> #include <linux/file.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 1e7c84df7252..f45a15f88e25 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -28,6 +28,7 @@
> #include "rbtree.c"
> #include "rcu.c"
> #include "refcount.c"
> +#include "scatterlist.c"
> #include "security.c"
> #include "signal.c"
> #include "slab.c"
> diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
> new file mode 100644
> index 000000000000..5ab0826f7c0b
> --- /dev/null
> +++ b/rust/helpers/scatterlist.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/dma-direction.h>
> +
> +void rust_helper_sg_set_page(struct scatterlist *sg, struct page =
*page,
> +     unsigned int len, unsigned int offset)
> +{
> + return sg_set_page(sg, page, len, offset);
> +}
> +
> +dma_addr_t rust_helper_sg_dma_address(struct scatterlist *sg)
> +{
> + return sg_dma_address(sg);
> +}
> +
> +unsigned int rust_helper_sg_dma_len(struct scatterlist *sg)
> +{
> + return sg_dma_address(sg);
> +}
> +
> +void rust_helper_dma_unmap_sgtable(struct device *dev, struct =
sg_table *sgt,
> +   enum dma_data_direction dir, unsigned long attrs)
> +{
> + return dma_unmap_sgtable(dev, sgt, dir, attrs);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fa852886d4d1..a8d5fcb55388 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -87,6 +87,7 @@
> pub mod print;
> pub mod rbtree;
> pub mod revocable;
> +pub mod scatterlist;
> pub mod security;
> pub mod seq_file;
> pub mod sizes;
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..122a6f94bf56
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,275 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Scatterlist
> +//!
> +//! C header: =
[`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
> +
> +use crate::{
> +    bindings,
> +    device::Device,
> +    error::{Error, Result},
> +    page::Page,
> +    types::{ARef, Opaque},
> +};
> +use core::ops::{Deref, DerefMut};
> +
> +/// A single scatter-gather entry, representing a span of pages in =
the device's DMA address space.
> +///
> +/// # Invariants
> +///
> +/// The `scatterlist` pointer is valid for the lifetime of an SGEntry =
instance.
> +#[repr(transparent)]
> +pub struct SGEntry(Opaque<bindings::scatterlist>);
> +
> +impl SGEntry {
> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to =
by `ptr` is valid for the lifetime
> +    /// of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a =
Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety =
requirements of the function.
> +        unsafe { &*ptr.cast() }
> +    }

Hmm, this name is not good. When people see as_ref() they will think of =
the
standard library where it is used to convert from &T to &U. This is not =
what is
happening here. Same in other places where as_ref() is used in this =
patch.

> +
> +    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// See safety requirements of [`SGEntry::as_ref`]. In addition, =
callers must ensure that only
> +    /// a single mutable reference can be taken from the same raw =
pointer, i.e. for the lifetime of the
> +    /// returned reference, no other call to this function on the =
same `struct scatterlist *` should
> +    /// be permitted.
> +    unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut =
Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety =
requirements of the function.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Returns the DMA address of this SG entry.
> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_address(self.0.get()) }
> +    }
> +
> +    /// Returns the length of this SG entry.
> +    pub fn dma_len(&self) -> u32 {
> +        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
> +        unsafe { bindings::sg_dma_len(self.0.get()) }
> +    }
> +
> +    /// Set this entry to point at a given page.
> +    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) =
{
> +        let c: *mut bindings::scatterlist =3D self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the =
scatterlist pointer is valid.
> +        // `Page` invariant also ensure the pointer is valid.

Nit: =E2=80=9C[..] ensures that the pointer is valid.=E2=80=9D, but =
perhaps a native speaker should chime in.

> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, =
offset) };
> +    }
> +
> +    /// Obtain the raw `struct scatterlist *`.
> +    pub fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
> +    }
> +}
> +
> +/// DMA mapping direction.
> +///
> +/// Corresponds to the kernel's [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: =
srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +#[repr(u32)]
> +pub enum DmaDataDirection {
> +    /// Direction isn't known.
> +    DmaBidirectional =3D =
bindings::dma_data_direction_DMA_BIDIRECTIONAL,
> +    /// Data is going from the memory to the device.
> +    DmaToDevice =3D bindings::dma_data_direction_DMA_TO_DEVICE,
> +    /// Data is coming from the device to the memory.
> +    DmaFromDevice =3D bindings::dma_data_direction_DMA_FROM_DEVICE,
> +    /// No direction (used for debugging).
> +    DmaNone =3D bindings::dma_data_direction_DMA_NONE,
> +}
> +
> +/// The base interface for a scatter-gather table of DMA address =
spans.
> +///
> +/// This structure represents the Rust abstraction for a C `struct =
sg_table`. This implementation
> +/// abstracts the usage of an already existing C `struct sg_table` =
within Rust code that we get
> +/// passed from the C side.

This is a bit hard to parse.

> +///
> +/// # Invariants
> +///
> +/// The `sg_table` pointer is valid for the lifetime of an SGTable =
instance.
> +#[repr(transparent)]
> +pub struct SGTable(Opaque<bindings::sg_table>);
> +
> +impl SGTable {
> +    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` pointed to by =
`ptr` is initialized and valid for
> +    /// the lifetime of the returned reference.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a =
Self {
> +        // SAFETY: Guaranteed by the safety requirements of the =
function.
> +        unsafe { &*ptr.cast() }
> +    }

If you take my suggestion of introducing a new type, of the safety =
requirements
will be to correctly identify whether dma_map() has already been called.

> +
> +    /// Obtain the raw `struct sg_table *`.
> +    pub fn as_raw(&self) -> *mut bindings::sg_table {
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable iterator over the scather-gather table.
> +    pub fn iter_mut(&mut self) -> SGTableIterMut<'_> {
> +        SGTableIterMut {
> +            // SAFETY: dereferenced pointer is valid due to the type =
invariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) =
}),

Same comment as `as_ref` here. Perhaps `from_ptr`?

> +        }
> +    }
> +
> +    /// Returns an iterator over the scather-gather table.
> +    pub fn iter(&self) -> SGTableIter<'_> {
> +        SGTableIter {
> +            // SAFETY: dereferenced pointer is valid due to the type =
invariants on `SGTable`.
> +            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) =
}),
> +        }
> +    }
> +}
> +
> +/// SAFETY: The `SGTable` should be `Send` across threads.
> +unsafe impl Send for SGTable {}
> +
> +/// A mutable iterator through `SGTable` entries.
> +pub struct SGTableIterMut<'a> {
> +    pos: Option<&'a mut SGEntry>,
> +}
> +
> +impl<'a> IntoIterator for &'a mut SGTable {
> +    type Item =3D &'a mut SGEntry;
> +    type IntoIter =3D SGTableIterMut<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter_mut()
> +    }
> +}
> +
> +impl<'a> Iterator for SGTableIterMut<'a> {
> +    type Item =3D &'a mut SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.pos.take().map(|entry| {
> +            let sg =3D entry.as_raw();
> +            // SAFETY: `sg` is guaranteed to be valid and non-NULL =
while inside this closure. The calls
> +            // to `SGEntry::as_mut` are unique for each scatterlist =
entry object as well.
> +            unsafe {
> +                let next =3D bindings::sg_next(sg);
> +                self.pos =3D (!next.is_null()).then(|| =
SGEntry::as_mut(next));
> +                SGEntry::as_mut(sg)
> +            }
> +        })
> +    }
> +}
> +
> +/// An iterator through `SGTable` entries.
> +pub struct SGTableIter<'a> {
> +    pos: Option<&'a SGEntry>,
> +}
> +
> +impl<'a> IntoIterator for &'a SGTable {
> +    type Item =3D &'a SGEntry;
> +    type IntoIter =3D SGTableIter<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +impl<'a> Iterator for SGTableIter<'a> {
> +    type Item =3D &'a SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.pos.map(|entry| {
> +            let sg =3D entry.as_raw();
> +            // SAFETY: `sg` is guaranteed to be valid and non-NULL =
while inside this closure.
> +            unsafe {
> +                let next =3D bindings::sg_next(sg);
> +                self.pos =3D (!next.is_null()).then(|| =
SGEntry::as_ref(next));
> +                SGEntry::as_ref(sg)
> +            }
> +        })
> +    }
> +}
> +
> +/// A scatter-gather table that owns the allocation and can be mapped =
for DMA operation using `Device`.
> +pub struct DeviceSGTable {
> +    sg: SGTable,
> +    dir: DmaDataDirection,
> +    dev: ARef<Device>,
> +}
> +
> +impl DeviceSGTable {
> +    /// Allocate and construct the scatter-gather table.
> +    pub fn alloc_table(dev: &Device, nents: usize, flags: =
kernel::alloc::Flags) -> Result<Self> {
> +        let sgt: Opaque<bindings::sg_table> =3D Opaque::uninit();
> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped =
`sg_table` object hence is valid.
> +        let ret =3D unsafe { bindings::sg_alloc_table(sgt.get(), =
nents as _, flags.as_raw()) };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        Ok(Self {
> +            sg: SGTable(sgt),
> +            dir: DmaDataDirection::DmaNone,
> +            dev: dev.into(),
> +        })
> +    }
> +
> +    /// Map this scatter-gather table describing a buffer for DMA.
> +    pub fn dma_map(&mut self, dir: DmaDataDirection) -> Result {
> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that =
the `self.dev` and `self.sg`
> +        // pointers are valid.
> +        let ret =3D unsafe {
> +            bindings::dma_map_sgtable(
> +                self.dev.as_raw(),
> +                self.sg.as_raw(),
> +                dir as _,
> +                bindings::DMA_ATTR_NO_WARN as _,
> +            )
> +        };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        self.dir =3D dir;
> +        Ok(())
> +    }
> +}
> +
> +// TODO: Implement these as macros for objects that want to derive =
from `SGTable`.
> +impl Deref for DeviceSGTable {
> +    type Target =3D SGTable;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.sg
> +    }
> +}
> +
> +impl DerefMut for DeviceSGTable {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.sg
> +    }
> +}
> +
> +impl Drop for DeviceSGTable {
> +    fn drop(&mut self) {
> +        if self.dir !=3D DmaDataDirection::DmaNone {

Hmm, I am not sure that we should be using DMA_NONE for this.

I mean, it possibly works, but it's probably not what it's meant for?

> +            // SAFETY: Invariants on `Device` and `SGTable` ensures =
that the `self.dev` and `self.sg`
> +            // pointers are valid.
> +            unsafe {
> +                bindings::dma_unmap_sgtable(self.dev.as_raw(), =
self.sg.as_raw(), self.dir as _, 0)
> +            };
> +        }
> +        // SAFETY: Invariant on `SGTable` ensures that the `self.sg` =
pointer is valid.
> +        unsafe { bindings::sg_free_table(self.sg.as_raw()) };
> +    }
> +}
> --=20
> 2.43.0
>=20
>=20

Other than the minor comments I made, this looks good on a first glance.

=E2=80=94 Daniel

