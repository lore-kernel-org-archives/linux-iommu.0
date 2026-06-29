Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998934166B
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782763888; cv=none; b=jJxX6UZADyvqxKqg0zDYY6f7MbMvNdRw4zSpY/C9k0N6N8QjeBwo1l+RVDYRtytn6yDOYe8nuMvmGCdErZpPo222Coix8KkqBS4rJ1NpEzQkAp5/PePlwawGXwPMl4VNvxMHaU93CI0xeFs/GMMDEfo5ClGh/bMPqPO3vG8213c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782763888; c=relaxed/simple;
	bh=eFgUeCGEO+qOSTEKY7myebbnHBLHZB0M4el90BZqF+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnQgcVrYrZECLLA04+H0ZFKJlVkx7jzw2AYTxvd2cqe4rKMSmFFhvElYhNXowV7BxAyBaUcnE/g3Z+dENY3jNJQhEQ7X+Mz66g6dsLT7AXDp+od+t/C9i4l77sRv4oo8DrA3KnBLaQQcGeHKab1kiaftF96lqPfpUpuHJb7yYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2o45hZv; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2o45hZv"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13809223fd4so4567732c88.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782763887; x=1783368687; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=juwApRqdf9ZN9ohtGGzCpOWWFQJmTGs8EU4cohU1bSY=;
        b=O2o45hZvd/jVvLV/eWxCSJVPgdy4Fyp7toTDhWQhFJ1+rf3zcV2yQ4J/ZORqNiBi8C
         csdCZEKwofePpR+Spa6iD/JHzEn+O/o+DWLte8RJ4fp2c1vlPyuK9TlvLI6xdoj3RiXN
         tl/dOHXT/5NFbwEs5N8cZhioF4+GJVJx2zoEfnNp0Cs7VzHYzLExHn1jStJ8JvqNRp88
         jlJnWRezA6tVPw0tAfp9FO09jmo6huHbPD2Uj0+IGAwv91nXtMuTqYxTW2X3SRdomAmG
         91Si+RnANZZon5mebklmrwTZ3vy7UA44zoL+/Pduf5yOXrFlZqfEMQTgkdXOhOC9yAFc
         fhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782763887; x=1783368687;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=juwApRqdf9ZN9ohtGGzCpOWWFQJmTGs8EU4cohU1bSY=;
        b=jGrAb+6bpkeKWWayqWQI9QR8asQUI5BGC8VOlyMfarqSzQ3LNmAffFxBMc6awogWHm
         YE2gsGFwPEaYQe9PLASx3C5LqAITASM03OASEy/osC+rsKIkGWrmwHLIlMxlR7dGgIiX
         A2OKMlpE2FjWUeqxg+R/mWE229BrNZ0bb4B4oEOZneFthtBs+9ymBSkG2cNeMxf+20Xr
         YNcAAo45mzh4Y4AxBSJcdXkcgq+BiisLJc5dWMnNbhWXc2KYn81eBImRSxEJy1NyQt9R
         O+9N0aQxREjGMgJ0tkjRUlYMK0MARSABZjNEF49OufjQdcD2c2MzQYZU/Aw2uASoRU3S
         kd+A==
X-Forwarded-Encrypted: i=1; AFNElJ/RGtrniJfId0G2nj/LSeImRNsEZhU/FwjvG9ytduqVTRwf+yYfNqgCDAggmfnfnhoprxakKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDmwgL1Po23Bd3NMcQC8idwuxljTfhKUs5CSHGTARtiK/xvxBm
	kCxLryXDvGjM376E+7L2gaUdf5U0UWnD5LWcXLzQBDJUQESxf7FUJl4=
X-Gm-Gg: AfdE7ckmE/OJFictghp2R/YCgHWzAHZCYT3UbW85iYNmWeSeV02x9RDkFTqZvh8fohH
	cO289XYKRSHuxZNz96MLukNWA2Dx1kss4ffhWAfBuYXv7tohhAOQbwHveyLyaYfQvwjf0dBSf53
	dvI3OWaCPGr8WW5r3wGEp9JXsHSENGpDedfyTFgN4OfaAfNrBMtMM3G603A8YUQoZRIDcoyOL+3
	GkV/nklX/ZXYuxr24FiiG/6vwgLJ0tSasE2D/Xn3lX72UiOQVCUru8snwJJe6oGLimN6K+ti58S
	mv8X3RlOvXW97th/24vx6U4umF2L85sB+995dILU6SLF5636nbdizONcocugJO6EWWW0DdZg7ts
	UiJBTIAjNr1tKt54nIDQNChidT4dJcd9aTbiwsva6P7Rj8zy3bCZa9KbkKQjtEEZtOAJLOTCuyQ
	ZSRRFkvAGpwQ5WPUHGiTyxGnWUr4ZJXblAGdc+5MwlVi771yQR7novWm7CYLozvDt8
X-Received: by 2002:a05:7022:1603:b0:138:916:5179 with SMTP id a92af1059eb24-13b2a1605d5mr498783c88.14.1782763886832;
        Mon, 29 Jun 2026 13:11:26 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2a9b425asm1150598c88.0.2026.06.29.13.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 13:11:26 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2] rust: iommu: replace core::mem::zeroed with Zeroable::zeroed
Date: Mon, 29 Jun 2026 17:10:41 -0300
Message-ID: <20260629201046.423464-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can. This enables
using `Zeroable::zeroed` for `io_pgtable_cfg` initialization instead
of relying on `..unsafe { core::mem::zeroed() }`.

This change improves readability and removes an unnecessary unsafe
block.

Link: https://github.com/Rust-for-Linux/linux/issues/1189
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Changelog:
v2: replaced `..pin_init::zeroed()` with `..Zeroable::zeroed()` as
    discussed in v1 thread.
v1:
  https://lore.kernel.org/rust-for-linux/20260626203122.713317-1-nico.antinori.7@gmail.com/T/#u

 rust/kernel/iommu/pgtable.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index c88e38fd938a..eddda8d9d62a 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -102,8 +102,7 @@ pub unsafe fn new_raw(dev: &Device<Bound>, config: Config) -> Result<IoPageTable
             coherent_walk: config.coherent_walk,
             tlb: &raw const NOOP_FLUSH_OPS,
             iommu_dev: dev.as_raw(),
-            // SAFETY: All zeroes is a valid value for `struct io_pgtable_cfg`.
-            ..unsafe { core::mem::zeroed() }
+            ..Zeroable::zeroed()
         };

         // SAFETY:
--
2.47.3

