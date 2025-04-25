Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18A22E415
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566665; cv=none; b=XMFsBxc1CQPI0X9aPKTfw5jVDV7fdG2u4NfqelYLRBeMcsHtLiQj1cwncew51l/Rd9e2rKmNaCo+NMLwGz1WgBW3AVZtmMqAkirPWCu2uNGQ6MbRBMakmnwWFFCB6n69DV0EV7uAE++yDksyyqH1cSLPO+ebmOT5Y83x1j8xWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566665; c=relaxed/simple;
	bh=t+c7p3hXTF+xTlc0Km+48d+pPuhuJBf8m+A71HAjDKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJfHX3lOGrcBL9oODyOVuhfV7mDnrNTc11pI1OArzeMpld6gRQcud+y2c8iyllOL4p2YtCw2GvL6XsTJzztcaGLKjbDSGcqR5RuKb++SEGlbLImT6PREafnZKGCGQLXPIgJAntYERN7cNzefwo3TM8i7fzqSHnxPk9sxhBQoUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYPwfxX0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYPwfxX0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54ac9d57173so3279066e87.0
        for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745566662; x=1746171462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mnIim+RQL+Hrsqs0xdul+xxqVCFsVQjL6+9pVyg8PoQ=;
        b=eYPwfxX06p8TZG3huv6b4ErlokO9cdMusmBrN6d4Dh2veC29XKDvXPoP5g8EWhIiqE
         OEksL2Mdm0U2HKZOAQxMZukrvFxcAWlcu7pt3/096uYAnK6tPZwFEWDgQZwbGJwL4mry
         3Wcq1WJyMs2R7hkFc1lyhj11FmQuDYdLNjS6PtICbW4CoLAoUJXa4DOlDgYEDxwJuwAz
         +l7Cke2M+Xkd8klm3zZqo5fTo99mV3iIvar8h0BCaOlGTTu+8yvg/LZjDDGDwac0fv0p
         siCX+etWQ0QSO4KR51ha2N3Etcqmc0/Hw9VPiERYEjvSQjup5+LNZZMIaQvuLNDaJusT
         YEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566662; x=1746171462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnIim+RQL+Hrsqs0xdul+xxqVCFsVQjL6+9pVyg8PoQ=;
        b=hPt7Gvxclaf+0Sp96mnrbcLWUhwhyNUsuRx53UoxTKpmCML6sbf6040b/7ICq8tMlW
         nWTu2+w6mbYZBlFVdQyed1LOwvbm0Zmd4ZB5+X8xB/8UxiPDig2+xyAQiLuUdq1vjGhC
         dAFKxci1xDhzI4k6/+phjaVC347F7eOcByvZr8blDgcaMM1OoLQIWpdJ4Z+bIqdyz6nb
         p1vh3tKFLZO/XsMEe1l5VwMH67GK7OoZ9HWqiDTdFl4ch5EYRRSUNx8RpTY5dRH7GEnm
         HFtiDaVfWGlq/UldKRxQHR2XdnKhvHANjHx1Tiz/4uQnw49CkTOKDunlVifxekbi+ZYJ
         c2+w==
X-Forwarded-Encrypted: i=1; AJvYcCUuU4cX3V2ycfGMIIWxsMJF2waiW2eD4f5NdS6lKrO173Ul4vg2iuDv6i2rMDdskXtUqL8gIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7GxA1792Qdey/DGigALWuTplRmpWsYJOdU8m3M8ZRJ03tK36k
	YUkuveurnsLDmblzmbGjCGQCKEuAOUg8dLQIGmjvcYXLUz8SXts2
X-Gm-Gg: ASbGncvJioEbjuJBX+nTAIkY883VumT+dZD5qQAiedjNT6BxwGaYuyMqTDfphYILeo9
	8qJ6gPsKOeMi477xFruK/DoSbks3SI2kQtczxrrEP9Ayaxn5oJHgsWt3dMKvgrVWPuirrZ7044H
	JH7TKxZAX5cULABwEf7yAd5kpLXUjIzRmq05hfxmES0uk4QBhE9RB/ZVY0Rr/dmyK8GJGTOmj19
	t1tQh84MwnaP8IRSgrvaY20Pb25NuBvSVc3gUxF1n6iI//C5abkLFANF8ovvhpN+mOBMaMT3Udb
	7cUvVzC7hDT4VgBKwXJLkfEVAYhoGMOOpp50EbQqmkTLAbmhEExwRRqmYW5oAgSL9546LiI7yho
	h2EiYbnmrhKwxunrU+Q==
X-Google-Smtp-Source: AGHT+IEZcJwlsd0sqDyVM7rduSdPLrkIpl5/mpahAAlSrYeCBg72J5O925aQVXmVaHNs9sZE2AniFg==
X-Received: by 2002:a05:6512:33cf:b0:545:2474:2c9b with SMTP id 2adb3069b0e04-54e8ced7fe0mr299265e87.22.1745566659971;
        Fri, 25 Apr 2025 00:37:39 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cc9e9a5sm504391e87.132.2025.04.25.00.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:37:39 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: dakr@kernel.org,
	rust-for-linux@vger.kernel.org
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
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 0/3] Additional improvements for dma coherent allocator
Date: Fri, 25 Apr 2025 10:35:39 +0300
Message-ID: <20250425073726.1027068-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
- Rebase update, add fix from Alexandre Courbot, commit clarifications,
  minor sample driver improvements in error handling.
Link to v1: https://lore.kernel.org/lkml/20250410085916.546511-1-abdiel.janulgue@gmail.com/

Changes since v1:
- Pull in reviewed-by tags and include links.
- Improve error handling in rust dma sample driver.
- Clarifications in documentation.

Abdiel Janulgue (3):
  rust: dma: clarify wording and be consistent in `coherent`
    nomenclature
  rust: dma: convert the read/write macros to return Result
  rust: dma: add as_slice/write functions for CoherentAllocation

 rust/kernel/dma.rs       | 151 +++++++++++++++++++++++++++++++--------
 samples/rust/rust_dma.rs |  28 ++++----
 2 files changed, 137 insertions(+), 42 deletions(-)


base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
-- 
2.43.0

