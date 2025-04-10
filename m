Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF620C03E
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275567; cv=none; b=u4FxCEsU+6sSSrDX651n1r7z1CCaoUNgKTuqM6i9lRpkAkA/wlF5DnIWjVYcJsoxd/O223+RLralNmbX2svjTK9+d7uSavVBdo4/e6JZejzadXLwgKZ6d30EVjJ/OUwGVCUtGTQswPgFvFlO82MTVeTW+g223iGO+YRnT0Y82t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275567; c=relaxed/simple;
	bh=WqzuZjN2OlAEP5U+WrT20wORev7uTKByfRxp1ekMkR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9zfQcVerKbG7cKphVMR8QR7D3UvAfqmU0MNoBpBY3QJi6tg5FKpEOfYQYk8BfWL801xt7d8HpHYULFzk8glnzm8KsjlsYUOe+wIHL+fft1RksegIt617+QKnMSZ8SR0MvMTmVCiipu+sA6NMhqQn+H+HYAsifMiTLXmwQW6ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsuS3sbc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsuS3sbc"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54c090fc7adso628267e87.2
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744275564; x=1744880364; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Cn3iGXk2B43PzN7CtJiYrgGpJ21xhd2OrhojDiLX8=;
        b=MsuS3sbcEcvBC0SjmIYil3zXx6oD7Bk9IAHpbjYgfKM7dIcSto/nninjyb3kTlEgxW
         c8pAPoFQkxbOcdQVJq1J0GTHblWllyAbhtFqlQMRbdMygc7iAYyCUzeEDujHayA2l2Ak
         EpKqq1qEQoGIhUELDiDNiKShG6NtRnLvVxlqBssvYh6oyaMb5TfgItyZq2BghfGMn/c4
         E8gMPQ4fMdsET0Mrl6VTktTHHLUT6nMCANjI1NqEJbgfT1sDlWXDVuUvk9Fd+6s8RkfY
         sSrflyuv2K9304hBDMaxQ0j6ah6ZTshe8P8QeNFzitrBrjMY5FKoExUxhjLklnyGqU9V
         CV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275564; x=1744880364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Cn3iGXk2B43PzN7CtJiYrgGpJ21xhd2OrhojDiLX8=;
        b=FtuVXuaJ3JA7a7jlkY+5ZOAvFgouoG4rwHGbV4gLyau8XX4pFnY0PyuaQq7c2erGsa
         hMDk7CF45B5wd436Z16GoOHdTs6X0qnVc8EcNF4rKm9GLr8YRkdyQMdN5MfFu9BPu+SH
         tvnD1/5M75PvmE0oh/jLkho4E/6w5XzDzU/f1OnqttRswkw7W8wEI0nJF18RD7ewhhls
         zmEDkehdRYPCCNm9Al63nCOSd5l0vw6UDbOod1JqqLFNf95pJo428x9PMW5HwX+mbv3r
         gZTLvHgfXbaoS5u5vfSc0/nqFzbbtVznVWdrogh4AlxIKCtGJF/zAevFcddU8qRe9dUH
         IGOA==
X-Forwarded-Encrypted: i=1; AJvYcCXtQxfe52yyGmfs6n0njekQhtTFWPxnSahU0CgOOQJqD15RWrQJ1DUVM+sfjcZAgPH9NX7LZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiDMXCQpJEH1RMhRLc4lK+BHmf+FrlxZCm/XFTSZxgpaBxxQX8
	Cjq5TvvgvIwTOp0/X0uGdmbR6kT2Sis3SxG/j1kJCldw/hHLei5H
X-Gm-Gg: ASbGncta95X3+R6jK5JHCQihsbjiTSKKwpY6QraCpsEtCP5cbE6o0NRo8NwpSJjpfvd
	8TeehKWzwYJ2Z/pEQbVxCcYtl9swIWRcFaGrtp2krL2mVLnLaILUQgZhLR/3acdC9xLFbrw0zT4
	9Ajst/s/yt0RmyJJPR7Dayd9aL/GPwsUhi9ApuWFTuwxsLKbf2V38nSxAnBDNGV4P216hAvemfW
	VBkeFVqB8K6SWhgEndvnIK0uxUDs7nbKVswklymPQS178cNINKL6tPEARnF5aJ+Jj/ioqQB71wu
	jYTTb49Ge4vgfHF5bcEGjZ13fV3sWw8VvjuFFp3e6LRrbPI3dX8lpaGERWejgcOJQGutLhbsam3
	1JCIoeW6Vagtf4Qt03fDgfNAjvjJD
X-Google-Smtp-Source: AGHT+IGs/lD9lWhhqJTHnVSN2M7rMU3M0DOoajmMiMIfO1CH0MSvgj//lmfzQx4yyiHxY8DPuESrdg==
X-Received: by 2002:a05:6512:1109:b0:549:38eb:d68b with SMTP id 2adb3069b0e04-54d3c5c0554mr469398e87.33.1744275563485;
        Thu, 10 Apr 2025 01:59:23 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50285csm80875e87.110.2025.04.10.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:59:22 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	benno.lossin@proton.me,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 1/3] rust: dma: clarify wording and be consistent in `coherent` nomenclature
Date: Thu, 10 Apr 2025 11:58:16 +0300
Message-ID: <20250410085916.546511-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
References: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
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

