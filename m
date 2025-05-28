Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A7A221268
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470568; cv=none; b=OcXW/dIEfV3b8tANhyrqKUrFcYQG9mLzY3eNxLBX0ijL4KBJKv6QYRXbQC0zHyHn23F5KaE+5KKz3G3AIiDxJHhsidC0KOlqcXy6u57z3Y2AHyEFfztl+mEeFe/o5SasBbYBHZKVBBJuQNP9hJ4G6sVQh67NxFfKxwiWe49QG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470568; c=relaxed/simple;
	bh=7gsOR0gNkU5/T2lBGTTXQjhgAghPoA/RiREki0cgJdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkYvRbY64tK12j4KpkEuPSPqMgTHwXwH6eLqXdkfSd2zGutGDQJqSCI9GHx++/K6WKVFgGsNY8LDUIkte2XDFBixnWTVSOy2SMdDd5hDe7Xxls4mbHyJ7af7y/b8Yr8DQEuot63iuKccxrO7WG6dyBqHlwUgUrjXPW44Tgu+k5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Qa+7HN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Qa+7HN"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so290702e87.1
        for <iommu@lists.linux.dev>; Wed, 28 May 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748470563; x=1749075363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Enihz6/HCS20B4CFOBmO5EOpNE5vpE5s80nw+pNvgk=;
        b=b3Qa+7HNR/HUcHdmmzp/KGmg6HxcjI+Z2w3ZZo6eFvH9CMKh6/XAbLBGhs4vqA1+QD
         ZM1iJe8kM+tW6czC/upclewNpn4UtOhqPSNpu3Bs0EXDb0bs1AvF7Eb2nee60PoxrC8Z
         BnblW7avlfd2yPoKQedmf7BBYGF9WrfBIAX+rBCocp7bcyexO2T+DCgy0eBq42DXeNcQ
         asP6qBkVL1q7fNKZVtMG74nd56gEn87aGN7vIM5oXcgddUPjxkAyY6lzsF8vVkc4emIT
         9KbAMGf5/pfcE9WJFaIKmBoLAC4aJ0ROGR+AQO3EBXFyW6vJtMfE8sw6eEWKGDkgcWYB
         7iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748470563; x=1749075363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Enihz6/HCS20B4CFOBmO5EOpNE5vpE5s80nw+pNvgk=;
        b=s8w18zaG0jAy+WWZrX1NEOM9rvl1ZrFgG3QkIMhft/pi3suSczlzHtiAg+aaMQkQvq
         ROkzbzT1MPoS+scK8dew9YH/JC7MPKlKcXas80XpSDU/IUqeA9YwalKNJu+gF7DmfvGZ
         dscsHTDfXgbdhq2e/Q9sylFe1R1KUM8/+IrlLz5jZGke7lIpEdin8QMX7FO3YG07zYOi
         T1cvaVz9b2+mAGmmxYgThsBpLLjb1cJ7aQwac/t+X6POtuSyXTk5u/r4Q5m/TcBYNwoU
         IDpnYyWx4LeU+shcx0v/EwIh6mZH0oSr6g3q6iCLcZRiVxD1mXU//E2Aw2JCoU+TBwPr
         yScw==
X-Forwarded-Encrypted: i=1; AJvYcCURwGhf9VTxU+BUV+jVqU8dmdYidfybHZ5e6gy/cKmVa9neWEEcEAADjVY4JAFRx9PEvUzeCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+BlL0ibDVBWdug1qXsBOX5f6H0x9TAmqsMFTTPfHCniwkrGXs
	gNZ1GO2ScwcpW1quHWIvggf0LYdHz0nPehxR5uZmGjpdhgIQDHVxDSrN
X-Gm-Gg: ASbGncvTaOdZ5hFrrPjBTdbOX1tPx0eUf4Ug+jNpg0YcIcbBcQ1M+13Ks0xyrlEAgUL
	+x2YQAIC3Ef1F40mjC6XP6ce0+3+SKOUMLUTvRQOc+TrmZqkqeEEYjJePwWN+NOfXH9ZBFmxaAO
	dcPpXS3MEts0JXSpRHlJ96rSKSNWJ+MPx4YuJEmIvnqqzWm/yTBoEj93sPo4HnVnlqFFy/xvFDR
	Bn08TBRDz/bRQoVUAU8JhHPu7aiEnJIDDnpaMI8a9MvyC3HRdvJSHn2dSFjKkYZH0zFv0T+LgX3
	w8IQY1HVyO/ItEtZbEyN6reWUCYw006hq4NUM/sn5Y0+/XLQMOO6FY60SaE3vjNZye5I8OW1vgq
	T5NL24RPIdlFiYThMqyrWmW7c3e2ImE43JiuBn7w=
X-Google-Smtp-Source: AGHT+IEKeeMrKUS/lOmd1TUP76CFI8k+PQghOOyWCL7sH6eA52cW3EaSl6yniwFeOoZuYVfomlK4Fg==
X-Received: by 2002:a05:651c:985:b0:32a:81a2:ebb with SMTP id 38308e7fff4ca-32a81a20f8emr6871911fa.1.1748470563272;
        Wed, 28 May 2025 15:16:03 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b55de7sm156911fa.53.2025.05.28.15.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:16:01 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: jgg@ziepe.ca,
	acourbot@nvidia.com,
	dakr@kernel.org,
	lyude@redhat.com
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
	rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 2/2] samples: rust: add sample code for scatterlist bindings
Date: Thu, 29 May 2025 01:14:06 +0300
Message-ID: <20250528221525.1705117-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple excercises to test the scatterlist bindings.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 samples/rust/rust_dma.rs | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 874c2c964afa..8c8f514bb27d 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,11 +4,15 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{
+    bindings, device::Core, dma::CoherentAllocation, page::*, pci, prelude::*, scatterlist::*,
+    types::ARef,
+};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
     ca: CoherentAllocation<MyStruct>,
+    _sgt: DeviceSGTable,
 }
 
 const TEST_VALUES: [(u32, u32); 5] = [
@@ -62,10 +66,24 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
             Ok(())
         }()?;
 
+        let mut len = 0;
+        let sgt = SGTable::alloc_table(TEST_VALUES.len(), GFP_KERNEL)?;
+        let sgt = sgt.init(|iter| {
+            for sg in iter {
+                sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0);
+                len += 1;
+            }
+            Ok(())
+        })?;
+        assert_eq!(len, TEST_VALUES.len());
+        let sgt = sgt.dma_map(pdev.as_ref(), kernel::dma::DmaDataDirection::DmaToDevice)?;
+
         let drvdata = KBox::new(
             Self {
                 pdev: pdev.into(),
                 ca,
+                // Save object to excercise the destructor.
+                _sgt: sgt,
             },
             GFP_KERNEL,
         )?;
@@ -77,6 +95,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
 impl Drop for DmaSampleDriver {
     fn drop(&mut self) {
         dev_info!(self.pdev.as_ref(), "Unload DMA test driver.\n");
+        assert_eq!(self._sgt.iter().count(), TEST_VALUES.len());
 
         let _ = || -> Result {
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-- 
2.43.0

