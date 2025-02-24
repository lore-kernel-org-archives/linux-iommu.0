Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B925D545
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397836; cv=none; b=MlJIDJtDbSCWxKAJ0Sf1ncXfB3VWmrZ/LsKbxQ06ioJ/5LWDLZKaUOnPDTMxESTcAyJf5S8ZD+5D6yVQ2VUQnJS/bV0W3nqmKLy/86Pn6rUl5YbpyC5DRmbk9hbn3bCju+7tcD3/SfFvGFIewcE17c+2URix0kUC3HifEbmD0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397836; c=relaxed/simple;
	bh=YDNlTCQoGkJaNVtqgLpI0u33kBZS6sYuWLEQLNwBwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HYqOx5HQfzXtmvg8lP5LLu6N74HTsTWXiV2Qy33J/k9YRvWDpdfBiiw4d6fooeKsg1ZpRCdH7Vmt7EsJDQ4z0Hy+Q4N6oSg1Uj0JXtgnigfTwNDU3sA5HtTD/q7sgcrUms7fJVkWTM9AO7lQhT4WnSE61muAaq3VQdzYaD26CZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDxgQUhP; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDxgQUhP"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso49569871fa.1
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 03:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397832; x=1741002632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nvYQvXkD0Ar4QdoxJqSHp8EpN6ZHUmaSp2XNQrJj5I=;
        b=GDxgQUhPlw4VX8BwNlg0NZ15h3s1LMuW+tZyEehAkq3m9aj19eJgG8i0k6e0pBSXSU
         jMYGBctpB+i8b4qof8mQW8ZXXR/FV7Vhm39JbAreIbLrZ1wtpEwD4VFkXWDPLS9ulDWE
         BLq0Wa2nc0UtjC588Ui32070aCCSWoKXuV4leTpQ61SXjyrH0tzEtCKrVcmDkoMbamll
         n/9e4Vs42BaPK/xrVc3B4JiwSqBVWJ8jb4CLuE3P55oPwGutHIjhyphMzB9gWv3Aq7Xx
         pgRaNVbY5pXVfPgtIa7GPKGAkATHoiYpovOr1x1FHXifHVUfeNxAikzc+MzVfpj/MQ5M
         o4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397832; x=1741002632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nvYQvXkD0Ar4QdoxJqSHp8EpN6ZHUmaSp2XNQrJj5I=;
        b=xLOU1YxhLIVqD8JxB6n62WKM2Nabs5Ef8Z6SqKTC08i2TY6h/v1TRrnXHbFX+SddLg
         oZKq5kWEGXxaucm3GTyIUtariKCiSE58u1/EdU+3oAkuP3b5oyGazgf5ZHuYzVXlwGoD
         mTifPZQLMz7+5r/KkN0WwJArPPn5JGvhGXlS4ELvmKr/KyAAAnuvIK83jo82thR0AMrJ
         sSDylM3X8W7yp+oMYmUPJzcXa79tHq8tIxmcj0O0awVSNfWSmEULKEt+f2kNC2K4el6f
         5xntTZVpYms0RuIFpPLKHUi5tMOHZQTfCL8CCZ3Qo+93lOuXAHtpCzg15YV7FZ/ZlIB7
         TwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3rVyzTVQrO/miyGRYqIK70GY1Y0lypdWESxv/wv8XgJtaa2ODBoiG8p3de4sfv0sD0aMJfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0nnP1AIWEu0X+5z10cI+ljMSnSoL3FZVMuBLbkmvIOnxSwMlo
	ItwnBdTvJFmyBcC4/PdCLO2Rqf/1iLdVbozKt+TDgHD8vvtVcz1C
X-Gm-Gg: ASbGncu5hsD3/HFoSgkdsL1hZxtPu9wZNlSGTxrY7Z7MTE1O1JIichBizOCaLnmp0c6
	LgXbI4lhJUw5Xg7NB2tozdYzGxZZFnOkGCekVcwiNKfzOxWB3MjE7xukvpvR6NHOloTIg/apN03
	FQDs9RkbwlgGLAPjf8p0dv+en5gLYntaXBTAzGlxltsOooHtwot9KrDoVzyHIPLiqUzUdCY9UDC
	NmeMxAGvMNy4TEJo7RDs7a63f9/0RdyFTl0ZP5i+XzoC975gy3eK4kqxMPttjyruaYQMGRN7YnH
	qP/ZB5SZl3nSG/Va4V1q7dOfBInFZ/Lqq9ohqnL/y3D3cadZk/cKH+sCoQYx27fUU1K6k+2v
X-Google-Smtp-Source: AGHT+IFPu6tr3k4lr0i+UTEWtLUz2QUN9RBBkDDNDW6fc64OhExid58PNm2lBtTjf3FY6e5KF3KbtQ==
X-Received: by 2002:a2e:9f42:0:b0:309:2653:5dc9 with SMTP id 38308e7fff4ca-30a5b217b39mr38422761fa.37.1740397832198;
        Mon, 24 Feb 2025 03:50:32 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:30 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: aliceryhl@google.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org
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
Subject: [PATCH v12 0/3] rust: add dma coherent allocator abstraction
Date: Mon, 24 Feb 2025 13:49:04 +0200
Message-ID: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
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
is needed for nova-core[0]. This is tested on a Nvidia GA104 GPU device
using PoC code which parses and loads the GSP firmware via DMA.

Changes since v11:
- Ensure robust handling for potential pointer arithmetic overflows
  in bounds checking (Petr Tesařík).
- Add dma mask helpers (Daniel Almeida).
- Clarification in the safety aspects of the as_slice/as_slice_mut API,
  Use ManuallyDrop trait as a replacement for into_parts(),
  Add dma_read!/dma_write! helper macros (Alice Ryhl).
- Link to v11: https://lore.kernel.org/lkml/20250123104333.1340512-1-abdiel.janulgue@gmail.com/

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

Abdiel Janulgue (3):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API

 MAINTAINERS                     |  12 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/dma.c              |  14 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/dma.rs              | 411 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 7 files changed, 441 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs


base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0

