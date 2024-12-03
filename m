Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8C1FAC46
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245743; cv=none; b=JIIdes0fioeF6k8es98SLCq6MkKMAEKPjZD4DS3tx30/HVboyo3PBSfFFRg7D8rCY+SHGx2yEF48i1Os0zhyuGASLWjcxltuiCSHske2zeSQsFxzlM2OlH9T5tHDXi7nDz1CUCeaBTHzyWPfi2f9lGxI9j0KDSvKOCZhFCHb+Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245743; c=relaxed/simple;
	bh=jDgoZVWs1EZ0BLsWSC/biSIEBFBgOOP/XfjuZPS8yO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMDTWQSWOQGV1368Jk+XPJr4pNEo7rAae4Jzl16a+TknnSPvepk09hQae1jzYnSBj8scSp4ZERL/c/TPunCuADGPcZqWEC5WWzdKaLLHveVqouvwL+b2YlTQGP5hIdeNdKdhRXH8NQnUVQuX68jmk033xX3kyVsGyOkqvqChJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kha2/Ksb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kha2/Ksb"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso5921139e87.3
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245740; x=1733850540; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTR6Ylpv3eNdxiaC7COAI2rMXOLAET8qmxvIBqqw6fM=;
        b=kha2/Ksbxn2DuLtOJJbZKguKBBH3D28M450YTKFoYb5lH/cU+H7lB96Kqy0jFk+DX7
         6bVk2oIT1wuHGsi3Y/ui1lQOLPLDFm0W2gHiu/FcbODs+ynef6XuVsLDueag8Skhbu8+
         lmGjY7xrG52XrvjVlQBasB4Ircg+emZRgBtGdbEDp0m+/DnjzRfLtLF6d4kDkgFgQAGw
         XIu2RIbMydC4QEOCm6pkktWorJmVvyGzleOLjdu3VMJI9kj3769vJJ6GtrnQ31mFqfUO
         5fRucwezf3HF5LUBGc/UB5ph0CpOSk7AuGM4C/kfK094WeKcF5n8P1en9JF8wCAY3IBd
         IPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245740; x=1733850540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTR6Ylpv3eNdxiaC7COAI2rMXOLAET8qmxvIBqqw6fM=;
        b=DnxWd5544ix6c+/JZkfITaetMkVWvhUS+QRDWmm75e1HEYoNjHIwOH8hFwOCCkgTAy
         7gS2Q4mlCZkEQIqed7pG+vOoi1iigxb8fLykSOxuBOIm4mEipP4q+ukpq93J/oPO0HJU
         OCIJY5bcMuEe1bT+U7S2ETBoGJrRaewN40bKMfojTUkjB/3rTgmkyrSEPBCCJYaHIuT7
         q9QWseIokE5cKErASPVjZoyOb9fG7LF5kABiqO3xNReEiDL65qydjJKNek3vebMdau6n
         z0JwafQTk/dZwccY1AoI4TFCiGKa4MRXRmzlFpspJyHpU990jaf2LJtBs1mAUSp1SPW8
         RAzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN2COMkgYZqOBvgwjG497MsFnxCHix84bTX97Sy4z/+E24psHc2VcACspxofIP91HnWSZ/SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpHoyz3jYwkZaZVjYI5epRRZEGWBhNQVgJl1HquRbXnJ522Fb1
	mnheaFiGV1PAobBomfJ1KKFqK/rqqQSwzWg5Pjx71W7eM6cOp6D/
X-Gm-Gg: ASbGnctb695JLBT8/1KwVJM0dkLRYPKz6bGJPCg8dupWmhri6pFmB2GMbBlQsHs/lOh
	yRJ47tRCvSJsSJoCbug8MWWmlJGYwkSFBRS3UiprSTF+Pk2GkMwpCMXxUMJIHrlCQYVnixp0HgO
	ljM/tp4iUqUqN1WWIGc/ay3EDFn4uIftuzsdW7DI2EXraT8c/a3X4smthp8WnGk5iq5jnnYOugH
	LSC1oxuEHcLo7FYo0EXdxneYrRZKzIMdUFlHpCbHn7oLC7N8gXNAnPW2E2JQ1tVsD2wRY8/FiIt
	RHP6m+fpeJvKbZ56nvmE
X-Google-Smtp-Source: AGHT+IHk1IYP2NKFAmvEFFHZPc7mvlW5OfXCL9iqwuQ5vcHYn6pBy4IkJ3t9oeRJ73P75rqoJytFaw==
X-Received: by 2002:ac2:5b90:0:b0:53e:12d6:7853 with SMTP id 2adb3069b0e04-53e12d6786fmr1874749e87.4.1733245739714;
        Tue, 03 Dec 2024 09:08:59 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644336fsm1893394e87.80.2024.12.03.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:08:58 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
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
	Wedson Almeida Filho <wedsonaf@google.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v5 2/2] rust: add dma coherent allocator abstraction.
Date: Tue,  3 Dec 2024 19:07:44 +0200
Message-ID: <20241203170752.1834271-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
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
index 000000000000..9279be235fcf
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
+    pub fn cpu_buf<'a>(&self) -> &'a [T]
+    {
+        // SAFETY: The pointer is valid due to type invariant on `CoherentAllocation` and
+        // is valid for reads for `self.count * size_of::<T>` bytes.
+        unsafe { core::slice::from_raw_parts(self.cpu_addr, self.count) }
+    }
+
+    /// Performs the same functionality as `cpu_buf`, except that a mutable slice is returned.
+    pub fn cpu_buf_mut<'a>(&mut self) -> &'a mut [T]
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

