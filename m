Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1B1F5832
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237660; cv=none; b=LYGoqLFhEdDcSGgGsWUBu76h8Ro/EoBGJLvecFMKu5M8OX2nC3a54EcU4SgWtGOrTTAPPqQ2H92fltDHhEEqdH+d3wGBRTEsP+HlnXe2nbhS89qs/QeqMk43QqGHe9q6qGCd9bdGNdnvBZm89fMXBzukNdoTAEHSWSQ8hlDri9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237660; c=relaxed/simple;
	bh=vxvrgclxSGXK143+YdwqKleBIqHOGE8LJjEKOsHLBgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUC105zH2balJsKfhnHtNQrgR+7Q0xaUW9jmVXKHTZNZalfp1B8gpRWbETr0nHt5RfN8wdSIRyh+zm8yaFjQ43EMngQXNP8+fqQ6OOVlZfgc6GUsWpBDVFKNd2D5Lcv2ja4+aHBP3QqsakORrDKurrvDHTCNoJIzfV/Eoxukg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ4kKT8L; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ4kKT8L"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54991d85f99so6003605e87.1
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237656; x=1742842456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBxT3MGZ+hhcADBfYF1XCdcnBcE8PDalZquxlBy/B68=;
        b=IJ4kKT8LgiRBFeku54K+rUV8Fn/MxSEbXy9kdTOTYLObgmXOy/qyAqg16+Jks2orml
         VT7AEECcKBWQcPa2EKK/DTndefULCii3//pvPLoX1RM1LV1V4Ep7wPbv89DC23E0uTFj
         xAMwTG9ZqpbCWL3BDN4ZpAA5CfjVBPVyGM63ns9hlbqHXm4OqToHotjBhkbYk5APwQTH
         KAicPmGAnocprREq1kMCsXMN0Q5MnU4wpZtoQud0Wp7tSbWtUUSUGCmF2YU21ahMbSyt
         70f8swXHiAtfmIqA4bh2ir+X6F/EgKP+yfkhtM6vqJNuBfWlpjyeKfJda6tKOYC2kdov
         F18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237656; x=1742842456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBxT3MGZ+hhcADBfYF1XCdcnBcE8PDalZquxlBy/B68=;
        b=dJWeBpp7VEXza8WjLypB9Atb9V4optupouC1Wl5evLti2WteU0IVDsIt6Pn61/22OF
         0kMWEUc4NrmNAMfQ2BEJmKoZmOTUOAq+RZ8WUl4xTLA0psrY2FWQxrvCzhDUXXhswDbb
         K9JR07OO08rCJ5xd9HPbN8lylR1emNt6QExNmzSwnn2Ee7Drnt3wTtOP1YpHogA/+M2R
         gQl3Lf/0lbHzaDAEVYtXfMU7fSBmZ0ERWfAMaTNBZC7G7+ozkdJ/r7JK1RjmwkV3Ejsl
         PUIOvvY4d3FoZpbGtyWVSdtBsJgbgsoYl/CygqSv9JLqdlhX+QVPg8J6i/K3qmDdfn9R
         DHQg==
X-Forwarded-Encrypted: i=1; AJvYcCUU6mCHzE+juow6zNuxzRcX9JcPc9lIEzIQ/hJofHK6bRvUr2wsjwOsYx/GDdAOTmN8mJdhSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3z5tsI7w8Z0kuZ5Vu0kMgVXE8tf8z2pNIeO8xRdUdyunB1KQn
	RONh9zl0OI9CT8hNxWQFbIY9hmIeAWsVG/ywWJvT4gtNbyeY+tmK
X-Gm-Gg: ASbGncuZEty/HKHWiuZRdokE6kjO6MYU6xgCTFPN3c+qk9Wax6msTPflcvQibmltTLe
	Be1z+hp6QaiGQdn986XWf61EzlFuAcIA3EMIV3XZBRRk6irm+1p66qT5H7tmKs21uYD2LBKuMbR
	snlFQRlMbB3j1ovOCThhWaZ9onDed83x2RdeGy9LANo2UASykNeq5+3yxqalO3QWAVb5YOruOCJ
	ZnLx+H2moUYl+1oLEDLzeTLdGtf+rEnPKM0FGls/g4jC7Xdw2fvdOOoRfT10K6J5f2I+r32XNul
	0UCDDlub1ApZIzdes3uFuQldpCrHFp+dSS5IdF4eXDzh25i3j94ukvWxFkAOHzTkAA9iWuNhWzD
	lRrcGgwyvIjeU6nyZUnY7hg==
X-Google-Smtp-Source: AGHT+IHHzE9MNcmcY799X/6TWw5sD7xGCyUwgJreKaa5Da/XvTSJswDdspqnvoKKyJWsthpl00i5dQ==
X-Received: by 2002:a05:6512:2c99:b0:545:81b:1516 with SMTP id 2adb3069b0e04-54a30582e58mr571697e87.15.1742237656042;
        Mon, 17 Mar 2025 11:54:16 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:14 -0700 (PDT)
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
Subject: [PATCH v15 06/11] rust: dma: add dma addressing capabilities
Date: Mon, 17 Mar 2025 20:52:13 +0200
Message-ID: <20250317185345.2608976-7-abdiel.janulgue@gmail.com>
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

Implement `dma_set_mask()` and `dma_set_mask_and_coherent()` in the
`dma::Device` trait.

Those methods are used to inform the kernel about the device's DMA
addressing capabilities.

Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers/dma.c     |  8 ++++++++
 rust/helpers/helpers.c |  1 +
 rust/kernel/dma.rs     | 46 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)
 create mode 100644 rust/helpers/dma.c

diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
new file mode 100644
index 000000000000..8eb482386f93
--- /dev/null
+++ b/rust/helpers/dma.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-mapping.h>
+
+int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
+{
+	return dma_set_mask_and_coherent(dev, mask);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..8f3808c8b7fe 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,6 +13,7 @@
 #include "build_bug.c"
 #include "cred.c"
 #include "device.c"
+#include "dma.c"
 #include "err.c"
 #include "fs.c"
 #include "io.c"
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 834d00c1347e..fc66f1764c31 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -5,10 +5,10 @@
 //! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
 
 use crate::{
-    bindings, build_assert,
-    device,
+    bindings, build_assert, device,
     error::code::*,
     error::Result,
+    prelude::*,
     transmute::{AsBytes, FromBytes},
     types::ARef,
 };
@@ -18,7 +18,35 @@
 /// The [`Device`] trait should be implemented by bus specific device representations, where the
 /// underlying bus has potential support for DMA, such as [`crate::pci::Device`] or
 /// [crate::platform::Device].
-pub trait Device: AsRef<device::Device> {}
+pub trait Device: AsRef<device::Device> {
+    /// Inform the kernel about the device's DMA addressing capabilities.
+    ///
+    /// Set both the DMA mask and the coherent DMA mask to the same value.
+    ///
+    /// Note that we don't check the return value from the C `dma_set_coherent_mask` as the DMA API
+    /// guarantees that the coherent DMA mask can be set to the same or smaller than the streaming
+    /// DMA mask.
+    fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
+        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Same as [`Self::dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
+    fn dma_set_mask(&mut self, mask: u64) -> Result {
+        // SAFETY: By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
+        let ret = unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+}
 
 /// Possible attributes associated with a DMA mapping.
 ///
@@ -392,3 +420,15 @@ macro_rules! dma_write {
         }
     };
 }
+
+/// Helper function to set the bit mask for DMA addressing.
+pub const fn dma_bit_mask(n: usize) -> u64 {
+    if n > 64 {
+        return 0;
+    }
+    if n == 64 {
+        !0
+    } else {
+        (1 << (n)) - 1
+    }
+}
-- 
2.43.0

