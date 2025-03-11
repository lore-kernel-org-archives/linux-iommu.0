Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D8026460D
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715407; cv=none; b=RyUSZlrH5wHKpaSMvUP8ez44qBYiMCYbO+Gx4g26tFMBm0r/MMLXP6GV0CAeMegy7zX6gKQVJUuBwDKLy+LOkaFr2tlV/bDxQelsL0SQlBwfm/Fp8EbVmjtbjTKTP3SN5GCpv0BPx+gsj62ZAArQT0zcbiguvnczC08L7tPOYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715407; c=relaxed/simple;
	bh=jCAxjyGzs4oya9QaR78RpvqzvHqmUmPWVJY26/yTUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY/3Ax3xvZokBPkyNfAAm59oZSbap9PzVDRh9HxcV1Z4VGlkL44mcJcW4O7cffhFxCrnhOurWUIx5JsVP3U6jL5I5e8O+ap9CyHw/FXUgifnNa/sdhT5XIle5CC2AHd5hZ2awgzAzGlZlQn3CLUWUwvD31JJy/k8mPvi3BdX2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8erBZ4N; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8erBZ4N"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5499d2134e8so3376352e87.0
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715403; x=1742320203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/BcF9+5sRTzvu9Wbc78vwyZ0YSIeBA8i4IVXLbkZM8=;
        b=A8erBZ4Nm+v1wjql6V1hFOzgoLftcV7Hkm6Rcg0aGZ/Jp940o4MtICaJbhHrdxW1mI
         6/jwL/NGkbIvlqPDCIg1IdmzHJWJio3yvHr7RzZr/+sWn3k8TA3wUJWBe5cnqgWXqBBQ
         +cUTYxoIetu+6Gtv0wzAsnZgHMKVR+riD88nXf2frCBaUDdXgC7wb9XOyYF90/pdwUbR
         HNejMJtmi+16TDytKJ39BWH9d68Q3vN1ubQ9qhpamAvpcOUiQwsKr358pdiDWbBap20C
         O4+aCsAvU9P/GH7T+FOLT1hziEchblXU5hXonJGOwYtjcT6XyppOBcFkCBgcm3zsmIWX
         PfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715403; x=1742320203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/BcF9+5sRTzvu9Wbc78vwyZ0YSIeBA8i4IVXLbkZM8=;
        b=FM/DokA9JBNj50MmaS5bXoVZkT2o3wpNupZDi9y6EWOijMUV6O7HznndjUhId9sH9S
         Ykdj19TmeShoQnCiLQLsF3KcNGXONh7V0cGVxGMQprtlwuMQuzfBFMLhiISc2oAt36xP
         JFrSr5+80j+6Usa4xtPOGevfEyEegiziO19c5+0Rdhk0HXyZq41SRkaaodnjQ+bSL9C4
         U1AC+Kh38aGmofnZBOs6S/xZT1vDnjKTEmzF3hEjp5R11Xnw1IsdQxLwiRY+HsMBfqBP
         sFaaPoHE6o4R4q/jmysg1NQXEGTyOfOXaaO73OeXyEnSz3VwTUz3YEGpmvddaHWveXVU
         DU5w==
X-Forwarded-Encrypted: i=1; AJvYcCUvlnvYmmpD387+ozUQKB4MWcD0K9r0GCFZuiwPJqZ/soc3jHkTmAmjtyyFku5q28koKdyafg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmaguCdQqkGv5jZ2EvRAVPs0hN5O/eepXw7Y43GvpPcOG38NvA
	gmWHrD240oD5KhWO9CEGM1YFxCqrU0RO/wogCb17BfZEwU5BsavN
X-Gm-Gg: ASbGncvc05jErY3jxV5+Jf3OCR+QhclI64VPu7may/MKZfYnWhdKx14Dta8ekXUwX3H
	T2Jxj+Bfltsmuv8xoFrtHa/OABlImrc5kFVNb5e0CBVWN9VgMip6sunN1EW1/XELc0FqcsgAMcI
	RWsUwGIycqoWH8M+1ufQ+XfUbl95M7mkVCXs7DgWIb+jSP7ehNBH27iC7Zcu3zZyjfya7haVsKX
	8MCDBUhxmvw1lyUjGMSfltDp1iqBJ7Uw6a4kL8Dy0LGT1pCpFH9twHvf9t8vSiJKnuiPvDO1QAm
	rqgwcCxtTU9VBqCXF113TfA/oxNWBavRQl6slADTQ2tgK4JtvcL103YCSdPoWnIWlxZMG2WYkOH
	drq+s35KIFxtyB9H9/9t2Dg==
X-Google-Smtp-Source: AGHT+IHblh0TlLPZ43+xMrhkpG+KkUIQT9tbXvVKDpewT/2IX8Y/8KH0Ot/MbNxqkdQ9EYAQ8UxUeA==
X-Received: by 2002:a05:6512:3da3:b0:545:296e:ac28 with SMTP id 2adb3069b0e04-54990e67291mr7588998e87.24.1741715403240;
        Tue, 11 Mar 2025 10:50:03 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:02 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v14 09/11] rust: dma: use `dma::Device` in `CoherentAllocation`
Date: Tue, 11 Mar 2025 19:48:05 +0200
Message-ID: <20250311174930.2348813-10-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danilo Krummrich <dakr@kernel.org>

Require a `&dyn dma::Device` in `CoherentAllocation`, such that DMA
memory can only be allocated with devices on potentially DMA capable
busses.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 16 ++++++++--------
 samples/rust/rust_dma.rs |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index ac3ec0042327..d0c6569cfc70 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -57,10 +57,9 @@ fn dma_set_mask(&mut self, mask: u64) -> Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::device::Device;
-/// use kernel::dma::{attrs::*, CoherentAllocation};
+/// use kernel::dma::{attrs::*, Device, CoherentAllocation};
 ///
-/// # fn test(dev: &Device) -> Result {
+/// # fn test(dev: &dyn Device) -> Result {
 /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
 /// let c: CoherentAllocation<u64> =
 ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, attribs)?;
@@ -178,16 +177,15 @@ impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
     /// # Examples
     ///
     /// ```
-    /// use kernel::device::Device;
-    /// use kernel::dma::{attrs::*, CoherentAllocation};
+    /// use kernel::dma::{attrs::*, Device, CoherentAllocation};
     ///
-    /// # fn test(dev: &Device) -> Result {
+    /// # fn test(dev: &dyn Device) -> Result {
     /// let c: CoherentAllocation<u64> =
     ///     CoherentAllocation::alloc_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn alloc_attrs(
-        dev: &device::Device,
+        dev: &dyn Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -197,6 +195,8 @@ pub fn alloc_attrs(
             "It doesn't make sense for the allocated type to be a ZST"
         );
 
+        let dev = dev.as_ref();
+
         let size = count
             .checked_mul(core::mem::size_of::<T>())
             .ok_or(EOVERFLOW)?;
@@ -229,7 +229,7 @@ pub fn alloc_attrs(
     /// Performs the same functionality as [`CoherentAllocation::alloc_attrs`], except the
     /// `dma_attrs` is 0 by default.
     pub fn alloc_coherent(
-        dev: &device::Device,
+        dev: &dyn Device,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<CoherentAllocation<T>> {
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 1740140faba6..4c7ebf66647a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -52,7 +52,7 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
 
         let ca: CoherentAllocation<MyStruct> =
-            CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            CoherentAllocation::alloc_coherent(pdev, TEST_VALUES.len(), GFP_KERNEL)?;
 
         || -> Result {
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-- 
2.43.0

