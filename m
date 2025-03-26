Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D91F4736
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019984; cv=none; b=Y+PixlyxA2VdzUxnD5oKh38C/eHgQOEWJd9Pdxf2LVQjHbmW6SoUwspQkSOvb8VNc1Cn7rwBOF7WjjBu/flepagi7P3LSNoSwuQ7JhUpTbQHMtpv3rOx9FiHhIHAn809wK2u/jqRCp8c8grX8tLbxc4z3Ayw9ySbJm6abDbwKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019984; c=relaxed/simple;
	bh=stYmGGDpjD4/tFiBC4B/cjq8Qdu/fF5PqqR/CNBxpus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/OAHhYx0VBnjCE1eKyixKCTnLD4VzBIvRtB2sPasWd63/TWlRAjjQxs9efjTdAzQYj9n2Z2WqZu/Le/X+VktEXfd6saMbx8+n6xnH6uvQf2iE7N+ozM4pj+7/TeSV4zzR4/jHTXlnbe3Q9ZNgh4Kkib2kpP56r8VexRoA3goos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWxZfu0n; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWxZfu0n"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so328743e87.2
        for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019980; x=1743624780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvGhRgUQQTe7LDrfZkfw77IPStuXrPdo85w1zZBpkJw=;
        b=DWxZfu0nFClhu8Rk876yRzcKBXlUOiIV8zvPnhGttsSpQ5vEM8EyV1oI4EgQ3m2us8
         j0IgFEidlk9tHKJTAQbPV2lYUcFExpmimF5xyZQ+2SZxrZhUhDuoD0K7Gwpk9Ey3uToW
         fyzzqLvVEm9fHHEhmwX3gRibpxI7il7rYcX58+a+C6hy7+ifPHoaaR/XE4f+Im968vX/
         XFvCivsOPF/dblR0oUheH/9vwpaiyTlHcZ0qn7Qmkh0Mn65uGm8wEkeGg6IXWG38SeCc
         2siiDr0IPcU9xedqYl9krq9p586+g2N397XhFBALOz65NIENvr/bkVj0lv5LcFQTSNk1
         VwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019980; x=1743624780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvGhRgUQQTe7LDrfZkfw77IPStuXrPdo85w1zZBpkJw=;
        b=eHFVd5IfeWqpceMCsWF1WNF6tTLo2md9lhTHXCFRnL64k3Lohan8hqg/5+8tN5UsT1
         OrjgoTIVRwLSkQubALByeEiC0NGfAumt0CGw8Ay+N4jfAONHFjGF7tK5D50/ZQ5QZjEb
         kq7vGjkxSRxcr3/Ue954QRdrci2R1x9mX0f6SpRgnpgcdKSDzxLoU+uPRlpDg7zAIVxT
         P5Px6IK5OT+qoIQmi6ugw2ChXZM04wPVhVU9PRBJhY+Ssods4/ycy1XJttNleDLaCnFD
         Q9tH/q0C34vMKijBcci2ae71BCByIEwm1Y0B8/C1V59l2JpJhmi4T2YNV6r65HJknlGP
         hCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeDUGpb2TEna4yuUwAkkqAw+EaUlE+IbiJjld6OoTqbreVNlJGn3Inv7ZMoQVr1CkcTyqzwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4xpwN5/OwSNMC7/HvIfWzTlCeyIbtnjYVhgMUSyK447bF/Ijf
	LKZE1D5IDd9V3Rg3P37ovlIqq/7u68m5TZpwtCfpHBn0HrqyF8L1
X-Gm-Gg: ASbGncuNL6GL8/0eEJoO7JBNpgy3XufleiatUp5FL6lAYrtDfDeVZVBCDDESsMJFgnq
	WUIfyef+RrLeRNHpDjJG6ZchNcETaJfTYIt+3zkfeReyKTs7XEbSvZByVnMOS+GUH9v5mCxclF9
	Q7bwlJFzJ9srufa0/o79Ii7Y0UlTsAL4stPUe8jt8nJEL/soStgWpwFX+JmStsD2BvdP326O3+g
	cVBZvdgM0aY7ojl/jU7JW/F/RR4O7NV6GKtFARRFbC/2LqrTEfGJHo/NkY1RGgBRLN90mopCA3e
	gdm9pI6YFZuiMMjcqQya5FC1s03pxj20xj7u5c+KoxqcBrDdBVmdllBiqh7VgJyog/EfuIubJ0V
	CwUbn4OWmr+bPx/Ne05DUGQ==
X-Google-Smtp-Source: AGHT+IH+TqDP71XrNIXqtEqJEpXk/B2z8Fv+6HePdoMFwLb0bvleEmB5zHlEOlYypeoPyLwRZuNHKw==
X-Received: by 2002:a05:6512:1393:b0:549:6bad:3977 with SMTP id 2adb3069b0e04-54b011dd205mr454607e87.31.1743019980249;
        Wed, 26 Mar 2025 13:13:00 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:12:58 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 0/3] Additional fixes for dma coherent allocator
Date: Wed, 26 Mar 2025 22:11:41 +0200
Message-ID: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional fixups to improve the documentation and make the read/write
macros return Result as suggested by Andreas Hindborg as well as support
for reading and writing large blocks of data.

Abdiel Janulgue (3):
  rust: dma: be consistent in using the `coherent` nomenclature
  rust: dma: convert the read/write macros to return Result
  rust: dma: add as_slice/write functions for CoherentAllocation

 rust/kernel/dma.rs       | 153 +++++++++++++++++++++++++++++++--------
 samples/rust/rust_dma.rs |  21 ++----
 2 files changed, 131 insertions(+), 43 deletions(-)


base-commit: e6ea10d5dbe082c54add289b44f08c9fcfe658af
-- 
2.43.0

