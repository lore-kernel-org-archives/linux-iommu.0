Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49F25D520
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397838; cv=none; b=upd0mzVDh59dIvUENt4GXIoGeMP0N/l0njVuHN9tU1e/WBhYc9XIJwQlwI8oS7Now28FUcjCUIix/06l8zWErCOM8sM3WRC4wFCnXVs41Vse1Rq9rgMX1SMIhhpTHvtrbxIcq7QL4uquK85aH1MmAGrbzEYOMvRZWy7QcyR58yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397838; c=relaxed/simple;
	bh=Udykfwl1MXc4gc2RuJvVXlL7EQdbeTE8wi/JhuNvidI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFkt9kjmxL42Cpbj/XuyPP7biAGpp6nOoiK/CweEyvCM2B2DHICH7tyey80OlB8h4eTXBFrF0fA7Z1En7cLRtbP7DagazIgakuCnhHEygPmW2e89JRVfzwOvRvRwFHpsqdp7kVOGjpsGeoGqIAJWXgVP1m/nrJkoG4jtRGsMo/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfvMnQRw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfvMnQRw"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so37638991fa.0
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397834; x=1741002634; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5JPny/8xmUL6JVDTY7izFghOi6X6ho5qifwBno3Gtg=;
        b=ZfvMnQRw0N/t7T6cwXR7nLypF3tfvw92Q3s928B46+yNsqqT5950Ow3Msf92UjGk/d
         3OObk1eq9Devz1zta63dJcH3KOREcaBEq3e6FP49OtcxUwO+l3Z+yb8bgpKr6sqa2o64
         thWJAOsxeExoojH2E7uLsgaZh4F/q4fPjiZlq629VkSWUXGAZVljT+0K6tFluU2kq4/r
         PfBw02+PzCfBAX1M6FBzTA1mrfersOLUXA2/jUMrcIiCbMYGN3YefvhjtJFORnei8gqm
         +KgZKxnuSgVFqDA1//wbPfsRBGpXwJdFD4Xxe+SvabJe4286t5TOKFK+jT0Hh49w/+Y5
         GReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397834; x=1741002634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5JPny/8xmUL6JVDTY7izFghOi6X6ho5qifwBno3Gtg=;
        b=C+5iOT3CxHyVNG6G7zOcqhjU9bIOe7MRH+FQRM8OkJ5etv8JCCoj6KkqV6VkjzQmFL
         LJwDpa4qkNIgoZwBSwfVkRoL3Ordzy46+1z3O60hFjQjoHxJ1eyKWnJl3kKsN91HEx96
         tQ/NFK2W9rax5Y+Yh03Q/qEAPpdUyczYfFdCE9/rrBAORsqC4pmQrzJ1B4hHhd+FgcpP
         FVZiHlySeHjJpaduV4fLh5kB9vr+yLvZMJS8J2nEi5pwWa0YpjbwGxF7snRlK7WlBisG
         XupZir6QvK2i2wCq/Bcp7l5PZi6vnGDm5XVr3iiaTREk3oUTwxoYKxdfoFHjxfVexzkN
         Gm2g==
X-Forwarded-Encrypted: i=1; AJvYcCWv4TOucoKlcKVD9MA/PWSuPfve+5vuEd1LffbYPzADUe2TREG4YqYjHpdIOuxGLO+I6VVMBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5YAHDNyM2Q+kekg+uxCkERT40HYTNtCbL2QZVxHF61Da10H7o
	ZX1CCjH3iwh3MTFrTVf+0gN7FQTzecm+JzaoDiYFPkuSkfWqBlRZ
X-Gm-Gg: ASbGncuQWA9T9YQMbmw3yq7XtqzmKW+sOI3E+SbqdT2wKhvX1L8z1E+NE2P/n12sUBO
	sxwEDBUBz758QsV5EbvJ7Rib5T8Pimk9ONVQmYPn/hWZJxraLnLw8+mOSWsZh2twI/0JYDdUoY9
	kdUTTIedekwU8fZvCM18FJqgZuJp8iF8ZTH0tgYtuclDUB7Fc3wF7d/Mz3gu0lsS0/XGjXu3AES
	/10mmzgLN9UjcVIMfg2WtIlvv39EnCFau8Io9D3yT4Rcv19tNImEnpT1SRQtTgCZO8EEoiMCf0f
	x/Jk3paHJmOwqsllhTByYvRAvNRa1NWaxGrOGnHLuxEOazpUQQFmZGxrr2ummOxs9hg9Krs6
X-Google-Smtp-Source: AGHT+IFrKGi4N2or557v/brTgU0jkI7F6CLygpynjgZaBX85qdtVnhp8hzxjA4KruxbreK67zbDtcw==
X-Received: by 2002:a2e:9b09:0:b0:306:10d6:28ad with SMTP id 38308e7fff4ca-30a5985cb24mr38650751fa.8.1740397834139;
        Mon, 24 Feb 2025 03:50:34 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:33 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: aliceryhl@google.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org
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
Subject: [PATCH v12 1/3] rust: error: Add EOVERFLOW
Date: Mon, 24 Feb 2025 13:49:05 +0200
Message-ID: <20250224115007.2072043-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
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

base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0

