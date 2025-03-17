Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3729F1FECD3
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237661; cv=none; b=cFaB9+UEZxn0QTNrK4hBmpitSvd228zT2ED8Bx9YVBYULo+OYeCWTmWYuaNl16CMh3UdYmS4jKTV3SuxO+rVH6HBPCe9RvG7DGtJTaNTEs5Xx3l/HO22aiUlEg7fy/U1r/C+YktjQ6Ik8H9+cqSkrMZQjlMhd1QTtzl5KT4P+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237661; c=relaxed/simple;
	bh=VyefDGWH0N2YpL9VfzECx+ApcLuk3v2hDwgQ1bV/Fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq7v0+73HJdyEqG1Uh7QK+2371lBOiZN8cWfJOIncyyunfPVvxj2FEHag7z/SXxR2aG1RcWr3rlhfa5BODidt4xxvAravHWFeYUONQ1cBBzTwTBNkGeWIAIPapRQFTnGmXshDfLI0UGNg9NMAFZUJPRY8QqOxBQWaHx3r4gd/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fydekAtq; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fydekAtq"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30c05fd126cso45740401fa.3
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237658; x=1742842458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=fydekAtqK7M1kiPgPKAw0+EAIq2E0po0+rz1y+RK0sPChaYLlAaGBysPDmFJuUPB5G
         AFfrmUHeGX01FTaEvi4/F0mnsB6TTB+CgaDFRR4mHjswt7nLRPHaNC41UbezUoV8/SA9
         UaAxk94m3Zsi1iBuzUQIE+vSUzZWRsQxYVQJ4onBKw8IpxXPuhqlNPQDbdSbiRoMMBdM
         8yWnrVbxQeGslwCVwt4jrCjxaXfsgxlQ/EMOQAuOtVywDFGJPRekWkzfcjuVWb0Px9fN
         pyf0v3kd00dndYdurJcvvd/r/0G/p2R21kCBq6vou48PNm7Tnuo5b+L/BWSqyYRcpDO/
         y2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237658; x=1742842458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=BjZkglSJOal3AWqdKHxNWP+i6xNImJmMvZ2cPG+Gtea3EYOlVr2LaLWdMRzLGU7aNr
         92QR/BqUMkcR1dC+9xglwLyMEpgDWRlqC9mpEkIc2VdyRxngzXJKBusNHZKXovJPDhWW
         3YpTrbMCLCOlWKSw2YAo1kJPvM+c8POECehQBmCbDD1EOW08LRN+RBVR0H7t/s1p+JDo
         K3pGKy4SkuLMwQPO6MdXTVkkp3dJCZ4YGZTv6ugAbrfzCYMyQDm4fwm1SWXYp5VlBpcd
         xChAl7xHP6fHazHJolNgr0XCUis9V450c0FMJnULZSQ6o82SeUNr+MvhswLf7tdmOMc5
         QZfA==
X-Forwarded-Encrypted: i=1; AJvYcCUxsv4d1bvJG9n+JoAxxjr7Ij34+WWp16J68bxJxECW4IQ4v+ZIPrb7ZO2wqct1LCVpqcOyLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZa+cpfPwCz5yjc7mnXwch3P7CIdf435Ffoeu4QD6z7cLaP9ja
	w/SrB0AvqmD3JrPlV+Zo0yNec0TXB50iP2FLVykToZ1Akq4It4v1
X-Gm-Gg: ASbGncsM4AFnXSBvbxUMZLSBRUfvCKJhroBIiLWEweczZEN3gmwOyuCxCw6OEoopu4g
	hyvvYqeKBAqkTan8p12v8emTSMBMnWuekPsZt6Y5ZIboCfkYH3p5q2ah1V7FEnW7deXg+z1R1M8
	FhPZk6c6AW7FrErAwx5cKLSPmvh2Wa7Z8RlCI/SutsAZCiLeinYErcljIvzj3oox9Jt+6zITXZP
	ZG48CnsRK7wpzhXds/+/IZGmpHbJ7PFWRB5LNjk9DXZIwMfJj/jee5WRBoAsEcEkZZosaIbgURe
	U4g+TKfnTlnXl9rPKPDbOghtXmTmuyvj0xZjGpwWcowNOmbg5ODOJPJs7tcn9njR+sf1CEiZiyI
	156j1H2+IlvPUkk1+xzRuKA==
X-Google-Smtp-Source: AGHT+IH+KOAMpDUgs9VZDCOMT81BZbgFevjKeE27whY+TdKHMJL0Bf3RFF+AR/1gnrWgGKy1uUv9Lg==
X-Received: by 2002:a05:6512:3ba4:b0:545:22ec:8b6b with SMTP id 2adb3069b0e04-549c39907ccmr8171472e87.35.1742237658184;
        Mon, 17 Mar 2025 11:54:18 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:16 -0700 (PDT)
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
Subject: [PATCH v15 07/11] rust: pci: implement the `dma::Device` trait
Date: Mon, 17 Mar 2025 20:52:14 +0200
Message-ID: <20250317185345.2608976-8-abdiel.janulgue@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

The PCI bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `pci::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/pci.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..5839aa5d4098 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -432,3 +432,5 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl crate::dma::Device for Device {}
-- 
2.43.0

