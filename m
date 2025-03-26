Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB52580D2
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019991; cv=none; b=DKQ21ofWw9HmmWbr11atrJM8Qhj0KHrMN/IwOLtSyvuKF91CwrKzxerdAyenFdoXIfG4O80v8sYlndfjM1QVtEu0edQWyiwgJYtWuGCoL9ViKnzXrT0upVqsNbMyRimruw4wYQuqFJLkN3xb+t+bl2/S3My7fq4hnXfrhMvDITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019991; c=relaxed/simple;
	bh=gqLyi9zMVoqhf8dZ1h7qevw1bHrpNpkeCv+mNLriNlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeaKmLOII6H914r3wiqDkEhnmUqxtwusLJ3IIi7N8Dym7H0fuyjPC2GMV0ktGrIvk8MgvvY7O2gTRXKGaTRv8CRCEO3d9T2pXwMBrFCNrGo55amDK6vf48kUfZRXQeHcxe6Q8dctzQYpi1ukWUpo0S360aXqAv6FJxtHAmvn678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STflIVE2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STflIVE2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5497590ffbbso270209e87.1
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019987; x=1743624787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W53DecoGOTRTNw2U+SerlppI9Y+PI0pGAG3CfwRejNY=;
        b=STflIVE2kwrLWhg5TfGLBow333/s+LtMsPn09nMYq/Qm4WphKP/DkicczOoDcwSt9l
         fHNdRsCCLI9lVbuiXnfLq77pi+dbklLUJJbaYspdtbPi6MG/w/XAJLnOGYpspzIK6L0L
         um8bdrdG9NR13nzXZzAELMpXp6hKTt14wScqWxo9uvy1chsI+ckcWGKVjiOsvnm0Bu8u
         v+64MMjQ0jranzyVVONV9WRZVre/mns7G21tzaeY8R53M7fUbB0xTxqSl3giXOaigKJC
         DwSlug7y/0j47yY9UdMP9FYr/o/F68Q5i+sZcRSpyUXiAJHfVvhhmbptko40GS4/gyl6
         nZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019987; x=1743624787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W53DecoGOTRTNw2U+SerlppI9Y+PI0pGAG3CfwRejNY=;
        b=VJPFJVrAp4KxnX0rPlTWcBPZg76rf5Nha6f9APHpoZ8m4w3D3YeewJjitDqpRCOWQC
         qQJICUTgEqEwtnV+PSdoJcz+nwhj7hbanw+1Pmn26x+QGdHpMWodFN/fjVlYyWFQyHU0
         R5Sd/FTCebgAKliNXhg2YLLc/uNmom32ZuwYojOJfkz2WXpa2/uBHoOQAutIlFviLdRU
         LtDN9Sh6icZySb5i4/5mS5dE8mJ2bPT67N/avGT0DIcXJodYS4eAZl3QWMQA6uotkGpS
         VqdKCHCv0+mb4QPLVS1Fy47dxJF+skNlHMT9R8aF6o4tKg1ZzjNEQtSInubDnC1QytrR
         NHVA==
X-Forwarded-Encrypted: i=1; AJvYcCV9+cJrKy1s4jJbG1168tXutM5MvD7HQHRd5FWnEMo8VnMdEVB0QZrYbi1PtjHTtHRJ6OkxIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywkq49qpaTf0Wh/e4Kq4N6wIYZk5FocVK4tGxk8Ji4BClYl+fnJ
	eim0CxQF90wRTAcRkEG7t4RWyuWLTSGq9kGiJhsUcYsGp16zn2QQ
X-Gm-Gg: ASbGncsPRBwmBMZqrMBkodDe05vNO6g7zplY/O3OHrdXqfPj4kS4ImN0t1aM0K8TzD0
	5XW1iISZGICxknULvZWyEL8a2AnJs0dUPv1dTuPNDOSXmCO/iN5FIiMayZmiW1ECtrVftqU9rnc
	UMbBmW2UZ7V/8Q+e/+zO82Z7X5C/28Xng3XetN5AdyZ6G6oXKIGac3H83TKmsow15BcLh92RAwK
	qXXY59PNA4XuDlhOm2s//UdOGTePWn7cPy6G1XLxCcr2SOp/F+teoDJ+QrEvYmlZBWt3/DWUFIp
	FFXnFJJxvf/1aYUYhyl42Xcc2krFKFuSxRehO51TRLgb7fBcyUaEDzPhHSBKacSYMTfiRFmqSIm
	AdjC2lG6HjSEbKZv7omZobQ==
X-Google-Smtp-Source: AGHT+IF6mqMJizxHDY+F9zAuhEFm/36zPBMO1NkVB0kRHeyeNEM/AoK/eSPeVqXuM8dMCdgMLHtDNA==
X-Received: by 2002:a05:6512:1392:b0:545:48c:6352 with SMTP id 2adb3069b0e04-54b012535d7mr466901e87.43.1743019987197;
        Wed, 26 Mar 2025 13:13:07 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:13:05 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 3/3] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Wed, 26 Mar 2025 22:11:44 +0200
Message-ID: <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
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
 rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 24a6f10370c4..24025ec602ff 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -218,6 +218,93 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
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

