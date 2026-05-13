Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393663C8C73
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709150; cv=none; b=PhFAB1o2C9ru8kZ21YJUnSvd9xN8zfRj9nU6EXW1FTSFYn3bTi5nNh7lBsMvDeszPYIaqDn7NjAHOsL0v/wOrJGpgB6Tj6+Qrnn+CaqheGg9c7HNU9L5kU7nR1ssInkq5s6BV1JCQDqmz8EdbU1ny+wqmy7C67hE1nIi0wjszf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709150; c=relaxed/simple;
	bh=bGvl/sBLosKFzDQ031MCLr2XVfTKKUbB0cXKdlZx5zk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M9Ey3EfGc2XQimehiukI+rowUiT8pXuU++1GDE5XKfrxHJHHrrJ+XOYprLmVJ4nwCP4aDF/CZHl2Nq0C6E010SUol7W+HM3gqHDgPnNjPYwPJBhPt0eauzgwtUqWWXiPEXnfj8vRGq8dVpFxgTcVbcNkkeqVJAeAU4lpezZX468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBrfQHN0; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBrfQHN0"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48fd2b502e2so7677945e9.2
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778709148; x=1779313948; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiR080QbM62s8vT4MbmTv04ZkR7uTTVOpbLdEGUZspk=;
        b=UBrfQHN07RYeeZ7t6uWOpUwWKktvZ5vK/etXH/1NNkkbYXdgVfxxS2asRCuCLGSZKN
         y2AcmzYYZgwHZKwtaTNehsFCG3TtVkI3fk7y1eoQLu3HD2h0z1MrFv8NFVC4mU57kus9
         AKu5dDLPqMQhwqfKFoLwV6lQoO7LT7J1CE5O7VrU/n/136aBZ0dWvfhMC8v8vwwYP2Sl
         epj7l9FkLkzKuKVUOel8obSpLL1ws2HaQILQDp+8Gn+c8ZxOPz4jEih93Kpugx67O2Yz
         rXWmwRF1XhuitlBFhLlumpE0Hjobma6NS0tccDWVha7Y+BBKW3dobkCJQZFZ/mfK/AxX
         4F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709148; x=1779313948;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiR080QbM62s8vT4MbmTv04ZkR7uTTVOpbLdEGUZspk=;
        b=MFtfbkdnx/wuXaRcL3/y0tY/ej2hm2tbS/Jk+O0/u6P5HeaHPqW5J9uOJBRBNFqoq1
         Uz4Gdy1IjXYIp0gP8ZV7uxJrP+s+CJHlMUaX9lffGQ/4uH6MOvaQxPiSTjTMXSPWznlB
         w/Z2L1+xnyWpd3R+qNB5biwtDx7uYYSWa9giaySpawWwaFv+BC9O8hTym7rpllGfWHLs
         tJ6017m7S35n9UpW6qyoMTk6uEVW5+/I9HPOuik1ffIchpJL70KkJh9QrBu+LAlvhHzH
         f1/gmQWA9PL+16QHzstdDKTtFSrDEsqB0MN1XpfumpP9McC8HcCQCAUtGoz0KxfZ/pk0
         yW+Q==
X-Gm-Message-State: AOJu0YzB6jh/DN1qJC2+BmzZrf0/ol943hTSNwr+MEeBd95xjo/tStIC
	hfjkrz8oKossbkqOMqcXtLFlm5MKMOC8PRuynSUbu68C9C8111TVVL4lmRLRu/sWF1ZTVUvCiT6
	NvQL4C/UyMaH2KugsAi0SmyeSz3FaH7AgtZxamk+/Xq3tc3avK/WZcRL9dfN1XpPeaJOU6zN3ok
	WAZUd2UrT8XJuuOjezXEFaw73w6ye1ibIoR9+E5BZ0YxkWPQ==
X-Received: from wmdi7.prod.google.com ([2002:a05:600c:2907:b0:485:c45a:fcc2])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a48:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48fc9a0ef80mr77492595e9.11.1778709147564;
 Wed, 13 May 2026 14:52:27 -0700 (PDT)
Date: Wed, 13 May 2026 21:52:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513215203.3852661-1-smostafa@google.com>
Subject: [PATCH 0/3] iommu/io-pgtable-arm: iommu-pages and cleanup
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a small cleanup coming from the pKVM SMMUv3 support [1].
However, they are not pKVM specific and useful in general.

The first patch is to fix a theoretical issues with alloc/free size.
The second patch is the main one to convert the code to iommu-pages.
The third patch is a cleanup to use address conversion consistently.

[1] https://lore.kernel.org/linux-iommu/20260501111928.259252-1-smostafa@google.com/

Mostafa Saleh (3):
  iommu/io-pgtable-arm: Use consistent sizes for page allocation and
    freeing
  iommu/io-pgtable-arm: Rework to use the iommu-pages API
  iommu/io-pgtable-arm: Use address conversion consistently

 drivers/iommu/io-pgtable-arm.c | 88 +++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 27 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

