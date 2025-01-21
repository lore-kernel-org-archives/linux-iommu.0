Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9432E406
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486887; cv=none; b=gjISmvheyYTaR4/URvffDihUoD6s9KcF2xmYkyxdiSXoyWeP+8SFA0SLi5GtPJJ/PnWmJgCPIiLZHp2iAhI4so+SdW78JpLI2+5Qui1MutDQecHyqD0A2yIlFbbJZFOmQWw80T8iCIQoUpYTnO8g7KDo+o00UOxPMsvvK5xum7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486887; c=relaxed/simple;
	bh=ivK18ECx3I8NGnpFSJQ6naIpLcVaOg0alogpoLWYwoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szSVIF5lBXxuwheNhftCqLCwjNep197A0o5Ia3UTHAl7grXA6ZCQCfHTnMeicHIfqmpTqouywR5MabwISqY4hUKWJu8rKWkKzvwmroj6ISxkKfnf0u5nH0sdmA5d2Kg11wV43pnvM0Mq4XoRmmmQgsSkLmebLVkHK8m/0qZElFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+e75hyr; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+e75hyr"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df80eeeedso6011657e87.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737486884; x=1738091684; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bg61QWb1i91VY9CIQBaPYXkWR4SssGW1KgIQsxOXJU=;
        b=E+e75hyr6UUEu5luYkH3SdErsTBGGmxljXE0F5zkdiRIOqIZ+ayWI69436siUYDRnu
         CJbCpV96gDupCPtXaN6oqt1Eqkidr6rJfjNhDvjZ0W//MFhqMXXuAXkycW2p5OO+/ho4
         VMTPVtlt7DMdI0duR0B8mg4TPreNBoH6BGvq4NpHKSTfGWTJiv5PpKVZYbu4cWVI2no5
         E23JX9GhEu1+Y7rAydzmZcFkr8OYhzftrFdEvvE/vpX3CjeysrjctJcIIOPWQvbxLW+6
         dAbk0lPf+uEL50VpTMtSyHi6LJ0GHu4a4MtyV0OWnk3jwVZPSbagktyN86Z7jEbnYDTK
         chaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486884; x=1738091684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bg61QWb1i91VY9CIQBaPYXkWR4SssGW1KgIQsxOXJU=;
        b=Zwl0ycgqjQWcM1UWbKqCC/gjeZuzkCZjXci1oT9lt34/RIUHEt/uAzQfZDWCNYge0f
         PH/qwdM7Bcw/54TUkpdEtRmaxiQKKRqfgtDuKqTaWnV/OXNuSJPVGcsuXPna1UxMS4x7
         H2ZBVhvAJEH12syDblpGIfG5l3MyBugRSdlP4gcguHUXW+mehO35mPWuW32rYs3F5tmY
         Xo52jRj1tSGInFlG3Ijm86Obspkj8J/zmH6LLyzBTg+GKyG7ueK8GjTN7BZUdRO9dAJ/
         XGZKfoJ4vLPzX7K8IUZy1uMLYNn2hA7Os9zZyy3pDDVsBIrbbIuxT5kAHSOJtag8LFZb
         eZoA==
X-Forwarded-Encrypted: i=1; AJvYcCWGG652mk511Tz1dlIk1FEP5LJvOM/uX9UKsulOY+150jp5p6dl6tF/Osqv0ZQs/xV08iiSHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa02gp/YnznGFTcJdytoAjuWvCOPque0aYH9qrt3XNHnFGm3lq
	O7IH8cpnkf8A+Ziz5M3M2BMHEq1b1tp2dHbB68utjKk2LPRkKsol
X-Gm-Gg: ASbGncuXEafPvvyfZ34pctJYy90v2EQCzIC/a7wFgZITm+gzuhRFcHtb5oKQcH2RknM
	Y8dMWPKd1GRRpaodnulZAlVDn0b+0y7iFaegthMVWwkLlyYlgQKIOKT5HHojDfh5W9D5SqnjPWR
	9wWQ3HqSnoW0hvqK97eyidRwE2/4kUFV5AG+e5slRQDc6tVXlF1WyIoNak+n9f6gap3J9CupmS+
	2XPyQTRrPav/Xu1YPF68ooQ9Y2lydgIk3sir7lBqMGhQGBTTyh76G/8HIInuqHSEvDwpC83OZvm
	V5x3i0yHHUp2i6rkOkw4QZbcmYCC0W/hzGCNISPa
X-Google-Smtp-Source: AGHT+IFZvLqKPUFbTeA9XOCsPrcEmevG/Vm8PIvqM4oZNloBE0Smt6VyQz29eF6NVmKLgg6EZpVcTA==
X-Received: by 2002:a19:e054:0:b0:543:baca:6f1b with SMTP id 2adb3069b0e04-543baca70d7mr450871e87.44.1737486883632;
        Tue, 21 Jan 2025 11:14:43 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543bb6bf5b1sm56786e87.118.2025.01.21.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:14:42 -0800 (PST)
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
Subject: [PATCH v10 0/3] Add dma coherent allocator abstraction
Date: Tue, 21 Jan 2025 21:14:01 +0200
Message-ID: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v9:
- Use ARef<Device> in the constructor arguments, docs clarification avoid
  manually dropping the refcount for the device in into_parts(), use
  add() instead of wrapping_add() in the pointer arithmetic for performance
  (Alice Ryhl).
- Link to v9: https://lore.kernel.org/all/20250121084756.1051758-1-abdiel.janulgue@gmail.com/

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

Abdiel Janulgue (3):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API

 MAINTAINERS                     |  10 ++
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 281 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 5 files changed, 294 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: ceff0757f5dafb5be5205988171809c877b1d3e3
-- 
2.43.0

