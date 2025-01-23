Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0320E00F
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629033; cv=none; b=tUiRcvhDAkRcLYyLAOZVnFh4dffaT1tqJMezCUfAZTOFdFgRxX9KmBj3S4gnIFlY+VV2hRIwgaAW7nil7MRDHLCnZLAkeWDABcWW7WGbqCXRUPlkrcm4wMsy//VvSN9XIqU1vqJT4Oxqs0D52SdflhfTcsCDdyUFnPf1E+gHB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629033; c=relaxed/simple;
	bh=+VSyzMWcaeFrxcpn8P21db/DRWIE8eIcvt4ETGNq7bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbKhvm39YOKizL9ga5dfdPRqtoT7GIUxbmvYkuRXzozMC91q1ArJSAQP331FwZ7FSd//UgSzNY6ZQGBuvsd5t33No+5oZMM1jPA+Vcfgr4nHnUdbG4MTFhUHLJwfkM+AyunsKoa1LowDGB2dyjJatuJKtkJICGmipfN2mlmDhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayIf8Bu8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayIf8Bu8"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53f757134cdso852836e87.2
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737629029; x=1738233829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs6vxvDASedSGwD6vuuKXmoK57VAFpx+XV9tSJhnRPQ=;
        b=ayIf8Bu8grMQZBopwWhuzAatCThK3qRn1sdtyo2n0KLdXc88fmTw4Az9jaYj/SWVEm
         L+0QO3hpUML0Ld5D/sLlX6rwWqP3NT61Kl+I+XMcyUv5rPrB3MpqEkWI3DYdeLCDNPXE
         7OWudUGtCjDg8w/sKPFJP9NQGiUHhjO2WTKzbAAnCcn5ix8mA1knmS8FjMqUxFQnIwCx
         d8ZNqOESrfpw061sMg8RCjSIRBmmpfrOaT/ugty1QCBRpsWjWu2viC8c0+FJVVAsZSrk
         bB/KaLuIjPa/yGlcWxapj2yhXjWiQBomp70nK+mO9CIN18cnrU0Nw2eO0rM6/ccSfHxD
         qgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629029; x=1738233829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs6vxvDASedSGwD6vuuKXmoK57VAFpx+XV9tSJhnRPQ=;
        b=XSaX5d3+XSxwf5hSbOG24W3/BPzRNwuWdu2eOVdprDtc4ps2xzspMrxqy49XU20JsG
         sEdOnQcJpQYC1W8l2WSKWWjlrOV8yfsAMJ83EzxrP77J5303VdIhwmHFFaeNEhum4SaQ
         w1r3zjBX1+53qEbzRwhoUCOi+59NKIB+NVXEUDq4F3jL15pafjZQPIm0TPurSRmpfCYu
         IkjWBw5JR5mv3F0/wj9JXSD3VjUrJFRjfKjL0F9JxeS2iyL4/w3rIqvqbDPyji5WjhYk
         Muupfu2wJtIUHdethHAVR7VJ0fDrL80eqBsQ/xMg6iXBqOFBkeDZYNO/ULU+/PjxM/Q+
         gJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUV9kWJFZhNmCq7UhEdriBcsz+hVb3bai/2TT8RoyoqfKdUpAKlV0Fg1XqM8qBm0dzyywa4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2EI4fgHa3ZeTB9DtcDvl5ewkLsOjLsU9edmkMWd/5pCKBgov7
	G9T6sf9N8olChkFw0LPzzCKLsw/rv/2p59NNRPRG1uKz+CJscAn1
X-Gm-Gg: ASbGncvtyXaiqYPB7WrM6m3EBIwTz2U32Ztyw4i4Zua05iZoxUI2lKDMrNkFm2opgGA
	0mtTjBxFYJ4hUYvckCPAuDbu313ErO54kp9tVwCoY1xswMlOR2BuZMip53TFuMBZljHEzr8cnx1
	JAEvPcMbFO5i9wfu3rsxSC0jQLLXcVW4M0n6K5njRCAqkzxnDinFBKqbTbuY+3ZZmio+BCykdNs
	Z6A/ZMf3jc+/0eQUXujJ+GBTxTpuOhbxT5fc14ILCHY+ivK5htW95Fa9MTGDBE1vhGiK1h4Mzas
	4c6yi1b7y5v0Ww+CJxBpOadswvKmw6/cJM2w68HF54+b091iuOM=
X-Google-Smtp-Source: AGHT+IGxx8s5w4BXQVnncFyJDQTXakJVDuuRVIiwBW08jZZSzDMCBmYcg+SIWcQdmUx1YdrNM/wA/Q==
X-Received: by 2002:a19:f716:0:b0:542:1bdd:748d with SMTP id 2adb3069b0e04-5439c223e12mr7548727e87.13.1737629028968;
        Thu, 23 Jan 2025 02:43:48 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af0ea8esm2579873e87.80.2025.01.23.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:43:47 -0800 (PST)
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
Subject: [PATCH v11 0/3] Add dma coherent allocator abstraction
Date: Thu, 23 Jan 2025 12:42:56 +0200
Message-ID: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v10:
- rename read() to as_slice() (Boqun Feng)
- Do a bitwise copy of ARef<Device> in into_parts() when returning the
  device reference (Alice Ryhl).
- Link to v10: https://lore.kernel.org/all/20250121191432.1178734-1-abdiel.janulgue@gmail.com/

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

Abdiel Janulgue (3):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API

 MAINTAINERS                     |  10 ++
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 282 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 5 files changed, 295 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: ceff0757f5dafb5be5205988171809c877b1d3e3
-- 
2.43.0

