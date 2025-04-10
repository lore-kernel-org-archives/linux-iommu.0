Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F320DD5C
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275569; cv=none; b=eFm2bJszEEIQZ8O0cEoX767jBtFnwdeGXT8Q5e24Vsu44jI3FCix9GBhdNgp6IHoXVEyF3Ulico1DgAGyWVDh4Ceuh9SnrRLaSy8bXxzWjh9qzOTNSjSC8l3pkJB367CPuCaiXRRO4EhwoQiu67LM+zIfDHi9XF6ErcOA3Gbrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275569; c=relaxed/simple;
	bh=Dm0EuL/Hf72yUy+knejcLhK3TuBfjuxm/0quqsCP/xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUMBEj0kIm2WScEWV0egI+8juVKPXU9N4I/bxWA7zOpLD16v7KDl2wEkBcp83xk/s1Yvd5Wngw4rMYUnraO3XYItyFIkPq9Yv09HRPeRw8FCOvaUlBqxJZEAYpZqyHliIh2AojYlD2v25Ybsf9io2pAENQlQ+7Y5TLhGZNKJBZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K25clgfc; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K25clgfc"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54af20849adso620423e87.1
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744275566; x=1744880366; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY+y/t6CAx0RYTvL64DfJN6U/KJsLf4NXsmWUCaqj0c=;
        b=K25clgfcsCwd00z5W6VDe5u4QLrZ83DJCT0kEdGDjrQAAcgC/sy0fOJAtsrnUV7VRy
         EhBqjR+gQ8obZwinf9pTVjGC5fwhIsBMpMBZMEbzEEN91oCMso6y2NBPh4YTRmwNGH9a
         JrgGkirEXw3LMk1SIx1vhR0TW7lum65/g5FF8w5bXfPF/z+/MQ08rmCv1g41lIAD9dIT
         zXsOX15rpg3AKh45evnbUvqsE32fnURhlPGE5JVNT9DMOZITE3sIGNi+KdjgGV01O+PU
         xiKGlihCD1K+4EHGAA6bt3FYcK+Dw8cGSQczssvBz+JBS1G5ZEU5tKj/SCH+WtN5MO6g
         cjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275566; x=1744880366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY+y/t6CAx0RYTvL64DfJN6U/KJsLf4NXsmWUCaqj0c=;
        b=wTkxqBTa+gy7N+rxiGSqqXbUEjKbho2E66iNb0/ru4qDwASOnXPUog3f/4JCnS1Axx
         CsuQ2ZoVyFiMYCoIGqBOUQCFNVWNBNDzptV8+91vqcCk8hjcIScHqO/dmjPvhcy6DuAM
         cF3hrIb1+hl4InA9o/F8n4CepRCPlhDDLaqg5AcyjPzAzbIWcgIu7hJrKf8R28Xd7lfP
         9UELnLdGknaE2+zl0mNSPaxkTfoxfj3qcEA1fPCTvYk/f/SYnUAUvAmpfmCJUoGrzvao
         dyp8hjIQYbTsSw2a9UkKIjiFALllh39HhAT4FCLeO+7OWf9zM7lHMFUOiYO01hTpztnG
         91qg==
X-Forwarded-Encrypted: i=1; AJvYcCVbWOU+O8YiV7G/gdsyMBdMBZBvR+h3nYIBjKMbMwxKjhjVrnxXTWHAlnH8X4O/BYqG8RWH9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNG+h+dccGCYY7rffIgnZjiBU4UeAG1eibUZXATO1pdL0dKSra
	fbM7Px/pBY9U/Vio3KNXimZRONRDtk0oBQFt03yhRtTBqhrNYAKv
X-Gm-Gg: ASbGnctdEy5BNt2E+es9kHh4ZC+bj1kZd5HmrcbVEzoLHuHvc0KTnBMoHrJH5TWbTwd
	88/wPty9ywO5kJpsdQENweFCPQiTL7I7n1vdQ8ax2wXHCtcBik1e3FPdbKwgOaeScutfXOlka5J
	jVCjjflOV5A2k1LogTXrOy5l8lCY4J7sszvsFO3JT5HaSxVYmwet/hdRLuRC6fTfiA+QTw4iYCg
	80e3eunuGiDnFf06to1uLEl51CGIUbzNXI0xkphLPP8WQnGVqwUDuTBZtapm0E0bESHCaTox3bU
	wpFc5uDKt9MsLwMgEx2FXagHNAIcnun1+oyocVR2p5lpVny3CKP92RThxyX3TzDkO+5Gjcx7gN6
	LNLE9fWM9s134+Ca97Q==
X-Google-Smtp-Source: AGHT+IGz1LYsDiprrFBJZFFqhs+1F1wEyvjL2TCIsFB9waYQMtth+506AVNqZHbMN3ejNCWqSKWKSA==
X-Received: by 2002:a05:6512:15a0:b0:549:7145:5d2d with SMTP id 2adb3069b0e04-54ce8a48130mr530657e87.16.1744275565490;
        Thu, 10 Apr 2025 01:59:25 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50285csm80875e87.110.2025.04.10.01.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:59:25 -0700 (PDT)
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
Subject: [PATCH v2 3/3] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Thu, 10 Apr 2025 11:58:18 +0300
Message-ID: <20250410085916.546511-4-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index a61da5eeb017..880f6f04ba86 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -218,6 +218,91 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
         self.dma_handle
     }
 
+    /// Returns the data from the region starting from `offset` as a slice.
+    /// `offset` and `count` are in units of `T`, not the number of bytes.
+    ///
+    /// For ringbuffer type of r/w access or use-cases where the pointer to the live data is needed,
+    /// [`CoherentAllocation::start_ptr`] or [`CoherentAllocation::start_ptr_mut`] could be used instead.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   slice is live.
+    /// * Callers must ensure that this call does not race with a write to the same region while
+    ///   while the returned slice is live.
+    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result<&[T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        //   we've just checked that the range and index is within bounds. The immutability of the
+        //   of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        //   that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Performs the same functionality as [`CoherentAllocation::as_slice`], except that a mutable
+    /// slice is returned.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   slice is live.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   while the returned slice is live.
+    pub unsafe fn as_slice_mut(&self, offset: usize, count: usize) -> Result<&mut [T]> {
+        let end = offset.checked_add(count).ok_or(EOVERFLOW)?;
+        if end >= self.count {
+            return Err(EINVAL);
+        }
+        // SAFETY:
+        // - The pointer is valid due to type invariant on `CoherentAllocation`,
+        //   we've just checked that the range and index is within bounds. The immutability of the
+        //   of data is also guaranteed by the safety requirements of the function.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        //   that `self.count` won't overflow early in the constructor.
+        Ok(unsafe { core::slice::from_raw_parts_mut(self.cpu_addr.add(offset), count) })
+    }
+
+    /// Writes data to the region starting from `offset`. `offset` is in units of `T`, not the
+    /// number of bytes.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   slice is live.
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
+        //   and we've just checked that the range and index is within bounds.
+        // - `offset` can't overflow since it is smaller than `self.count` and we've checked
+        //   that `self.count` won't overflow early in the constructor.
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

