Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BE1DC182
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398375; cv=none; b=JkYmVrsAXeSx2iBLx5k34yEfPFUUg6wdOGGbfL/YMqsYKO3yf8sUUa6A9RMjkKVuIs07MQF/Yoj+uxYU/OmWAzYQMvGHbhLkF/xCo+0ioiX2WlPE1Q0MQARU6LdU91tBfMyJp7Evuq/LmXdFOufVOiCWFTh0cMXISMz2sw95EHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398375; c=relaxed/simple;
	bh=v/VhgNzAUy5yfkyihuvK+jBGhawPzQRWRegqTl//ZtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KozSzqMs6tzqaNIJBlLD06TFXnYd+MnV3tb4yAt/sXF19/z//+UN8Rz6xgLVdGcvN98lqYvQEYb8ThTMQxNrdS0YR44EzdnNgvkLbOEbvaWOX5AV9QTb5zjfHAl/+oMulhCg6k72aAVA8CAMo2Ijgo3cqv9YT9CbpHcNo7d/jew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXAi2zfZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXAi2zfZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de852a287so867648e87.2
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 03:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733398371; x=1734003171; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4w+FNnQU4Gd2oQswt6DB7Qgzf599gU2AT2+6YNQKrw=;
        b=bXAi2zfZYn4ENDS8r7YcZXe27cwiwL0BrUwCcKv/zEP7x565p3FRTm5mF+63ITkDMp
         gaqAvlc3YMARgOUs92NOlZkqINrHh8aTZLyhVXO5WXuh4HfyUG+TsJdxeNRwp6QsxIUv
         M5CDTp2Hy1unHyD6316RTKCQiFpnFgKpm5mNNFpkfYrhGQ7Hg+uWnjhP/aN3BhpuF4qN
         DQWxQ+/kXliQAQ956/l8Z3RlxyZFsbIuxjONvsYJ1rWrkJnjkZ7AJ78HpkdeXqWvf36b
         0C4wcr4to1bq6XbkIHIVqH2A4Dfvt9SSBlbPcFiSm0YRGJH0SwtHpsGvsshbCTjD7dhP
         u5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398371; x=1734003171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4w+FNnQU4Gd2oQswt6DB7Qgzf599gU2AT2+6YNQKrw=;
        b=HgjHky+lL5kCzei/j50OTp3ekMReNVBbGDdR0PzzfW03K0R5YcjXcdd0n5V2jaR07W
         oBje7kcIWrUXJuQKeqQj2fBHyFXK3zlAodekgbq83XyW2XLnsc2tRyJtqNGPK07RgIWq
         zDJnDR+NEarxpYWXagupfY93/Nt+m/CojVu8P+AmeujnDFY+S/YxPPc6Skh4tSelbO8W
         9skIPQzaPwzVObGL8Hmbsqn0ONhkEdA2JFDQIs17r2eaRqR5NbWT3OsCQlrrmXOYri2M
         IYdYQSZ6o+ccAy9dVrQKy2TxGykgBnTZ+G5omIjnB3eYPnboW6U2O5PrAsw3XmLp3qks
         fDHg==
X-Forwarded-Encrypted: i=1; AJvYcCXE3RdEPGBkBMhC1HQfifVgiiypASgGNHHI2KmSh6RYewzcBH5oMnlRjd6AjmYrjqaSbnvDQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNqGuFgGX5qLZ98fLbw6Ew/z/c7VjDE4PpfwnekovTQRiivkI2
	wzezkivqS3PhNIVYTSYfe5Zin6AYF+gXyv4XfeIPIp9jMPtJO2cL
X-Gm-Gg: ASbGncsusXGomy5t6Y3JCXoc6qf7o9iOSx6DQPpGgIxvQL73vMAKhEM1K1ADp+KD6D/
	0vC0X6w905s3V8sVxJ4zEYwJcCxN9di62zXCKjsjvBGm3jOf86o3EP/DQ6lNoUNu2OF0bLc1Z2K
	GlY2Yj3SKVHT6OYc+nlCRvvrlo68N8oMRSGkiiQYQBxyBOm3x4t35uRxzOfusJaaNV1IKfVFeL/
	KIBlw8oIVxHttvZFcZJj9QmU9wYAS92kRqM6Knj2juLo2ybqvA24hCBJlanW2BjEsWCG3g/0bbH
	yfJsu44uS8wfh8ECupOe
X-Google-Smtp-Source: AGHT+IHzbyGee5WIyxIDgwfUDjYSBmtTtthROTbvUuih4hQqRJxGEWMbCyELSJSBDvFxXHkoBFi+/Q==
X-Received: by 2002:a05:6512:3f22:b0:53e:12ea:f797 with SMTP id 2adb3069b0e04-53e1b8b731cmr2760098e87.42.1733398370489;
        Thu, 05 Dec 2024 03:32:50 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229744e3sm216136e87.66.2024.12.05.03.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:32:49 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
Date: Thu,  5 Dec 2024 13:32:17 +0200
Message-ID: <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple dma coherent allocator rust abstraction. Based on
Andreas Hindborg's dma abstractions from the rnvme driver, which
was also based on earlier work by Wedson Almeida Filho.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 136 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 3 files changed, 138 insertions(+)
 create mode 100644 rust/kernel/dma.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5c4dfe22f41a..49bf713b9bb6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/cred.h>
+#include <linux/dma-mapping.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
new file mode 100644
index 000000000000..dd725c571ff7
--- /dev/null
+++ b/rust/kernel/dma.rs
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Direct memory access (DMA).
+//!
+//! C header: [`include/linux/dma-mapping.h`](srctree/include/linux/dma-mapping.h)
+
+use crate::{
+    bindings,
+    build_assert,
+    device::Device,
+    error::code::*,
+    error::Result,
+    types::ARef,
+    transmute::{AsBytes, FromBytes},
+};
+
+/// An abstraction of the `dma_alloc_coherent` API.
+///
+/// This is an abstraction around the `dma_alloc_coherent` API which is used to allocate and map
+/// large consistent DMA regions.
+///
+/// A [`CoherentAllocation`] instance contains a pointer to the allocated region (in the
+/// processor's virtual address space) and the device address which can be given to the device
+/// as the DMA address base of the region. The region is released once [`CoherentAllocation`]
+/// is dropped.
+///
+/// # Invariants
+///
+/// For the lifetime of an instance of [`CoherentAllocation`], the cpu address is a valid pointer
+/// to an allocated region of consistent memory and we hold a reference to the device.
+pub struct CoherentAllocation<T: AsBytes + FromBytes> {
+    dev: ARef<Device>,
+    dma_handle: bindings::dma_addr_t,
+    count: usize,
+    cpu_addr: *mut T,
+}
+
+impl<T: AsBytes + FromBytes> CoherentAllocation<T> {
+    /// Allocates a region of `size_of::<T> * count` of consistent memory.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::device::Device;
+    /// use kernel::dma::CoherentAllocation;
+    ///
+    /// # fn test(dev: &Device) -> Result {
+    /// let c: CoherentAllocation<u64> = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL)?;
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub fn alloc_coherent(
+        dev: &Device,
+        count: usize,
+        flags: kernel::alloc::Flags,
+    ) -> Result<CoherentAllocation<T>> {
+        build_assert!(core::mem::size_of::<T>() > 0,
+                      "It doesn't make sense for the allocated type to be a ZST");
+
+        let size = count.checked_mul(core::mem::size_of::<T>()).ok_or(EOVERFLOW)?;
+        let mut dma_handle = 0;
+        // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
+        // We ensure that we catch the failure on this function and throw an ENOMEM
+        let ret = unsafe {
+            bindings::dma_alloc_attrs(
+                dev.as_raw(),
+                size,
+                &mut dma_handle, flags.as_raw(),
+                0,
+            )
+        };
+        if ret.is_null() {
+            return Err(ENOMEM)
+        }
+        // INVARIANT: We just successfully allocated a coherent region which is accessible for
+        // `count` elements, hence the cpu address is valid. We also hold a refcounted reference
+        // to the device.
+        Ok(Self {
+            dev: dev.into(),
+            dma_handle,
+            count,
+            cpu_addr: ret as *mut T,
+        })
+    }
+
+    /// Returns the base address to the allocated region and the dma handle. The caller takes
+    /// ownership of the returned resources.
+    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
+        let ret = (self.cpu_addr as _, self.dma_handle);
+        core::mem::forget(self);
+        ret
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space.
+    pub fn start_ptr(&self) -> *const T {
+        self.cpu_addr as _
+    }
+
+    /// Returns the base address to the allocated region in the CPU's virtual address space as
+    /// a mutable pointer.
+    pub fn start_ptr_mut(&mut self) -> *mut T {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may given to the device as the DMA address base of
+    /// the region.
+    pub fn dma_handle(&self) -> bindings::dma_addr_t {
+        self.dma_handle
+    }
+
+    /// Returns the CPU-addressable region as a slice.
+    pub fn cpu_buf(&self) -> &[T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
+    pub fn cpu_buf_mut(&mut self) -> &mut [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts_mut(self.cpu_addr, self.count) }
+    }
+}
+
+impl<T: AsBytes + FromBytes> Drop for CoherentAllocation<T> {
+    fn drop(&mut self) {
+        let size = self.count * core::mem::size_of::<T>();
+        // SAFETY: the device, cpu address, and the dma handle is valid due to the
+        // type invariants on `CoherentAllocation`.
+        unsafe { bindings::dma_free_attrs(self.dev.as_raw(), size,
+                                          self.cpu_addr as _,
+                                          self.dma_handle, 0) }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e1065a7551a3..6e90ebf5a130 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 mod build_assert;
 pub mod cred;
 pub mod device;
+pub mod dma;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.43.0

