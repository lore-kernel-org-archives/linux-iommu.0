Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0978C91
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043783; cv=none; b=lZmtKb9di208pgDK4ZWZgAaD58ieAYSFo154I3oNmRcMEsTikqgtW/gFPQZWZSgPnesdsf64eLhZcZqqEDfLAOvXAwdbpQy7wztEeLRb7k6VcYc+Mg5bFfiL6b6yCaOdzZpIdU5AJ3mxJnR5dxNKfGda6HWmHL7+Peq68cBjTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043783; c=relaxed/simple;
	bh=ejf98AvbP7eN6an6nx4oFHS9YFPFVtY+tLswFiJ3dpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBNvndfb4FhYaivUbVuOO7Ieyok/7sv5tpIkLtjwq1QruJrgSyZvqa3IYwdzQ2wNhnwzW56Hj+aG6Ywmp1otWboKR2ZnWsTgLFDNNGEDw/N3R1ZIYwUpOe9NelTa2aRikfmeB5nv883SLVv19sSAfLKHp96/wMsCf86y9+nQsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJa1egxb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJa1egxb"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so5111851e87.1
        for <iommu@lists.linux.dev>; Mon, 12 May 2025 02:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747043779; x=1747648579; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYgSrCKK+BvJRqo75FcRAGXeQz+yl7joXi6D74Qth+I=;
        b=gJa1egxbfl2xvAzQZRuIrxq5HyMsq4vBnSbZIN4GaRcVCl3kRdjGfa8oHWTEp9Drd+
         +tQmnJT1OfA/uX9r0c4StxE0Ua0v2cre0Ok7kPuc/2Meq+b87etmplRUxhhIdkXrHUfT
         lDWcNCOtPZyyaGIQIUH+CfGAGMU5efAOnosS506M9Ubwr9A1w2Lzi6ryQV9DPmMevXqM
         VC4imjIVa4VkqGCy7Tl+pAH0B5+Tz+fQMyBR0cEZXWQAQ1V78fJgD2TwN1tpVZ8bQJ90
         t55dEZT/EMED6Y1bR9OQV4E7295sSbSztBKtwlCX8IE0X9fmBS9cdKERLJKm7zz5Ae/j
         /ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747043779; x=1747648579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYgSrCKK+BvJRqo75FcRAGXeQz+yl7joXi6D74Qth+I=;
        b=LLRRXhKHVaGr0XhdFs6GtnqZfRuvyGqAeezweGfA+WJJj/Bj90ujcWILAwz5/TVCPd
         Oxwcs1vg1Y2hZ6e+g74u7K1cxOwAi43h/4qxixMdrWGUnXCYWhM4+JsnMgOZuSSiJsfN
         Hott1ewfaImvBGKyBNB4oLWdx/t5QACg2Wtiz6j3syVE1dYZCAdInPdJeeILwNv7FAHo
         98oXgMCgk7iCVoh7CBv93gbZ8uG6zMiR4b/ANcp6I+zLHHfUXgQeXlzptBMAFwuxVYC/
         HUK01fdhSHdc64AFHckyQsjyrtZp+W3ZxtkyBc7IdDpKFB8eJ9lmVlNkU/4w4qfzSe2q
         yHAA==
X-Forwarded-Encrypted: i=1; AJvYcCWph23YW1SI3BMTIKCVUZR5U6LrRHWSssaIyEa4o9GFCNODB4YSAv8Za13+/osKM5khQQxPNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhT/ajOw1T/xdCIIF9NJ44/n+ZKZr5lhW74F2gE9fVdt6Kj/gB
	RlGjW/O9j0Ce01QkHkLnnUHxN/a9z3TrrvwaYRmC8Ar4fzBeof6o
X-Gm-Gg: ASbGncu/qQvCmWJHfL2WOOgufj562qp5nRh7bRZi5o+bf3rdKoEJ43CruIamfg+qXjn
	9f1Vy7E2YtYwdC/NfYHnTQqQYYIci5/TxpotdZLJa/gqnV3KwJJCqnq+6ibQOwgiyTA73RcRtoC
	vHoCbIAflv3l7ad0Aj8KGWR/mq4ofXUBcnOuzmn/WHPOhy/BGw4tXje0zlIN9mQqCMZeH37ej4C
	cKlRlxAtrJBkMrSW/bkWRbTCXcZVmJJYFPweO6xgkNQe99Nzysq5XfkPn6/9OukoxQOmSnXx5+g
	E5TdkJJOet/dguavTRgGevttkIM6yldrTAVKvffU0pSvwj59dlGrzjxS+QLzbOldTglBgkALdwG
	AYrHdMXGiUJ8lgor3Ik7EtOu4NvQw
X-Google-Smtp-Source: AGHT+IFhCvOibD9ZqY6X3LDMCpSjyzVb+l6WNUXcenaRu0cNcqFF9Q4iteyNTmKQ6b/sQGqxI75TMg==
X-Received: by 2002:a05:6512:6612:b0:54f:c66b:8b73 with SMTP id 2adb3069b0e04-54fc67b8e96mr3944219e87.13.1747043778800;
        Mon, 12 May 2025 02:56:18 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc644fa48sm1460449e87.1.2025.05.12.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:56:18 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: dakr@kernel.org,
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
Subject: [RFC PATCH 1/2] rust: add initial scatterlist bindings
Date: Mon, 12 May 2025 12:53:27 +0300
Message-ID: <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
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
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 275 ++++++++++++++++++++++++++++++++
 5 files changed, 303 insertions(+)
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
index 000000000000..5ab0826f7c0b
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
+	return sg_dma_address(sg);
+}
+
+void rust_helper_dma_unmap_sgtable(struct device *dev, struct sg_table *sgt,
+				   enum dma_data_direction dir, unsigned long attrs)
+{
+	return dma_unmap_sgtable(dev, sgt, dir, attrs);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fa852886d4d1..a8d5fcb55388 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -87,6 +87,7 @@
 pub mod print;
 pub mod rbtree;
 pub mod revocable;
+pub mod scatterlist;
 pub mod security;
 pub mod seq_file;
 pub mod sizes;
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
new file mode 100644
index 000000000000..122a6f94bf56
--- /dev/null
+++ b/rust/kernel/scatterlist.rs
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Scatterlist
+//!
+//! C header: [`include/linux/scatterlist.h`](srctree/include/linux/scatterlist.h)
+
+use crate::{
+    bindings,
+    device::Device,
+    error::{Error, Result},
+    page::Page,
+    types::{ARef, Opaque},
+};
+use core::ops::{Deref, DerefMut};
+
+/// A single scatter-gather entry, representing a span of pages in the device's DMA address space.
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
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
+    /// of the returned reference.
+    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
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
+    unsafe fn as_mut<'a>(ptr: *mut bindings::scatterlist) -> &'a mut Self {
+        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
+        unsafe { &mut *ptr.cast() }
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
+    /// Set this entry to point at a given page.
+    pub fn set_page(&mut self, page: &Page, length: u32, offset: u32) {
+        let c: *mut bindings::scatterlist = self.0.get();
+        // SAFETY: according to the `SGEntry` invariant, the scatterlist pointer is valid.
+        // `Page` invariant also ensure the pointer is valid.
+        unsafe { bindings::sg_set_page(c, page.as_ptr(), length, offset) };
+    }
+
+    /// Obtain the raw `struct scatterlist *`.
+    pub fn as_raw(&self) -> *mut bindings::scatterlist {
+        self.0.get()
+    }
+}
+
+/// DMA mapping direction.
+///
+/// Corresponds to the kernel's [`enum dma_data_direction`].
+///
+/// [`enum dma_data_direction`]: srctree/include/linux/dma-direction.h
+#[derive(Copy, Clone, PartialEq, Eq)]
+#[repr(u32)]
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
+/// The base interface for a scatter-gather table of DMA address spans.
+///
+/// This structure represents the Rust abstraction for a C `struct sg_table`. This implementation
+/// abstracts the usage of an already existing C `struct sg_table` within Rust code that we get
+/// passed from the C side.
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
+    /// # Safety
+    ///
+    /// Callers must ensure that the `struct sg_table` pointed to by `ptr` is initialized and valid for
+    /// the lifetime of the returned reference.
+    pub unsafe fn as_ref<'a>(ptr: *mut bindings::sg_table) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Obtain the raw `struct sg_table *`.
+    pub fn as_raw(&self) -> *mut bindings::sg_table {
+        self.0.get()
+    }
+
+    /// Returns a mutable iterator over the scather-gather table.
+    pub fn iter_mut(&mut self) -> SGTableIterMut<'_> {
+        SGTableIterMut {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
+            pos: Some(unsafe { SGEntry::as_mut((*self.0.get()).sgl) }),
+        }
+    }
+
+    /// Returns an iterator over the scather-gather table.
+    pub fn iter(&self) -> SGTableIter<'_> {
+        SGTableIter {
+            // SAFETY: dereferenced pointer is valid due to the type invariants on `SGTable`.
+            pos: Some(unsafe { SGEntry::as_ref((*self.0.get()).sgl) }),
+        }
+    }
+}
+
+/// SAFETY: The `SGTable` should be `Send` across threads.
+unsafe impl Send for SGTable {}
+
+/// A mutable iterator through `SGTable` entries.
+pub struct SGTableIterMut<'a> {
+    pos: Option<&'a mut SGEntry>,
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
+impl<'a> Iterator for SGTableIterMut<'a> {
+    type Item = &'a mut SGEntry;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.pos.take().map(|entry| {
+            let sg = entry.as_raw();
+            // SAFETY: `sg` is guaranteed to be valid and non-NULL while inside this closure. The calls
+            // to `SGEntry::as_mut` are unique for each scatterlist entry object as well.
+            unsafe {
+                let next = bindings::sg_next(sg);
+                self.pos = (!next.is_null()).then(|| SGEntry::as_mut(next));
+                SGEntry::as_mut(sg)
+            }
+        })
+    }
+}
+
+/// An iterator through `SGTable` entries.
+pub struct SGTableIter<'a> {
+    pos: Option<&'a SGEntry>,
+}
+
+impl<'a> IntoIterator for &'a SGTable {
+    type Item = &'a SGEntry;
+    type IntoIter = SGTableIter<'a>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a> Iterator for SGTableIter<'a> {
+    type Item = &'a SGEntry;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.pos.map(|entry| {
+            let sg = entry.as_raw();
+            // SAFETY: `sg` is guaranteed to be valid and non-NULL while inside this closure.
+            unsafe {
+                let next = bindings::sg_next(sg);
+                self.pos = (!next.is_null()).then(|| SGEntry::as_ref(next));
+                SGEntry::as_ref(sg)
+            }
+        })
+    }
+}
+
+/// A scatter-gather table that owns the allocation and can be mapped for DMA operation using `Device`.
+pub struct DeviceSGTable {
+    sg: SGTable,
+    dir: DmaDataDirection,
+    dev: ARef<Device>,
+}
+
+impl DeviceSGTable {
+    /// Allocate and construct the scatter-gather table.
+    pub fn alloc_table(dev: &Device, nents: usize, flags: kernel::alloc::Flags) -> Result<Self> {
+        let sgt: Opaque<bindings::sg_table> = Opaque::uninit();
+
+        // SAFETY: The sgt pointer is from the Opaque-wrapped `sg_table` object hence is valid.
+        let ret = unsafe { bindings::sg_alloc_table(sgt.get(), nents as _, flags.as_raw()) };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+
+        Ok(Self {
+            sg: SGTable(sgt),
+            dir: DmaDataDirection::DmaNone,
+            dev: dev.into(),
+        })
+    }
+
+    /// Map this scatter-gather table describing a buffer for DMA.
+    pub fn dma_map(&mut self, dir: DmaDataDirection) -> Result {
+        // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
+        // pointers are valid.
+        let ret = unsafe {
+            bindings::dma_map_sgtable(
+                self.dev.as_raw(),
+                self.sg.as_raw(),
+                dir as _,
+                bindings::DMA_ATTR_NO_WARN as _,
+            )
+        };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+        self.dir = dir;
+        Ok(())
+    }
+}
+
+// TODO: Implement these as macros for objects that want to derive from `SGTable`.
+impl Deref for DeviceSGTable {
+    type Target = SGTable;
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
+impl Drop for DeviceSGTable {
+    fn drop(&mut self) {
+        if self.dir != DmaDataDirection::DmaNone {
+            // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
+            // pointers are valid.
+            unsafe {
+                bindings::dma_unmap_sgtable(self.dev.as_raw(), self.sg.as_raw(), self.dir as _, 0)
+            };
+        }
+        // SAFETY: Invariant on `SGTable` ensures that the `self.sg` pointer is valid.
+        unsafe { bindings::sg_free_table(self.sg.as_raw()) };
+    }
+}
-- 
2.43.0

