Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272A52FE042;
	Tue,  5 May 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970106; cv=none; b=B5UT6Mv4gkgh96PgyxR+jbvA/FK0eEiqRp3c7axsh9XHhCxRf9zkinpsqPFx3WfwM1hZ4ClT7HrwJDk968Lp2wd1BX+nq6Ae4VAOYzyglDRTlnpa/0rYtqI1lLSSEJtMi2ADtnqtszBocq+LeO7O9RJgZGKNrPV99tFzrXpu+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970106; c=relaxed/simple;
	bh=CNn+ZWgh+7C2b9yaEn9pF8xUQEEDo9yAQf2Hl/cr0qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM6Yh9vSx+0iwTGeePtjJ18yzIP6de65otxPX2KboVWd2mO/JhYz8uZkKpUDluPJrPHZdInLro6zbfmOLe6lM9Rux8eNdnp8XvrYneKtTK0igS9YnpT7v0cwwAtpp+U/8C4+duB9Iw6exC2Vu0n0IVLKQZAV2Js42TPQUuld3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=2005.tr; spf=pass smtp.mailfrom=2005.tr; dkim=pass (1024-bit key) header.d=2005.tr header.i=@2005.tr header.b=pgvlf9fT; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=2005.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2005.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=2005.tr header.i=@2005.tr header.b="pgvlf9fT"
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id B115A817D4;
	Tue, 05 May 2026 11:23:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp) with ESMTPSA id cNbAev4RHW20-yCUyAjcM;
	Tue, 05 May 2026 11:23:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=2005.tr; s=mail;
	t=1777969430; bh=2NNDcpVpt7t8ZkO2QIAaCgnk7gCb32YTn7XrqmGXaeE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=pgvlf9fTCXhdHQbk8sWwsqBRX2hcPxx6/cT2RZP2ha40ZNRSwCKyJHIL9u6DiuPP5
	 roeiuYs/XuRPH6/cPKYyVdtamsWTnrIBiYMpxFQXM8kSIddn6NTcv+Bteb/Vx3nHkM
	 4MfxCR/4kahqfAspAuYgS6tvtSc4Qd+gQTykgM/8=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@2005.tr
From: x@2005.tr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	driver-core@lists.linux.dev,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH v3] rust: io: use newtype for PhysAddr
Date: Tue,  5 May 2026 11:23:23 +0300
Message-ID: <20260505082323.37335-1-x@2005.tr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504111421.72130-1-x@2005.tr>
References: <20260504111421.72130-1-x@2005.tr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Favilances Noir <favilances@proton.me>

Currently, PhysAddr is a type alias for phys_addr_t. This means
that physical addresses can be mixed with unrelated integer values
without Rust noticing.

Use a transparent newtype for PhysAddr instead, and update the
affected call sites to perform explicit raw conversions at the FFI
boundary.

This keeps the existing phys_addr_t representation while making
physical addresses distinct in Rust type checking.

Derive Clone, Copy, PartialEq, and Eq for PhysAddr, implement Debug
printing physical addresses in hexadecimal, and add From conversions
between PhysAddr and the raw phys_addr_t type for API ergonomics.

A fallible TryFrom<usize> conversion can be added later if needed.

Signed-off-by: Favilances Noir <favilances@proton.me>
---
v3:
- Re-add Clone and Copy derives as suggested
- Add PartialEq and Eq
- Add From impls for better ergonomics
- Add Debug impl printing hexadecimal values
- Keep explicit conversions at the FFI boundary
- Thanks to Onur and Danilo for the review and suggestions

 rust/kernel/devres.rs        |  8 +++---
 rust/kernel/io.rs            | 49 +++++++++++++++++++++++++++++++-----
 rust/kernel/io/mem.rs        |  4 +--
 rust/kernel/io/resource.rs   |  6 ++---
 rust/kernel/iommu/pgtable.rs |  2 +-
 5 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..beb3723d2519 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -85,10 +85,10 @@ struct Inner<T> {
 ///     ///
 ///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
 ///     /// virtual address space.
-///     unsafe fn new(paddr: usize) -> Result<Self>{
+///     unsafe fn new(paddr: PhysAddr) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
+///         let addr = unsafe { bindings::ioremap(paddr.into_raw(), SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
@@ -114,7 +114,9 @@ struct Inner<T> {
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
-/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
+/// let iomem = unsafe {
+///     IoMem::<{ core::mem::size_of::<u32>() }>::new(PhysAddr::from_raw(0xBAAAAAAD))?
+/// };
 /// let devres = Devres::new(dev, iomem)?;
 ///
 /// let res = devres.try_access().ok_or(ENXIO)?;
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fcc7678fd9e3..e9e8944ddea6 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     bindings,
+    fmt,
     prelude::*, //
 };
 
@@ -21,9 +22,43 @@
 
 /// Physical address type.
 ///
-/// This is a type alias to either `u32` or `u64` depending on the config option
-/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
-pub type PhysAddr = bindings::phys_addr_t;
+/// This wraps either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a `u64` even on 32-bit architectures.
+#[repr(transparent)]
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct PhysAddr(bindings::phys_addr_t);
+
+impl PhysAddr {
+    /// Creates a physical address from the raw C type.
+    #[inline]
+    pub const fn from_raw(value: bindings::phys_addr_t) -> Self {
+        Self(value)
+    }
+
+    /// Turns this physical address into the raw C type.
+    #[inline]
+    pub const fn into_raw(self) -> bindings::phys_addr_t {
+        self.0
+    }
+}
+
+impl fmt::Debug for PhysAddr {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "{:#x}", self.0)
+    }
+}
+
+impl From<bindings::phys_addr_t> for PhysAddr {
+    fn from(value: bindings::phys_addr_t) -> Self {
+        Self::from_raw(value)
+    }
+}
+
+impl From<PhysAddr> for bindings::phys_addr_t {
+    fn from(value: PhysAddr) -> Self {
+        value.into_raw()
+    }
+}
 
 /// Resource Size type.
 ///
@@ -101,10 +136,10 @@ pub fn maxsize(&self) -> usize {
 ///     ///
 ///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
 ///     /// virtual address space.
-///     unsafe fn new(paddr: usize) -> Result<Self>{
+///     unsafe fn new(paddr: PhysAddr) -> Result<Self>{
 ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
 ///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
+///         let addr = unsafe { bindings::ioremap(paddr.into_raw(), SIZE) };
 ///         if addr.is_null() {
 ///             return Err(ENOMEM);
 ///         }
@@ -131,7 +166,9 @@ pub fn maxsize(&self) -> usize {
 ///
 ///# fn no_run() -> Result<(), Error> {
 /// // SAFETY: Invalid usage for example purposes.
-/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
+/// let iomem = unsafe {
+///     IoMem::<{ core::mem::size_of::<u32>() }>::new(PhysAddr::from_raw(0xBAAAAAAD))?
+/// };
 /// iomem.write32(0x42, 0x0);
 /// assert!(iomem.try_write32(0x42, 0x0).is_ok());
 /// assert!(iomem.try_write32(0x42, 0x4).is_err());
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..f21f9038b297 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -254,12 +254,12 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             // SAFETY:
             // - `res_start` and `size` are read from a presumably valid `struct resource`.
             // - `size` is known not to be zero at this point.
-            unsafe { bindings::ioremap_np(res_start, size) }
+            unsafe { bindings::ioremap_np(res_start.into_raw(), size) }
         } else {
             // SAFETY:
             // - `res_start` and `size` are read from a presumably valid `struct resource`.
             // - `size` is known not to be zero at this point.
-            unsafe { bindings::ioremap(res_start, size) }
+            unsafe { bindings::ioremap(res_start.into_raw(), size) }
         };
 
         if addr.is_null() {
diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
index b7ac9faf141d..5dda1061db68 100644
--- a/rust/kernel/io/resource.rs
+++ b/rust/kernel/io/resource.rs
@@ -58,7 +58,7 @@ fn drop(&mut self) {
         };
 
         // SAFETY: Safe as per the invariant of `Region`.
-        unsafe { release_fn(start, size) };
+        unsafe { release_fn(start.into_raw(), size) };
     }
 }
 
@@ -113,7 +113,7 @@ pub fn request_region(
         let region = unsafe {
             bindings::__request_region(
                 self.0.get(),
-                start,
+                start.into_raw(),
                 size,
                 name.as_char_ptr(),
                 flags.0 as c_int,
@@ -137,7 +137,7 @@ pub fn size(&self) -> ResourceSize {
     pub fn start(&self) -> PhysAddr {
         let inner = self.0.get();
         // SAFETY: Safe as per the invariants of `Resource`.
-        unsafe { (*inner).start }
+        PhysAddr::from_raw(unsafe { (*inner).start })
     }
 
     /// Returns the name of the resource.
diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index c88e38fd938a..ae724ca1e8ad 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -182,7 +182,7 @@ pub unsafe fn map_pages(
             (map_pages)(
                 self.raw_ops(),
                 iova,
-                paddr,
+                paddr.into_raw(),
                 pgsize,
                 pgcount,
                 prot as i32,
-- 
2.54.0

