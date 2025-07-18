Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DE29B22F
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834856; cv=none; b=NzwHGu/EaP5i4CS/n2eUpdesrkBeUl8eVartMdCGBWUbRp2tYCba64oQIuJNA5mlIhjHnw9Bc/n7UEr+jYk1P97yvHwr5VraJ7dfb6CB5HcgOhU3lBzFBo6XD6F/n1qtYFyxDT3FWse9ccViKYBMzEbndBHFrDeODsTAvMcpTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834856; c=relaxed/simple;
	bh=URT4x0Acr8D69x0WfU/q2WOWVbFVaINnDpDK31b1/9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZj8mB0UrFsY6RoIeCU8H0S0OyepzgCXq3dXvKZtq8RMIsdiCc6Qh9O6r25zoc/hjm0hQK6ifU69tFairSyYoCO+iKWy5VU1FZj3NNORz5XJ6tNh331mwFpa7AHygutdjiKWnAE5U0hZ7uHkhHYYIjakYGXlpFEJFTV2qBuhDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZF/eq3V; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZF/eq3V"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5562838ce68so1897134e87.2
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752834852; x=1753439652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L16c/8jEUuiIlk2H4pEeJaRqtG3hOpwT7bIYsra1fiw=;
        b=DZF/eq3VD2C/3hAMEbKGvGbgH+SeGYZLH8RAj6JWYCo5WwBik7vS70ounf5cwaeW/8
         LVkcZLcoize7CrgxygexPf1ky6qye+rd2LoCRZ+0/BwZUmSQsiQpSbQx8enwlf0AOQne
         GCHguKI+gSg7BSlteftH0rehRRSutd4+Rw+ytp6vZDqsbI0XfoJTMEOv61rHWHw+R+TX
         Fsmqh9A2IEa6iRQEaJxMs8SAYLiwK7vF8IrSL7EXBTM3Sh65r7jV0hg7s279MrzWiJqR
         S+5a7S5R+V7a93fuD0p1ydbR8CJaTZG09lUQOKlfEixt+uFMpBeGr4uzYL5YrCZY3BeR
         VXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834852; x=1753439652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L16c/8jEUuiIlk2H4pEeJaRqtG3hOpwT7bIYsra1fiw=;
        b=Mj71msDIVv6xPeRB7BzjnHOGCf27adCVpqcZVbxLUFZatlsAK9pptYgvspGRYClAwk
         quEqpP3nZOLxyFO707+e6KR724gUH9IFGmJOTFqUGeARvRGtnWCsLgMCvPq9zmeq/rwa
         Un45YfA0RMx+dGCNL6JCa09yi7q6g1I8mxJpSOSvhhgYOsb7a6oY/mtLJi7dyzTQ18bd
         VaLXbQivbTnE3rt53p6+QzkSMWC/Lg0dMILiCmbMtCgZunJLa+Xv+FBDVXGVHqKY760i
         7nGWkwCF4MWsQgx262N9GGqulvPmB3iNeV1Q5IrvdTn1HHowJ+Xd9LchDTWz0+nPHX9x
         7xBg==
X-Forwarded-Encrypted: i=1; AJvYcCX/aEV1GELUS3tVaPafk7s5NXMy3yLzHmajk4x7b7j8zFmakwHDY7/llkxoXFYU/r5idTcX6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqf+8NL3fX/zOYt8YA2+povrbOG1fHJgy9TWgYdgfjgoQNZ3hT
	Adxy7c5LlP9wDXaeFOtf9/ZsoCniLiOHTSZhtGjZwUdrw/lisbDuQj3p
X-Gm-Gg: ASbGncvug/XBN4KF/6VSk2JGp87gzWKAp4SoLwizq0s9+YTr1fyR0QW5CDDuF2K7B2m
	LOekUerstJgr0e3PyKgEL5n3RsAs1il5dH5XsedK5UGOorvdEFK+I2T/lzSL30M9wfoK0FspvrE
	a0SK5aePAdVBaqVAou7jF0xu4JUoV9f+du68P18rFpMYWdsdc07fcfqfWnpRwooeuqdaQwj4eTH
	2oQsaQVik+tejQ7klSv46uFZ46DOwNr7xWxAdEjgPPPz32Qok+/CWHRgKbqobXn4ybmKqWlIGWE
	BAwrtwTciHuFLLUEAVXPo3SJ3c6lTT46YG2TtrsB8pmX/YVz7fjCdNYp4fWy4a+WRE26NteVAtl
	BAswG7nf5/DTO/H4Y+4j4M1qxO1h5kq5gcVOI1DbTmmFyOFAwHKjSZJ6Grks9ei39mOo4+pKVvx
	g=
X-Google-Smtp-Source: AGHT+IFFMGQELOhee441f3hfVlskDcHVYSyft1CA1/LFgX6RrnJxMgUqeZOwcEWvRatCceHUxRfGqA==
X-Received: by 2002:a05:6512:40c2:10b0:553:2311:e1f6 with SMTP id 2adb3069b0e04-55a23f7fad8mr2256705e87.49.1752834852016;
        Fri, 18 Jul 2025 03:34:12 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d9176bsm203689e87.161.2025.07.18.03.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:34:11 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org,
	jgg@ziepe.ca,
	lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	rust-for-linux@vger.kernel.org,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 0/2] rust: add initial scatterlist abstraction
Date: Fri, 18 Jul 2025 13:33:33 +0300
Message-ID: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v3 of the rust scatterlist abstraction incorporating feedback
and code from Alexandre Courbot.

Changes since v3:
- After further discussion it seems we need a variant of typestate after
  all. A major change for this version is to introduce unsafe methods only
  when using one of the constructors for a SG table. Otherwise nothing in
  the interface should need to be unsafe.

Changes since v2:
- Drop typestate pattern. Introduce SGTablePages trait to enforce ownership
  of the pages to SGTable.

Link to v2: https://lore.kernel.org/lkml/20250626203247.816273-1-abdiel.janulgue@gmail.com/

Abdiel Janulgue (2):
  rust: add initial scatterlist abstraction
  samples: rust: add sample code for scatterlist abstraction

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  30 +++
 rust/kernel/dma.rs              |  18 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 405 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  49 +++-
 7 files changed, 504 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: 23b128bba76776541dc09efaf3acf6242917e1f0
-- 
2.43.0

