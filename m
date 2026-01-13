Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E10D33D4F8
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294183; cv=none; b=p6NNIoQJc1NO5tJKo2IKWmHbmfUSFnEpiP/4P4rCDLkt0R/xN9qP5hSDJ9egDHtUn2V9meFWoQQOKDLRLsKdq6441hKnVjiRRyi5qhjNjFdljIVM2nH4qy/V+0PPNMLMOd0+CfD0fFGuABAvKbq8ViP9Wf8WDosgrlvR7AP3TK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294183; c=relaxed/simple;
	bh=g1WAfHw3fhA18eizkTxdt4KfTRTng4SZoErFuKuDg64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UqTRvUq1CcP4bHA/Th7WE7xgXI4wS+FJvxHTbzJyl+vJJ71Rw88oMcXxdLNUS9lO78jEjVhs2M/RY924CYJVJi9cJ6QyUa5UO4RoYrUla1jovieq4p1x/Xu7Tm2t1JcFZLZ86GA+1gvn3lzogDSXizg8U6/1zg6G+CYCd6kVf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zuRp1mmt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zuRp1mmt"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b872c88d115so153140066b.2
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 00:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768294178; x=1768898978; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jw+Q9e+3qzYdGDM4/rhL4Cf9PitNjxQFTtoPvumkEKw=;
        b=zuRp1mmtzapwCrJQ3d014jHXOK9UFTOFCIK0G0E58gWLthKNiuEIQOeRKjGaNWD9Je
         wDGP/xT7BYb5fclEVBoFQ1DWrrFmDoqCpW9kwQKIxEADW4kJCuDf8vVDmnK9KLC002Lv
         HF0MPyhuEqD2Iu7+mu1y7O2gd/+2QK721A0SAAzUtIMzxilU9+cjuFw+KP14mCOS31eU
         8nQ709IaOr9aBWzKkAXyK3wi9GR1uGIsQ9fdz9gHVKP8CAdMbxHz85VLN5sIfj/sfvdG
         w8IUMQuNhusOLgX4wrFtvay0L0UI4P/odZJkKTr4HOcHMXEh3/FnwLgwWPqmXaFZCtx3
         IKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768294178; x=1768898978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw+Q9e+3qzYdGDM4/rhL4Cf9PitNjxQFTtoPvumkEKw=;
        b=hjJ+yoeKTMxxXSd4Y51x+eZmQcbD9xF6x0oSj7zNIo1f2KvJCQLhayesIfh9eNEYBO
         SagrDfdgsXDUY+yHiw4MfjB07oC4BQ7vnY0B3tnOH4u1Y1v79bBLxp+XOfdrizgw7/2z
         9N0DIihCx+H2ml4BwafnDvUjeK9f7mybtCIuAmfWVigXPzYgMZ4taNF+9QCxUkFCMfr6
         NDPJRrQepP5d3TldpQSKrD5IpkStHakXTl+we8dH4BlKA6kvRvaOISkLh7ksr9Ups08Y
         OONf0dhhm5+KuMvyHTWCi/TQPOTwYYD9HAUgp0p1XB9TGDnUckgQ6Pj4UF42lcsTb0Br
         iAfg==
X-Forwarded-Encrypted: i=1; AJvYcCU+IMSq8kiyqEwX9vG3Eb0b9XtbmFZrZgcn0FUAo0R3pm8wUtprT1+/Je2LaHaPuGZWXWa4Jg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzihQw7SSB0nVL6alSHUbhaWHHSXFnrydK0DuMuKYx4g4Y8Md1l
	1VnD39iDIntRz13jIO1Jw2IU4Q/7Dz2epEX3s/5XSQ2bmIxk2ZBeqbYPUr5r20vzASZ1CMC50Ha
	GuBbEGJFFWVMqwPtLhw==
X-Google-Smtp-Source: AGHT+IG+jeDT8il/eAqSDA5cuGkJbkzksYOdO7Mos9jGlhqfPY9NZ1sG85DVTJeq24oXIQZmCGGLmrtiUEe7nb4=
X-Received: from edwn23.prod.google.com ([2002:a05:6402:4d7:b0:649:8456:d4bf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:98d:b0:b73:7b97:5bfb with SMTP id a640c23a62f3a-b8444f4f7d3mr2145464866b.33.1768294178675;
 Tue, 13 Jan 2026 00:49:38 -0800 (PST)
Date: Tue, 13 Jan 2026 08:49:27 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABYHZmkC/1WOyw6DIBBFf8WwLgbwUXXV/2i6AByRRMWCJW2M/
 16KTWpndyf3nJkVObAaHGqSFVnw2mkzhVCcEiR7PinAug0ZMcIKGgZrg2e1cDEA7oBUjIkcRNu
 iAMwWOv2Msuttzxbuj+Bc9iUS3AGWZhz10iS+TGmNraToU+61W4x9xUd8Ftvfm+x402eYYkGIZ FCKuqD8ooxRA6TBGj0+/7Es+I9sHtiy4pyfeU6yivyx27a9ASqjSmoOAQAA
X-Change-Id: 20251111-io-pgtable-fe0822b4ebdd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14368; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=CQgadvNGkklTMvPBwYDBqTFwljHbuM9uho1jUasw/lM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpZgcc3/3HGgCiJsPygaovp4f3h+AB0KdYAq11m
 5FzkkiCvA2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWYHHAAKCRAEWL7uWMY5
 RgL+D/0a+pQIZUSNKsrmV5XA53l45frfdrOhnIHn+PezUeJf5A+z3ZTbU5NNPjIMQXcY03qXV3l
 YnhjZJMkxQpSc8umBABPcoCc9Alw3jfNreF4HzUkGhNmxp/qQpPghe7n32sziiaU3x8C6TOEw62
 6a6SRILNrpQT8SBtOl24yKXmFrIyowpTqadpuNQTFmrwm6dH91Q6W+ROK9wlSZsr9MV1PSBdhV5
 vnQ9ofm+eeB8CvSH2gk6oSG6O2rlJvcdxDnJ3OU1AkxttFCyUQwVF2vroQlahnM6KWQZl3N92Lj
 iESRzhiEqOKqpyWF1nri52uJeX71hHawRNDBcp1PqhsaFgYWof6D90te0Chh4k+S3YtW30C4aW+
 0FvRmwgv/0+vGcvYK77dNB3zFhUmEbcZfl6f03zReMUY9dWh6H46pbejU9Rr4b1kKgm2K94D2Rb
 2BKmSNwhw1j1VV9/B3ZJO3zrfj6AB7Tiy60TmRn/ytuBFhrCCK9706lLec4K/B+aqBZg8KciG/U
 Njfk1WZ4BpayNs+l6xoEYTdUZBNlnDV7moTY7iOg4GNpFtJp66HDAXQVNpeggjea4JJmH6qPUDc
 bLRGxKWKXVzx94+kKIZjohcovwCw5+NZvwwXrGr8wJq+sQlZzWpv+D7/WerSDJswiPhxedNJmQT XRxd3mMyhBFRxdg==
X-Mailer: b4 0.14.2
Message-ID: <20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com>
Subject: [PATCH v5] io: add io_pgtable abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
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
Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
We did not discuss where this should go in the MAINTAINERS file yet. As
an initial suggestion I added it under IOMMU SUBSYSTEM, but please let
me know what you prefer. There is also a DEVICE I/O & IRQ [RUST]
subsystem that it could fall under.
---
Changes in v5:
- Fix warning by removing #[must_use] from `map_pages`.
- Reword comment on NOOP_FLUSH_OPS
- Add blank line after `alloc_io_pgtable_ops`
- Reword safety comment in Drop to refer ttbr method
- List in MAINTAINERS
- Pick up Reviewed-by: Daniel
- Link to v4: https://lore.kernel.org/r/20251219-io-pgtable-v4-1-68aaa7a40380@google.com

Changes in v4:
- Rename prot::PRIV to prot::PRIVILEGED
- Adjust map_pages to return the length even on error.
- Explain return value in docs of map_pages and unmap_pages.
- Explain in map_pages that the caller must explicitly flush the TLB
  before accessing the resulting mapping.
- Add a safety requirement that access to a given range is required to
  be exclusive.
- Reword comment on NOOP_FLUSH_OPS.
- Rebase on v6.19-rc1 and pick up tags.
- Link to v3: https://lore.kernel.org/r/20251112-io-pgtable-v3-1-b00c2e6b951a@google.com

Changes in v3:
- Almost entirely rewritten from scratch.
- Link to v2: https://lore.kernel.org/all/20250623-io_pgtable-v2-1-fd72daac75f1@collabora.com/
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   3 +-
 rust/kernel/io.rs               |   1 +
 rust/kernel/io/pgtable.rs       | 276 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9de1e9e43f63787578edd8c429ca39..eccdb937762a7545fcd5db0194ab7c1b6dfdfde6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13241,6 +13241,7 @@ F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
+F:	rust/kernel/io/pgtable.rs
 
 IOMMUFD
 M:	Jason Gunthorpe <jgg@nvidia.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a067038b4b422b4256f4a2b75fe644d47e6e82c8..1b05a5e4cfb4780fdc27813d708a8f1a6a2d9913 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -56,9 +56,10 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/firmware.h>
-#include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/io-pgtable.h>
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 98e8b84e68d11ef74b2026d8c3d847a127f4672d..88253158448cbf493ca200a87ef9ba958255e761 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -10,6 +10,7 @@
 };
 
 pub mod mem;
+pub mod pgtable;
 pub mod poll;
 pub mod resource;
 
diff --git a/rust/kernel/io/pgtable.rs b/rust/kernel/io/pgtable.rs
new file mode 100644
index 0000000000000000000000000000000000000000..001b1d197563728881e995c90395bf167d29dfe9
--- /dev/null
+++ b/rust/kernel/io/pgtable.rs
@@ -0,0 +1,276 @@
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
+    pub const PRIVILEGED: u32 = bindings::IOMMU_PRIV;
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
+pub struct IoPageTable<F: IoPageTableFmt> {
+    ptr: NonNull<bindings::io_pgtable_ops>,
+    _marker: PhantomData<F>,
+}
+
+// SAFETY: `struct io_pgtable_ops` is not restricted to a single thread.
+unsafe impl<F: IoPageTableFmt> Send for IoPageTable<F> {}
+// SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
+unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<F> {}
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
+    /// If successful, then the returned `IoPageTable` must be dropped before the device is
+    /// unbound.
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
+
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
+    /// Even if successful, this operation may not map the entire range. In that case, only a
+    /// prefix of the range is mapped, and the returned integer indicates its length in bytes. In
+    /// this case, the caller will usually call `map_pages` again for the remaining range.
+    ///
+    /// The returned [`Result`] indicates whether an error was encountered while mapping pages.
+    /// Note that this may return a non-zero length even if an error was encountered. The caller
+    /// will usually [unmap the relevant pages](Self::unmap_pages) on error.
+    ///
+    /// The caller must flush the TLB before using the pgtable to access the newly created mapping.
+    ///
+    /// # Safety
+    ///
+    /// * No other io-pgtable operation may access the range `iova .. iova+pgsize*pgcount` while
+    ///   this `map_pages` operation executes.
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
+    ) -> (usize, Result) {
+        let mut mapped: usize = 0;
+
+        // SAFETY: The `map_pages` function in `io_pgtable_ops` is never null.
+        let map_pages = unsafe { (*self.raw_ops()).map_pages.unwrap_unchecked() };
+
+        // SAFETY: The safety requirements of this method are sufficient to call `map_pages`.
+        let ret = to_result(unsafe {
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
+        });
+
+        (mapped, ret)
+    }
+
+    /// Unmap a range of virtually contiguous pages of the same size.
+    ///
+    /// This may not unmap the entire range, and returns the length of the unmapped prefix in
+    /// bytes.
+    ///
+    /// # Safety
+    ///
+    /// * No other io-pgtable operation may access the range `iova .. iova+pgsize*pgcount` while
+    ///   this `unmap_pages` operation executes.
+    /// * This page table must contain one or more consecutive mappings starting at `iova` whose
+    ///   total size is `pgcount * pgsize`.
+    #[inline]
+    #[must_use]
+    pub unsafe fn unmap_pages(&self, iova: usize, pgsize: usize, pgcount: usize) -> usize {
+        // SAFETY: The `unmap_pages` function in `io_pgtable_ops` is never null.
+        let unmap_pages = unsafe { (*self.raw_ops()).unmap_pages.unwrap_unchecked() };
+
+        // SAFETY: The safety requirements of this method are sufficient to call `unmap_pages`.
+        unsafe { (unmap_pages)(self.raw_ops(), iova, pgsize, pgcount, core::ptr::null_mut()) }
+    }
+}
+
+// For the initial users of these rust bindings, the GPU FW is managing the IOTLB and performs all
+// required invalidations using a range. There is no need for it get ARM style invalidation
+// instructions from the page table code.
+//
+// Support for flushing the TLB with ARM style invalidation instructions may be added in the
+// future.
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
+impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
+    fn drop(&mut self) {
+        // SAFETY: The caller of `Self::ttbr()` promised that the page table is not live when this
+        // destructor runs.
+        unsafe { bindings::free_io_pgtable_ops(self.raw_ops()) };
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
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251111-io-pgtable-fe0822b4ebdd

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

