Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD92153CF
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345718; cv=none; b=ZBGtpCb7+iHZlCin7ZNy4ZhtQvjOApoMzH7v1k3y+Ob1XWpTgiISEEJ1whP1lgBmC9yeYghISeQcEOZdNgBUNK98HfXqvgDWi37aOSYQ3j+uz1L+fLG/s2aIXt5Plxk+1/KIXiVwN2mWdYTaTzWfllJE20GtsnunvUec/xI+ajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345718; c=relaxed/simple;
	bh=jMCtgMty8Xj5S+wgAPSjJqGBcyOB8F6TpYrMc2l1nJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyGwty81knv9EDgOCB4GTzSEGzhMvUplmQoa7AK1jxOwCNFt8rRfgkP2QT+b310zHv5SbIdDaL9fNHocVPrBdQDvkn6nnNYA7LA9XAHAMqlJc18BLA7in5Z2YcazgSbH3nfPBBFYIIe5LGFgeCrD+mdvv+cW1A972CvDWTskS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7vorI1T; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7vorI1T"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5496078888eso1978068e87.0
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345715; x=1741950515; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goq+Rv5UchdtTKanUxqHPoTKyKgnqXI7XzQqTTMH450=;
        b=F7vorI1Tz2bSjcwUY3V492PGPLwrmKB0g7epHJlCHFRnD7r+liJNQ54U2nCAdX2/uf
         Z5yxmSGdtj+9JC9KsI2dD2CptAkjVdPJwTZWiZKT3MvrDlnUQCaMF2jjs3XqzNjTkVlv
         BB0/XUCDGuIOgm/zFdvisO0f+0bBxvf+ajSrIhnX2goWymDfFm4aNTcT1E3nb50+/q97
         vw6+gRnDh44zDKLps20wCISRYErMLAwEudy+QdwlxxrajbBxBQpxhOmPKJL/j+KwsyTD
         d6Rgsp/zbCa7sxteuFVjX1xKnvZHSnOJLdU+b7chVLxFOqqvsFAP3RLHBYxch8SCvAUX
         8iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345715; x=1741950515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goq+Rv5UchdtTKanUxqHPoTKyKgnqXI7XzQqTTMH450=;
        b=lz1or03J6OgRtD6PaAfK6LnfVW8Ak9sVDZTiXp6zEFE5M+sVoS7TsVFcRprqqunvkV
         okaAIKtw7p3PH6o2KofuaE4cM6vm/OrMysuD5ETQBIdDfMYbB+gLn6DQmMuymgEExTkM
         sEIPRdd7kMQTEQTGNyBPCmMfuQSLnOYxHw54yO1PsRz+tnGHBZU/xNYK/+spVLo+gEHF
         XlS9d4RLq91ipdsQi48N9Sve99d8A/5pAy+GmdJ0XTO7/ExL5+ruuHikNbJQHKBMizKp
         6S8wjFUpc+nE1+oUjCBqGwE/ULigs+KIYU+D7D7B6gHB0weK71Qe91SbEJEngwRmibFB
         FbJw==
X-Forwarded-Encrypted: i=1; AJvYcCV6nR+RLuQwTNdkQEW75X0YCZ2HMc/ET5cJRk9jx5IfuxNG04XG3AIcoOFmzo7a95d91sIT1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW73mvWpb0fiDnEqXOz1m/h6SEdazERbTsYIEWjuZkJAkixzUz
	KTMtrcq2VcPcVgnAKK0nExMdnQlnARJ1QdKF8GK6jdinQPkrOte1
X-Gm-Gg: ASbGncs2vpp2O6cd6QgLsMI6MG1uWNkI1vhdJ3r9WJOFZAaeaD1BtE0E/66evKAO/DO
	lCBIEb+0UfaNDnPyYabx8SJJW9Oc1nXCqqlm4xWtwh2+ikJ5fu7xkXyLsN18F4nt7yqQp2z14OJ
	mwVYP38OveKs24zw7vlMX8uEkYg/khjVaeX6XTZMr9CIARaso4sPfnpx6e6PHMtoxh9hng//Ocj
	990qpXFtUlGX6EghR5eCKnujq5IGt+86LzvcYnlhsokWvUYxc58Mr7g9Hrkk+PB1GLfCt77VuQm
	4FlUNjRXqfG9rQqRNCLd8mw4k2fDK6QXy2Mo5oQsda0IujYqgdQQJh1UVS9m3gEgEJ4WPUs19Y1
	sOjP8r8GX5ETo2utbxOsyFw==
X-Google-Smtp-Source: AGHT+IHivXfHpJ/MkL3ckqcRz7Dp1glsJZvC43jbwp51OZ0izhWjLDTusmZgB0CbVNeM12vJynXOpw==
X-Received: by 2002:a05:6512:224f:b0:549:9078:dd4a with SMTP id 2adb3069b0e04-54990e5e0f7mr929157e87.14.1741345714361;
        Fri, 07 Mar 2025 03:08:34 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:33 -0800 (PST)
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
Subject: [PATCH v13 0/7] rust: add dma coherent allocator abstraction
Date: Fri,  7 Mar 2025 13:06:17 +0200
Message-ID: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds the rust bindings for the dma coherent allocator which
is needed for nova-core[0]. For v13, the biggest change is to move out
the as_slice and write helpers for later discussion. The object is also
now wrapped in Devres to explicitly tie it to the lifetime of the
device[1]. This is tested on a Nvidia GA104 GPU device using PoC code
which parses and loads the GSP firmware via DMA.

Changes sinve v12:
- Move out the contentious functions: as_slice, as_slice_mut, and write
  for later discussion as a separate patch. Make write unsafe as well.
  Remove skip_drop, use volatile r/w for field_read and field_write
  (Alice Ryhl, et al.).
- Documentation improvements, use markdown for intra-doc links
  (Miguel Ojeda).
- Move dma addressing capabilities to a separate patch within device.rs
  (Andreas Hindborg).
- Add a simple driver to excercise the basics of the api (Danilo).
- Link to v12: https://lore.kernel.org/lkml/20250224115007.2072043-1-abdiel.janulgue@gmail.com/

Changes since v11:
- Ensure robust handling for potential pointer arithmetic overflows
  in bounds checking (Petr Tesařík).
- Add dma mask helpers (Daniel Almeida).
- Clarification in the safety aspects of the as_slice/as_slice_mut API,
  Use ManuallyDrop trait as a replacement for into_parts(),
  Add dma_read!/dma_write! helper macros (Alice Ryhl).

Changes since v10:
- rename read() to as_slice() (Boqun Feng)
- Do a bitwise copy of ARef<Device> in into_parts() when returning the
  device reference (Alice Ryhl).

Changes since v9:
- Use ARef<Device> in the constructor arguments, docs clarification avoid
  manually dropping the refcount for the device in into_parts(), use
  add() instead of wrapping_add() in the pointer arithmetic for performance
  (Alice Ryhl).

Changes since v8:
- Add MAINTAINERS entry
- Fix build issues due to switch from core::ffi to crate:ffi in bindgen.
- Ensure the wrapped attribute is non-pub in struct Attrs, declare it 
  #[repr(transparent)] as well (Daniel Sedlak)

Changes since v7:
- Remove cpu_buf() and cpu_buf_mut() as exporting a r/w interface via
  a slice is undefined behaviour due to slice's requirement that the
  underlying pointer should not be modified (Alice Ryhl, Robin Murphy).
- Reintroduce r/w helpers instead which includes proper safety
  invariants (Daniel Almeida).

Changes since v6:
- Include the dma_attrs in the constructor, use alloc::Flags as inpiration

Changes since v5:
- Remove unnecessary lifetime annotation when returning the CPU buffer.

Changes since v4:
- Documentation and example fixes, use Markdown formatting (Miguel Ojeda).
- Discard read()/write() helpers to remove bound on Copy and fix overhead
  (Daniel Almeida).
- Improve error-handling in the constructor block (Andreas Hindborg).

Changes since v3:
- Reject ZST types by checking the type size in the constructor in
  addition to requiring FromBytes/AsBytes traits for the type (Alice Ryhl).

Changes since v2:
- Fixed missing header for generating the bindings.

Changes since v1:
- Fix missing info in commit log where EOVERFLOW is used.
- Restrict the dma coherent allocator to numeric types for now for valid
  behaviour (Daniel Almeida).
- Build slice dynamically.

[0] https://lore.kernel.org/lkml/20250131220432.17717-1-dakr@kernel.org/
[1] https://lore.kernel.org/lkml/20250305174118.GA351188@nvidia.com/

Abdiel Janulgue (6):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  rust: device: add dma addressing capabilities
  samples: rust: add Rust dma test sample driver
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API
  rust: dma: add as_slice/write functions for CoherentAllocation

Danilo Krummrich (1):
  rust: pci: impl AsMut<Device> for pci::Device

 MAINTAINERS                     |  12 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/dma.c              |   8 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/device.rs           |  29 ++
 rust/kernel/dma.rs              | 464 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |  11 +
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_dma.rs        | 104 +++++++
 12 files changed, 644 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs
 create mode 100644 samples/rust/rust_dma.rs


base-commit: 6ad64bf91728502fe8a4d1419c0a3e4fd323f503
-- 
2.43.0

