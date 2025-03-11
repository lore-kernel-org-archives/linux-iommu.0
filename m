Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DD26462E
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715410; cv=none; b=p8b+uArHAFiPF1PDxM0LzlH9rPaZvyyxyNCjlp5W4wWaOTFWJqlm0eyxbjrFScCXe06e/KOCeo9hR1Pe+3c0VwZL8Bq9Se9/IbjVJcTkFX5P2ZrLJuKHJOLxWV7eSMs2O2sQEi2/lP0Twz/GgIz9DZOdKRAYt8gwy8cnM/QoKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715410; c=relaxed/simple;
	bh=964LyMRqlPXEPxt4dRUtburkX8rzYyxtJ+Zd6YPN9n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7k+3lynup3Xfa5gu6qWnb7Clj1jSPJyn2pajLNMdMx0A4LS/gsTjpV8aWsy1POEjQo1eBjkxZcBAQ7AiJ4f6G3lH3pY/RrzFfeXUdZXRT07PcTa+eXG6LJX1h3pcHCcvv0g6JkLZ28/+7Ow9jj4gYwhdD/5sQOSzja6VkA7yN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1oSP/Ar; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1oSP/Ar"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-548409cd2a8so5610313e87.3
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715407; x=1742320207; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyciabioh/RTBRWZFgAXOHCv2udpm7yTbk+rfqYhebY=;
        b=U1oSP/ArQilX3iGfUL24OzuQtrOzHYJrvIf+g1y2HPctKVq4sgdxEiDO08nqEtvRco
         s0iaumAB4oWrRWY6XavQB0BFfmGKuvbpphzbvH6C2M+DT0m8lFF1Pd7CHb5wIYMoRJZB
         VxRHdMp5Wq73VDMSLQtSdafkQvXOlHXJyl1akzLflLOL3Iaud7PjJkT1X4WPc1F1IXZ5
         qR2JDFRVbGjafZN/7/xaQq4J0t0Mvq8inFJi0UOAhIiUKK5chxnzifgUDvb/znKVvDoA
         2pRjWJ+lN0jLbpITLRCA8TBYB8UpvSAeJXs5TMbP3krlTitYgzSjUfJalzDv6meS0vbr
         bT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715407; x=1742320207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyciabioh/RTBRWZFgAXOHCv2udpm7yTbk+rfqYhebY=;
        b=Rpkiq4q8tnUkY7hl8oJcOYjMnf04F5ca/BZ8d8wBBkGhwEa/Uwj3oOtqfRDp86Ab6t
         XU2lzzZMnwl58rVzoKkh6PdQskzjQUdgqVGfj+1bNkgR8T7eqKzQ0bWboQJv+7NNiT0P
         /MYJL59lcYC2ZI5wX6/o9pEjaBNf/Ktv0jSO/gOqsagcwSYKX+snSG1dJs6CgYStNjwV
         8r0l/WGa+hjaOrgraoKah3169RlHVCz1pqLoz+M2EjC2ialEFVvxeeYqcZTt+huDYr5O
         u6DmGqU1buL5lwTMtB/JXRuO0RHI0ZFHgbdlsU96QxAQUQPpGhnz8tEC4tRxIsplBEnS
         sRuw==
X-Forwarded-Encrypted: i=1; AJvYcCUnj+47pTOQmV+DotLG2avTpL1PTgr5KlZ1a3XWDBlZ2TM4t5J8QDVGECts07A3ONC/gwK0Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvP6o+s1Fu68W+LybO0p5yOKgHad8pXVRBU7Jennp7p2YhZxiJ
	07VFkCiS2oapJtDLQwG2UhUoVgbM9dLZZmRXO2AfHWnlx+itm68M
X-Gm-Gg: ASbGncsnnbUZUEg6jlmZyqsJHPTj7kzEsWci1yMWqjsIxUANBXDm7q7feXewn32Sjcb
	ERlYoqv+HqTcA87lCCuciW7GK6SGl9fk1+fj3PLBYAvTQ3LcmET11bLxcffvy3TnPrJcfV4tBLz
	FvWfJLPeEJt8oqYCjw0fKDW/4Q5Z/OU62zvXlioY/ILwwRZfIBiUp3EDK5bB5eSszen10qQ9MZu
	BODY3IXkC5PjPIMf89/XPVkIGt8zETatbrTZ8n2JVtYQDaRmym5OqCi9oQksGzNDZzbpaLvQp44
	psD7NQAXabVNVPS13g2uQBanRhr2lEHhC9LOviGCbLRq3uJHiKY0ksYjuNJ2vdZ87utYU2aW8Lk
	XZXE0FKZkTBVGYhfcqfzuhg==
X-Google-Smtp-Source: AGHT+IEJad4gl+z0QS4ewlzZ4karifVvk4Su2qy2hDsPEF00+XFLaO/pmT6m2hKmYpP7qT9AMIlM2A==
X-Received: by 2002:a05:6512:2393:b0:545:2950:5360 with SMTP id 2adb3069b0e04-54990e5e2a1mr6250883e87.22.1741715406926;
        Tue, 11 Mar 2025 10:50:06 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:05 -0700 (PDT)
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
Subject: [PATCH v14 11/11] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Tue, 11 Mar 2025 19:48:07 +0200
Message-ID: <20250311174930.2348813-12-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index d0c6569cfc70..514fbb27c607 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -253,6 +253,93 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
         self.dma_handle
     }
 
+    /// Returns the data from the region starting from `offset` as a slice.
+    /// `offset` and `count` are in units of `T`, not the number of bytes.
+    ///
+    /// Due to the safety requirements of slice, the caller should consider that the region could
+    /// be modified by the device at anytime. For ringbuffer type of r/w access or use-cases where
+    /// the pointer to the live data is needed, `start_ptr()` or `start_ptr_mut()` could be
+    /// used instead.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that no hardware operations that involve the buffer are currently
+    ///   taking place while the returned slice is live.
+    /// * Callers must ensure that this call does not race with a write to the same region while
+    ///   while the returned slice is live.
+    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Performs the same functionality as [`CoherentAllocation::as_slice`], except that a mutable
+    /// slice is returned.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that no hardware operations that involve the buffer are currently
+    ///   taking place while the returned slice is live.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   while the returned slice is live.
+    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        // we've just checked that the range and index is within bounds. The immutability of the
+        // of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
+    /// number of bytes.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that no hardware operations that involve the buffer overlaps with
+    ///   this write.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   that overlaps with this write.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -> Result {
+    /// let somedata: [u8; 4] = [0xf; 4];
+    /// let buf: &[u8] = &somedata;
+    /// // SAFETY: No hw operation on the device and no other r/w access to the region at this point.
+    /// unsafe { alloc.write(buf, 0)?; }
+    /// # Ok::<(), Error>(()) }
+    /// ```
+    pub unsafe fn write(&self, src: &[T], offset: usize) -> Result {
+        let end = offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`
+        // and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        // that `self.count` won't overflow early in the constructor.
+        unsafe {
+            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_addr.add(offset), src.len())
+        };
+        Ok(())
+    }
+
     /// Returns a pointer to an element from the region with bounds checking. `offset` is in
     /// units of `T`, not the number of bytes.
     ///
-- 
2.43.0

