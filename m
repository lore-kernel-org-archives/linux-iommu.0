Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457411F9428
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339315; cv=none; b=Cqju7OiE90/hjoc5JEzPZI+IA+6wMfIXc3no8DhQvsEMzbYQhQIJCiZa76K4RORBRLObQ7rfqmoR6VnRuloVJzYeyiobwd9VU1/FaTzhAlAQP8XUGe4AaNrttcFSITf482aD1I3A9ezlXoBnwB+36Dc8u/ZYy0tL8U8Vw93Jup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339315; c=relaxed/simple;
	bh=cZ14/wWRUVUf238we36wItWnxfXg1HTVv9+deH4eTq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aC1xUUWWNvjD9HFZX7IZ+qTIi9YJLgz3WJyPxPgkuoMa5IcRhBOEvMQKjhu6+Rfj+Cj320cAWiGJ3Ci1IrWs3Z6uiDovbBv1a2ieh+mCbA5nVsmOQJs8t4SbWQD1xZ6s10kMqBff51/cebIA5ZFVnjTOi1IJKiqCH1EkgU22KS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU6n4vvP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU6n4vvP"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so106490851fa.3
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736339312; x=1736944112; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM27qo6u3r7uKPpTU2oaqiKaRCP/5KyL1NbcAHjQhow=;
        b=iU6n4vvPjxadc6pZpSe/1LXXE4MwKPPuHb1HfUVpjFSzX/ObEE7Dx3Rvzpa2MnLPeq
         33IZbadvGhHgmEpc/dQSBm1aPxRFddjYv76cHfRxzJjA2zDlAyheQdvnTXwH1O0BAmjR
         Ry3VgKkEijdgs7gt6cFoR958FcmbOwfKJ8Aj1S8QDdvQai5k/Kllx+PL3ywOs6vb0cMW
         vPl1RCMKDfthJzAAOKZ2ym6B66XPG0glyau6JVZjv2H0fPYSPQlic4+0cWH/9XVHoRAM
         961Np7NOrxyrJ4ivusb4G4CNXv3pIfE1j3OafRaNDBZK22Hsj2xvjXzolywVHE9HwXnS
         KFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736339312; x=1736944112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wM27qo6u3r7uKPpTU2oaqiKaRCP/5KyL1NbcAHjQhow=;
        b=FDZomqMA16llX3C/O77jAnz8MBNyG16skTkmEOPygYL8o0QmF6emRNTnchiIifV03N
         8GHaCIOKmNVciZAB07A8XR3DrsfTvV9W3tO6BtM3xz5lEvCgyBHry9xbdfbGQpnUn1XS
         i2b0bamRNRxvo1DPfNpT4eb95PJ5aWD3eIz5kyhbTo5uDRqo3A539TsiKqMV3SNYU+QA
         uF2sArKffnX50hKfuYh6JD1+uEfP+MtE/3Hl37ReNAtdtpIbYHf8O8wmwEPcci6IZ22Y
         WG1fMvzM7KHP6K2Zt2Ht2caE1sK2DLap1XB4+yFecN70QxJ4PgwILcd9yhYIAp8yCp+8
         ovcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0yPv/WYoGqtoKcagJV4NmRILp7NeJm5aodDfSNUS3fpbIk81wJ9XqacxjnWrrHRWH1jlFHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5WkQrkC9UqQRWRbvYlNEHHghG3sFs5bSW3RRj1tNh9ZCmi979
	68yM8GB6VHPa1GuHKC1LGrOWd7Q5NzP61CHOVSkn7i/wW/XfBRsR
X-Gm-Gg: ASbGnctAZK/tfU66OGYbl5eaKYs6ao4QnMW3YUetAdvt+LZbHLSbh3a8I9e08iqQ1rx
	0pvqy0K1WF3gvOyinixzFYAz4ZbO7mBpfCC1k5bpmS8SyPmsgQbJuOosfnbak2Vv9fF0apx0mak
	paQzmwGkh2+2ed1cex/lfcgPLC73nVRgGUUVydjSiiwdhBDJd4196SuEDEy41hsxb5c9CROqfeA
	rsV5I8H3CzBOWc/4YWnl6KDzw6+CNMxHJvGXa9k5qW5BxcaswJ6NtbpuY91rwZfNlo025GJKbrd
	Bc4OHVRLbq9mEFT5so1XxebgluE=
X-Google-Smtp-Source: AGHT+IGjY9ryTUxiQ/CgtRArSzwWWhtj65FdhI0DJ8xzTaj2rddmNknMPMcxykYc0Iaa+d/MKLOMlA==
X-Received: by 2002:a2e:a589:0:b0:304:d31f:2fbc with SMTP id 38308e7fff4ca-305f45f2869mr7019841fa.36.1736339312178;
        Wed, 08 Jan 2025 04:28:32 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b082db8sm61183911fa.99.2025.01.08.04.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:28:31 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com,
	aliceryhl@google.com,
	robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v8 1/2] rust: error: Add EOVERFLOW
Date: Wed,  8 Jan 2025 14:27:23 +0200
Message-ID: <20250108122825.136021-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
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
index 914e8dec1abd..eb06be2ca9c5 100644
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

