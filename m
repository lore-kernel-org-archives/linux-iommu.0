Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308181BBBD7
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449321; cv=none; b=ajyEKgSdDMzXrFqaM6gtltlKnCqJn/bK/AKNK13TMrhv+PKmm4gk2S6mn0trOf3nOtMq1unlRlUK7jt+1A5rezmBBKH143GPmw5nmuDAQeiF5CTlUxgbF4sy6LdcdwpZeaigG9exYznyxp3WCzAjSIfyVhxQdAkXhc1U+Z+7qo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449321; c=relaxed/simple;
	bh=ll0P9IfFa7p/1ScsbSL5ZIC9Tt28lrzdPJ+txKSWBpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvfBztQ/j1mnzZriDCXnB3pfncJFQPMtSrt1a6B2iXecKS7Z5Jej8vpf+l2JBtzxX9/p34+0r62NT2H72NSPCPGySK7HuACsn2AgMC6fqXoLxQQmu8qXASiTlHeNHqBwyI3bQ4zkV3FbghCxGxm3bH9YQpKcnQdhG65Q9TOvTNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuRCL+DA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuRCL+DA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30227ccf803so44461471fa.2
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 00:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737449318; x=1738054118; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6t/NfctZQzCLSp1/vL00MczYX8ztZK8ZRUybzG+0jo8=;
        b=TuRCL+DAdYi5nvZe8w77Nx+cqcK7MTK+QOqTKHN6ahgKgIqy6c+aKqYEoENY4b6Ywe
         uT3vK5DAzK+U76kh89wbjQKz0xRhBlqykhR/jvsPYhFD/Urzh2YJSuQnU2WPeeRiwjVS
         CsIPm4VobhLsmmambPXAsMNE8RS3l5LbNXAt3ZNnr/2J1yHvi4u9dcOsHqfYPQy8tpMa
         7RiKmucJRTwpCY5tsJiBi7vP6i+/TeRryGYpgiQqhk6eiXcbfczmOO6xqKaoCSbCPQ2w
         yEGNfB0xs3h2+fVUTlfaNn02sTri+syGV0ZM78Iw6IR2N6dc+//7dclYEItmG03g2218
         nQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449318; x=1738054118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6t/NfctZQzCLSp1/vL00MczYX8ztZK8ZRUybzG+0jo8=;
        b=MydMpV/SiZlnUZJTx+f4jJkNp4LXBEy5ljQvQyG8wIytd/RkINpULqREQfe7j/bdw9
         aHMsBcul4xE+1wKHWjn3WjX2nJyeEfiMnMj38m1ZMkn6uAWFt79PfmbsBwrShwgodhW9
         FitJJ0O04EaNLIsrVZTiIAXjs5Dfqpnwo8XAQsQkjaNd/H30YAFumogE5gNwrY94z/hG
         Y2yIO6+7XF4EMBxUT5fviBMMjutKzWleNB24pvbse1POwwlrbPmRhJbYsPJOc0jDQQ+7
         sVAI4YTmksUUZl3xeT9SBTCV1PyZrlNQsnGjv3qNAakhx4Hd3X9ZVghEk5Gvdq99+NFK
         D05Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQtUW533hZsNEuabNfsjc/HAap8VPjPqg8ryPsX3rDLxYi6i1jFeATR1H3DjCJF0edAJ8Rcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqQaSzGkXpXslrRYViDgF9exdwAUn9DyVQ/7nENaBBuKdeHnHH
	UJoGiZxfbEk9DMSaAmbOlvfmUGjVUd5quPWosMkTyNXjib9h/Vb6
X-Gm-Gg: ASbGnct/ad0D0QEPwA6zg3pEnXrjQ9dOnbB70xDVsLXg8RFMBl/cbx4ZNQHwU9WW/Gu
	XVxH9djB3C/xrq93cp0ESzbyu3UxLJPI9UV1V/HCfkcJOHngY3zANVYVF6qYfaIYjpCt6YsgWBX
	3lRqvUfIzWzj451KtTKANCuijUhwHtjWeBQo0QKXrvl3G5vNGI/I6cdE00vjTEFhoc0tVvaPKLY
	14QOQuLZJ5Rsolkk9/d/Xa87r1pGHG/74cSLOKIATOrfyCeocRDJ6YoNvOtzKz5f0jm9Lb/gdUZ
	I3tt6MfCi/vPwPaykfuVLxONtGjN4B7U1eMkIV7c
X-Google-Smtp-Source: AGHT+IEO9HiGi43wrj6DPjuve1YnbSDtbMLQpjtAFXaxo39GOA22EUsPUeQtUvgAJad6Hc8blBYA0w==
X-Received: by 2002:a05:651c:993:b0:300:31db:a782 with SMTP id 38308e7fff4ca-3072ca5bccfmr59602761fa.6.1737449317996;
        Tue, 21 Jan 2025 00:48:37 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a4ed5c7sm21178651fa.82.2025.01.21.00.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:48:36 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel@sedlak.dev
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
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v9 1/3] rust: error: Add EOVERFLOW
Date: Tue, 21 Jan 2025 10:47:45 +0200
Message-ID: <20250121084756.1051758-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
References: <20250121084756.1051758-1-abdiel.janulgue@gmail.com>
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

