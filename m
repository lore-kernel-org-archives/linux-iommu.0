Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8071E8344
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237653; cv=none; b=E1PPbQoGbkij+FnftFZp7P9RU6r/ZnhjPykREzht92keXEl0L2+AKryT25lO2UD/cH2WcOD5gf0W3F+BRMlw8mO+siVbx22hNhVSTaY8RezEiaCaoduv/lt3DLR65QN4/BG0U+86tOGRL6i43fHvs2+d6faYLlZe9A07spNpKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237653; c=relaxed/simple;
	bh=oGOFIMrjfL+4XU5dP1wcQjBFQeScz806Bd7Lj3UJZ+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyZBG0PcJF7/s39a/PBlvgt2hRAlmCR8UpkjRT4hJFKCXtVwD98wBGByWet9agwTtvfoIGxDewIXz8z1n7lSg1kJp20CtRnK/KPTKY6jV+7lbedBybVKabbpuN696X0nQs9HA2x0kI0WSoCyRNeWGNCtIIYM3WXlZv1vfK3g70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ5AHawN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ5AHawN"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54996d30bfbso4340830e87.2
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237649; x=1742842449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM0eQ1obKbtILGTTnzK/VCxxqxPjEtxURVU4+ANPojg=;
        b=mJ5AHawNK5gpmOO7GlxlhjA/LWImZ2ublyxCQYeY/7qUcVUeWJUHw+nbHJvVA4zgHN
         Km1GFIwyq8U3pRoSW0BYMncbESY9K6JTuakvM8DPI+eXZfwiPv/Lwto8tNsTM284riSG
         yDOhDCy7mvYohrkQRPZB1aa1wrfDBV+E+DT2YOXSm4xL4+zEBphzWkAKIHZvgbiFBg2j
         X7XWTwJXWw6bL9cuyZ45+rlTz1dZwWGBkrhK40VPAupGErAPQlNcnwBp4y0Ht1ld/95f
         78XH86nLPoG2/ktP7cIfDZ044AcWJWxOBchdO3Q7dM2oLnp9L9hm2i5PKw/9w4m322+6
         npyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237649; x=1742842449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DM0eQ1obKbtILGTTnzK/VCxxqxPjEtxURVU4+ANPojg=;
        b=DZ0a73gH0biQDVEW4be6AzTKcTQc3Bk/Hn1k1oAa/IsPDCTEEebpHW/nlP+B7AWuoP
         N1ZIWuFOp9Bk7Je6h9N5MjiGiBSZSkEnJtpCHVGuz+fODFRjvdI1Q5FHvsBlxdebCTpS
         HPuFejjZ/nipo9jvGN/YYc6ns0WCyCR3cPGCR8ldmyZD712wzvIwL/6ETDyoBnuLO5Gc
         b72vicuu2YDWCfvMC7PAJ9Q4mThed9hDi2wcDrESqMOFdA154SXkC5SBf6AZU3MK9GjB
         ryZscCw/E8Xo6Bclb/i94H6WHOA1yyY0Bit8rWEwVERiMoDUD7e9jUGXKx7QDdamZK13
         qXWg==
X-Forwarded-Encrypted: i=1; AJvYcCUrW/AZIyqUBJE1OU6gnxJKNHRTSAKWMxVFlkpEL7pJEb0KmTZA3BKusDpsGyppFVuZmgtR4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo5wnHlGvvxFXmNGMZHupAvWemTNDuE+EDvU7LV5QbVnB+AQFt
	0f7t3p9WvKrMEQnkomFjfO+uK8ghxfksrrMWBouDPKGrjn/jz0JH
X-Gm-Gg: ASbGncvIgKepGxAre/lhWY2F7kc0PRUlg2yXS290GYTtH1oxaFfhVUqj3CIjqyepuWb
	NsyrXBUNxbCwzvftF8KcCAsUGl6op9O2USj96R68PZSfYOyVronU2YC+B+aIfaEY0DRBkaJoNpV
	0skrbtjfpDQDbdMoOcoeeg6aKA53cPqG9jAMdFAwXxgxd6AtuESwV2P+Iry+LLlWROz5STuE5Vl
	Rxi4SjOiV+A0VBPTb14bXK7uQfz8N9wBA4dWM0bYEcWsxPLaddqTPlY2nMgaIEOIVr4mzkEhqPT
	f7v65Iz6+bQ3BRKDdDc55Cmy1aslszpKKtLFTdQHC4CeHw3FMMnsMe6jx+0k9jsL3/q2AVEJoxp
	eLO56mPnTz2NcHWcoYzfPwQ==
X-Google-Smtp-Source: AGHT+IFnnedBdplgL64PWBV49Hy+Jry/u8OoNeqEanEXgzNG/BKD9z4voKdW4Uvd0DjiuRK/61Cf8Q==
X-Received: by 2002:a05:6512:3e14:b0:545:8c5:44cb with SMTP id 2adb3069b0e04-549c3921986mr8810314e87.31.1742237649071;
        Mon, 17 Mar 2025 11:54:09 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:07 -0700 (PDT)
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
Subject: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
Date: Mon, 17 Mar 2025 20:52:09 +0200
Message-ID: <20250317185345.2608976-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 387 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 389 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae39fc18a8bf..ccb988340df6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
+#include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..9d00f9c49f47
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,387 @@
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
+///
+/// # Examples
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// # fn test(dev: &Device) -> Result {
+/// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
+/// let c: CoherentAllocation<u64> =
+///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
+/// # Ok::<(), Error>(()) }
+/// ```
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
+/// DMA mapping attributes.
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
+/// For the lifetime of an instance of [`CoherentAllocation`], the `cpu_addr` is a valid pointer
+/// to an allocated region of consistent memory and `dma_handle` is the DMA address base of
+/// the region.
+// TODO
+//
+// DMA allocations potentially carry device resources (e.g.IOMMU mappings), hence for soundness
+// reasons DMA allocation would need to be embedded in a `Devres` container, in order to ensure
+// that device resources can never survive device unbind.
+//
+// However, it is neither desirable nor necessary to protect the allocated memory of the DMA
+// allocation from surviving device unbind; it would require RCU read side critical sections to
+// access the memory, which may require subsequent unnecessary copies.
+//
+// Hence, find a way to revoke the device resources of a `CoherentAllocation`, but not the
+// entire `CoherentAllocation` including the allocated memory itself.
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
+    /// let c: CoherentAllocation<u64> =
+    ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
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
+        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
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
+    /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
+    /// `dma_attrs` is 0 by default.
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attrs(0))
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
+    /// Returns a pointer to an element from the region with bounds checking. `offset` is in
+    /// units of `T`, not the number of bytes.
+    ///
+    /// Public but hidden since it should only be used from [`dma_read`] and [`dma_write`] macros.
+    #[doc(hidden)]
+    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
+        if offset >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { self.cpu_addr.add(offset) })
+    }
+
+    /// Reads the value of `field` and ensures that its type is [`FromBytes`].
+    ///
+    /// # Safety
+    ///
+    /// This must be called from the [`dma_read`] macro which ensures that the `field` pointer is
+    /// validated beforehand.
+    ///
+    /// Public but hidden since it should only be used from [`dma_read`] macro.
+    #[doc(hidden)]
+    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F {
+        // SAFETY:
+        // - By the safety requirements field is valid.
+        // - Using read_volatile() here is not sound as per the usual rules, the usage here is
+        // a special exception with the following notes in place. When dealing with a potential
+        // race from a hardware or code outside kernel (e.g. user-space program), we need that
+        // read on a valid memory is not UB. Currently read_volatile() is used for this, and the
+        // rationale behind is that it should generate the same code as READ_ONCE() which the
+        // kernel already relies on to avoid UB on data races. Note that the usage of
+        // read_volatile() is limited to this particular case, it cannot be used to prevent
+        // the UB caused by racing between two kernel functions nor do they provide atomicity.
+        unsafe { field.read_volatile() }
+    }
+
+    /// Writes a value to `field` and ensures that its type is [`AsBytes`].
+    ///
+    /// # Safety
+    ///
+    /// This must be called from the [`dma_write`] macro which ensures that the `field` pointer is
+    /// validated beforehand.
+    ///
+    /// Public but hidden since it should only be used from [`dma_write`] macro.
+    #[doc(hidden)]
+    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: F) {
+        // SAFETY:
+        // - By the safety requirements field is valid.
+        // - Using write_volatile() here is not sound as per the usual rules, the usage here is
+        // a special exception with the following notes in place. When dealing with a potential
+        // race from a hardware or code outside kernel (e.g. user-space program), we need that
+        // write on a valid memory is not UB. Currently write_volatile() is used for this, and the
+        // rationale behind is that it should generate the same code as WRITE_ONCE() which the
+        // kernel already relies on to avoid UB on data races. Note that the usage of
+        // write_volatile() is limited to this particular case, it cannot be used to prevent
+        // the UB caused by racing between two kernel functions nor do they provide atomicity.
+        unsafe { field.write_volatile(val) }
+    }
+}
+
+/// Note that the device configured to do DMA must be halted before this object is dropped.
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
+        // The cpu address, and the dma handle are valid due to the type invariants on
+        // `CoherentAllocation`.
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
+
+/// Reads a field of an item from an allocated region of structs.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
+/// let whole = kernel::dma_read!(alloc[2]);
+/// let field = kernel::dma_read!(alloc[1].field);
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+macro_rules! dma_read {
+    ($dma:expr, $idx: expr, $($field:tt)*) => {{
+        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+        // dereferenced. The compiler also further validates the expression on whether `field`
+        // is a member of `item` when expanded by the macro.
+        unsafe {
+            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
+        }
+    }};
+    ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
+        $crate::dma_read!($dma, $idx, $($field)*);
+    };
+    ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
+        $crate::dma_read!($($dma).*, $idx, $($field)*);
+    };
+}
+
+/// Writes to a field of an item from an allocated region of structs.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::device::Device;
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// struct MyStruct { member: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(alloc: &kernel::dma::CoherentAllocation<MyStruct>) -> Result {
+/// kernel::dma_write!(alloc[2].member = 0xf);
+/// kernel::dma_write!(alloc[1] = MyStruct { member: 0xf });
+/// # Ok::<(), Error>(()) }
+/// ```
+#[macro_export]
+macro_rules! dma_write {
+    ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
+        $crate::dma_write!($dma, $idx, $($field)*);
+    }};
+    ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {{
+        $crate::dma_write!($($dma).*, $idx, $($field)*);
+    }};
+    ($dma:expr, $idx: expr, = $val:expr) => {
+        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+        unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+    };
+    ($dma:expr, $idx: expr, $(.$field:ident)* = $val:expr) => {
+        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+        // dereferenced. The compiler also further validates the expression on whether `field`
+        // is a member of `item` when expanded by the macro.
+        unsafe {
+            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+            $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
+        }
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c92497c7c655..001374a96d66 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod device;
 pub mod device_id;
 pub mod devres;
+pub mod dma;
 pub mod driver;
 pub mod error;
 pub mod faux;
-- 
2.43.0

