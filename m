Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872271DF73A
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730904; cv=none; b=YJdhVDGEuSD5nvOgZa4M01AITJrz98WFa5004PXJmSSphtHZdV3EilM0aH7Kn4abWkGcWJbt99rTxRznbKDJrrO7c+6+O0r70lD4IpAXxx0Och6z1aA4S9enM5qJoVLYFOgAKRf6JUT676xCpLXBQU6woV45zeY1OAx8QywrKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730904; c=relaxed/simple;
	bh=LrSIo5ha6TFLy6D21xYM7uPy787et3bQlSaz8DA55bA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WCvxEr6OB03CQdsRLIkbL9q1Py7EhIlcxKwHw7kktw2lC2ns3OndM/o5wljMFTRABULZxsPrxMDAuiJ1I6jjl5baj77LR7pc+uLrc2cPyzQjGnXcDx2fPs5Dv89+SJbCT2qexv3gVqVpF2dh74zkmKwP29UOqJfkJ5BHYiwW0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEGbFuI/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEGbFuI/"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47d4029340aso32390025e9.3
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768730901; x=1769335701; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bzi0bS2JMbIu1Wq1pRi2DjrPlWSPSU+2KdETOJ9NLig=;
        b=mEGbFuI/Fs1s6+bwksplq2yqFTvqNvjb5cCGB8dOR9iKndK12Z76bt/WKt1wBnEaEQ
         cW9HD0ySpCZir6UWZUPCN59l0WInYfOVAoEci7QgHg/l0aQLxkvlEQ1DHEiqfzOf3uZ7
         jzcvkNivtz3QM6SYm19zuJ/H1ozDe4ydn7HJT0rUao+MyXav6gmcopQeNPe4lAkXAucL
         3dQMZGDEGVlW82dUYGQnz8piJiMxziyqbfvdk7SafcEpfhM0PSpfIEbRi+49wX1Z+ruh
         Io/0t9VuhxXww+PXC8uLkyc1QfqEZN3fgu1XX1ONSqv6NwzQ1lZW6+vVsdyRg+S2o2hK
         JK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768730901; x=1769335701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bzi0bS2JMbIu1Wq1pRi2DjrPlWSPSU+2KdETOJ9NLig=;
        b=UXHljShsFBi+qjnjnOmvRnwhtJ6O1yM1LYgdqvV4QpYy6CrO8yXGrahRwGrDAyBs9R
         2gvrSWeMqCmH2+Cs79gzHzM/zNa+3NDSqBe25K2HTNY76GrXylWIQqxQwdSfSrdnxRd3
         nl/2vFmOzPUC2a11sHiIQ6kNcFglY5fIv3SPJt6g6LXsgcJ2LmHUurNH2eBc2xFd3/Yn
         9UlBgCCjiRNiCdAQMkDQlWJhFvZ3+ja2f2PDTVu8KhzrYNo3f0SDQbhFvFcEnWVdb/0W
         ruWbK4iwH/AifO3Pi0Y+EF0GHBQsGkaMzUsjMG6l3ESctIUVDwNaIoHeTWc8cWk4AiXH
         axWw==
X-Forwarded-Encrypted: i=1; AJvYcCUvkdpLFWd0Rz/Bxh0hFp8/71RyqgwjottU3kR2r9zH/LVxjP6g+rCvBE1wSM2PL1QLOi7+Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT4pjVLeKBWYGAKGzg3G6R9+uyc0Z9yXmPpGwCIsGiRDGj/VVg
	yXvtBWIJsDHfp/8UGlkGJ//4prJJE2A0S54MAK/SysHLKW1oGatoq4gYlKqA+KqFm6lQ633SZO6
	O7Xs44FHDwVLtA8op4A==
X-Received: from wmbka9.prod.google.com ([2002:a05:600c:5849:b0:480:2880:4d51])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:81c5:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4801e30df8bmr97176285e9.16.1768730901023;
 Sun, 18 Jan 2026 02:08:21 -0800 (PST)
Date: Sun, 18 Jan 2026 10:08:08 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAexbGkC/2WOyw6CMBBFf4V0bUkfUNCV/2Fc9DFiE7XYYqMx/
 LsjaNQ4uzu558zcSYLoIZFVcScRsk8+nDCoRUHsXp86oN5hJoKJmuNQH2jfDdocgO6AtUKYCox
 zBIE+ws5fJ9lmO+cI5ws6h3lJjE5AbTge/bAqsir5kkbLybO892kI8TY9kuXUft0U3zezpJwax
 qwAZZY11+suhO4AJVonT64+rED/N1shq1qtdaMrJlv2x9ZvVjHO5Q9bI9uAaxpurHSt+2HHcXw AwXhs7EoBAAA=
X-Change-Id: 20251111-io-pgtable-fe0822b4ebdd
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14766; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/8bC89qTDsFikv7hESqFn6Tq2jauWkt3iFph/Lepxys=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpbLEPKuxnB0McVu90qr43YGJsUixy1cxF2syh0
 JRYLAOtSeWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWyxDwAKCRAEWL7uWMY5
 RrYtD/4hGr/Ibbd5xaBQyaGQ+TKS+3v2Bl5vxQEmKZCgsW2fQ6PG+d9+x9auMDHlLdlTAtCgZZh
 rGZUNxaREA7r9uswacgTRuoJJyMy+od8SYUn4wU45VQsNniQ6F7CQpbypL9bhcJusxnS2vHktaZ
 Li6zSFdERJIRNoCFf1OebqgpChUpJ2mfZNAA/4oJoKabDt8q12pfH85Vu4YB1W3CGbXZUokMW4q
 xkdR1LhJAYEt0u94Hl/J0v0Z0EiM5msXf/KL6ndGdk8SnYj+EE03/Ow2jcnkKvh79BTojO8i01U
 BAXL2ADLJzJ+u9RsitA9n+x7tbOgWSnaBoR3kJG+xeVDSK7oJtPVa8jWezEP9fRMcP740zs3JWP
 2yyWLA0zBu4AEZ/563X1/XW/QJemRu5lfohQscsi4a1l8l/yb9Qj7MNYODp9Zz+W1lklX2u0MMy
 GMvd0MzfUdWdgb0kKVDXgbWpx12C3TLyH9Se7Bv+UN1RWcEF/+Y/4RnRlpypNR600E9ttEwX9gf
 reEtokPF/ogDwSpfblrZYxJegKd0Pn8fCKxiY+K1UYz+jTPgsvakzynoa/f2ElGo9cceb6MBaSR
 nMOjlSLPqJXMhbDwHToey+djJybGYD+8lN5qcmg6W20WbS8ffDvnTs34fJMBVrJ3Xzx+RgNLFn1 nhHt21lC4lsU8RA==
X-Mailer: b4 0.14.2
Message-ID: <20260118-io-pgtable-v6-1-423846996883@google.com>
Subject: [PATCH v6] rust: iommu: add io_pgtable abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Joerg Roedel <joro@8bytes.org>, Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Asahi Lina <lina+kernel@asahilina.net>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	iommu@lists.linux.dev, linux-mm@kvack.org, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Alice Ryhl <aliceryhl@google.com>
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
Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v6:
- Move to rust/kernel/iommu/
- Pick up Tested-by tag.
- Link to v5: https://lore.kernel.org/r/20260113-io-pgtable-v5-1-7ed771bc3d8d@google.com

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
 rust/kernel/iommu/mod.rs        |   5 +
 rust/kernel/iommu/pgtable.rs    | 276 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 5 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9de1e9e43f63787578edd8c429ca39..b83bd50c2755115cc14e903e784b1dae1bd921bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13241,6 +13241,7 @@ F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
+F:	rust/kernel/iommu/
 
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
diff --git a/rust/kernel/iommu/mod.rs b/rust/kernel/iommu/mod.rs
new file mode 100644
index 0000000000000000000000000000000000000000..1423d7b19b578481af3174e39ce2e45bc8eb0eee
--- /dev/null
+++ b/rust/kernel/iommu/mod.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust support related to IOMMU.
+
+pub mod pgtable;
diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
new file mode 100644
index 0000000000000000000000000000000000000000..001b1d197563728881e995c90395bf167d29dfe9
--- /dev/null
+++ b/rust/kernel/iommu/pgtable.rs
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
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f812cf12004286962985a068665443dc22c389a2..e7fba6fa0f811c44ca36b66ef21a25be4d322aae 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -103,6 +103,7 @@
 pub mod init;
 pub mod io;
 pub mod ioctl;
+pub mod iommu;
 pub mod iov;
 pub mod irq;
 pub mod jump_label;

---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20251111-io-pgtable-fe0822b4ebdd

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

