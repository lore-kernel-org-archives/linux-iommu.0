Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E020C028
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275566; cv=none; b=D0Q8Coih1y5HOtOV8jmSorp2O74rFxZZaZVYf3SWV/RavK+/DSyVR44XJCV2XUuK0vIaPabdSxY/ebnbZwEbkWA1aqyVXKm0jS79aRU5xleFDt46Do2+3YdATqNGVYRdch+T0yLOHJSriQJvIDQfvX9njMysigAua1rMS4qQVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275566; c=relaxed/simple;
	bh=N627E5jZKLaf+a/aM6GqmldS3P+0rZzVxq+N8PIKrco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nd2CRh+BVFWrf4rKwM23qcxsZa0w6beTI9jBZJNCbOpze9lELAJtDumnSzfVSvZI6fSydttMqZPFmQoMnonEFrRMR8mNqoGtY7TVWSTnGdnUAWxNH5NHH6gggdttymAEb9XNlbNUrLkM3MwLs8upg2pOV+0CUzRSF8MDKFNfuVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXMxxceb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXMxxceb"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54af20849bbso755846e87.0
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744275563; x=1744880363; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkRCxQpoiKpq959QZVGdvZFLEItmCPQnXnB8Wl2Ra+U=;
        b=FXMxxceb6uUb/t0oTnqm+yNNaEH5zRL5vrg8itRvhflySNBSrlKXiZwH4EzHcXF8qZ
         OazkxxvAsG8bZB+yWIXJQxOBUFKu3Xvrmfq/IiwVBJyNGuAb3AhTmVLipTwk8ZfhB8Pa
         oCHHbxWc4c4+x/sbeNc0C1zLDuDYnUhpXzHQWrq1jf4GV1FRyCNTco6P9NaqRHF5crZi
         6Kjt0RjQBn9Di8RYLvfvISZB0g+CYDh83jc+c5nGymIj8gpFyEvbUlWHq8nRqfgcAiFf
         8A08qsjwjq8JX57nuVJJjIAkYmeUCjfag8NihKLvrzeku9+u+S2B+vIKDqGaNAPgF43A
         B6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275563; x=1744880363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkRCxQpoiKpq959QZVGdvZFLEItmCPQnXnB8Wl2Ra+U=;
        b=ZcxTbzM3Nrv1f495mx9Q0vcv9nAXas19B4cwyVe32oy79/7zgo6g303RTOeNxvw/fr
         BmERmzAuKsCAIrnNsqOzbv9jJNCPElJYOb91mQwPPRbcqiG+EJcAoqDbcvOyVZmyJ0ap
         rCmc1zWodbcFrLH36OmIu5eE8kh/eU0aNJYS1yJ9vpepNlNTl2jg3+D5efCy09on8VVu
         ScZPRlwfuu8xjbVAQ8QCMI/FheT6XtecqJWhLtfK+9NkBRWpAwVi0B76MMXkvJ18KUip
         OGwowAphr3Cc/toktwp4VcJc50t9RieRuLDPTMF6KdNJkBRl4d9gPa2FOvtCks33W0na
         wn4g==
X-Forwarded-Encrypted: i=1; AJvYcCXA4lwHdq9xrGN2N6oJmZz/+3DFsy0aIR/NTBOoVYKEX6msADRtiMlscSYIHDqxD7xGkMBI9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4XCuFwPw3XMTIMUzRI3SxrdgdyfnVFG+qDUNkP01m3s7L9yUd
	iuSgktovKw7CHYqfgdj6fnzjijviJj1/V4Hzbj75URMJxmSkcN8G
X-Gm-Gg: ASbGncscXAj64VbcKS83l7ztnFbYE/sNtGIoiW4KIEV0vk6lWsa0aWpJ5P9pydyNF+S
	IXZn/6ofY/23AYE8ryx1ocBspFcwvyTHz/vpbxoddS7xOs4TKIWkLfqOkUN8l4hFrv0yPyy5HbC
	GSwvfKajXGKdeddXfPYrLA9DK8IAOzJKSj8dMf1taiqt5+d0aypG6MsALcWaYoMKh1hnG8x+sTR
	irIEsxhIyUaDhUFalTHfMCZJqFkJdtGEo4UekOlX9I7bI7++MRvP7/gK8Hm6JiDMvRaQvsO9Nt4
	oLyeTyL2Kn0XdmjyrEUFXnCM/Z8ueA0jXOA6tZYTJz4PqtQEM/ViY1VVQW5/y1uob8EWUBFrLRQ
	8tGv1ScTA0dS03cOOevlC3M+EzYn0
X-Google-Smtp-Source: AGHT+IE6NExB+uwP7ot68Q9UpOoDvF2vSABUBzgEGo36Z21gac09d/mjar9ZjsqStikMIHCVsjTnZg==
X-Received: by 2002:a05:6512:33cb:b0:549:8d67:c48e with SMTP id 2adb3069b0e04-54cb0bbd08fmr487055e87.29.1744275562557;
        Thu, 10 Apr 2025 01:59:22 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50285csm80875e87.110.2025.04.10.01.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:59:21 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	benno.lossin@proton.me,
	rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
Subject: [PATCH v2 0/3] Additional improvements for dma coherent allocator
Date: Thu, 10 Apr 2025 11:58:15 +0300
Message-ID: <20250410085916.546511-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Pull in reviewed-by tags and include links.
- Improve error handling in rust dma sample driver.
- Clarifications in documentation.
Link to v1: https://lore.kernel.org/all/20250326201230.3193329-1-abdiel.janulgue@gmail.com/

Abdiel Janulgue (3):
  rust: dma: clarify wording and consistency in `coherent` nomenclature
  rust: dma: convert the read/write macros to return Result
  rust: dma: add as_slice/write functions for CoherentAllocation

 rust/kernel/dma.rs       | 151 +++++++++++++++++++++++++++++++--------
 samples/rust/rust_dma.rs |  25 +++----
 2 files changed, 133 insertions(+), 43 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.43.0

