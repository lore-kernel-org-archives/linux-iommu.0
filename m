Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B761F75AC
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 19:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486894; cv=none; b=oXG0sPyizRxlomGy3/FMaUM0Tfxqfx8ByCkgm/pqyhV9walDDySFZsHAN/+bhaGs6Aj/2IktXfFhANo5ahS0Pf8Bcr8DO8o5W6vRtniE3MzrwHFlqSF8IFQOvURPrfs7Pm1mxNr+aa8Rnu1K77PxXYKdbEB/p4xov0MNHIRke0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486894; c=relaxed/simple;
	bh=dzmLbtBDyZ/FcPHMscg5on2MnkSNe09HBjazyM8Uneg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ4tqHx+kRvXfnDdRCyCu4KifWU6QxlVUNOOqxya7Lzqd8m+NIuvcG8yLDjppbc5ghqICA65hC6P6LQYAZGO2AgCgGVurr1VNReeqSx0/OQ4Np6sCsYC1Yb4t9x4omDAZtpGkBJrNUaHLMCwwSec2dOOfNr2xvdArk8cmhrLA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX18Lrtj; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX18Lrtj"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-540218726d5so5829550e87.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737486889; x=1738091689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAubxMbMqNP2we07eOQcqge39nCAiJaFdqM8sysS3gM=;
        b=TX18Lrtjvpd0kSaPtgaLvTf1hJmizNqruezN7SQ3jyUyQOfZs0yJSxAmOWt+/Mg4Dz
         aKjV55cTDbxk9iZswL8FXPuZdglS9MYpIYc3ywms2PB9RZfhvnLkI47i/x6gee31EXlw
         dYlsnB4PBO9d0W5vGMQqbFpzCWFzHSV0Hb8hKA0zLU89aLQKFVnyxH2hiI/tfgjZBG23
         VQzGOtOUwr0yhvbHazvBl2Z1dDOBEUXsabUgoPjp5TpJTe+5YQcCTc9Z78jy4teWCOa+
         w7GiCsbJZFxN9+pBYl1ZpcJguaCRnvscZyUrfzbreckgXziQr96IjQSLI+t0aIfJieFC
         y3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486889; x=1738091689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAubxMbMqNP2we07eOQcqge39nCAiJaFdqM8sysS3gM=;
        b=aWVlKcFhISkVqKt0THxEvt97O+KwnlK4Bo4fCurkgs71tZCQl2Q1y1+quyidCnB2w2
         YuF/2QKSUUsTno8wnk4j3xJsL8oaGjtZ8xJ+8NxIFEmRC31pa4pVAZ1dAQ0cGdXej6fx
         4+4h5NeyKhS+AjeuUReo3YiatRtlGCJToNvfHI0kIYm63yD+jlHT/bwwFfUzTtxoMIfK
         aA4RFbe5U5dI3aLDE/RDZ1OHzHxHcezF+azBD/w6RmXlpJm91OQ7aivQDQuHFzDVE1bl
         dEIMCaNL0tFQb1HtPqvx8+6PnNerwam3lMBeMt9Vu2jb824J6hwFZfByDB6v52Y4pWwE
         4LxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuCAX7K/1v2wjAFQFVPzsOzvjNOd5cQ1FDWHhWx5waKi3RK6Np0ecESBgvjgIbHtwpF6MMNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnM3LuVZrmbS9+V6bHqG5S7XJe2AqTbm+zaiD6sh1VmEAdyBBO
	Gv6g8Tpv+5we0Uu4/vqqcRxia8aCnNlQv2aqFyrjG7zXQSq1M3OG
X-Gm-Gg: ASbGncvkjQXgXLHdZu35zfONwJa7DulabHTRbSisWA60ZgU7tQTDizOCQ8l0gjdLiQT
	NE6AU3wjnijZ7JsF2hBwb7yJ7D2awFQ2SJu/DZw+UvQxcsDq2gyrk5bHh89eC/PGn0yc93JyKHU
	jVVKZY6lvvXgDK8b8H/1nD/H9WwrFbrBZJpnNwSsTjtfkMa6Nyy/DNtf+g+bVtUa0oHhgj+rTRY
	TrZNvzQBOFiyTFXNn+FFU9ox9w4Xu/KtKyxjWhCJKVGDi2CDtpAj0eUptJjn/1MqEEHE96nRp9Z
	y99I0cC+z0wsunrTgpIWXs3umeXU8J71aqBHH19m
X-Google-Smtp-Source: AGHT+IE55a8HZn5lF+hZo5o/LI0vN44z9PeLAM5cWvBquc/b9itDdhKKcAX0XAo/mkFqU+4ISND5RA==
X-Received: by 2002:a05:6512:10d0:b0:53f:a8c0:22a7 with SMTP id 2adb3069b0e04-5439c282546mr6539148e87.38.1737486888458;
        Tue, 21 Jan 2025 11:14:48 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543bb6bf5b1sm56786e87.118.2025.01.21.11.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:14:47 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v10 2/3] rust: add dma coherent allocator abstraction.
Date: Tue, 21 Jan 2025 21:14:03 +0200
Message-ID: <20250121191432.1178734-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple dma coherent allocator rust abstraction. Based on
Andreas Hindborg's dma abstractions from the rnvme driver, which
was also based on earlier work by Wedson Almeida Filho.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 281 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 283 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5c4dfe22f41a..49bf713b9bb6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/cred.h>
+#include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..ebae7270190e
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings, build_assert,
+    device::Device,
+    error::code::*,
+    error::Result,
+    transmute::{AsBytes, FromBytes},
+    types::ARef,
+};
+
+/// Possible attributes associated with a DMA mapping.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`attrs`] module.
+#[derive(Clone, Copy, PartialEq)]
+#[repr(transparent)]
+pub struct Attrs(u32);
+
+impl Attrs {
+    /// Get the raw representation of this attribute.
+    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
+        self.0 as _
+    }
+
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Attrs) -> bool {
+        (self & flags) == flags
+    }
+}
+
+impl core::ops::BitOr for Attrs {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Attrs {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Attrs {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// DMA mapping attrributes.
+pub mod attrs {
+    use super::Attrs;
+
+    /// Specifies that reads and writes to the mapping may be weakly ordered, that is that reads
+    /// and writes may pass each other.
+    pub const DMA_ATTR_WEAK_ORDERING: Attrs = Attrs(bindings::DMA_ATTR_WEAK_ORDERING);
+
+    /// Specifies that writes to the mapping may be buffered to improve performance.
+    pub const DMA_ATTR_WRITE_COMBINE: Attrs = Attrs(bindings::DMA_ATTR_WRITE_COMBINE);
+
+    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
+    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attrs = Attrs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
+
+    /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
+    /// that it has been already transferred to 'device' domain.
+    pub const DMA_ATTR_SKIP_CPU_SYNC: Attrs = Attrs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
+
+    /// Forces contiguous allocation of the buffer in physical memory.
+    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
+
+    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// to allocate memory to in a way that gives better TLB efficiency.
+    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
+
+    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
+    /// __GFP_NOWARN).
+    pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
+
+    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
+    /// ideally inaccessible or at least read-only at lesser-privileged levels).
+    pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
+}
+
+/// An abstraction of the `dma_alloc_coherent` API.
+///
+/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
+/// large consistent DMA regions.
+///
+/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
+/// processor's virtual address space) and the device address which can be given to the device
+/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
+/// is dropped.
+///
+/// # Invariants
+///
+/// For the lifetime of an instance of [`CoherentAllocation`], the cpu address is a valid pointer
+/// to an allocated region of consistent memory and we hold a reference to the device.
+pub struct CoherentAllocation<T: AsBytes + FromBytes> {
+    dev: ARef<Device>,
+    dma_handle: bindings::dma_addr_t,
+    count: usize,
+    cpu_addr: *mut T,
+    dma_attrs: Attrs,
+}
+
+impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
+    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::device::Device;
+    /// use kernel::dma::{attrs::*, CoherentAllocation};
+    ///
+    /// # fn test(dev: &Device) -> Result {
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev.into(), 4, GFP_KERNEL,
+    ///                                                                  DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_attrs(
+        dev: ARef<Device>,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+        dma_attrs: Attrs,
+    ) -> Result<CoherentAllocation<T>> {
+        build_assert!(
+            core::mem::size_of::<T>() > 0,
+            "It doesn't make sense for the allocated type to be a ZST"
+        );
+
+        let size = count
+            .checked_mul(core::mem::size_of::<T>())
+            .ok_or(EOVERFLOW)?;
+        let mut dma_handle = 0;
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        // We ensure that we catch the failure on this function and throw an ENOMEM
+        let ret = unsafe {
+            bindings::dma_alloc_attrs(
+                dev.as_raw(),
+                size,
+                &mut dma_handle,
+                gfp_flags.as_raw(),
+                dma_attrs.as_raw(),
+            )
+        };
+        if ret.is_null() {
+            return Err(ENOMEM);
+        }
+        // INVARIANT: We just successfully allocated a coherent region which is accessible for
+        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
+        // to the device.
+        Ok(Self {
+            dev,
+            dma_handle,
+            count,
+            cpu_addr: ret as *mut T,
+            dma_attrs,
+        })
+    }
+
+    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
+    pub fn alloc_coherent(
+        dev: ARef<Device>,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
+    }
+
+    /// Returns the device, base address, dma handle, attributes and the size of the
+    /// allocated region.
+    ///
+    /// The caller takes ownership of the returned resources, i.e., will have the responsibility
+    /// in calling `bindings::dma_free_attrs`. The allocated region is valid as long as
+    /// the returned device exists.
+    pub fn into_parts(
+        self,
+    ) -> (
+        ARef<Device>,
+        *mut T,
+        bindings::dma_addr_t,
+        crate::ffi::c_ulong,
+        usize,
+    ) {
+        let size = self.count * core::mem::size_of::<T>();
+        let ret = (
+            self.dev.clone(),
+            self.cpu_addr,
+            self.dma_handle,
+            self.dma_attrs.as_raw(),
+            size,
+        );
+        core::mem::forget(self);
+        ret
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space as
+    /// a mutable pointer.
+    pub fn start_ptr_mut(&mut self) -> *mut T {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may given to the device as the DMA address base of
+    /// the region.
+    pub fn dma_handle(&self) -> bindings::dma_addr_t {
+        self.dma_handle
+    }
+
+    /// Reads data from the region starting from `offset` as a slice.
+    /// `offset` and `count` are in units of `T`, not the number of bytes.
+    ///
+    /// Due to the safety requirements of slice, the data returned should be regarded by the
+    /// caller as a snapshot of the region when this function is called, as the region could
+    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases
+    /// where the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()`
+    /// could be used instead.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that no hardware operations that involve the buffer are currently
+    /// taking place while the returned slice is live.
+    pub unsafe fn read(&self, offset: usize, count: usize) -> Result<&[T]> {
+        if offset + count >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
+    /// number of bytes.
+    pub fn write(&self, src: &[T], offset: usize) -> Result {
+        if offset + src.len() >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        unsafe {
+            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
+        };
+        Ok(())
+    }
+}
+
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe {
+            bindings::dma_free_attrs(
+                self.dev.as_raw(),
+                size,
+                self.cpu_addr as _,
+                self.dma_handle,
+                self.dma_attrs.as_raw(),
+            )
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 545d1170ee63..36ac88fd91e7 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,6 +37,7 @@
 pub mod build_assert;
 pub mod cred;
 pub mod device;
+pub mod dma;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.43.0

