Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAD6156974
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623593; cv=none; b=MOnFHm9wd3VR25lP1g6nl3unAXAPL5uGkuG3ShT+qbH5DfIXy/iKCr9dwrTMnNjuKSpbBIfhMa6eKRelU6zhDbO+aIEA8qpQQClzIAwo4IsVNbkAL3tt+64kgO5iSsNHP1lvOmK5SqoV6+LZxjNM6tp5I5SAEX9QKYgpqMXxbb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623593; c=relaxed/simple;
	bh=e5/EqNK9UpM0PQlRBjtqkQj6WaKZ0lxzfKw0E0tVZJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biuYmJnk5oxvVRSvJNW7trCRL95vTkIqFBxCPLzLFs3PQjcSlwykMpLBihpl889oUtxylc17J29FHnSmLroHTHDmBJG3LuxzV8L0KSERY65TtI88BTB2wsKb4usnlGhLXXdYZfV2IkNXh0OGJvNwlIgOUlIOwgCd7FkI5HoxOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ZjP2anxf; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ZjP2anxf"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-429f53f0b0bso58601511cf.2
        for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708623588; x=1709228388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCq+3vWtONMZUCcchixRvndD69tz6ABYgm5wv9T97ic=;
        b=ZjP2anxfvHOXyBn56Cl/0RbUYDFJ2qGMc+6aBV6aJSgfVcvWsY8AvQCv/Xuqs1/u9D
         hZEGvjdhLJioSoK+186cpzLCXl0WsUY2KcojTC2fOMOYA7z/84xtKEa1E0bv4Fr17HOC
         0b/s5snQHs2GXJCgYUh3LZDh1eTwRY+EHV0hQOKuZl6JAM08j7nLQvD9FRTpWcprGqQi
         BnGzkCzEO8cX9uxA/w4/64dNHP0a7f98Hk4M1YPWyqoWEV/nRO0uK9Z9k6i4XGupJ8tQ
         Bt54yWOFLi6Pk9OBh+kZh2QsRRjmQYNRMi+kMjaGVHXnaMCIZsCtEzMvySjlNCYNfVR0
         B76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623588; x=1709228388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCq+3vWtONMZUCcchixRvndD69tz6ABYgm5wv9T97ic=;
        b=a7w5EELNdvs8zrKOkpodX9zrZIUkDZrR3NhJ6AxjZAOUL76/KWUVjE44UXdi75HSeg
         bylPSSnabpKKgf00zuGvrSuKKErkxEj5VcOmdam1Djdd03WjiW5fF2qGv1voWrxIwFIp
         omzjUTvRjw1M1Djdaa8v0Hxd4vxLcrt6RJ32LgyEsRj8Pevq9kVR0k/V4fnUhIRhXvcb
         iX3v3V6NS9SwAjZA9fsdEMcF1DYyu9Ab9XM/g9vK+Rnch01dsFErB0guDNslmuZm/Oy6
         C0QxSEqTYjrulw8OONKMgYiIL/z8rqGCilQ43DDesTnFkSNsezUiRo2erP1lto5kyQFv
         0Tww==
X-Forwarded-Encrypted: i=1; AJvYcCWw9b5bIjE2MKK1gyNmYxVVF6Ih63cAeO+14ajmflcJYDnhHy4OqW9tGMm2Gf6wlwYeC9QCH2TKK27LqcHo/5hqFhXH0NA=
X-Gm-Message-State: AOJu0Yxw1sMF52F5UB4fN2njYOKocDm39eNXM2BdM8MOOBst39N4m6Ey
	t0zBlEAZgmguLPhVzFFqVZ+1ICDLSwX9z3/YGPj5IAGauKDHzi9Su4ifWgz0O2w=
X-Google-Smtp-Source: AGHT+IHYsjufxgrQOIaZKGAlBEgAe+E77c4mX2kxpmgTPbMZQuerhv+xRzMr0weawYHNzNvAJaqSlw==
X-Received: by 2002:ac8:7e82:0:b0:42e:5791:3531 with SMTP id w2-20020ac87e82000000b0042e57913531mr1519017qtj.22.1708623587773;
        Thu, 22 Feb 2024 09:39:47 -0800 (PST)
Received: from soleen.c.googlers.com.com (249.240.85.34.bc.googleusercontent.com. [34.85.240.249])
        by smtp.gmail.com with ESMTPSA id f17-20020ac86ed1000000b0042e5ab6f24fsm259682qtv.7.2024.02.22.09.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 09:39:47 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com,
	rientjes@google.com,
	bagasdotme@gmail.com,
	mkoutny@suse.com
Subject: [PATCH v5 02/11] iommu/dma: use iommu_put_pages_list() to releae freelist
Date: Thu, 22 Feb 2024 17:39:28 +0000
Message-ID: <20240222173942.1481394-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Free the IOMMU page tables via iommu_put_pages_list(). The page tables
were allocated via iommu_alloc_* functions in architecture specific
places, but are released in dma-iommu if the freelist is gathered during
map/unmap operations into iommu_iotlb_gather data structure.

Currently, only iommu/intel that does that.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 drivers/iommu/dma-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..fa0c4be79f9f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -32,6 +32,7 @@
 #include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
+#include "iommu-pages.h"
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -156,7 +157,7 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		put_pages_list(&fq->entries[idx].freelist);
+		iommu_put_pages_list(&fq->entries[idx].freelist);
 		free_iova_fast(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -254,7 +255,7 @@ static void iommu_dma_free_fq_single(struct iova_fq *fq)
 	int idx;
 
 	fq_ring_for_each(idx, fq)
-		put_pages_list(&fq->entries[idx].freelist);
+		iommu_put_pages_list(&fq->entries[idx].freelist);
 	vfree(fq);
 }
 
@@ -267,7 +268,7 @@ static void iommu_dma_free_fq_percpu(struct iova_fq __percpu *percpu_fq)
 		struct iova_fq *fq = per_cpu_ptr(percpu_fq, cpu);
 
 		fq_ring_for_each(idx, fq)
-			put_pages_list(&fq->entries[idx].freelist);
+			iommu_put_pages_list(&fq->entries[idx].freelist);
 	}
 
 	free_percpu(percpu_fq);
-- 
2.44.0.rc0.258.g7320e95886-goog

