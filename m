Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA41B85CA
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449319; cv=none; b=tC1iUTqJ0wNvxwhdKf9XooofigPCG/KPl2ldFlzCdypZV/j1u+yZ1hefwZ3tREDigvSmLH+CeTU5GzM7O5/wxjT8u0ovmbI4I79T4RYt9ASffeYABngL+mkniYwJ2bU/9Lc6Er6hkbUnHbBomjwx9P42P9kwd/8GZBtlOZIwSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449319; c=relaxed/simple;
	bh=9yw+tJyscIFBRqqCRDiUeLgp6QlDzsEW2TiCp6TkP8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0AAqZM4bHqD/TY23xsyJ4ugY08nHEuwviKKaplhmmZMHhTrtrZF0srNBTTM+r/nqhNMrq9GdWw/5olzw65iStUvnJcq1RpMnWiP60aQko/B0IyacDS+yAEMEy+5VTZnnZ0t/aEmnRK96x9l/OJ1A6LJlM17OKL39ZmNqkIWhzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8e0X4ha; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8e0X4ha"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30737db1aa9so24904831fa.1
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737449315; x=1738054115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1IBBAaVfa6hiQTK+rLof3oKcml8F9zzRUwtu2WH63s=;
        b=S8e0X4haiuEDkJxc0It8tl3XHqj+4SfPMjpgUU5YKZlcCyVaQWdJIHgE2p0UEzpK0V
         XAcjcgQXj+H0R57Wa8YqGcZ2W8g2+wCRDjDqZVP3P0SGl4ZyXTjwWy9LvDgp4zzbDPhc
         8skljOQRhagxmYM59e5q+0WeX9N4fpzF7yj2Jl41IhF7P/EdpFFnFOSkzj0sjXTTw2f7
         1HIqn+BVbnQQoNvD6bJtl8HH4h9tz4C9xTuv5iSGWKuqQe9cU6W6XENWCh3h5S+SAEGc
         eyz+IeUhVkIpAyzSZ1JmNoLCsxuDp7tG6q7C2CmYzkSHH7rW4xlU/HB9oTjOd9I6zZIp
         oPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449315; x=1738054115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1IBBAaVfa6hiQTK+rLof3oKcml8F9zzRUwtu2WH63s=;
        b=rn6gU7iCCiV2i2Gqqbe3WKf0DSbEp1wrueNfsCeZX/YMZR4MIj+qsiX6tHv6HVbXwj
         nJ9oiF8OlH+8x4wwS5yII2oenHIhvPYU6dsZzRTMbDTkf+D2Nhgz6jtdhNEb4XNQ1gMA
         9ddKZJWc6YQuRXJG8kaTOQru+eTfSlaOkOWErEQ5KJXeZyADi6AKwMM37cdDGvfBo87B
         rWvO096bSSaHNX1CzoRvMb97DBGbSL078s3zWDvI76IfYqnIKyGk35ofh2l3sO+Vxvnn
         VUGD/jPcB0+kd+CNohGhUrD5cnqaTszzaqqQqJwg3Jw5KNtOr5z/971f6hVM1YXOZzXA
         lIjg==
X-Forwarded-Encrypted: i=1; AJvYcCVmnzJrWX7IaZxgPy46trzFjX2jwuhOFRmOe/qcl1m9kVhwuCHKy4xm9QHK1R60ZTXUy/EGYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfPEKyZchCEF7WparcZb/ytDI4pRoVd0CzKFROf6r+n/afWidA
	RZWWDPF0rmnlTuS40e43hWug9WysA8Isa9L8D7XWrpULM+fcgrlA
X-Gm-Gg: ASbGncu8uFtjtlOWAXiIGo4IKoeTPBRssjdaWS8tERwW/l7bpDDUcCVFrC3yOOVd0Wu
	tT0CMKYGOrtbcCvJJLmkdcb2YaFddqF7DWYGr++Bw+MZcHygiCxa3Bjad2X9g0Fk0hNl5sARhqp
	996ufzj0uKJByWZMlIcHV+G78oUx/dn5YHAQZObq0gwhu9JS02BDLX4vlbc/QdLXkdTyyzoarRq
	epDocLsrGFpsw8rwlTYxeCkV3PuTtGU1DH1GrcQoi43mXSOieOGcgX1sipELKunoMd2YCzWIFGk
	LBvK/Dp71TVyyQ0MFk9idMpiO/Q+LluzThB+0s8E
X-Google-Smtp-Source: AGHT+IFcDKuxLrpt/fzqSVNvr0kOtGLvjPWFjlocZAiJGOx4W6HVF21TJTzIPJJ/g6sQdX5jmV8FOw==
X-Received: by 2002:a2e:be06:0:b0:307:2bc6:5ec6 with SMTP id 38308e7fff4ca-3072cb3cf90mr56185001fa.36.1737449315144;
        Tue, 21 Jan 2025 00:48:35 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed5c7sm21178651fa.82.2025.01.21.00.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:48:33 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel@sedlak.dev
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
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v9 0/3] Add dma coherent allocator abstraction
Date: Tue, 21 Jan 2025 10:47:44 +0200
Message-ID: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v8:
- Add MAINTAINERS entry
- Fix build issues due to switch from core::ffi to crate:ffi in bindgen.
- Ensure the wrapped attribute is non-pub in struct Attrs, declare it 
  #[repr(transparent)] as well (Daniel Sedlak)
- Link to v8: https://lore.kernel.org/all/20250108122825.136021-1-abdiel.janulgue@gmail.com/

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
 rust/kernel/dma.rs              | 272 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 5 files changed, 285 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: ceff0757f5dafb5be5205988171809c877b1d3e3
-- 
2.43.0

