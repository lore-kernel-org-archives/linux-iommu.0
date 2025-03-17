Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B0200BB3
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237663; cv=none; b=TXqZT6TAZgkRSVp8q5PgMbLPDFn/jIGU2GFQPgCXIRP7JBLMLRhEdNLnJ3BFD4rDRZbnE9BG4OQZEJlb2mxdq7GJn9LJR9/HuXRSOoqUbVJNjO6+ZxyrA5M/i6Kp1LXVabXFovgH2RZoDN1wplwBsWJLCcatcqaxwZt9cMmkoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237663; c=relaxed/simple;
	bh=DhrwcCKAPl4wQYbKHYYSepNVPu31+4xtNNYqjdxy+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBa7DsiKzTRks/1VALoRV9yHHe59zUB2xjfG8V3Ndzkf57REfMbgUqRV+zL+5SnbJlVvqJyjDbd8YRtpKCte3zPOwhaG4c3aUvwXGfVAjilhq9zkXjiC7P9Gd8Y8paSyOShTXDBwpGofaSeWaEzVOrQQalH9HWVjQ6LWT2+wSPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxtrIN3r; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxtrIN3r"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499bd3084aso4842287e87.0
        for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237659; x=1742842459; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=DxtrIN3r8WZtTGZod5QYomW7IvMrmhPCuuaiwx/khjxT4X4Zfbl20cNMOWBllkYGje
         9T0WI6SsAau5EliQqL4pHbGLIUORyU2H8K7NhsrufA9JxTL5VXIyDbXtoNObmbHIPDzN
         ya1VhH+pGSIKyOk8jC6ezqhifblpPhVWcb4Rn35d7Lc+u5RAo1jQAThGS3gjiQL12WX0
         7pM3bDD+AVgcJ5cPCOFTyHLjrnQxXE4+2Kd7AqTVC8AIlKaIW/vHOzRIxTMVQBqu0K8E
         +7jf2/ksPbLdhtLq26WfFQ1uLoTk9CVptFAFSRU1JcdsfJt1+yh6no6doOt6e0A7wsKb
         JW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237659; x=1742842459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=v8gZLywysTm9ahtAtQWo5JVLpMt+Dh81BoCFydU+umzAhPUmJEPI4Pism7MCy7e1yZ
         aJfaNFWHkVhQCMGsllVsN85iVZyaLJIy2BkR49ZMjdBWIApk3GHu7wyyq3f78jCkcX1Y
         4VFCQ+FfjQP+FNP3r1CzMqMawjUF8ijpcJHW1Q0Cfr+7rSWyQMHahWKG1OD9f2mzjI21
         r34rZRKdfCW5XMH1fWJJlMvXkAJXg8x/galxiB6J9rCTEuTeXx/nNooQTpHzdSaZTUdl
         9FjumCAdioHmY6HNl0kt1M5FlzvB+9H66T8kB+t7LJitL04tSd4l/uipFYZ6wY3zs/Ob
         aPmA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJ1TpO61Hc0L/2K6Uo6O2NMCyus+ycb0tUnsJ3+ljB4fqSIRxs1rvJPzvcYb4mrcFbGAvfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkmVhLBnIwUfPU+XYbaMCvTBdX1PLxFIwhF2jVmeL4axSd+OtY
	40YWfx9hfGAbfnCztIMO1Ik93yt7NDzGm1RxcCiyo5+1KWXHL0H2
X-Gm-Gg: ASbGnctBaUqvvs9z8mGKpAWKrPbMl9AU1+EUVQgDqHGNSbpp3t6HXEIHwBDl83KYb68
	Th4uLWzOf3nOl1PXj6vyzGIWq4wYTU7kvK6Sq3cJ+LfZLm8+B9xYbgF8sLnH8MstBPrTiTaa7Ao
	+OkThhhPcPHkCHmo8Vg5Td/45eQXGOeLViS+jC+1GdtDvVkmUYfIPda1IB8uExy62egDSRdQ9sw
	i2u3RrL2VoNg8tykE/OEGYfCAOstE5IcB6Prxy3LFtI+HKkp/dIP8Xt6m4XrSeY5VoCgG20ysKM
	22iAXoAkSIbomxX9tYn9OImLEqDYHFCJdGsuT70D9FulLnry/oDqJvEfdbnXJwJeDFyB+g0ij8H
	UsTFB2YuN+1juepgAsGtr3w==
X-Google-Smtp-Source: AGHT+IFbyIHdySxokOsAc7slyf+TNhJ4gkPo4Mto9tNnD3n0AVBHi4ObetvBIzaq8zw+2DhtUo3BVA==
X-Received: by 2002:a05:6512:1247:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-549c394fb49mr7047143e87.46.1742237659278;
        Mon, 17 Mar 2025 11:54:19 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:18 -0700 (PDT)
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
Subject: [PATCH v15 08/11] rust: platform: implement the `dma::Device` trait
Date: Mon, 17 Mar 2025 20:52:15 +0200
Message-ID: <20250317185345.2608976-9-abdiel.janulgue@gmail.com>
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

