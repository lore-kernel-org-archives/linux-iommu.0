Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98D19DFA7
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854493; cv=none; b=nPuxoPpJPhr9DEmKQEbCEGCHKDxCW8yQKm6PHBW5fuyRzvGKvyZjOoIt82k64LiWajh5oCwR52gr4jzz89hM1IlZY4/TrL9hv6K3DSsFWaFRbvcWQkZiL2cDvcpT+/t4ulzV5EV71Xc9/y+qcPMRoZ6bMSVc/hy4trmYTH5bd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854493; c=relaxed/simple;
	bh=MLcNJDKV9gsnJnU6fEk+vYT6E6DBe92pvFdpw4BYUG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wm6On0FDI0FrVAkF9aU/LCtmTFIg9qOPz5GzqeGJ0CM7Yne7LpNACbEnl81qSf4/Uavj+x+lJZLc81icMQIQwrDn2hYFzUAVVwLgym1Se66216Bzch7N3GwCesCZLDnSr7Hn2KEv+k9AgYUiTW/2IGW55cgC/JELNhvfGEkiGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBySfhHY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBySfhHY"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54e816aeca6so5384941e87.2
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 01:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748854490; x=1749459290; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+telj4p6ynVQKOKj6b/gndQEjhkehuFQNwZjD1BmKc=;
        b=CBySfhHYB4EqYVyvKcVvFabj8bYL331R5kT8vkrrWss2nyw9iosHcGCe33mJTbmKK3
         bR0QTzURmlXMc80G9QpyReHGcZN9aWtKs7EriP89z0KWghUN7PhqqWyF0yFqM3G/0K3B
         zj0ytVTwPezvNk3ZvGtWwEpkCS0TRQh8biBBDcy0zttmVBbu0qx7S0rFPy9MC7r+PSeA
         HymhA46cRTWKmd0ZTzGq1BstbhnWbfyQJn+AS++c5Kytg5ieTd8m289rt4JdSPlSCSkS
         Kk5PloPK8nxUCt3D0DKG9lLUCGhVhzMJwl3eCWGMAM4Jl+sgO04k36Y55Nl8QLxtEGYK
         UAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748854490; x=1749459290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+telj4p6ynVQKOKj6b/gndQEjhkehuFQNwZjD1BmKc=;
        b=EqP2YPYiC97E0eiyjlj1Sjm/8dQWVHWnUNeqXdfZYwfEHSdOZd0YieHa+wpIhqY1Dc
         YTgMgCJRJIgjmnxcnfVNl0BzI9aJSwYPUjkXMRtap8fKdfjtkBuIXu09pf9WOeHPs5IG
         P+Ku1KEgJJ8wde7m1clcSDTeocmwnUBzF8u8abnkdYk2ogV7xSl3rIuCXIp9fR6jw17I
         gOiga3CK1yOnapOtfM1bem4zHJJ3Ss/gwZ88J0OB0WNQyhEyvJ4vA12jmZGqxbcXktGA
         6wrsl0+pvUpdNMkOxkODshU/XcRj8Sqy9V1VEOft6d4/I8Xv9sWk4xg+5pAjZRa3iuUb
         RenQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa9XrCTS88q30jzhPaT27BHOGC2BObQpGbaYvjgt9cTztYPMrWgYAQRy+U+Fud6B0FyjEt8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx74zS4hdUJ2JwC/dO4w2t7SLEzohctaCbdyVHxDZuYUUr1qNDn
	/keop7hmhMUmXjTiOzB2bB+seNHtFzsyrXtN0UnHh4/5rApHyIxq42zG
X-Gm-Gg: ASbGncurR6aEkRKGqndMcSqpvYYEpth1RTjaqGZ91XLDRAeVtZ2wKP7NYLtZVeSn/+n
	83qDdUw5DBIu2Af/0Eg+vZd32RTjOPP84eAizIyOD4+Ur26I087BzBErtgCLYmmpgnYsgaePyNX
	mXXB66PNzR9mYbefjk3LWH6hPUlZ3gaGhvoranlFPquN/jR0ZGFrFtptRkUx4SIGjT2pHtSxZZW
	j7g3mjTwFLwSGlcn0/mh+tlPJ8VWslWIMQ9V+2jaGLthT2JhHqiI2SJzvgIZRzCA62xwarVFRkH
	8Hfra5Neoaaa+Pg0f4ryollDz9t/0B2QU34iYNZ8eug9jxsu1JvyzFfCSTaeXVW9LHvOVN1AwAz
	PaVquOSRI9M5WfT37ob/43HspYZgO
X-Google-Smtp-Source: AGHT+IHo2NQcKatHJHFatk8XSmAeedAW4NR6jRllJ8AjxcE10Os+h8aPokKup1yOp0ML5QiCKq5SPQ==
X-Received: by 2002:a05:6512:23a7:b0:553:2668:6f32 with SMTP id 2adb3069b0e04-5533b8e0fccmr3937492e87.5.1748854489451;
        Mon, 02 Jun 2025 01:54:49 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553378a13basm1524325e87.81.2025.06.02.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 01:54:47 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org
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
Subject: [PATCH v4 0/3] Additional improvements for dma coherent allocator
Date: Mon,  2 Jun 2025 11:53:10 +0300
Message-ID: <20250602085444.1925053-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
- Improve document clarity and move the range checker in as_slice/write
  to a common function (Alexandre Courbot).
Link to v3: https://lore.kernel.org/lkml/20250425073726.1027068-1-abdiel.janulgue@gmail.com/

Changes since v2:
- Rebase update, add fix from Alexandre Courbot, commit clarifications,
  minor sample driver improvements in error handling.
Link to v1: https://lore.kernel.org/lkml/20250410085916.546511-1-abdiel.janulgue@gmail.com/

Changes since v1:
- Pull in reviewed-by tags and include links.
- Improve error handling in rust dma sample driver.
- Clarifications in documentation.

Abdiel Janulgue (3):
  rust: dma: clarify wording and be consistent in `coherent`
    nomenclature
  rust: dma: convert the read/write macros to return Result
  rust: dma: add as_slice/write functions for CoherentAllocation

 rust/kernel/dma.rs       | 150 +++++++++++++++++++++++++++++++--------
 samples/rust/rust_dma.rs |  28 ++++----
 2 files changed, 137 insertions(+), 41 deletions(-)


base-commit: 7a17bbc1d952057898cb0739e60665908fbb8c72
-- 
2.43.0

