Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DB175A66;
	Sun,  3 May 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777804695; cv=none; b=nnu6t2cxQoC3moct3jGigDlZL+TJEjYEbkiF+ZItN+7FsRdbARxjKG6hNwK2t1hXLPOXNXnwPcmf4jWa71yrB6x2b9ennEwWuPFjuMXvPRIk17D7IdgEJeYIZjiCG1glcGkb7jkEZPC7jaDH2BSQGipWbklFJln7wl6ncvD8lN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777804695; c=relaxed/simple;
	bh=InkpjzdiCLzusxzyeMvWTUrovVx0A/NuHzY4bOAMdXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJ+2OrM6m1AF+XrFxdTVotwG7DOa3DxmZqO5scJdXPiY0d4jKZuQ6tGVRUJUCbfbUWoYUHopqW0TV2eRP5D/FElGPps26urH9+SURgW3559IaFnFyBm14k3EZ2W+TwcQDuWPhR347y3AwbNqyki0adW7jtE8uONJG8z/JqExFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=2005.tr; spf=pass smtp.mailfrom=2005.tr; dkim=pass (1024-bit key) header.d=2005.tr header.i=@2005.tr header.b=gUkPpPBh; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=2005.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2005.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=2005.tr header.i=@2005.tr header.b="gUkPpPBh"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id 9DE4DC1B82;
	Sun, 03 May 2026 13:31:25 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c5a:30b4:0:640:f126:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 74E34C0074;
	Sun, 03 May 2026 13:31:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp) with ESMTPSA id 5VbTKPfSQW20-Il54nMyb;
	Sun, 03 May 2026 13:31:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=2005.tr; s=mail;
	t=1777804276; bh=iiHQfYwwq+y63xmVlSmQSrMy246317Nq+OjXaxmq1p8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gUkPpPBhhnzUHd1GYChWmgWQ2v9ilmjz7Xi8CHB+wrVaiBHYlqOiT5nI4xao+o3mR
	 7/Q2qQ3dKAkOjYtYsDgA8n4Bm+krsn7h0uOPyz30bpDDp022jej7FoHa6Ykq9S8e66
	 N11JGhgHdWWXjv/pmLvqfHJ8hzdC+iRe0o3M89AU=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@2005.tr
From: x@2005.tr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
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
Subject: [PATCH] rust: io: use newtype for PhysAddr
Date: Sun,  3 May 2026 13:30:50 +0300
Message-ID: <20260503103050.200526-1-x@2005.tr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Favilances Noir <favilances@proton.me>

From: Favilances Noir <favilances@proton.me>

Currently, `PhysAddr` is a type alias for `phys_addr_t`. This means
that physical addresses can be mixed with unrelated integer values
without Rust noticing.

Use a transparent newtype for `PhysAddr` instead, and update the
affected call sites to perform explicit raw conversions at the FFI
boundary.

This keeps the existing `phys_addr_t` representation while making
physical addresses distinct in Rust type checking.

Signed-off-by: Favilances Noir <favilances@proton.me>
---
 rust/kernel/devres.rs        |  8 +++++---
 rust/kernel/io.rs            | 30 ++++++++++++++++++++++++------
 rust/kernel/io/mem.rs        |  4 ++--
 rust/kernel/io/resource.rs   |  6 +++---
 rust/kernel/iommu/pgtable.rs |  2 +-
 5 files changed, 35 insertions(+), 15 deletions(-)

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
index fcc7678fd9e3..2d55ee93caae 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -21,9 +21,25 @@
 
 /// Physical address type.
 ///
-/// This is a type alias to either `u32` or `u64` depending on the config option
-/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit architectures.
-pub type PhysAddr = bindings::phys_addr_t;
+/// This wraps either `u32` or `u64` depending on the config option
+/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a `u64` even on 32-bit architectures.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
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
@@ -101,10 +117,10 @@ pub fn maxsize(&self) -> usize {
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
@@ -131,7 +147,9 @@ pub fn maxsize(&self) -> usize {
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

