Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77C30101E
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942513; cv=none; b=mzzF1AQqOIbcpIS+FzOJHrnL8jxSk9UlZ8Rh/TvtboPWIMpEH7vYqBW+Wh57zxePN0Ure43tnGUDCf/vBN/zy5VO/hOqbE6Bj8skAELKtlGVz81ZQqcacZpjbtJvO/j/VRg+Toq5+BRx2KU0z3ExJ3Q7bfSphaq0OC7Z2V2sCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942513; c=relaxed/simple;
	bh=o9+xpW4uPh8uhRYnWukE8UfaplpoEAJ9o211/Bb8GT8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X8KrR88cmEGKo2QMajiTqABZlJf6KimAXZ1TP3XtIv+acJ1UnoUMTdozWkSExgHN/1ldkeJL7wR37NbCxmIaGhqEJ9M+fnPMhzE9xBtWPQyksjlXOyhq2US7g1KurAPZBYBFXwl32e2g6QzRU9D581WLfocW9qo4GLFsrUWmgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uB5D9xu9; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uB5D9xu9"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-64095177aedso1054517a12.2
        for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 02:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762942509; x=1763547309; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=73I2FUGpROBWvvc1rEHs+Shl3zJLhmBgQPZT0bfkTyg=;
        b=uB5D9xu9DpvhampbtJR31EEXGK5L9pr2TKaGUoITjOOluBmwnu909V5Sm/N+OOhoAL
         yoVN95BaojM/BkgmYJJlrnl6BrEaMqZQxBDl+kjT8UD0MFSu2tXw6Q/053Jvi1fnsGSK
         FYNurXFc/+U1om9Tc8PgtrdfNAYHokdzdxVp3Hxo+p9wUTd0dzsiandIu3CPpzsBitMb
         bsV1ouAJ/YawSId1Dp2isBhdl4Ngpr104I37SVX8NVKbVlaVScXdvUUyWGp7pyMoVPVE
         JD2X7nBZUXVRvEC0WKFwyn//l9qk41BOFyde8KIoaIIfdQpZXaqF1+xCxgTpDu7scqM7
         Jvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942509; x=1763547309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73I2FUGpROBWvvc1rEHs+Shl3zJLhmBgQPZT0bfkTyg=;
        b=lAGu/RNAySxT7F/w9oIy+3iZ46THltCNz33/EHUgC8EfO01NEIYzVrP4m4hDOp64gM
         gFeHsff1oKux+f8NXXVP7wUNOtvXfykb5PEJ5vKadmkU6Cp/9LoBgnkKvWHRkk4e+/FT
         xOmgKIo+u9zmqaNEWvMAoAC7V7gBxDqmLQN8ur3wtOnaB5rdsu6jgTVmVUes09i9Ffpn
         LX8O/YKhUzNvKx9DCrblmLebO82fbuH1RjTAyUO+mhKR5Dbwwo/6G6NwPiJOvdqrSrzx
         YNbflZqfSbq9VlZHwpbs+RHwPK63rmlgwWUdy4nPC6e/wcgY8NRVICrLy+aDfJC75di2
         wd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIfYccv8rx+PnT0kHqCXIcd3LZRzE97mRNg5Lwmq6pa4lVfNrpwRaMO8Qvu/bKpPJkIsuXhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsH0Q9QO3B10k/52yim5+mhg2iH/3ioPc9w5tnX1fL9yZOwJoY
	0lfnMIaLZl4t/wCHRV32cSEJmlfevWmGyUrDqNAFk9a2lEXYOQPjvd67k8/CFI1ln49oJ15fvrB
	96Cc8hAaaUAo0h5HVzQ==
X-Google-Smtp-Source: AGHT+IFqKjM6hhCMFPCGk+2Jpbz5Hm1iHGXFKauxgdFMLZ34a2nCz7aZdsSy/MowpmbykFK42/F+adtGbWZpHz8=
X-Received: from edg25.prod.google.com ([2002:a05:6402:23d9:b0:641:85b3:f437])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:26d1:b0:640:fa38:7e4a with SMTP id 4fb4d7f45d1cf-6431a49a8cemr2140719a12.8.1762942508817;
 Wed, 12 Nov 2025 02:15:08 -0800 (PST)
Date: Wed, 12 Nov 2025 10:15:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACNeFGkC/0XMTQ6DIBCG4asQ1p1Gx/pTrtK4EBiVpAoFNDXGu
 5fWRWf3TvI9Ow/kDQUu2M49rSYYO6coLoyrsZsHAqNTc8ywzNOBseCG2MknQU9ZgyhvJLXmaeA
 89eb9wx7t2Z5eSzLj+fyTgp1gVoGnYBevCNy4BYibI019gErLor5jrfPyLlb8+rILBMpOk4mCr dU1b8Ar5O1xfACweRVgxwAAAA==
X-Change-Id: 20251111-io-pgtable-fe0822b4ebdd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12178; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ZXrOBFdyf9TG39sXS6oqK5q38LX8QtvFEFyq+TKtdgQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFF4nbVQ48kgpUcJKNVdzu9LCeXj0vRdE2I+Qv
 qo/Vy3hpOCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRReJwAKCRAEWL7uWMY5
 Ri6kEACJ1ErD1ff8rRfLJ/E1cEo3ogYuuSXdi9FVJi7KwZMw0ryDRadjy26jInquoxCCfu2qrS9
 P6iY4wBtKDX+vOHETQMKq8nOmDOhDOB0nEEEPsnPD6dMTE+fzf6AOgO9xbpgbH9ZyYZIxbJPOtu
 nNlG1p3mvjEbL56gmynSEyunQkDjE3oOPUC9w2nozhVlLQEG/8deuKcR0dk2tF1PNG+2GRRGTB9
 YgpwbCf8mWn/eIS7R1bUMzLHnLX10EbWTQVeG2MdPgMe/HzrUzmhnbFNSaRpmeiuUdYpqMwYdlN
 mXWPIVOB+qhqCR8rKwfOEBraN2N/xFGFqLpWUecNUPO5/8TgAM27a2fVJQchwqxdqVEQsIiiLrZ
 qYQ9WjW94fhJvg6SIPUmJGlA0YFZbGVFOnQhBb0x7+i2Q9HFjHisL5XcPBoTCia5oUkQLEUhTB/
 Y0BXqipcIUL79CmELu152HEAl3LqSN9Oc9brq7CYPgNs4HjA/HZO/qj1MLk3iEEBy2f8y7ZMGMR
 IshBN7Kox/QxntpwacoOYZZCcJ6ScKG8qMcsA8OQAjOhO0idBw8egPuWPKFcy7U+uOe1w5E/Nhp
 fA6Ca+tiJaUZQK8oyZerF33kS9pOps9AEY4gFHLdmGSvP32fRejNa/56LKZ7DbPtAyzqgvszjIr OFZWcZQaNThXsdQ==
X-Mailer: b4 0.14.2
Message-ID: <20251112-io-pgtable-v3-1-b00c2e6b951a@google.com>
Subject: [PATCH v3] io: add io_pgtable abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Asahi Lina <lina+kernel@asahilina.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Asahi Lina <lina+kernel@asahilina.net>

This will be used by the Tyr driver to create and modify the page table
of each address space on the GPU. Each time a mapping gets created or
removed by userspace, Tyr will call into GPUVM, which will figure out
which calls to map_pages and unmap_pages are required to map the data in
question in the page table so that the GPU may access those pages when
using that address space.

The Rust type wraps the struct using a raw pointer rather than the usual
Opaque+ARef approach because Opaque+ARef requires the target type to be
refcounted.

Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This patch is based on [1] but I have rewritten and simplified large
parts of it. The Asahi driver no longer uses the io-pgtable abstraction,
and Nova never planned to (since NVIDIA has its own separate memory).
Therefore, I have simplified these abstractions to fit the needs of the
Tyr GPU driver.

This series depends on the PhysAddr typedef [2].

[1]: https://lore.kernel.org/all/20250623-io_pgtable-v2-1-fd72daac75f1@collabora.com/
[2]: https://lore.kernel.org/all/20251112-resource-phys-typedefs-v2-0-538307384f82@google.com/
---
 rust/bindings/bindings_helper.h |   3 +-
 rust/kernel/io.rs               |   1 +
 rust/kernel/io/pgtable.rs       | 254 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2c9f31bd99b9817bd2d6ab89fbcf2..faab6bc9463321c092a8bbcb6281175e490caccd 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -56,8 +56,9 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
-#include <linux/interrupt.h>
 #include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/io-pgtable.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 56a435eb14e3a1ce72dd58b88cbf296041f1703e..5913e240d5a9814ceed52c6dc1a798e64158d567 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -8,6 +8,7 @@
 use crate::{bindings, build_assert, ffi::c_void};
 
 pub mod mem;
+pub mod pgtable;
 pub mod poll;
 pub mod resource;
 
diff --git a/rust/kernel/io/pgtable.rs b/rust/kernel/io/pgtable.rs
new file mode 100644
index 0000000000000000000000000000000000000000..fe05bc1673f9a7741a887a3c9bbad866dd17a2b5
--- /dev/null
+++ b/rust/kernel/io/pgtable.rs
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IOMMU page table management.
+//!
+//! C header: [`include/io-pgtable.h`](srctree/include/io-pgtable.h)
+
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
+};
+
+use crate::{
+    alloc,
+    bindings,
+    device::{Bound, Device},
+    devres::Devres,
+    error::to_result,
+    io::PhysAddr,
+    prelude::*, //
+};
+
+use bindings::io_pgtable_fmt;
+
+/// Protection flags used with IOMMU mappings.
+pub mod prot {
+    /// Read access.
+    pub const READ: u32 = bindings::IOMMU_READ;
+    /// Write access.
+    pub const WRITE: u32 = bindings::IOMMU_WRITE;
+    /// Request cache coherency.
+    pub const CACHE: u32 = bindings::IOMMU_CACHE;
+    /// Request no-execute permission.
+    pub const NOEXEC: u32 = bindings::IOMMU_NOEXEC;
+    /// MMIO peripheral mapping.
+    pub const MMIO: u32 = bindings::IOMMU_MMIO;
+    /// Privileged mapping.
+    pub const PRIV: u32 = bindings::IOMMU_PRIV;
+}
+
+/// Represents a requested `io_pgtable` configuration.
+pub struct Config {
+    /// Quirk bitmask (type-specific).
+    pub quirks: usize,
+    /// Valid page sizes, as a bitmask of powers of two.
+    pub pgsize_bitmap: usize,
+    /// Input address space size in bits.
+    pub ias: u32,
+    /// Output address space size in bits.
+    pub oas: u32,
+    /// IOMMU uses coherent accesses for page table walks.
+    pub coherent_walk: bool,
+}
+
+/// An io page table using a specific format.
+///
+/// # Invariants
+///
+/// The pointer references a valid io page table.
+pub struct IoPageTable<F> {
+    ptr: NonNull<bindings::io_pgtable_ops>,
+    _marker: PhantomData<F>,
+}
+
+// SAFETY: `struct io_pgtable_ops` is not restricted to a single thread.
+unsafe impl<F> Send for IoPageTable<F> {}
+// SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
+unsafe impl<F> Sync for IoPageTable<F> {}
+
+/// The format used by this page table.
+pub trait IoPageTableFmt: 'static {
+    /// The value representing this format.
+    const FORMAT: io_pgtable_fmt;
+}
+
+impl<F: IoPageTableFmt> IoPageTable<F> {
+    /// Create a new `IoPageTable` as a device resource.
+    #[inline]
+    pub fn new(
+        dev: &Device<Bound>,
+        config: Config,
+    ) -> impl PinInit<Devres<IoPageTable<F>>, Error> + '_ {
+        // SAFETY: Devres ensures that the value is dropped during device unbind.
+        Devres::new(dev, unsafe { Self::new_raw(dev, config) })
+    }
+
+    /// Create a new `IoPageTable`.
+    ///
+    /// # Safety
+    ///
+    /// If successful, then the returned value must be dropped before the device is unbound.
+    #[inline]
+    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable<F>> {
+        let mut raw_cfg = bindings::io_pgtable_cfg {
+            quirks: config.quirks,
+            pgsize_bitmap: config.pgsize_bitmap,
+            ias: config.ias,
+            oas: config.oas,
+            coherent_walk: config.coherent_walk,
+            tlb: &raw const NOOP_FLUSH_OPS,
+            iommu_dev: dev.as_raw(),
+            // SAFETY: All zeroes is a valid value for `struct io_pgtable_cfg`.
+            ..unsafe { core::mem::zeroed() }
+        };
+
+        // SAFETY:
+        // * The raw_cfg pointer is valid for the duration of this call.
+        // * The provided `FLUSH_OPS` contains valid function pointers that accept a null pointer
+        //   as cookie.
+        // * The caller ensures that the io pgtable does not outlive the device.
+        let ops = unsafe {
+            bindings::alloc_io_pgtable_ops(F::FORMAT, &mut raw_cfg, core::ptr::null_mut())
+        };
+        // INVARIANT: We successfully created a valid page table.
+        Ok(IoPageTable {
+            ptr: NonNull::new(ops).ok_or(ENOMEM)?,
+            _marker: PhantomData,
+        })
+    }
+
+    /// Obtain a raw pointer to the underlying `struct io_pgtable_ops`.
+    #[inline]
+    pub fn raw_ops(&self) -> *mut bindings::io_pgtable_ops {
+        self.ptr.as_ptr()
+    }
+
+    /// Obtain a raw pointer to the underlying `struct io_pgtable`.
+    #[inline]
+    pub fn raw_pgtable(&self) -> *mut bindings::io_pgtable {
+        // SAFETY: The io_pgtable_ops of an io-pgtable is always the ops field of a io_pgtable.
+        unsafe { kernel::container_of!(self.raw_ops(), bindings::io_pgtable, ops) }
+    }
+
+    /// Obtain a raw pointer to the underlying `struct io_pgtable_cfg`.
+    #[inline]
+    pub fn raw_cfg(&self) -> *mut bindings::io_pgtable_cfg {
+        // SAFETY: The `raw_pgtable()` method returns a valid pointer.
+        unsafe { &raw mut (*self.raw_pgtable()).cfg }
+    }
+
+    /// Map a physically contiguous range of pages of the same size.
+    ///
+    /// # Safety
+    ///
+    /// * This page table must not contain any mapping that overlaps with the mapping created by
+    ///   this call.
+    /// * If this page table is live, then the caller must ensure that it's okay to access the
+    ///   physical address being mapped for the duration in which it is mapped.
+    #[inline]
+    pub unsafe fn map_pages(
+        &self,
+        iova: usize,
+        paddr: PhysAddr,
+        pgsize: usize,
+        pgcount: usize,
+        prot: u32,
+        flags: alloc::Flags,
+    ) -> Result<usize> {
+        let mut mapped: usize = 0;
+
+        // SAFETY: The `map_pages` function in `io_pgtable_ops` is never null.
+        let map_pages = unsafe { (*self.raw_ops()).map_pages.unwrap_unchecked() };
+
+        // SAFETY: The safety requirements of this method are sufficient to call `map_pages`.
+        to_result(unsafe {
+            (map_pages)(
+                self.raw_ops(),
+                iova,
+                paddr,
+                pgsize,
+                pgcount,
+                prot as i32,
+                flags.as_raw(),
+                &mut mapped,
+            )
+        })?;
+
+        Ok(mapped)
+    }
+
+    /// Unmap a range of virtually contiguous pages of the same size.
+    ///
+    /// # Safety
+    ///
+    /// This page table must contain a mapping at `iova` that consists of exactly `pgcount` pages
+    /// of size `pgsize`.
+    #[inline]
+    pub unsafe fn unmap_pages(&self, iova: usize, pgsize: usize, pgcount: usize) -> usize {
+        // SAFETY: The `unmap_pages` function in `io_pgtable_ops` is never null.
+        let unmap_pages = unsafe { (*self.raw_ops()).unmap_pages.unwrap_unchecked() };
+
+        // SAFETY: The safety requirements of this method are sufficient to call `unmap_pages`.
+        unsafe { (unmap_pages)(self.raw_ops(), iova, pgsize, pgcount, core::ptr::null_mut()) }
+    }
+}
+
+// These bindings are currently designed for use by GPU drivers, which use this page table together
+// with GPUVM. When using GPUVM, a single mapping operation may be translated into many operations
+// on the page table, and in that case you generally want to flush the TLB only once per GPUVM
+// operation. Thus, do not use these callbacks as they would flush more often than needed.
+static NOOP_FLUSH_OPS: bindings::iommu_flush_ops = bindings::iommu_flush_ops {
+    tlb_flush_all: Some(rust_tlb_flush_all_noop),
+    tlb_flush_walk: Some(rust_tlb_flush_walk_noop),
+    tlb_add_page: None,
+};
+
+#[no_mangle]
+extern "C" fn rust_tlb_flush_all_noop(_cookie: *mut core::ffi::c_void) {}
+
+#[no_mangle]
+extern "C" fn rust_tlb_flush_walk_noop(
+    _iova: usize,
+    _size: usize,
+    _granule: usize,
+    _cookie: *mut core::ffi::c_void,
+) {
+}
+
+impl<F> Drop for IoPageTable<F> {
+    fn drop(&mut self) {
+        // SAFETY: The caller of `ttbr` promised that the page table is not live when this
+        // destructor runs.
+        unsafe { bindings::free_io_pgtable_ops(self.0.ops) };
+    }
+}
+
+/// The `ARM_64_LPAE_S1` page table format.
+pub enum ARM64LPAES1 {}
+
+impl IoPageTableFmt for ARM64LPAES1 {
+    const FORMAT: io_pgtable_fmt = bindings::io_pgtable_fmt_ARM_64_LPAE_S1 as io_pgtable_fmt;
+}
+
+impl IoPageTable<ARM64LPAES1> {
+    /// Access the `ttbr` field of the configuration.
+    ///
+    /// This is the physical address of the page table, which may be passed to the device that
+    /// needs to use it.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the device stops using the page table before dropping it.
+    #[inline]
+    pub unsafe fn ttbr(&self) -> u64 {
+        // SAFETY: `arm_lpae_s1_cfg` is the right cfg type for `ARM64LPAES1`.
+        unsafe { (*self.raw_cfg()).__bindgen_anon_1.arm_lpae_s1_cfg.ttbr }
+    }
+
+    /// Access the `mair` field of the configuration.
+    #[inline]
+    pub fn mair(&self) -> u64 {
+        // SAFETY: `arm_lpae_s1_cfg` is the right cfg type for `ARM64LPAES1`.
+        unsafe { (*self.raw_cfg()).__bindgen_anon_1.arm_lpae_s1_cfg.mair }
+    }
+}

---
base-commit: ffee675aceb9f44b0502a8bec912abb0c4f4af62
change-id: 20251111-io-pgtable-fe0822b4ebdd
prerequisite-change-id: 20251106-resource-phys-typedefs-6db37927d159:v2
prerequisite-patch-id: 350421d8dbaf3db51b1243d82077c5eb88f54db5
prerequisite-patch-id: ac0166fb3cd235de76841789173051191a4d2434
prerequisite-patch-id: f4bca02c77c40093690b66cdf477f928784bdbf4
prerequisite-patch-id: 083d1c22b1a7eb0dcae37052b926362543c68e8a

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

