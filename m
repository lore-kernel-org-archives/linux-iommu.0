Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ECA39B955
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554538; cv=none; b=ftsJlN5wY10+DhshdFSSIOAHkKCgu+/PVCHIkFQ/5qFMA6eDMg/kQ1MKxee2+hfaY8Blr3DOSHi9CtIDmW6FaT2CtQ8GiTltKfVMVxOTIvB3M+/cW3lUXDxcs2LqGgziV6ILo6p2uKqfQydpjCjXJG/MaeGTnb3g9THo0IdxFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554538; c=relaxed/simple;
	bh=6jssrHCaxHvaqzW+be+ADSb76OVb/YAMVKCPjnMUMhQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vB6HKerT6muBauDbetBZ/NDg2dqyIYh/lKzXNA6A0Zel6oS8+JKVAUw/u1YUk9FfvAJiM3/1vqJT0aCEpAuLDi1eHqTiYgOpcvCHkMk436k5ecJO15jps7kl+h9iDD++nf+egfsy3v8wetzrKjiThT15G2sobsQdf5+KWsgRWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mT7BWPYT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mT7BWPYT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88ad1558f4so660082a12.2
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554537; x=1784159337; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFhl1KlUjTv27006fhIt6b3pOPGmn7+PIUCxNMQiXPw=;
        b=mT7BWPYT4aSoDNXpFdT/6yVUdYt2nLan3fCRGpVapSxZmOgpcEHDg36DT+mboigro7
         JDORehziMQNFBTo/rWs8z1edjO4i6V4fFF7xVNk7nT4AH79xQM4jbwKZ4TbcNg50zwrM
         BcbFGh30rK+YcOWzRgXvTJDWO53pszGbqbPRKZ4VcC+huxomkRl6nnk/aQAojoj8Zck7
         4hFi6sfd9h+YHUL1QQ35SOoSApdG9szgpSxBUNY97sDyW21l65kW5j2e7x275QFhmk2T
         Le40fTz5+lkBhChXmaSxqn8whTdPd62Og+Kh4yoIYf/QPRD62YCgnBnmx6xzRbsq5s9i
         x/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554537; x=1784159337;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aFhl1KlUjTv27006fhIt6b3pOPGmn7+PIUCxNMQiXPw=;
        b=Ofbyv/trur3TGrnQXXP9u897TWE/5RZEfM0tEe5NKth6+3kfz1eWrCdOjUKedVP2vZ
         v7xFxCpPPSQcXVtCUxl1ubZ34uigFBd4scMZ69kOlVs6cgHxJw3V23FpTrHsz4ySHHac
         ScHwMGK3I/7+h0mqKe/kXQO4qVhRh+aydpkF9x3ei33JYON+H+oGYTIW0Eta9PXmjx0g
         r1MqMQn/YXmU3xcjbqz4cNtgFWKC3DLFinLDFpgo78+UtOK0V7yqzeDo0EjtcMaDofSz
         2abzYuHhgSI+lON9EAmSfPf9JCHnUbUtlSSKuhfGpGnvcKA6En4hwaMuDpS6GYWQSq6v
         CwTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkaHzn+xYUOleQS8o73BFz+junIN9TNUhjB0+8ABdtr8kL9dSInRqZ2uyNCZFLhcp2XMOKMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqtorEHPnpLB9ST/Hhcor3hLoHs60yQv7UArazGa6TEJzVo0wR
	mNVGHE2gFBQ4fdPpdLnD3pwpWaianwYALHbagDEUkXs4lW0il2I556UfqW48miAjwlXZTUpJZGR
	ytlQnQ7vDQLMVvQ==
X-Received: from pfcp8.prod.google.com ([2002:a05:6a00:a248:b0:848:4e44:7f19])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e12:b0:848:411f:3969 with SMTP id d2e1a72fcca58-84842ee66f7mr4071344b3a.20.1783554536532;
 Wed, 08 Jul 2026 16:48:56 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:46 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-3-skhawaja@google.com>
Subject: [RFC PATCH v2 02/10] dma/pool: Add an API to check if DMA allocation
 is from pool
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

DMA allocations can be done through DMA pools, add an API that can be
used to check if an allocation is done from a pool. This will be used in
the later commit during preservation of DMA allocation.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/pool.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 6a1832a73cad..9382785a2faa 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
+bool dma_is_from_pool(void *start, size_t size);
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..d1a0bb03e478 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+bool dma_is_from_pool(void *start, size_t size)
+{
+	struct gen_pool *pool = NULL;
+
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+			continue;
+		return true;
+	}
+
+	return false;
+}
-- 
2.55.0.795.g602f6c329a-goog

