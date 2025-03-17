Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50E1E1E0C
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237648; cv=none; b=eDb8glgvJAjhDd0r2fMwk8LeBF0S3wuoag65HRoQnp7QnqzaosQVTNCfpIM89aPlblbc09HJRd/WzVz8IsenZ9CCZuJ8WrChZCtRTOSC7yF8OekSO6aqKdC4mW1b23YSWoQS99RC4BcwKhNjaGdU5zgQzrzvdrPxtIGfKwsp+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237648; c=relaxed/simple;
	bh=CMy6Htn4s7pw2UTjZOcIXbOpCuXHUjOp8J1cVhJZUqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rAdX+vF10xtPIeraRIpa+JPOztwoll4ES3eZhUtFXqx4t7Kb8ppU1Sftf67ocAiKPTX64S4VWFsc77AXftksHWlliqp+6adhatb+xOG2aQ5CvGKFOqxoAMwudvqR7ab0c2vHkDPXjurLJQLgGiHRnVJA8Zx0Jmb6zXeGZY9lRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndv3OkLX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndv3OkLX"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c2d427194so53250981fa.0
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237644; x=1742842444; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtbNOEuOEjHNv2vhsiXC9E25JUoz2NWq55PvharWWMk=;
        b=ndv3OkLXivtThzka5p5Ly1898vj6zca66tlFGhjO5Oc/SP9SSdIZ3e/Xy+aho4Zq/6
         4XVe4kGxXV25gvCNWWx4Wb76UR/2AqFReFYs17jDJndaSkAMVBdbtxhMh28NMZcSkYdg
         Upz8VqPSRqswYDLSp1c64j2kNDEkJk/ovSeaSZDgcDwStGUmCf4cGLNPf61FOxa9Mm/a
         t89hld6yUg1Oz+E0ayj2OiOsG/jZEkGOhs1vtvqSFhDZVmiQby9oWbyQp4WHXewKWU4f
         FY6U6VYH9RIT/YIGyILEjqi8w09M2FCaIPbVeKDOHyxb5V6Pbyz55QQvO6wXY009jgH8
         NPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237644; x=1742842444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtbNOEuOEjHNv2vhsiXC9E25JUoz2NWq55PvharWWMk=;
        b=DI7PMxXSatrcqbf6WBj1sWQ1acSpJi0rRjqbUgSjO5S4Ge+XAvBHVrFg+STDybvnqG
         XTAY7CqoUUqInkg7yYEE9hSqPvP7ucktwCu9ita1AvMflTROT1eglA/24MeIo1cAJnzE
         giNrTUv7lgEumILuJ9Qv7qMyNHZ6MWsSyCPAv2m07F6iTqvGh1Ei1FTKL3vVZnIxPW85
         sTSEiQnR7/iTlzAohj7SRX+UZT41EYTnST83b++Hv7KY32nD/qtC+6Y6sOxQhSdGgUE3
         Uv01F4n6N+4qNG5fRyaNV3KxunvcKj8wvkbzTlB+oBXdn2GeCZd3qMcdfBgcSO33SJL/
         6QNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZRnDfLO3eHZMrCb63y6VCsncs18hkoSTJHardg3ehKjZUQEcdeQKeTV8DK0JdtF5aEF+iNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxltS5q26G0pB/JOuGg3RdOfvmbnrfi7sSI7jXNTWlPnXCModMQ
	nbDTYcK1NzY1c4k2ISYgXrS2zcfN7VXYkw8QqhoEwLhKhQ4jvH2eEP1PNw==
X-Gm-Gg: ASbGncsHAg6Z36fv8pw5MDV1sl7/cJDCOfd9yx/woKiBxRXOShkYzeCN7sgkdg61Dvk
	/aNnkCz08mbNt4N8lCdSOL71m/BcfjpyJjnEqBIIn34q3H3kfBIDWa+NaUU6LH2xzRpQhm4pD8Y
	AOtkbXnVxBJSwl4RVFZKJzGlRsSNIEWngH8WH9tSjbD2BYRwYTz0SWAvNwlmGvWBb8XRCkJ4na0
	OlotOpHRzye/3JXrI305xqeNFgBqCYMCzS1wlp3Nx6ou86W15j264JgLEdnsMuX78qJKlL0SeJ1
	+7jqSqKPMDGHRNURA7LIknF1bQqI4wlDcPJwnYUZUEvtE8teCV50A4qfVx8563b7nNcwHcAuDjC
	P1F+qff9fBcSknVGAftEUzw==
X-Google-Smtp-Source: AGHT+IGoSQRk5CcCqyOI4qQPQSTtXK+3nYWthvMpLNR+8DqPYWaQix8LAJ8co054UfBYNj2o6+FGAg==
X-Received: by 2002:a05:6512:158a:b0:549:4de9:c23 with SMTP id 2adb3069b0e04-549c38f2271mr5564142e87.9.1742237644035;
        Mon, 17 Mar 2025 11:54:04 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:02 -0700 (PDT)
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
Subject: [PATCH v15 00/11] rust: add dma coherent allocator abstraction
Date: Mon, 17 Mar 2025 20:52:07 +0200
Message-ID: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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
is needed for nova-core[0].

For v15, document safety comments on the exception of usage on
read_volatile and write_volatile as suggested by Boqun Feng.

This is tested on a Nvidia GA104 GPU device using PoC code which parses
and loads the GSP firmware via DMA.

Changes since v14:
- Add safety comments on the exception of usage on read_volatile
  and write_volatile (Boqun Feng, Benno Lossin, Andreas Hindborg).
- Link to v14: https://lore.kernel.org/lkml/20250311174930.2348813-1-abdiel.janulgue@gmail.com/

Changes since v13:
- Remove Devres wrapper, document correct solution for proper resource
  deallocation as TODO, add patches from Danilo to properly add DMA
  addressing capabilities for the device which requires a new trait
  that defines the DMA specific methods of devices. (Danilo)

Changes since v12:
- Move out the contentious functions: as_slice, as_slice_mut, and write
  for later discussion as a separate patch. Make write unsafe as well.
  Remove skip_drop, use volatile r/w for field_read and field_write
  (Alice Ryhl, et al.).
- Documentation improvements, use markdown for intra-doc links
  (Miguel Ojeda).
- Move dma addressing capabilities to a separate patch within device.rs
  (Andreas Hindborg).
- Add a simple driver to excercise the basics of the api (Danilo).

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

Abdiel Janulgue (5):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  samples: rust: add Rust dma test sample driver
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API
  rust: dma: add as_slice/write functions for CoherentAllocation

Danilo Krummrich (6):
  rust: dma: implement `dma::Device` trait
  rust: dma: add dma addressing capabilities
  rust: pci: implement the `dma::Device` trait
  rust: platform: implement the `dma::Device` trait
  rust: dma: use `dma::Device` in `CoherentAllocation`
  rust: samples: dma: set DMA mask

 MAINTAINERS                     |  13 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/dma.c              |   8 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/dma.rs              | 521 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |   2 +
 rust/kernel/platform.rs         |   2 +
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_dma.rs        | 104 +++++++
 12 files changed, 666 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs
 create mode 100644 samples/rust/rust_dma.rs


base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
-- 
2.43.0

