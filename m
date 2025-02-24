Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D226137C
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397843; cv=none; b=gLo3LuClU00uV013nrxRYtZnh5reNifjTIuCnhB/LuulZsMKE1z/TrnpUjAOD7DDR057bNOi5TsASDHT4p3ALV/TkgeD4DQNMFEYtEPqZRyKHWFiW0fNjwkBExgTmGeDtuIvXtrcL5HT4iyP2rZyzHO9PzrtQVt0t1Mnk2D6gPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397843; c=relaxed/simple;
	bh=exnmk4QoMfx9qtW7vQx3ctX13oqT61LfRTvCDXadsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz6rzPjxcW7n78JLcTszCnQ9lDPMrXQTaTzaCpnQPzyCkQWN/kQBNx0Ny7I231tkS8PnwqKhTT/x/V/jlVDF2V8oxikXr04B5Ofa8n86BCMkP1LG6t1unGA3IDGpaoG+ChMeqNIEOuf6UQMpAcp8fa6rFm81goIIcHOVbB34NX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW09FjYQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW09FjYQ"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a303a656aso44017701fa.0
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 03:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397840; x=1741002640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSEFC3Z4MM80reKv528I94a4MnIklfvmUttoKk+o084=;
        b=IW09FjYQqgMexkIg3ZAALUDN0k6TREdxZ0BcquVTDOU8BTqxCY+ZM1uA2i4V9lkyqN
         YdMZ+qvWWOSYXakPZBj5tyxJc0Db95YCJW4VvZY1qUqGE18PCbBkqx+zDkbwS4Fq55r8
         bP9uzLfCf0G1SjyC/IPmwotSrbMlWE/NVxtZqaM+24uX1pvgK7ExpBJqELx2V21owNUk
         Uz6YCTbFcoBYxsVXrM/Yzmx4QFpYeF7N5Li8e/iFLrwBqhwDrDtSVHWXkfc2flGjee1V
         S1MS5MQSLoze7Q7kZIpFgbUfWCobxKIpQPIuw4RqFC231GA/VIXXISRpSP1pO5pvFAs0
         7UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397840; x=1741002640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSEFC3Z4MM80reKv528I94a4MnIklfvmUttoKk+o084=;
        b=Oajlu6FJJatqMUTfDyqQ5B+mxBFvCNFsb0nAly+JHcRqUX4T6RR0170vVA1mFa9elz
         Im+jegxTQxkc9EqB0MPLQ7JMQ+am6oKFuAnIRxalsxMmK9zQbgMleBAjceqrY6tbG6sn
         UpJfCDfXH4qqYWY1olrk3HNW31NIrM90WAvLO0fouxAPqzLbAv///odlDvSF9/SQ0tEN
         myy8QSMXF1D2O4KqywSQAyZzGQ99uRgI5/wWBX5znT7Bu5515x18RX4OCXhWxNasAZEb
         D1+YEo2a+9EYo+Ph9Y8qb5xu7U2zjibh7KPRs4hTGZy/MzI3tVKKFVgkq+bJpO1mqwq9
         Swww==
X-Forwarded-Encrypted: i=1; AJvYcCX4sasbvKVwA3JEGKVes9xXS2jE1XmDli4Ftoqz6HsF4jU9hcIifiAad38itwxQ50k+VueGtg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4nfUUjmt5E2f53ormLeOROskVUwad2hL5UsEbmOx3voiU4Cwy
	XR1Wbv5sGqMf5LBlYhUxCX9TR9J5+tZjJb+6eafDsL7n6IzdLN4s
X-Gm-Gg: ASbGncujsYlPDiZQ1pF7MUdJuRh3msUg92DlxAP7WEKmWHoq0nP/VUsKDkhmxsg59QL
	abVZ7u/JYoiBspm+Tn8V5VakhjzbGC3KHxDokWWZjuXGVDZ9fTcRv8fRX3TA2EBFKk9CWh/L6md
	2sNf8hQmeRjthWnMGykdskvRVSAzXmIgmf2bP3/u4AGH11Mi7F2D0LYCCofi//mZrSw9/3i95SA
	G0nts1QTO3kColaEAqWbU12GFzecjHhPyPY0x6Lg429K/jlC4m3NHxZ3g0eWx39iKTZAtYBghL5
	gNGNRQg8ZR/+xLb/oCxaz9Pe73EFAATbHUalIP6TCgNoCqnDK/Hmt6KMeVihTEaQ0F9cL4EU
X-Google-Smtp-Source: AGHT+IHbT/y6SIytgLwKF4WORSZ4NAzvYcWlOt4XTeSB+apsoFfrwhgoAxg4dkzURyJKOfKYhDQVIw==
X-Received: by 2002:a2e:9c06:0:b0:2ff:8e69:77d7 with SMTP id 38308e7fff4ca-30a5b1a09d0mr40853261fa.20.1740397839852;
        Mon, 24 Feb 2025 03:50:39 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:38 -0800 (PST)
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
Subject: [PATCH v12 3/3] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Mon, 24 Feb 2025 13:49:07 +0200
Message-ID: <20250224115007.2072043-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
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
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d9e8187eb0..3bf130c0502c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6900,6 +6900,18 @@ F:	include/linux/dma-mapping.h
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
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/kernel/dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0

