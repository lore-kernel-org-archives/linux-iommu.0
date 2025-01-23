Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346520E6FC
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737629039; cv=none; b=pdZMc6hhhjweegQXU+uWH/lIkHruivbfdUgavr741CqAzzGhHbkzXBtkr9juhpI9RleJ3tQXo7PJKYnD+7atHQl5DRLhBU1ppJjMOY7vFke5/Ql3k/udeeqOvNsfoAPATzxORM9S/eB7JtoFhe18+HJy4n5aIqd2itQkBxpi7Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737629039; c=relaxed/simple;
	bh=FNwkKYtNgY128tT+Ow8mqes42EjX7w9jGfWwlvxYpFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWpDFw4j3Ad02D1LhKrQnYd9NtqYKPTv6VIG2VXyqCx9ejMva2l3nSZ04TJTsEDpy5OEgPgoV/qzILWSGRw2QMeVAG2FAhnXPcI75uhn0/S/+mbOMLzHbfQTR1QzPiwTU2/qbutEQYQw+86tClKjqFHHiH3meN2414ia7rZluM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHX9JVFo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHX9JVFo"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439a6179a7so837432e87.1
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 02:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737629036; x=1738233836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4s3hoprJz1ioDJMXWp67H1qXVNKWcKbvshZNe+AKy0=;
        b=QHX9JVFoV/Zr/bKv9n5O18d4i5//9smUam7gHFmtKLaHvJvdTd4xz1GPxYG0/64/1e
         SkkYGf+Wk0pGkRJvRRGsRAzMNAAeamwlLovi7Vstf8UE82Luaad0uvBM16RAD58j+sGs
         +fYlp0qGzBsyZneBsp32xZvliufsgkkNwV5fSttYy0RZDcSIdI+F3bIggh8oCE5lEeSC
         qS/m9Cx5VNSpU5WBuAxzmHvbfrGwVL9jGIsou3CDeo5JxNkQySQ3ujBkO4OD1/FQ9Oqw
         1PpDGdjZ/Zf49JeKaQoGq8viKd31i6//wcQYWniQgqwLISRT6zYr2zLLfVGkNNlyR74e
         3sHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737629036; x=1738233836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4s3hoprJz1ioDJMXWp67H1qXVNKWcKbvshZNe+AKy0=;
        b=g4CI6tJG2f7dTwFnL7f3uDFC2zVpY2qoiSyZIm0BT3B31rggq7KrSFHpFz4eYaOlqP
         Ijw6bpNrdigjbMOD//FnsNsqb/6DBaWNGMvGGfXA9RGy2bN2Ie7qhBoQ+r4Sf2gXyItJ
         LOLg+W4kqGLD/x9SZOljH+xBIKeK+D/LDFjdDnQ09lnh6IaitXh0mx6sFA46Ay45nMNr
         Sc/e/u55o3Vy78aZGJ3duUPEgIOvdficfXDX0jUzw6lY0hrApPE//pAGy3owOLEuxS2k
         ToeeYIwCn1sUfPNkQtYgNyupW2yHPDzTcPHnFOchi8gYroEF5LhFx0I2Vfx4mhRmP9Rm
         vCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPAe0zvV5Rr+pK8WAqeZkoveJE1CBgASYPLNYYHBKY2UoFbi18Lfe8RKYZMi/STxIJz1KyvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkgDqlQHsDL+2YiJAM2tS8V4rrxKh2eTkPDGQbQ5zO2SYQ7P4n
	nZJYqzoUwYLBLCEoY3DIuRqjp6w86iYAwdz4v7emcp05MB34j3sQ
X-Gm-Gg: ASbGncu+rpxm9zx3TELJSNkNJ0dXwxDKt7VxGnKFMAigFsVjmE44diJY0kD9QORz0UY
	j5Mnxh1OEy3XP05wNpue8A4kfebg0QPZ7KAuZ+l1R5XujDBru29IVaytTOH0InsWb1cx5x2Ae01
	h9T1b4tTcGBHmeeIYzPYhs58gZwRWIxisRNBCpzJiv8vuni6ft+UHvNfDBPEhtqCisYY8lRbPmG
	Q+fqZQvHEVxgv9LdxmuJsmUEmMjyH0EBMG84x4Z8DeSGfLzZOTeX9iBQ9EL9T2/51nuvtRGf2bT
	01uXEsVFZ7Vn3C/fvMuli1FTXolw/E9lcNaQrfi9wgdeYJR1F8M=
X-Google-Smtp-Source: AGHT+IHcT7/RQNeQOAcU8PvDPDdbWBolwS3y95KvFPLTulFvDVapY73EUjtaarvuodv6G+7bXgxMBw==
X-Received: by 2002:a05:6512:1044:b0:53f:67be:507 with SMTP id 2adb3069b0e04-543c2278880mr846834e87.16.1737629035933;
        Thu, 23 Jan 2025 02:43:55 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af0ea8esm2579873e87.80.2025.01.23.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 02:43:54 -0800 (PST)
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
Subject: [PATCH v11 3/3] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Thu, 23 Jan 2025 12:42:59 +0200
Message-ID: <20250123104333.1340512-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
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

