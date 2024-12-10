Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D879229136
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869006; cv=none; b=UlL8fo+hTtqxwkMeGH1yx2RSpYbQmd4ikGwlQJ2PMb0vxAPuiNgFAEmknKFbdiKaBs3q9/dblOGwWLSXguXfBsh44OXz3SoJAcIX2+7CktBaCmz6iFZnIAPjYDuatXOGJqxCferwqsJbqIfvUZHe3hAd0y9MqvdgFNAFzH8Ldyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869006; c=relaxed/simple;
	bh=GemqW1wx2Zr6paMlaBSC9NsMGFDzwO10UQsFGzL0Yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTobQ6JlL+H7A5SC4ROyLwdHDq9v3s0Mht7oM7m6GuaB0B5GZ+3hdIpVXzU7teBKYMPp0fASvZiTcCGRrASihcRNpftR/K6RJr/Cn2EByC/xrzcPoWrVeE/EYnG5R21w/dFmjXEEyRKLit2zWS3k1/iLkTbETbE70aoLbA3LLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1FC6D1q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1FC6D1q"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so76794e87.1
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869003; x=1734473803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q5eDyei5ksXYu0d0JSpsZg8ILiim7eTaT1jDdxHxcxY=;
        b=F1FC6D1q5FJEaadtBG0WKLSkSUYb3BwHJRRct6XGvAuFUs8KifNG+2p36PVz/+pgWs
         wT5PFsIoOX4HDbaAxbJVrxcWvuano33N/47dJZnIxAxMkNuZcL8+UW49HFhg9xEH3U6V
         xkSUiGCjSN5N9Dy8+nek5m6Oaj7qG9gnQHYqwzVk6UCY1MaBJLbFBn+f2wEZeYC0ZMw+
         2Xp4AIJAMFK/QQhdYIOrsbUQbRHEjiCOHhAQYoJg1jH6CAR2ZK6PmorQPncczeQCAzmr
         GdAyVMe9ijSuIL5tU9HbSoFx+aQDUIL94hpH5XQFoCcXcHYTO2O6BvEklwUfmlhG6+Po
         +gxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869003; x=1734473803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5eDyei5ksXYu0d0JSpsZg8ILiim7eTaT1jDdxHxcxY=;
        b=vExnM33MvkjigwkKaP3VmxC/wcRxVqZXZCEfKvJDfcWjnAok5hR9I9+tvjNGhWJncL
         3/PLt4LFry4l4FPuJMPqAade2kCHPj3zCRzzsQDr/GKXO2/nufBNOQMTiRxDyafcnCec
         FMyad7ZxO27mlwbDKzuj3MUtQoL0DoZF5dojXAf8MWiq+fxP2G0j0X/HjClNxIoWz/j6
         ZXKN3VuX+96rDStEcPcnkSaQz0/FTJASkpb3L0DP0ZKJ9LbUkQFv9iQ4xTIBpnLMVBrW
         kfTd3fC2hlIfUM+0XMmoODhRpCVhtNl7RF0ACJT5gkQLQgg+9ueEMN405arzbcL37L/R
         JSzA==
X-Forwarded-Encrypted: i=1; AJvYcCURf69u1pmTBwRFKDfrkcKt38gB5qcqFGRuu+CeWXB4w5aoLP4Nz23CX/dKxsSLvx8PTacvfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2F+2EjRwURBaiWie7DO4GEZYOid1SJXqDgs3Qm1K0tT83hHMj
	CIapo3n4eI7bb5874KzMg9s70pJSFmurCS3bfhM7H4uw0Dz9tTsj
X-Gm-Gg: ASbGnctO7+GGNKW0bscggG0YyEiWYZQIXo/WP470K+Xk8fnFJSAKXZNR6koEZwVJfAz
	SJNUaDDzn1zsH4A2ZIuNDFuoLR8BZpAsGTM1L7KDPCpSmKKcnPLgusplJ+JovULXkiKyOUNRPEP
	rAkrM3CsKn4IbNaNpJepZzoQIwS8+V0yELviuWEtdZqqh9O9uLD8XArNxQqB14jq9viVgWPOqr2
	cp4CaYjs2PrQxoRySLFmPksaDTQHge+OBc741DYDjK8n96T+todNWb9XngvQ92SughMjH1L6x82
	AmgLek0Wg8YkMrYXlPZDeJe7
X-Google-Smtp-Source: AGHT+IGYXyjdGUb83ke3duPPcomNuJVXRVbSNr61MJVyyjJUySl5R3d+sPrypSylJfWAJ07lr2F5Sw==
X-Received: by 2002:a05:6512:1104:b0:53e:2098:861d with SMTP id 2adb3069b0e04-5402a7569d9mr113730e87.15.1733869002359;
        Tue, 10 Dec 2024 14:16:42 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34a4531fsm1472694e87.262.2024.12.10.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:16:40 -0800 (PST)
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
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v7 0/2] Add dma coherent allocator abstraction
Date: Wed, 11 Dec 2024 00:14:57 +0200
Message-ID: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 rust/kernel/dma.rs              | 223 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 4 files changed, 226 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.43.0

