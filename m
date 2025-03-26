Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D92571CB
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019989; cv=none; b=E5SoS1EIVdFKxnH8Ol1IJF1RPbbXnQsCAvJ6HGd8eutR1PtvUqOpm2pEGTsulObAXxKvBF9QAT5+k885BRAsKBmZyozcKE3KN/3dyCMI9L6DzgKtLHibn9O+hhBLAynz3vuY+/PBgeY1J8A5nkK7VO1fp2hlpa2UwN26RREJDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019989; c=relaxed/simple;
	bh=QklNTkE+U9D+pTS8UKveElBjdJatRbS+Ai62Y7tPWXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYyZTy82LXid6fo/YfoqLjaWq5NmvgWj6SHT4+wXq2XFVD0OHjzWEdR8M5UY5B51v0VeggaJPh9GTHOC26eCx3XSmrwOxgB4j3wLAavbeGRUL/vPO3KwzI47uLspcUI3dy+6gYGI/kr0Dz79O60MmRoZX5R0sey66YGcYIh6toQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3q0eUyQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3q0eUyQ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so287525e87.0
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019983; x=1743624783; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pveoisS0dkHjk8AoQMkPJTBRAAfPuiNG6lIhjvhzlA8=;
        b=Q3q0eUyQahEjikO0Ys1TO9cUL7a3mLoqly39FpQE+W5KvkICFFvLk+mpakpnnYdGpM
         LX/ILh9+RrW8j9hGLW96jMopLbb6w3pfcPZ8OSImPahj4or9ddmdccJjLKotKwyC+FU3
         D++HvixbKH48Ur5JhXDdRBZaevuee24rhrWR5ZktbLnHxGNQjkcpgi6q5oGAH5BGmiUK
         c8fNg7cDhsea3PMuUWzHvWfPIwCm86apwEr3IEZ+OewRcy9TFd2pHeG0qtNsZEOxurRS
         EIOQA5GH+LMg9wv898sl9rRX9IFCVW7uKI1nsYiGwbeICbvAtPKaDAf9P//iRhwHZHA1
         iMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019983; x=1743624783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pveoisS0dkHjk8AoQMkPJTBRAAfPuiNG6lIhjvhzlA8=;
        b=eXheLDbgJLPL3JfwNS/YwwFm0fEEEgoPrwKYaU05SvwdWh0Nc5bVVMorvK0+2+4jW6
         9e5nQVpRRz8T2B3wu4xAM2WwOWcuSC9tSE1KFJdhXohUmOgS7CE9XZ9h7FKe/qVZRVTL
         P5TIVZQrBkqsMx05KbLXnO/aeNq3yZtNuU8UXFroAxOH2+KTbZJ6d9S55nWDBazqi6XT
         XZjsDNJeJ88YU7yKJYPcHzVWBck6Kt5Tb2qKpWsKcdBM6MZSDFPbOOtOvz/fca5TYBNe
         EHcuGA01QhKG5QfHHQSVxQPRIEur0vht6BgIE2o4O35MI1BNAfe/4iTeOtCcxRcS7e5I
         iVrg==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZFlonIJhwW/77JHbcxVExIy4UpNe5mUiDAZbA/qEN+ABBI7joBCXFQ6bZC5iLsz9F0QO/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuihwtMc4fdB3Vr/NkkHV+9g4QFwMx29T3arWM/cOw1M4sgakp
	EJkJ3RwEQL7c1E+BCcFwL6OtEtZgyg68cvnryH56HGXu86lgXkT+
X-Gm-Gg: ASbGnctMoVAlTCdn2wyEPVR7uL1sTpHF6fYMcU1ppNZ1ipRnZH7oe4LDBcYIxC4HgWl
	WvuiNklkkBmMfLGs0vD9FO65injyrHr6Wz9aHpOtDd1+nyjCr99uGRLf12yaZtkRvl4dsxkeFYg
	oikg66pRigjOc/hZv7MzJqmQvSZbYSl+gR3lClItRGhVREc9Qc10QfpBwOT/nFOaHV0uOg9QaMY
	RA0FjHOHfJHenm2fdVmSSnmTZlWgtDsNrVDmrblwEOvPB0Z1NFU+ZHP942wbG5gtP17cOHKfa4d
	phCCUA7PhpMkPINI156TOMiTJpy3a7xoRG5qLSGC3dr/dyflp33C0JP6gCc8eeduhUdyAfFnDDB
	x3Yb8OHvLOglrYjPxeVFgHw==
X-Google-Smtp-Source: AGHT+IFayDpBMS79xivFqH7xf6jKCQW1raM5CGZsxw5i6zi+hzQ0h4CALk7kf9R32eciaIZyk6BJIA==
X-Received: by 2002:a05:6512:3e08:b0:549:5b54:2c68 with SMTP id 2adb3069b0e04-54b011d6355mr391157e87.22.1743019983084;
        Wed, 26 Mar 2025 13:13:03 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:13:01 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 1/3] rust: dma: be consistent in using the `coherent` nomenclature
Date: Wed, 26 Mar 2025 22:11:42 +0200
Message-ID: <20250326201230.3193329-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the kernel, `consistent` and `coherent` are used interchangeably for
the region described in this api. Stick with `coherent` nomenclature
to show that dma_alloc_coherent() is being used.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8cdc76043ee7..d3f448868457 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -89,15 +89,15 @@ pub mod attrs {
     /// Forces contiguous allocation of the buffer in physical memory.
     pub const DMA_ATTR_FORCE_CONTIGUOUS: Attrs = Attrs(bindings::DMA_ATTR_FORCE_CONTIGUOUS);
 
-    /// This is a hint to the DMA-mapping subsystem that it's probably not worth the time to try
+    /// Hints DMA-mapping subsystem that it's probably not worth the time to try
     /// to allocate memory to in a way that gives better TLB efficiency.
     pub const DMA_ATTR_ALLOC_SINGLE_PAGES: Attrs = Attrs(bindings::DMA_ATTR_ALLOC_SINGLE_PAGES);
 
-    /// This tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
+    /// Tells the DMA-mapping subsystem to suppress allocation failure reports (similarly to
     /// __GFP_NOWARN).
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

