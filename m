Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C01F8906
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339315; cv=none; b=u+cvm3zzH9voQDR99VYLX6ExCr/RDcjk3cG5OZrHqoBJ45/j08Q8Fk++/fG7F3EZBb0dkjbtPMBV6TMDMHEJToQgm93sQpd4pudgsoyi9UfxlBWbfyNTu3sIPTYDUKYMAWzCNzYkOs4VI9kCcGeuEVTdXRGYU/9ooUd3h0tAY54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339315; c=relaxed/simple;
	bh=UDKti+aJ77n6pROea8SeqbYgxfEhmJrwitmmnfWuZNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8pke/yaxfy1sD+3oF8KvyOGcW7wxjef3vsJfmkvKDnVMEOTuUuEhoMJ+mYS2J8qe7SfPLhTaT8SLLT3xdynAeRXdFH83h9gQWBT6mfyBcxkZgyLPnC9Y5VisMWUNEQRrHKTK1jkGQZ/FmrlVnHtww2OWoLHwPRNBZpLP3y82N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npbJbKmr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npbJbKmr"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003943288bso188186581fa.0
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736339311; x=1736944111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEOnBQPSx3LETN+z4pi6jcbb5PWSNzvQx1cogr085Nw=;
        b=npbJbKmr98tD5F5UkIZIhobx2TH43MF7FbqFbnKwLIPdr2lcWiLlR2eDhGRcEaeZvl
         VivF3Uvl6YGrImMz5azGyNXbU7Jnk6gQXpgv+PgJfqidrI3BpK916kGcozeb2g3XI5Ck
         lmpnMVtrD+1tyDLc7OWaLPgecgcWVaiQGwYq5/z6YnXNJyhv8XKlVNzMvcI5VjME7Cip
         t7cawNkfF0oNuV1bBI6l85J88hlp+FCq2o9hKJTlrPD8E9jQx8LXvHamNSo4WDZUXSjX
         ED1beA6D/Krm1rW/B26tIco2W4o+XQ5+B12M5yZy5XPMvrBUDz/mQRELKoBxErYQKPWy
         To8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339311; x=1736944111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEOnBQPSx3LETN+z4pi6jcbb5PWSNzvQx1cogr085Nw=;
        b=J2oxU8vadcL/MTgkAFiN2ES+QDkmTf1XBeg9eXpCPj/XbpBCQQu8e/JjuUv0IHgE7+
         p334dVN/AAzX2vbNRsb8BGRB6XBYYEaxQzQn+Qfex9bXWdwDE/oOG9XmXPpLJ8nOOMgS
         ZlvYRFj16Q+CTZIbJzp6w8yLJqejQguCTV+DURSv4yrmNX5xbsuIcTdskaK33F2SuT8h
         I672H5+kTaqJzcMmT8ZkoejdRiRfKYott8KFQDOL3XcGSeca1Vw0RIJbD9kagE+yGamH
         FzqBhFYoaTUIHd7Lf+CcaMbnMDhgLJtEkv1HR9ghcyoRvG8uUno0/oXZe9K422n/qq5C
         VOgA==
X-Forwarded-Encrypted: i=1; AJvYcCX6CxP5ehrJ2xaskKRVdt5wYboyAVJ7c3zGuYYPEBkN2zNRpx+taK6mnCQ+MCh6ovTiHd63Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhQNhEmmPzIW4OlIMz12B/cEdMrvQqmV3N/SenFcErRmriBanC
	XGWEuiApyZW8I0XsNvwROZhyrV0Diyu9oO5O28jAnNoHu86/kp70
X-Gm-Gg: ASbGncuAujPM2FHXwJlSF4GTIire7hykNzW21t9P7qJqLsczITuvt+H1C1ggRyX1XNC
	6LNBhU2gkeRzJ1OZ5vRYxVG8P+wT/xkC3L07xO+XbqIDOVG0yFT+M3OcbYKAbzTRTmK3LQo3Ptv
	25EVyex3pjiPUV4botk+Fs98X0eF/5kb0IbAF44s/sBz4x5eV996cKxGr6psZyh2LRIzhREf9vF
	d+/t0AaStTSG0VZgyIB5D2kHaLBqWc9D+ShGM3qQdDPUeNIsoKIekBoic4zTRal+GcHn+WcMhYi
	76ySEpg2Yn+i/kcg2wYJVcQj03o=
X-Google-Smtp-Source: AGHT+IETg2TD1LvGCWsVjL1D6PNdVra3sYgydESLEO7ovogJqf6P6dXzxr8sp8sYxcrpAzWw7Xmw9g==
X-Received: by 2002:a05:651c:2113:b0:302:4130:e0c8 with SMTP id 38308e7fff4ca-305f453e565mr6651561fa.9.1736339311205;
        Wed, 08 Jan 2025 04:28:31 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b082db8sm61183911fa.99.2025.01.08.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:28:29 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com,
	aliceryhl@google.com,
	robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v8 0/2] Add dma coherent allocator abstraction
Date: Wed,  8 Jan 2025 14:27:22 +0200
Message-ID: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v7:
- Remove cpu_buf() and cpu_buf_mut() as exporting a r/w interface via
  a slice is undefined behaviour due to slice's requirement that the
  underlying pointer should not be modified (Alice Ryhl, Robin Murphy).
- Reintroduce r/w helpers instead which includes proper safety
  invariants (Daniel Almeida).
- Link to v7: https://lore.kernel.org/lkml/20241210221603.3174929-1-abdiel.janulgue@gmail.com/

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

Abdiel Janulgue (2):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 271 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 4 files changed, 274 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: 0c5928deada15a8d075516e6e0d9ee19011bb000
-- 
2.43.0

