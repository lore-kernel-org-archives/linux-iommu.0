Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6096217650
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345733; cv=none; b=VsTijMAs6bWFpJuELoxvyN2HAWpaEKxOHe1s6wgWxn2T4wMN4T5m9Vh81k2EcooB4xY/u/ag1Gf7UM0RKMrsarAelSW3iBqgh1hdXxcZPe8OVSJp7zIoCkwX+XMP0Q3uqe99KmMne9k8YXwMDNUjkZOrXZXKNwt6m7s0YvFYg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345733; c=relaxed/simple;
	bh=rrOOzkjgFH92AX8ZIQzQ3stuSFWy3mIsSfUxBAk5e5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnrHL1o7mo9R3+v1g2/jUSp5SjFgu8AFK3ZRIM71UXVwpIeu8/M3uGFH5vwkHqzNnuXVmGjCnEYSVaE5pT56FDQ/p57oOShck1ejhiAywmgSsCZ2syAfvx7U1O6ixRKJFN2b2hLhf2eURfKBAGmkOtvRxRSFLWlh4iGGMA+Q3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnGDMXtF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnGDMXtF"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548430564d9so1870648e87.2
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345730; x=1741950530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09GJYTVzja13f3kvBaJ1uBzOOCE24NR3g3J/ynL3xcg=;
        b=bnGDMXtFUgA5VsHet8zjJ/u6HD0imbImw9ihyhYXUD6mnq7AchDhi79PPAxshVMfJ2
         ajdyErLitk6GcRDPTKoaUx2IxrRB3z46J8TZ6r0umdrN9Ri1BKUkenfmrHRLgPkXJGQp
         x4tgJvTW1nuxnsMRGngRHpTSUoUqU+UmRlMM7JcANw3xsxaA85jAs6MJ6wVj4ENEFM4d
         9azIuJwASJ1Ay3gRmViIQ+dXhjrjN+hoM07XSa70hq21CNVJdku4o51BaBwpGlafQVwz
         +fqZd/aCSMPcIC8QYf+gb6EzGG/TZV+wd5yW64kG/Izf2ab1t0hA2t+G5UYX8wwmib8y
         380g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345730; x=1741950530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09GJYTVzja13f3kvBaJ1uBzOOCE24NR3g3J/ynL3xcg=;
        b=A3MTpQ8O28H30azWpjFxAnh052Ld1MqCz0EYmJvFqJVdJTSszIlaRUFclU2Xp5ON5+
         xqW/OZfPXUswj+6wsnqlFq+cBzE/OKBdd4xKqNsMrIlUkBiVw88u58ZuI3KuED6KzOxG
         mwZ4BvKoJmTqaVMGLN+eq56cK+zHmbZu5GWq5wLSHEf0Ze0jcrdkkhE29MeknBohV57i
         +AoQbV+l+YihADhoRM4lqep1+zECGn5o80PI8Zzx2CyHTxYj3xfsxeLFyzmLaXIE+vB6
         A09LP8acSt2gc9gNIwqsjGpNf9YeeCnnpOmewqDUNZQHDsMfzlgoyBKrROw2tP4iD+Hn
         qFTg==
X-Forwarded-Encrypted: i=1; AJvYcCWe6FnqWs5R1OYK+FiIwcafeVLJRooWLE8BpB73P1uWmiNWGFKCJ6kNyjSTz/L9TgI3yydMBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfLdberEF5AaaUmMPZNNGFZbgIUtqeAw3/ifd4qEQ1RwrcmnSc
	FpJIlY4usbRPoZZTat5cxcykb8jywJueedkfgOCS5w/SGRRYjpfi
X-Gm-Gg: ASbGncuw1N5Kk0q2wcQ5c54ylLX6c+oJvOumYeGv1u2X/p+cQs4r/7ahBLfy8/gEYea
	54s/v6MMaEbr0CqWil53dS7/tMJKo4aBeyGqWxmBMUBaT7wz33PGROtCleBApZYEWrXj7eBkcu9
	ROCHDIUDYaCZpDMWrh7THdu1EFUmxDVBrbS0x2uSeCpAEyKfhyaoShZ3g/yF7D14ifvISTurj0J
	WMYdlqVAWXPWeoy6YieWHbaKmCfiwd5hxcb/oj4SyyCqhD7Vtsci3OE1yCac373Mbn2sGJXGsPC
	Haempl5we1HRs7blZxlkYJFgJPOYaS22UU8Yi2adlRWL5DrjZk6yBqftH7qhRBnCqKvVwxUygE0
	Z3AJTcObAwnCy2pkaF+NzRg==
X-Google-Smtp-Source: AGHT+IGdooSiaMhwC//4GREgXUoEIs+EBOffQpNGTyIYeDlunWJEPmlHzlIklF2/tY9bs8/u3NaQHQ==
X-Received: by 2002:a05:6512:159a:b0:549:5c5f:c0c0 with SMTP id 2adb3069b0e04-54990eaca02mr905585e87.41.1741345729577;
        Fri, 07 Mar 2025 03:08:49 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:48 -0800 (PST)
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
Subject: [PATCH v13 7/7] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Fri,  7 Mar 2025 13:06:24 +0200
Message-ID: <20250307110821.1703422-8-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8a250242641c..cee7adc2fc22 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -213,6 +213,92 @@ pub fn dma_handle(&self) -> bindings::dma_addr_t {
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
+    /// Performs the same functionality as [`as_slice`], except that a mutable slice is returned.
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

