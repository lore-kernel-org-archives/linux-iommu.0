Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7822F147
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566665; cv=none; b=meARdOFo560L3ciP/wuxn9xfEzvXJ3z3KBPdQz4jpiXwznuxUi3KvcIeToNfSPwewV7eZeZLu/SCXhUyy/qNZh4yfsoyL+b7aMKGRGhVjF3k+CnBB4yigj9sYCgZ/Fi6XW75t3Ljyje0EQ82K+BYPdCyOxm5qNZzkJOS+EEoXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566665; c=relaxed/simple;
	bh=p9KuyczkRk04gYMkFGGJnxWv0QoLL1+yqvWdiiBeT3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htrBeVrsJu63qjoXB+rWUfzUHbW50LTPjmi/rxAvGYLPk+9dPmIENv/YOHumt+pfjBNPfdo4tJhB7utHphadCrCDa/ssoK41FKcL1Fuq23ySPCO+sbSrreSN08b5hpYxdru3yYY3n8aE2qBAS31xKuq3R2sk2Gl3FRj5oEFzcHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWQSecAX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWQSecAX"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549967c72bcso2139616e87.3
        for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566662; x=1746171462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1kYjA5v2ZxXF+57lF/W+Zxp4CYc0PDu1KuPLGZgYLw=;
        b=AWQSecAX5HfBnzBTsij4yxBEcDQ2t/y2/BPu4ly4vAGYLvjaFihMi9Ipre1kb1LrWB
         SGIqr10g9EDn8ySXsCJSltmhNwUfHb7taCNQnKbDPCQCfnvyogkxrT8UqGhtF0wD4YHW
         hP5Ba7ZAfHdaDQ/IjuWbdpOOuQqHg83GReDj+ailcHHga2H/J61GqLuY+4GmQptobg51
         j65TOPYtwapHuUVjnC93PgHn/BVTPFTDdbs5moxnfRhXk44D1p3FXw1cyM/9IYy30Vkr
         bRbIAxjujDle562tN2K3KGa1Sp7+vgMO2HYXtsN/mBjVYy8WoFDyy9LbAqUoQocA7veP
         pU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566662; x=1746171462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1kYjA5v2ZxXF+57lF/W+Zxp4CYc0PDu1KuPLGZgYLw=;
        b=woju+OviKAdzcqcP+OrWoD2qQxzty+h9NArV+j/WqVmvbEunV7bLEok7z/sesI9dG5
         1w+3o6Uq3LrBnC6EriV8UBdVgoyWgEvMwh35Q+0DcjN9iIteHatp6QvHPnxF3rqZ/k8j
         bc/Fje8ULZrXAwkvk7mbuClPtuNtj/gS/uJBHUSRpHCRshrlyJik/5VZKdz2gdd0vBl9
         j1nLGOoNurJxrHiRjzPg42YT5iQfvXNmSVIHL5Cr9AkEz8/h7XIJKXLwlVF1dA8Wi5b0
         b9uhkLWrfAZLTe0POt3G5GGJ8OWAShAR6opNXV38FROOM8BiXPt+ErSyUzDSkyOijXYu
         LlMw==
X-Forwarded-Encrypted: i=1; AJvYcCUflVLsTRuNU5ztxUiVInDWJlVRDr25hfG6oGzBvc8m4eVV4NZ3yusHfHCYrfn2vCVx1uf0Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPdNvOqxBzA1igkhmFmhdFUP0DfoqnVhI6HsSVcrKzz0guPh30
	JutiWrMv8uevMlBhbJMZk+2Kfa4usJgKh6iCKrXPNdowHWqqXmWT
X-Gm-Gg: ASbGncur0ZAcVONELm4stIffrCoaoyrBK1uVhmqxol+nsPOeYZtezLTD9yPnVncHchC
	el69kfHCEri2TqoykOSxBGV04jBHzQ6cdM+i9eUmNaQEKScIDJOqIYdpf6gfo+BDI0Ubb4GGHWH
	ryLSL36Qe3pAu2+aAOZcPIlB6AO/qZcku1l28ixTXyDzUxKfm/MtnlY4a7mwqFJxM7k/+wT1hXw
	zel9Il1gmhEBfu6nIj3H7ibN8i7T/ZKDX2NkyZXHUk/ojutbENOexECYTjaXIZvCnBp45teP5ca
	YICBRPIN1D8l+WO7knlT3Q4ec0z3/OVkpJ6v2idwUD82Zi+FS1OVUMSMVheGODZdrj7/bxXvmtE
	fsd3z+CkyDoyxBDRpiP+WC86o65hy
X-Google-Smtp-Source: AGHT+IG0vJEK9kerNJ+x87uQuMGI3i+Ng+kKkkJ+CqAjbAHJkHQPScomcHYgoQzdCHw9f91km5IT7Q==
X-Received: by 2002:a05:6512:2399:b0:549:2ae5:99db with SMTP id 2adb3069b0e04-54e8cc0e6bcmr383224e87.45.1745566661791;
        Fri, 25 Apr 2025 00:37:41 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cc9e9a5sm504391e87.132.2025.04.25.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:37:41 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: dakr@kernel.org,
	rust-for-linux@vger.kernel.org
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
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 2/3] rust: dma: convert the read/write macros to return Result
Date: Fri, 25 Apr 2025 10:35:41 +0300
Message-ID: <20250425073726.1027068-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425073726.1027068-1-abdiel.janulgue@gmail.com>
References: <20250425073726.1027068-1-abdiel.janulgue@gmail.com>
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
index d3f448868457..a61da5eeb017 100644
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

