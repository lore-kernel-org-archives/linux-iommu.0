Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45634C81
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470564; cv=none; b=EZtqyFQtiAU4K3MRS5doK9s++f6vDXG2FsFCysRCX2gcQPK9RQryU+EDifeVVvS4WwZjAPiQgLyZ23G5F6qzQ0Cd6uwvN0a2BxAl8L14XHFFub5JsXGlws1hgH8IZfZ1uGRHfbSr7cCEUF64DW6KKRU4a+vs7Oj7NsNrdYc8fFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470564; c=relaxed/simple;
	bh=yOrU7SGPQ3OrGhFEa4kTFyzjCvRlbqHUS+eLZvJ2fE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TG/6RBxKDyFbBrnrmmG3UQVRwJzXKvdC0YeioJHiDZquHNjbbV7nyTib08k12YFR1ucukuLKGNGV87FR0Hi77jOvI6VAwXKpp+4moFsDaR82qSA54pqz9vBZlTDjOFh0osPUsVwqDA9EciAP2mgJOOL+kQnIwq6VTgZo7etJvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jfn8PIUZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jfn8PIUZ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32a61af11ffso3844431fa.1
        for <iommu@lists.linux.dev>; Wed, 28 May 2025 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748470561; x=1749075361; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sE2bIPrvcBK+tw3u4Z3n9q+Um+FsoesBae4mFssigCg=;
        b=Jfn8PIUZF7eeRPfiGFLQq87T/pSyQvr4fAa2Xnzps0dTXzcUdsG6nyLhiiUinkqqel
         H4WpIa/XncUGRcE30K9rXbzF62HK0amhlefaI8nKUHUPtzZ3o9j2u8Y4PqfSxgbsUpiF
         Dg8OpSqEYpXGy+588a+qIikRKcVI/8SvciWcolor9WoDx0OB9mRGFEWnCFzj50NwuXCn
         VTLQTgHVohr61rGJ+0meucFN7vz+LhCNP45C7s3OkI5b+9HAw5i+wlk7+exAd0JPpgGo
         VMUzjtL7TYlRCsGrXsrzuYRpRSDe6jHRySNCsn0/4COAgQIQ76WzfcbQduWb81Vk1CKD
         SGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748470561; x=1749075361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE2bIPrvcBK+tw3u4Z3n9q+Um+FsoesBae4mFssigCg=;
        b=CciCn1oMTQJZe3VUoyzsH1yM9SgH61I0PUJHpOLYs1b1uDW3J9dVKwrhffyBgYqwGT
         gJZDpyZ/yp4Q1uyta4gw3vzYL7W6XCr6dOeN4pGTZ/xRXWWja9W7HFuYyrgasRlVgZNw
         BVHvFn6PQAvksYPSlUc6HqsGGwBJ/jV9djZiUOCAppmaPprvVCdlvjWt/TzRuRmimk5Z
         uPRPYPbfjMr0gaNqr5nDaRyw+20rdExU0VW+OdYJUvm+REp2t5ApnMRa+/BeHMAO+n/T
         lHT2hJrVUvR2cGyBUaZ3W9e1OYgQSefUeCUSOJB8jUsevomirsOwxSKGJtAuvi1z1Eud
         dSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiusHDTzba4EjbeWrgus7ikF1oO/IJubCQ0XfXv/RsTYfB65Ao+O/peLejXeD9k7YD/aCfyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoFS1wgPrMXRLoai+8V42ZG3wK6cZNmYfJeFrUZ5P0BT68SU2I
	QG77Dt+cViq4fzfibhMtu/+fV1pPmtYl18y8tRL7X7epOnCuIJVKnfdc
X-Gm-Gg: ASbGnctlB53+/7Pvm/VyXcHn8UgwHICNyPyBNkZsS2XQ74zrza4uuP7fPs0Xv1wM1EG
	0BP4QdyfXma+IVSnWBF96OJ5o3i+vMLRni56+QNiDbPMi4mlholppr64X1W0aKPjDq1ZT6G3XUI
	QTFNu2zPhRO4prJA0zfnni71q6F+32Bc7iW2i9TaTKucAhqMupQJ3UD927MBNFeWRV3bYWYYlNN
	Al/Mg7O9uo5dfxK95tECdu6IN73uSN5S7J5Z5XJK4ajZhEparmkz5CmwLyL3HICgxvuHKVLzTGM
	MB8kDSnD1zSN/IbQ/NUt8NMY3/TabfXpE8qKgM/1WFEpLyQa88GIQ/ZzuB6uBs61DgajrDooWrS
	X14pFlnoAmqQJ82qJxwWPFwuaQPLe
X-Google-Smtp-Source: AGHT+IFuoR6xo29lnwzewO6jtWGAATl3ZfrBI/QrwrebjbEHcd1CciMFpJdZcqrbHs9oVwEdqnG4bg==
X-Received: by 2002:a05:651c:19a2:b0:328:ff56:8da with SMTP id 38308e7fff4ca-32a82663ecdmr3777741fa.16.1748470560547;
        Wed, 28 May 2025 15:16:00 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85b55de7sm156911fa.53.2025.05.28.15.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:15:59 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: jgg@ziepe.ca,
	acourbot@nvidia.com,
	dakr@kernel.org,
	lyude@redhat.com
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
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 0/2] rust: add initial scatterlist abstraction
Date: Thu, 29 May 2025 01:14:04 +0300
Message-ID: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all, this patch series is the next version of the initial
scatterlist rust abstraction initially sent as RFC[0]. I appreciate
all the feedback especially from Jason Gunthorpe[1] and Alexandre
Courbot[2] in shaping the design of the API.

This particular version implements the typestate pattern referred to
by Alexandre to fix the limitations of the scatterlist API. We now
have two iterators, one for building the list and the other when the
list is mapped via DMA for a device. This version introduces a cleaner
flow of the state transitions and enforces restrictions in calling
functions that are not allowed in a particular state of the sg_table
i.e, querying the dma_addresses on a table that is not yet mapped via
DMA or setting the pages on a sg_table that is already mapped via DMA.

Doesn't apply to rust-next yet but is based instead on top of
driver-core-next which provides the needed Device<Bound> functionality.

[0] https://lore.kernel.org/rust-for-linux/20250512095544.3334680-1-abdiel.janulgue@gmail.com/
[1] https://lore.kernel.org/rust-for-linux/20250512164247.GF138689@ziepe.ca/
[2] https://lore.kernel.org/rust-for-linux/D9VWA9ZQLY85.277DFA3YTH5R0@nvidia.com/

Abdiel Janulgue (2):
  rust: add initial scatterlist bindings
  samples: rust: add sample code for scatterlist bindings

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  25 +++
 rust/kernel/dma.rs              |  17 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 369 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  21 +-
 7 files changed, 434 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


-- 
2.43.0

