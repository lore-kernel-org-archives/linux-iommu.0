Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426122C35A
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869012; cv=none; b=eEDnFPzL6NAtSF1sCL7/QjfwAuBBMTPav0xySuQe5PR1didBRkn6KFk3S5srEJS8BTqAHGR/ry238SQieYaOKcHiPap+oODuzBvHfE1WK/7Kg8p3oj5H5pzRRPodGT6erhLa8B+Sraj7uHe2U1+VMtYPiXanaICSBPMNfzkunYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869012; c=relaxed/simple;
	bh=2minwxRqaLd9Jk2fYu6/XdgIGwZe6avCKpeQoVOq/k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2jhlYMDJh7RM25RsxUGgyBHQei9vhgZ5vcRRWMonnQvHprXLqhPnM5Zvc4CUmC+xao067ti/QtUHB3fnxaG1ajII4aaSasWWiiHrF9xgdpO8cMROADNdRM7zbL37Pn2s1UeEdT8nIdKKwEqb6yYlMTk296DScyIprVkAIeeBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTu/eSi9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTu/eSi9"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5401ab97206so2692655e87.3
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869008; x=1734473808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecos7G9LvxcuUTpaed3jRSW8Gq1jvBENI3n1ac84Xmg=;
        b=KTu/eSi9Fmt7Wb3/B4Le1omyxNXA/tfrwxaIF5ALXJPtUoj1GsMzPLTTQ2sAtusoON
         3/H4qfA2h+X6B5v1w9Uvt2LKxbq+hiFJZk5aNp1a4VdH8ZJW+oWDNk4KKZa7LyXszvJ8
         kP4ZwGhvjJ8mz7cd3GAu/m6xvNsvIVSsIcNOv1uzgx3s0dsf3eZkxg1nc3Wi2jMfkiD+
         M3xoyld21CjiEV0TQRYbg8ywlpmQ+FK5zzQ0KQO3Wi78PYhJMMKBhleqoSf1NLnGCHj0
         /6mY6aZUKZmXR95kRttY/ji16RJB0ip/lAFsOcaPyYJEswCd6Ltyp3y3qSeauSbZz9Le
         1+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869008; x=1734473808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecos7G9LvxcuUTpaed3jRSW8Gq1jvBENI3n1ac84Xmg=;
        b=IiToAi3Iqoe5bMVw0QBw+Zx3wltG45H3AYre9frv8QVJmR3xPYZstgDnWxUUPn7c9E
         jaTPvX43JjA/WoR6FaNRviBe9DCBgsQTdzn/6QuGOXqhojE/XAew3kMQhmfnA1f+obhv
         sKXlbMt/jcVIgNwMzrRz3aOA1B51/7684EGqhgHaHgdLkgpLFJaHDY6QuVRnjmaNHUxa
         LK8dNMtf431aOPOMlRt/mqXgoOnFUi1lTJZD8VKO0AcBqUOsZBX1ySywxvpDpTn+6n5G
         P20RqSubbsD8x4mqitGmaj7V5+5SISGXz6HqJnzHeL162mTPa7ndysvg2mlHZOOyUBW6
         59YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm0th+vYRaz/DkmndVbv6Jbe8QW5ZpngqWPPNss5mBnAFoLlfnWVBj9+Q6nxs65bKaUShimQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0zxalsGGnTILaZU9YaKyyWPturFhioG0uUwU8TA4DNKz+KOVG
	uebkD6y2jPepBMUdkgPLXhKgn9J98MVvyvc3XXJa3z54z+w9+SyP
X-Gm-Gg: ASbGncsp79Eryj4vpb9/mF9B3H9h4jA4VVZqK1S4GLWzz4wunSMY4PR5nlD+g/iBEcV
	ulbi78Xb34LIY75DP+4bClAQqkhPv9rGq2fe5Dz0TV1yRMHMHmVbqE1kvRxI+RIR26mY+wyjZ6D
	ywB6v2hDihSRTG5DtnIPou6yDJScY10FMDXmb+pFq24PoORAzxZu6hFKkdaH/yi9MUq1ayVksfW
	5jWeF8dunZX7FBhubgNxyFJm6ygZG3GK84karVh+jYd8CMaJEoBkfxk0xMXIv1ammT+5spoEVGJ
	SOiEYgLVVVWBjgnISoixgEBV
X-Google-Smtp-Source: AGHT+IFpI5c0LaM0OcTwuHYjM5hJRabuF/hLS5+6OA/7AmnFCLocH/U5OLOQkM/GYDj0Q3P99UlBZA==
X-Received: by 2002:a05:6512:15a5:b0:53e:6503:8b89 with SMTP id 2adb3069b0e04-5402a575ceamr163883e87.0.1733869007988;
        Tue, 10 Dec 2024 14:16:47 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34a4531fsm1472694e87.262.2024.12.10.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:16:46 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
Date: Wed, 11 Dec 2024 00:14:59 +0200
Message-ID: <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 223 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 225 insertions(+)
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
index 000000000000..29ae744d6f2b
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings,
+    build_assert,
+    device::Device,
+    error::code::*,
+    error::Result,
+    types::ARef,
+    transmute::{AsBytes, FromBytes},
+};
+
+/// Possible attributes associated with a DMA mapping.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`attrs`] module.
+#[derive(Clone, Copy, PartialEq)]
+pub struct Attribs(u32);
+
+impl Attribs {
+    /// Get the raw representation of this attribute.
+    pub(crate) fn as_raw(self) -> u64 {
+        self.0.into()
+    }
+
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Attribs) -> bool {
+        (self & flags) == flags
+    }
+}
+
+impl core::ops::BitOr for Attribs {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Attribs {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Attribs {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// DMA mapping attrributes.
+pub mod attrs {
+    use super::Attribs;
+
+    /// Specifies that reads and writes to the mapping may be weakly ordered, that is that reads
+    /// and writes may pass each other.
+    pub const DMA_ATTR_WEAK_ORDERING: Attribs = Attribs(bindings::DMA_ATTR_WEAK_ORDERING);
+
+    /// Specifies that writes to the mapping may be buffered to improve performance.
+    pub const DMA_ATTR_WRITE_COMBINE: Attribs = Attribs(bindings::DMA_ATTR_WRITE_COMBINE);
+
+    /// Lets the platform to avoid creating a kernel virtual mapping for the allocated buffer.
+    pub const DMA_ATTR_NO_KERNEL_MAPPING: Attribs = Attribs(bindings::DMA_ATTR_NO_KERNEL_MAPPING);
+
+    /// Allows platform code to skip synchronization of the CPU cache for the given buffer assuming
+    /// that it has been already transferred to 'device' domain.
+    pub const DMA_ATTR_SKIP_CPU_SYNC: Attribs = Attribs(bindings::DMA_ATTR_SKIP_CPU_SYNC);
+
+    /// Forces contiguous allocation of the buffer in physical memory.
+    pub const DMA_ATTR_FORCE_CONTIGUOUS: Attribs = Attribs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
+
+    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// to allocate memory to in a way that gives better TLB efficiency.
+    pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attribs = Attribs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
+
+    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
+    /// __GFP_NOWARN).
+    pub const DMA_ATTR_NO_WARN: Attribs = Attribs(bindings::DMA_ATTR_NO_WARN);
+
+    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
+    /// ideally inaccessible or at least read-only at lesser-privileged levels).
+    pub const DMA_ATTR_PRIVILEGED: Attribs = Attribs(bindings::DMA_ATTR_PRIVILEGED);
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
+    dma_attrs: Attribs,
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
+        dma_attrs: Attribs,
+    ) -> Result<CoherentAllocation<T>> {
+        build_assert!(core::mem::size_of::<T>() > 0,
+                      "It doesn't make sense for the allocated type to be a ZST");
+
+        let size = count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
+        let mut dma_handle = 0;
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        // We ensure that we catch the failure on this function and throw an ENOMEM
+        let ret = unsafe {
+            bindings::dma_alloc_attrs(
+                dev.as_raw(),
+                size,
+                &mut dma_handle, gfp_flags.as_raw(),
+                dma_attrs.as_raw(),
+            )
+        };
+        if ret.is_null() {
+            return Err(ENOMEM)
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
+    pub fn alloc_coherent(dev: &Device,
+                          count: usize,
+                          gfp_flags: kernel::alloc::Flags) -> Result<CoherentAllocation<T>> {
+        CoherentAllocation::alloc_attrs(dev, count, gfp_flags, Attribs(0))
+    }
+
+    /// Returns the base address to the allocated region and the dma handle. The caller takes
+    /// ownership of the returned resources.
+    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
+        let ret = (self.cpu_addr as _, self.dma_handle);
+        core::mem::forget(self);
+        ret
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr as _
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
+    /// Returns the CPU-addressable region as a slice.
+    pub fn cpu_buf(&self) -> &[T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
+    pub fn cpu_buf_mut(&mut self) -> &mut [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
+    }
+}
+
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
+                                          self.cpu_addr as _,
+                                          self.dma_handle,
+                                          self.dma_attrs.as_raw(),) }
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

