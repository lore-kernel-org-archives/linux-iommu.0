Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4C1F8AD4
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733245740; cv=none; b=LhNuIN8XbWUaFUsntDHc7X46LCSwRjZVml9DAU2TMgF4YH/P/n0CqCWSigVhn50Nz4fCuBzDtR7e+AMAAwkP8vj4pEzAJB0FBFdSNSsWwrma/Kf7TOsG8aT5ru2rnZM38T2LuvjypP8SLFERTPk/oogDJkHCesxwr/rRqlphWq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733245740; c=relaxed/simple;
	bh=7TF0D7iSdGT2magME+zHIHzqeRneKEyOSjHsh3ydk2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwHetaNe0MO7xoRdJF27m8BO6deLPTX654OOW3EVHkwVv11KeNQ60vN6ETAVkP0D5NeCIytxiPy+NElLalnDSZ2uKO6Ps9B+0kYYYXQU+evpFkn+28dmEtmJm33vcYYITOhEuGQRBxTCxMkfmNPmYXc7zJA4VegbUU80S9A0TH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQL28Xbs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQL28Xbs"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53dd0cb9ce3so5123549e87.3
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 09:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733245737; x=1733850537; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=ZQL28XbsuExeOy5zVZz8GrUEN9yiZmxmXsgLVlUSgD3DZUfwf1X5eNtl0tgtz6JKg/
         FXfrqeScjF7OtB4F7uCsXcRa6/EN45PrUP+86mCuQsD12hlPqArhuZCf1y2tVW1YOaYS
         b0DJq2U4J4S1HvS6G3dOLCEdLiTw4EMzF5fC6H+hwTcPl0gGyB8slh/zI0Vv9MdsRthp
         WOFGAduifcF3R5mUSxohXv1iT46IcRmmYcwhwUhsOmxOwwFRUZCVU079GjLSigSlFkaB
         5Ypo3OC8GdhqTMRrPOnfFwAWcRFjgaHscoO+Mj+4VPhjNxIk6icbzKA4rtuApap5AWZ6
         m20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733245737; x=1733850537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtMK3W1LybcvR677zqhzHXJkDBdRMP3ngjp2gwl/Zfc=;
        b=PnSR38S2KhF8R4WAkEduUpwcoGuYmbl8H6AGnt4BRTgFdotQuCEUmbk/jDioAb224K
         X7GrTJl+Zfy4TJFQG18kuQUHLPiZr2/5tB2Cc6b3uqqoAswSEBXzX1xPlDSQmzJgRLeg
         ZIfZRgy7cIjq+k6XUz/nCNDyRtllmfgdDmTeinMKGZZ/ShQjrUrH90NDUFWc/oiXmfrQ
         5FPkXqrHaQfuDGBi9EbKFWUM3VaX+gHVajvc5i7CuVC6Pur1JecWkIW5z6kSHyhm9QXJ
         ArVTRzdx1Rqh3Y0C9YgxzqH0OKZ+Uk8sNb1sAbW8yEmLvayKu3HZ48t54aaykyJVMoVx
         YcFA==
X-Forwarded-Encrypted: i=1; AJvYcCUzHSLsTJnD3JcIBqDU6LB58eI4YM+iSQ2wRMfLGlyDowkTbtghO5Q5j7fdg9wAtT/RpdwJDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyu6xe8HuBFgo8IxSY6fvhRuLOXlahCQcZzX0kVahddHGfH3hON
	T1n0NtjF97XKyoFtlTZ1kdDTBa/f3mtrpy1SVr4O7jbYKinMSkEU
X-Gm-Gg: ASbGnct9At5HjP9nctb5laIWs5pu8NMF6fYJd+Z9bvaeLT5iG7I1cEBYesydNye1Jcz
	rHQfDSLokqLT8l//xXGPqRvYIwtMtwBnQ08mFlh9JKeVRX6DuPUosw8fLaqcVQyc5SRsA6AFwKM
	BjVs3VNsW//ppkl4Gc8zjXgJu/RF9fMRIsF1fzOZzKFVN4o76piBvghBiif3nU0PXnrPjklDCZ2
	jlrbFsBUrmIc7kwVU8gVw/ej+zL5utmKWDfz6+rVcL536uXtWoBbr4c1T3ZroC6TxHi1nC49zMt
	Pud2phqz3lvhaN6vIuaD
X-Google-Smtp-Source: AGHT+IGKT8ncZs0BP4yUL9QW6s/N/Mve2dCBM9yZqZKLjTOm7noCdEwcNW5Zgom1ytAzSOeyIWx0Og==
X-Received: by 2002:a05:6512:b9c:b0:53d:ed16:7a43 with SMTP id 2adb3069b0e04-53e1b882fb2mr581462e87.17.1733245736835;
        Tue, 03 Dec 2024 09:08:56 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df644336fsm1893394e87.80.2024.12.03.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:08:55 -0800 (PST)
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
	Wedson Almeida Filho <wedsonaf@google.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v5 1/2] rust: error: Add EOVERFLOW
Date: Tue,  3 Dec 2024 19:07:43 +0200
Message-ID: <20241203170752.1834271-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
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

