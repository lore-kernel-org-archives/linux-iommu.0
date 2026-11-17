Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943958;
	b=tb7Oqns2Kqg45w30bAlt5LabW13omo4FNlS2AbdWblKpLEk1XvCnpJFnmAUK/EiwlFv8
	 BZY+3Z2+p+OsG9i+oBTzv/yf7NV0Wiyjxhjc4M5mnJBvDJbV6pRxQr9aMyvYNowN/qylR
	 Gcoc2H2R8uhyYw7W1aKzc/lA/64B5K0dxebNG8H+s38IJWv247okL9WakkO9W+PaBoA/V
	 UepY42mjgsg0i8xqVs5u9vn0iNRnx7xSOo+X9qU8tgwNIHTwUNTbR5onHB3E0wBKjKxDV
	 Qbf/yyNjB3F1Dy9L71KKAHuGFuQ80mAtYRx3HSfU0HXdVq0P3uVCmQtRMeaS/izFHWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+0+txM7MPeyJRwa0Sn9PNj0P/voFCRRCRvjyl+hjpB4=;
	b=KLWpLVxFUjmbzxKZE9WdpgXtkuXXFLx4o8tUEUvD3Y1RxC6nJBnlWio6/+RkzE+u1Sfw
	 R1Bm6V4Nw3S/eetLBal4tGS3mhKqNEVoZ1eEdr7Q2cXwkG8mup67c8/03KDlQ3wPHVr/4
	 ow+Ei+zK/lCPc/nsX90M4gk03MM76NTzlHsQPp+sghBF6WOqPdfBeuD3TY16RoanE8GRM
	 Semd5yHyM5NzfaKp8/fgSVXSekHaJG3OENYPNppMz2cjSGOzyLxDwMk3lVWcycBJmKIC2
	 nwyd7ni3CCTSAarBshpWWqn3wPjshNmctMmAXcgjJMjQvl2VD4NI9M3cPBk6nOvrgpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="a/l8rJF0";
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F960A263F
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C27F960A263F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a/l8rJF0
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a370217dcfso138837f8f.1
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794943956; x=1795548756; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0+txM7MPeyJRwa0Sn9PNj0P/voFCRRCRvjyl+hjpB4=;
        b=a/l8rJF0wGefUMR+iKLU1LnXX7j8q655kHQp4rInqpcVpNYH5un5XSlXQpSYC22APO
         zBPOUkqmAM4eTMBZt4zXMOBXqFSNI6vRXLYyAMgJvliuMaco2mkKTMgVRlF4xKEYJzq/
         550rfRsPxLbVPlOo8rmz8/KY/1sgbv1a+28t6l/rIu9t6Dob+1WWmfkSXRcAnfhp+Ca9
         Q314hOJTDscPAcxeiSqEQVoLqJyEA2utAyYuJJzqkPYNGKTOYzFryV26ysLhRJnG8wJg
         /lVlgu/UNnufs2zGkWhaN0ETuVhzsW68BlU5rvRsSX103FlS8x1StjtI1YOeRyVyvuOg
         t/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943956; x=1795548756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0+txM7MPeyJRwa0Sn9PNj0P/voFCRRCRvjyl+hjpB4=;
        b=q0HmzCk3tXAWlEpI5Em+VSIIEI3uj4XCw5qjeTCzegW8TyamVJxApxfYCD5piuU7u9
         xIMhv7SsxXHNowq/IUd1K14tINrXZtuxfPDkIKF4ej8ZIvC2c92ZSNTaevmmtvHxZzhR
         7udcAQWcMwzVJQdUNIpIGykZozFCt5Z9A/MzyYvKR4dL29Xi1hc0C8jhfWn31HgLajNL
         bwUeQuY7/lODDgSPH00H84rNyYpMDJjmRscKD/VxUl4bnv3pzewIXKfYHtbGs41fBH3M
         K+vzKq8pnGJGZs798GaIIw29t4ZnWF7CAngRLpx7FV4NHGaz2dREGNpvkh6VrccH3ulF
         yJCA==
X-Forwarded-Encrypted: i=1; AL+hErH/we+5cslGizGljTQBQA7LJZoDAiYBIVkPddDGcT8+rme6emfQMIhMps1LL6nM5A9+kfsa6A==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+/LSKRwhgeQF8aAdJcI2m+aUfy5CMzP1cLv0Y1g8HzM1doLAT
	VSxKC9chkyrgssssqtb/4Y/zeu0Sju4tSByQaJq8KyfhpUjnkkNYOZ0cMuF3YS/1Vamf6AXc4eY
	Q6nIlP5hAbzyZpG6R/Q==
X-Received: from wrnb4.prod.google.com ([2002:adf:e644:0:b0:4a4:9fcb:c0d2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:983:b0:492:820d:107e with SMTP id ffacd0b85a97d-4a63cd0eb78mr804149f8f.47.1794943955847;
 Tue, 17 Nov 2026 11:32:35 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:18 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qullzfbasZ1PBAiwmelJR8Wu/8Cq09DzJ4AhkY0NXXE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQhhfo/i3hpH5lFbOyDEwYbHCYaKQPRqu7h
 BvCnbobi0mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 RojaD/92+hR/vatJndmWWwF1FE/2fpo442zd/mWkRgzBkO4VFIAIzF35Ckwt+5scDlitsJkhc4o
 7T+bS69Ze3KLWfegrGht24waHlj7oB6wbMYYWLuZPB4utAyG5ljJC0mvJ1qATyBmphbuTCBLuFi
 5wHzxgysG3H0vwDgykoqSpqhIhuDKyYQFHTOa+gQZhI/xcR0TLOEx0Dfw6zILOQX17t8WJz345G
 KDFh2xc0uqfU3sV8o9EcmfTo6F1641JtsXVIZY+Oc8yCAv826HzwsxKkFFYyfjlic3zEblEubUV
 xhxRwbdq76B9Xmq0i9Y1COm6pHZb9KUaT+yeeYxGUEamZwGS/M5a1palNLRGlKuWT8AOfxIiWcx
 x/w6kfDtP2nKNMYdbIFzkDF78wkZAsanc9VJOAca1Zotbxsz7w0NKQNoYgUV6WrYcbUQ/PVupF/
 g+6zuUAwfP1uey0kc0/sMvH3qwmkT0hHalKomEES5QimHuMCP738vgMWnft4jczbjNevxCtr7CT
 6vrskXM6peY7eqcGV+YNA7uCIc8fRk5XD+IXrNInmibFCEIe8m7qUPHjcOL28p7WLdh42VO/4Cq
 vXfm9Xij3ONUlRy/h4Vdizgeo4bpmukCIFSSZnsdGDujDlDMIDbMcpZ1cibReJ/j390RfadZalx zRc6pYOXWN28N3w==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-1-2a8efd4c8180@google.com>
Subject: [PATCH 1/4] rust: drm/gpuvm: add GpuVa::data_ref accessor
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

Tyr's VM_BIND remap path rebuilds page-table mappings for the fragments
that survive a split, and those fragments must keep the protection flags
of the original mapping. Add GpuVa::data_ref() so the remap step can
read the VaData of an existing mapping.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: split into separate gpuvm and iommu commits]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gpuvm/va.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index 46493f0ec5a6..f81302faba61 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -87,6 +87,12 @@ pub fn obj(&self) -> &T::Object {
         unsafe { <T::Object as IntoGEMObject>::from_raw((*self.as_raw()).gem.obj) }
     }
 
+    /// Access the driver-private [`VaData`](DriverGpuVm::VaData) associated with this mapping.
+    #[inline]
+    pub fn data_ref(&self) -> &T::VaData {
+        &self.data
+    }
+
     /// Returns the underlying [`GpuVmBo`] object that backs this [`GpuVa`].
     #[inline]
     pub fn vm_bo(&self) -> &GpuVmBo<T> {

-- 
2.56.1.703.gf848ed807c-goog

