Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17D1DB52D
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398373; cv=none; b=mSaNcTsDB7S4NrdDOtyXX6pUbargS8Nu39zvGYZlcNcJfkJgbUoNOkMzO96Oj2TXXnzjVBSrgRm01tYQxdAQozvLyGN/Avq29hBAeX/6z9vfImESY7eol9NaibEGdjgjZWCVtm6f4ckTOtmUykM2kpiOM9esAnxxsrxbGKjuSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398373; c=relaxed/simple;
	bh=qd4trRUQfQkxS8oc3Uy3RwMq56m56afdLOQIDKV643o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oM64hKyfuHcDdpWOx5kInbbRbRZToNVLyXyiWxWIJjJQLSD9hDcIgzYhbAxHLHhYmR1HebD056FhFrQIBj4rwt6bEuObH97+4k3Bx2BIYWrGVDK9mSZdZ0SLPIud9HDnG+KjA4FLKLr3W7WNpvQgZxJawvmpzpZuJh+QLWutI0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBvImb99; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBvImb99"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso1019752e87.0
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 03:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733398370; x=1734003170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vhWWNL//qRNhtly2gq08UnOc6Yd7Jys95X1y4ntnJ6o=;
        b=JBvImb997JSFs3AaE01Xs5QwRtRfa+Q4l1byFxORt1/KxfrXibRaICndKpMYOv/3tq
         Gi6n6w/D+Z7QITv369Tu8vSsxmlYYJR8Vzd0VtIdVRZWxqopuVuFeSDw5zQeu0T48mKJ
         WMthtKTbi4VBvDjVSjXIjRSAKQ2jf1nvvZKJYgk6+xu7TDHR469086cMZN88icJ3F811
         4Wf+pOcCyxnEZzMfNNll0Pi8gT3jQYYv2UWcoLKE5iPGXYxZoPCIMPDz0dizJ9CNhMWr
         VsGX6Joxx3Gscv6hwcu2m1wesATZ73d7g3/0GgKKKqYC//rVUTy3ItRM4CsVM01oYREr
         IALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398370; x=1734003170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhWWNL//qRNhtly2gq08UnOc6Yd7Jys95X1y4ntnJ6o=;
        b=YuqEfjojLD+bNyxmPXTXPBrJbOafGXVtycOFwrvWZpFhYBwXplK9Xq0XpeIW56BhS1
         upLWB6T+ePfxS0FKwsx6JZwR0J4MsXzj+B9N2v8r0ZpuFaCb51wUYOKUClyy8EBMY8tr
         quKMdWcopvLK0MpwQ1S3lfuGvT61wAZhkM3QQY0BEFcygD1wWkDJFOA49XaPYwmOah2D
         6e1WS60IAdrO9P1Amv3v4rSfrrARpFmhkUAOXGd8csekNuakCjecMIat4GEeWRH90DlG
         0hAaZ2IdDdsKV4KY2IqXMLhPn+Gdq1zWv00wN82fj7mh5nSWHMnQ2nPJeh2kn+M/0+fW
         3ADw==
X-Forwarded-Encrypted: i=1; AJvYcCWrCHz7+Ec/NDDmmhgpcBTsme+Y0fVSIHosoBLXnPC3KAXu8ssZVqbfnI846ZLjV/WSOs4wTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSu2q9DFhhDc3pSIUlB+P8UhKZQBsvrzocX8qafBY/9oKLRjk2
	y6UVGhMjgJrNWr9Su4vSr2GZgPyQS1rhUPZAIkqZrQAz8D9Z3iz2
X-Gm-Gg: ASbGncuOcd034rjIGrPf87XPr/IlAX/AUW82iQa7mMFGDGrXsFmOw63oFV9mx4QKx6L
	+9dRtj6TynouRsF/KIyp8rn3aEWy29Bpe4D9qhPr3R6fw6o4i5SbaBvlI3/j+m6m73W6mkineoO
	Tw3IZbsrKS3G8wlMsKF75vAf+mrMI4ExerUtlLJpMqOoYgngbIqanDv29F11g/CO+mFfOyf5XGp
	IyFA5T2V7pSJ3gEq79QInDklwEZN8q5o+ZsXmFSv/vfX57spwrTrqYpxssmJupfTZEFd9zgS3XS
	RpZdALxwUApR7OI+P9VO
X-Google-Smtp-Source: AGHT+IGus/e6ZmL7m3QokmKtG/m+9qimhmVc1Ry4PhTBzywCCtWZxD9qMbm6G7bczIlHASdug9tBfA==
X-Received: by 2002:a05:6512:10ce:b0:53e:21b9:e7ad with SMTP id 2adb3069b0e04-53e21b9e868mr1461214e87.4.1733398369493;
        Thu, 05 Dec 2024 03:32:49 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229744e3sm216136e87.66.2024.12.05.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:32:48 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: daniel.almeida@collabora.com
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
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v6 1/2] rust: error: Add EOVERFLOW
Date: Thu,  5 Dec 2024 13:32:16 +0200
Message-ID: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
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

base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.43.0

