Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D972571D8
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019989; cv=none; b=FXR5RwPsFlP2xv/x50w39dEzePN78TI30/SP3nHAD29cZAl8uI9Wl1f/N+9ZUQk0OyvM0xWiONL24TBbqvoJuXJxvjJHyFU3xftHgcPCpFMjp8MjZAPnZWb6dYWYgZN80M9onMQ64x9ZBjf4/Peoutg8i1PxOdi/cd3Se7WCz9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019989; c=relaxed/simple;
	bh=KUEjh4hK5AwiNirfSdvvzr04GjjI9soaojGNwlt+gYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHHlttO775crTWj1eqj40CJAOZsImGRSaf5WL+RNWFbtyRcMzKVREZrRI4TN7rT/MDYp3DRA/BRun0BqiNwwYjUlnj9o0S8ToW0dwvD6FoA3CvABfbRKYd3dm7idGDOFk9CxUsC3pn3HZie2m/HdkCbYlHkG+RbBN6gfANHuQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II+F3UiC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II+F3UiC"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5497590ffbbso270180e87.1
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019985; x=1743624785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqPyNQzlsZ2VM/tXZ2FXS0OL5lARsE8hyIi3dCnvYUw=;
        b=II+F3UiC7pG/w4JDDAFYYAJ0VxBP+RiihPXxP0rkMoIVHEsPMjlaIv9qP7JbaSE9tT
         3plNvIppPQWRTcP7ShcXlWjPZd1/MOT7s40Xb2SFoiv9P9G50N7/um3jxOVq+T7oTiKH
         zvt8sOPi9OehxBM3kI/7WCM3CA83NXVi63xFU11nL5t3XDTK1Fd2h4pZA48XVTbDtk1B
         kcis5gvHoRIUwxPj7JoNFRYMhFKnp9oSy1HRYMVn/GmyDuMsoux7mVaAv2fb8iZpo91v
         NzJV5U9doBjtv70F0/kGkqw7Jo+rxwT2qRgNYJ4xUXdrIJG2zHRYc020ygs/ofXFCvAo
         I3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019985; x=1743624785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqPyNQzlsZ2VM/tXZ2FXS0OL5lARsE8hyIi3dCnvYUw=;
        b=wQYs97JZ0X2iJVY5aaANpvSpcLRhJ8Pq5hXOQAhyk6bJegaQrSNqLn/6lrxe1vzpHY
         m0/TsRBc08jnP2IV8RVDnfU7R7Qm9H3f/Gh4llLA/dNL1PQp4qj6rRhEMmXaYN7ajvRI
         oY+vFJbB3vL3/D9NA4zDw1rMnVzWKj9YGj2jLBfArg/qibx3VzUEoDne5u3il8fn+Ha8
         /ZTBO8NS2E1//5sW+Isau5ySiyOQ7IiEmgb2SSzWDo/T3rQG1xHXDmzn31dfsRPX802d
         2IRv06aR+oFc9d5HfLilvzej6D7pH1Au9/77kwDEDGl6d189FvvHlp4eDtoWbjKlFKma
         ZHGA==
X-Forwarded-Encrypted: i=1; AJvYcCWNvB03r1B7nSCQyHDcqE1+diTvJBQDhEBPpLP8m3GS3BtJrlkvaGuqhzfKmR9Nz8LzabIFYw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7BIr/nBcm5APKxC1LY6CcjrKILWAoA2J0EqcXNar6gxjx+o7x
	+MDVw1yzWapPjD3rmBRCC8mSib5JSr5DzbLEJFW6WlIw9w+xovjy
X-Gm-Gg: ASbGncsHOVqFW8y+bG8/SV/yLSIA/IO3kuapqsZNKzFesFa21jRftcN1SpdRk6E0/BD
	yz5CueacBEaho0ue4pEBfeP3mUxo20UpLHD99Uu3LFmHLXtAunm6VPILwyoXDMe6JvH8j1KNi3V
	w1LItBbxy04C0vfeqE2nVG7HWC5s5Q6PgXGMSnlxISN3C9OJbstVXS7XJ33ix2GYSdwJNUn9ctK
	i9T7rhbEC1Q/byW+4hZ9koIAy9r9kgSOL2Dnu1dtBx0VeyovbUvIy4zyQTXTbkrCCeHvoXR567K
	bAmAWV8nvbS/smhKKg/l6snRq8OdDR+irmtx6fmbVGcPjPIETqHw++z7yNG5W/4k10AGtvFftim
	p9sSuhtPYuXhyi/rUHINfjA==
X-Google-Smtp-Source: AGHT+IG5DWfivJ6phDkqR8mJ7+AXG7ZqtqivCgyez055JfZ+pxmclpEKwBt74y4guotavXKViI0gpQ==
X-Received: by 2002:a05:6512:3d11:b0:545:652:109 with SMTP id 2adb3069b0e04-54b01264efemr392524e87.51.1743019985037;
        Wed, 26 Mar 2025 13:13:05 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:13:04 -0700 (PDT)
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
Subject: [PATCH 2/3] rust: dma: convert the read/write macros to return Result
Date: Wed, 26 Mar 2025 22:11:43 +0200
Message-ID: <20250326201230.3193329-3-abdiel.janulgue@gmail.com>
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

As suggested by Andreas Hindborg, we could do better here by
having the macros return `Result`, so that we don't have to wrap
these calls in a closure for validation which is confusing.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
 samples/rust/rust_dma.rs | 21 ++++++----------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index d3f448868457..24a6f10370c4 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -328,20 +328,22 @@ unsafe impl<T: AsBytes + FromBytes + Send> Send for CoherentAllocation<T> {}
 #[macro_export]
 macro_rules! dma_read {
     ($dma:expr, $idx: expr, $($field:tt)*) => {{
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
-            $crate::dma::CoherentAllocation::field_read(&$dma, ptr_field)
-        }
+        (|| -> Result<_> {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of!((*item) $($field)*);
+                ::core::result::Result::Ok($crate::dma::CoherentAllocation::field_read(&$dma, ptr_field))
+            }
+        })()
     }};
     ($dma:ident [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($dma, $idx, $($field)*);
+        $crate::dma_read!($dma, $idx, $($field)*)
     };
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {
-        $crate::dma_read!($($dma).*, $idx, $($field)*);
+        $crate::dma_read!($($dma).*, $idx, $($field)*)
     };
 }
 
@@ -368,24 +370,30 @@ macro_rules! dma_read {
 #[macro_export]
 macro_rules! dma_write {
     ($dma:ident [ $idx:expr ] $($field:tt)*) => {{
-        $crate::dma_write!($dma, $idx, $($field)*);
+        $crate::dma_write!($dma, $idx, $($field)*)
     }};
     ($($dma:ident).* [ $idx:expr ] $($field:tt)* ) => {{
-        $crate::dma_write!($($dma).*, $idx, $($field)*);
+        $crate::dma_write!($($dma).*, $idx, $($field)*)
     }};
     ($dma:expr, $idx: expr, = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid item.
-        unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+        (|| -> Result {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid item.
+            unsafe { $crate::dma::CoherentAllocation::field_write(&$dma, item, $val) }
+            ::core::result::Result::Ok(())
+        })()
     };
     ($dma:expr, $idx: expr, $(.$field:ident)* = $val:expr) => {
-        let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
-        // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
-        // dereferenced. The compiler also further validates the expression on whether `field`
-        // is a member of `item` when expanded by the macro.
-        unsafe {
-            let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
-            $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
-        }
+        (|| -> Result {
+            let item = $crate::dma::CoherentAllocation::item_from_index(&$dma, $idx)?;
+            // SAFETY: `item_from_index` ensures that `item` is always a valid pointer and can be
+            // dereferenced. The compiler also further validates the expression on whether `field`
+            // is a member of `item` when expanded by the macro.
+            unsafe {
+                let ptr_field = ::core::ptr::addr_of_mut!((*item) $(.$field)*);
+                $crate::dma::CoherentAllocation::field_write(&$dma, ptr_field, $val)
+            }
+            ::core::result::Result::Ok(())
+        })()
     };
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 908acd34b8db..cc09d49f2056 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -54,13 +54,9 @@ fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
-        || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1));
-            }
-
-            Ok(())
-        }()?;
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            kernel::dma_write!(ca[i] = MyStruct::new(value.0, value.1))?;
+        }
 
         let drvdata = KBox::new(
             Self {
@@ -78,13 +74,10 @@ impl Drop for DmaSampleDriver {
     fn drop(&mut self) {
         dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
 
-        let _ = || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
-                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
-            }
-            Ok(())
-        }();
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            assert_eq!(kernel::dma_read!(self.ca[i].h).unwrap(), value.0);
+            assert_eq!(kernel::dma_read!(self.ca[i].b).unwrap(), value.1);
+        }
     }
 }
 
-- 
2.43.0

