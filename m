Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747581FA260
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339318; cv=none; b=Oy67c8hJQ+9aKjlTjKxN2eiYYIjUmgwjHmFcMpHvsJLm66gsnuwew2JgjtHHal3Yi4w7a813sE7VUKsi7iQQ+2D+5QeGPK194NbmLYX4Ag0oIV46gbfVb9s/lX0wStSoDUMuDbItZnBXcxgAjpbywSHD6aLOZ9KMOvxDVDJBN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339318; c=relaxed/simple;
	bh=2BwwfipFvu8t7D+gTPEBw9gzaEqFY9AHFMcZn2BEQHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB4G0DKxSJxNFUrWAJ+wNDLLLJdHO2Vjyi26Swge7Cj6ggXI6oVjqBtYCaGRqjUdOCkLH4XVUB70nWkcTQeozFSSxfbeSD2YmGjzl9fZvuth3DbJKL7wYQu8/iJvpLn2au6w+DAGr2aRovk/MYs3TR7JwQFfKx6I84D5kE4g88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Suo/IHTK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Suo/IHTK"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3003e203acaso165516771fa.1
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736339315; x=1736944115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xZZ3yNkLB+sNAA/LBpLvEhrY9sh0ePsbmghyTjHX2E=;
        b=Suo/IHTKUmXLoOX8r3aMUQDFg+Ug6Di9MIGKepR3+dsDPdkj52mK98QXpfG5LyShN8
         M1H7mglKokU0blMD3NTLhpcr3p2dBdHzQE0fNMmWL5lPQQGXolUA81EwVrxcF+SNuVkX
         BVlwfWH43hwKMgHDRdZC0hOJpgw5p03Nc8avZXQGmwEnXyU5g/owRjzCYePQidwEnAae
         6ovuooVUooLFYcmKndWDFNJUrqhpzEhZKlWVjYS4ll4OkKb3n/x1x8nvrQemzqhPTqO0
         ErdirbpFVFdq2HGjDwaqF0jAw/DjwCngVUixIEy1GTmmeZVuth1IWRENgxGdUZ94dUoI
         KwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339315; x=1736944115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xZZ3yNkLB+sNAA/LBpLvEhrY9sh0ePsbmghyTjHX2E=;
        b=jtlINvXqU03ML3bHzfjA1siagwExkiuhDNkj+YBzziXODMhqjJjoplyWwE7yHYUPQr
         JZhQO4DKY/k4hDkuedpkM9n6+gK2cGlA3aX9xBNuVeXjny2DGs1i9TlIV3aFZKe4Jp/c
         i+y1DUT0uGfTgVLhqghu4dO6Cx6Ly8/dnIZmRd4acDHYMtxoD8SCZ8plF1eVjbeK0QuU
         eggUk+UDj0KRFFqh9BYEeMt9hkBeTi8iePIWXZelICidKU/m3Rswkfzio5j7sEVFyAqz
         nfYQyGuXWHZAvh86cGkSt+mzjgFFnluZHJ5SLTY3dD//3ONkdKtRF8J3AaqRm/XFjn3h
         CCBg==
X-Forwarded-Encrypted: i=1; AJvYcCUmcHR10ZHDIiFXvCUzT+axBxfsBm2IgnP+V/nxMUrLuoKhKNkaja5ilDk9tofTQ6nGAl9CnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxUGaYogH0ojmdjB/3kt9Y40qJd0X3b/4y3WREccQ2lQMdLtdO
	1JT4atuSCociP8mJXIJVEXZMH7KAV3T5pwY9A0Z1k0Pmle/EfXm9
X-Gm-Gg: ASbGnctjiVDLtsYWfDbPoVSiKYyNCoQDPlfbDvgkueXAS1tozxQLhgvMH34SrzUj2wu
	Tk2VJpQFmUMweOMnXPBs3blGYmoOMmOHIftgWudp62kkn628UT6aZPDDtdO7X3WPpK5rUIt2zQS
	ylLxE1LTPBWZwteAVmRJCw1EelVkRHeR8AVMFvjjyYyop+mKRcEW2AjWBuk++K3IRZbJIOBEsMF
	VHsnt1AH15CFP/pSHm2UWcW2gFa4FgFi9fojXPQWqurgG04ozUihiIU16zQMNRGElpUMC9E7tpV
	5BstMMwPrlFo5XUTop7Y43t0bZU=
X-Google-Smtp-Source: AGHT+IEfCYar0sKyJ4/FULPbik3D/ZHdWRTbjRbx++csRT4HaEL8g6F6cajrlilVNEdDKyX6oU9U2g==
X-Received: by 2002:a2e:a716:0:b0:300:4362:40 with SMTP id 38308e7fff4ca-305f463cf58mr5169171fa.36.1736339314252;
        Wed, 08 Jan 2025 04:28:34 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b082db8sm61183911fa.99.2025.01.08.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:28:33 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com,
	aliceryhl@google.com,
	robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Date: Wed,  8 Jan 2025 14:27:24 +0200
Message-ID: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
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
 rust/kernel/dma.rs              | 271 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 273 insertions(+)
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
index 000000000000..c0661bcc9f72
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,271 @@
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
+pub struct Attrs(pub u32);
+
+impl Attrs {
+    /// Get the raw representation of this attribute.
+    pub(crate) fn as_raw(self) -> usize {
+        self.0.try_into().unwrap()
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
+    pub fn into_parts(self) -> (*mut T, bindings::dma_addr_t, usize, usize) {
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
index e1065a7551a3..6e90ebf5a130 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 mod build_assert;
 pub mod cred;
 pub mod device;
+pub mod dma;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.43.0

