Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536031E9B26
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715388; cv=none; b=FV94E+oRpGfcMDq/bh5Z0+g9WwocGOe3nomck6lIvYcrRmGkL5XPWd1GRweMibXKYFuc3zqLFCC8nAGivs8ZyaAOg7b77ZZKzjtCgADG11DdSOUd2/8xIBpdb7m7BOSeAU9xqQ1t3tOVpA14oqcqtTBrHgiqEpwPIiMvnXhU34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715388; c=relaxed/simple;
	bh=I/BvJlbiSjp/Z5twciQAUeTVGh/qMdT3NWIHULDCFYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6Qh1ZUDXJQsgbkJpE42Y8bxT9ExXz4nUUQ2cpyTA+67S7mqOi7HN82BpOOOqH2ScNXDj1bdr2DaSyIiaSz73ELQiWtH8SmoQ5A1RaixqXityALd9svISjshHnL4rSh6TX85SBQJ5CM3xGKQ7zd2mask0olmPrXhZXnEvKp6Ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWHAl4ZQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWHAl4ZQ"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30795988ebeso61556701fa.3
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715384; x=1742320184; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+hnZybhDJXzPARLCusLi3xFhuAqO5UGHgXR0BOcXKg=;
        b=AWHAl4ZQ8O3t20TAYc2Vf5BRs18uplW5hADDf8vK51w2QFQpw6sPptF3Eltl4D/9Wx
         N2D1nzebLtE5ZO0Uu26aPHPl/jsGX7CVOEo12suPIuMhdwTN0sVViD/kgt27EBsBxI2K
         4yf2TUrvNHIV7OJUNgrLANSRd36JjD0pTR7CQ3uc+7ji2J5PckIXxKQh/HCYgcq+Iya2
         TLy3YfpgunQ4JvVBeHShI6zOqshwkFffmnVfg/c2fRXiLvYHcaxBzdy2uigeBOYCQotM
         DOyT+YDQClICwX5dy8U+vDRorwIt8eESVvvZSyA8WiDNuTRhqhq/RMlzGPC/+Um/oqr2
         dAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715384; x=1742320184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+hnZybhDJXzPARLCusLi3xFhuAqO5UGHgXR0BOcXKg=;
        b=JyUrirbKwKA3liziDs8dYAgVpDfiiqi4oV3tn2QNI0ThFzZ6Y/TQC8gjL62sGVI0qy
         5R/Qn5/T3a6SRHhJ6O5y6JE6V/KBfD4BppW+/CKOd42B2OkSKOmO5/eDlG6YvVGQF/hy
         kY+9+v7GiSVj0+RjYtf2+d8NZztAKW1EcjAnJpD4pEHC7W1RDCHc3p1wKYTeUyYsCc6d
         yLiIO7hgIZsS0TqC7uT9Kuo5sqWlFd2Lular3matz0ldMjfBub4wRPP5usDYc10u0W8L
         jJU842VjzuA4K8PIczm93hFGRBnt1Ryi1PhZKcZsPMQRIWNNPwXwJlNnsROGb6kISaCr
         FJqw==
X-Forwarded-Encrypted: i=1; AJvYcCXnbf5Oy20ACkBF2GWGPEazAyjbYoIWapGGTVJnS0PwJ4DjT+T3hlPkA6cyZ8GA2bx1ek5Itg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhJWdD2ZxGhpLLHV1rtJS8O4RIHa0H7MO4sTwlwxgp5TidJRt5
	u0N6hx9Xo4Cc/bLPckGO8Es4vlbbCi4EpE4EhBgwZl1Ng15QZuS8
X-Gm-Gg: ASbGncvJJnOhTRuqZr+mpixao6zPtK4pKmCyKAIs+sKI/AQTPUvCDjdcaSly/2YRed6
	lwNgn0iY45/hHKpGCpZP/1tOKjgPQIvLlCvtsQdt0M0e8Xs9AhQ+0YGwb3UwrfAaxdkmAUYceqQ
	8bRbfYcn2LyuT7YuulavYkvNbiLsyNiqLsPbAEyTWC7tZ5erRZETtcl9X3OPVKoQwyZvfEgW5dN
	YJbfEq3zjKZWbv8U/2IwoSEp6grAW1aeAuqBl70OtXvOBLPWAylhT1p4ohanwbfQ3uLbtnp4tFQ
	czWLPYM6Y09dRBtrAZitro9LXlI5IkGeocET6sbciM41avzpOzKseMgGbL/qHcNUZUwTOr6ronI
	hc5VxzA/AJjVZlJ35DIz3Ag==
X-Google-Smtp-Source: AGHT+IFI/hQPt1n5nvgipTFuRCv9TVmIV3SNFe4AnB8TBzlGpWb6YhsoaMIPZt9q7+lC/MQhZZbrtQ==
X-Received: by 2002:a05:6512:1112:b0:549:7c64:3bc0 with SMTP id 2adb3069b0e04-54990e64227mr5404132e87.29.1741715384139;
        Tue, 11 Mar 2025 10:49:44 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:42 -0700 (PDT)
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
Subject: [PATCH v14 00/11] rust: add dma coherent allocator abstraction
Date: Tue, 11 Mar 2025 19:47:56 +0200
Message-ID: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
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

For v14, mark for TODO the solution for revoking the device resources of a
`CoherentAllocation`, but not the entire `CoherentAllocation` including
the allocated memory itself.

This is tested on a Nvidia GA104 GPU device using PoC code which parses
and loads the GSP firmware via DMA.

Changes since v13:
- Remove Devres wrapper, document correct solution for proper resource
  deallocation as TODO, add patches from Danilo to properly add DMA
  addressing capabilities for the device which requires a new trait
  that defines the DMA specific methods of devices. (Danilo)
- Link to v13: https://lore.kernel.org/lkml/20250307110821.1703422-1-abdiel.janulgue@gmail.com/

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
[1] https://lore.kernel.org/lkml/20250305174118.GA351188@nvidia.com/

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
 rust/kernel/dma.rs              | 503 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |   2 +
 rust/kernel/platform.rs         |   2 +
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_dma.rs        | 104 +++++++
 12 files changed, 648 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs
 create mode 100644 samples/rust/rust_dma.rs


base-commit: ab2ebb7bc9d9af2f50b0ad54deb65e1d0b01bc70
-- 
2.43.0

