Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FFD25EFA0
	for <iommu@lists.linux.dev>; Mon, 12 May 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043782; cv=none; b=tapckYKC512O1MP9MEqPitCPoQHc8+YAjj/8qy8izm7yuDS6HbHi1U8PUUNunDmPosSIxV7kWHku4RKHeUSPzVl+4aIJHY5tlpe4BO9HIZfBu+DTBsa2ZxEVn1Db3H5y+yXdgta27tzPZY6SDpNkLZZBHuphzH/hbv2oCovMLQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043782; c=relaxed/simple;
	bh=OlbebHoLu4LXG8M5DHLeD47dN2+hbpUNsw4GjMsaE6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSO/9Xb4gJG7DGyFkBGp6pWzYZVHXLJDasXm7/263SX/zEUV+lFJlxWLdh3bs+nNF6+aoIE7WrXjjDa9IgdSZ6ju4mw/oZhhVZSkyxv2QSfDE4W59sjHRYbHlKSLj5hXNj0TG5A9eV2Bw03yneJL9DCBUCjnpW4Zza69lFcQQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV3HVUkp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV3HVUkp"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so4238754e87.2
        for <iommu@lists.linux.dev>; Mon, 12 May 2025 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747043778; x=1747648578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6xGlGBkE1m8gu0/rjDmatj+Hz4dtijC/JB0CSfGWno=;
        b=VV3HVUkpdpttra3RNruZeI1vAchkRp4OYVxGxSlbjeRVEnLNCtbOvrq5TGHpv0n8Wl
         VpC6ez5MSyz8+67MIM7DWARyH/3FsLCz9gIsLwFUYtZ40ykOwzA3gbPUwnTCm7uYFgvl
         fouB+K+ruXczdgwGrwA68jc0dUMv4QEyXuAVQufLXZ6mQIjPxtrdArVVxaM6OQzUUtJG
         FXivCVM4eSQEQMKUpluaB92JlBmKao//Vqv3YFDZsDAf+L8PdgOiUZD88eJNJIqhwbsi
         gRjRo4LbTmkCC21bEclWicnOw+beFfuQCLGufV915M6dOeVc3FGk0VM7KKDiXHGzWc0u
         7eMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747043778; x=1747648578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6xGlGBkE1m8gu0/rjDmatj+Hz4dtijC/JB0CSfGWno=;
        b=YBkH4sILtD85si0iN8y1j8Z1EN5v4stPt9ekWQzTzslKTKTRnXroxwmwoyGcEpaa3k
         cX+wOUo486IpXK4akzxJBcNieiQa0nBtxFIUswqvUPQ3wISxNtzghcsZQ8hDPA7lX30T
         jUALWp1i0lmLmv18gY0Lp87GomwyHxdQKm/g0/LqMPS8yrCzTdKTPUVwtgD8RkCfZOdG
         SWXyEzgFqttTn2WZzYeQsOe9JWvvZprjBRbgNJEOUSTJqP0zYUWiYpqIhvFbA/+t+o/N
         FjKYL4mIcUDDmcrpqI8n7b8Yj83lKCCg8MYxqouXgL5K6T03RXNOAA59ntJ6YOg5mdKJ
         y3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVZJQz5PH8bc+75vtfrQ4+GhdED1qa4J56P5hMnubecDf+JUoVEe0L+A4uhsXeUZKEjaQPo/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsK4ImHfluq8dGWJBM3IZQR/23pH+nidaZEm2f3BZxIq0AP3fs
	Htdn/2kMLMzeHEzXT49dab1c+z12DydD0kGB57Tk7aZIbMS55oEt
X-Gm-Gg: ASbGncu86bH0PPC4AENpoRdZdS2Cu54BUYnbc4adc8n8xnRQmB9qfg2SM968kSyPNC2
	BpSDfiT4vExb9yHMkYM0xVBCP7G6SkFYY1Z+MIlv0MLZkEhf6J6wlgA8/LWFXF8kLAIpUT1JggL
	2I3bswURWcMQdOsvf+J/qukQOtAZEJts14AMUSiWYyhIX1jOk4nJaXtIizp9lDfxXPWINBRfU8i
	CxAH5v5R6/HS5Xe3aFzEqWVfmiKsYFscqEEzsPLgdC9SdQxDDbLLEeg/0COcaq+2rZUAdVimgJV
	dwWqZ8MTeWBJqAKiJZ+aMhq8/S72F2F2FHeqzrZwEA1RukqmrnteFi8jApAuchql7RI8Id0F3vE
	CXMDOJLcU6oxcIdV4rjfKYM54XQkNBDRL7v8X4l4=
X-Google-Smtp-Source: AGHT+IHVWWri4vLZs2whHIUJWvjl7yMbyBdtbTF5UREoIyZ4wrhRYZ7fIdThZCbA87BC5h9ImJP7aQ==
X-Received: by 2002:a05:6512:4408:b0:545:944:aae1 with SMTP id 2adb3069b0e04-54fc67ad8bemr4406415e87.12.1747043777823;
        Mon, 12 May 2025 02:56:17 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc644fa48sm1460449e87.1.2025.05.12.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:56:17 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: dakr@kernel.org,
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
Subject: [RFC PATCH 0/2] scatterlist rust bindings
Date: Mon, 12 May 2025 12:53:26 +0300
Message-ID: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are the scatterlist bindings that has been brewing for a while in my
local tree while working with Nova code. The bindings are used mostly to
build the radix3 table from the GSP firmware which is loaded via dma.
This interface can be used on top of existing kernel scatterlist objects
or to allocate a new one from scratch.

Some questions still need to be resolved, which mostly come from
the DeviceSGTable::dma_map() function. Primarily, what if you call
bindings::dma_map_sgtable() on an already mapped sg_table? From my
experiments it doesn't seem to do anything and no indication is returned if
the call succeeded or not. Should we save the "mapping info" to a list
everytime we call DeviceSGTable::dma_map more than once?

Hoping this initial submission will generate some discussion. I'd like to
acknowledge valuable feedback from Danilo Krummrich and Lyude
Paul in shaping this up.

Abdiel Janulgue (2):
  rust: add initial scatterlist bindings
  samples: rust: add sample code for scatterlist bindings

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  25 +++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 275 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  14 +-
 6 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: dd21715de3dfa6f6457432ce909e5f7eb142a7d2
-- 
2.43.0

