Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA21DDC1A
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854495; cv=none; b=M7HQbkCAc4/AtA9nHC51/K8SpWZK/rKsItAOd7Z4xhc8jhrsdbVJ//tZQTsmNoYCg3Q92cQqqEJqSlSbnzW/TvevaqN5NajA9quHSzvOENCmUFlavrkapOykxq0tPcW8LgN0cjIRI2w0X+t3nQAQ+Od5cW6FCp8DKdHXBxpAvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854495; c=relaxed/simple;
	bh=vdte7XjxyvO5sYF/1isE++FjO7g1ns05+zWEcuh9RwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZlqUj2/kTBJ1ww3TUzdyZzO6MLisXUOBsAU08LpM/nIwmgsrBHTmVXLc+adZmJNzxtQzRxNfNVQPnxDPKMoRs/7Vvo+Y0P8V6AQhARZm0BG8vh9YGy7d3DbhyiDvW0qP9518Pdl7K+FLNNSXtsg6msnaGywvkOhCbUdrhC/WW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYe/jhOY; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYe/jhOY"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5532a30ac45so4195997e87.0
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748854491; x=1749459291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmm9TMxx1UWco/se+EJ0p1bxOhoMbO6epU94xaJakwI=;
        b=JYe/jhOY31biLc+d5aGS4KCJ1FB+S9X5m14fbJDBEwTApo9Dey4Ynhq2XGp1lAwYP1
         b+L6f7shOjOb+jKgUxtPC8tR+u4OGsCNN7C0UqGeogSrtWvpBf309bl/UyZ0qhxDspMH
         ltcWMR+wi8EAS4ivxbIHYob//wX3YJzDQs5vx9Uedj94OAZK3Fv89/7ApzF4sSij2SW7
         gcwzsGnM834Mbt1u2yUR3ADpWp1Jp3ZxCIK3rWWmDsI2KmPubtULNTE6ZF6kYNsrvoHW
         TvDoF11VjNg2cJmI0ZNpgfTO7FUiO0+EpcD2mXbs0HUhQd/WJztmeWmX6Qn3yN0BOJ2n
         +MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748854491; x=1749459291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmm9TMxx1UWco/se+EJ0p1bxOhoMbO6epU94xaJakwI=;
        b=nequtJjo31aKaU302lJzQZ0z/2hN1oCG/j3wn2tYt289AUuBPErOdfFBEdFOXoE+Tq
         SFcFfqdC4RYxSoJf70h1Zld+aY8KN9tD6KPMjEp/m0FO9YUUczUnmQPcQaLSryyKhby3
         oIBFE3gtgmjtD99HHlRu+9CDpPFf1yPsSAoYFCwqV9ICysYBZYIDkX8aZPx8YzuJVIt8
         hzj2uzxyu17VzAMg9hW4YSbuqiYUosx0VU3g+sqY3LF21VS6vSDhGMwkAxiSEY9Pmyw0
         kPNhrsyZNX+BiPJj5pAXWNlumkwTm0lB5+pG1EYIeT3QPj/lhR4+h/qKp72RE5brdu7Y
         m3gA==
X-Forwarded-Encrypted: i=1; AJvYcCUL30a2KX0D2emiHA8rC3p+AVxioafdSiNZOQ4LgW8ChkGQd10LNOL1tqyv3m/fAZdKYzs0Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbAFvmmEWHJeJ12hLcPBQpf7WDwP+3KGftEB8JtCTUKfCpCNeF
	ArFXOERVsbSWLfFvdKo06n2W9wQJfdagA4bNEaytOBsuMgrQHgTuluE2
X-Gm-Gg: ASbGnctpEwPniYWcMdrkf8XKQNQhc31H0m5ErsS585T5wC6GCj8QX4PlpNgbSDNtad1
	u9rFFqhCCHK/SJd1OBZ/zXPkWb6Q0+ZOGEjNddbERNXUdbb152NgEJGal4yf9gWdL4+JwCkCgTX
	DtZ7hURhbp1mqgOeK9XxdroPhhXElwIJNGv4HxcwwQHWItIATkqsBshOW3ohuCnSiwnNaMSP49p
	L6pm91mWDtwmsXEJglNkPLVNnVdwXgk++JNCYTJhfhSclfzAI4ybn025MWJLYJU+zjMwOh/09RQ
	V/kWUA55SU1DjTbrAGuLSBWytSPRqM50QzSLuMdvA0WK02gCz93bg2gEMuKEkmMHnI5EAz7vgzy
	2cQFNM/2Iezizvbojawe5Bi5UbZZy
X-Google-Smtp-Source: AGHT+IGeQ2VJfS2pSQq9y4fFCIu/d3EP9UcOUYcg/V5Nm0QONGa3Ygn6eN+EP+hDSxJMw7LdEHQWFA==
X-Received: by 2002:a05:6512:1108:b0:553:2927:9864 with SMTP id 2adb3069b0e04-5533ba23ab1mr3493372e87.6.1748854491275;
        Mon, 02 Jun 2025 01:54:51 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a13basm1524325e87.81.2025.06.02.01.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 01:54:50 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v4 1/3] rust: dma: clarify wording and be consistent in `coherent` nomenclature
Date: Mon,  2 Jun 2025 11:53:11 +0300
Message-ID: <20250602085444.1925053-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
References: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, `consistent` and `coherent` are used interchangeably for the
region described in this api. Stick with `coherent` nomenclature
to show that dma_alloc_coherent() is being used, in addition to improving
the clarity in the DMA mapping attributes documentation.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 35fd8a638473..c3fe39e7eb0b 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -89,7 +89,7 @@ pub mod attrs {
     /// Forces contiguous allocation of the buffer in physical memory.
     pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
 
-    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// Hints DMA-mapping subsystem that it's probably not worth the time to try
     /// to allocate memory to in a way that gives better TLB efficiency.
     pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
 
@@ -97,7 +97,7 @@ pub mod attrs {
     /// `__GFP_NOWARN`).
     pub const DMA_ATTR_NO_WARN: Attrs = Attrs(bindings::DMA_ATTR_NO_WARN);
 
-    /// Used to indicate that the buffer is fully accessible at an elevated privilege level (and
+    /// Indicates that the buffer is fully accessible at an elevated privilege level (and
     /// ideally inaccessible or at least read-only at lesser-privileged levels).
     pub const DMA_ATTR_PRIVILEGED: Attrs = Attrs(bindings::DMA_ATTR_PRIVILEGED);
 }
@@ -105,7 +105,7 @@ pub mod attrs {
 /// An abstraction of the `dma_alloc_coherent` API.
 ///
 /// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
-/// large consistent DMA regions.
+/// large coherent DMA regions.
 ///
 /// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
 /// processor's virtual address space) and the device address which can be given to the device
@@ -115,7 +115,7 @@ pub mod attrs {
 /// # Invariants
 ///
 /// For the lifetime of an instance of [`CoherentAllocation`], the `cpu_addr` is a valid pointer
-/// to an allocated region of consistent memory and `dma_handle` is the DMA address base of
+/// to an allocated region of coherent memory and `dma_handle` is the DMA address base of
 /// the region.
 // TODO
 //
@@ -138,7 +138,7 @@ pub struct CoherentAllocation<T: AsBytes + FromBytes> {
 }
 
 impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
-    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    /// Allocates a region of `size_of::<T> * count` of coherent memory.
     ///
     /// # Examples
     ///
-- 
2.43.0

