Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56D204C2A
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237669; cv=none; b=bjhtph7n0ls+uKSDF+stCQLW6eQ1uXEDGaqbkzUnMc1W0zNj+nWMzlynrTR6a/mxrO181wBlnev6UaUpteHWCkRsg+zqhcjXhQYJVGtcexxnX7xoQj7e+V3ngSmhlmNh+1z08GY5T1ZlroYfUgK6RkombRDKFE3zeoyCnzIpab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237669; c=relaxed/simple;
	bh=/7wFbnKC/IXue+Ku51P5u/UhRTtbHQI319bGUuW1U8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAimXsrBbkGU8c7AxUBpQHB9D9T5Hlh3ZcJGk2NkOZYYbEDq5lv7sxjwh/Gd9eNDORCyCucatilbqTqzdv0JEzZWGtfd7CVqRerlkuRUzeEBsKNeZNWyVT1UvL7j2qD4A40SBW9h/81GJz1rp+xKTnt5mXG9dc4+xTqRcQDhtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxD3Yae1; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxD3Yae1"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30762598511so50328091fa.0
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237666; x=1742842466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTtaX3vhSb5G36KvfqVCTP+WKBznUgLh6K0dIke/e54=;
        b=hxD3Yae1FxvJ1sc3PG3+ZhQbePxWuqhPkAKjrX+3UtJvDHLZVoaAzmPmjQO3EN72mv
         HlNhOIr9TrqwsZiZ1PZADYMzSUtUJj+3iihSQ4yahFnSFqV0geealNwd0S9R5TYmXJPv
         61u4NPugy6xz1NGYmbSkzrQFtBgMxUVMB9kidgbeMRZiFnf/BrkUb/3DoMMdQAZm8iVw
         2nzAMAhCZHc9U/8q1YfBIDkP8X1hFRbXiQovbzNYLEx+E7op86VU+L0RQVs50G7J90Lc
         1G5CwuhJb4DY48ZBmS+paasqoCG0BKbPPu5OTLNXQUlEwXHXkDqrgKPS+gtkBIokAtN7
         IALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237666; x=1742842466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTtaX3vhSb5G36KvfqVCTP+WKBznUgLh6K0dIke/e54=;
        b=bX61LRlSrRWsae94TRme5+Gq2AOPk9PbBQc2gHTXM+BPEheXJ5a7O8AMTcjs1FhLl5
         LgyYXgskv1oqzBmJfG6ESe6wYjW0TKbSWJwCtI6ALfm+cx7nFQvBZkcyi7V/Xg59yv5C
         06S10AQyiVBBxFj1BwLkvqRSOwSgornzet6Yc8PZJn10fOTW57bEKKrgyUVNBZzDlxvr
         JQZbiMNSgHDyexCZf5ebWt7liB9THrGG8jDjP/gFw06sfWNAwu7Iql8IDPxd98JlXIkg
         uYrWP3WDbh1g2/IOc7qrrR7yClJL+i/3wPxdcX2YAQmt2iKK7S0qC2yGyjJ54HolgFj8
         CHtA==
X-Forwarded-Encrypted: i=1; AJvYcCXgBxIIwWJb4vhZ9oW3gfnSH9fyowOkSIu90hScTueAs3hEG5W0lGv7D3+D68NVjhe4DmnMTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx726lcactd8pSSj6GcBePH1i8e/+jq0CN+ftBSj+cawBh/42Lq
	SLKZDyhdFBEP7d+ZZksKcKLdTxZN5RQg5/ZggvbbCxBx254f39cn
X-Gm-Gg: ASbGncuCe4FtDv+mrbhTG0eRfSl686zW76oN1HPaQ3olesAp2+m1xq0uomh0s4spJUH
	rjiwe7hfIUd+yzxcRozHPFtR2kNV7kYo5XMU5N6q5T16nB5MkQ2OJFcAqW1iE5ndwt3flOjNJ6o
	Ww8D3QpntaJRVQktZetQsyaR+7l5pVs/BN2aNGCUSfO4ixRs5o0kWQ4Gcj/ET46KacYX/cJXqca
	uMScGRf+rpyQYNRtUXqJeVKiN7PzDkNh+VEcgKWIbbE0qel5zov+BmUiLaYx1k0Lmyf7uPgatYr
	m46MtZ/vdmSshgf7Vr/7ZrZNWIEdfxftU0lfVh1f3BiXEhjkzXKSQ8/i9RR43Zg0/efsK4W7ycO
	i2cN1d7TEqosMsGNQ5Dw9zVgPvWicaavY
X-Google-Smtp-Source: AGHT+IFLi8eIWmNCR26IQ1ZzNqzF+yX5evRGaLB3kNs6XdGjVB80bX12ukMhk1Sq94RJg91f1Bo3PQ==
X-Received: by 2002:a05:6512:31c3:b0:549:8f06:8225 with SMTP id 2adb3069b0e04-549c39507ebmr7288403e87.53.1742237665546;
        Mon, 17 Mar 2025 11:54:25 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:24 -0700 (PDT)
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
Subject: [PATCH v15 11/11] rust: dma: add as_slice/write functions for CoherentAllocation
Date: Mon, 17 Mar 2025 20:52:18 +0200
Message-ID: <20250317185345.2608976-12-abdiel.janulgue@gmail.com>
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

Add unsafe accessors for the region for reading or writing large
blocks of data.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/dma.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 6d7aff6b360a..027ef75a461a 100644
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

