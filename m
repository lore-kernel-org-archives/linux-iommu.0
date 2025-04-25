Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1B622F75F
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566666; cv=none; b=Wt41vZxDWmw/Lc5E3Vy9/Nr42Mwi918Cdccfl5UfjxetBXmxfVtOapbtz9pixPzfptL2U4x07Jd4ocfi3VK8QyM+YH5x80N12qErNbqPaER7Lji03lG/1JJBm8fCdc8uR8DFqOH9PujI/dMpjLFW04GV1iYfqWvgMqqbcvk82iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566666; c=relaxed/simple;
	bh=XWuGO4SJLJGrF+nTghBBzNefxbhT1CZpxRKb9GjitCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3h601/VYh87iYHhwuAJPSH5P1YVkyllJA09uSi3NOSnO6TBYO+wn+8Yy3eEx1VzQSaWvf/ralhPpwJr1pVULVtoFishq+a7+a7KzJHpr3cflhUqNA+awY6XrDXolcmU8pB7k7nCGPOsKswxlavQcrsjw4DWfZSfysTDUy/JmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTQbeSC6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTQbeSC6"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499c5d9691so2125591e87.2
        for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566663; x=1746171463; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I7bm+ySgu/DQq5ttF0NDzcE8tALma2xJRSt3C9wY9w=;
        b=mTQbeSC6/McwY80XQpsnQ9aKMOsuLxzBu58/wrD93INYz1TlqVA+oTXLx0ai/6R/09
         cEuNZvYIa1IfW1Xq0cki0J1U5Gt3yt3ztLjttqiLnoCojnVrrkQ/s3pvSANzZrcytyZy
         OONtmfu/T53FzvDC+cjhXwBsntjKK9yzZ/bMUG6QA/zXl64MCVFt4M15IsdYxHqkyOGV
         PiQyS0jMEXxyhxaDw1GRIT//DcpUxsS2hi+fSmWER8ROURsFJsPjZsTPHwu++VvG6yKk
         euG+38agnLR2M8dR3i3HQK5b2oX8gDYf5ZqfvieAM/YZfCbtASsDw1UACtqS+YkOzLhE
         uy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566663; x=1746171463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3I7bm+ySgu/DQq5ttF0NDzcE8tALma2xJRSt3C9wY9w=;
        b=coEC+TgfJTaBOVNe9djecQlEBAFNWgNTD4F2kk6BMW8YpzKmESD2AKcgR5ysIlK1CS
         /e4AA3XuV2YRAHmNqEMZvSbWNpwnCYVUoV+CIb/K8EYarV1xPivleXbPuALqE6h8CbTL
         +tgkSAZ4Y/CS+p3bDe9jkRLEvsCeWGWGAxT2uDUz0tevSqb8O+cuLs7ClhAr0I2QuzWU
         zoPs5n4l3mf/UNoIb36WN2hxCYd7zn+7vJpx0P75aTpjAg4QMCULnk9m/FrUPZ42B5Wi
         Moif6nKJij4J/m9xVibZeWLU3EyzfsYpeIIfz6lZttJzMzR25ItkritJqeDraqqQAGlo
         1iBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPwnEQjbRq87HOdRyiqig/noLt2w3O0qbZ699dzU4aiiIjm2UTBIwGxL1Yp2BR3JwCmIezjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjLmch1Cd886XQyS8PRqXXsRlW7v5rOwVF/WhrW0PYNhWbSc6f
	K2lCPzutue9OrvcEEjlqFSB6ned/EQKEiAP9Yb6aOlfvfzx+yvo0
X-Gm-Gg: ASbGnctyy0waUb2B+DQkErmwsJ4eY+ltDd1aVpH/KWtt8tEdYRWtI74yRxyztpL+Wyt
	Wa6dIOkfzJiH0pHeD1X3aTjcvzmedZp+3wx/3PEkJt8nVBRoGpoTRnWxNE4pEmeXS2gEu5ThXRv
	nzRXtZao0WTYdJ7jwGLe5g46jPKiTL8ZB9kCiLBNCbn8iVZz1++JS9dcrgUX3jtydY10YLskmFT
	Yu8ud1HjbCztrn+GHDi+hODFlaYdHKrBYeXnBeMos1NgvbAwsOAY7miDh19t4L1uMSuojq7AH4Z
	AJdFaXaepOc9fWhXejW+5eU8jhkrUeWIjGO3owkJfjNzpu4CMlpBlNipSxBHON4ZZ1HN24CK4Wq
	KTskSpHi8T1Ia/bwu94iW5ERfLYA3
X-Google-Smtp-Source: AGHT+IE/O7y+ibpJZn77AUv3aPfHPZbiY7wPyl4ijZldhKUFWJKAEQIowa051VjLOyzso8Bq8UG5fA==
X-Received: by 2002:a05:6512:318b:b0:545:6cf:6f3e with SMTP id 2adb3069b0e04-54e8cc0f2c2mr287610e87.49.1745566662719;
        Fri, 25 Apr 2025 00:37:42 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cc9e9a5sm504391e87.132.2025.04.25.00.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:37:42 -0700 (PDT)
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
Subject: [PATCH v3 3/3] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Fri, 25 Apr 2025 10:35:42 +0300
Message-ID: <20250425073726.1027068-4-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index a61da5eeb017..e01bb7e7c440 100644
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
+        if end > self.count {
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
+        if end > self.count {
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
+        if end > self.count {
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

