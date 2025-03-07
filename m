Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD512216E23
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345732; cv=none; b=qGVW56Pe5KLowWdKSHmmXlcAAlt32+W/4J9pW1qpgsrcR2fqqRsNuihMSt+Zk3BsPdQvXjvugeMjg3p5ZHWhrEUUbZUVDNuy0WsadZI3CB9YZmfjWSUB2QDN2hluL2ItXAeQaIGHeygxaPLm6iJq5f2JdZztJBEo38bqGmub9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345732; c=relaxed/simple;
	bh=EXM0h+nNXEzWwA+37YY+ZOrUkAfwYMWN8MLzC5oEIWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkeBq5aFD747vqV7ijRUWJHimLhlqImPjQxStJA4wSxIfHWLq/eKEiKM2kHkwhxug5n12cZ5kgdblG5J94w78Wmm+ketCG4/nRF3/iVka7fYUZZs1nCurnviFAApgnMDTHDTixDFscweZXk+dpBo8VYbRMFdzJfhsjvjHdpq560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaPa/Fut; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaPa/Fut"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549963b5551so80159e87.2
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345728; x=1741950528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLJkp6MLOD1BiDeGrlidAjVqoKEfJEO/erWzBeDn7QE=;
        b=SaPa/Futvy3aIqh5w3VqX3XLyn/355CgJ2lXTVNUvo3ze2XGsNGEzjtR6okglGEhur
         luFzuapoP4HLQMo6RlhqU7jQN17wBUZiOBCpLGeRE4HNnsm914pbxpDHav6JrvWrZgdl
         orqtMTLrzvrKlGR5sUsTQfP8wYyjHArK+Xq7QxIRTLMYK08TTMbV6+soMVNI+Zc/eYnW
         +cPq9qz9JLoBf41rtNJ+sVZ1A0LpoSL6QR88wp1oZq0sdwagqwdPkQgpuh1XEbNvY8tk
         ttXz+vJjLNUVgxJHloRMJuhjW9sqwu8MLvVyZibMNKqmpE1YuCTXR8EHMUDkbJGnQiVc
         ZJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345728; x=1741950528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLJkp6MLOD1BiDeGrlidAjVqoKEfJEO/erWzBeDn7QE=;
        b=rOCZVBzZDN+8+Re1WM76PcRtXI3vxUDvT2Me6h3sdcpunuwwvNqwOg8KUDJC+8YXHO
         XzQVvgT00aHuwY6EwRhGOCdVeYuXIDEsgjq8YR/F1LZIR4wjB9O+6eTOPAnpShq12W+8
         2U3GMbg0ScCiOR4YzH1CxI8+6EnzrmogMFo1oBmmpNiMvzRQsHpSeQQ5+WVka7bkblS7
         +va05Cd7UsI44Pd931EI4dnGkrgj3EU/Egc3/GPU7JSzn1zCDT5mo8JJ3uGDJ22PVNGp
         5zkhsj2uJDd4LLrALEsQ25sHvqVwTMBSasXYlvKkqfT9LFnY8uWU13KP/gcP8Y4AmStS
         kBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBdNP74AS9kgMO6LE8hihZzNmD+PMbLCM47aaVt1T9+IJUSDtBhr81Bhirh57T9H0jiBFslg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6KyVg7quYYlf9c2KaNYxoe/UH8VTweUZnKXkTyUciFiaH2YGR
	wwA4o+gWcFYrteqMyuW2vEdG3MtROz9QZt1Wtp3V0kyWl8J/bjUZ
X-Gm-Gg: ASbGnctYJG7E6gQMdqbZ18ODHe2JMlgLNuK1YioaXMl00OrzpmFcMCOzQZtGQITCM/8
	aDtFG2TzfqZqBNb//97DjrM2d0znoeizCg7qw0rCO1Uv7mq3dkg2RkK6hnAVNXpm7gJvLgh/fux
	VgggSWiXz0re+sawY5vxM7LnLgUd8UnhywfqMC/9/13XrgdutjOAhsz94lyBl0XQkkUFeJgE1dB
	HgjjdN09opATO1WXEXpkvwt2XrKrKzjMKX+WRvDHy0KmmjhIJPNUQvTZn1o0eBa9nk5ntTN9H5t
	jxuWKYrr2DFMaBmoxliWnTybWw7p618/ALmR0czYoqzBWgL2WCenxXsKOSUHLGseedaMgj3S/qs
	7wQ75j4HQBbkOQlqLiT+Qzg==
X-Google-Smtp-Source: AGHT+IGiGpe6CSJJtkufhdPB5iGLtwq4UxbrTZKaH5A1Wg2RvJPmdaO+/Wjn/2beT+7PpJmdLcSDmg==
X-Received: by 2002:a05:6512:3dab:b0:549:8d2a:880d with SMTP id 2adb3069b0e04-54990e5005fmr900677e87.21.1741345727697;
        Fri, 07 Mar 2025 03:08:47 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:46 -0800 (PST)
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
Subject: [PATCH v13 6/7] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Fri,  7 Mar 2025 13:06:23 +0200
Message-ID: <20250307110821.1703422-7-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
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
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f2d79ce174..72daf5db0242 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,6 +6902,18 @@ F:	include/linux/dma-mapping.h
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

