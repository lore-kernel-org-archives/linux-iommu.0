Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0832264A0
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969977; cv=none; b=FzS1nusCus8MUwrcQLdpnuwRN//pVpHRFAkx+ZrqTl8+ri18IJv/BKJru5EtXjZRN/YGTO+JNXQyl3v4LCqJXhQPYA6VoxXpQynrUYS812H2zq6+8EGY46KbpfL7rrHBUaVQDE93RVgcgC+YfbqjIfgRPF5WJswTEpsCeKzu1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969977; c=relaxed/simple;
	bh=NxaoikWWKYzV5QejK8n9/JfhoZy983I+9kYK9QzYnMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AL3wAbF6B6R3naTe88Ac+uFNqmQXqXAGP7vI8zEpWnAGswAFzUzb/qeA4MD4kTi8D209vnr6RvmVLmBYIhjL6Kf6RP2wt6GnKvBlbzBXHxkXXKQCNOM4oZnUwF4Z3PAQ5q7QnGPB+cbPorZtABuUioDo1kwytr2BcYPIXOcnq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8m4ATKi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8m4ATKi"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b51f5218so1625716e87.0
        for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750969973; x=1751574773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5s++U0umyHNoKeAuC41JGj9b55juJR9+534lcM7ZpA=;
        b=K8m4ATKi3tTLwr5RoiojQB9/jftDbN3et8b6A4q0n+x4C+a+QGzU3PLQrmTJcxUGVj
         87SdgySgQ5j4mgvy0R2p7ofSAbUqivO5w4IyUXM2URn2j3RJH7B/F9F1ZALn9UIYao72
         mhu1WbLs9dhYapcvOlRW481ha/qprwEsVPg2pNPMhQcSvPRYLrJx2esbj4xlIo857qz/
         NijmjTaxqU4yUzekA4k3vOKAXbngY4N6SDm4zSSf2b1iRTTjAmoHqQWol5R7rsQrKLW0
         5SkLvCpBDnBvoS/SOFOueZP9Aq4nG4EmXVwBIdfqybhPiCriDjS6DJNy+QMtF1idEE4S
         JNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750969973; x=1751574773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5s++U0umyHNoKeAuC41JGj9b55juJR9+534lcM7ZpA=;
        b=TbEOqVcc1/dBS82jbH82w0V/xobtl1H21UcIZJrQIxICMYUhr0wDfKFZi0gday7+9d
         DQYZ2OhJ0/sxaOMNXdnU+evchbLzUXRTK1aKLqYxk+SdaOXYITBdQopzo6X/eLgfN9zC
         sNL66rQXPimlk2CdXsfWjJjHiNtv5e6OpVrKg8RSSIphIp+i4PvWZNO7FWPZgip+nTAg
         5Rhj7ES3X3PCric54deRsLoIUhCAIth15f5XffKS3KQWaEtebFKRHi/S2hZ8CqdzLyeF
         f6YC94GfJ3mlyBdiQFB3Aq4+T9n6XoEbVNeM0+EpWRjYz5Ido9BUYwG7x6AJXZYK+MYt
         WAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGa09ghEo1vILpgcmA+D0+KKNRi+VMzc9C09J018g1OM9wuag5bdLOkMIM1R4vijZB85t+1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDQXkTWfWqEQgSU0HmlK/J2bpFsXiYxaaoB0S6xKPZSKcaybtG
	2G7Uaz7qK8WFTnsKXDBwxkekzqPe4wXkgkivwoO6ByKWtib6i6ruoGsf
X-Gm-Gg: ASbGncv4ATSs+uMCX/DcwBDUOWBSTB9wbUNKMQxKdsDXC2aaeB6R7LIiGeiskh2g7+g
	gTvaAgRfydx/qF0hG8syXPi+HjTFhZeIZa5uzkXBvU5Oh3+ud6kJDiosVznQQc7SwRDPmyYzQUU
	AvmCjuT/WEqwFzqmNuNHM6DhWzdxnWkPv4c/OqwPT+WihDgpoqO9y6WHqby/nGKkDU1/gjMlhGr
	Gv/Gp9P2njPUjLjWEaOiKEzZJwh6f0GF76pj1TQJ2h60HgqmzUzkaSertz1t4DflHxpsqZ/6AVX
	4z7mAbGqDiNlTV/ysEjRYXcLPDPIOqIHW6yc5DNQGr/M7t8dcJgHD21dLYnH0o+VNnKYJK3itPc
	4IZ3V4ZOIF25Bw+9cIHwRRMRWztZesjUM7HJCBN8=
X-Google-Smtp-Source: AGHT+IGP7ZuwCDqeZjCBxqR5XKarIbFCcj5/SQroX+zbJQ0cmAChrym66sKvNxs2Vb5InXRZDBfTAw==
X-Received: by 2002:a05:6512:3b9a:b0:553:a77f:9c45 with SMTP id 2adb3069b0e04-5550ba16fe9mr316348e87.39.1750969973335;
        Thu, 26 Jun 2025 13:32:53 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2401f7sm142363e87.30.2025.06.26.13.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:32:52 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	jgg@ziepe.ca,
	lyude@redhat.com,
	dakr@kernel.org
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
Subject: [PATCH v2 0/2] rust: add initial scatterlist abstraction
Date: Thu, 26 Jun 2025 23:30:06 +0300
Message-ID: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

Took some time to re-work this after the initial feedback but here is
v2 of the scatterlist abstraction.

Basically what this version accomplishes is attempt to enforce proper
use of the scatterlist api for device drivers in Rust. This comes down
to a couple of things:

(1) Ensure ownership of the backing pages is moved to the sg table.

This is done via the SGTablePages trait. By allowing users to implement
this trait, we allow users flexibility in how the list of pages are
stored and organised. During construction, the sg table takes ownership
of an object implementing the SGTablePages trait to build and allocate
the sg table.

(2) Prevent invalid use of the API such as retrieving the DMA address of
entries of an sg table which is not yet mapped for DMA. Another invalid
use is setting the page entries of an sg table which is already mapped
for DMA.

Safe use is enforced using Rust's newtype pattern which allows us to
ensure that only specific variants of `SGTable` objects are allowed to
safely return an iterator. For example a `DeviceSGTable` (a sg table that
is mapped for DMA operation) is the only object allowed to safely iterate
and retrieve the DMA address for sg entries. A `DeviceSGTable` object
likewise is returned only by the safe variant of the dma_map function.
Also, the set_pages interface is now hidden from users of the API and is
only internally called when building the table.

Lastly, a glue layer provides unsafe interfaces to help in writing
Rust abstractions for other kernel subsystems is provided (currently
targeting Lyude's gem shmem work).

I'd like to acknowledge Alexandre Courbot for providing the feedback and
initial idea for the SGTablePages trait approach.

Changes since v2:
- Drop typestate pattern. Introduce SGTablePages trait to enforce ownership
  of the pages to SGTable.

Link to v1: https://lore.kernel.org/lkml/20250528221525.1705117-1-abdiel.janulgue@gmail.com/

Abdiel Janulgue (2):
  rust: add initial scatterlist bindings
  samples: rust: add sample code for scatterlist bindings

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  30 +++
 rust/kernel/dma.rs              |  18 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 390 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  29 ++-
 7 files changed, 469 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: 0303584766b7bdb6564c7e8f13e0b59b6ef44984
-- 
2.43.0

