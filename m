Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26133264A75
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715409; cv=none; b=nJ6cyUbyo7I2cTIxIYZTyRPlW5s5UcVQEsvyQ/bdaLg/UagxnAId5TrWaqtdWBxN/m5v2M5vJDalpzJ66WvBfqSVoIDXXPJnB+hcxXKFeBxMLaBeerwt1DLge2+zE+ZqpddHrbSJewtTTgLkd9Mp8FuDx7vFU5nMFKKN8WUGWJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715409; c=relaxed/simple;
	bh=TcpoD/AzioVcQ+RFPHlw+D3njSBh1aynVEy/vrcfm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6uLfFKEVcyfsnDrKJd+FszixSuEtTh2Z8CqVhE5wWZRtwskCCnU34kQ2UwIXQdRETxDfzUZwqKAVl57BVNh8Fm92XHP5Xlo/k91jgba8L1damjDgvBg7zgXoVuSBGOsM3an6udirSB6jlH1FtgEy1Hu0+/FwBOphtOmLS4dr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz+2Wsuw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz+2Wsuw"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54954fa61c8so6136678e87.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715406; x=1742320206; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=Cz+2WsuwPcBuUxNi4qyla+FrhXGX9swHyaWSQIQ4zSZ3BiVuqPWiILBvYttKjvUwJ6
         5eVCQ0rqfEaxmI90Po/+GIWmbwgi0yV8yQg251RFQc6+VJ+wcJIkVhbT5VgMSwH4KROe
         9hf2w8gUX6sCpjprJcO+r2BGqIFS5aavAwunGAiYvhqilA3tEGUgfnrMKzmpbCjsY2dS
         +XPr3dCQw/M6uGW/40WZ/IdV3D+rsLLGl4ngy30q9LUrh4AtP4FS3ghid4jEkD+2oGnG
         Sm49cWhqC396+Gn30IAhy8K6a6ej/r75cLNX5FrWoc4iqVFygdrGtw7m0/p9IxUa4Gqk
         ClRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715406; x=1742320206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=vjvMb9WglniOmGPT6Mn/Roc97pFOiGYuYKO4iO4HBjuyKzQ3tGOBrI/OU4cBGjqtWe
         ByJml9HkZoDsd0VWboTstsLy4OZDGV081WK04+uCfFCMocTr+E8HaLI7aZtHULbFVFhJ
         +1xf0FYb6MZtoCvgXatDzdQq1xD0vuFduVaLMw1vQgTt7oqvCmCbPUVrA2QivBoAA0KJ
         oqyLL8Yp8b0imLoK+XavN3uncYQ1oiJX3Amfp0Ug1NrdB3PZ9SJfm83zGpl97MCRZiyd
         YmW9K60CGfzLUOZVgGBJsePUQDXvnx2azIOxHZyvSLC7aqlPDMkZjW6sz0rFaIgS4DQ7
         +k0g==
X-Forwarded-Encrypted: i=1; AJvYcCU1HvGnD0A+UmL517DzxJ/r2rukIRZ9ocaOijxjywMSJ5iwMo5nGsGr3eOlpJsE1H71PcqBfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrWqmTLTTrgBBTZfNfI/QTCYgDAb22GI624QgL04aRL+d9aDKu
	PWaNDbalaIbbNsbvdiB3d2f+xMo8BySEDlsGHtpsIBMHonWz/4dd
X-Gm-Gg: ASbGnctLUnCfzIu8ZtBo2eMvJBkZT2Ij+9A8X94TV7KKTW5jzhG9KEJd0UTIv8HhgSi
	pDU6KkVqKVsKxA+na2RJeLvqtnVtE6NrOXxPM8wPiSfZo4u1ouEPOros2hiqILSrsvO/OsmIxBO
	b049UHIyqrffNo+hqOx5M/SG1UYli3yI6PN1QbE5PJIVDzqBcojrLFwmdiHG3ILhha88V+2Gw4p
	3rjN5EEz5rgsFLzbDVTfQcDHW44Yj5D6v26tTdmkP4v2xcV9F79vfOvEKzUqzW7swo8rjrWmTCq
	G8DctEwZMoIIjrZhn3i1v00IugMDzjKprBm2/jQSbktVIwjkeunMgYD+iVv5flB1ppCVHl5yWIz
	GUrlH1OJgoy9g2AnSM1vHOw==
X-Google-Smtp-Source: AGHT+IGq9+9j3TLKd4ZMF0Hv/jAhadwI+/7rJ6RpYAMlyrkjAtEgxGTE8Fo3X2gzmbXq68ctC7l0Vg==
X-Received: by 2002:a05:6512:ad1:b0:545:c7d:1791 with SMTP id 2adb3069b0e04-54990ec158fmr7085373e87.43.1741715404978;
        Tue, 11 Mar 2025 10:50:04 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:04 -0700 (PDT)
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
Subject: [PATCH v14 10/11] rust: samples: dma: set DMA mask
Date: Tue, 11 Mar 2025 19:48:06 +0200
Message-ID: <20250311174930.2348813-11-abdiel.janulgue@gmail.com>
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

Set a DMA mask for the `pci::Device` in the Rust DMA sample driver.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 samples/rust/rust_dma.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 4c7ebf66647a..39b6050aa3b6 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,7 +4,12 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
+use kernel::{
+    bindings,
+    dma::{CoherentAllocation, Device},
+    pci,
+    prelude::*,
+};
 
 struct DmaSampleDriver {
     pdev: pci::Device,
@@ -51,6 +56,8 @@ impl pci::Driver for DmaSampleDriver {
     fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
 
+        pdev.dma_set_mask_and_coherent(kernel::dma::dma_bit_mask(64))?;
+
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev, TEST_VALUES.len(), GFP_KERNEL)?;
 
-- 
2.43.0

