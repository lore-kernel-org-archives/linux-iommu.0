Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BF1F3BAC
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237656; cv=none; b=StP0zYfTVrp+sqC0d8IvvWMAoz1suxrrXmm1t8Q+xdKdoUKtquWTOZGWRsLpRxBhVEf1TjD0bpfZMrJGEwBk8FeWdYZfvA28kgXe2YffRBZ7fhRPlWcupY6vFTHh8CS+m/2k1fAQim8i90NLkFq/vNWIchCNKkfjIYixZPguOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237656; c=relaxed/simple;
	bh=EPWDPC+fJnBBU4GpffSxWKMg3/m13OBptFGQuoDiMs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqGrr7AasHOpET4NymMHP8cWXiD1F+eCgk/uZYVjuM/YkZLgYMDLIYAmZRzIYE0tpRR/woGAQXwaG8fszz4XOAAyv1mm+YChgI9dsf+Qf6xoknaXkPaCD327eyfKAI3Tt2J5+gHvN/LpsKDfiUZ3/W8DiYw6Vs3njGcKfXGJ2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWjg4umr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWjg4umr"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so5576372e87.3
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237652; x=1742842452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZvup61483wzLulSQOsIqtlJndDefRKXhVwq8k7pdZg=;
        b=DWjg4umrKq9IFlvSK3iPUa0hBV3tviyIiECGqOO+TuMvsJ0SthPkE4K1SnHQDcZwnL
         X8xawOM61OeisZo9VA9ueD9vlMYesSgzA8T77b1tF4lP4l8RebmFl+sNtSnfBRXiio0Q
         E7iqRRm98r27k9chsK2X5iDHL0clCBlXpwVAdnr6lhCeMuaq9kMlRstWCLnStjnayGtf
         fIlof5BbzcpTAwjByvBpsAYqu/aPf8SBvOS5Q9BXROoVU/UQHlAEb5AapAkJSUZSIc9K
         vEBLZYgawFTTFJhlcPLlQbkDlzPDcwfgD1f/3/DEZcVQGRTQWQFBPnrrqTu51107t5tW
         l3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237652; x=1742842452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZvup61483wzLulSQOsIqtlJndDefRKXhVwq8k7pdZg=;
        b=B+Nn+ju190b70RF1O0B9UIoJolH3cZlBPcSaDmkboD9oNCxHebtX0ihQy18SKQ+bTj
         V/q77n/jMOSAZdEthP/1oywVUCD3AbfI3KdMlSCfe69rdHLGjZpoNKzhPD3s/jT0/OEn
         M+k3457ClyCuU9p6fPoI6wb3VDAvXZHAcqgaR8FOLnz1lXi+ZJ+t4X2L9pz0Wo8Lsa2w
         XbWMdPefdjGg2yueUCuLMySLORiGOhclh7+iBmA+4IL0Pd+ZgXXaybZjNvcFmFXe6GZi
         1AcYf9Ao38/AhUZbwk9Ne3AAJYWIRfhzcQ5/43bOnnHWqAzCZOLnmVZ5pU/CU2J3tVZC
         wLkA==
X-Forwarded-Encrypted: i=1; AJvYcCWkt6FK6vLk5hMFqk8BuFbPNsAiIAZxTQ6YzuMyMXAYkvAiZqlQcVYM+HiVC0jnafdgY/PWLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIGN75KEDJF3rxeLLXkyTAQc21TNx8+MUpRkckphUN0yfefBCv
	rHXsfVF7nNMm+CHSeKC1pofEAJq/ngkIDAl30U5fwHhv9ML0iD6x
X-Gm-Gg: ASbGncutu3Xx+5DBbvQpUEJ2b+rZ6oxeMV6Az1AE0gLEzlCtqGwQcaZRxwD8EyY93ul
	EjPfmdIprjsAZmu/9QHG63TCivySR/KtukjRqnOlXmfuRYQlEDcJR4KQ6DBB21sqOSqej18xqWu
	gzYfIeMw7FIxn9FZSBIUtZ2ozTKo3ZEzWcMghWjuaOrcZ1BhIdDlZwe5tc4Xse7OlqL4UIHjLOn
	IYUt70EK1UFqE+E3NLmxp67c0phRVfwQu6GAj20Om5K7fndb1NhCfl2EO5U00TWsgjSEoJDM+Gg
	D6mJcYjWH+9nQZ4g/kNyv29rojG5ZoYyzC+DE0D6bYvXffwPPply3VlC9j/pWTyfnsAyNbW5QZ/
	MD492XUoaAd9jCuBMC/uqUA==
X-Google-Smtp-Source: AGHT+IGtX9zm2Uw55vGFTyqp9oaT5S5iJxffQf8eYYzjp5zzW3dESN7bQoHL9dB0Rop//PqH96BF/w==
X-Received: by 2002:a05:6512:3a8c:b0:545:576:cbca with SMTP id 2adb3069b0e04-54a03b7818cmr792338e87.8.1742237652127;
        Mon, 17 Mar 2025 11:54:12 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:11 -0700 (PDT)
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
Subject: [PATCH v15 04/11] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Mon, 17 Mar 2025 20:52:11 +0200
Message-ID: <20250317185345.2608976-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the Rust dma mapping helpers abstractions.

Nacked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b88f1638a2..4c0786336826 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,6 +6902,19 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
+DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
+M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
+M:	Danilo Krummrich <dakr@kernel.org>
+R:	Daniel Almeida <daniel.almeida@collabora.com>
+R:	Robin Murphy <robin.murphy@arm.com>
+R:	Andreas Hindborg <a.hindborg@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
+F:	rust/kernel/dma.rs
+F:	samples/rust/rust_dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0

