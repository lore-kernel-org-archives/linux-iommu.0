Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055D35677E
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036084; cv=pass; b=f6J21GI6lKvGzgRtgHEBkjIXkIdBfzAzaeAPygwqD05IG+HjCMTh8fqu6q5hDint8NORbssdCZfxWd5aw7Hlq5d5s/CcSycVAEZtDRxQeRxRhzGQesXJqAlQh6W4Tk49mxiMB86cZVwH1gLofT2lQM+eN/n9oSS3sSVqR/7B5fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036084; c=relaxed/simple;
	bh=aBumc0wGxxCOdrgpftfUMvirYJvjxNQ1AjJ9HYWhWk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gsaqC36HRp2LitV7ydBgD2DsWyvLiZ5Sx3WHE3nb+68BNZkppDDP2pUBSOYI3D8fxwxH6K1tazXZREZn5B4Ly0UK8onuHQfB/CgVHArYT/1vtBdIanDclWx20tpd1poGCrbr4q+Gi+J7rPLVk1xwDzJ/obT8BtLXWg7eb8I5AOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=VrWxuUnf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="VrWxuUnf"
ARC-Seal: i=1; a=rsa-sha256; t=1783036076; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C6FybWWGTRwbtg2zrn9aR2t3ZHnc+UU7SEmT6BeaPALb98TUftZFcZIVBEWmJtGWrlPQRxnLV/79ShSZC5/niZ3Yi7lRHjnmPjTLoB5Shef1fIHBtYV9CV3iy/R0CGaCW+BE9579BtyclvMxn0KZI5bR3G0iAOfJyAFbJ0OV7Ak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783036076; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KFVTo7RfLpFVVazK+3bL5ArPbL18Ps/MhpevEmhVSJk=; 
	b=n/btbTYe+M+7Zbn29Al8asDwj089nfx69gD2ZpGjG9fIsfXd4hShoaJWfQGGWvx3TrjD/zEkz2JxRDMMHKy+T1aV4/1h3KZZFvQRqjlmD6aKvO/EgaHAEUr6hsa9kfGmwLliI4+mLG5d2WNbjReMWzL69ClPAi+Cwo0ueQpvxT8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783036076;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=KFVTo7RfLpFVVazK+3bL5ArPbL18Ps/MhpevEmhVSJk=;
	b=VrWxuUnfF+88pI9N0+mTuhwMMHQQqsNcDwRpdas+M1Sjz8AfXbj604/8PNFghZ84
	WzG23Meyl7leCsru0Xin4P/D4qO6wxzoKcRLfjDYEEK2frb3ufZ+ZeisqgOfDIYX47o
	zKbGiwVTQ0XemQr4tNCZuVUtat8JA9QAe5RyKynM=
Received: by mx.zohomail.com with SMTPS id 1783036074721243.51256091292396;
	Thu, 2 Jul 2026 16:47:54 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 02 Jul 2026 16:47:39 -0700
Subject: [PATCH] rust: iommu: add device lifetime to IoPageTable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMj3YL0ksSknNT4nJL4MkNdY4PUNBPTVANDyzQTJaCegqLUtMwKsHn
 RsbW1AMO95HhfAAAA
X-Change-ID: 20260702-pgtable_lt_v1-30ef45e019f4
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, samitolvanen@google.com, 
 boris.brezillon@collabora.com, laura.nao@collabora.com, 
 daniel.almeida@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4554;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=aBumc0wGxxCOdrgpftfUMvirYJvjxNQ1AjJ9HYWhWk0=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFluP1Z6bf2YJsRTcHijucW3oEjvIv32f6fPrfp+UTHE7
 JDF/1fxHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAExEkI+R4crFBNWUv+whAlrV
 OyfelOFrmHT7aa/d3mIzw0UfT3h/Oc3w3zlWwUArvHVR4HYnqxs5zjevrlq18/STu60Mv477bGX
 QYQIA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB

Currently, using a raw IoPageTable is unsafe because the returned
IoPageTable is not tied to the device driver binding lifetime.

Since device drivers now receive a lifetime parameter <'bound>
representing the interval during which a device driver is bound to its bus
device, add this lifetime parameter to IoPageTable. This ensures that
the returned IoPageTable cannot outlive the bus device binding.

Also temporarily remove the option to create a page table as a device
resource since currently Devres is not compatible with resources that have
a lifetime parameter. This option can be restored once the lifetime-aware
wrapper for devres is available.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/iommu/pgtable.rs | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index c88e38fd938a..d4a16283b5a7 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -16,7 +16,6 @@
         Bound,
         Device, //
     },
-    devres::Devres,
     error::to_result,
     io::PhysAddr,
     prelude::*, //
@@ -59,15 +58,16 @@ pub struct Config {
 /// # Invariants
 ///
 /// The pointer references a valid io page table.
-pub struct IoPageTable<F: IoPageTableFmt> {
+pub struct IoPageTable<'bound, F: IoPageTableFmt> {
     ptr: NonNull<bindings::io_pgtable_ops>,
+    _dev: PhantomData<&'bound Device<Bound>>,
     _marker: PhantomData<F>,
 }
 
 // SAFETY: `struct io_pgtable_ops` is not restricted to a single thread.
-unsafe impl<F: IoPageTableFmt> Send for IoPageTable<F> {}
+unsafe impl<F: IoPageTableFmt> Send for IoPageTable<'_, F> {}
 // SAFETY: `struct io_pgtable_ops` may be accessed concurrently.
-unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<F> {}
+unsafe impl<F: IoPageTableFmt> Sync for IoPageTable<'_, F> {}
 
 /// The format used by this page table.
 pub trait IoPageTableFmt: 'static {
@@ -75,25 +75,12 @@ pub trait IoPageTableFmt: 'static {
     const FORMAT: io_pgtable_fmt;
 }
 
-impl<F: IoPageTableFmt> IoPageTable<F> {
-    /// Create a new `IoPageTable` as a device resource.
-    #[inline]
-    pub fn new(
-        dev: &Device<Bound>,
-        config: Config,
-    ) -> impl PinInit<Devres<IoPageTable<F>>, Error> + '_ {
-        // SAFETY: Devres ensures that the value is dropped during device unbind.
-        Devres::new(dev, unsafe { Self::new_raw(dev, config) })
-    }
+impl<'bound, F: IoPageTableFmt> IoPageTable<'bound, F> {
+    // TODO: Create a new `IoPageTable` as a device resource when DevresLt is available.
 
     /// Create a new `IoPageTable`.
-    ///
-    /// # Safety
-    ///
-    /// If successful, then the returned `IoPageTable` must be dropped before the device is
-    /// unbound.
     #[inline]
-    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable<F>> {
+    pub fn new_raw(dev: &'bound Device<Bound>, config: Config) -> Result<IoPageTable<'bound, F>> {
         let mut raw_cfg = bindings::io_pgtable_cfg {
             quirks: config.quirks,
             pgsize_bitmap: config.pgsize_bitmap,
@@ -118,6 +105,7 @@ pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable
         // INVARIANT: We successfully created a valid page table.
         Ok(IoPageTable {
             ptr: NonNull::new(ops).ok_or(ENOMEM)?,
+            _dev: PhantomData,
             _marker: PhantomData,
         })
     }
@@ -240,7 +228,7 @@ extern "C" fn rust_tlb_flush_walk_noop(
 ) {
 }
 
-impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
+impl<F: IoPageTableFmt> Drop for IoPageTable<'_, F> {
     fn drop(&mut self) {
         // SAFETY: The caller of `Self::ttbr()` promised that the page table is not live when this
         // destructor runs.
@@ -255,7 +243,7 @@ impl IoPageTableFmt for ARM64LPAES1 {
     const FORMAT: io_pgtable_fmt = bindings::io_pgtable_fmt_ARM_64_LPAE_S1 as io_pgtable_fmt;
 }
 
-impl IoPageTable<ARM64LPAES1> {
+impl IoPageTable<'_, ARM64LPAES1> {
     /// Access the `ttbr` field of the configuration.
     ///
     /// This is the physical address of the page table, which may be passed to the device that

---
base-commit: dd8a3c6cd531dca5917111a94fa3074077f6ba5a
change-id: 20260702-pgtable_lt_v1-30ef45e019f4

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

