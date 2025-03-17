Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC81E5B85
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237666; cv=none; b=j0aEA1IZ9Yntw6XiwDvZfqC3GPYsC9aXtDTX8yXgpPXzY6T3m7X0Dpba1bCOEDz1tIAdOTHBoVXhayJJx0uBkZ4EHcw+q84yvi0j7obRdBRSUGqu7LTlv8cv3AcrhNj6iwL7nyAtha981zNLUgx+i+RCmRjVXL09mUvT6xBj4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237666; c=relaxed/simple;
	bh=TcpoD/AzioVcQ+RFPHlw+D3njSBh1aynVEy/vrcfm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1ycokRMEG2mXefLJIRuCfOOcjaNWNEZiO3n2o/VV9EPrB/SNX2cendR6jn9FTwFgKGhgJRp/SEOOGpOdJK0uemDbO17rFNrs55ZmaoNl5+5hTFa+oarELpeYRsIdYlXzatMDql+2o7NM7n+9b87HL9fgSyGUK90YAF9Jj6s7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCL/DwJO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCL/DwJO"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54957f0c657so4973273e87.0
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237663; x=1742842463; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=OCL/DwJOK+x6los03rN7B/nv8aFlT/CZwZscLBjl5i/J/gQ14sOuojJyc4/act/dSX
         lmf0iNqdMB/LlmlBWGtAs57CK0SbZ3HxAuotAReqWlSJha+OTsZhon/xVedGxeloptiY
         1OybBoLCsGs4LpVKWX4xhc7YpWKmsFwkVKsMoaPQ8mLyzl4V/fyoqcf3Ug/E7wuoVojY
         w6hQhr9vfRJnvJ1csoV+Y78QcGnLjDPWNtoDBNv98FlAknYFzp6D6AE5jOyvG2AprmNF
         4T+vkqf69bMsEA7XTJllIcwmtldP9bt4tomfsyO+swNehFIROjxiV/FPuCqSrj3ODV04
         izUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237663; x=1742842463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=WphklUrkTW6t2JieNhAaMNvq/TpHP5y8mJPBDgHbfSGVZ70DZCipugjZsZ7SArMfeF
         zLqokiOTNS0ZfsCXFAt5wgaFN44osFjESx3J0/cfToE+EkdN4F2/jaccWRBpoar0WMhx
         4EU1eXo6rSVbBRI09fV4QY++4FPPJNRJpI7DBSAR7rR21Y7oPtNmFciAff3U4ZcB5DWd
         Rd0lE4GaJN29sRGEQ4UElPJWnQygJJZTn2BDIBJzGGhGvwuPg1LRTdK0SUOjs98mNUUA
         3iNOxYMIHsn0NTC6eprfkvHD+nUBXI6u50AJVB1H8W168YXya8mGxk4aZYB2dTp0MVq+
         sYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeCf9JMEg9vW0a9WdVCdlimVkEr9vUROGA9drkOF59Qs8+iP9agb1QsPZ5YWHuX8S3ltia8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYTQXDy+6nP1j/o/5P/hOjIPOevzrT2jaG9WiTvqEyfiRgy7G3
	eFv11AvLqL8ngRkxWbyP2kZiWpt4nEOLoxYkdrSThLTlxKts/ZE5
X-Gm-Gg: ASbGncsM60tUA5PiE+9iUbs8ZNV41xioszvA0uM2vdFE1GvlcSpfDy75j1woq6hXaDc
	tfw4nDH1Vp1MJqLPQE2V90xFZw8zvLNYsAeySNJbgUeQiwHrxkNHZ0xSrkc2fVNa3xIR1QTogIf
	DmjSdPf3kyqxyhbDE43k6idIMgAXrDoj8RDY0Y63WQcuouKR9n5BbNAKKyq2kvn+6Zjgi3dq22h
	SLaMHDM218es3+skAmeZTx4WZ0xhKxGE8p3nhhVkK/FhEof55prPoL/DkWKzgVLav15HLNz11sV
	n5pMNCdnsZvG05bYot6ww1BAGbJh1h1TjK5zCeGosVFyL3Jj+yvO4HYl4dBTxnPgzumgDp+iOrw
	j0igCnmFOPAN+0zIna2lyQ5fNjylQO38G
X-Google-Smtp-Source: AGHT+IEP/PtVThPCG47TCqBvS5ALN6nZRdODEw6SF73CDXB1BtRyV/+bQ0SZ49Nqf98pxWHzMjB8AA==
X-Received: by 2002:a05:6512:ad0:b0:549:5dcf:a5b with SMTP id 2adb3069b0e04-54a3046a9bamr523713e87.4.1742237662590;
        Mon, 17 Mar 2025 11:54:22 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:22 -0700 (PDT)
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
Subject: [PATCH v15 10/11] rust: samples: dma: set DMA mask
Date: Mon, 17 Mar 2025 20:52:17 +0200
Message-ID: <20250317185345.2608976-11-abdiel.janulgue@gmail.com>
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

