Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502881;
	b=NuJQaoOhNt4Nzd+KbX/3m9DWzqc4VVz7RdGQ4/CxORkgZFqJooFIV8xRj7k/ORVKJKiH
	 r8hoj5AbEJTCS2/cpoVvWgXEh7LDpDPS2Gw7bgstLXVZnqEGIcBE1ArTJroAevFwSE1q1
	 FOuJ8zhYUVbACZSNkrJkPr6zMKTDfdFXhH+t0qDx87INb74HeHTD80tnECknq5wTrTTwN
	 YwwVkfko2508tPszKgYDTYOkRPbRhXXjK/pfgHg25wW+HRkKW6gL8LOWYcgRqmOosdGC9
	 S3BMFXzk9dyb5TfO5BT1z0sixSKT/jtOwfi4Q8hpJu8D74L4NXf+tOkhzYnC50ByqEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502881;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=J6mvnG12EDoqYLvLk+gFoWDFbHuiJZvTIZxOR9XoL3A=;
	b=uHAQ3KOTeXJ1mIfI6u0Rz7nLWPxfY6U1fB0+AHtGlE4+ZyS4DCxzxyJbXnlXHD4Bdlvt
	 3akzHLDpM/Xvt9mC8pabnIDuEPUwxBuWFOzXJByKMcvv/OyYiMFH0ozis3VJpJEYG+8/H
	 Jx04SfPrMoIpZhQudzuuFL9dlOumgLiOV38T/z7BdLav0nWn9VO2fsC2Pv9iycRMouILf
	 s9MTNG1wQdYpRdENrR+4Qo3gKsaK8qeWAzRKF2yZKX/AM4zf08OA2rbP8woEyPZpocmHK
	 VbpQ8l3z8pJ4SrqStFdOXsvJEWFDfrS7WxWivphOILVSekwWv/bp1iUY+lzWYWEq+Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=P4BYQcGa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5272606A897;
	Thu, 12 Nov 2026 17:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5272606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=P4BYQcGa
ARC-Seal: i=1; a=rsa-sha256; t=1794502866; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UgXls1NeRScvLQI6WBkSTSpzq06K5qfDKOYfWu1tlsJUZIbLmCcpu3o6KznqRBHH/iJ1Vv5fQw+b/7VrFiVm5oUpPGRHqKuzV9P8XpPNQ8VuobxNEimr5I7SWMADu80AX+MDaR2ODIauuDXIt9IdZ1+OCA1olTenZK7P22XKq5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794502866; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J6mvnG12EDoqYLvLk+gFoWDFbHuiJZvTIZxOR9XoL3A=; 
	b=DOUzd4zJbfpBNJDeIWK4037NxOz9zm1Pkef9RIny678+qSaMNT26OG1KBACQZhfdKpdGtl3F+pgCQKE3qbTiTCAyVAqvII/K/Ory3aAy/hRTwAtB5/fStwaPm34icI/8UKCyalLsYmZFNHsCtfbDz4Sl9r9S0JPzrEP0zUs9gvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=P4BYQcGaqhNwr3zKZy77NxGcivjZ3NHrn1aH2BZr6Q2qY5reVANH5Sx+PFDot59vyN9vx0j9SalQm1z0Q9mKRHM9Mhd++6n/fIYYkcw151wXpiQC6TvNO9sHSFb12zz4rLLGidz0hBYUdF7QfPPWpm/GAcfJ0mgGhJQCTd3kfkc=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=J6mvnG12EDoqYLvLk+gFoWDFbHuiJZvTIZxOR9XoL3A=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794502862904739.3424819615961;
	Thu, 12 Nov 2026 09:01:02 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 12 Nov 2026 14:00:11 -0300
Subject: [PATCH 4/6] rust: iommu: add Domain::attach()
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
Message-Id: <20261112-b4-iommu-domain-v1-4-c29e86788dda@collabora.com>
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

The upcoming rkvenc driver will use IOMMU domains to isolate different
sessions.

Add Domain::attach(), which attaches the domain to a device and returns
an Attachment that detaches it on drop. Devices that share their IOMMU
group with other devices are not supported.

attach() is unsafe. The caller must be the device's driver, and the
device must stop using the domain before the Attachment is dropped.
The Attachment must not be leaked, since the domain could then be
freed while it is still attached.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/iommu/domain.rs | 57 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/iommu/domain.rs b/rust/kernel/iommu/domain.rs
index 2e66becde156..2a5b66f2a5d9 100644
--- a/rust/kernel/iommu/domain.rs
+++ b/rust/kernel/iommu/domain.rs
@@ -19,7 +19,10 @@
         Bound,
         Device, //
     },
-    error::from_err_ptr,
+    error::{
+        from_err_ptr,
+        to_result, //
+    },
     prelude::*, //
 };
 
@@ -44,6 +47,11 @@ pub struct Domain<'a> {
 // SAFETY: A `struct iommu_domain` is not tied to the thread that allocated it.
 unsafe impl<'a> Send for Domain<'a> {}
 
+// SAFETY: `&Domain` allows the following from several threads at once:
+// - Attaching and detaching the domain. `iommu_attach_device()` and `iommu_detach_device()` may
+//   be called concurrently for the same domain.
+unsafe impl<'a> Sync for Domain<'a> {}
+
 impl<'a> Domain<'a> {
     /// Allocates a paging domain for `dev`.
     ///
@@ -70,11 +78,56 @@ pub unsafe fn new(dev: &'a Device<Bound>) -> Result<Self> {
             _dev: PhantomData,
         })
     }
+
+    /// Attaches the domain to `dev`.
+    ///
+    /// This may sleep.
+    ///
+    /// # Safety
+    ///
+    /// - The caller must be the driver bound to `dev`.
+    /// - The caller must ensure that `dev` stops using the domain before the returned
+    ///   [`Attachment`] is dropped.
+    /// - The caller must not `mem::forget()` the returned [`Attachment`] or otherwise prevent its
+    ///   [`Drop`] implementation from running.
+    pub unsafe fn attach<'d>(&'d self, dev: &'d Device<Bound>) -> Result<Attachment<'d>> {
+        // SAFETY: By the type invariant, `self.ptr` is a valid domain, and `dev` is a valid
+        // device. The caller is the driver bound to `dev`.
+        to_result(unsafe { bindings::iommu_attach_device(self.ptr.as_ptr(), dev.as_raw()) })?;
+
+        // INVARIANT: The domain is attached to `dev`.
+        Ok(Attachment { domain: self, dev })
+    }
 }
 
 impl<'a> Drop for Domain<'a> {
     fn drop(&mut self) {
-        // SAFETY: By the type invariant, `self.ptr` is a domain owned by `self`.
+        // SAFETY: By the type invariant, `self.ptr` is a domain owned by `self`. Every
+        // `Attachment` borrows `self`, and the caller of `attach()` promised not to leak it, so
+        // the domain is attached to no device.
         unsafe { bindings::iommu_domain_free(self.ptr.as_ptr()) };
     }
 }
+
+/// A [`Domain`] attached to a device.
+///
+/// An attachment cannot outlive the domain or the binding of the device it is attached to.
+/// Dropping it detaches the domain from the device, which may sleep.
+///
+/// # Invariants
+///
+/// `domain` is attached to `dev`.
+#[must_use = "the domain is detached when the attachment is dropped"]
+pub struct Attachment<'d> {
+    domain: &'d Domain<'d>,
+    dev: &'d Device<Bound>,
+}
+
+impl<'d> Drop for Attachment<'d> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, `self.domain` is attached to `self.dev`. The caller of
+        // `Domain::attach()` is the driver bound to `self.dev`, and promised that the device
+        // stopped using the domain.
+        unsafe { bindings::iommu_detach_device(self.domain.ptr.as_ptr(), self.dev.as_raw()) };
+    }
+}

-- 
2.56.0

