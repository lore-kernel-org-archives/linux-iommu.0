Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D5204680
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470566; cv=none; b=XxQwyIHL746RquINoToKqVdiQxOkXDupIpxC7oAEiyxvpbEv5Btu7srsrOZTiWN+OJ2nQ0xKO3hqmCtb5S96xqa2GENriBXu97GA+p3rkReJqJcbiTf94/zhk+t3XIg9/F+kZBauZDsSr/qYt+um529gxPErqchAitNFxlGnsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470566; c=relaxed/simple;
	bh=0sYRtco5/LIhNuvunQhP3dpti9pGta5j86E9VC8F7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT0X84NXiCsbIdCAcbAeLSD3XJSwJjKnZdiTYKxMGWNg69kzEXA0broH8RdvyvztGy2eAbZNeYL9eUrliW8f6Qj5YfzIRh8f61VKjtO6GJAyCX34g4hKK/r7bGO8jK0nPYwj5BY+J75jj0nWYnqiIal5xpMy86aQlzlAUdINrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9IKQkax; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9IKQkax"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30db1bd3bebso2461191fa.2
        for <iommu@lists.linux.dev>; Wed, 28 May 2025 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748470562; x=1749075362; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE8xriiFGztd1btvq75clmhQPb2gnzIni6aMdTgzdD8=;
        b=h9IKQkaxgXIT2OKad59ZJ8hTFuNgRvpE8xRpk9Xmij4nCbYxs8PXC86QrrJaJu2CgY
         3FoxAPwCXQAbQXWwa7t3dd5cjvOLPhirbjMlQV1Detu6UK+I2ABjPde3voa+6zrxQblo
         nKVe9L/lNPiTIP4R/xoc2M3w+rfxIxcTnR8pfB1mDiDdJBmge8NtMJf/iKr6xwyv/KLG
         ZCZvbHhMPMAyRfzw1Gb770kOtNcMu83DTXlIK27s4axtDu1fUPez0ECISt/s1K9zvdGe
         kSCSuEjfFLiOAzPv1e/NH2rcXoV65/Ho13ObYaVFMqY9mNjtHczWyaveuYF2ElrAXFxC
         4KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748470562; x=1749075362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE8xriiFGztd1btvq75clmhQPb2gnzIni6aMdTgzdD8=;
        b=fB0fcJ3RojEkjMh5VP4rKldW0w2fLb7U1xpQY1OmKvFpJM6IsfDb7KsEJybzYK6qsw
         7U4JNz+lKUVymBPHaDJ2qsQJ9psNj47sF3rnWok+d2kGsk1GIle5u6fjxVDdhS+W7wtO
         qBiUjf5YWXoHNZT9DN9vTqnHeHxpshkhrgkknpXQ+JsdxCdAUNXrzeg11iyNH9OTTPJl
         AnFvCurkwQ4JmfZlI0VG5wWuqeNBgGiylDIhtaTw0+jJ/kkFmvpaBjCyZ0gLK1i7UZ+F
         jwW8AhdAGMs7JJ3UO+emnEQqFycQHWNlvOfCPG2GiGN1ysX/uGSFKVreEtHO5+PchR0R
         x3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe4gbSf+EM7Ethzvu/b/E8N4L5iIaeCIDHn4GaLn/He/acUrw6B3AgvVnbjreYGG5VQV/8Ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzOUL7zvxr2PMkKOSdUb1+DvEOm6mgRZbIciMaaRmT5lEqWVwb
	CyllQeFQAuEz/80Oy/X972gUPJi6asxiWilMmVWPvP2OVsFxHsIRwyRS
X-Gm-Gg: ASbGnctaSw5T0V3jXih5Qtmo9r7/flQgcXjoeiFT0Buu5v5TWRiDWbHAM4S9wmgcsK3
	o3101VTHjxYNrv8yomsPri0t1VwEUxv5m82uENPR4cWG69rIcaieoqWPWluaXUFi29xBFh4OAnV
	YSLK8JlXEUabgSnJKvcZAM3IqVWRwQYNO0NLSZtOqMklFoKboA7G9E8hTDUT4vpcjsf7Vd0mWaW
	hvFhgQXV5ueWjTsEBwrAHKCnhvvBRIvY5bsZ3h/r+JI5sP0FaqbfIuwvUV3gXPc5fAjQ5kk0WR5
	n7IN5BbntKuCV4TZlaMALcotP/iu3a4e1rAAE2LAzRJtrF/rXN1rWGHZspLgcmvuxItzH/fHsq6
	7pA2BqvWNJPnHOY1COdWrKmoObGqD
X-Google-Smtp-Source: AGHT+IHtOgIZ7FKwvN0689N26kR4L3Ct+uY1ZfyLG/NS5h+f9nSFNIfLh9QlHFHYeUjE+GOrU0rRHA==
X-Received: by 2002:a05:651c:199f:b0:32a:6dc7:8f0a with SMTP id 38308e7fff4ca-32a6dc79222mr24551181fa.15.1748470561527;
        Wed, 28 May 2025 15:16:01 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b55de7sm156911fa.53.2025.05.28.15.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:16:01 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: jgg@ziepe.ca,
	acourbot@nvidia.com,
	dakr@kernel.org,
	lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 1/2] rust: add initial scatterlist bindings
Date: Thu, 29 May 2025 01:14:05 +0300
Message-ID: <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the rust abstraction for scatterlist. This allows use of the C
scatterlist within Rust code which the caller can allocate themselves
or to wrap existing kernel sg_table objects.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  25 +++
 rust/kernel/dma.rs              |  17 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 369 ++++++++++++++++++++++++++++++++
 6 files changed, 414 insertions(+)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..a7d3b97cd4e0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -14,6 +14,7 @@
 #include <linux/cred.h>
 #include <linux/device/faux.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direction.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1e7c84df7252..f45a15f88e25 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -28,6 +28,7 @@
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
+#include "scatterlist.c"
 #include "security.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
new file mode 100644
index 000000000000..3c8015b07da1
--- /dev/null
+++ b/rust/helpers/scatterlist.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-direction.h>
+
+void rust_helper_sg_set_page(struct scatterlist *sg, struct page *page,
+			     unsigned int len, unsigned int offset)
+{
+	return sg_set_page(sg, page, len, offset);
+}
+
+dma_addr_t rust_helper_sg_dma_address(struct scatterlist *sg)
+{
+	return sg_dma_address(sg);
+}
+
+unsigned int rust_helper_sg_dma_len(struct scatterlist *sg)
+{
+	return sg_dma_len(sg);
+}
+
+void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *sgt,
+				   enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_sgtable(dev, sgt, dir, attrs);
+}
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 605e01e35715..2866345d22fc 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -102,6 +102,23 @@ pub mod attrs {
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
 
+/// DMA mapping direction.
+///
+/// Corresponds to the kernel's [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub enum DmaDataDirection {
+    /// Direction isn't known.
+    DmaBidirectional = bindings::dma_data_direction_DMA_BIDIRECTIONAL as _,
+    /// Data is going from the memory to the device.
+    DmaToDevice = bindings::dma_data_direction_DMA_TO_DEVICE as _,
+    /// Data is coming from the device to the memory.
+    DmaFromDevice = bindings::dma_data_direction_DMA_FROM_DEVICE as _,
+    /// No direction (used for debugging).
+    DmaNone = bindings::dma_data_direction_DMA_NONE as _,
+}
+
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..0a4f270e9a0d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -73,6 +73,7 @@
 pub mod print;
 pub mod rbtree;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..46cc04a87b2f
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist
+//!
+//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
+
+use crate::{
+    bindings,
+    device::{Bound, Device},
+    dma::DmaDataDirection,
+    error::{Error, Result},
+    page::Page,
+    types::{ARef, Opaque},
+};
+use core::marker::PhantomData;
+use core::ops::{Deref, DerefMut};
+
+/// Marker trait for the mapping state of the `SGTable`
+pub trait MapState: private::Sealed {}
+
+/// The [`Unmapped`] state of the `SGTable` is the table's initial state. While in this state, the pages of
+/// the `SGTable` can be built by the CPU.
+pub struct Unmapped;
+
+/// The [`Initialized`] state of the `SGTable` means that the table's span of pages has already been built.
+pub struct Initialized;
+
+/// The [`Mapped`] state of the `SGTable` means that it is now mapped via DMA. While in this state
+/// modification of the pages by the CPU is disallowed. This state will expose an interface to query
+/// the DMA address of the entries.
+pub struct Mapped;
+
+mod private {
+    pub trait Sealed {}
+
+    impl Sealed for super::Mapped {}
+    impl Sealed for super::Initialized {}
+    impl Sealed for super::Unmapped {}
+}
+
+impl MapState for Unmapped {}
+impl MapState for Initialized {}
+impl MapState for Mapped {}
+
+/// A single scatter-gather entry, representing a span of pages in the device's DMA address space.
+///
+/// # Invariants
+///
+/// The `scatterlist` pointer is valid for the lifetime of an SGEntry instance.
+#[repr(transparent)]
+pub struct SGEntry<T: MapState = Unmapped>(Opaque<bindings::scatterlist>, PhantomData<T>);
+
+impl<T: MapState> SGEntry<T> {
+    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
+    /// of the returned reference.
+    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
+        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Convert a raw `struct scatterlist *` to a `&'a mut SGEntry`.
+    ///
+    /// # Safety
+    ///
+    /// See safety requirements of [`SGEntry::as_ref`]. In addition, callers must ensure that only
+    /// a single mutable reference can be taken from the same raw pointer, i.e. for the lifetime of the
+    /// returned reference, no other call to this function on the same `struct scatterlist *` should
+    /// be permitted.
+    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut Self {
+        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Obtain the raw `struct scatterlist *`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::scatterlist {
+        self.0.get()
+    }
+}
+
+impl SGEntry<Mapped> {
+    /// Returns the DMA address of this SG entry.
+    pub fn dma_address(&self) -> bindings::dma_addr_t {
+        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
+        unsafe { bindings::sg_dma_address(self.0.get()) }
+    }
+
+    /// Returns the length of this SG entry.
+    pub fn dma_len(&self) -> u32 {
+        // SAFETY: By the type invariant of `SGEntry`, ptr is valid.
+        unsafe { bindings::sg_dma_len(self.0.get()) }
+    }
+}
+
+impl SGEntry<Unmapped> {
+    /// Set this entry to point at a given page.
+    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
+        let c: *mut bindings::scatterlist = self.0.get();
+        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
+        // `Page` invariant also ensures the pointer is valid.
+        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
+    }
+}
+
+/// A scatter-gather table of DMA address spans.
+///
+/// This structure represents the Rust abstraction for a C `struct sg_table`. This implementation
+/// is able to abstract the usage of an already existing C `struct sg_table`. A new table can be
+/// allocated by calling [`SGTable::alloc_table`].
+///
+/// # Invariants
+///
+/// The `sg_table` pointer is valid for the lifetime of an SGTable instance.
+#[repr(transparent)]
+pub struct SGTable<T: MapState = Unmapped>(Opaque<bindings::sg_table>, PhantomData<T>);
+
+impl<T: MapState> SGTable<T> {
+    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct sg_table` pointed to by `ptr` is valid for the lifetime
+    /// of the returned reference.
+    #[allow(unused)]
+    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Convert a raw `struct sg_table *` to a `&'a mut SGTable`.
+    ///
+    /// # Safety
+    ///
+    /// See safety requirements of [`SGTable::as_ref`]. In addition, callers must ensure that only
+    /// a single mutable reference can be taken from the same raw pointer, i.e. for the lifetime of the
+    /// returned reference, no other call to this function on the same `struct sg_table *` should
+    /// be permitted.
+    #[allow(unused)]
+    pub(crate) unsafe fn as_mut<'a>(ptr: *mut bindings::sg_table) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Obtain the raw `struct sg_table *`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::sg_table {
+        self.0.get()
+    }
+
+    fn take_sgt(&mut self) -> Opaque<bindings::sg_table> {
+        let sgt: bindings::sg_table = Default::default();
+        let sgt: Opaque<bindings::sg_table> = Opaque::new(sgt);
+        core::mem::replace(&mut self.0, sgt)
+    }
+}
+
+impl SGTable<Unmapped> {
+    /// Allocate and construct a new scatter-gather table.
+    pub fn alloc_table(nents: usize, flags: kernel::alloc::Flags) -> Result<Self> {
+        let sgt: Opaque<bindings::sg_table> = Opaque::uninit();
+
+        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
+        let ret = unsafe { bindings::sg_alloc_table(sgt.get(), nents as _, flags.as_raw()) };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+        Ok(Self(sgt, PhantomData))
+    }
+
+    /// The scatter-gather table page initializer.
+    ///
+    /// Runs a piece of code that initializes the pages of the scatter-gather table. This call transitions
+    /// to and returns a `SGTable<Initialized>` object which can then be later mapped via DMA.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{device::Device, scatterlist::*, page::*};
+    ///
+    /// let sgt = SGTable::alloc_table(4, GFP_KERNEL)?;
+    /// let sgt = sgt.init(|iter| {
+    ///     for sg in iter {
+    ///         sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0);
+    ///     }
+    ///     Ok(())
+    /// })?;
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn init(
+        mut self,
+        f: impl FnOnce(SGTableIterMut<'_>) -> Result,
+    ) -> Result<SGTable<Initialized>> {
+        f(self.iter())?;
+        let sgt = self.take_sgt();
+        core::mem::forget(self);
+        Ok(SGTable(sgt, PhantomData))
+    }
+
+    fn iter(&mut self) -> SGTableIterMut<'_> {
+        SGTableIterMut {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`. This call
+            // is in a private function which is allowed to be called only within the state transition
+            // function [`SGTable<Unmapped>::init`] ensuring that the mutable reference can only be
+            // obtained once for this object.
+            pos: Some(unsafe { SGEntry::<Unmapped>::as_mut((*self.0.get()).sgl) }),
+        }
+    }
+}
+
+impl SGTable<Initialized> {
+    /// Map this scatter-gather table describing a buffer for DMA by the `Device`.
+    ///
+    /// This call transitions to and returns a `DeviceSGTable` object.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::{device::{Bound, Device}, scatterlist::*};
+    ///
+    /// # fn test(dev: &Device<Bound>, sgt: SGTable<Initialized>) -> Result {
+    /// let sgt = sgt.dma_map(dev, kernel::dma::DmaDataDirection::DmaToDevice)?;
+    /// for sg in sgt.iter() {
+    ///     let _addr = sg.dma_address();
+    ///     let _len = sg.dma_len();
+    /// }
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn dma_map(mut self, dev: &Device<Bound>, dir: DmaDataDirection) -> Result<DeviceSGTable> {
+        // SAFETY: Invariants on `Device` and `SGTable` ensures that the pointers are valid.
+        let ret = unsafe {
+            bindings::dma_map_sgtable(
+                dev.as_raw(),
+                self.as_raw(),
+                dir as _,
+                bindings::DMA_ATTR_NO_WARN as _,
+            )
+        };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+        let sgt = self.take_sgt();
+        core::mem::forget(self);
+        Ok(DeviceSGTable {
+            sg: SGTable(sgt, PhantomData),
+            dir,
+            dev: dev.into(),
+        })
+    }
+}
+
+impl SGTable<Mapped> {
+    /// Returns an immutable iterator over the scather-gather table that is mapped for DMA.
+    pub fn iter(&self) -> SGTableIter<'_> {
+        SGTableIter {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
+            pos: Some(unsafe { SGEntry::<Mapped>::as_ref((*self.0.get()).sgl) }),
+        }
+    }
+}
+
+/// A scatter-gather table that is mapped for DMA operation.
+pub struct DeviceSGTable {
+    sg: SGTable<Mapped>,
+    dir: DmaDataDirection,
+    dev: ARef<Device>,
+}
+
+impl Drop for DeviceSGTable {
+    fn drop(&mut self) {
+        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures that the `self.dev` and `self.sg`
+        // pointers are valid.
+        unsafe {
+            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sg.as_raw(), self.dir as _, 0)
+        };
+    }
+}
+
+// TODO: Implement these as macros for objects that want to derive from `SGTable`.
+impl Deref for DeviceSGTable {
+    type Target = SGTable<Mapped>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.sg
+    }
+}
+
+impl DerefMut for DeviceSGTable {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.sg
+    }
+}
+
+/// SAFETY: A `SGTable<Mapped>` is an immutable interface and should be safe to `Send` across threads.
+unsafe impl Send for SGTable<Mapped> {}
+
+/// A mutable iterator through `SGTable` entries.
+pub struct SGTableIterMut<'a> {
+    pos: Option<&'a mut SGEntry<Unmapped>>,
+}
+
+impl<'a> IntoIterator for &'a mut SGTable<Unmapped> {
+    type Item = &'a mut SGEntry<Unmapped>;
+    type IntoIter = SGTableIterMut<'a>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a> Iterator for SGTableIterMut<'a> {
+    type Item = &'a mut SGEntry<Unmapped>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.pos.take().map(|entry| {
+            let sg = entry.as_raw();
+            // SAFETY: `sg` is guaranteed to be valid and non-NULL while inside this closure.
+            let next = unsafe { bindings::sg_next(sg) };
+            self.pos = (!next.is_null()).then(||
+                                              // SAFETY: `SGEntry::as_mut` is called on `next` only once,
+                                              // which is valid and non-NULL
+                                              // inside the closure.
+                                              unsafe { SGEntry::as_mut(next) });
+            // SAFETY: `SGEntry::as_mut` is called on `sg` only once, which is valid and non-NULL
+            // inside the closure.
+            unsafe { SGEntry::as_mut(sg) }
+        })
+    }
+}
+
+/// An iterator through `SGTable<Mapped>` entries.
+pub struct SGTableIter<'a> {
+    pos: Option<&'a SGEntry<Mapped>>,
+}
+
+impl<'a> IntoIterator for &'a SGTable<Mapped> {
+    type Item = &'a SGEntry<Mapped>;
+    type IntoIter = SGTableIter<'a>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a> Iterator for SGTableIter<'a> {
+    type Item = &'a SGEntry<Mapped>;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.pos.map(|entry| {
+            let sg = entry.as_raw();
+            // SAFETY: `sg` is always guaranteed to be valid and non-NULL while inside this closure.
+            let next = unsafe { bindings::sg_next(sg) };
+            self.pos = (!next.is_null()).then(||
+                                              // SAFETY: `next` is always valid and non-NULL inside
+                                              // this closure.
+                                              unsafe { SGEntry::as_ref(next) });
+            // SAFETY: `sg` is always guaranteed to be valid and non-NULL while inside this closure.
+            unsafe { SGEntry::as_ref(sg) }
+        })
+    }
+}
+
+impl<T: MapState> Drop for SGTable<T> {
+    fn drop(&mut self) {
+        // SAFETY: Invariant on `SGTable` ensures that the sg_table is valid.
+        unsafe { bindings::sg_free_table(self.as_raw()) };
+    }
+}
-- 
2.43.0

