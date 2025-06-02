Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72B1DE4CD
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854496; cv=none; b=tV6poYovWfQHd0bYPK/gfE4vx2O+EqebR62rY6eJzcaREzxUECK7qnnFL9My8jUYwua3Z3ApxQm0icN4Wsik5e7kSuz4vl2ppjJm0B8s7LV3dJb9/VzhUfWhcccBpGFKrecWN2QAFjtClEM/jbtkEGRgXODYQFzfcO7PtBtcz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854496; c=relaxed/simple;
	bh=aVxlq706IujBRj+HiQ3ah/IIAv77R+CvWdXj/E/ybvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaGNWmzmHTgwicPQZu4sZO6qER71jZ+9MHc5KCgc+vfCQRCnt3AmdY5ZqTjxLfroQgNtvs5F9FZlSxiGRWEdIfYeoaFW5vznA4P3AAQO5SMo4yVw0h8UF1vpyP2d2eA0Ur1E1iPm6GN8UNl4AI4q1QQCvFKIL1Wh/KIZx+WDo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktn09mwM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktn09mwM"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5532f6d184eso5252383e87.0
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 01:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748854493; x=1749459293; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRX6ycinlDpWw2cKVx7yjaGxT6xMop9u+LnJF5PNiJQ=;
        b=Ktn09mwMxT8SXOd/GRA+LB0pSOtYI0S9ibPQtlIcumltD6EcQTTh/cr5qQtdLNycgl
         eBKb2z1O7eEpjevYyTNYzypALAiDPQYKw7XtN9SBsE2O/z73s+rnA2wiZ2rIHX4bzBpr
         Xq5fUWMIvt1AHEDi+eloPwQW3889zYhBVCvx82G09oHpcEoRvWXHWJR9RFUKVMsCLXT0
         20tdlDKVdl90BqXs17yhwxaSsa5tTy5b2nxqrmGQ5OEXXgUyfJFcmgFJaegwJSS/dD4I
         dFRdl7Kpmx5+kpl7cwtwZh3siYxTW7ec92mEluGrT0IJJsFRBaywGmts+TgrESAi5Qqh
         AeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748854493; x=1749459293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRX6ycinlDpWw2cKVx7yjaGxT6xMop9u+LnJF5PNiJQ=;
        b=vra/RBG2MyDmkCJ1iPrBHiOLAKIYR0GsrprBHOBAFgvQB0mL90GOp4yMHltdMhfcQ9
         SA5Ss1OkxEfgpixbm2OCKO2886pXri8qUS75g74/dWNIAUrTVkvP53/qXRKV/Fl+c3Iy
         Zm9dwrkhKjpZMwSri+TSYPhahEU/WtfUUUGavTHlsLPEtfW+eMJT2f3qoSOmJID7z0uX
         uaZGRiEuQ6ZrV/NZ9l7f4xTZoVikcAsDinBtzahWsABT9mBEvfJ2gi7f+ysAdzRqifw0
         hMxuGvwnDYzifjtIKdaasVuWNyy8t0XeWOhuJNKP/q7d+zq1M9QLLgu6tTvZ6SFNMacR
         2tZw==
X-Forwarded-Encrypted: i=1; AJvYcCVmUwi4/1PgrNcPI2EBkfVCr8FG1Wvoadb8fXWGClk1KVe5I51pMX98CBdrSyzy6Wq8Q5F2aA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3b/E/fap9Ox3KEhfZJRoxIWbej4tMK4MFAlEoR+F4yjooN7JY
	QWONcpiQPI/EKFxPFB/wlCmuibF+kTrIQFGAIihLdz6Ocq6rId0vNTvd
X-Gm-Gg: ASbGncsxCSzawDxfba2/yuH1VmQwTTtdqeXIaerqgtYLjVGV9BrZ3i8jm4US8tlFrsj
	jNrOvxumRcnOXHfjjSsHv1aFPZwbaY7SuYnB+4Xoc5G+ip5ygY44U37AMCIwQyTbJZnEqM7fK24
	bK2jRPhhq4Rr0w81NFzBUZT7PjYCUih+ASxicQEjgeiJ5rj19/ReTQoa1m0wyij1F1PsTTn+g+i
	6Inl1V1FwhtTGsehV8cAAL8oFWUYFENGOpZWdjQYmMjKUGbTg6HqIAQZ9evWBSOc1YIIE1u10Pa
	t+uHjgSC9UB6YhfSVLjlJQS+YG07KBCmsGMBxSQF+PGlFqs+7fRILdy1PN7/jM0JwtelJRW0hN3
	a3RgozSveCywugClQvBRIDrorOORM
X-Google-Smtp-Source: AGHT+IG2LmHus1rr8ydQkHeOUpuq/nYTVQnVNjpmNMi+kbH3v2KVxyMZpriwJL9CZN4aoHvOpzgf9A==
X-Received: by 2002:a05:6512:1328:b0:54e:81ec:2c83 with SMTP id 2adb3069b0e04-5533b8f412cmr3757007e87.18.1748854492276;
        Mon, 02 Jun 2025 01:54:52 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a13basm1524325e87.81.2025.06.02.01.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 01:54:51 -0700 (PDT)
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
Subject: [PATCH v4 2/3] rust: dma: convert the read/write macros to return Result
Date: Mon,  2 Jun 2025 11:53:12 +0300
Message-ID: <20250602085444.1925053-3-abdiel.janulgue@gmail.com>
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

We could do better here by having the macros return `Result`,
so that we don't have to wrap these calls in a closure for
validation which is confusing.

Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
 samples/rust/rust_dma.rs | 28 +++++++++++----------
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index c3fe39e7eb0b..5a690e5f1e66 100644
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
+        (|| -> ::core::result::Result<_, $crate::error::Error> {
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
+        (|| -> ::core::result::Result<_, $crate::error::Error> {
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
+        (|| -> ::core::result::Result<_, $crate::error::Error> {
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
index 874c2c964afa..9e05d5c0cdae 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -54,13 +54,9 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
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
@@ -78,13 +74,19 @@ impl Drop for DmaSampleDriver {
     fn drop(&mut self) {
         dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
 
-        let _ = || -> Result {
-            for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                assert_eq!(kernel::dma_read!(self.ca[i].h), value.0);
-                assert_eq!(kernel::dma_read!(self.ca[i].b), value.1);
+        for (i, value) in TEST_VALUES.into_iter().enumerate() {
+            let val0 = kernel::dma_read!(self.ca[i].h);
+            let val1 = kernel::dma_read!(self.ca[i].b);
+            assert!(val0.is_ok());
+            assert!(val1.is_ok());
+
+            if let Ok(val0) = val0 {
+                assert_eq!(val0, value.0);
+            }
+            if let Ok(val1) = val1 {
+                assert_eq!(val1, value.1);
             }
-            Ok(())
-        }();
+        }
     }
 }
 
-- 
2.43.0

