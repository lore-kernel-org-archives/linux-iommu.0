Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C27175A5
	for <iommu@lists.linux.dev>; Sat,  4 Jul 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783124945; cv=pass; b=hMiyW/g2UGhw03SmcNtOKKCvNcCQuv69n2fj7NLg9YqVwcnuYilUDbDuzZrKkASGOfpPGrHMPx/QSUs+FtzmNo6Jt2wr4wWbpnhqCcvqEGkmwj0MCadbVZF4ZmEXjdi+B99+dGHPz8rPnVsjPlTPVwxtSQLR0+cCRhoE2yaspik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783124945; c=relaxed/simple;
	bh=d8fMp8gUokVQDuy+QCEg0Uzrs5JmyXGLHIUu1qB137I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O0R/rhQI0Ppk67N/7pa+acs64FfrRap3PcDdIpgBqSSn+gbI0zABGqCOIdYCLvQ9q2705Gc5E/Y1Yw0ucJVFtmqOk5L7NqO+eaws2D2Xr96whrm91i1rTOdr5cESpRk/RF+3X36zgWgJRF1aKDGmTYCeyjMJQp4BbEsi05+pQ6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=hOiUG0zO; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="hOiUG0zO"
ARC-Seal: i=1; a=rsa-sha256; t=1783124937; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TpJ8hFMjR9glkbHI3bIchjT/df37u2SWXL4TTHCHiLwgL97SGpW4OBmoqHIFLFRo3p6UwnyXkv6Sjy66Q5TTd+6BZSCAO2xljvR1j1DVo5OISRC7HI8ZOtplsye5mn++Q5SJ/yRvWL7xG14PYOGlD1ne0ySA+GxuPW7tShzHvTw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783124937; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KmIopzwY6+X+r5v+iDn2bx47mSMRQXY+Oh6QenNL02I=; 
	b=JPFnJ5lIVOH0fFYWFDy1hlAcERCG5ciPYhvXBNL3wdBgRwyGj0BrjSjp7BYx8sZknqW4f3tDu4EysSm8axDLv2urYUR4k8TNSfE800HCvP6GeA90WpkEQN2qmQi0kE5VKy4Uyfoj40ZpTyIPU4k+vzbbSdRk7j/mpGkKRgNHmtM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783124937;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=KmIopzwY6+X+r5v+iDn2bx47mSMRQXY+Oh6QenNL02I=;
	b=hOiUG0zOJkiQ73gj0OX62GG84yziSEhmfJ6iUTuorOC2Ux1Cjwe+aypj2CntJ2Uw
	HRYv9gQrgYSEaiygkpVW3zQ1PSvUYbwl9cKci881zVAH+Huw03c4bywhvj+faswHvzc
	dOFb1mA2iAZPLAYkR56QU1SMazmlLiLKOvwP9clA=
Received: by mx.zohomail.com with SMTPS id 178312493544320.334366290850767;
	Fri, 3 Jul 2026 17:28:55 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 03 Jul 2026 17:28:44 -0700
Subject: [PATCH v3] rust: iommu: add device lifetime to IoPageTable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pgtable_lt_b4-v3-1-e738e1f513a4@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMSwrDIBSF4a2EO67FFwY66j5KCD4TwcagIinBv
 ddm3uF/4HwnZJu8zfAYTki2+uzj1oPdBtCr3BaLvOkNFFOBR8zQvhSpgp1DmRVHIzWKciMNkw7
 6Z0/W+ePyXlPv1ecS0+fiK/2t/6RKEUGOdEsYTrAwTx1DkComedfxDVNr7Qv4PVkergAAAA==
X-Change-ID: 20260703-pgtable_lt_b4-72db24dad3af
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, samitolvanen@google.com, 
 laura.nao@collabora.com, boris.brezillon@collabora.com, 
 daniel.almeida@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4930;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=d8fMp8gUokVQDuy+QCEg0Uzrs5JmyXGLHIUu1qB137I=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkewcfezIh4wMG2oaJLQqtimRaP83f2l4fPtceuT1df8
 cNdPNK/o5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIls/8zwV7CwhK9xW0hDS+Uv
 TeeeFO6ap7U2P9bdS9+yImv9B6led0aG5k/hc4MaDQIb1z7zM99qtkZgEd+1Y3q+igu150j0rH/
 MBgA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB

Currently, using a raw IoPageTable is unsafe because the returned
IoPageTable is not tied to the device driver binding lifetime.

Since device drivers now receive a lifetime parameter <'bound>
representing the interval during which a device driver is bound to its bus
device, add a lifetime parameter to IoPageTable. This ensures that
the returned IoPageTable cannot outlive the bus device binding.

Also remove the option to create a page table as a device resource since
currently Devres is not compatible with resources that have a lifetime
parameter. This option can be restored once the lifetime-aware
wrapper for devres is available and if a use-case appears for it.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
Changes in v3:
- Rename 'bound to 'a since the page table could have a shorter
  lifetime than the whole device bound.
- Remove the TODO comment about restoring the devres option.
- Link to v2: https://lore.kernel.org/r/20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com

Changes in v2:
- Renamed new_raw() to new(), since the constructor is now safe.
- Link to v1: https://lore.kernel.org/rust-for-linux/20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com
---
 rust/kernel/iommu/pgtable.rs | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index c88e38fd938a..f5f2706d72fb 100644
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
+pub struct IoPageTable<'a, F: IoPageTableFmt> {
     ptr: NonNull<bindings::io_pgtable_ops>,
+    _dev: PhantomData<&'a Device<Bound>>,
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
@@ -75,25 +75,10 @@ pub trait IoPageTableFmt: 'static {
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
-
+impl<'a, F: IoPageTableFmt> IoPageTable<'a, F> {
     /// Create a new `IoPageTable`.
-    ///
-    /// # Safety
-    ///
-    /// If successful, then the returned `IoPageTable` must be dropped before the device is
-    /// unbound.
     #[inline]
-    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable<F>> {
+    pub fn new(dev: &'a Device<Bound>, config: Config) -> Result<IoPageTable<'a, F>> {
         let mut raw_cfg = bindings::io_pgtable_cfg {
             quirks: config.quirks,
             pgsize_bitmap: config.pgsize_bitmap,
@@ -118,6 +103,7 @@ pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable
         // INVARIANT: We successfully created a valid page table.
         Ok(IoPageTable {
             ptr: NonNull::new(ops).ok_or(ENOMEM)?,
+            _dev: PhantomData,
             _marker: PhantomData,
         })
     }
@@ -240,7 +226,7 @@ extern "C" fn rust_tlb_flush_walk_noop(
 ) {
 }
 
-impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
+impl<F: IoPageTableFmt> Drop for IoPageTable<'_, F> {
     fn drop(&mut self) {
         // SAFETY: The caller of `Self::ttbr()` promised that the page table is not live when this
         // destructor runs.
@@ -255,7 +241,7 @@ impl IoPageTableFmt for ARM64LPAES1 {
     const FORMAT: io_pgtable_fmt = bindings::io_pgtable_fmt_ARM_64_LPAE_S1 as io_pgtable_fmt;
 }
 
-impl IoPageTable<ARM64LPAES1> {
+impl IoPageTable<'_, ARM64LPAES1> {
     /// Access the `ttbr` field of the configuration.
     ///
     /// This is the physical address of the page table, which may be passed to the device that

---
base-commit: 2e75b259f4a4350f4d36026865be5a74554974aa
change-id: 20260703-pgtable_lt_b4-72db24dad3af

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

