Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328D2E630
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753231541; cv=pass; b=QxH5L+Jf1sJGgwAvLgPVBAvIf67MXv6HNKRlJVUuivIxrszM+6xQ0FG8jAHYu37GDZpJoLuPk+oWoldPdublDwReSzVuExUDYyGnf6wY6C7aaiWe68+2+UCJm5XHZrhCow67KqN7YOf8xGTBjOl53H24uw/QSr8ZNrQ1sGYcbdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753231541; c=relaxed/simple;
	bh=YkEQiUosvcK8XA37iDMYpyYrYggceyNgpIhQ3gg4PUA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sPsvaDwsSfCbrMXSlfWWpH1BNR3MBocNked4AiyWKQGkn6F7cPCxXHIquduaV1Xrz7qkG1mIxKKslTLYgZ+o/Fz1/IlXZNIERAPQ252k/sbs8lfJS6nU/nmf0BC4o1BTTicd1ez+Yzs8Y3M3vxi9c/2GK8HxGzRMzdtPncfqFU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=PkAqea0v; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="PkAqea0v"
ARC-Seal: i=1; a=rsa-sha256; t=1753231501; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AoY9r0kZNzmY+7I5ME1iBkgDoB8Aje5DEIxLdtLJOjKLyp3Os9E2HKQw+a6GZIHcuFa8dvYJ1DE2+BuPYaADeA15wLLjrZcEpRbq5rFRnCaVeQeIkpqe461i1WZm/kHUEOuvoWEcgaqKE2Mb98c+W4shiBLJrx5zGeazIdmWyZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753231501; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y/8TA8iXa+swpxja+BCip3f75Ikfe8JgOIrMXP2uKLk=; 
	b=SyzV4TC9WLhj07pbdtBOhebYyDcAnFhHGQY2eFy259zsOF3dvJ08yeiW/LVVQQGVgsqgm0JW0p8fc+LOP6s+rGoDsanAoaKPCo7ryC1ey4gujfinYNtY+KjwkEUWShbyAjKj6HvEI0ttQ64azYrrb0wqrpaRO1vmaaEdlErNSt0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753231501;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Y/8TA8iXa+swpxja+BCip3f75Ikfe8JgOIrMXP2uKLk=;
	b=PkAqea0vJS5hMQka0mF95mVBEVA6RnsHV/6VKBrMWKqJh7kTupblImbulmr65/ZZ
	xdtX/1ZfNpyJkwCCyN7gSBPYMXNOw2PxkLysWnGUruEgklF2BjWYTLBB+wNY7coF57P
	fraShl9mywcncC8BbGfdfjGiSYLL+t6MSctDJGAg=
Received: by mx.zohomail.com with SMTPS id 1753231497812613.8647771954251;
	Tue, 22 Jul 2025 17:44:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
Date: Tue, 22 Jul 2025 21:44:39 -0300
Cc: acourbot@nvidia.com,
 dakr@kernel.org,
 jgg@ziepe.ca,
 lyude@redhat.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Petr Tesarik <petr@tesarici.cz>,
 Sui Jingfeng <sui.jingfeng@linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E999B1A2-B1F6-4625-B784-08016672F4E0@collabora.com>
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Abdiel, Alex,


This overall looks good, a few minor comments below.

> On 18 Jul 2025, at 07:33, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Add the rust abstraction for scatterlist. This allows use of the C
> scatterlist within Rust code which the caller can allocate themselves
> or to wrap existing kernel sg_table objects.
>=20
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/helpers/helpers.c          |   1 +
> rust/helpers/scatterlist.c      |  30 +++
> rust/kernel/dma.rs              |  18 ++
> rust/kernel/lib.rs              |   1 +
> rust/kernel/scatterlist.rs      | 405 ++++++++++++++++++++++++++++++++
> 6 files changed, 456 insertions(+)
> create mode 100644 rust/helpers/scatterlist.c
> create mode 100644 rust/kernel/scatterlist.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index 8cbb660e2ec2..e1e289284ce8 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -47,6 +47,7 @@
> #include <linux/cred.h>
> #include <linux/device/faux.h>
> #include <linux/dma-mapping.h>
> +#include <linux/dma-direction.h>
> #include <linux/errname.h>
> #include <linux/ethtool.h>
> #include <linux/file.h>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0683fffdbde2..7b18bde78844 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -35,6 +35,7 @@
> #include "rbtree.c"
> #include "rcu.c"
> #include "refcount.c"
> +#include "scatterlist.c"
> #include "security.c"
> #include "signal.c"
> #include "slab.c"
> diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
> new file mode 100644
> index 000000000000..c871de853539
> --- /dev/null
> +++ b/rust/helpers/scatterlist.c
> @@ -0,0 +1,30 @@
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
> + return sg_dma_len(sg);
> +}
> +
> +struct scatterlist *rust_helper_sg_next(struct scatterlist *sg)
> +{
> + return sg_next(sg);
> +}
> +
> +void rust_helper_dma_unmap_sgtable(struct device *dev, struct =
sg_table *sgt,
> +   enum dma_data_direction dir, unsigned long attrs)
> +{
> + return dma_unmap_sgtable(dev, sgt, dir, attrs);
> +}
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 1f7bae643416..598fa50e878d 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -102,6 +102,24 @@ pub mod attrs {
>     pub const DMA_ATTR_PRIVILEGED: Attrs =3D =
Attrs(bindings::DMA_ATTR_PRIVILEGED);
> }
>=20
> +/// DMA mapping direction.
> +///
> +/// Corresponds to the kernel's [`enum dma_data_direction`].
> +///
> +/// [`enum dma_data_direction`]: =
srctree/include/linux/dma-direction.h
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +#[repr(i32)]
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
> /// An abstraction of the `dma_alloc_coherent` API.
> ///
> /// This is an abstraction around the `dma_alloc_coherent` API which =
is used to allocate and map
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f61ac6f81f5d..48391a75bb62 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -101,6 +101,7 @@
> pub mod print;
> pub mod rbtree;
> pub mod revocable;
> +pub mod scatterlist;
> pub mod security;
> pub mod seq_file;
> pub mod sizes;
> diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
> new file mode 100644
> index 000000000000..0242884bf9fd
> --- /dev/null
> +++ b/rust/kernel/scatterlist.rs
> @@ -0,0 +1,405 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Scatterlist
> +//!
> +//! C header: =
[`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
> +
> +use core::borrow::{Borrow, BorrowMut};
> +
> +use crate::{
> +    bindings,
> +    device::{Bound, Device},
> +    dma::DmaDataDirection,
> +    error::{Error, Result},
> +    page::Page,
> +    types::{ARef, Opaque},
> +};
> +
> +/// A single scatter-gather entry, representing a span of pages in =
the device's DMA address space.
> +///
> +/// This interface is accessible only via the `SGTable` iterators. =
When using the API safely, certain
> +/// methods are only available depending on a specific state of =
operation of the scatter-gather table,
> +/// i.e. setting page entries is done internally only during =
construction while retrieving the DMA address
> +/// is only possible when the `SGTable` is already mapped for DMA via =
a device.
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
> +    /// This is meant as a helper for other kernel subsystems and not =
to be used by device drivers directly.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct scatterlist` pointed to =
by `ptr` is valid for the lifetime
> +    /// of the returned reference.
> +    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) =
-> &'a Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety =
requirements of the function.
> +        unsafe { &*ptr.cast() }
> +    }

Did you see this? [0]


> +
> +    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
> +    ///
> +    /// This is meant as a helper for other kernel subsystems and not =
to be used by device drivers directly.
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
> +    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) =
-> &'a mut Self {
> +        // SAFETY: The pointer is valid and guaranteed by the safety =
requirements of the function.
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Obtain the raw `struct scatterlist *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
> +        self.0.get()
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
> +    /// Internal constructor helper to set this entry to point at a =
given page. Not to be used directly.
> +    fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
> +        let c: *mut bindings::scatterlist =3D self.0.get();
> +        // SAFETY: according to the `SGEntry` invariant, the =
scatterlist pointer is valid.
> +        // `Page` invariant also ensure the pointer is valid.
> +        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, =
offset) };
> +    }
> +}
> +
> +/// Trait implemented by all mapping states.
> +pub trait MappingState {}
> +
> +/// Trait implemented by all mapping states representing the fact =
that a `struct sg_table` is
> +/// mapped (and thus its DMA addresses are valid).
> +pub trait MappedState: MappingState {}
> +
> +/// Represents the fact that a `struct sg_table` is not DMA-mapped.
> +pub struct Unmapped;
> +impl MappingState for Unmapped {}
> +
> +/// Represents the fact that a `struct sg_table` is DMA-mapped by an =
external entity.

Perhaps it would be nice to define what an =E2=80=9Cexternal entity=E2=80=9D=
 means?

> +pub struct BorrowedMapping;
> +impl MappingState for BorrowedMapping {}
> +impl MappedState for BorrowedMapping {}
> +
> +/// A managed DMA mapping of a `struct sg_table` to a given device.
> +///
> +/// The mapping is cleared when this object is dropped.
> +///
> +/// # Invariants
> +///
> +/// - The `scatterlist` pointer is valid for the lifetime of a =
`ManagedMapping` instance.
> +/// - The `Device` instance is within a [`kernel::device::Bound`] =
context.
> +pub struct ManagedMapping {
> +    dev: ARef<Device>,
> +    dir: DmaDataDirection,
> +    // This works because the `sgl` member of `struct sg_table` never =
moves, and the fact we can
> +    // build this implies that we have an exclusive reference to the =
`sg_table`, thus it cannot be
> +    // modified by anyone else.
> +    sgl: *mut bindings::scatterlist,
> +    orig_nents: ffi::c_uint,
> +}
> +
> +/// SAFETY: An `ManagedMapping` object is an immutable interface and =
should be safe to `Send` across threads.
> +unsafe impl Send for ManagedMapping {}
> +impl MappingState for ManagedMapping {}
> +impl MappedState for ManagedMapping {}
> +
> +impl Drop for ManagedMapping {
> +    fn drop(&mut self) {
> +        // SAFETY: Invariants on `Device<Bound>` and `Self` ensures =
that the `self.dev` and `self.sgl`
> +        // are valid.
> +        unsafe {
> +            bindings::dma_unmap_sg_attrs(
> +                self.dev.as_raw(),
> +                self.sgl,
> +                self.orig_nents as i32,
> +                self.dir as i32,
> +                0,
> +            )
> +        };
> +    }
> +}
> +
> +/// A scatter-gather table of DMA address spans.
> +///
> +/// This structure represents the Rust abstraction for a C `struct =
sg_table`. This implementation
> +/// abstracts the usage of an already existing C `struct sg_table` =
within Rust code that we get
> +/// passed from the C side.
> +pub struct SGTable<T: Borrow<bindings::sg_table>, M: MappingState> {
> +    /// Mapping state of the underlying `struct sg_table`.
> +    ///
> +    /// This defines which methods of `SGTable` are available.
> +    ///
> +    /// Declared first so it is dropped before `table`, so we remove =
the mapping before freeing the
> +    /// SG table if the latter is owned.
> +    _mapping: M,
> +
> +    /// Something that can borrow the underlying `struct sg_table`.
> +    table: T,
> +}
> +
> +impl<T> SGTable<T, Unmapped>
> +where
> +    T: Borrow<bindings::sg_table>,
> +{
> +    /// Create a new unmapped `SGTable` from an already-existing =
`struct sg_table`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` borrowed by =
`r` is initialized, valid for
> +    /// the lifetime of the returned reference, and is not mapped.
> +    pub unsafe fn new_unmapped(r: T) -> Self {
> +        Self {
> +            table: r,
> +            _mapping: Unmapped,
> +        }
> +    }
> +}
> +
> +impl<T> SGTable<T, BorrowedMapping>
> +where
> +    T: Borrow<bindings::sg_table>,
> +{
> +    /// Create a new mapped `SGTable` from an already-existing =
`struct sg_table`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the `struct sg_table` borrowed by =
`r` is initialized, valid for
> +    /// the lifetime of the returned reference, and is DMA-mapped.
> +    pub unsafe fn new_mapped(r: T) -> Self {
> +        Self {
> +            table: r,
> +            _mapping: BorrowedMapping,
> +        }
> +    }
> +}
> +
> +impl<T, M> SGTable<T, M>
> +where
> +    T: Borrow<bindings::sg_table>,
> +    M: MappedState,
> +{
> +    /// Returns an immutable iterator over the scatter-gather table.
> +    pub fn iter(&self) -> SGTableIter<'_> {
> +        SGTableIter {
> +            // SAFETY: dereferenced pointer is valid due to the type =
invariants on `SGTable`.
> +            pos: Some(unsafe { =
SGEntry::as_ref(self.table.borrow().sgl) }),
> +        }
> +    }
> +}
> +
> +/// Provides a list of pages that can be used to build a `SGTable`.
> +pub trait SGTablePages {

I feel like this could be defined closer to where it is used.

> +    /// Returns an iterator to the pages providing the backing memory =
of `self`.
> +    ///
> +    /// Implementers should return an iterator which provides =
information regarding each page entry to
> +    /// build the `SGTable`. The first element in the tuple is a =
reference to the Page, the second element
> +    /// as the offset into the page, and the third as the length of =
data. The fields correspond to the
> +    /// first three fields of the C `struct scatterlist`.

I feel like the above could be replaced by simply defining a struct with =
the
right field names.

> +    fn iter<'a>(&'a self) -> impl Iterator<Item =3D (&'a Page, usize, =
usize)>;
> +
> +    /// Returns the number of pages in the list.
> +    fn entries(&self) -> usize;
> +}
> +
> +/// An iterator through `SGTable` entries.
> +pub struct SGTableIter<'a> {
> +    pos: Option<&'a SGEntry>,
> +}
> +
> +impl<'a> Iterator for SGTableIter<'a> {
> +    type Item =3D &'a SGEntry;
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        let entry =3D self.pos;
> +        // SAFETY: `sg` is an immutable reference and is equivalent =
to `scatterlist` via its type
> +        // invariants, so its safe to use with sg_next.
> +        let next =3D unsafe { bindings::sg_next(self.pos?.as_raw()) =
};
> +
> +        // SAFETY: `sg_next` returns either a valid pointer to a =
`scatterlist`, or null if we
> +        // are at the end of the scatterlist.
> +        self.pos =3D (!next.is_null()).then(|| unsafe { =
SGEntry::as_ref(next) });
> +        entry
> +    }
> +}
> +
> +impl<'a, T, M> IntoIterator for &'a SGTable<T, M>
> +where
> +    T: Borrow<bindings::sg_table>,
> +    M: MappedState,
> +{
> +    type Item =3D &'a SGEntry;
> +    type IntoIter =3D SGTableIter<'a>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +impl<T> SGTable<T, Unmapped>
> +where
> +    T: BorrowMut<bindings::sg_table>,
> +{
> +    /// Map this scatter-gather table describing a buffer for DMA by =
the `Device`.
> +    ///
> +    /// To prevent the table from being mapped more than once, this =
call consumes `self` and transfers
> +    /// ownership of resources to the new `SGTable<_, =
ManagedMapping>` object.
> +    pub fn dma_map(
> +        mut self,
> +        dev: &Device<Bound>,
> +        dir: DmaDataDirection,
> +    ) -> Result<SGTable<T, ManagedMapping>> {
> +        // SAFETY: Invariants on `Device<Bound>` and `SGTable` =
ensures that the pointers are valid.
> +        let ret =3D unsafe {
> +            bindings::dma_map_sgtable(
> +                dev.as_raw(),
> +                self.table.borrow_mut(),
> +                dir as i32,
> +                bindings::DMA_ATTR_NO_WARN as usize,
> +            )
> +        };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        let sgl =3D self.table.borrow_mut().sgl;
> +        let orig_nents =3D self.table.borrow().orig_nents;
> +
> +        Ok(SGTable {
> +            table: self.table,
> +            // INVARIANT:
> +            // - `sgl` is valid by the type invariant of `OwnedSgt`.

How is `OwnedSgt` relevant here? I see self, which is SGTable, then =
table,
which is T: Borrow<bindings::sg_table>, and then borrow(), which is
bindings::sg_table.

> +            // - `dev` is a reference to Device<Bound>.
> +            _mapping: ManagedMapping {
> +                dev: dev.into(),
> +                dir,
> +                sgl,
> +                orig_nents,
> +            },
> +        })
> +    }
> +}
> +
> +/// An owned `struct sg_table`, which lifetime is tied to this =
object.

s/which/whose ? Although I am not a native English speaker.

> +///
> +/// # Invariants
> +///
> +/// The `sg_table` is valid and initialized for the lifetime of an =
`OwnedSgt` instance.
> +pub struct OwnedSgt<P: SGTablePages> {
> +    sgt: bindings::sg_table,
> +    /// Used to keep the memory pointed to by `sgt` alive.
> +    _pages: P,
> +}
> +
> +/// SAFETY: An `OwnedSgt` object is constructed internally by =
`SGTable` and no interface is exposed to
> +/// the user to modify its state after construction, except =
[`SGTable::dma_map`] which transfers
> +/// ownership of the object, hence should be safe to `Send` across =
threads.
> +unsafe impl<P: SGTablePages> Send for OwnedSgt<P> {}
> +
> +impl<P> Drop for OwnedSgt<P>
> +where
> +    P: SGTablePages,
> +{
> +    fn drop(&mut self) {
> +        // SAFETY: Invariant on `OwnedSgt` ensures that the sg_table =
is valid.
> +        unsafe { bindings::sg_free_table(&mut self.sgt) };
> +    }
> +}
> +
> +impl<P> Borrow<bindings::sg_table> for OwnedSgt<P>
> +where
> +    P: SGTablePages,
> +{
> +    fn borrow(&self) -> &bindings::sg_table {
> +        &self.sgt
> +    }
> +}
> +
> +// To allow mapping the state!

Can you expand this comment a bit?

> +impl<P> BorrowMut<bindings::sg_table> for OwnedSgt<P>
> +where
> +    P: SGTablePages,
> +{
> +    fn borrow_mut(&mut self) -> &mut bindings::sg_table {
> +        &mut self.sgt
> +    }
> +}
> +
> +impl<P: SGTablePages> SGTable<OwnedSgt<P>, Unmapped> {

Oh, I now see that you can have SGTable<OwnedSgt<..>, =E2=80=A6>. In any =
case, when
I said in my previous comment that "I don't see how OwnedSGTable is =
relevant
here=E2=80=9D, T was unconstrained.

I am mentioning this on the off-chance that it's a mistaken assumption =
instead
of a typo.

> +    /// Allocate and build a new `SGTable` from an existing list of =
`pages`. This method moves the
> +    /// ownership of `pages` to the table.
> +    ///
> +    /// To build a scatter-gather table, provide the `pages` object =
which must implement the
> +    /// `SGTablePages` trait.
> +    ///
> +    ///# Examples
> +    ///
> +    /// ```
> +    /// use kernel::{device::Device, scatterlist::*, page::*, =
prelude::*};
> +    ///
> +    /// struct PagesArray(KVec<Page>);

A blank line would be welcome here, IMHO.

> +    /// impl SGTablePages for PagesArray {
> +    ///     fn iter<'a>(&'a self) -> impl Iterator<Item =3D (&'a =
Page, usize, usize)> {

See, it's hard to figure out what is going on here. I had to go back up =
to the
comment that explains what each field means in the tuple. This could be =
fixed
if this thing was its own struct with named fields.

> +    ///         self.0.iter().map(|page| (page, =
kernel::page::PAGE_SIZE, 0))

By the way, ironically, the order seems to be inverted here :)

> +    ///     }
> +    ///
> +    ///     fn entries(&self) -> usize {
> +    ///         self.0.len()
> +    ///     }
> +    /// }
> +    ///
> +    /// let mut pages =3D KVec::new();
> +    /// let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, =
GFP_KERNEL);
> +    /// let _ =3D pages.push(Page::alloc_page(GFP_KERNEL)?, =
GFP_KERNEL);
> +    /// let sgt =3D SGTable::new_owned(PagesArray(pages), =
GFP_KERNEL)?;
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn new_owned(pages: P, flags: kernel::alloc::Flags) -> =
Result<Self> {
> +        // SAFETY: `sgt` is not a reference.
> +        let mut sgt: bindings::sg_table =3D unsafe { =
core::mem::zeroed() };
> +
> +        // SAFETY: The sgt pointer is from the Opaque-wrapped =
`sg_table` object hence is valid.

IMHO the sentence above does not read very well.

> +        let ret =3D
> +            unsafe { bindings::sg_alloc_table(&mut sgt, =
pages.entries() as u32, flags.as_raw()) };
> +        if ret !=3D 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +        // SAFETY: We just successfully allocated `sgt`, hence the =
pointer is valid and have sole access to
> +        // it at this point.
> +        let sgentries =3D unsafe { =
core::slice::from_raw_parts_mut(sgt.sgl, pages.entries()) };
> +        for (entry, page) in sgentries
> +            .iter_mut()
> +            .map(|e|
> +                 // SAFETY: `SGEntry::as_mut` is called on the =
pointer only once, which is valid and non-NULL
> +                 // while inside the closure.
> +                 unsafe { SGEntry::as_mut(e) })
> +            .zip(pages.iter())
> +        {
> +            entry.set_page(page.0, page.1 as u32, page.2 as u32)
> +        }
> +
> +        Ok(Self {
> +            // INVARIANT: We just successfully allocated and built =
the table from the page entries.
> +            table: OwnedSgt { sgt, _pages: pages },
> +            _mapping: Unmapped,
> +        })
> +    }
> +}
> --=20
> 2.43.0
>=20
>=20

If you give me a couple of days I can test this on Tyr and see if the =
MCU still boots :)

=E2=80=94 Daniel

[0] =
https://lore.kernel.org/rust-for-linux/20250711-device-as-ref-v2-0-1b16ab6=
402d7@google.com/

