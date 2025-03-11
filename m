Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588A263F57
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715402; cv=none; b=M3QAIjd66tJgSsY6vPxDgV2FRchaWzt0/M4U4qRDECuKTP/A1tUzOTrk7+AdqGQhQI69swGS6Q0bit/+/KezDVRqAYyR3eOb7aBVe0dkswqf/DBckwYct3uGA1FItfZIogwFZQTKyg40PzawJYhYIYCmOSdhzWKPDzBiH73Yf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715402; c=relaxed/simple;
	bh=VyefDGWH0N2YpL9VfzECx+ApcLuk3v2hDwgQ1bV/Fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQAa1eT0AefvwyneddZ8Uc1I4q0YelfibW0k9L4nfPgqHOHO3DXMsJOkxaR/ohqcRMRpLRFnTgO5x392ewPMkQOajFSDn6bQitVicgkHvmW2n8Hh1DIQDuFzqUiTXUS/GlW3J87SoOXp0gOpP4+mv4ZebWl6u18Yg8Jxa/KFKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhBypulz; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhBypulz"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so39089751fa.2
        for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715399; x=1742320199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=KhBypulzznIr+7AeWHz6LhaxRLKlA5BoN8gqZcEAUB8WLM/UEib1ck12Z3uW706lZp
         BDoUMt7nJvDEzB89tqadoZdoWRpTRVTSHYCnZ3sI9WzQT//4FgpVu8fy5RZAQI+mol4m
         lYDkJggv3IXnShmZSH9cvED14L1H3tTH9lJNXH62ztc3zlKeyt3ChXbiyaDMcslJHjLE
         n3lW2kCcvcRqoU9Wx4KjSVgmUwsw4GXqVaeZlYZma6ie+EwGMQD6OVEdCnPS9V7O1p0u
         sOkgPovLAYTsI7OU3wlFA8rNTee6BoNsc81Wkmzc+sqgFDTJSgtbEFPc0LiKJxFd3tQo
         ShsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715399; x=1742320199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=rfydo1UCy9W2BbqvUdj0HnqoySGhBo2lGxdB5YTMk14m2MJljprnAJXWqMRUyoCVat
         KpwZc7lIT4B+AVYotsu3wAlHMmnavVYDad9/a5kgWHvvTEaMU2URdWlGhdMyYeK3AkHy
         wGBnj2s/bbNWq3Qo5pCK0VLN4RL1N24oi6+tbvyaa88tSWHpquLH73h5vB3Kw/w8wrhy
         DkN8Ux22PKtBnTPCMdtA3QfLXz5dmuYDQqQMOnSzZkl8Y7gSqypyUH3SFpEyQ9oE/K+h
         C/yzncLWr80u+CmCZkU8vHWSCvJBoLb3dDupqxEoSDXO/0CPMV1hrkV1BXKS0iSzVpJO
         EF4w==
X-Forwarded-Encrypted: i=1; AJvYcCWJqQ+/Ns8xqEr5gktIHUmy8Ega1ekJKptjOtCbpqL/4v2ToiP7V+hjxyBU5F3FyutvJGiu4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzibIOGvIGaJzq2kDEd3BD8RaGjhaHgz0nUmC/IMsKJx1uj0Zl+
	l62dq1QINdt163pXagKQOxVa1ziXQDNR/Zh3EEkIxnCzdFMH66sn
X-Gm-Gg: ASbGncu8bziKJeBdVqKmbaNRREJwPmRwM5+15XBl+/BxVv15zsoaNm9KYvTHpxglfO5
	yKFI5uPz1OpBLinvIaG3sCjp9QuQYkemMMWjT2toNpS0xQSErag4NXnjZTDg/tYa+gVZDhVhU54
	xFHju5wSIh4Sbhj3E2P2CREuNBHqS+ts8DLwVcFzkOJ6uXWTpq1qf8OKk8ULjtQXI/i/0zbgMwW
	DWM0od39ZGShFGoc0LUHAySPlgMwp6K2Gy74ZN0ughptNq9di94PyRJ1z+0oVvWr26vjwiX0KY0
	6DjTFTqMMbxYKyAZgv0ZQHFOiCVfSw42WDntzNQ0LmH05QUVQVETaB1OYAhxOR5jISOSVvfAiHo
	8mjj1aIRHXBaQzgRdtq0H5Q==
X-Google-Smtp-Source: AGHT+IG4/njd7PlBm1mpnIVR9OdsVm4WGkJQXiTRSmnS3QRyKrR3ovUI1B0STYMLIlQyY1eNipdRAA==
X-Received: by 2002:a19:8c0b:0:b0:549:b13a:5d7f with SMTP id 2adb3069b0e04-549b13a5e20mr216857e87.41.1741715398584;
        Tue, 11 Mar 2025 10:49:58 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:57 -0700 (PDT)
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
Subject: [PATCH v14 07/11] rust: pci: implement the `dma::Device` trait
Date: Tue, 11 Mar 2025 19:48:03 +0200
Message-ID: <20250311174930.2348813-8-abdiel.janulgue@gmail.com>
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

