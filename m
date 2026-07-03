Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975831F30A9
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104779; cv=pass; b=Y4uzLJjZStHRDH2RCDzul4HGKFow/pyIwr0n6FScqB6sachnofsJW/wHPHYksVfWyWpGBEkdfE/32xx6cg6IK8biiJeChjfGt123hkB1If219BCpfpFtgZbF7eNNHuiuld3BtjHqUQ/Y7hCZzC65ud+UXk/IPfCGkoRf0BYNfzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104779; c=relaxed/simple;
	bh=XVuPdvip7/qY1K9b34f//yC+Sfd/Qm9mPtikcodSiDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ra694/JAQu0e5Bw4qMjqxsBHyUUkWZQooI/q8MnrQMFohnGtCuR3Sp+YLIVnlLJ4uCeSFI62+4NiLiK7CjhHE2ZQQKIawwhzqA0L2ys6Bs1jMZDa8JdaA1FmFAJuRJfFZefAdC3BLZhzkMlPLt+9sj7p3tM4ShJiAlNg4dRnF5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b=jA2qgwFg; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="jA2qgwFg"
ARC-Seal: i=1; a=rsa-sha256; t=1783104765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AdkyPW+BUsDA1E2I5NcOJ0y0/On1jyiLmk+qPcHErmYdAcdbfCJAQv2tN1RrTnt5/6iSmDGRlzpFYMk/yhIhxijxVIbLZvX7233bBkwHTqJIqS9m1YDMeXIrdP1U2LwIuevZtXaTMsdqyBYvnhsltVbHXBHoLR7f0spqqp6xeqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783104765; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RuC5EaV26foRNr0Sjv0RFI1x7h8Dc+6JlS0DhVM8/pI=; 
	b=X890O7JrQxMyVy1Ji9jlz34VBcPsMFlvI8bkwB/ICCMr0NToGIFnFp6KLjwg6Sk0bSAr1EwDbOGE1O+Z4lDa4e/GREMjG4V/+XSvRfFPoIHTuIF7fex4YtUHBMTm2JNn1b3IxNTOVtj/R3ySw16asZVeCzDh++N4GBReYjvcdJY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
	dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783104764;
	s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=RuC5EaV26foRNr0Sjv0RFI1x7h8Dc+6JlS0DhVM8/pI=;
	b=jA2qgwFghu5ZrYFDDqwsHIPL0zeWTsJmaxDWFRp+k6UF6oKKUalmvk6AVqz0379V
	JjW5+LwXfhICeffTBUmkC3vO6MciK0y7A9W7PQ2Iv0aG/CHLswBa2ZYHps54ZL9ZiNK
	Sxev2F+A7bEGH+q5CsA/h6ThHroMPnF3JT8E6vds=
Received: by mx.zohomail.com with SMTPS id 1783104762344360.55967240986513;
	Fri, 3 Jul 2026 11:52:42 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 03 Jul 2026 11:52:17 -0700
Subject: [PATCH v2] rust: iommu: add device lifetime to IoPageTable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pgtable_lt_b4-v2-1-f14da6d4106d@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNj3YL0ksSknNT4nJL4JBNdc6OUJCOTlMQU48Q0JaCegqLUtMwKsHn
 RsbW1ADJeYYBfAAAA
X-Change-ID: 20260703-pgtable_lt_b4-72db24dad3af
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, laura.nao@collabora.com, 
 boris.brezillon@collabora.com, daniel.almeida@collabora.com, 
 samitolvanen@google.com, Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4774;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=XVuPdvip7/qY1K9b34f//yC+Sfd/Qm9mPtikcodSiDM=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkeLB92GbFt9nq/b2aoIPOCillXowT+e7X1T7uVcaP5w
 JL3ybZsHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAExE8BHD/0DzQ/92z3/R4Cr3
 fZuU+fqTxyUj735+/uPz0UlO23ReSwsz/K/5+M6B9cu5vAtMK3w1IvyCuLPNH9fP1p9xemF2UKD
 8aSYA
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
Changes in v2:
- Renamed new_raw() to new(), since the constructor is now safe.

Link to v1:
https://lore.kernel.org/rust-for-linux/20260702-pgtable_lt_v1-v1-1-18d9c9812a1a@collabora.com/
---
 rust/kernel/iommu/pgtable.rs | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index c88e38fd938a..48bfb72eead6 100644
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
@@ -75,25 +75,13 @@ pub trait IoPageTableFmt: 'static {
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
+    // TODO: Provide the option to return `IoPageTable` as a device resource
+    // when DevresLt is available.
 
     /// Create a new `IoPageTable`.
-    ///
-    /// # Safety
-    ///
-    /// If successful, then the returned `IoPageTable` must be dropped before the device is
-    /// unbound.
     #[inline]
-    pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable<F>> {
+    pub fn new(dev: &'bound Device<Bound>, config: Config) -> Result<IoPageTable<'bound, F>> {
         let mut raw_cfg = bindings::io_pgtable_cfg {
             quirks: config.quirks,
             pgsize_bitmap: config.pgsize_bitmap,
@@ -118,6 +106,7 @@ pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable
         // INVARIANT: We successfully created a valid page table.
         Ok(IoPageTable {
             ptr: NonNull::new(ops).ok_or(ENOMEM)?,
+            _dev: PhantomData,
             _marker: PhantomData,
         })
     }
@@ -240,7 +229,7 @@ extern "C" fn rust_tlb_flush_walk_noop(
 ) {
 }
 
-impl<F: IoPageTableFmt> Drop for IoPageTable<F> {
+impl<F: IoPageTableFmt> Drop for IoPageTable<'_, F> {
     fn drop(&mut self) {
         // SAFETY: The caller of `Self::ttbr()` promised that the page table is not live when this
         // destructor runs.
@@ -255,7 +244,7 @@ impl IoPageTableFmt for ARM64LPAES1 {
     const FORMAT: io_pgtable_fmt = bindings::io_pgtable_fmt_ARM_64_LPAE_S1 as io_pgtable_fmt;
 }
 
-impl IoPageTable<ARM64LPAES1> {
+impl IoPageTable<'_, ARM64LPAES1> {
     /// Access the `ttbr` field of the configuration.
     ///
     /// This is the physical address of the page table, which may be passed to the device that

---
base-commit: dd8a3c6cd531dca5917111a94fa3074077f6ba5a
change-id: 20260703-pgtable_lt_b4-72db24dad3af

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

