Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C953C1982
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900775; cv=none; b=bzCisftVLrauqF+1fb5OQfUq+7z5rhsaUFEklXciepF6z/gbTtoOsPlPzRzfryEVov9FlM0iThJ/ElAN+MduC//SCNgW1ue06AvfDbKsoWEtmslpZdxMeVfGfOuq4LjTLgLWyEI+kOwU+Qhb5QIWWIFACMLMLVCNhFeVU57TzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900775; c=relaxed/simple;
	bh=dz8KYRvaR4cIH7OFqi4HAkd8OxCeLLplo8K/12b6aYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XXGgDjXmCJ+FJyMsPUHt4P+3lDV+ErdQczjWuZXVHX/Fr0Csu2oIZeUHnJknzc2KpRroZW0CgKNHEMRxCgcs/swUke9QHRT9wSqwdQvd6aX1XJ7F3XuQbbNux2ed2QoCKxw0b4kSx3/5OOb5Np5mI2429/VtHh8OYjdj0JI/WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XVg1d6nK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XVg1d6nK"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43102ac1da8so4316103f8f.2
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 01:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768900772; x=1769505572; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gf2YI936iIbQws0HxhhxYueO3tESeyYZp/38y2RVRZI=;
        b=XVg1d6nK7DD64g4NvI6NOSfrxLLGqLajqXWeDfTvz2U4TAJnadhJRF8nvfFG9rk1nU
         afUbp0Edg8GDsYy3JCbQ9NmKDnG7T11F185jLRbl8IZ8/8NLm/YzKombG0YkT62NI7u3
         pYJPatMfingnXntF+qJeOCl4q3pTu3WM1PpmNjGJsmA3Ox+Vcs8AKVeu8bm2+Xap4usk
         gIceoxJ7mpUs5WuS0CQYf6XynJ3SsOwRogwiK16dRWUrglCTuUJ30ka4cIjT6TFFp7KI
         FbrAb2slbbuMSOc3idynYIrHBOfrM8T/f2V06PADviiHNd8iBvIYrviiq4QyoueYu4uy
         Mz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768900772; x=1769505572;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf2YI936iIbQws0HxhhxYueO3tESeyYZp/38y2RVRZI=;
        b=IN2UU7veGtML080oVOvuiQWrM0hvNomDDZz12oIZl/JhkJplFsiDDBwCELDiEzaut7
         F705cySPBlrOOajtNWJNmq1/0xcFHEuIR84+2sWH+si0iznTBjdoGA4gtqknnKqWYcZY
         4TABwS+F469V4Y+BB3ecAPOiDO71f1mSRLAfE9G5njhhfv2uIg6DUccp3xH8+NqApuoh
         EeOClHpGrN5jaIo2cnfeo17U+AqcK3D+7T0uasI+0htoWwg/aNm/mxE3FHwXcz3skRLD
         mVnSxyMcDECtd9vUPG9txIDRPrqWhfs7LhkiezUrveUQ3nG8k3yvAyHwgDOIv1/5OwDv
         xUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVyyKijNDgTEQUNV/LGWsLYFT+wNCs6CE/kzSx2igXwhTSOE12RM8czVbk7DSn3TH/iQce22g==@lists.linux.dev
X-Gm-Message-State: AOJu0YywYCLMClheoCrOQBmfxMNpCopqyfLpYpRyiiwjjqAZQZZ6widE
	AgeFcpIxncbTwN9L4DlkuX48hD+/d0kp4Kd5e1wS1inRFZAYdm0PX57CTm1CV4uDV5B8mdQM3zF
	39eqnjt0hoYuPvA==
X-Received: from wrvk17.prod.google.com ([2002:a5d:5191:0:b0:430:f5ea:d30b])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1448:b0:42f:f627:3aa3 with SMTP id ffacd0b85a97d-4358ff398b2mr1994536f8f.56.1768900771795;
 Tue, 20 Jan 2026 01:19:31 -0800 (PST)
Date: Tue, 20 Jan 2026 09:19:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120091926.670155-1-smostafa@google.com>
Subject: [PATCH v2 0/2] iommu: debug-pagealloc: Remove pfn_valid() usage
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a small fix for the new config IOMMU_DEBUG_PAGEALLOC based
on the discussion:
https://lore.kernel.org/linux-iommu/CAFgf54pBAUm3ao-UJksiuGKtvv4wzRyFq_uKwLe0H1ettO4DLQ@mail.gmail.com/

Where it was concluded that pfn_valid() is not enough to validate
physical addresses before access to page_ext.

The first patch introduces a new function in page_ext that takes a
physical address as an argument, and the second patch uses it instead
of calling pfn_valid() and phys_to_page()

Benchmarks with the new implementation can be found in:
https://lore.kernel.org/linux-iommu/20260114164322.787125-1-smostafa@google.com/

This series applies to iommu/core tree.

Changes on v2:
v1: https://lore.kernel.org/linux-iommu/20260119142246.3821052-1-smostafa@google.com/
- Rename page_ext_phys() to page_ext_from_phys()
- Reword comment and commit messages.

Mostafa Saleh (2):
  mm/page_ext: Add page_ext_get_from_phys()
  iommu: debug-pagealloc: Use page_ext_get_from_phys()

 drivers/iommu/iommu-debug-pagealloc.c | 31 ++++++++++++---------------
 include/linux/page_ext.h              |  6 ++++++
 mm/page_ext.c                         | 23 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 17 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

