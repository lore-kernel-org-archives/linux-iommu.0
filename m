Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE22641ED
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715405; cv=none; b=rdZkmnGshDCvinuSRuZ31n9OT0abT+5JeOLrHlFZFTix+sr2yf2YuosyDLZxDSoWxJflNk2hKZwsAXeZk2m24Z4u0t1A8KVF09bR9mOutE86fadPNsEnik9xFmw0ARzGNKG5S81jP2qseGQgPTadhJs6p8P06BYyHnPnmKO8Ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715405; c=relaxed/simple;
	bh=DhrwcCKAPl4wQYbKHYYSepNVPu31+4xtNNYqjdxy+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEFFL9JVf2f34Uh6ySe95xTm5SKY6VBcERXMsR12svhMgkBAVS7w0NSDjgin7CpUXaKRwUr5kl5PnDoVtCS5E6u4H2yS3XuPolhhmirJKAefSqecwQZoBjLCOjdTl+KQdJoNY3RIrqutrX8Zr90po6ytCSGR70hExLOlfQz+gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvDBwIlo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvDBwIlo"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5499614d3d2so5057712e87.3
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715402; x=1742320202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=kvDBwIlo7ai7ZmNwBVfZhG+HypUGra1ryt9c3mK5IZTzFDqYojDPaCP4tHEH2XHZFS
         Bik8xnEVsgwsLIoAey+sxvJEhDogQzteI9JqYZqTAuQrnRw10Ok+phiCsWGfaLCUy3IQ
         Ho5wEw6kgbZDwlAG7lV5wZXiDY7YG144PvVMUvDtZ/TDI5TeL1X5KNDrMGg4fGjEb2PV
         NsgVLBm6XvJSqDlZE0sawWY4R4TDS6+krgn/yqLPwfsyNAobQ/4NfHpwWgvAkLzmwpEC
         rCZV4DnDwliG476bBh3psQwSxXdFliVPaCjYTXE+GMOweTUUCJxPnMwiTMK6s8TphNFC
         6igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715402; x=1742320202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=HAowOGrNtIXxJ/m97IS1wiGcqprWzWibIXZaNYPYn7pOFUPht1UKRW5uciFJ8OTkBS
         wigMH5jPquup/RLcQQwRE8lt+gEGwQIJ071kSz1xDsYBuT+/5WM0ghXV+tpcj/adgUA1
         CqQ0tuB8Th+tlOjLwTCUo9ZXRMgDko2uCqBDtpG+V8nZ4chkTLLGDTCY87hYk7m9GE0J
         mgyyf+U4gTALfIUV9MKzb5xAnl8k5+wWc0rAXddJeUxvn///5MJ6SAvDwJoZYn3cjuhl
         9QFZgUkF1aACFGjQjaEOPjKyVWoeBD+0fQXxUymoX8zUTNvNi7u7YszAYal0Wkq7/soX
         BGhA==
X-Forwarded-Encrypted: i=1; AJvYcCUCi3o3neG2iSCY4GAFwXdgEiKDU2/kAk8XBwDO/3rIpssrqJGsd9T0q6c3CFmh4R8SCqTqUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkEqHfMNVQiXx/5+9p+5D3JDeOmsV2gv5fORRJngFVdcD9RrY+
	FZh4f3G+NS8HyoL9qWH1PQB16EhRkV3IwcJoyLGPHiR9bst8wQOE
X-Gm-Gg: ASbGncunzk/1vdzlNcQxzdT/Qt8b+jOgoNliLmRpMM+V+CKvcZIsbOBOnnwIfKeBOvv
	B3aA3gPJOjsbTTMAzUiQb5pUOSNw0NPXRWTBnGF37VDf6L3O8Izi0zlan4F5SiLEW0AhxD/NYGL
	Fhs1PChVShWB5CU2PMhOwETNfI/Ul7f7r+PWT8bJXNrM4EPOWxiIV8WVTNsODI0KV+dpKTGd6/3
	DezCEYXrntWVwwxicgC+nub19AOUvdQDmU/LymQFxy0CHqOc6RfrNCQx5ptOalimZdnaajQqm7Z
	cj/E62oOg74KaNgmsMChBDMZc+dn2wEUJ9F6x/csoLQEhHEmR00hPmBrzJbpFFY0aQqPuQE67db
	SdLX5QDLQVOQ3v77Au2mglg==
X-Google-Smtp-Source: AGHT+IHLqeLrmjCzyXaU21i/GMhrHAYwaPPURUglknBJ5VdO/cQPJy+xrLkGD/iWnJmSh58Q5/RDJQ==
X-Received: by 2002:a05:6512:3d15:b0:545:2eca:856 with SMTP id 2adb3069b0e04-54990e2be1fmr5700784e87.9.1741715401504;
        Tue, 11 Mar 2025 10:50:01 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:00 -0700 (PDT)
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
Subject: [PATCH v14 08/11] rust: platform: implement the `dma::Device` trait
Date: Tue, 11 Mar 2025 19:48:04 +0200
Message-ID: <20250311174930.2348813-9-abdiel.janulgue@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

The platform bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `platform::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/platform.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..a7bf3525313e 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -198,3 +198,5 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl crate::dma::Device for Device {}
-- 
2.43.0

