Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663F379C42
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554556; cv=none; b=YgrNyBZOONTdsC4Ib+HZmUuCHpQFjczJYe21HDo0N7fj4LnUW6BMcqSsb6TKnb9LP9ux+fU4PYS6hXBiJDueK7YQWY8AFjNKdOVbFaO8qrxl2YM2aDdoIVNDuEnX+Woh/nABi59/ZvBy/pO67KkOZ2Xs9s/Xu/wGwWJKWJNZbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554556; c=relaxed/simple;
	bh=svwRb5FqDOotzSvpMqIzYKJxEBfgPXgrhnz3d8wsn8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q158h1JyurI5qd1q1WZO7iRuAScKmfookGOvQ6TIHB7OnJmEoy7GUsjkggZn+0Hqt2oX91F7MnOTnfTHZOzbsvrdRuBG8/tcPMYbWx6dOPCU9zoOU+P4uyY2Dr4gBbIKIDeFgMZcK3baQUrEhGBPfMb8MZJNdyckb3bMulfY7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSfZhZ5k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSfZhZ5k"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2caf4173b1cso26604815ad.3
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554543; x=1784159343; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqgUUDLbrc3OMfaB+epoRKq9BuL+wqg9nIdlWGSYSoM=;
        b=GSfZhZ5k0RC6NPeUmA7zeOGklnIjdXkvPFjqpriCZAkEG99knkK3KR2TJf4+yUv0jq
         iFF9C9+HCemyiaNXr9mWWDDgYteh1KnaP69aIYnu7kL6wPxIL4j04iNidWJ4l5jseYuO
         XCpvD9TFfy8pTYo1wiMNbeQspcxKNyGmEv44r+qhOYVP+rTVKbJd/xXDjkYWCfNYGFWS
         WJUBjt08Ln77zRxmIQKsyuyelnHLJ7Frqm6CKb89Us8sQp8EJHcob++P6ZlGwpQnnAFf
         Q3bg7cigILy8yxxxwxiyTE435+4/Qw4YoNO2WzMzj8DL2iOgylQ8BXZjGCcvdzxAc/+9
         BxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554543; x=1784159343;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqgUUDLbrc3OMfaB+epoRKq9BuL+wqg9nIdlWGSYSoM=;
        b=aU6Ns1rWe8ttmGMUcnTC4FWI5fFnRiTu4JCJjHkyRiAdD/YbtObu+CQJdLfJX97Cay
         mqDHom2C/nVSBp26mmtoKwR2PUrL3z69j4zPucn69j4EjNM1z/mq3QSKTf781ofWPsBH
         KZzGtcMzrj3j8Z/6wY9ni6jwPYnIXI5SlA/+A6kUkh0nojxBlIBEafO9bjmn3p3OBqNR
         fmGDyNiEx2U6ebnjxu1kFO4WL/lQ2Esi2Mf95QkU+wxa6fIJG5IYg/AC1jGd68f3oJMK
         RR+trgSudF+zwhGQcLqfrzZ4xP9KMAGcbEyFCv9cF0lgMim8amM9n286mMQI3uLvtVF8
         b0LA==
X-Forwarded-Encrypted: i=1; AHgh+RqgHfZDvJ+Us9rc6JA2co9amGyC5YEqCQ78YHisxyI+K1ySkemgr8oimQGVRFM4u2Sq6kZOxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywhj9S7J2bU+NLbLjv61ZZHYAmpSz3Kq2pECqPJmQcDRxwzD/nO
	kcQuQhzv3M/Xq7aCXPIayI79W41Gfx8LZiAZD++vu0KmLVA7YIi1ZDC9fbl8TdguhXp8O5AcQTL
	W0XXOcmt04MitsQ==
X-Received: from pldv18.prod.google.com ([2002:a17:902:ca92:b0:2ca:d0f4:2f91])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef06:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2ccea2a565fmr51586345ad.8.1783554542780;
 Wed, 08 Jul 2026 16:49:02 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:53 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-10-skhawaja@google.com>
Subject: [RFC PATCH v2 09/10] dma: pool: Export the is_from_pool helper for kunit
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

When kunit is enabled, export the is_from_pool() helper function so it
can be used to check whether the allocations are from DMA pools.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/dma/pool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index d1a0bb03e478..78496568973f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -3,6 +3,9 @@
  * Copyright (C) 2012 ARM Ltd.
  * Copyright (C) 2020 Google LLC
  */
+
+#include <kunit/visibility.h>
+
 #include <linux/cma.h>
 #include <linux/debugfs.h>
 #include <linux/dma-map-ops.h>
@@ -320,3 +323,4 @@ bool dma_is_from_pool(void *start, size_t size)
 
 	return false;
 }
+EXPORT_SYMBOL_IF_KUNIT(dma_is_from_pool);
-- 
2.55.0.795.g602f6c329a-goog

