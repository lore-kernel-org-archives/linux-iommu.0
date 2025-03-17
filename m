Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23F1E25F7
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237650; cv=none; b=W09v3GsOiFMKfZhn+HRm2jEdBwv7Pt4rV608Kr/2+lzcLYgJNhgQFfZo2nJV5qxFY3ZKyCWBgxJeKKcxQ2wOqFzbSoSjgcobXOUYEtC2dXebQZI7DXiLOmwN9OQ3XlFS31t2peFVOjtwh/vicrv+llBexVakzSB5dCz8FJHS/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237650; c=relaxed/simple;
	bh=VNgS0vH2ZlYZUHj7qrVoVvtJKWTOOMEET1wyGgzN1t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvGh2W38fdwywoDl8vn+eckPLFpf7CjGd8cTUeMjXT24gvKBmsy2VZf2hWshFIhiTr9TuqXEqQ0pWYAzs0o7KzIPD48NEE4p7tvIq/z+st6uh5GASR8juGUPJzCARtlcwqN+UyG45nW2yZVC1ErF20+JPEjZFpHdjdTHtAsSYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+7gXNTh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+7gXNTh"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54991d85f99so6003462e87.1
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237647; x=1742842447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSlOoVfGuSynT1x7fqBiBqNVP4Dgpx/NS3fcP7oxU0c=;
        b=f+7gXNTh6kpmmrgLemAV1XhO1Uxl4cihvqI6HscpfYm4O3CP91vk7HQi+7IDmBAfEG
         GLnlD5lHDxvUjbzSEsqytwSBpxSyGoc39I4NyVgQBuQrQqBkZroXUcqOGihO489ctDac
         1wZcOgv47BETuvq9NoC9yYDaz0iHUbyBAai2YZ2OxU6sDaMgGTbZQnLCgp8ve0V7Dn5m
         hZDcDi7kKvCOQJez1Y6hGeHJdsmPfkppl/UYFLG7NU49k2E/fBJsq7ZMI9nWkDA7eD48
         5NEjHSHY0+aScxvyeFT+SICi4YmiGqnaEPlW/11IaU4kx5s82lIg7OldLE27UDdUocWc
         8AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237647; x=1742842447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSlOoVfGuSynT1x7fqBiBqNVP4Dgpx/NS3fcP7oxU0c=;
        b=BDAIvdNyk8bkxf0w48H5aBvKNj1HU6RjC1hc24SqYxnvfffx4TKbGrZkBRLah2tQzh
         pExVdEEpb2Hn7Gm8cKc5UF2zxdIQf3DQCnk0g04Yf33o1lJS8dMg5iZVbN2QziHod35a
         IL4McuW9IQl3WuumQHui48PWIIgFUHycGNf6ggjCJY+/pwvQ6+9yH41kjU8bywgvjkuk
         aoM7BCkcYkMzDdaWqmBRkbPTz7j0KaivIjFqCpJ9G5+agw0D7HY9raEmbLdlZSvRG6Cc
         dbQPwpbazWSxjVtmjzfkOnyaPvKTNjDdJmUEHZh1WU+ZrQVMDhC3swByn92h5RszD/Q8
         kwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9njMm6CT85LGAubrAHJhOUZJEPxLuBs7aNmKmg5JUQHufmOcvaUkZQKWUamb2NExGK941vQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOZfK6RFS7cPMObnyLHpFlcHND4iPOopJjezHHI0z4SDD/94l3
	S5gtvPXzzssz3a5GwY/hERdn9y+H7mKwr8/TzoBePYRqCVvrQjw52DQ2EA==
X-Gm-Gg: ASbGncvKKQFVSBnT97kEJ0ujCJhcj3s7rqFZO+qTxAdwX2xqiO0BL1T6GNXDLopbREN
	m6MnCXCxFhEY8zEFHr6qX+8w1Xx9JZB3G3TGEs65jzeUgNvotn/HLHfzpqdUSt45jfGNZ12Awp0
	YQoNFfNC81TA9l2VMXuWvstwOxS5nw/W6GJhwlPJeuk1LRc3cxMqzaQ+1EXD03K42IcVYmtUpPZ
	vRhU04vUsMDkY9I7Cg2KAoR3378pLTyZu4Fdk7k11Zy/zeVVjQEFnN9ynMf08CH83CAdFhfA6ni
	dfh3XajTRIS/GPrmyUpdRUONjQMzjEVySjNAcWE/mtimjo/smpClWtZlWpkMJs6HKQcMJzGseBW
	WwYvs4YzcYhcCVZ2DqLgIyA==
X-Google-Smtp-Source: AGHT+IHQF2iIfVqplnGsSaUNHSln0qW15Tgb5KGAxJooMIYRxAdePR22i8Oq/R6m75Sr3v82hQrpxw==
X-Received: by 2002:a05:6512:3048:b0:549:90ac:cca2 with SMTP id 2adb3069b0e04-54a3047117fmr558637e87.1.1742237646739;
        Mon, 17 Mar 2025 11:54:06 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:05 -0700 (PDT)
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
Subject: [PATCH v15 01/11] rust: error: Add EOVERFLOW
Date: Mon, 17 Mar 2025 20:52:08 +0200
Message-ID: <20250317185345.2608976-2-abdiel.janulgue@gmail.com>
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

Trivial addition for missing EOVERFLOW error. This is used by a
subsequent patch that might require returning EOVERFLOW as a result
of `checked_mul`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 376f6a6ae5e3..30014d507ed3 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.43.0

