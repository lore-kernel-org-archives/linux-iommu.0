Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075D20CCEB
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275568; cv=none; b=gboG6RSp6bLowv54WRwTmXwGQ3BozQ0fTI9Rvr4EVWmhbLBl9i8nUGhsFFHAq5QZx20OpQ21T6b38MVn/Gcz8TChIp4HT318l/5Wuz6pacyPHTsrfwtV3pHMQ5m13kASB9TSVpQZ7x/W1/8cf4qgjQq7cmi9oWwMYA0akSGkiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275568; c=relaxed/simple;
	bh=ym65ZHl+x7j2UBFJ7WrJbNmKqz9rKOx7DPKi9PWmqfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkCmGdCuMK229CJkj2Qcuo06q1g3OjaxpsDDG6BtAQVcPJwgbZiGz9tnbn8om/2yPBaUJW7OtMTYrZE9WCqMoJtLbqVnicnFpFrKt+bORBd6oyZpxt2qUMXNplf1R46ReK1+VfosSaldQRNM5LDmBaputnlE+jwiRjDi7SwZXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAcEK4wy; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAcEK4wy"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549b116321aso650047e87.3
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 01:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744275565; x=1744880365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quYlemSJI/IPbTuyW/ur+mjtFnxkDwGn/F831OhHW4A=;
        b=PAcEK4wyOfT8WOUs8zP+0CWyy/HM3436rOm9n5Og/JOjLknMK6bmLRyGhlKHcBEAo9
         ytyv4rqtCTJ3Ro5kXQkKJXL8bCN/fnErD0TItYFR8dVd/rAUy88NzPGxtcDWl+yyhHrh
         xYCFMFqvbCRtQE51ZqCbQrnHn9q1731WgERvn9z/zI1Qpouxie45upbcFsea91P0wALp
         zjGpbL6Mnn+t8crODRsiYi/Kn4ZeMaUnZVe50vdTcNB99wb+MINDhF+O7yPxePLtJbXu
         vk22YfRDirK7Rgoe8OWRIwOHHg5xCQ2riMGng+Gwex4zh3/HZlcjtAXAJtyOSYdQIR++
         hoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275565; x=1744880365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quYlemSJI/IPbTuyW/ur+mjtFnxkDwGn/F831OhHW4A=;
        b=F0kJ4HtqhgqFxLOTVk5mLm3RD+D3gZPTsETSDjtryCMiGX6/fVDCDQOJJt6vGdyqpO
         LzFJk/0xh7WL0emh5kMDnNN3JzJ5gsfevTxMl2CmAXBC+IYPgGu0MjXvi5ZnDMYgFazQ
         7s8FxOo5tt772+3TQgzdQw6IXrHAy6XED/y4V17PglxJLkuCu3RmEbcuf5+LdZlbobIZ
         21QBmVMwmxxswdytzWAdMDtegE3v1pqvoQ3UkCV8uSwIYDtumTRiMbOZGOgGO4ro7fbQ
         uDzizrsmhdjhiw2rSqaXzeyfhWIoID/CzPnQqcox718YRlZd6sX08GEZfGlPozxEnUdx
         NRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkQtqlhXqUXlmCcOzBVktilggnpt5W9dg3HWHajGv0DjJIB0vHB5c4x4be0l2TUhetL8WPcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfC38xFM/WAILPj8weNTIxjiDkykW0zPs0Kt6FIwDusYhMRWpZ
	gmS9/27i83/a4cnzAPHma7ww51yjXu9fVHakoeqRVI7pV49ZrPgI
X-Gm-Gg: ASbGncvhSjkpoEuIqkODxarcO1kV+9UdUOofdLaU9qRzNotIIxLBmolBdSan/BGd8bA
	rI0BvEz1O7xlNeylF2gNKS/G4RMGrolW4MLnVoKVXwXMHK9Idxks3/fImU/OKO3b3YfyLF5u+s5
	Fvc7yEZYfpFqpqHMlidUwpSNtIIYcVpDxC95J5XmB8VeR1pBjbKLVwB7MS8rsfb8Le6FBgikX+k
	O8k8eUSMujI14Vkoxj+iYfws1SognEWM48dXoSde4tRkzzP8smIfFuJwjygAreUc7MLeaYXxCGv
	plMXpS8RZFroSsc+uYhzBNpBvmk0U8MP0ZXujd254uUfxoofki7OMXfvXrweKbEwpoOPQAnBm5r
	PBumZ/g8/V/H+mvwUhA==
X-Google-Smtp-Source: AGHT+IH3LEFp5SZfJTn9mBfnEMdw55TG3aOnTZaiquCIur+BQEvlh3TkT50lZo8liyX9R/vIcNMUdg==
X-Received: by 2002:a05:6512:4010:b0:549:4ab7:7221 with SMTP id 2adb3069b0e04-54cb688ae13mr591027e87.50.1744275564501;
        Thu, 10 Apr 2025 01:59:24 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50285csm80875e87.110.2025.04.10.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:59:24 -0700 (PDT)
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
Subject: [PATCH v2 2/3] rust: dma: convert the read/write macros to return Result
Date: Thu, 10 Apr 2025 11:58:17 +0300
Message-ID: <20250410085916.546511-3-abdiel.janulgue@gmail.com>
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

We could do better here by having the macros return `Result`,
so that we don't have to wrap these calls in a closure for
validation which is confusing.

Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/87h63qhz4q.fsf@kernel.org/
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs       | 54 +++++++++++++++++++++++-----------------
 samples/rust/rust_dma.rs | 25 ++++++++-----------
 2 files changed, 42 insertions(+), 37 deletions(-)

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
index 874c2c964afa..1e610545e100 100644
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
@@ -78,13 +74,14 @@ impl Drop for DmaSampleDriver {
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
+            let val0 = kernel::dma_read!(self.ca[i].h);
+            let val1 = kernel::dma_read!(self.ca[i].b);
+            assert!(val0.is_ok());
+            assert!(val1.is_ok());
+            assert_eq!(val0.unwrap(), value.0);
+            assert_eq!(val1.unwrap(), value.1);
+        }
     }
 }
 
-- 
2.43.0

