Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710D2264B0
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835712; cv=none; b=kaXlZFNZ+bzxgGj9cwudHx2Ub5aYElFy5gSieXJDqmeCbDjkUkUxZTXHqFaQHuRCPDtpCmms3VwrJ3D4TROfs3vm/sYHBo47fi119ExlHSul4yOldB7WKVc/n9mss/0fdnIeU2Nve36w3KF9FjKbvvThxTDwfcnZib5MUVDTCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835712; c=relaxed/simple;
	bh=tge+8N4eSTSVxeb5T2g4NYzIYsLGM11CHJPIBUanVCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RnsCQYlVysQNhgERiJr9XO4Y/8cFltFegh4oYABOqWp/Cv/wdizlp7WQbaMCSOXNOedt2NH3GmJUr//SG6CroB9eG0LzL1QNt1LoGbJ/2gbDwvDOQyLZXToV+Igkd6KxP3umNt3kk+snETweQ214p9dW+teLRE2ZJeKG7LjG7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=sXKnHqsX; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="sXKnHqsX"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4877837890fso1126830fac.2
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1791835706; x=1792440506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C5VkKI5ZAzJ6cEJcZ3ResShuIP8Oeib9ArzUWA2J4tg=;
        b=sXKnHqsXBrk3imPoz9fooCaGRhrIN86M1sFYSCEcgfpt933gq3SA738jIBvrHLWLbx
         vieHAULUzNXUK4CiCxfguYoObuJkvq4GMb7KruABvvcPhbVCATZmSzFviSpVM8KCQGnv
         hs29NjR6T1udWLSj/23VbkBJMDeABmO2hA89LzyiuRh7Aka5Xw9Zct23G8Ce7ETD0N49
         Dx0jtbQvST0lcOYcuCyJDsW8LbJgHKq8tXsrQHeiOgg/eLrHvEBjbhZiO0QlNEbz+txZ
         8vUIVphMT0XOHIH6uVSVmCeHhV+NzH6GNu/DDOQLRdqI4+YpvGdAzLdzRR4yCpAd4+7n
         WBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835706; x=1792440506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C5VkKI5ZAzJ6cEJcZ3ResShuIP8Oeib9ArzUWA2J4tg=;
        b=MaFo8nai5nSqewZKkEupwb1HxsAoT1sOQ+SFaz3+DqK0/y7BDiJTtzjlyS7qnBfLDp
         I6baEuJoIXfnprPBqfmGETTIiZ+NAz6NtO1/aRYt/HfWkEdhMAHSIcYejyjcIVMWB+77
         nWBYQa+zgsfbsZQyQiqIyKIAByhi0Z5+sTOOywx9TsplCw/okVqilTLfVkJ5mwlmtrt2
         C0Dkjpg5GLQqa6hGIAM4plVtHHxkSEaSWMthjEKjZ0OgYsXHOPqRfXEHWlyv8vGqSx2+
         iRAB7ZugwME1XebjaNh8IroPT9VcqYKsTSknqRRRl7Nz/VNIbLBOCHI2vdkL5UPGHN8w
         eZPg==
X-Forwarded-Encrypted: i=1; AKwUvBwqWoDrJ+kKw4B6qXLjdekbFgivszDAEOkYB+EyxnsQml04P3QFGEQCIEFl2UAINT18FGiklw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKcPPLkzJ8pcPx+A4wtz13ZactbX5SezaEimSzbsZ4u9/nznYLh
	jdqCwpSrwshc1+rKipTt/ZMPV7wFBY+574GGGupIysjVeUdvuUvr0hOcI9JdV20dV+Y=
X-Gm-Gg: AYBFou03OSln8YPjv0wPd37HE1CDNWCzKnGRku2MKIOgQvL8TlaBVD/7QVHfFboIEmq
	E5IE+Q33Ke6yhos6pSOGXBnR781Y98ODqCpuVbdi8r9LFs4l00oL4CUxs57RhKvOKpxa+KKpOfk
	TUSJWQnAJovtv0VJ6jbBkhRFuPeJshnK1Yz5GeH3KvLhqJEcH5ksNWwtWqpItEqjGGJC/2TVgfL
	Wtk/X5suTkOf9AbNIgoxRVEbevlmriWms5U+49Tr5T7nI/v0gkVKiuVFhUAQvORQ/x6BD99efZ/
	ZDEdq438dOAuzvsxwHJvkUCsiKzv49a61Zy6apLZv6z/e2006n+148QF2irOnz1MGZkwGhNbd82
	m+BVddx3UXie+WYbW0FVIur7yIx2hPJZiX2lEnS3AuagFHV5L6723vQ+L6K79A9PNmlLrszlRpT
	as6ejAnM4kI9vfPF8lpB3MHnYNHkqYX9iVzvTXk1SbdJeEcAg3W+sePKz4r0toKHNPkm2POzfjN
	zRSI/QmJpsx7P0/f0lvOQ==
X-Received: by 2002:a05:6870:63aa:b0:493:ab63:38b2 with SMTP id 586e51a60fabf-4a2a8b0cf44mr8930726fac.57.1791835706237;
        Mon, 12 Oct 2026 13:08:26 -0700 (PDT)
Received: from paizhang-U9.taila8073d.ts.net ([70.116.71.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6aca4711csm2166166fac.4.2026.10.12.13.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 13:08:25 -0700 (PDT)
From: Peizhe Liu <peizheliu@utexas.edu>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	iommu@lists.linux.dev,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/sva: Charge IOPF allocations to the faulting mm's memcg
Date: Mon, 12 Oct 2026 15:08:23 -0500
Message-ID: <20261012200823.699316-1-peizheliu@utexas.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_sva_handle_mm() runs from the IOPF workqueue and calls
handle_mm_fault() for the faulting mm, but does not set the active
memcg. File-backed faults can allocate page cache through
mem_cgroup_charge(folio, NULL, gfp), which falls back to the root memcg
when the worker has neither an active memcg nor a current->mm. Page
cache faulted in by a device is therefore charged to root and escapes
the task's memory.max.

Set the active memcg to the one associated with the faulting mm while
handling the fault, and restore the previous value afterwards.

Fixes: fc36479db74e ("iommu: Add a page fault handler")
Signed-off-by: Peizhe Liu <peizheliu@utexas.edu>
---
Tested on a Xeon Gold 5512U with Intel DSA, based on iommu/next.
Before/after testing confirmed that the block-on-fault case charges
the page cache to the task's memcg after this change and is subject
to memory.max.

 drivers/iommu/iommu-sva.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 9827cb804363..9a825fac61a5 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -2,6 +2,7 @@
 /*
  * Helpers for IOMMU drivers implementing SVA
  */
+#include <linux/memcontrol.h>
 #include <linux/mmu_context.h>
 #include <linux/mmu_notifier.h>
 #include <linux/mutex.h>
@@ -220,6 +221,7 @@ iommu_sva_handle_mm(struct iommu_fault *fault, struct mm_struct *mm)
 	unsigned int access_flags = 0;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 	struct iommu_fault_page_request *prm = &fault->prm;
+	struct mem_cgroup *memcg, *old_memcg;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
 
 	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
@@ -255,7 +257,11 @@ iommu_sva_handle_mm(struct iommu_fault *fault, struct mm_struct *mm)
 		/* Access fault */
 		goto out_put_mm;
 
+	memcg = get_mem_cgroup_from_mm(mm);
+	old_memcg = set_active_memcg(memcg);
 	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
 	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
 		IOMMU_PAGE_RESP_SUCCESS;
 

base-commit: c233d59828627bfaab750ec5546e81970475f951
-- 
2.53.0

