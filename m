Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8CE1F7087
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486890; cv=none; b=YwOt+fyud2du9hkjPiE5ja8H74royiLzC7tS7iBlKk6Hpd2L+nCdbEdeYu7oODHAz/FaLjwhPu5kke7RXDCKmnSsBlXpGQiXCWqZoA5ie37pRnGWF9PSQNXXtSg1z3kiDG7uC2qxhwJR4ibic82LTyhvQkcVzKaCIcKo/+1TXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486890; c=relaxed/simple;
	bh=7y/5voRRl3iVEWd8dd9FMx/aIm3fFsPYaagWFci7DeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTlSeMvAgJGM6AS65xOLDP2W7lHL0Ja6+6nJMRbWYuFiD3+3vgyQjUBJMMfe9m3XiO+/W6cBcLwTb0v3lnMA0wQSsJlaaWcKqIFhSaWP3hJ8iYRWHC5c7UeYXsomirDMoKksTNLZFHsfYHRTJ+LoKFjHuyy5t7jS7LNRfLTH2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMTdT8c+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMTdT8c+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so118654e87.1
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737486886; x=1738091686; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsTWX9yoQTMgLsmI/WJU+pLJbUvjBW8MdXlesjuHNQQ=;
        b=GMTdT8c+r5fpMpolv8zKaPgtP59YEe1GSvGIGLayUyF/yNLXslIsYbB5hG1GNmAan0
         9V+BKw1WAC1fd2a3lLYkOFSUVBL+VnGc2yrc7y08YpzU6LxuWiLZ9JVdG5r23FXDjtLU
         CkYyPuYc7pifgjU2ijrmLKKr49T5PMkeCzsphl2q4kfdfe1IRUUr6TzCIjizwtu8TZgU
         MV2u1fcnpjv80P5mpWjazcfFlydMdMXMEk4/AejxRnltWf5IDKPlgmntSCO3zs8Md/8B
         jdt5uqz3J226+hoiJDURDDqWK0hlbnj6wXrBKtseVpbN38fB6vIRMrrO2aY3Myz4KwKE
         wyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486886; x=1738091686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsTWX9yoQTMgLsmI/WJU+pLJbUvjBW8MdXlesjuHNQQ=;
        b=BT9Qpm5+JMzk0bWtcPxrcSDKlho9F7kBqTHK3rwPDhGXx5SbheLhYev0NkmQoZtxil
         T+K01IOfNqFvt+bdIUku7W9hGy1xyXr3cZry/PnxB2r8cbZ/LiYVXANa9vG1wHpF/HVj
         r5HMNDvscTnT69wSMgdfDNdvbQmqrXuirzfuiQ7hUHXhyCJvLLZZDQ4UZeCI+RMUavhu
         ysSPBkPAMUlFAy2otqlbTrTkG4LHIMMEqcVa01ywHam7D+9wFFlYV5svJcqT2kGLH2rj
         1Bv2NbKsSRCdpSwkvw00tQGIJC+gJ8/QS1SlGkskdI0XCZLb+nvKAyCBZ0lceDaSYvkY
         kiIA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Wz4QIpWkkGzpKqjMLPj1uuwl5QS3WNq2TIF6OKUPzwwMCOP7aYVK/SXEhBixZXLvPn9HiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyevjo7tyqLY3LEk7za/2A1obTfzftIL4NVwUZhz/sMdcCnZklN
	aI89VPqSnKg/vwLfUzwz2fh7XPiJVkjsqN6CNSMx4hESdxo6h8WY
X-Gm-Gg: ASbGnctHXxYCMnfWnmEqoZVJFiZn72jbhJCYnHEQFNTzGlzquBsSgAzjYnp2r+0Mmov
	sJKKsr6A/C4ypyigwTda4supj2eivoOcioqANKNTN0r0xR+8rInG661OqIlSoKdoma8d+kNWI+F
	PdSoqvVrdmpf0jCf1XJXlZu1PJDezr1WJ3eGYHvPO0FgXcrjf69gE+NWfdV65nouIAczfyNpqjZ
	dsjdCJSH0Ju3C6WfuNw+sm/XTLEOipMMMk4w9wq0jqudmiqY2W4hHIGXFzXvKMxaJHJMkmpmsBM
	lgIzbr9EHH1f7L5KKwdDVrgvZl/uefSLzOpjUdum
X-Google-Smtp-Source: AGHT+IF59/6VBNX+P87BsR3FzxtMILdr5WUEu2YX+aOjaC1INxGKfOraQULJOOgZMNYW/Q/fUqvlxw==
X-Received: by 2002:a05:6512:1599:b0:540:2add:c1f1 with SMTP id 2adb3069b0e04-542abfb56a9mr9238213e87.18.1737486885553;
        Tue, 21 Jan 2025 11:14:45 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543bb6bf5b1sm56786e87.118.2025.01.21.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:14:44 -0800 (PST)
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
Subject: [PATCH v10 1/3] rust: error: Add EOVERFLOW
Date: Tue, 21 Jan 2025 21:14:02 +0200
Message-ID: <20250121191432.1178734-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
References: <20250121191432.1178734-1-abdiel.janulgue@gmail.com>
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f6ecf09cb65f..1e510181432c 100644
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

