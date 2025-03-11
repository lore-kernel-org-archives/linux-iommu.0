Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17E2641EE
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715405; cv=none; b=P1457rCv0FKvsV2j8t7vonAIuIq02h0OYq17ugyxAr/EMYGwlz0CDuTq9E1mCxj/uwy0Z1ws5x1mx1KZqBxcYapubi1nBXg+Dll1ldl0IE/f1tKtZhTLKi+6mxHFMnP51L6ZTyHz5O+Noac3Zcw2ahb4hzXVV+5JYG1Mv9WcmUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715405; c=relaxed/simple;
	bh=j4ICurqMmlLInUMYmohM6h+/0kW79Y0dJonUlhaLBYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1CJKzAp26Tn8skqtjWheW1UUrqz2DkmaWiSuJ06CCTU3LligiWyqKgzUYYzEg/n7orJ8wTT6VxFSmiHo7yogDV+KhxcOtySZ7tC6GBiiM2ekE9Yv9KHlHqOeDH497HqMHzTJos/g/DlUSmIES+Kq4Rh1PL+ARnBF8KHOjPDmbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6oF5Fow; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6oF5Fow"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfed67e08so38172881fa.2
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715401; x=1742320201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSrzlK5UgeilNXDe6by3qJ/tSZ9bYf/cIKJZFecm9Fs=;
        b=V6oF5FowpFPVludsSsqtMTI3DvjB/krqaWRpBxqJzloHQVdOsAJQv0UAIfcG1s/Whe
         hu6+2f21roq74ie6SLzz007Nv9NUPfDo6jT62TXxNPUcnKuS7VaBodquaone2bn2fYb9
         Sj/M8/QJ6ozAwST72d0UJMsQKUJ5ruVXEIne5LF5qBh8FrC90UMF6p5sa3cAMaYfX0Dq
         uBjRwmQrZz0DDLyMZ3gg2ev6El7IA6lraKsLsYCF4Tjb7NOOL2/hzLFf6O0TG173hl63
         oCJFrbwfAvsJ9k+0OL/RfRbmi+k0/2R7+DmzmlVY9KRDpFnGzp727wM/vb408CekHiUb
         RHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715401; x=1742320201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSrzlK5UgeilNXDe6by3qJ/tSZ9bYf/cIKJZFecm9Fs=;
        b=XiM63h3azYc1HdHFPg5G7y1kW298AUg3RQyOl1aVWHp+nPYSsi1SkyoXNi54oetkAJ
         KU4tuQS5lS/VDLlqCGvuO4y1BKhSXJ6RVxPCFcU25kMUEPikElYXj+PwNgarnPh58uRF
         voiDJwx52GSsHJ4k+cepTuGjtN4Xcd4XAjN2j9WgrOzRzMruCi0T8A/wF+lXGSmE7LN7
         EYW7pTZ0gz0iWuwmt1c+Q1QGrxL7wh9lGIX9mzZ/z9R3oGEunO+L1wbMsJmSiycUO5Hc
         smUynFpmIe4ydnsJrfVTZVQO9iB2hwN95xzpoBoTQDpbz9KPegxXi5o3dQ+5ZjuMs3io
         A3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXen2RyiB4qZdEBMkEItddwYa4t6GCs1JnbF2GgCctQx56hGl2LYe9YVxFIpTZ28sf5fBZ+yQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXO4dtqqwPtGc8OQ48das2EDkvRAuCSmJopBAN4d03n+Hnp3QO
	xgMXn+m44AcXdVPVrt/qLK3rb60W0xlN+xlQSPxBe8WjVtAIZLvH
X-Gm-Gg: ASbGncuu6V421cdQQFiTTLXO90IBQA0X1kMOt1nROj5WvPiIshCyXuwkUPspxIgH4N4
	sp/VI8cCX8PSObSMZs+1hjizg6SzFaifXHUVpnCH1ys9Ke2544ZF/1yOG52M46fjpX8bLzQaOT1
	D/lGobTYrvj7sI8jql0tieXeI3iPlDlUcIwFlKj0T64SVyVHmqeggnLK6Qyk6bN/2cL9NI8MaqO
	E/g2VXSs8FTUZfyVjM/1Nyy4BTclZe6HSUpURhFeAgixs/GgxKyrqg71iul42xoX9m6zprko6R3
	8lCxolYhimAcstakLJZvGljl6YQPtlKPP13aapOfaDWC51zvbIM8E9pIQe1hUfG4aexagoSsYUx
	JvT2v/2/0+Si2uAp8K9GQZA==
X-Google-Smtp-Source: AGHT+IGIrskUDBhrtLJ6SrsQZPVLptUzfeEFgQD5QeWDh0vtw/4t8hw7rBlRiiUbzBV0cn9Wc/W8UQ==
X-Received: by 2002:a05:6512:3c98:b0:545:2550:7d67 with SMTP id 2adb3069b0e04-54990eaacadmr6700836e87.36.1741715396745;
        Tue, 11 Mar 2025 10:49:56 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:55 -0700 (PDT)
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
Subject: [PATCH v14 06/11] rust: dma: add dma addressing capabilities
Date: Tue, 11 Mar 2025 19:48:02 +0200
Message-ID: <20250311174930.2348813-7-abdiel.janulgue@gmail.com>
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
index 7ff797a7ad18..ac3ec0042327 100644
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
@@ -374,3 +402,15 @@ macro_rules! dma_write {
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

