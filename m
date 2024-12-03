Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351C1F8AD4
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245738; cv=none; b=bVnPQWQJAfuG4l8biXKWSZ+9hJUq2vmVv4i+KCLMB+8t5F1X0c5E5W0P0kD0IQg+OW8nckLzW9my0Mpw/+wqLbwqaJ1GK61GcOZCFXRg4nyAGTWrNiFzZm7fW2b8mXT+vrLfQfi8D9rfJNFQOGUu8pM18S274HKcAXgOZfgMj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245738; c=relaxed/simple;
	bh=llubugD33UtLbMNSAYPh4S0QVhXvEcS0Bxvt3lhri88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+LYkjRW3pJc620GcbZo8GYDCYM+ob6sf+g58BHSiq3RzrQxXmM+TgvfwzwQgZENo9ciWTlFrKd2Sfrru6j4+LloUwglUGhrUeae3Bbpk+8/OQvrw1dLtS/+yYKqDy5HoMc2AQTT6JMjNfXiUsu91gwYDDe0dGV2n68kAKN9TO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLfrpWso; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLfrpWso"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3000b64fbe9so10177401fa.1
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245735; x=1733850535; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8xdO7uSAmdeXdaXhAt2LPxaiOQvWWPfYYTgLrEVF90=;
        b=TLfrpWsoy4LH3peJvhdzQbtcq3a2m6Iju/JetTZACwYjHBeLpLd4IPO2c/4GgPyS4x
         TcWTqeHlz/leizKHbqW5fTDFWDtrTNV06Nau0mOvW/oadCltlVv91wdK2WxJx+fhchYr
         2X9S915alczD4Hki2f/0bONqa2sDab0SPj3180X4emGeODB7yi/UaKwGvVudnBNYHMfp
         8N6ZU8OMXCQPzARyMUH9LFhpwfEF1IY2QPC0jBby655mCI9Obt+2empyZ4KzOiDMU4P4
         j+Yc8KvQw2HcTDFIJ1bDWHKFZf7I1KlTYhZ99V9lDF2ecxZ2hcn0Yu9O1QgGueyLiadh
         YFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245735; x=1733850535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8xdO7uSAmdeXdaXhAt2LPxaiOQvWWPfYYTgLrEVF90=;
        b=A3VmNuv8vUqlIZGZ2nxApvZ4Psr/jHJ83H65zYpY08Nn0t5EM4ZNyKSUkp2gWqcRDQ
         498ZL/FyrX6wy0XUngtEhMgFKuo1Jv7j8KP2i/PqLNyFXDd77ik8t1kxoWmCDYKJ72kn
         DuGKA+zHJbjZE2I50hmXw1EKnSAMJbe22Ay3vgLTVBuBrT/U7PXEoH2DhWeV8EQRKksk
         KQajnkSamGvwRj+CjG98q4gQ+e2apBYLdM5LPjJNLGeteauOC4MiqIbWkM60lWLbGkOv
         8Gm/jTapI3DR/2smSVq9I7DSX1aRXlUDOXuFcL3v+QJmdb3Mi+mVklE2IgnHhMkUqXnE
         1d3w==
X-Forwarded-Encrypted: i=1; AJvYcCXc8OtL2t35Q7elOU3STEk1eGvVoADKpyxx6RhFtSI0sVbhdp9B7FP6+B8unutBCvCosCPDNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYLAfBO5vnPU+SBOFsoWNYme/YI41pxh47DVUdcgovhMlFpbgz
	KxCLBt8zSnklp7XKV7zk5vx2LWH3TNc2ARhfOR4MbpMoQ6GzGEoB
X-Gm-Gg: ASbGncvGPMWnm4Q3k7vtlVlfxY/WbASd3wJLnDVnPhzkU89JwfE0oeUgq1/116Q8HqR
	/bFRImugehulz2+tKRAO5WTIAk/7nMOz1dXQPT1TvjbXuUaRhLh3OK4tHftgtA76RluAKQ+p9fr
	GYQLykFPfe0cAaGGdOvxrLKA8e0HsYTinapAB5X5wr/H7Rbe0gcba8CPjAZah3jlPkImtEGLMW3
	p56PQIME8HwA+GqJa32vCyz9AtalRspnLO7sGT+fpDdB4v6eYWdlgw+i5EzWVSB/9XBZr3dFGq+
	w06GXFhIy9nFu4myE/iK
X-Google-Smtp-Source: AGHT+IHfeCJtMPc4CL71SUxwIM/hZO9OSoFqlkV+xBr19Tu6JMY210/2r+5GNGRO/pX+NA68F7N7wg==
X-Received: by 2002:a05:6512:1589:b0:53d:e324:11c9 with SMTP id 2adb3069b0e04-53e12a39247mr2123837e87.54.1733245734836;
        Tue, 03 Dec 2024 09:08:54 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644336fsm1893394e87.80.2024.12.03.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:08:53 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@google.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v5 0/2] Add dma coherent allocator abstraction
Date: Tue,  3 Dec 2024 19:07:42 +0200
Message-ID: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for a basic Rust abstraction for the dma coherent
allocator API.

Changes since v4:
- Documentation and example fixes, use Markdown formatting (Miguel Ojeda).
- Discard read()/write() helpers to remove bound on Copy and fix overhead
  (Daniel Almeida).
- Improve error-handling in the constructor block (Andreas Hindborg).
- Link to v3: https://lore.kernel.org/all/20241105104726.3111058-1-abdiel.janulgue@gmail.com/

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
 rust/kernel/dma.rs              | 136 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 4 files changed, 139 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.43.0

