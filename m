Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6737DE85;
	Mon,  4 May 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893903; cv=none; b=WEJR/beHsXHRz9iS3uT95z83iB+jjFmpL7yA/Mh5SDVkXckMVgfE+6yb+QchWwVbmYhScoERoW8ul0zoue7zAUZ+dxGZgG2xQeW+1sXuIcZyFbOmIg1OH5i/BrP5LxezZCQE39uumgk34BLQC92jb7t6yhQ4DsflPIs9zWf86D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893903; c=relaxed/simple;
	bh=tUzzMutq4Sx7of0cMGJidiHPmwK9ZP0wtz5XQHd8UAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQWfJxjWp9lGdMtWKewaWxqgbhXKtiqHJhw5DCY5xLS2267tc0CqzStCc6ORZrzaqAjr8bHOItltKczG6xOT28wm3cynM0OomJAFg1qaH6uXPGVUJbD/eMJoOhK+QomFTQstb0NnkKf40Y9n5qirfFn96t6/GpXahywYOntSEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=2005.tr; spf=pass smtp.mailfrom=2005.tr; dkim=pass (1024-bit key) header.d=2005.tr header.i=@2005.tr header.b=Nm4Weixd; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=2005.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2005.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=2005.tr header.i=@2005.tr header.b="Nm4Weixd"
Received: from mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:494f:0:640:ed81:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 93E68C0CE6;
	Mon, 04 May 2026 14:14:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net (smtp) with ESMTPSA id bEdRaMsSLSw0-lv5ex7uR;
	Mon, 04 May 2026 14:14:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=2005.tr; s=mail;
	t=1777893290; bh=EyRXmwAUXgiBKVinT8b1roGNdRCmdbZK3Hh4r5I0of0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Nm4Weixd7OH/si+5SYYFS8IdnVdc4VdeokB4lWUxwdU19NNCZNB9JpMLPqazTy8GS
	 T/ezmEbGNWiTwoNP3tok3i6ddk+GNQITRK9qIL9igFgFpFJ2Kk5Ukiklh69dj+ElLj
	 F39MMgoLdw376zcPQU9wxYn4LINJDPTi638Ia/s8=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.klg.yp-c.yandex.net; dkim=pass header.i=@2005.tr
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
Subject: [PATCH v2] rust: io: use newtype for PhysAddr
Date: Mon,  4 May 2026 14:14:21 +0300
Message-ID: <20260504111421.72130-1-x@2005.tr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503103050.200526-1-x@2005.tr>
References: <20260503103050.200526-1-x@2005.tr>
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

Drop the unused Clone and Copy derives from PhysAddr, as pointed out
in review.

Signed-off-by: Favilances Noir <favilances@proton.me>
---
 rust/kernel/devres.rs        |  8 +++++---
 rust/kernel/io.rs            | 29 +++++++++++++++++++++++------
 rust/kernel/io/mem.rs        |  4 ++--
 rust/kernel/io/resource.rs   |  6 +++---
 rust/kernel/iommu/pgtable.rs |  2 +-
 5 files changed, 34 insertions(+), 15 deletions(-)

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
index fcc7678fd9e3..999fa285a6ec 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -21,9 +21,24 @@
 
 /// Physical address type.
 ///
-/// This is a type alias to either `u32` or `u64` depending on the config option
-/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
-pub type PhysAddr = bindings::phys_addr_t;
+/// This wraps either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a `u64` even on 32-bit architectures.
+#[repr(transparent)]
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
 
 /// Resource Size type.
 ///
@@ -101,10 +116,10 @@ pub fn maxsize(&self) -> usize {
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
@@ -131,7 +146,9 @@ pub fn maxsize(&self) -> usize {
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

