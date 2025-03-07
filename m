Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FC215F6D
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345724; cv=none; b=M+tiDkhan9nL/UUeHf/7K/irhyrzGuipRb4t8w9p2AktYNvLCoMZJj6Qa5TZpHtUa08mWIvbetZfbhC/c0n4moHtZKqHFgCBZpIQIChVyUiVoX/o/ZgVu/7Lzyjbld/eASfGs5UkC0koZtEZGVNG4JxujRT2SKhuQw4fD/b8Zvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345724; c=relaxed/simple;
	bh=wifw/dEujCJ3OVoPR2EsPHuRAc7kCpIPBo1//png4vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSyEzNwh+Lt5HL0709SldVSP9hv+hcnBJjIcrlIumqITr+vuQxtgSqiKuj5lg0Biljxmb2Fqg3Wz7D5d7WRROIcnvQMASi8hn1lhbu1EZzF1Dwy/shjUJPo1mTNXq0RNJPlL/fdggf/9CLvw0KS4sTRpavS34dc26K0Ft/bkA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkyFcWFQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkyFcWFQ"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54965898051so1698179e87.2
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345720; x=1741950520; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0FVS9VLJIIJ6kHkmWCSquWbZ6SxQbrrZYisX5uBmSA=;
        b=NkyFcWFQWHrqSPnxO3JH2yy6UIlpvOw3xvOD7Y/M5mgxg7x1F1agf9aNY+5kIy0XS5
         VF6g/HY9+c5veafid6i0AYIedceyhRcWHExn2z6oE0bwPAiZswmy33Pgiq48GokFbMGt
         czxmkGcTqKMH6Y3a+LmvG3UFI4w8IcoI4SSDSGsg5sc/uqP65VZCu2p4H3MKrx4IQe+v
         MCt/6oE5sfQS0EvTY5AHLPkZsa6a8hCkcR+fGR3YZfZi5egJsxw5gkmiZUf9uW/TqxL1
         yL2rdwQX6W7dk0HwsHHWEqGTKyHraVfmUDi6QoQZpUJFBQBxcHBCXZe/8m8ikZFxkJcS
         Nx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345720; x=1741950520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0FVS9VLJIIJ6kHkmWCSquWbZ6SxQbrrZYisX5uBmSA=;
        b=FeUqHDc5+89eifZsCwGeD4Y021t9woUfwNjeBbAK7z5sshbr3gFaf6h/DySAPboQ51
         he8ev877pBcIrDKkD1U5gBWQEMuilr8PlYBS8J8dJl+AgIpTTDnSu9TFqUAlG7r/Jlh6
         SCHJIKCYNR1pYoiFOUMK6KeCrbytBiKUpZXyx0erwkPsJOS9dMEzKNfr8ZuaK8Md1cbB
         OFyIscTQhACW6NjSFYmK1CMvqQY92J6YTFO10HpDd2ChZC7CWv+CCvDglm2AY2Hyvwjk
         DjQd1Ok6YBFiCfmyeWXaN2ViMZt13wwnqTWZ4cvXUrz4luj0RPZH/DeUKFcPKXKGuB3m
         VaNw==
X-Forwarded-Encrypted: i=1; AJvYcCVB2Zb2XMW8MtW8eJdjGUSGD+++ebIDqkDCThRVFbznB/GgKoChny1Ni0tAXXseoSwNpuVMQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqkb3qqaDPCMdJKJb5v806C0lyZwnvZCFHkCLIUAnbwMZ9KdIb
	kmvTMDuOV3L/faHj7gzbJF9vIai7AvbMKh7HBA2/bpvRYXGz68+9
X-Gm-Gg: ASbGncsgwrYhf9zYwopgU4dTUtAIx1U9FIFZMCi0hZR1hO6RL9Ia9BqsRMDwkP5ZrPM
	oQXNr25pbFgv1ybNJH0xEwCta/STDSHdEkmZrg2IKK/M72ZbV1R4Wfw4Bi5Rq3EUf5dGSS3p+dQ
	C5f2M+vDu7nUBhbfS22VIFeBFRG0A61OdgJpsQ1iFAVp/QIcN+ZVcopIIHCvBD5waKA1hTs7AWi
	p9plMYn7GBkYMLfqPAelbMcwHjsRLkAHpvsSXKHz2JbSRSIMLEccMA7lnLG6fqgb8egjTQT+jMG
	oxicdvw2JILsiBoIU/ImZWOr8MSpBhat77KhPGNEvyK27dbBjMvDlRo10JR2PXhQQQ417atyI9R
	Gf/tV9S09WaenbJLS5zKOlQ==
X-Google-Smtp-Source: AGHT+IHtERMjJN0wtv6/JAlhVWXUoGZyadEVLU0EhqhPw3wRQN3LEAPG7QX6lyT89Ml2GPPXGSMgpg==
X-Received: by 2002:a05:6512:b14:b0:549:9044:94ab with SMTP id 2adb3069b0e04-54990eb17b0mr961360e87.35.1741345719218;
        Fri, 07 Mar 2025 03:08:39 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:37 -0800 (PST)
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
Subject: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
Date: Fri,  7 Mar 2025 13:06:19 +0200
Message-ID: <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
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

A CoherentAllocation is wrapped in Devres which basically guarantees
that a driver can't make a CoherentAllocation out-live driver unbind.
This is needed, since DMA allocations potentially also result in
programming of the IOMMU. IOMMU mappings are device resources and
hence the device / driver lifecycle needs to be enforced.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 378 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 380 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f46cf3bb7069..bf1110590c19 100644
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
index 000000000000..8a250242641c
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings, build_assert,
+    device::Device,
+    devres::Devres,
+    error::code::*,
+    error::Result,
+    transmute::{AsBytes, FromBytes},
+    types::ARef,
+};
+use kernel::prelude::*;
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
+/// use kernel::{device::Device, devres::Devres,};
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// # fn test(dev: &Device) -> Result {
+/// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
+/// let c: Devres<CoherentAllocation<u64>> =
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
+    /// use kernel::{device::Device, devres::Devres,};
+    /// use kernel::dma::{attrs::*, CoherentAllocation};
+    ///
+    /// # fn test(dev: &Device) -> Result {
+    /// let c: Devres<CoherentAllocation<u64>> =
+    ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_attrs(
+        dev: &Device,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+        dma_attrs: Attrs,
+    ) -> Result<Devres<CoherentAllocation<T>>> {
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
+        let devres = Devres::new(
+            dev,
+            Self {
+                dev: dev.into(),
+                dma_handle,
+                count,
+                cpu_addr: ret as *mut T,
+                dma_attrs,
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(devres)
+    }
+
+    /// Performs the same functionality as [`alloc_attrs`], except the `dma_attrs` is 0 by default.
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        gfp_flags: kernel::alloc::Flags,
+    ) -> Result<Devres<CoherentAllocation<T>>> {
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
+        // SAFETY: By the safety requirements field is valid.
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
+        // SAFETY: By the safety requirements field is valid.
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
+/// use kernel::{device::Device, devres::Devres,};
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// struct MyStruct { field: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(reg: &Devres<CoherentAllocation<MyStruct>>) -> Result {
+/// let alloc = reg.try_access().ok_or(ENXIO)?;
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
+/// use kernel::{device::Device, devres::Devres,};
+/// use kernel::dma::{attrs::*, CoherentAllocation};
+///
+/// struct MyStruct { member: u32, }
+///
+/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
+/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
+/// // SAFETY: Instances of `MyStruct` have no uninitialized portions.
+/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
+///
+/// # fn test(reg: &Devres<CoherentAllocation<MyStruct>>) -> Result {
+/// let alloc = reg.try_access().ok_or(ENXIO)?;
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
+
+/// Helper function to set the bit mask for DMA addressing.
+pub const fn dma_bit_mask(n: usize) -> u64 {
+    if n > 64 {
+        return 0;
+    }
+    if n == 64 {
+        !0
+    } else {
+        (1 << (n)) - 1
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..8e76ef9b4346 100644
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

