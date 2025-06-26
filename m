Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B72F0E2A
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969982; cv=none; b=FfdY4B9A2/KHilMcLRawykxNPrOSWn4ht7LOm5k6QnkPcNQRhkY8/KfY0Q80cxnMzyIiGwXgeuQjl2C+peUH+inROwUhhv7cvqGRS5as4/kSfX8FOCFlOUqQ6021bCv+O4jKmuoO9Acmbg4ONLE9y23ZOvMsKSaytDVmd5uXNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969982; c=relaxed/simple;
	bh=8xUOfh/4Fu5s3CdeVKLm9m+W8+aFQ+cow7IviBIUDhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaWY0WZpMiyh5eV0ZEFV2atZtVlUK6fYDEzyQcQ8db/lsyIywNKnSAKUwJW8zqOjwCln0Gnwz91oLx1V1e1ToZ66hk2sRb2tPNnli3i1DalFG9KhfobuDepAqJPMxQ3UsuFKNfaeBDhXl3s9VvS8LTpmfpj6zLUTrT9Mrc3nxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNjAHi9m; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNjAHi9m"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553b60de463so1611695e87.3
        for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750969976; x=1751574776; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfnquTdHgsXV8LB7mDxET1RjxHmMIAq9AbOuHXvosjE=;
        b=nNjAHi9mwuFcgCaZLXp29lQh7Zu4aZia2minpkHZQROvBS0UQUWeLoBNrUna+0JOTJ
         K4YXp+NpvYX3QbPu+9JT1bUUYmYt9olSyiY2LegIgCgOuXzQUKTbhYeY2bP8ipQZVhkj
         BrD+PeDu5EywMtoLUT3/ZQL6lqVxZP17EpOHxvO1qGdCseL8PzwRzsSjyOkqvkPMhkh7
         UcTGawPb44df0OU+bRDnkbNTFRAh8bzXNvGtn6WEt/rnmNCJbQDkW44nmnfPo3VKXCDZ
         4bVXj9x2zSCpdHvWCw/VseUBYUiZaaE3Pzy/HjlSaWwWG5lsAHdKIM9vWwl2pmfv53if
         oZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750969976; x=1751574776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfnquTdHgsXV8LB7mDxET1RjxHmMIAq9AbOuHXvosjE=;
        b=b+cBv+FSSgv6fr3WhBB5LjIWO5W3uhjs9LPNFbjASwxHNKT6pQkp++4esZcdRmkaYg
         WXorp4Z0ySe9HvvWfjc+2F5AgeAjZ6k8DZZpgGIVlLINty04C6k/r8jKgGHtewFDbg90
         bvXBBEEg5wv7IWck43hX7zBDT6Dc8EY1b1Tc/Y85E8x3oIh/0+WFKfRP3JX+vOJxiSKs
         UTBmVYBbNcNMwt2mmDLEe9seiNa/jIAhkEW8afYkKwwFPcApVTh/jdOiep5mAmDndCID
         lpKa5WT02xcAj+hS6A2YENtL6UcQQ1pQ9kXGe6d9u9UgWfg6VGTBRp1FvN3iYgNUI9Gw
         jZpg==
X-Forwarded-Encrypted: i=1; AJvYcCWQedDpevnvOKw78FfZP2rPODgjVBKSSuZrLxg3LFadoMLtND6F9uqmIAUKw05hH7X2SJhlew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ91c09ChUwCk7WuENB+yhSor7MPaZIoGS/xBtc3zT4Xud7SCP
	QBX6WNyN8F63tWK5mZBjeD05uspBuhJrlp6/k8qDV20/iSqI4CWUiGnp
X-Gm-Gg: ASbGncsGdmfF2lCm8AMbfr4thqYWMYhqgJn3BMGv47fMkkS9TMgyePi7rGlDN3UzLBn
	ko6qXZjY427zmRWlQqjJ140jr3fxexjdWWV5c4FHYtX3iPngLSuDWmphX8j8dcWVWrKPhcLORKY
	XbgTTQDlr2ACe8zCLxI2ZWMyXaL6NwfnIXzKjLp8JqhscYLwApn75Yxs/R2VGBTOszPNEHeIkVk
	aJ+4wwoC9NTC1o+RpTP1zQFQeb6px+dfAuvJ0gXyMwZ3rxX2hTBZEOXN2LA2rdk14VHXqgnvaGA
	dKrgCU+hVsMkbb8JsBZRq8p05yu7NYzdO3c9KTWVK9O8wSM5gWwXTBPOTds9Q0LV55owiyXZqz9
	umj95yPP9SWtooUEznBfYL5SFoskrMY+K4+azkBA=
X-Google-Smtp-Source: AGHT+IFDP091+HfG5u17uM62+CAEYK26ItA4vJwHnwKGNP5C5t3jt3YxLSgVVUmsKfwNttr/PGg2fg==
X-Received: by 2002:a05:6512:12d1:b0:553:2e27:6769 with SMTP id 2adb3069b0e04-5550b82a76cmr258239e87.7.1750969976005;
        Thu, 26 Jun 2025 13:32:56 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2401f7sm142363e87.30.2025.06.26.13.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:32:54 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	jgg@ziepe.ca,
	lyude@redhat.com,
	dakr@kernel.org
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
Subject: [PATCH v2 1/2] rust: add initial scatterlist bindings
Date: Thu, 26 Jun 2025 23:30:07 +0300
Message-ID: <20250626203247.816273-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
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
 rust/helpers/scatterlist.c      |  30 +++
 rust/kernel/dma.rs              |  18 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 390 ++++++++++++++++++++++++++++++++
 6 files changed, 441 insertions(+)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 8cbb660e2ec2..e1e289284ce8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -47,6 +47,7 @@
 #include <linux/cred.h>
 #include <linux/device/faux.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direction.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index b15b3cddad4e..199a83ff3583 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -35,6 +35,7 @@
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
+#include "scatterlist.c"
 #include "security.c"
 #include "signal.c"
 #include "slab.c"
diff --git a/rust/helpers/scatterlist.c b/rust/helpers/scatterlist.c
new file mode 100644
index 000000000000..c871de853539
--- /dev/null
+++ b/rust/helpers/scatterlist.c
@@ -0,0 +1,30 @@
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
+struct scatterlist *rust_helper_sg_next(struct scatterlist *sg)
+{
+	return sg_next(sg);
+}
+
+void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *sgt,
+				   enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_sgtable(dev, sgt, dir, attrs);
+}
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8e317005decd..b44c84928f1a 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -102,6 +102,24 @@ pub mod attrs {
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
 
+/// DMA mapping direction.
+///
+/// Corresponds to the kernel's [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[repr(i32)]
+#[derive(Copy, Clone, PartialEq, Eq)]
+pub enum DmaDataDirection {
+    /// Direction isn't known.
+    DmaBidirectional = bindings::dma_data_direction_DMA_BIDIRECTIONAL,
+    /// Data is going from the memory to the device.
+    DmaToDevice = bindings::dma_data_direction_DMA_TO_DEVICE,
+    /// Data is coming from the device to the memory.
+    DmaFromDevice = bindings::dma_data_direction_DMA_FROM_DEVICE,
+    /// No direction (used for debugging).
+    DmaNone = bindings::dma_data_direction_DMA_NONE,
+}
+
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c3..476c4a3de9c6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -101,6 +101,7 @@
 pub mod print;
 pub mod rbtree;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..2e17a56ea7c7
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,390 @@
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
+
+/// A single scatter-gather entry, representing a span of pages in the device's DMA address space.
+///
+/// This interface is accessible only via the `SGTable` iterators. When using the API safely, certain
+/// methods are only available depending on a specific state of operation of the scatter-gather table,
+/// i.e. setting page entries is done internally only during construction while retrieving the DMA address
+/// is only possible when the `SGTable` is already mapped for DMA via a device.
+///
+/// # Invariants
+///
+/// The `scatterlist` pointer is valid for the lifetime of an SGEntry instance.
+#[repr(transparent)]
+pub struct SGEntry(Opaque<bindings::scatterlist>);
+
+impl SGEntry {
+    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
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
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
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
+
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
+
+    /// Internal constructor helper to set this entry to point at a given page. Not to be used directly.
+    fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
+        let c: *mut bindings::scatterlist = self.0.get();
+        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
+        // `Page` invariant also ensure the pointer is valid.
+        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
+    }
+}
+
+/// A scatter-gather table of DMA address spans.
+///
+/// This structure represents the Rust abstraction for a C `struct sg_table`. This implementation
+/// abstracts the usage of an already existing C `struct sg_table` within Rust code that we get
+/// passed from the C side.
+///
+/// Note that constructing a new scatter-gather object using [`SGTable::alloc_table`] enforces safe
+/// and proper use of the API.
+///
+/// # Invariants
+///
+/// The `sg_table` pointer is valid for the lifetime of an SGTable instance.
+#[repr(transparent)]
+pub struct SGTable(Opaque<bindings::sg_table>);
+
+impl SGTable {
+    /// Convert a raw `struct sg_table *` to a `&'a SGTable`.
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct sg_table` pointed to by `ptr` is initialized and valid for
+    /// the lifetime of the returned reference.
+    #[allow(unused)]
+    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Convert a raw `struct sg_table *` to a `&'a mut SGTable`.
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
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
+    /// Allocate and build a new scatter-gather table from an existing list of `pages`. This method
+    /// moves the ownership of `pages` to the table.
+    ///
+    /// To build a scatter-gather table, provide the `pages` object which must implement the
+    /// `SGTablePages` trait.
+    ///
+    ///# Examples
+    ///
+    /// ```
+    /// use kernel::{device::Device, scatterlist::*, page::*, prelude::*};
+    ///
+    /// struct PagesArray(KVec<Page>);
+    /// impl SGTablePages for PagesArray {
+    ///     fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)> {
+    ///         self.0.iter().map(|page| (page, kernel::page::PAGE_SIZE, 0))
+    ///     }
+    ///
+    ///     fn entries(&self) -> usize {
+    ///         self.0.len()
+    ///     }
+    /// }
+    ///
+    /// let mut pages = KVec::new();
+    /// let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
+    /// let _ = pages.push(Page::alloc_page(GFP_KERNEL)?, GFP_KERNEL);
+    /// let sgt = SGTable::alloc_table(PagesArray(pages), GFP_KERNEL)?;
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn alloc_table<P: SGTablePages>(
+        pages: P,
+        flags: kernel::alloc::Flags,
+    ) -> Result<SGTablePageList<P>> {
+        let sgt: Opaque<bindings::sg_table> = Opaque::uninit();
+
+        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
+        let ret =
+            unsafe { bindings::sg_alloc_table(sgt.get(), pages.entries() as u32, flags.as_raw()) };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+        let mut sgtable = Self(sgt);
+        let sgentries = sgtable.iter_mut().zip(pages.iter());
+        for entry in sgentries {
+            let page = entry.1;
+            entry.0.set_page(page.0, page.1 as u32, page.2 as u32)
+        }
+
+        // INVARIANT: We just successfully allocated and built the table from the page entries.
+        Ok(SGTablePageList { sg: sgtable, pages })
+    }
+
+    /// Map this scatter-gather table describing a buffer for DMA by the `Device`.
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
+    /// See also the safe version [`SGTablePageList::dma_map`] which enforces the safety requirements below.
+    ///
+    /// # Safety
+    ///
+    /// * The caller takes responsibility that the sg entries in the scatter-gather table object are
+    ///   already populated beforehand.
+    /// * The caller takes responsibility that the table does not get mapped more than once to prevent UB.
+    pub(crate) unsafe fn dma_map_raw(&self, dev: &Device<Bound>, dir: DmaDataDirection) -> Result {
+        // SAFETY: Invariants on `Device` and `SGTable` ensures that the pointers are valid.
+        let ret = unsafe {
+            bindings::dma_map_sgtable(
+                dev.as_raw(),
+                self.as_raw(),
+                dir as i32,
+                bindings::DMA_ATTR_NO_WARN as usize,
+            )
+        };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+        Ok(())
+    }
+
+    /// Returns an immutable iterator over the scatter-gather table that is mapped for DMA. The iterator
+    /// serves as an interface to retrieve the DMA address of the entries
+    ///
+    /// This is meant as a helper for other kernel subsystems and not to be used by device drivers directly.
+    /// See also the safe version [`DeviceSGTable::iter`] which enforces the safety requirement below.
+    ///
+    /// # Safety
+    ///
+    /// Callers take responsibility that `self` is already mapped for DMA by a device.
+    pub(crate) unsafe fn iter_raw(&self) -> SGTableIter<'_> {
+        SGTableIter {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
+            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) }),
+        }
+    }
+
+    /// Internal helper to create a mutable iterator for the constructor when building the table. Not
+    /// to be used directly.
+    fn iter_mut(&mut self) -> SGTableIterMut<'_> {
+        SGTableIterMut {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`. This call
+            // is within a private method called only within the `[SGTable::alloc_table]` constructor
+            // ensuring that the mutable reference can only be obtained once for this object.
+            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) }),
+        }
+    }
+}
+
+/// Provides a list of pages that can be used to build a `SGTable`.
+pub trait SGTablePages {
+    /// Returns an iterator to the pages providing the backing memory of `self`.
+    ///
+    /// Implementers should return an iterator which provides information regarding each page entry to
+    /// build the `SGTable`. The first element in the tuple is a reference to the Page, the second element
+    /// as the offset into the page, and the third as the length of data. The fields correspond to the
+    /// first three fields of the C `struct scatterlist`.
+    fn iter<'a>(&'a self) -> impl Iterator<Item = (&'a Page, usize, usize)>;
+
+    /// Returns the number of pages in the list.
+    fn entries(&self) -> usize;
+}
+
+/// A scatter-gather table that owns the page entries.
+///
+/// # Invariants
+///
+/// The scatter-gather table is valid and initialized with sg entries.
+pub struct SGTablePageList<P: SGTablePages> {
+    sg: SGTable,
+    pages: P,
+}
+
+impl<P: SGTablePages> SGTablePageList<P> {
+    /// Map this scatter-gather table describing a buffer for DMA by the `Device`.
+    ///
+    /// To prevent the table from being mapped more than once, this call consumes `self` and transfers
+    /// ownership of resources to the new `DeviceSGTable` object.
+    pub fn dma_map(self, dev: &Device<Bound>, dir: DmaDataDirection) -> Result<DeviceSGTable<P>> {
+        // SAFETY: By the type invariant, `self.sg` is already built with valid sg entries. Since we are
+        // in a method that consumes self, it also ensures that dma_map_raw is only called once for
+        // this `SGTable`.
+        unsafe {
+            self.sg.dma_map_raw(dev, dir)?;
+        }
+
+        // INVARIANT: We just successfully mapped the table for DMA.
+        Ok(DeviceSGTable {
+            sg: self.sg,
+            dir,
+            dev: dev.into(),
+            _pages: self.pages,
+        })
+    }
+}
+
+/// A scatter-gather table that is mapped for DMA operation.
+///
+/// # Invariants
+///
+/// The scatter-gather table is mapped for DMA operation.
+pub struct DeviceSGTable<P: SGTablePages> {
+    sg: SGTable,
+    dir: DmaDataDirection,
+    dev: ARef<Device>,
+    _pages: P,
+}
+
+impl<P: SGTablePages> DeviceSGTable<P> {
+    /// Returns an immutable iterator over the scather-gather table that is mapped for DMA. The iterator
+    /// serves as an interface to retrieve the DMA address of the entries
+    pub fn iter(&self) -> SGTableIter<'_> {
+        // SAFETY: By the type invariant, `self.sg` is already mapped for DMA.
+        unsafe { self.sg.iter_raw() }
+    }
+}
+
+impl<P: SGTablePages> Drop for DeviceSGTable<P> {
+    fn drop(&mut self) {
+        // SAFETY: Invariants on `Device<Bound>` and `SGTable` ensures that the `self.dev` and `self.sg`
+        // pointers are valid.
+        unsafe {
+            bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sg.as_raw(), self.dir as i32, 0)
+        };
+    }
+}
+
+/// SAFETY: A `SGTable<Mapped>` is an immutable interface and should be safe to `Send` across threads.
+unsafe impl Send for SGTable {}
+
+/// A mutable iterator through `SGTable` entries.
+pub struct SGTableIterMut<'a> {
+    pos: Option<&'a mut SGEntry>,
+}
+
+impl<'a> Iterator for SGTableIterMut<'a> {
+    type Item = &'a mut SGEntry;
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
+impl<'a> IntoIterator for &'a mut SGTable {
+    type Item = &'a mut SGEntry;
+    type IntoIter = SGTableIterMut<'a>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// An iterator through `SGTable` entries.
+pub struct SGTableIter<'a> {
+    pos: Option<&'a SGEntry>,
+}
+
+impl<'a> Iterator for SGTableIter<'a> {
+    type Item = &'a SGEntry;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        let entry = self.pos;
+        // SAFETY: `sg` is an immutable reference and is equivalent to `scatterlist` via its type
+        // invariants, so its safe to use with sg_next.
+        let next = unsafe { bindings::sg_next(self.pos?.as_raw()) };
+
+        // SAFETY: `sg_next` returns either a valid pointer to a `scatterlist`, or null if we
+        // are at the end of the scatterlist.
+        self.pos = (!next.is_null()).then(|| unsafe { SGEntry::as_ref(next) });
+        entry
+    }
+}
+
+impl<'a, P: SGTablePages> IntoIterator for &'a DeviceSGTable<P> {
+    type Item = &'a SGEntry;
+    type IntoIter = SGTableIter<'a>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl Drop for SGTable {
+    fn drop(&mut self) {
+        // SAFETY: Invariant on `SGTable` ensures that the sg_table is valid.
+        unsafe { bindings::sg_free_table(self.as_raw()) };
+    }
+}
-- 
2.43.0

