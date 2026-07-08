Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDC3AFCE9
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554552; cv=none; b=GOIiXgwi2o6hGktq4J7C2pj/gAge/VlN25mjtbdYmP+p35llsF1MbdS+LEtHEk36Ln8NnSci/UvQeFZ5FJ37nXWA+M6aws8lB9c9rYvnLqPmJ2EF1Vyw5kLlWvzVNd+v0GDNmPWwKyS6pUL5/FEa9tkzCHVocmV9c4asHwd5Xls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554552; c=relaxed/simple;
	bh=8OoZvLMH4ThuGxhQEiXShDSuroGIAHdNtptcInC9DpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=no4XjRzstcmPTAO6WF4Gt3QeXfkfKRR16IGSD9xXBMlAApvQfarx86dwUTPnDrv6sB54iX8I1GAKQrHOJ6caeJBwhIOSfvnOwNfHfpzY0yFILteVsLLseKFDOmW1cer8cCVQ+xD22ZDapxY16Yjz3OjJUTwcx3RHI35FaM8ajBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnUJFCkh; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnUJFCkh"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so25243685ad.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554542; x=1784159342; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S36ZhlE0su/Uhwn2a42SI+N6oTSNT9EqACGdaCh7Irk=;
        b=wnUJFCkhI5q9MJfcJTSDKA/xIuMTMHnBlgjGe0k2NfhPFnzrWygM9i8W+ZQZRMPH6l
         4nQTYAV1t+C0kwtaO1VblARXAECWKdK2tqS3MZWJN5eBpHJi2QSKf/bhSfozf+Ivboiq
         9x0uhKbRuV+QFrefV6rvl+BLPdFVFPexmJocRIMR0r3YLwl+UuZ+iWk/4oN/m1LztrtH
         9gQar1OzSfSX7Xhb2IoyOwy95eMvCgjmgNXN1gNMX44/qybi6QSBuGPglD7u5Ba+s2g1
         x3Hn3WCR8J9ENGtOFZlyL8kxuZyBSrsd7fSlPek1B2P5w/12Ift25LyytQufmHSK7EQ4
         HUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554542; x=1784159342;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S36ZhlE0su/Uhwn2a42SI+N6oTSNT9EqACGdaCh7Irk=;
        b=mN2A/bad1thp0PSbjBuG14/LvvSez+qzaccR+TWQy5SUMm0WzNfEpiitKPzVxai9YC
         PTAbOI6cm4NRsJxFz1yv0v26/Bl8iwex1YTeLqhzhZBh1jBQREjwwkPeLaISCOIHkBKW
         0M2c6yvpGTM3p5PpGDaW9UFEYh8RtzQjDi8+arRUJ+fd9NLkNvuk/VXA0cVgz0SqjopE
         HKqc0P9rcvs791uGxPYba8xWpg5IiwOmVeBKY8Qy4jT6InM+b18bwcWadouXnth+4xHY
         x25kfCl9mFHsv70k6U42wtVt15E2n6EQY5NXA1v359p4l/EiVQ3iO96xhgypk4VzedJv
         p42A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7c9MF2rc6aruOq+6kCBVRBKIX03Io0ZICh9GvPJNgXbp603Ye8Eim+A3QbgRU1M1To2r8Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTeRC7AZBvq/Wrdfgex31Y4mkTT+or7ersBUQaVyFYP4WnegRW
	xCEq8lCs9tsUkUGOiRaDct0va8LVh6apL7GqNCkO5hob5rFIZJHfhCxUDbwLB13iHpFnG+VSOPM
	eoOQmd8J7YE0iAg==
X-Received: from pgcn4.prod.google.com ([2002:a63:7204:0:b0:c99:3b68:c9c6])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4d8e:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3c0bca47d59mr5364528637.31.1783554541947;
 Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:52 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-9-skhawaja@google.com>
Subject: [RFC PATCH v2 08/10] dma: contiguous: Export is_from_cma helper for kunit
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

The is_from_cm() can be used to check if a memory allocation is done
from CMA. Export the helper when kunit is enabled so it can be used by
the kunit tests.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/dma/contiguous.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 0b1702bf39ca..6d0cf9c7528c 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -37,6 +37,8 @@
 
 #define pr_fmt(fmt) "cma: " fmt
 
+#include <kunit/visibility.h>
+
 #include <asm/page.h>
 
 #include <linux/memblock.h>
@@ -153,6 +155,7 @@ bool dma_is_from_cma(phys_addr_t phys, size_t size)
 
 	return cma_for_each_area(dma_cma_check_area, &chk) != 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(dma_is_from_cma);
 
 #ifdef CONFIG_DMA_NUMA_CMA
 
-- 
2.55.0.795.g602f6c329a-goog

