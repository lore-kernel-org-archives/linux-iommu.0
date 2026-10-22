Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691652;
	b=AIoKKgMCG3IXLRt7FrhkLlE8FSmuk1Zm2f3GRBv0mF+R8SuBI8njugRDT5rrjfjlP9mF
	 LZiplLR01/0HeTublflSW/qXJOszS13Bx8d4xx2RlI0P9zd6b8zeJ0IasMhsV1knRWBmd
	 P/wr6zz248/7NmjDUzlG2XzD2FU/UHp3b30e/2l3rKMJ3oxHAI0NftgL1ntjrUaa3/LQA
	 qs8kz72pMpXZ2SDNvAgQFP/b3MQQMsXGE4Rc3duR9Xd7aOLNZ0oVwyHC+alyUHX+6hDxj
	 uG7E76WsCuPpkIQuAY5GqDxF8V2z11DU/txCTjZl0OSJasX1W6t9LvCdW+1CAMaQlZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ItNB62+d8xZkM4n++xye2rokmaOlwBMO1Csx+QkxrFk=;
	b=1ge1QEiV1ZiYNjmadbafqs1ZecoK5iUighLVxaPQnDDTGGe/RlmRjZeCcAGHFGWQULcv
	 LDZDRK4cW3x3Qaq2jkkcvMQqlC3/cA9Hkl+cG+t41bYJgi78GIO9c3Fxy0+vAPLyOfAKp
	 B+TkER7hgkrjyzmy+GmARHWuYUqGcnExWD1w9G2ib7P+rlJj6ZRCCj4sfdsGTPITMHTee
	 iYYTkuHFqVLdRZYqGMXSJFS2N0DNjQF7ohk9XKnUbelEFVnRILTxpGfPKPii9FWyiN2yT
	 hfzbM/fpjmdBHqh3YLAXb1fRzACiUqZI27zSCwhwa60HcTC94adLSOs9X5zMoOm3bpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rB/tIK0R";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BD606A319
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 17:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 140BD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rB/tIK0R
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93cbc3ab2fdso1129185a.3
        for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792691651; x=1793296451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ItNB62+d8xZkM4n++xye2rokmaOlwBMO1Csx+QkxrFk=;
        b=rB/tIK0RitaAX+uF6tVu/wLMzmzf2UFhb28zGHd4pmaXnTT4kMWVYuJ9TFFyeUsfih
         A5qgaUuE3JKa4J7DuY5Od1pJMZeDoA43MH+0LHTwCrbmpweqDUZrX2NkIuH4roqUbMKh
         nZT1oChj0CfPa/sJ3MneEcYr9RZbFGE6hRE0bO0izgL1o5bEDf1O421Dmg21weC9UZhC
         YAn5HxCGGGDl6MOGQGLJ4q6wk5JbUSqKIIX7F0hvXG9pAY2vqQtOj5HJtu6xuRYtccBi
         ARLOJUOeSo8fhn9m63zL3QaCwMyywzjbGz+O5zmw24pAcugZC+CpWE/hSAFSrrVUs4Pz
         cqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691651; x=1793296451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ItNB62+d8xZkM4n++xye2rokmaOlwBMO1Csx+QkxrFk=;
        b=ZxmLPin3Nq76tbOSUBjjBr5I62noaMcTun1roKj/JBDctQ+8Rek6DBEzy0DlCmeUEl
         KC5CbPGPK3Jksn9gB/zRlPt3UQJ9zvQ1MI9wC+DXl91ocN1lVvAyUQ1sN0bnRe147Jc9
         KgE/6ElYckbkvLcMV4ohW2IzvghaUACqVFUM1dKZdVemOpuypOA5t90ELnpTT3v2D+t/
         EpWItZVIV2E+wTe504cJQxZsyQa3ykd2nUlyKZriFcgVX/NBC9IPeVPa38uT4HYG69oC
         tu68RxLNdEm0YiCeBURCQYb7AMAGBkD8f2vESGYbAwOnZmc6EjH8HGPpzovAJPhECfRK
         qv8A==
X-Forwarded-Encrypted: i=1; AKwUvBwZqRufhFEDB9okpRjwFrh63ey2+qYrRpXAh7O5KsM+2LXr1qRFPmhOllC3N97rPNdMVbicAg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJTlyXpFQMYiRqpK6hLl5T5tDv80VqCkHpuBQelilkrRhqh2o1n
	/curtB7c0pIM9P6gTEzi2y14ZJ2kz26ASq37onKi5Fgd9N/dwBSbHqFz
X-Gm-Gg: AYBFou0iyl1BI8V5VUU9MHLtXAiA9+GpoqmCGcJgSY1fr3eTMqzkdtekpYAomvTLXQD
	lXZS8WTdolJRotW1WFzwsOsFiGlht6GegHBVUcfNoF28ujbv4R0o33Zmlr0mGRYL4/yWucUiXbc
	dHnf0TTrYf3QSwsZLXE3/AECd0UyfK4jIVNVI18sNf5UvK7nXlhKU/U7Z118wVH06PKY9t3R7RW
	pc9ugqzpBkF0C5sV9A4mBD+RHdzUHKoN+Hb8O5Y+DUvsA+9tS8ijdPtUiNwk0fkqSEaXZCSrXUN
	H5W0PpkzA7PBOgfIuJGzIBAmzK+K12s99Y9H2BSw4t8mnsxtCvcBP5GeA1HYMGPLXgcxllBgk2k
	fsJW4zowOsJpLgBCp9aj1a7Riveuk4UTCKnl9cvl/ugZ0GktTEHYkMJFPNVJNVsWg86LMF71buT
	is+xpYQ+/OUnQWNc8GOvGCJSi3ZGgaFoxqXyacFnk48SNYWo2P2iUllU1s0y2qEEA3EclwUwhnS
	CdZF/9FcJSmwHGCJg0NTRyGKXa0EkWb3Ukor9DjWhvGze8TBv2foiJ/LqYkFynDxA+sA/udWA5G
	zio=
X-Received: by 2002:a05:620a:2851:b0:939:3fcd:4c3a with SMTP id af79cd13be357-93f6f908edemr32192285a.17.1792691650812;
        Thu, 22 Oct 2026 10:54:10 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f6fc7582esm7062885a.43.2026.10.22.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:54:10 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	iommu@lists.linux.dev
Subject: iommu: TLB sync timeouts and page table freeing on unmap
Date: Thu, 22 Oct 2026 13:54:07 -0400
Message-ID: <20261022175408.52254-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

While looking at how IOMMU drivers handle TLB invalidation timeouts, I
noticed that several of them only log the timeout and carry on. For
example, ipmmu_tlb_sync() in drivers/iommu/ipmmu-vmsa.c (v7.3):

	if (read_poll_timeout_atomic(ipmmu_ctx_read_root, val,
				     !(val & IMCTR_FLUSH), 1, TLB_LOOP_TIMEOUT,
				     false, domain, IMCTR))
		dev_err_ratelimited(domain->mmu->dev,
			"TLB sync timed out -- MMU may be deadlocked\n");

and qcom_iommu_tlb_sync() in drivers/iommu/arm/arm-smmu/qcom_iommu.c
does the same. On unmap, __arm_lpae_unmap() in
drivers/iommu/io-pgtable-arm.c frees a page table right after the walk
flush:

	io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
				  ARM_LPAE_GRANULE(data));
	__arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));

and the IOMMU core and its callers release the data pages after
->iotlb_sync(). Both callbacks return void, so a driver cannot stop
that when the invalidation did not complete.

Is a TLB sync timeout considered fatal enough that this does not
matter, or would you take changes in this area? For example, a driver
could record the failure and fail later map requests, as [1], or 
these callbacks could be allowed to return an error.

This came up during static analysis for research that is not yet
published; I have not seen such a timeout on hardware. I'm happy to
send patches if one of these directions is acceptable.

[1] https://lore.kernel.org/r/e2b13e82-f762-4fb0-83cb-d4bef57be427@linux.dev

Thanks,
Yuho
