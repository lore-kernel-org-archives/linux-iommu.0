Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F03DBD61
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730233; cv=none; b=tIrpYmISr3+DHRS4QgoOuAdVkRpy/DcmaFtKhAbg8jplDT8iTBEaCFNHJWYdfoCkJKBQAPOUzf/ciYyVnGlfvZM8dzuAnAcwCPDXbdwPsAG8LlqyiV1VZK4QN1kiDWdlHRtWDvheXo07Z/0BRjHH9qncxJQItDBXNhX8ld8no88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730233; c=relaxed/simple;
	bh=ldweqbderj9W+mZAc6xgqSsLP3J93Wvlmui8r0wnLmg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aG0dgl4lp6MN8oiJX//p5zn1cbmdbg5F3i69V8uM1E619ZXavfd/VteYNZoy8BFKvc+e4sOBmiQIt1499YNCnLflPLow471LCCoedcllvCVXD3zJcUmWcEdBDwRK90n3nze/4YgDamekuHg1xJHozeXF+JQKXKUv06EFMiW3On4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXzt9xjm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXzt9xjm"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439b8858b0cso3603734f8f.0
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730231; x=1773335031; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWT+qG1oRqRuIDXjK0wYhRDBGamREpRhvdBlfbs+nAU=;
        b=yXzt9xjm9BAws4TSg7SkKzqC50N3R1ZL0mpTLcjGDfGddqqq1MnkYlxuILGH6wdQ6N
         ZKjd8BZf+2aSYcVFN0eb7LdUF4dkZGaHuMFxwWmnZRNPLCKHycl8MUYwPXYKBFjv4onq
         B+U7Xzx2YCjh8FY6CNf8RA3pqddJ74T8m5l0LUrD7qPXpr4eypXspfTOQC/I+t9vHteG
         ROchJcp3EubHTG3lRVv6oYfQ7XMFf+qnR+U/I8MdWYPGAstsPUEM1IPGSsTzmtvDAdB9
         tT0bPcUPYfP8yvxK3X1MN+JQc5Jj+a64bMn3y/GYy8yLce7T6jju8Vk4PJKvo7g7DoSP
         KCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730231; x=1773335031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWT+qG1oRqRuIDXjK0wYhRDBGamREpRhvdBlfbs+nAU=;
        b=WY7bRILMKxmFQlhVwxbJ61q+z3xMLZrgyZExvBe649gPyWYYliAU00pNs53yESLSgd
         Wrkrsjb6+KBSgaGkB16dNyVGtrSYzIvSi1qUHKTZDAyT6nLhpRNQHidzH8524Ts8nVSo
         /HSVZWiXde7oiYQc9Z3VNKPKopWntIwiE0ksEeB4l8XB3VCmbNjLvzC2cqRmMSlT5qIn
         XsvFihfvQmoeCvVMWrM9HFeTTFSDlXr9En9cuKdVNtV2pZNIRwFT9NcFfgc9xtKO//+T
         MxYQoVjIRY58MNB4FVBKoNPdM1S/amw4EZtqoSqSgXpn9P39jEXgBBZcUS8zmw/nRgvS
         NftQ==
X-Gm-Message-State: AOJu0YyuYe1JtYO6u1JoGe+sO4SYuXr+KOMlDVtUjl1ixNTZiIx+bIMF
	v87+/7JkUgxjH9FRdWCWq+X00z605MhSQPxWjqqdxz5t0ThvMwCj6xX+HeAPr76pxrfkrRaXEnq
	9qtF6KIu0zisbSv6TlP2k/HyIoXB+Z0QfiFsMSuoPn6qCDRWu0N6vIZF/3A0VzE14RIVTJzIYJy
	w2La6VZfPwd0n1BYuO3kESStr+8lZe3f40OZc1xhTxw06hZw==
X-Received: from wrbfq13.prod.google.com ([2002:a05:6000:2a0d:b0:439:c461:68c4])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4009:b0:439:d74f:da94 with SMTP id ffacd0b85a97d-439d74fdb4amr460338f8f.5.1772730230278;
 Thu, 05 Mar 2026 09:03:50 -0800 (PST)
Date: Thu,  5 Mar 2026 17:03:33 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170335.963568-1-smostafa@google.com>
Subject: [RFC PATCH 0/2] dma-mapping: DMA_RESTRICTED_POOL and encryption
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

I have been looking into DMA code with DMA_RESTRICTED_POOL and how it
interacts with the memory encryption API, mainly in the context of
protected KVM (pKVM) on Arm64.

While trying to extend force_dma_unencrypted() to be pKVM aware I
noticed some inconsistencies in direct-dma code which looks as bugs.
I am not sure if there are any architectures affected by this at the
moment as some of the logic of memory encryption is forwarded to the
hypervisor as hypercalls ore realm calls.

I have wrote some fixes from my simplistic understanding.

However, Future looking, I feel like we would need to have a more
solid API for memory encryption and decryption, that can be used
consistently from both SWIOTLB(so we can also not decrypt per-device
pools by default), DMA-direct and other subsystems.
That would be useful in cases (at least for pKVM) where a device would
need to have a private encrypted pool, (if it needs to bounce memory
for any reason with leaking information by decrypting the data).
I am not sure how other CCA solutions deals with in Linux, I am
assuming they won't to need to bounce at all?

I can send another series for this which adds a property to SWIOTLB
buffers to be decrypted by default if that makes sense.

Mostafa Saleh (2):
  dma-mapping: Avoid double decrypting with DMA_RESTRICTED_POOL
  dma-mapping: Use the correct phys_to_dma() for DMA_RESTRICTED_POOL

 kernel/dma/direct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog

