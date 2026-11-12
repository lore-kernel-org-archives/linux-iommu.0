Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502879;
	b=Cj+2a2LCa2i0SBqaI58RagffJMs0jG/FZSN2AGqAk5StriMuXraQ1nqX9D0YL31/Pz/d
	 HHSB/FKuwy0ifTSNzoF8lwxi5l/GdZim4olN2H9Om1U9/is0301rz2VV3112m4IuKfFmw
	 u+Qu3cgg1S9Ob8VrnbXq2CQLtJoP7S1fVQD8bLoghBQNoPX70TG2dcddt+xsisxKZBMSA
	 UvTo5Y0ciRY3rg1zlyfOBghpidEbBN5p9vpXwCHoHkf9jEfFoCuhPg82hRUFhxWPvxLQ3
	 tL7w3RlQJLi+DToNZS4Ki0Ayldkxow2LZWman4SIYYnj2c7P9H2wgdNecLgD1pt58+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502879;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=t4e3NzVEzyqo2Z4CDS5YX3ORogwj7eesZ5oXHBnybGA=;
	b=qSEudMUGmhrEAL8E95u/7P6f8Xa/R6AI8Puk+KkUgFDV6tNiGCgI2sMDNRFMdwct/pbA
	 mp70HswMIbCGXCKwTxABuHMQnseT9A4OgXO/kLLw7FbKY0IOuTUq2BbMCFMbTA1GF7yFP
	 Y8suMW/aYL5EyTNlm0OzgjS0HYcn7JKDtnycwntlIiNJ9vLh46J5AfL607iKCzXzRi659
	 o/aopSSW/Jlrf/ILjwKSJ5hbip8UaMisf0yhfDI6phfQwiqWr0DnVkowKTAt/ahM2g5wt
	 HgUPE07cBGjAvP9xi/46KYu0TG7EXadJoMsI1IL0T5EmQ+IGKuD4H6Qa+EiMChKkp5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QfKeomhp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A723606A893;
	Thu, 12 Nov 2026 17:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A723606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QfKeomhp
ARC-Seal: i=1; a=rsa-sha256; t=1794502872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lLGZTMsrj7K0hwbrNbtiPQXthFOOZvF4p7uHFpdBEMM2QUHulJolK0U3xg1NYo7zGWVOTOhvLpkYSTfx7sUg38tHULzGYyTQSyhGi+JYRk3Fhq0m35JBOT9S0/KOsfAi4BlM+nk7lyWXpvDHJIJ9BUAz9qdgWAOtp6HsAzlcojg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794502872; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t4e3NzVEzyqo2Z4CDS5YX3ORogwj7eesZ5oXHBnybGA=; 
	b=Q0zITqSxltMa2zoJpGtV1Bs3cSQcxtj33CHgAW01OXWgiiCk4WbRlHJSB/So4enF1aSwVp3P0U8ZPauyNRVbfEfJYwk0/RHYWEyJaQCsJUXv+I1ASHI4Jg7EALElO1wHXJdLnk6nAkc7HBNWM52xTeWPCOTYETWVX4PL0CmYmUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=QfKeomhp+PBt5ksr2kgM+3pyAsWAsnLpff4JDKThIqjKDTAAcTbW9WdxYc88u0zcghkRa/QNkoSZFx76FSDqHBpWJoILNZro6WS+gT6snuJJFqbDOqJApGZyBKzBWDOy44SE2Cot2wBMjuOWRw12z5i8JdrBpm38ZAeqeckGL0g=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=t4e3NzVEzyqo2Z4CDS5YX3ORogwj7eesZ5oXHBnybGA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179450286951028.577966242972934;
	Thu, 12 Nov 2026 09:01:09 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 12 Nov 2026 14:00:12 -0300
Subject: [PATCH 5/6] rust: iommu: add Domain::map()
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-b4-iommu-domain-v1-5-c29e86788dda@collabora.com>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
In-Reply-To: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The upcoming rkvenc driver will map the buffers of a session into that
session's IOMMU domain.

Add Domain::map(), which maps pages into the domain at an IOVA chosen
by the caller, and returns a Mapping that unmaps them on drop.

The pages come from a MapSource, a new trait for anything that can
provide an SGTable and keep its pages allocated. The Mapping owns its
source, so the pages cannot be freed while they are mapped. MapSource
is initially implemented for a boxed SGTable that owns its pages.

map() is unsafe. As with IoPageTable::map_pages(), mapped ranges must
not overlap, and nothing else may access a range while it is being
mapped.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/iommu/domain.rs | 182 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/iommu/domain.rs b/rust/kernel/iommu/domain.rs
index 2a5b66f2a5d9..ac9947d5063b 100644
--- a/rust/kernel/iommu/domain.rs
+++ b/rust/kernel/iommu/domain.rs
@@ -23,7 +23,11 @@
         from_err_ptr,
         to_result, //
     },
-    prelude::*, //
+    prelude::*,
+    scatterlist::{
+        Owned,
+        SGTable, //
+    }, //
 };
 
 /// An IOMMU paging domain.
@@ -39,6 +43,76 @@
 ///
 /// `ptr` points to a paging domain allocated by `iommu_paging_domain_alloc_flags()` and owned by
 /// this object.
+///
+/// # Examples
+///
+/// Two clients share one device. Each has its own domain, and the device is switched from one
+/// to the other between jobs.
+///
+/// ```
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     dma,
+///     iommu::{
+///         domain::{
+///             Domain,
+///             MapSource, //
+///         },
+///         prot, //
+///     },
+///     page,
+///     prelude::*,
+///     scatterlist::SGTable, //
+/// };
+///
+/// fn new_buffer(dev: &Device<Bound>) -> Result<impl MapSource + 'static> {
+///     let pages = VVec::<u8>::with_capacity(4 * page::PAGE_SIZE, GFP_KERNEL)?;
+///
+///     KBox::pin_init(
+///         SGTable::new(dev, pages, dma::DataDirection::Bidirectional, GFP_KERNEL),
+///         GFP_KERNEL,
+///     )
+/// }
+///
+/// fn test(dev: &Device<Bound>) -> Result {
+///     // SAFETY: The IOMMU driver that `dev` is behind meets the requirements of `Domain::new()`.
+///     let domain_a = unsafe { Domain::new(dev)? };
+///     // SAFETY: The IOMMU driver that `dev` is behind meets the requirements of `Domain::new()`.
+///     let domain_b = unsafe { Domain::new(dev)? };
+///
+///     // Both clients map their buffer at the same IOVA.
+///     let iova = 0xdead_0000;
+///
+///     // SAFETY: We are the driver bound to `dev`. The attachment is dropped below, after `dev`
+///     // has stopped.
+///     let attachment = unsafe { domain_a.attach(dev)? };
+///
+///     let buffer = new_buffer(dev)?;
+///     // SAFETY: `domain_a` has no other mapping, and nothing else uses it.
+///     let _mapping_a = unsafe { domain_a.map(iova, buffer, prot::READ | prot::WRITE)? };
+///
+///     // Run a job of the first client, then stop the device.
+///
+///     // `attach()` allows one domain on a device at a time, so `domain_a` is detached first.
+///     drop(attachment);
+///
+///     // SAFETY: We are the driver bound to `dev`. The attachment is dropped when this function
+///     // returns, after `dev` has stopped.
+///     let _attachment = unsafe { domain_b.attach(dev)? };
+///
+///     let buffer = new_buffer(dev)?;
+///     // SAFETY: `domain_b` has no other mapping, and nothing else uses it.
+///     let _mapping_b = unsafe { domain_b.map(iova, buffer, prot::READ | prot::WRITE)? };
+///
+///     // Run a job of the second client, then stop the device. With `domain_b` attached, `iova`
+///     // leads to the second buffer.
+///
+///     Ok(())
+/// }
+/// ```
 pub struct Domain<'a> {
     ptr: NonNull<bindings::iommu_domain>,
     _dev: PhantomData<&'a Device<Bound>>,
@@ -50,6 +124,8 @@ unsafe impl<'a> Send for Domain<'a> {}
 // SAFETY: `&Domain` allows the following from several threads at once:
 // - Attaching and detaching the domain. `iommu_attach_device()` and `iommu_detach_device()` may
 //   be called concurrently for the same domain.
+// - Mapping and unmapping ranges. `iommu_map_sg()` and `iommu_unmap()` may be called concurrently
+//   for the same domain, except in the cases that the safety requirements of `map()` exclude.
 unsafe impl<'a> Sync for Domain<'a> {}
 
 impl<'a> Domain<'a> {
@@ -98,6 +174,60 @@ pub unsafe fn attach<'d>(&'d self, dev: &'d Device<Bound>) -> Result<Attachment<
         // INVARIANT: The domain is attached to `dev`.
         Ok(Attachment { domain: self, dev })
     }
+
+    /// Maps the pages of `source` at `iova` with the protection flags `prot` (see [`prot`]).
+    ///
+    /// The returned [`Mapping`] owns `source` and unmaps the range when it is dropped. A leaked
+    /// [`Mapping`] leaves its range mapped. Its source is leaked with it and must keep the pages
+    /// allocated, so `S` cannot borrow them and has to be `'static`.
+    ///
+    /// This performs no cache coherency operations on the pages. It may sleep.
+    ///
+    /// [`prot`]: super::prot
+    ///
+    /// # Safety
+    ///
+    /// - The range must not overlap any other mapping in the domain.
+    /// - No other operation on the domain may access the range while this function runs.
+    pub unsafe fn map<'d, S: MapSource + 'static>(
+        &'d self,
+        iova: usize,
+        source: S,
+        prot: u32,
+    ) -> Result<Mapping<'d, S>> {
+        let sgt = source.sg_table().as_raw();
+
+        // SAFETY: `sgt` points to the table of `source`, which is valid.
+        let (sgl, nents) = unsafe { ((*sgt).sgl, (*sgt).orig_nents) };
+
+        // SAFETY:
+        // - By the type invariant, `self.ptr` is a valid domain.
+        // - `sgl` has `nents` entries. By the safety requirements of `MapSource`, they describe
+        //   pages that stay allocated for as long as the returned `Mapping` owns `source`.
+        // - The caller meets the safety requirements of this function.
+        let ret = unsafe {
+            bindings::iommu_map_sg(
+                self.ptr.as_ptr(),
+                iova,
+                sgl,
+                nents,
+                prot as i32,
+                GFP_KERNEL.as_raw(),
+            )
+        };
+        if ret < 0 {
+            return Err(Error::from_errno(ret as i32));
+        }
+
+        // INVARIANT: `iommu_map_sg()` mapped `[iova, iova + ret)`, and only the returned object
+        // unmaps it.
+        Ok(Mapping {
+            domain: self,
+            iova,
+            size: ret as usize,
+            _source: source,
+        })
+    }
 }
 
 impl<'a> Drop for Domain<'a> {
@@ -131,3 +261,53 @@ fn drop(&mut self) {
         unsafe { bindings::iommu_detach_device(self.domain.ptr.as_ptr(), self.dev.as_raw()) };
     }
 }
+
+/// A source of pages that can be mapped into a [`Domain`].
+///
+/// # Safety
+///
+/// Every entry of the table that [`MapSource::sg_table`] returns must describe pages. The table
+/// must not change and its pages must stay allocated for as long as `self` exists.
+pub unsafe trait MapSource {
+    /// Returns the table describing the pages to map.
+    fn sg_table(&self) -> &SGTable;
+}
+
+// SAFETY: An `SGTable<Owned<P>>` is built from pages, and keeps them and its table until it is
+// dropped.
+unsafe impl<P> MapSource for Pin<KBox<SGTable<Owned<P>>>> {
+    fn sg_table(&self) -> &SGTable {
+        self
+    }
+}
+
+/// Pages mapped into a [`Domain`].
+///
+/// Dropping a mapping unmaps its range, then drops its source.
+///
+/// # Invariants
+///
+/// `[iova, iova + size)` is mapped in `domain`, and only this object unmaps it.
+#[must_use = "the range is unmapped when the mapping is dropped"]
+pub struct Mapping<'d, S> {
+    domain: &'d Domain<'d>,
+    iova: usize,
+    size: usize,
+    _source: S,
+}
+
+impl<'d, S> Mapping<'d, S> {
+    /// Returns the first IOVA of the mapping.
+    #[inline]
+    pub fn iova(&self) -> usize {
+        self.iova
+    }
+}
+
+impl<'d, S> Drop for Mapping<'d, S> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, `[self.iova, self.iova + self.size)` is mapped in
+        // `self.domain`, and nothing else unmaps it.
+        unsafe { bindings::iommu_unmap(self.domain.ptr.as_ptr(), self.iova, self.size) };
+    }
+}

-- 
2.56.0

