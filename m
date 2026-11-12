Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502870;
	b=JtI3/zGroNJCBYjLldiB18D9RDPJrHtgxB9pCfC5p6v+WoOxC6vm2Uc25/vcasOtCNV0
	 Kzpi4ksGwI+kijgPbGw+zfIKcZxerR6iwkZigCLgRTXLrlAweECq6VdPwLOr47/ROJ0BW
	 TxQDH3BfnLfFyHNd6E46VU4zOP3qu9qZ0yAHGnNbnSmrnMA3/uV8dmb9RzK0GfCTaiO+P
	 cCX55GGiqEBc8scSIADZF8IrABxb7+d+GLOZ0Z1UYpvZiQpIpnwfy+4jG+ZicMqjwJtxm
	 QFVuGGPJgtewplzUWcdpjCvXXQ78o1MW8MtDW5S/F24lv9ghnyGUq5RXlI/ZvPu4Ajw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502870;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=l54l8F6ChrZEQ9IliQVSHCHPtGgTJboynSGjuo7L+UU=;
	b=d0ovM1BYSTgUBN62krD5fWqv8n79gfVwMSf+pZMJSyqT+yP9dai3PsHlVYsyojBsX0MI
	 ikEo2AhOm9g0OM4To2DitsVUoT+R/BRbG6MuMig3Jv3+7AdYPrP32e+Zlay/6TOV65eew
	 Rwlm052J9DMzAoSQ1ji8JhZWvyb0B6LQRb4A2zrFJ2nDdltEAC93OUAwLHKp0Yod4Q3Ie
	 VJvmuFAF2OkBPm4WNB0IdJhvHTIHhRc2biXurxa3c36L5Cb+oMuIrD+UmqQjfZyHiJdOn
	 Qh/+Gvcvdjl6Hcsk8RBYs96umiclUEja+ju38Cc/Z2JFUZr0eGKfPdgEdqjv2FZzUyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VDGNgA6h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.11
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC0606A323;
	Thu, 12 Nov 2026 17:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52EC0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=VDGNgA6h
ARC-Seal: i=1; a=rsa-sha256; t=1794502857; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OnIEemt8oiYirBng1HPlLjMyXhijLi5XTgRnS5idUJzxTxLl5E7VhbgsqvIZIHhtRYmvdXhZ16Fysw5ONkXAFAUSS74OHEKr+zN0J4fUlGNDe9BhtreLuoJ3VpoO/qGB6wxH8l1+pqi4tuV2E8EWvepF3UbM2A5VLYBNK/vBkv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794502857; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l54l8F6ChrZEQ9IliQVSHCHPtGgTJboynSGjuo7L+UU=; 
	b=GFZ5ulRmeqU22btGr6p08NudjTdU6PInAUTZyFkYDHP3UwspOGwRk3oEFG3JhIHnxlwamUCl+xJfQjD3ZXSwd4NKastkoY52guoPhNsigfC7O8OSAxYwAuP5KXGYy5J/d6a8HU9ImHq4CoWE1QmhEuNXyKl5lGOPQlShRaQ5qqQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=VDGNgA6hcn1gOqvb6zWQhqRWhWRC9+2SjFIJ+jq76NEOL9wa3qN3EeB3anjG99xvetPxok0Kmxd5OKHsHyO4r5RLt+Vu6+Zg5DQXVs3mInQ/VQRWJ119hMx9eOWqUjXX+RscJZQ/j1KpOq0e3DNz+RK0fcIfCWRwqCSoWXb0AiY=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=l54l8F6ChrZEQ9IliQVSHCHPtGgTJboynSGjuo7L+UU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794502856084102.6314223997532;
	Thu, 12 Nov 2026 09:00:56 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 12 Nov 2026 14:00:10 -0300
Subject: [PATCH 3/6] rust: iommu: add the paging domain abstraction
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
Message-Id: <20261112-b4-iommu-domain-v1-3-c29e86788dda@collabora.com>
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

Add Domain, a paging domain that is allocated for a bound device and
freed on drop. It cannot outlive the device's binding. It will be used
by the upcoming rkvenc driver to give each session its own IOMMU domain.

This is needed as rkvenc's submission model will let userspace set most
of the encoder's registers directly, so the kernel cannot check every
memory access that a job makes the encoder do.

With a single domain, one session could make the encoder read or write
the memory of another session. With a domain per session, the encoder
can only reach the memory of the session whose job it is running, and
any other access faults.

Domain::new() is unsafe. The caller must ensure that the IOMMU driver
behind its device sets a domain up fully when it is allocated and
allows concurrent use of it.

Attaching, mapping and fault handling are added in the following
patches. Attaching and mapping rely on that requirement.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/iommu/domain.rs | 80 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/iommu/mod.rs    |  2 ++
 2 files changed, 82 insertions(+)

diff --git a/rust/kernel/iommu/domain.rs b/rust/kernel/iommu/domain.rs
new file mode 100644
index 000000000000..2e66becde156
--- /dev/null
+++ b/rust/kernel/iommu/domain.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IOMMU paging domains.
+//!
+//! An IOMMU domain is an address space: the devices attached to it share one translation from
+//! I/O virtual addresses (IOVAs) to physical addresses. In a paging domain, that translation
+//! consists of ranges that are mapped with `iommu_map()` and unmapped with `iommu_unmap()`.
+//!
+//! C header: [`include/linux/iommu.h`](srctree/include/linux/iommu.h)
+
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
+};
+
+use crate::{
+    bindings,
+    device::{
+        Bound,
+        Device, //
+    },
+    error::from_err_ptr,
+    prelude::*, //
+};
+
+/// An IOMMU paging domain.
+///
+/// An IOMMU domain is an address space: the devices attached to it share one translation from
+/// I/O virtual addresses (IOVAs) to physical addresses. In a paging domain, that translation
+/// consists of ranges that are mapped with `iommu_map()` and unmapped with `iommu_unmap()`.
+///
+/// The domain is allocated for a bound device and cannot outlive that device's binding. It is
+/// freed when dropped, which may sleep.
+///
+/// # Invariants
+///
+/// `ptr` points to a paging domain allocated by `iommu_paging_domain_alloc_flags()` and owned by
+/// this object.
+pub struct Domain<'a> {
+    ptr: NonNull<bindings::iommu_domain>,
+    _dev: PhantomData<&'a Device<Bound>>,
+}
+
+// SAFETY: A `struct iommu_domain` is not tied to the thread that allocated it.
+unsafe impl<'a> Send for Domain<'a> {}
+
+impl<'a> Domain<'a> {
+    /// Allocates a paging domain for `dev`.
+    ///
+    /// # Safety
+    ///
+    /// The IOMMU driver that `dev` is behind must:
+    ///
+    /// - Set a domain up fully when the domain is allocated, and keep it and its mappings until
+    ///   the domain is freed, whether or not a device is attached.
+    /// - Allow one domain to be attached, detached, mapped and unmapped from several threads at
+    ///   once.
+    pub unsafe fn new(dev: &'a Device<Bound>) -> Result<Self> {
+        // SAFETY: `dev` is a valid device, bound for `'a`.
+        let ptr =
+            from_err_ptr(unsafe { bindings::iommu_paging_domain_alloc_flags(dev.as_raw(), 0) })?;
+
+        // SAFETY: `iommu_paging_domain_alloc_flags()` never returns NULL.
+        let ptr = unsafe { NonNull::new_unchecked(ptr) };
+
+        // INVARIANT: `ptr` was allocated by `iommu_paging_domain_alloc_flags()` and is owned by
+        // the returned object.
+        Ok(Self {
+            ptr,
+            _dev: PhantomData,
+        })
+    }
+}
+
+impl<'a> Drop for Domain<'a> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, `self.ptr` is a domain owned by `self`.
+        unsafe { bindings::iommu_domain_free(self.ptr.as_ptr()) };
+    }
+}
diff --git a/rust/kernel/iommu/mod.rs b/rust/kernel/iommu/mod.rs
index afc9cfffb656..b6e96b8d7af8 100644
--- a/rust/kernel/iommu/mod.rs
+++ b/rust/kernel/iommu/mod.rs
@@ -2,6 +2,8 @@
 
 //! Rust support related to IOMMU.
 
+#[cfg(CONFIG_IOMMU_API)]
+pub mod domain;
 pub mod pgtable;
 
 /// Protection flags used with IOMMU mappings.

-- 
2.56.0

