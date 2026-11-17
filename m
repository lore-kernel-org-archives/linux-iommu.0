Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943961;
	b=I9qqKHg2bZ5QFng86PkG6ElqPdbbAtZ64uUMbst6eBiFwfwd1VA1x9DVam5LCyZH/zqm
	 2U1OTyUI6YyL9hVQ+bTP5fCWTR0lvyR2JDOcQOiibt+oYOy6ijTn14sNpenmWlzsZHTf8
	 k4ggMKO7nt8XICPdJPcO51BSZvpvL8rhufQJDxZwgBpbDL5WMY/Z7exYWNXOvSMP/74SL
	 J/Lp+hzTHvvedxmDiTGxQCg716km2bamyM4bM+2S+Q6IjUxuYKys2VgIQbjkcu2BuNHDZ
	 Av9TsxP1M0y0/0I9vRrfAdIERCCyCgMMyA4X5QngRo5U1F32gGYdnAmEuPS0SjgXugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=KKe7nWmRzfcozsR9XT3++1825BIwj0YyjVNcnU/xYxg=;
	b=OnbQ6XY550Hl/c6KsCjBz00BHzJGM2JbQd0p0OY2dMW4YGg0fjFUT6iCtPUWYayUS+jc
	 Z+ol3GDCYbQxFqgItBdiWQOGphehngslw212SSOnqvOQU91ZHnoHWuKj8uBuQxpFU8tKZ
	 7V9sJqsjeDASCh684QX6ER1CY6AGUCsKYnY74Bk9mpsBXA7OYAwWl2kq3wcR+q86vxC5U
	 27Ull56TI6cmotMyHmHM+z7nbjsQliu8y4tYRaDDRmOpikK7jPQSiMHK5vdSC9UEA398b
	 h6xuAXKk23Ruv/3lRwXDknzj26acALWPHhMd5hxsF2umlfzQEWLIwyXPRwyh2mhooeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P6h9EFbF;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAE60A3834
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADAE60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P6h9EFbF
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4916bd6e3baso87002f8f.0
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 11:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794943959; x=1795548759; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKe7nWmRzfcozsR9XT3++1825BIwj0YyjVNcnU/xYxg=;
        b=P6h9EFbFaot5nfWET4Q/Ov7S8fBeNHVUGP/c3Cu90y2RTBh0+gM2aVV2ilmLapPjgz
         r7JjRJRZ2HPvtbsQ0t124fRpWEnPCSR7CoX+6jwsPCzoYsgvhdO8XBQnCcrgA9FIiSqO
         ohm/+hq07aC1f1Cr6xencefAscfhdPj9Hd02ngawJYLkxp/v9eWDrzfBo1kBfN79gYvC
         lNUyIfnl33l64NdM1Wg6wPZTzmw/0Q8XBQpz9kQJiYRp3FCml04JPihktulMzFqLp/l+
         6pldU1btRGvNsJn0CF1SsWquaNIggiicyJuZGNMOHVDa1SokSnGBCinyxubpD7OTLdAn
         Datg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943959; x=1795548759;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKe7nWmRzfcozsR9XT3++1825BIwj0YyjVNcnU/xYxg=;
        b=VruPfoG09o1Vvq0xBwZ1k1PVMACiH+7fkdQw2xGayS/Ei2RI0wJkZBvDJdmK47SaDZ
         ki7NGZ5JX1004KF223+a3RRiM+PwfG5VmTpclv2NOnL9tf/3wR7tkZeXhTTFb5T0dwA3
         QawJvBh26MYeyH9yGj9oEQfi1O6izTGF8Xmsu7YkT55nxrztbHjUEPKzxOCYSIvFyRnB
         oYk8332eXaU4gW1q3Nj6YyNKOW6UnarUzGb3hZcec5DC8WnWjXsWeWmSoL/0S3xd7Zs4
         ALDTaHY73AAtLdO1crJbrzqHf+oMkK8m6SRdH30oIwGIaDe/COSOCzlF8rrRMHzMDJJQ
         kciQ==
X-Forwarded-Encrypted: i=1; AL+hErElJ/cg51154xRhDdTv1c+sffb8bGcu3oUn8PSWR0/611FtdBbjmoCX8INkuFTNSEApOFphoA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/mt+ANhiMcfpMbp+HSVQ6/UJrNGPFE2DTq1AJVAUItOzE/jlqd
	hvLJiYw9EcoYyPducCpN2yGo4RSZFFGmXywbsMfw+v8Ae8JFiLTfWflDRGJ2Noy0RbUpTYkdPCJ
	rgQCrhcWPDvAOoWLJRg==
X-Received: from wrqi7.prod.google.com ([2002:a5d:4387:0:b0:491:154e:cc94])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:454a:b0:48e:6092:dea1 with SMTP id ffacd0b85a97d-4a63b50ebfemr598864f8f.47.1794943958801;
 Tue, 17 Nov 2026 11:32:38 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:20 +0000
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11225; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=bL5SPtkc6ERMxg0Q2bjGArvHr684lqk9kP62BPoKlsM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQJqb8lvIvRovwW/WkvKX15QHDvNQQrW5O2
 2Z88AZ6teqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 RmfBD/4jJSqj2I3Y5OB8w/L+Mc9koMgha4XMVc7n76FuGXcNp5FdKq549ByV9dsUgARAMWDVgA7
 uyyZyitWN7gNgeud9eluwrpWhQi8r0sFaeqmVLQSg60Cz3easlMGD7lTkkfmJjLtqkVUGYRRwvU
 M15QAXQCkjC0PBGJ43CUrSw3HgKP1KduH4nDPTEF9qEKnTVVBxrENSucbcoH2REJg7pLVROOKal
 YdukvKkZRypt/NywbYiKtRRF4vQPbmFmcDKPYpyZcdcjJgJrIIqsvP2x63HYHFmIhLbcF72NdAa
 ZcxDAy4ivhPZI8y+qg7bsXBSrFw1NtVnfyLo3n09RNqiB61TfhyomxLR/t3iT8XnmG9NmI+4fm7
 Q3FDGIpcSA9cdxadnQX1UyX6WyTx8x08Fz7PCexelHmoXgUGqyNUGy3C/1RwouTeqvsx8kQ4+mY
 7L1j6Ti9r01KXE/Utv2P3FZM0XNu6Yucza49wBhixMizp4IsHfUXjuahYMSscrOIMti8WvC5N4K
 Rn6TDubrXWriguLBMb6shVwBluCXtKQs5nvWi/zHndurEcAzSTXi5L6U8xyLz8pa/rsBFtkemtS
 uJbA5zwsAduSYDBh6Dn5Nxo8J4r1E33GCCnYlQnEtsJO81cfgz8RdbB0bbbyjTtmpL0lPjkgIdb ourhb1wKXY/tsiw==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-3-2a8efd4c8180@google.com>
Subject: [PATCH 3/4] drm/tyr: vm: expand sub-block unmaps to 2MB boundaries on remap
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sami Tolvanen <samitolvanen@google.com>

Backing GEM shmem with transparent huge pages lets Tyr install 2MB block
entries. arm-lpae refuses to unmap part of a block, so a sparse partial
rebind that splits one in sm_step_remap fails the VM_BIND and poisons
the VM.

Grow such an unmap to the block boundary and rebuild the surviving
fragment, expanding only when contiguous.

Fixes: f2dc32d5a133 ("drm/tyr: add GPU virtual memory (VM) support")
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: tweaks for drm-rust-next and use safe casts instead of 'as']
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/mmu.rs               |  13 +++
 drivers/gpu/drm/tyr/mmu/address_space.rs |  29 ++++++
 drivers/gpu/drm/tyr/vm.rs                | 146 ++++++++++++++++++++++++++++---
 3 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index 5e88c9e6a4cd..99739a3a8aa1 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -109,6 +109,19 @@ pub(crate) fn start_vm_update(
         self.as_manager.lock().start_vm_update(vm_as_data, region)
     }
 
+    /// Widens the active lock to cover a larger region.
+    ///
+    /// `region` must contain the currently locked range so the GPU stays
+    /// stalled over it while the update completes. If the region is empty or
+    /// the VM is not resident, this is a NOP.
+    pub(crate) fn extend_vm_update(
+        &self,
+        vm_as_data: &VmAsData<'drm>,
+        region: &Range<u64>,
+    ) -> Result {
+        self.as_manager.lock().extend_vm_update(vm_as_data, region)
+    }
+
     /// Flags the end of a VM update.
     ///
     /// If the VM is resident, this will let GPU accesses on the updated
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 76e3d2df6afd..666af82a37b7 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -475,6 +475,35 @@ pub(super) fn start_vm_update(
         }
     }
 
+    /// Widens the active lock to cover a larger region.
+    ///
+    /// Re-issues the LOCKADDR and Lock command over `region`, which the
+    /// caller has computed as the union of the currently locked region and
+    /// the wider range it is about to rebuild. The hardware lock is replaced
+    /// in place, so `region` must contain the previously locked range to keep
+    /// the GPU stalled over it.
+    ///
+    /// If the region is empty or the VM is not resident in a hardware slot,
+    /// this is a no-op.
+    pub(super) fn extend_vm_update(
+        &mut self,
+        vm_as_data: &VmAsData<'drm>,
+        region: &Range<u64>,
+    ) -> Result {
+        if region.is_empty() {
+            return Ok(());
+        }
+
+        let seat = vm_as_data.as_seat.access(self);
+        match seat.slot() {
+            Some(slot) => {
+                let as_nr = usize::from(slot);
+                self.as_start_update(as_nr, region)
+            }
+            _ => Ok(()),
+        }
+    }
+
     /// Completes translation table updates and unlocks the region.
     pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
         let seat = vm_as_data.as_seat.access(self);
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b1253..bcc864b17428 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -42,7 +42,12 @@
     },
     new_mutex,
     prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
     sizes::{
+        SizeConstants,
         SZ_1G,
         SZ_2M,
         SZ_4K, //
@@ -290,6 +295,22 @@ fn return_preallocated_gpuva(&mut self, gpuva: GpuVaAlloc<GpuVmData<'drm>>) {
             *slot = Some(gpuva);
         }
     }
+
+    /// Widens the AS lock to also cover `region`.
+    ///
+    /// A remap can rebuild fragments beyond the originally locked request,
+    /// so the lock is grown to the union of the two before those fragments
+    /// are torn down. The locked region only ever grows, so several remaps
+    /// in one unmap union onto a single widening lock.
+    fn extend_lock(&mut self, region: Range<u64>) -> Result {
+        let union =
+            u64::min(self.region.start, region.start)..u64::max(self.region.end, region.end);
+        if union != self.region {
+            self.mmu.extend_vm_update(self.as_data, &union)?;
+            self.region = union;
+        }
+        Ok(())
+    }
 }
 
 impl Drop for PtUpdateContext<'_, '_> {
@@ -312,6 +333,16 @@ pub(crate) struct GpuVmData<'drm> {
     _phantom: PhantomData<&'drm ()>,
 }
 
+/// Per-mapping private data stored on each `GpuVa`.
+///
+/// A remap splits an existing mapping and may have to rebuild page-table
+/// entries for the surviving fragments. Those fragments keep the protection
+/// of the original mapping, so the protection flags are recorded here.
+pub(crate) struct GpuVaData {
+    /// Memory protection flags of this mapping, as passed to `pt_map`.
+    prot: u32,
+}
+
 /// GPU virtual address space.
 ///
 /// Each VM can be mapped into a hardware address space slot.
@@ -599,7 +630,7 @@ impl<'drm> DriverGpuVm for GpuVmData<'drm> {
     type Driver = TyrDrmDriver;
     type Object = Bo;
     type VmBoData = ();
-    type VaData = ();
+    type VaData = GpuVaData;
     type SmContext<'ctx>
         = PtUpdateContext<'ctx, 'drm>
     where
@@ -701,7 +732,7 @@ fn sm_step_map<'op>(
         }
 
         let gpuva = context.preallocated_gpuva()?;
-        let op = op.insert(gpuva, pin_init::init_zeroed());
+        let op = op.insert(gpuva, GpuVaData { prot });
 
         Ok(op)
     }
@@ -749,10 +780,50 @@ fn sm_step_remap<'op>(
             op.va_to_unmap().addr() + op.va_to_unmap().length()
         };
 
-        let unmap_length = unmap_end - unmap_start;
+        // The surviving fragments inherit the protection of the mapping being
+        // split.
+        let prot = op.va_to_unmap().data_ref().prot;
+
+        let block = Alignment::SZ_2M;
+        let aligned_start = unmap_start.align_down(block);
+        let aligned_end = unmap_end.align_up(block).ok_or(EINVAL)?;
+
+        // An end may only be expanded if the fragment the expansion sweeps and
+        // rebuilds is fully mapped and physically contiguous, because the
+        // rebuild maps it linearly from a single recovered address. A genuine
+        // 2MB block is always contiguous, so this never misses one and the
+        // partial-block unmap can never reach arm-lpae. A fragmented region is
+        // never expanded, so its sub-range unmap stays correct.
+        let head_paddr = match op.prev() {
+            Some(prev) if aligned_start < unmap_start && prev.addr() <= aligned_start => {
+                contiguous_phys(context.pt, aligned_start..unmap_start)
+            }
+            _ => None,
+        };
+        let tail_paddr = match op.next() {
+            Some(next) if aligned_end > unmap_end && next.addr() + next.length() >= aligned_end => {
+                contiguous_phys(context.pt, unmap_end..aligned_end)
+            }
+            _ => None,
+        };
+
+        let region_start = if head_paddr.is_some() {
+            aligned_start
+        } else {
+            unmap_start
+        };
+        let region_end = if tail_paddr.is_some() {
+            aligned_end
+        } else {
+            unmap_end
+        };
+
+        let prev_va = context.preallocated_gpuva()?;
+        let next_va = context.preallocated_gpuva()?;
 
-        if unmap_length > 0 {
-            let region = unmap_start..(unmap_start + unmap_length);
+        if region_end > region_start {
+            let region = region_start..region_end;
+            context.extend_lock(region.clone())?;
             pt_unmap(context.dev, context.pt, region.clone()).inspect_err(|e| {
                 dev_err!(
                     context.dev,
@@ -764,14 +835,29 @@ fn sm_step_remap<'op>(
             })?;
         }
 
-        let prev_va = context.preallocated_gpuva()?;
-        let next_va = context.preallocated_gpuva()?;
+        if let Some(head_paddr) = head_paddr {
+            pt_map(
+                context.dev,
+                context.pt,
+                aligned_start,
+                head_paddr,
+                unmap_start - aligned_start,
+                prot,
+            )?;
+        }
+        if let Some(tail_paddr) = tail_paddr {
+            pt_map(
+                context.dev,
+                context.pt,
+                unmap_end,
+                tail_paddr,
+                aligned_end - unmap_end,
+                prot,
+            )?;
+        }
 
-        let (op_remapped, remap_ret) = op.remap(
-            [prev_va, next_va],
-            pin_init::init_zeroed(),
-            pin_init::init_zeroed(),
-        );
+        let (op_remapped, remap_ret) =
+            op.remap([prev_va, next_va], GpuVaData { prot }, GpuVaData { prot });
 
         if let Some(unused_va) = remap_ret.unused_va {
             context.return_preallocated_gpuva(unused_va);
@@ -781,6 +867,42 @@ fn sm_step_remap<'op>(
     }
 }
 
+/// Returns the base physical address of `range` if every 4KB page in it is
+/// mapped and the whole range is physically contiguous, otherwise `None`.
+///
+/// `range` is a sub-block fragment, so its length is below 2MB and the walk
+/// visits at most 511 pages.
+fn contiguous_phys(pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>) -> Option<u64> {
+    let start_usize = usize::try_from(range.start).ok()?;
+
+    // SAFETY: The page table is exclusively accessed through the
+    // `&mut UniqueRefGpuVm` held under the `gpuvm_unique` mutex for the duration of
+    // the VM update, so no other io-pgtable operation runs concurrently.
+    let base = unsafe { pt.iova_to_phys(start_usize) }?;
+    // Expressly convert to u64 to work with arm 32-bit builds.
+    #[allow(clippy::useless_conversion)]
+    let base = u64::from(base);
+
+    let mut iova = range.start + u64::SZ_4K;
+    while iova < range.end {
+        let offset = iova - range.start;
+        let iova_usize = usize::try_from(iova).ok()?;
+        // SAFETY: The page table is exclusively accessed through the
+        // `&mut UniqueRefGpuVm` held under the `gpuvm_unique` mutex, so no
+        // concurrent io-pgtable operation runs.
+        let paddr = unsafe { pt.iova_to_phys(iova_usize) }?;
+        // Expressly convert to u64 to work with arm 32-bit builds.
+        #[allow(clippy::useless_conversion)]
+        let paddr = u64::from(paddr);
+        if paddr != base + offset {
+            return None;
+        }
+        iova += u64::SZ_4K;
+    }
+
+    Some(base)
+}
+
 /// This function selects the largest supported block size (currently 4KB or 2MB)
 /// that can be used for a mapping at the given address and size, respecting alignment constraints.
 ///

-- 
2.56.1.703.gf848ed807c-goog

