Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD75C2163A6
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345727; cv=none; b=oqz4yRsPVk4fvYZlbyq1LdIFuqWWXd5kqgpr/lO3pmdN4ulihhX634plxFvctkt7s+kcG/O9IoEJvFW0L4Kgax/2q6JoJtwg2ST7U1XnWauW9jQ8IzUhySikdJ8/AusQgK1QXWmtVuLOHeXtuf+m5RBjElxTGl3l0au0jshqHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345727; c=relaxed/simple;
	bh=NFKIAidxnRMlrYELYDQT43QLdnHioABterAjD1+vLGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWESDsQPQtcSw6J06Si2ZewvuyCg5FxqZVBhhml2p5IoFpWcjPw1ismCZXUBto6vsnvxBv2GWnNyd374jPBKWkhOyQ9bRkSyaVCGq23eWqzrzNrFYK7/4ONL96ba4AhHUBynWUW/w60kIqGnyS2dSfKc8ErOGvt/ci8xGmFCNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR4BY/oi; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR4BY/oi"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a6bso17723161fa.1
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345724; x=1741950524; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bna1rbJPQWibEFwv4J1kDTSY5U7INmYTRZbd16nD/nc=;
        b=LR4BY/oiw16nmaSvNYi2OkPrCcrPBxYgnGf7Fn7izFb8tkMZEF2Xe+ucw4lTl3jSn5
         drKH7fNNZg8GPWzMSLhDaUm9s3vlBhN+aqWF3UROO8lSGwg8l0LFhtx98tuAfK5Vv0yL
         8bVPqzs5vkgtDjDeWFlmbtdajPVCj64AJeJZgfWnLgQF5vRZczMH5EWNs7nfFx6+HybI
         IhuMGgrgYOttAhkH2zkQRMUaJRo0AzTZxARXzYuW8l8X0L1wprsahRyGYUCAhOGSNlRP
         axaegqjQBe9HFNO9/HQi3S8vwMgvFZdHb+x7cdxPP2mUjeJM/yD+77p28H9f7xtb6bQH
         ftfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345724; x=1741950524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bna1rbJPQWibEFwv4J1kDTSY5U7INmYTRZbd16nD/nc=;
        b=O4twwhY+vKMPhKCtO5nyIDjNvs3rPh1KZf5myUw090M70ivHe9c5mylwjrk5ISGfAQ
         rFLOKKcTuSq0nX43Ji+hkc845OVyZ3fVXerOCqOJGdjcNzBvNurrvzFtLxsqy8Xh8VQr
         v5Zzw/0gKQDnMPtorSJIHZ8sZ5pUv5zTzdVhRRcr9qo5bjR7ckpP9IBVhtr1YS0O/+Cg
         NiJX0u5FsopQ/1Ml1aF/JwcwydXo+enbAcJy8T0+GKvYgBQ3r1z64R+ob1iPQXvifiOy
         bs6+T8VQJlMV0VIGSTUQdiYBgwEODDaqszlDqU+R4L8Ks9eeRuneVGkfWPjTdSsrEhRX
         CxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD89Gwnxab+nKcmrrHpIfD4koDmkAOJcB8amEC1h2R2p3fwnZE/9VYGISiw/l6FHQABgZFbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbe7qmyCuf53tQOiixe8k9Sg6DUDTFltePeNgodBjfE/Mk0Pqd
	WB99eLaolxxKtO0kChNH6YKPvih778WahCtNZnMIILwVV0reVLeO
X-Gm-Gg: ASbGncsFUhqBG1UO/VNcMD4vaSl70vhQtDn6u39K0IjizRE1HqQp42XKWOgkKaj+Ln8
	JIc8YfErhtt/ZX9SSowvvuv3cdbmOJbJId/73f1dEUmHZ0aFxiI8+ekNFWDwKzsQ5By+DzzKKPB
	tNXGES1Munisz90NJ88EwkWg67DUrgOfi94mVgA3QnyXvHh8AMIu197kPkjduqHLFVTlG0eHQPN
	PEsEGlh7+TIqCg7WaZ+Oi7xA7gkEc6sWxCdr+n9/Nf/xXvlGa3T0yi3Yvv2FomQGfMCH81IH9/9
	AOftmbqJqTBKKzMEXYCRnQlOJdpo9vmLhZDRLfcZe8Wwdvr1Sg43ajJSnXqLlOk9IYMLl7EmbsA
	rQ5nPq0NglcaCGKu+n5UwGw==
X-Google-Smtp-Source: AGHT+IHjaZ7I8vrWUm2jSrf2K7izD3GQ+2svxuHCSAb3JqdODUfWFeX8SdZqFx0ZMpsg2ApCZyJSYg==
X-Received: by 2002:a05:6512:1597:b0:549:8cc8:efed with SMTP id 2adb3069b0e04-54990ebb232mr1066828e87.48.1741345723841;
        Fri, 07 Mar 2025 03:08:43 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:42 -0800 (PST)
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
Subject: [PATCH v13 4/7] rust: device: add dma addressing capabilities
Date: Fri,  7 Mar 2025 13:06:21 +0200
Message-ID: <20250307110821.1703422-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to set the DMA mask to inform the kernel about the
device's DMA addressing capabilities.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/helpers/dma.c     |  8 ++++++++
 rust/helpers/helpers.c |  1 +
 rust/kernel/device.rs  | 29 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
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
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index db2d9658ba47..f9d3d4f60ddb 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,10 +6,12 @@
 
 use crate::{
     bindings,
+    error::Result,
     str::CStr,
     types::{ARef, Opaque},
 };
 use core::{fmt, ptr};
+use kernel::prelude::*;
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -187,6 +189,33 @@ pub fn property_present(&self, name: &CStr) -> bool {
         // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
         unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
     }
+
+    /// Inform the kernel about the device's DMA addressing capabilities.
+    ///
+    /// Set both the DMA mask and the coherent DMA mask to the same thing.
+    /// Note that we don't check the return value from the C `dma_set_coherent_mask`
+    /// as the DMA API guarantees that the coherent DMA mask can be set to
+    /// the same or smaller than the streaming DMA mask.
+    pub fn dma_set_mask_and_coherent(&mut self, mask: u64) -> Result {
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        let ret = unsafe { bindings::dma_set_mask_and_coherent(self.as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Same as [`dma_set_mask_and_coherent`], but set the mask only for streaming mappings.
+    pub fn dma_set_mask(&mut self, mask: u64) -> Result {
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        let ret = unsafe { bindings::dma_set_mask(self.as_raw(), mask) };
+        if ret != 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(())
+        }
+    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.
-- 
2.43.0

