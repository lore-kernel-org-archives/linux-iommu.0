Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2DE2638AD
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715395; cv=none; b=g3rxzHV6l00YrhSasC2RK1mSdx/gOh4a2QJxTV495y4gui3QXQkeNHqJxoFj5lSOUnLuhcGwiQS7WzRK2bBnpLjc4bgDSX2FDXotoQfflSH/J+y9thGP4iCYNBETlAxK7HAKVkh5Agcvj2xvtmtL3g9iMmKzkGp5vw58ssO4v/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715395; c=relaxed/simple;
	bh=kcqiy6qGt4Y+kxGncSLGf72ytPK9edLXcjO1O4LH7hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0hbd2xAkcG1fJBbEI2vosghdbhVxoEhavaE/P8cOX113/haXRM8W31ihZxho6vPRfKvW7s6/gQUKK6hxTTWO1Fb9+1HDmWtnzf0n2mK1ROJzKkrke4n+MqRw9MNjtIhcrqyE5tJsXiq7NjItbZ1PcCK6HEMvpKdeAXJxOgsThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mlgliwoi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlgliwoi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c0517142bso31359951fa.1
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715392; x=1742320192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14YkA0wGL7fYnkvOubGO+Rkt0qCHzCYEIoKnBb0OOUg=;
        b=MlgliwoiG2RnK4+BPjIrbw8LeG3QeFPnYrZgVcNfHfzzVC7U06JO0XZEaGb/lX//CW
         LdizclZbxbq7vR76Wov+uusqVJ4qiiOYaTVVc8BRfsAZLF0kFZp5GzVJo7hcPzVJ0EQV
         /OvI5+AUlFZZBl19GZ8C+Ukzq4xzSu3+19ie1bdqPizzFLfJTnobayZdQ/3EqWjpHzHE
         eVLBeHRLz54oZYtQzniZDU1AAQLsVxZgTFE1tAKG1fRm6yqc/WkzPnK9Z1JhmTi55ln9
         wy+WrY2CAbxLXn5eoli0uoZ3Vq5BsY22W8+CF0ZTmsbmROqXpkUIL1WhG/n6/PdXwAMJ
         miCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715392; x=1742320192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14YkA0wGL7fYnkvOubGO+Rkt0qCHzCYEIoKnBb0OOUg=;
        b=dTghV7CO+Po57N/IK+UWErwR0O+TAEkCw333cByQFGA7pYn3SBQqNuS/3vQ7QqSvyz
         qs9ncyx5CBZgfPiyUEr7yiinQFjR1AQOPB1UNIaB7hlwMYhOg0EteaPWdm0SnU0MwUqu
         7Vy3GU5bmU5YX74LeUWQgYcNRAt+TtvuHcEvwldX+uEdUEpBSuWl6sWLfUXkfE3n0bIA
         U+3zSg5ZgGZYWaP6HfRy4Se4C7R+1xoQbfgI5NAAof7BRfJ6RhEzzUS7RFCfDLoZH4MS
         M1jKguQgDx8XjcuXpziHi907MsjzTpcHN8rBgxQ0rmBxPZB0660XXn1CFC4i5r82BxgU
         l+sw==
X-Forwarded-Encrypted: i=1; AJvYcCWDHMkRThUBrUHzqQ8NAD1L0RrkzHf7PKLjFXvxeLXyKpga42pZwcXILkxErVl0L6cqAYkqjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf8ZdWJNlRp5zCBTC2Aq2ggxISLESXMhWHlvcWGq2/kKSeI0jJ
	nP1hF7ecc3v6S5rxGNIUBb380lJcDUKi16mmPbGSswPFRzT2KO+Z
X-Gm-Gg: ASbGncvd09hRK5srxRImcvhDj2ZabWLEt0u+GNOAzeIDifMbprSQjFWLOxbaY5YwwpI
	pCkwhh9WXMLNevPrIin9sVZwTg6uWuSoWnaCR3sXGora2FX0ICQ+OtyfD1Gc/Efw2HwoeeTUOUq
	OqQ9MtNVOPazvY4GdIH24IXzWOcuGmUVHYicsQokdVW0jTco+UCUc3M5+nX+R7xp9eEhzz50oXV
	S9gPrJaupXTF/y5VQ+X3Sy7rI8983p1FooXkLLTPh/z8BtT0Ey2U1eFwRWHGtA2CrWe5+3DdeSO
	ZGwAgLfKS2oRrxvHqIOakoi60uiEFm+zYVkZkua0fXthy0zKFBWdaXjJs6ZBP9FcUcnug73ovmK
	GJZY1zyK165CikNMq1s6qTQ==
X-Google-Smtp-Source: AGHT+IHOS3hlQgJU64hUJKXadQ+ab5L4zyh26dMc/jdCYKiPNtOWkm2Ahv2s8J3tE0GaKNyF1kyskg==
X-Received: by 2002:a05:6512:6d6:b0:549:8d2a:8820 with SMTP id 2adb3069b0e04-549ababf0ccmr1847721e87.17.1741715391892;
        Tue, 11 Mar 2025 10:49:51 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:51 -0700 (PDT)
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
Subject: [PATCH v14 04/11] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Tue, 11 Mar 2025 19:48:00 +0200
Message-ID: <20250311174930.2348813-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
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
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 007ca67cc830..aa49c551fbec 100644
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

