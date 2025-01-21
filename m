Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E801BEF83
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449327; cv=none; b=axVv1YIS4GHoiaT2KXqrlQMH4QX7Rrq7QQv01HZ6JK21EuhoJpELYcnIjaOTHw3Hh+hwN2pOy0btoABhmzH1mLYQRzfyPSKAOpXX8RhJJ9c8851jqIuP9boJn3xOjZoEGyNEDOA/hMZcpKQSfDLHI9UgN7UYHDUP/m8xpLN85jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449327; c=relaxed/simple;
	bh=FNwkKYtNgY128tT+Ow8mqes42EjX7w9jGfWwlvxYpFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R46RSqTtbB8tkw8Zb7ypPRg68rrv+l0r2ybaAQ6TyRohRRg0JQdrrfQbxGnkKcYnWEs1kPomKvzBgiCVOeA48pw8LKkJwKFKQyGYcw4jeUN02Q9in6slbmsJZvevUipB4sGLMEbIEV8sB0iRLHISX/hD/BYTuwPxSQsQBb70Pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDEiYAo6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDEiYAo6"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-304d9a1f198so45252481fa.0
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737449324; x=1738054124; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4s3hoprJz1ioDJMXWp67H1qXVNKWcKbvshZNe+AKy0=;
        b=fDEiYAo6Cg+jw84e75diwr0y7t+uGHJQMHIOB2v0/5fqFFaU60OW15LglHoSUWRT3E
         KlVDuJH6jlgX3gsZS+4bmQK+kW3PLhHwtiFybhtoDFnJhiBaBsnrmmuJKulKyP5hcjsH
         aWC+RaEkT9LAuWM4Rcnj3xAeahF7gHFxZh3Rf4YcSHwDE3nTa9LtaW0dvK2ZzkJ8KsCd
         GlGWZVHTw7cYyLN0XRL+ahOUl+ZMy0dQwdror2raxr7Ep7/nG81WvFGLaB5QcTaa1myF
         JBgcgwekxEbOFMTABcwv0YvVpDCEonS61sAeU5rg8JHGK5LbcV/k/YYwN9sz+E5M57Jl
         IK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449324; x=1738054124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4s3hoprJz1ioDJMXWp67H1qXVNKWcKbvshZNe+AKy0=;
        b=TxHtzb0Re2Tn19mROaux6QHDc3dSS71Luryhep/2BR7dqhXI/u+F7v2CRBPjdZlSpF
         0jP+FZHwIlPK0/5Rz4KTF7WsmIb++mQkZCiPKIf2jsg4jaiuk6WHI6gNay0bF6Gb+a/9
         osh3LFbQUBfTvdh4/c/UtUFfkBvUbJayutX+4hkOrQWLWSXvAhCwiV6ZIJG7f70/9Kvw
         3vEiNRVaOoMyj6b52d1mq74gelVxOpbbE/mFZ+cG8F8TtyauxYONfgTPv2xxU9+2nazO
         JnGLNhdcH8J4Txl4isfQYotKKJ63N6qbfb/KgntUkZ3VWp1UEURuyPt1Q1REQ3q8ot4J
         IuZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8waK13Iypui4rf3vBZOp+C0kgrHyQX5j3PgNh7/D9InDAEDYwdCD9aUyNx9AG3ZjuIsEMBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/89m8FPtT4i/cDLQbwN8Z22gLeHzTz49oJPBerklS3udH/R+K
	+yxBrFiWdT0ucykwaMbGYa67qsZXG03QvKLnld49gMNo17t/HElk
X-Gm-Gg: ASbGnct24+wdSGUNfIvNqhiQpOye0yYIW3sKypmoZRpIMt5d3RrACB1aYr2fUVsNe8D
	5EMOSVZsQxnSyqsfWVeWF9g21b8W/vtS5jV0NZ3tyV0TWPSMMiW7CI1UzKc6EWTK65wM82zIYEa
	2I5KdkI1QEcbpq+bf7AZrc7tbTtO/r5A8jqJlnaf33TnXmDFbMWOS2iAzUhdoKQlvjvWnxx417V
	/dI5ELMrcIYd9jngEUMCtVm5KfecRGns7mNMVdzaJzlHkPP+ZvbfJiZm4wkyGKmShd3sU4hlslj
	cQXIeN/XIGRigKzwxy7S9ugwC2h28xYIsR9vH9qv
X-Google-Smtp-Source: AGHT+IEUb+pKUur2MAxOyMFl1SvfLwa+rQvrDMr6H+dQ73p04UtbHXpzu1PqQqoMBlDfg7V3YdMuRg==
X-Received: by 2002:a05:651c:b24:b0:300:32a3:a322 with SMTP id 38308e7fff4ca-3072cb1f715mr67961381fa.32.1737449323788;
        Tue, 21 Jan 2025 00:48:43 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed5c7sm21178651fa.82.2025.01.21.00.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:48:42 -0800 (PST)
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
Subject: [PATCH v9 3/3] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Tue, 21 Jan 2025 10:47:47 +0200
Message-ID: <20250121084756.1051758-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the Rust dma mapping helpers abstractions.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..4808c9880b3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6822,6 +6822,16 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
+DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
+M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
+M:	Danilo Krummrich <dakr@kernel.org>
+R:	Daniel Almeida <daniel.almeida@collabora.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/kernel/dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0

