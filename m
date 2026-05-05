Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D4481B1
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940860; cv=none; b=GVHBSCpjyBRPpgO6CKlbjVt5MliRsVBgm3e0pZiqjWlVrtxXeVB4x0tTs2zK/5/Pcnc7xdjfeEkcMQxzlqlxz6/Np+8j5fDQ10sjekiQCwlf/4O+bVQSNwnt+A7G5Nycs4fMxvvAMV8yhlNSb1AJfPfrgDNInf4iDw1BFkYN9Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940860; c=relaxed/simple;
	bh=91nRYe/wLdIrUgZME+Tr6TDRQiKCek5oJsJuNHIN4MY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pi4RvlTOP7AgtSYjy0QbFGT5T3IjUDGyBJmU2oA/ldbJG0IaP6RRYcgvsthp8e74CFkHvfnxjJUWuE59tbMgbxWn6rJWFh4lXS44WE1XQg23dFB36E6N2I2C5D97mHbub99e6fqK4L+GmxTcg6D5fkIyzu2ATwW12LO4HVBiTW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kc9m76gv; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kc9m76gv"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so948459b3a.2
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940859; x=1778545659; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Obu+hjMmt2gyOfNoZeJMdjxX5bs05kcQmj8x3MdMggE=;
        b=kc9m76gvA+s59Xi7XvqvTmmlps6X8FNmeWKE2jsF8vQNtsDIY+83o9xLNNAjOULhKE
         EIEkLyOo+dpPc6GKahokMgIRimscQT1aVW0oIjUnFX4vt1vVKszmWVtcmj07/90LxWM7
         awyEuowge9M3Fe6fnK47079/mXPmvMMxQy1mBYcdZniB/uZ2VoG5JBdNx8bvpbmboZMz
         wjVzW5YeEJOH7GuXF5M1vjR3CFuTeuBoGqHdmHZiSXuLiA3TBDj+Y7EbL/AJZfZR8IUQ
         KbuMJw4PNagubsVEirZHL/7Sb2+c/XGsD+aUFEwPHPqQTA66EfwKYp3gcKHPq4kUdk1R
         gEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940859; x=1778545659;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Obu+hjMmt2gyOfNoZeJMdjxX5bs05kcQmj8x3MdMggE=;
        b=LLdDjBkZa5ADLSjTEgJ/tCvC3XkX2j0odWILniOMtqawhwbm2F7H4x4+keuIvt8Pqj
         g/FCcvshQR/s7Wk3mNAO73xTz91SevTH+LYPnb2Ccfyv7K0aanjTUfL6Wq0QnkmzwMro
         2zpr7iJzEYAp8gGgBnv5h6uYbwtAnC9VHUuVQzWRnYmdeBmawQd8VG1cArHBnLPGUrDu
         GuPdsc9AItrNdovBZRWVqT5G+Xk/3DWn1iqGOm8RNAJBtpFGo2l4hQMLpeO+ivLZFZid
         IpOcqn9WkGcRRAmeWmh+D6hLoWzQYP+PARGTt1FP+ESn3ZLlSTW8eW26ARXC760dTcKr
         4JbA==
X-Forwarded-Encrypted: i=1; AFNElJ+nUgdc1zPfmylvs8SxOb/EnEhm86raQAgV+rh94c0rB2Yj1wMOE/FzKWPsT+kgJI6Xb8snpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXCT0LkmJW4h5/bnIs5g5Ryj0WEEL4Q+rZGsVGyInf/VDj4cij
	6N/z2uEDDo8d9G495mQMZuWHYz7WgC2V9CzP1g+WRMOqGcFLj+cW0Y+VYCh5cDBZfYdJ4LUmChc
	8WaZ6WZXHuly6/Q==
X-Received: from pfbhh11.prod.google.com ([2002:a05:6a00:868b:b0:82f:a959:4a7f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4188:b0:834:e5a2:d089 with SMTP id d2e1a72fcca58-8352d29abeamr10788662b3a.33.1777940858612;
 Mon, 04 May 2026 17:27:38 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:33 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-1-skhawaja@google.com>
Subject: [RFC PATCH 0/4] dma-mapping: Add preservation of direct allocations
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

This is an RFC to discuss the preservation of DMA allocations for
devices that are using direct allocation mode. Note preservation here
means preservation of physical memory only using KHO. IOVAs and IOMMU
mappings are out of scope.

The complexity and need of this was discussed in the thread mentioned
below. It was proposed to allow preservation of only a subset of
allocations with minimum support.

https://lore.kernel.org/all/aepfYzkI7NsVGCF0@google.com/
https://lore.kernel.org/all/aepRy7Gp7Ng85Zr7@willie-the-truck/

Note DMA allocation allows allocation from various allocators in various
configurations. This RFC supports preservation with,

- Direct Allocation Only.
- Pages allocated through alloc_page (Buddy allocator).
- No CMA support.
- No DMA allocators.

The changes are also pushed here:
https://github.com/samikhawaja/linux/tree/dma-alloc-preserve-direct

Looking forward to your feedback on this.

Thanks

Samiullah Khawaja (4):
  dma: Add DMA allocation preservation KHO ABI
  dma/pool: Add an API to check if DMA allocation is from pool
  dma-direct: Add API to preserve/restore allocations
  dma-mapping: Add API to preserve/restore DMA allocation

 include/linux/dma-direct.h        |  29 ++++++
 include/linux/dma-map-ops.h       |   1 +
 include/linux/dma-mapping.h       |  50 +++++++++
 include/linux/kho/abi/dma_alloc.h |  30 ++++++
 kernel/dma/Kconfig                |   3 +
 kernel/dma/direct.c               | 163 ++++++++++++++++++++++++++++++
 kernel/dma/mapping.c              |  52 ++++++++++
 kernel/dma/pool.c                 |  13 +++
 8 files changed, 341 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h


base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
-- 
2.54.0.545.g6539524ca2-goog

