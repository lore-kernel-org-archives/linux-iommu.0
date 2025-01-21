Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7A1BEF6E
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449326; cv=none; b=mg0fzpnzdZHfInyv4ZfHYRYSFwnq2gKXQ+evbRhWNoLPXRB5lyMBmoA6FTusfjIW1oSe+/wKhU8tRv6NWkh1XRwhQWc9zTm9J2PXVL90VPEAl47hwAO29bueD0aT3RUW4blirbm7A3tfDyLtUNnksjCnsZFb89wUjMsWepaVn8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449326; c=relaxed/simple;
	bh=dffPxo/yF55U8AlImHFUM4SJkEFBKP1Tfwn4583Drvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJiJ3O0BEoKBqNqUextvRTQGi8iAL29IZdszD3n3NDoubzK+A/jME2G7I2H2GgAzTz2H2WCrN6mIXj6jtbZxPOIb4Il6JS1E9QOohcVyJA32Fgrxj/XtgXNpIqL/syYr1CR/wPruM8ubzInb6je/602K6jhQZjXOJE3IGB1mOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqlqwF++; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqlqwF++"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso5362455e87.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737449321; x=1738054121; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWEC9dme17QjxSSaKuiGallOB2fmsiUY7mEJTTsr2WU=;
        b=aqlqwF++8iliOd1agUit4Ad7Y+vNACHemwSzIE0jXSfuwSbaXydSBmRFOFoYLoHjEb
         JqhLSehXFv2J5rGIvs2mCOr0N4X0bJ7l8Pzo/Rp+FnUMRBEr8qgXy84MvBJk7U9g7icW
         X67f49ZSkGRSKb4d5OB/pJJXGM1pThyt+wJc0rVcIHsvORQoM+Rbf5xJeazgJMF9+XM4
         vvxXeWCtlzdvNhDKFCZI9kb6cMpmTYJ3RunCfHLcj+B5hohAWPJ3DH2kxyKnE3ZTYYNd
         6u/5bRgrdKdqpjyhdc9F8HDKSpYX1ItjyVTW7uiVycFcGtID4vKRxU8RZd3lMC6nS3u0
         GC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449321; x=1738054121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWEC9dme17QjxSSaKuiGallOB2fmsiUY7mEJTTsr2WU=;
        b=mjiKtEP36U1ITE8+fnt4/LUnQDdw7EbmP0B0lbktZedPV4B3qiGOSiDi0IHY0BwaXq
         e9s3FZw0W0tHfjmQ5WKcY/oHcpM9kuVZ9zkvwRS/5X2jjq3VPsbAcUaI5hz+4cW8KxV4
         rZ+ec4xOSoqyR/WgFJNesVtU3m3ozFrSdeboHObvDS1SEC0ReFlVVClwXSDJYCDnjsdi
         yAA6RVXZYla9U5EouVS1yautZW5aeGChoHQWFuVSgwzsA/oRIY8/kP99r/o7fkr4VnE/
         23N8SDTxuyS9sBfNqTJr31Q3iDtC22umE2+rRfTIJDoZUfwync2SMDGIS0tONdEbVLQR
         ZmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhFCRxz9otYYAX9Ox/2AhOMcuWIaATm0V+PabW//JjeOaJsaqZmHx4m2Vh7UG6Y0gOOvUm2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUpaLO78Qm+GxM2gnFb+Pfvzd3Xg41bCqas355HhYgJ52dRZ0E
	BYaqDoUfTwhKPRl0kb3lmU5pk6wqVKcbuJcjy182Xx0zTwIbuZ02
X-Gm-Gg: ASbGncsBpNiJs+a5VuuW5im1jnTvqr7APi5a3cPzPlDk3UZ94DZ+m0WDgwVfWBx5td+
	mYTGvznr1v1ZM+kLH4Vt5/SKCdNP/2Nt8UN4aXJnUnYdeI4AbUGfk6Bs4UNaAkv0L5z8iE4bZ6p
	H6a2qn6VbeKC1PUYPVl4/a+jojgGMsbP9yUMi2aKkmCxMQLei5/1VhX1LifkmiC4J5vLZJ3+o92
	AA9yFhpc3etK2Nj7ZO5jChOBfJ7YzvnXYNqD8brgKS9eCltw4VHH82okEM0JCjLnBEpPu5qiBEp
	gJNoz9jvFomDX6eGJodlya28H4iJDzr9tSSZC0JF
X-Google-Smtp-Source: AGHT+IFxUDsjDEZF6OTPoTSBFnfC3GHMDWgyuPjhLhgsV+N/pYXCfKqwnjwuD1OEwwhuZCwc7n/efw==
X-Received: by 2002:ac2:59c8:0:b0:541:4900:7c42 with SMTP id 2adb3069b0e04-5439c286b53mr6223447e87.43.1737449320999;
        Tue, 21 Jan 2025 00:48:40 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed5c7sm21178651fa.82.2025.01.21.00.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:48:39 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel@sedlak.dev
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
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v9 2/3] rust: add dma coherent allocator abstraction.
Date: Tue, 21 Jan 2025 10:47:46 +0200
Message-ID: <20250121084756.1051758-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
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
 rust/kernel/dma.rs              | 272 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 274 insertions(+)
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
index 000000000000..66d1bed887d3
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,272 @@
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
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL,
+    ///                                                                  DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_attrs(
+        dev: &Device,
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
+            dev: dev.into(),
+            dma_handle,
+            count,
+            cpu_addr: ret as *mut T,
+            dma_attrs,
+        })
+    }
+
+    /// Performs the same functionality as `alloc_attrs`, except the `dma_attrs` is 0 by default.
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
+    }
+
+    /// Returns the base address, dma handle, attributes and the size of the allocated region.
+    /// The caller takes ownership of the returned resources, i.e., will have the responsibility
+    /// in calling `bindings::dma_free_attrs`.
+    pub fn into_parts(self) -> (*mut T, bindings::dma_addr_t, crate::ffi::c_ulong, usize) {
+        let size = self.count * core::mem::size_of::<T>();
+        let ret = (
+            self.cpu_addr,
+            self.dma_handle,
+            self.dma_attrs.as_raw(),
+            size,
+        );
+        // Drop the device's reference count associated with this object. This is needed as no
+        // destructor will be called on this object once this function returns.
+        // SAFETY: the device pointer is still valid as of this point due to the type invariants
+        // on `CoherentAllocation`.
+        unsafe { bindings::put_device(self.dev.as_raw()) }
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
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.wrapping_add(offset), count) })
+    }
+
+    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
+    /// number of bytes.
+    pub fn write(&self, src: &[T], offset: usize) -> Result {
+        if offset + src.len() >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        unsafe {
+            core::ptr::copy_nonoverlapping(
+                src.as_ptr(),
+                self.cpu_addr.wrapping_add(offset),
+                src.len(),
+            )
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

