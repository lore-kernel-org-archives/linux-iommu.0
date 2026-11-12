Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502858;
	b=k1q5cWKUDMa2YbPQ3mNWBJbi01ikL4EGP73lv0dM6Iq+fxA4IVJAhY+TqragBwQ2Wvxs
	 nUhK9q1lEDtJ/3Urf0WQwdm38uo7jWKjakhpObYzmirKw5p+NXl1dW16lykQ08umCRfGM
	 NX35DvXznxGRoPe34+vz/QsG3gLFobeaRKwNFEqMIMcBATF54agdqiHRzqhiMrnB1yNV7
	 RelLl0zt9on9M1mSNVhZpkMpPkE3ofKMg7PoljSPlQUVjU4Hgb1Zz788HjRBeuRzuBgNu
	 3xNSAVNqkxd09zx0nzIvu/32NvKJaVxS/ObiKB1qM55idfqTssG3o9ESIGu8myZ3lOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502858;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=OEbtzU9uwmtl0K0JSe5qb3/CsbblUiOI+QqP89nwPNM=;
	b=ojHbdKeXfvQdRFoafDqa0+Vz4fJ9DUNWVsZNF3UHMPM4OzXvfKXcpqeB2ArURhgYCyMs
	 dPHqKneuXoCzhTxzp5/KaN6N0IpBUTUzV99ldtSNjM8OVl51i9dK7bKh2baBzutqz9Z68
	 Pt7BPImo+bgm2cpKspaLfGmnIfotiBIo1tRCk716U32p7+YlmRBV2ICuiQulmz/NFhSG7
	 BPDhwpqDMxbHcMlmRUegFvMNT+XpgYRVL22caCuHlHBS7QymPEJlRRAhDyA3oLUA37lu3
	 VheRrQZM+0NrrZ4dw32oSs+79RCGhi1fAKssCcLeE9pMs7IPD8UtXojUWwPiUgjYDKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=FaCgRDER;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5975606A32D;
	Thu, 12 Nov 2026 17:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5975606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=FaCgRDER
ARC-Seal: i=1; a=rsa-sha256; t=1794502845; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=naELY/sGfNqfN0+4LrmZM5yu9ttDQOK7XzPmaCEruZF3mWlnVDY51JjQR8inlHsSn5Eqvib8/KVcQg0vhLqHlrysyRNPBlz9VAtzizLYZFbDC0W2H2k6qxSG3BioxO8hr9slidZBhRinQGm1B3GoUpdnlTu4Jawukntg6siYBys=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794502845; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OEbtzU9uwmtl0K0JSe5qb3/CsbblUiOI+QqP89nwPNM=; 
	b=PN3DwRAKT7RSbm1Ww+XqW41GpkOYgTwnMHplYwEOoC7PwmKczBeHOwAguKP4BVQ9hgsajQLnHI3CYje8j/fvLExTdZn4MrMUOxuVXvMJxrKZrX7MKHJZ0Z0qmuY2scaOT9m23vbqgi0pvJbVHq4byqeHU20jRIUEE/XDU6G8sxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256; b=FaCgRDERCBbXzy6c/UzYrzS+EGGeX7XhEeR5kVYvNrj3FxrV0Ka0kKvgukpq12ANyP4EoA+JPxWlKsw1XvniQPGD/q5t26sFrkZQV0Q/pSRzVsl69JAkcgzcUnJV2qqf0Rn/5wqthaOsMAUrBYDQQbUZxsMG9iuLppdNttGjeDM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=OEbtzU9uwmtl0K0JSe5qb3/CsbblUiOI+QqP89nwPNM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794502843756120.57863446500517;
	Thu, 12 Nov 2026 09:00:43 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 12 Nov 2026 14:00:08 -0300
Subject: [PATCH 1/6] rust: iommu: move the protection flags to the module
 root
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
Message-Id: <20261112-b4-iommu-domain-v1-1-c29e86788dda@collabora.com>
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

The protection flags are the IOMMU_* flags from include/linux/iommu.h,
and are not specific to io-pgtable. Domain::map(), added later in this
series, takes them too.

Move them to kernel::iommu and re-export them from the pgtable module,
so that existing users do not need to change.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/iommu/mod.rs     | 16 ++++++++++++++++
 rust/kernel/iommu/pgtable.rs | 16 +---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/iommu/mod.rs b/rust/kernel/iommu/mod.rs
index 1423d7b19b57..afc9cfffb656 100644
--- a/rust/kernel/iommu/mod.rs
+++ b/rust/kernel/iommu/mod.rs
@@ -3,3 +3,19 @@
 //! Rust support related to IOMMU.
 
 pub mod pgtable;
+
+/// Protection flags used with IOMMU mappings.
+pub mod prot {
+    /// Read access.
+    pub const READ: u32 = bindings::IOMMU_READ;
+    /// Write access.
+    pub const WRITE: u32 = bindings::IOMMU_WRITE;
+    /// Request cache coherency.
+    pub const CACHE: u32 = bindings::IOMMU_CACHE;
+    /// Request no-execute permission.
+    pub const NOEXEC: u32 = bindings::IOMMU_NOEXEC;
+    /// MMIO peripheral mapping.
+    pub const MMIO: u32 = bindings::IOMMU_MMIO;
+    /// Privileged mapping.
+    pub const PRIVILEGED: u32 = bindings::IOMMU_PRIV;
+}
diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index 5f9b42ca92c2..695b62eb4835 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -23,21 +23,7 @@
 
 use bindings::io_pgtable_fmt;
 
-/// Protection flags used with IOMMU mappings.
-pub mod prot {
-    /// Read access.
-    pub const READ: u32 = bindings::IOMMU_READ;
-    /// Write access.
-    pub const WRITE: u32 = bindings::IOMMU_WRITE;
-    /// Request cache coherency.
-    pub const CACHE: u32 = bindings::IOMMU_CACHE;
-    /// Request no-execute permission.
-    pub const NOEXEC: u32 = bindings::IOMMU_NOEXEC;
-    /// MMIO peripheral mapping.
-    pub const MMIO: u32 = bindings::IOMMU_MMIO;
-    /// Privileged mapping.
-    pub const PRIVILEGED: u32 = bindings::IOMMU_PRIV;
-}
+pub use super::prot;
 
 /// Represents a requested `io_pgtable` configuration.
 pub struct Config {

-- 
2.56.0

