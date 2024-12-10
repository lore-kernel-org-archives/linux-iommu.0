Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF422914F
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869008; cv=none; b=V4zN+ANXt1JehJPohF0Ryipe2d0ur36pKE+eD0bsxpR5TCifXK+DGw3ackEGr6sm6hLhDv3u2bl4o0UR9+kEzhnd9L/RWF+Was1nQXP8YIrqWKcVeGTiCzQKWamrnTi6fbsCMatXB6Ig64fOj2AJ3i7pUzYCDL9QF8slxBt+gIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869008; c=relaxed/simple;
	bh=7TF0D7iSdGT2magME+zHIHzqeRneKEyOSjHsh3ydk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtLZDfdbADA+xDyIKrYWJNpt1jhAIdGh4w0uKoAhbHz4/ylLY9ayV4jdCvxBVnB8G0D4+/LfGQEe8QidH5EjQWgkOi321W3xwYRuyqknNV3gMg+X7gmp9GsfxSMnl4khpGrelgRXShQWQ3IOE6C+WAvdK8w1PfznWIF8d10VbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnFAWfZ7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnFAWfZ7"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401b7f7141so2514721e87.1
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 14:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869005; x=1734473805; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=cnFAWfZ7K6NeeABfBdwUZI/RMRbV2zKhJkiyXvsotOlOMET/IPIHh3O/oOgejVPONU
         R4nqVrmkyo3qB7zkOUZpFxL/+p/B9uLI2tHZA/OgD66J04HWNPMii3ehosepzihwk/JB
         113vZbzavd5zQSDu8lYsjn+dQYY/lCrQMGBfVu4aU0CFuSwlkkGGc3BWSbvVWfYPSx/z
         QrObFAN6RQj2nI6qTpj0ye6cbCGffdw3ChDh+TXnZtvrv4eeMl5mCR3KKybxRH1X1+TH
         07TteBTj8eDeod0sePNkTEapSmXdDAMb+Rw64zKFttxGu13YrNNqj3i6loBphqcTrDHe
         SnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869005; x=1734473805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=WY0Q/bu9YwN6ITdvLNGWEQnRyBWeSQqllZEXQ4GT3lmH79/fWLHsnBrSrTnC4vRSPW
         EHE1PoWN+3UIba9GQAhIf0inG0X4rehYEgG4Dv3W05JGjJme2ut8ZGrJ6R9SKuG0ldVm
         xhUUQ+BkGIJ+dVeqoOteWl4yZwOg2XfMhu4g1aSsTAjhfsaPABUaZ2M5zmfajcEIJY0u
         wpp9xr1vAGWeeqydKqqN1WMFTmzIKLiyF3YTRSDYqDw8K6Dg4Duznk7rEbNKWXmNV3Hz
         xzb5pbvS02FpTzGMAjXWG6oG8SpezZegD5zIRrwykpVqQs+4cFOqOPN6UkMG3eipR/bI
         7+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWkJ94rG8TL28xYVgVQNv+zkhIQiKHkZ/3yOT/E4q0HHn5ZN4bPDF5ntbXMTuKQD0W5n/I/ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVo+k8afQogLsfvYxEaEYm4Glfvtd4muc3HWTFXPjtwqvfB/qV
	Dt9uT2ygB6T6o4Fvzj1d7zld5GeGkLoX4uuNBoi1H/8hbphMQO1b
X-Gm-Gg: ASbGncvOrDXsbqRab7aa16JQ9b1D79fc58vXfadWKvHClYAaktXCDAppdMe+buFX14C
	JYKhkA8kIJMnio67Mp+BEBjGmBH7bYO0xRL5qOu1Q/GUbCXd9ssjWB14sNR+7PT9OW62jCHrsUh
	DX8LvIqTzMSwfG5BwLL9irtWDv2AqlXKYMaralJUUnmk236UC2xAi5QCMNGYEMD6BSO6ATbXMK7
	/C3EATq8GYrZK7OzbWqVKmsz1zfkz7Zc99NlaUwv4pw6y5YE2tAu9M086CJ76kefhlyFBTvBFO4
	MHc4N3PNn+nluxUBJYD0VT7l
X-Google-Smtp-Source: AGHT+IH9EfavxqA+l7UUyXjE6dD6kRiqPRIcI9r6iPLIBdfqW29TtwhZQ+79LfaDOqsi8cZ8iFLQ/g==
X-Received: by 2002:a05:6512:1597:b0:540:254b:8fb with SMTP id 2adb3069b0e04-5402a605dacmr136595e87.54.1733869005145;
        Tue, 10 Dec 2024 14:16:45 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34a4531fsm1472694e87.262.2024.12.10.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:16:43 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v7 1/2] rust: error: Add EOVERFLOW
Date: Wed, 11 Dec 2024 00:14:58 +0200
Message-ID: <20241210221603.3174929-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
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

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 52c502432447..cd57fac7f1f9 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -63,6 +63,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.43.0

