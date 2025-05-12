Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6B25E478
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043783; cv=none; b=Plp+KOmXGpHOcScVW+RtvPsOHlkKWTzoYSI5Qywqr/bslpusmk+bDBw70bGef/3Hf2Sxpzjnr8Irncl7ZQzXs0IU+Nb9oQQ++H0mmbdC8kCkQNsQDeiCDWbyZAYM0oPu/Oj9WBU2xTGsCC9WG6iQ2oV696tLbeNpBKeI28numBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043783; c=relaxed/simple;
	bh=CXSs7qlL+ovSxslTb8/w3rSuLo2Zvof57vQkEI7kgGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npKBQDvFQD/cB9KXVCcD1Uh+fNhvIv1cCU9Y2nCzNLANsMVd8tW9Vak5xs+qDFQchptOT+oWagdcNmd18gwiGEYpoOikgifK9OmeMlUjBG3lsyEq8mxkuPEMU2W93JXuWhSh+rFKwC+NZQrfXMEnWQtZTCtUNAwMc7sLesdLd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGK5Jg3C; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGK5Jg3C"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d6f93316dso5368949e87.2
        for <iommu@lists.linux.dev>; Mon, 12 May 2025 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747043780; x=1747648580; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lhhLHV59fpZK8mISaf1NFm71EKTLsq0mDVPXUzJQys=;
        b=ZGK5Jg3Cr0Klaju7E3FrmWRXehQFnlTdOq0bB9s6dpzclyuL2ZacakKMKRENf2e9O8
         eezIBu/mFAazWj/WDmHea2QzMNM0yeDw/MWujpXWuIbD7VLYR2oVN+phiAY+XRSGSyPD
         5Mwr6VLjAUVtPfLbAhN14Wu+Qfm7SJ/ub6jQuH4lE2183jt+HQ7wt6xryUSy6U8QEQC+
         V1OGxLidD7YhHaxgz2d/UNmtFjWU4HI+uIkzKCoXswbiFyjbsKogT6P7kZGz1p7+TFZM
         0t/dMOv9th6v46kYpoNxepLPHr6Qq6aZrywre2ChOno6ODmqDNmyjq15H0Enk+VSgebP
         Mt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747043780; x=1747648580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lhhLHV59fpZK8mISaf1NFm71EKTLsq0mDVPXUzJQys=;
        b=aXPRxY8UGi6HloK9zzpWPNnD1cVtuFmHhCNlT71qFhBI4KOp/6HDNcyn+UaBsWers1
         zPujEcWZO0eWexhwECSxa+YBUmip/HpDshRZzU2fbbMX+ARERiCTC1M6qXCOqfAP8GnG
         Q1u+gApEOaeH7R80t1elnjg2Ikv5aithVbpDE32Vmz9K1CTlDzUJ3iUIlGiHqOBicpvA
         VJ3ep1JtrNym6er2vB1VElAGd55hubNCLksNLsOnxbiwM+7JcjpTm87A/RQdoefy5pAG
         fVwuAP6VqJG3TK6TPqlKrHLN/czCTwJWlzrOSt6Lh05pKQMQvFWwn/ra5P1VTASe2zI8
         aLtg==
X-Forwarded-Encrypted: i=1; AJvYcCXs9BtpAS9zf9JJQUZXydsYNkXQSZjLcVQP1Q9gCtPJCsHHze72JYCp2oM1d4vwEiFFWJ3B4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL3MwzLsz7U+YlLb3DD1jP43yhf7M0ftzLuRcPwLj4Si9NwvV6
	JdSNQEw1yHXA5G6Qq37r9DDQ9DOfBSeck+8YL8brs2ArIw8yE3O/
X-Gm-Gg: ASbGncsLVdkb5/bfF0E5H1GKcqBWXfGHZXq74JgYfrhrVc7xAUcrHr4zfztwmvWW2ZT
	wUQkUQvb7sODcx+NALxKMjgbwrlfx67DLrdczXizW0ohzmG2AzRCa6WZP8tx5p9a5CuSNE01tLr
	4XHRmAwhtD7cM7P/GlMYdNhBv/OGq+mqjgiMM910mTIK4lDT8yqkXaZ+6ubKtZUdi/6VJy0xO1I
	D8frcK8ogldblq87EkcTkTBBVDvZpH/bc+u79Y1s8g74HchiwF+z/5kHy3zlyRNJe3cyqfy5cwz
	+JNLuVoCCfi90A08bQX/ZoRdoIKKyLZY6nrckGG/tQvtqbGK0rzIgCEjc10obqSICRld1tiKXfI
	kOX80nqM5cGM3Wbkv/rain0I65x1R
X-Google-Smtp-Source: AGHT+IFI8TxoLK1NKbk3tvddAdOAbk0BUota4Fsp+CVn5FAlFmpMvZoBH1/nsB6nGuA5il7Ek1JJAg==
X-Received: by 2002:a05:6512:304e:b0:54f:bdf4:169e with SMTP id 2adb3069b0e04-54fc67ecec8mr4075048e87.56.1747043779735;
        Mon, 12 May 2025 02:56:19 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc644fa48sm1460449e87.1.2025.05.12.02.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:56:19 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: dakr@kernel.org,
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
Subject: [RFC PATCH 2/2] samples: rust: add sample code for scatterlist bindings
Date: Mon, 12 May 2025 12:53:28 +0300
Message-ID: <20250512095544.3334680-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
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
 samples/rust/rust_dma.rs | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 874c2c964afa..e3768c1a16b7 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,11 +4,15 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, device::Core, dma::CoherentAllocation, pci, prelude::*, types::ARef};
+use kernel::{
+    bindings, device::Core, dma::CoherentAllocation, page::*, pci, prelude::*,
+    scatterlist::DmaDataDirection::*, scatterlist::*, types::ARef,
+};
 
 struct DmaSampleDriver {
     pdev: ARef<pci::Device>,
     ca: CoherentAllocation<MyStruct>,
+    _sgt: DeviceSGTable,
 }
 
 const TEST_VALUES: [(u32, u32); 5] = [
@@ -62,10 +66,18 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
             Ok(())
         }()?;
 
+        let mut sgt = DeviceSGTable::alloc_table(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+        for sg in sgt.iter_mut() {
+            sg.set_page(&Page::alloc_page(GFP_KERNEL)?, PAGE_SIZE as u32, 0);
+        }
+        sgt.dma_map(DmaToDevice)?;
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
-- 
2.43.0

