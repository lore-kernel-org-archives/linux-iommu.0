Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784661E5B60
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237665; cv=none; b=R/SjXe3++Fb7W6W9dmkoY4DoyQ4IWwhGSxjhAap3O/dM8HTXi3ycdKcOpgwDS7IOqw5L6JsPOLemkY6i6DQLQ5ZBXd1Rho1fq6PoI5Kg51UpGxyvHHUwI0hlO5vhNv+Xk2GjBi91R0HCgXpH1Jm/pkOqZHsTILQB5jtpw5C86so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237665; c=relaxed/simple;
	bh=AFXc+JDAFlfaLW6k8nRKqG1H7IeQzzuskvkR8ls2d24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tllymchJfFQZh75pAO9QxRpUvRSuvpssnf4cG+O/hm3RNkTlcgW56e4KS0WG6Tt7ZJEm66R9Q/TULgAk58iFEVWNOn/hVpNLoMFhiEcNNLR+jagCOcot0UDXxB+QWHbzbMXV50npCWdbgPTJwHMYntubPJzkgpTwZYr/Sqi45i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsZOf1AB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsZOf1AB"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54963160818so5865896e87.2
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237661; x=1742842461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thgHd6wCi9ljuTgZv1q/rgFzzZU0rxSovW0BQEj3yDA=;
        b=FsZOf1ABOqoFbMa3dXFtddigPsPQgYgv9x5wORUvBoAGt7SpuMekBq2XSVXFdi6cOD
         Ojo6uPlGOpdx6hW0fDAAOlzsZTaP62lY6WMNlX5s4Hm/Q7UqhLBnBbIOr2S/uYGqbuZf
         FMvfUpdQpQN11xRSFcmR3T7SkUrOTsmzM74BNi0yWaECccD0P5cYkckhIrGTNAN2gtZR
         4tY4vY8DDtt0cwv0XnzCdq+6xjXcv4DummSi5jmF8pygmIVCKaGz49HpAXmJDszh/gcC
         QxmAPFjw9J9oh55l7jvHB8+B/1s2vrHmxSjrq0magydFVqDzwOESfk5zhCvnDg5QnmBr
         mWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237661; x=1742842461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thgHd6wCi9ljuTgZv1q/rgFzzZU0rxSovW0BQEj3yDA=;
        b=Se/aeRmtP2myOmoRzMzBh8RJy2PnRB5rXSKP+Wubu/77pC6V3eWn0WexEqkSmA0E5k
         rq4ijOI9DvqxWc/k4WzBv8/3UYVVlpEMffkXP1naiY554uP2K4bloz+IGFBNtN2vNWGU
         OsQ2iQwdhkUscrqW1399DlxOCydhuwaAqOmP+J0bsysRx0Ogyig9TsOVzq7h5OizzaEH
         IJV5+VMsda8+pODGco74EpCrKBe73Zjs8EeWxnzbUdL2TEwwzlIpBPoTqyRY+9aaFOwW
         y7yEYxuw8NIapfsve4wUeL7ca5y6eHBIsbGMrSu9pmMTkXbtUcf8sD2gOyZfyepUGMDe
         mJZg==
X-Forwarded-Encrypted: i=1; AJvYcCUBKg49+l0rJZZSeY63YxqMPbrl02u9L88RygjIqqqEJzYhf//7MMbb+529o8k2FGtko9YzkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkFHDWkAvmXmrahR7yJ5etX82URM8CRiQsgfrY7q/GTchIcPgn
	P2vJqArblu0ESgROHWkKRehJFstdqpGuE9Pjj7TZ+3Mta4lurrnS
X-Gm-Gg: ASbGncuXlFhzSDWvGZayn8WC6o2UmyTEucjmMzfCjli+u5En66XnKaxWJkLxHo7Bs1D
	NOm/u3pmWHoqDHXWND4pxEH6/rUtMEoJviLlAquw+YjW0EfujoKZ9dLX3RBPBOAsnXNMME6kIHo
	Vr8b7Pj/lX0gjr5UX+aJhP7uhFTGpitjsHa8xU/ytkx8sdxYK2AaA6TZv2qGxEyybmUbkxOGNYd
	rw3SeV6o9mSwcLrQg/Wx9VOYhQiPXqnbiBGMPDLec5ppZSW1otuak19G/hFnPd2lGy+EzkcCnRA
	863EBGlpJgCCh6Y8AYHFGhBuEcNaYv98DYnGJnzOTACuT2T6cnFZ5MKT+aNraT/62VBkW7cDIEn
	qJEheozi5u2g/HYT7Ac6p8A==
X-Google-Smtp-Source: AGHT+IEzcHIx5VvRKJa7vTMmQW77VymKl7dWS5EAvgPjCayjuDwj//mTZSHgbw6h1YANjwJF/oLHJQ==
X-Received: by 2002:a05:6512:3ba4:b0:549:b13a:5d7f with SMTP id 2adb3069b0e04-549c39905d3mr7606610e87.41.1742237661377;
        Mon, 17 Mar 2025 11:54:21 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:20 -0700 (PDT)
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
Subject: [PATCH v15 09/11] rust: dma: use `dma::Device` in `CoherentAllocation`
Date: Mon, 17 Mar 2025 20:52:16 +0200
Message-ID: <20250317185345.2608976-10-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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
index fc66f1764c31..6d7aff6b360a 100644
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

