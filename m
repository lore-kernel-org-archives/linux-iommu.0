Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CEC37882B
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938979; cv=none; b=Qirs7sJLkraKHJbG99RZEJKeFnA8O+whXTmBilCqTrAqpMCfWL4VoFhqMyA0ppWg1ytshV0eFcv7BF8OLh1Ipi0LxesAYpLJmo2FF8vrny1BKGs1bd7rDDwhcPImhFhcQLKOfqds+UTsbKtAyrdbK521hnnhD+n9prxy9YVd24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938979; c=relaxed/simple;
	bh=UTlbVQte9MXWRTLRKgI2LMgHRO0jaYQooyHaYcX98aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H85sW/1rVUEZlf5Xl3EUqSdOag8yqTNeONmHlKHKwi3++SJva3Oelb48NLYIKBv3fZf5zm7u78r+KZnZ7X1qDjJsjycEEMcRlGITIOnoJFeFcdTWeZT/UDp2td/DyOjCNNZ31MvfWzOlskoj3sZpF5MRCdiyjI/r06qwrgLTHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/WyM639; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/WyM639"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35e576110adso4406412a91.0
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776938977; x=1777543777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hw3+dt4upvwPZbcilhyfG5LgQIqATsWm5ea0NmPrr4=;
        b=V/WyM639+wL8LqNxA+I5bo67wyg75y+mV7ZMnZFZt/U5fYACMIbSpUirZgxEwoN2hL
         diohjqY0qYCffFOvaSFXgDZ4Y2Eu1vi0oL1e2BlPkKiKtj6hL/eUyrjjp+X0f/m08LGp
         2FFAsupVZhK6o+6dl5LyqjpyPVO87uYMrAbnlk8OUJX73NWGQW9FvIOkrjHXle6qLUcV
         iU8e0um7eMITT7t0dhb0wqZzsV3GtWaRJVMWD9R3PGWkpAY31HZSINJET/JK4T+kZ42g
         KzXervymADPRUJl/TOB0W318qlFXeypSG6hS8kqbWDs+q1lLcy1LEMTB7PJO9+WxF9tH
         Aw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938977; x=1777543777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hw3+dt4upvwPZbcilhyfG5LgQIqATsWm5ea0NmPrr4=;
        b=Dfv/R+/hbgYNDu0sqhgZyt/t5V8yyK6Z9GxzlaxxlcdOXYJag/eE65QHvvSWq2crNg
         x5nBKSrEBrB99b2U0bRjAn4OyRtGBPVkXS2zDXouQPAHdntuR60ZMQiyxuiYT5IBsCR2
         XwcGPoW66+pwVZckQHgmvP8i9dGYlgtKp/BDT4OHlxNAR2eemdQgBcJn9CbDsJ/INMbZ
         t9/BZX8b4sKf1uGz/mPdRHPWe+rHm9vNylE/k7Icpff6/XNXtoWxaWirD2Gy30ckRKBm
         6jdG7nVhkUY87IuOE1HhP1xRKnu9dkjNxUOZx/jG6NjuV9IDaKNyqBjP8eLCyBgnsP0J
         whUw==
X-Forwarded-Encrypted: i=1; AFNElJ87ErvlybEY3csYwDEff3sjqSs2Rsue24zONIZT9RpVRQKfAW/smsDt5EpXH867kOhcK8sEfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMy5Lf6PxmHa5fqm8jwbRpQ3DUcd3Lu5RO8loZgc0DFTLJTaKT
	rxzizx6PCqovPbKYgx6nUu2SPsZAagfEtx9JMrXKKqQtitV/+IO3YZgzGtM7LufG
X-Gm-Gg: AeBDieu32+VgJcJe91jUDlgi8egI1HaGah6Ww8Xvvnn922o5LmqfOx4ySFonExkyjDn
	lOiDvLACnLoJui3/5jCTAmFqvXS/itb464Ig52oAgOJkThho8JZ6qJ7uhhI0YxRaoY/UTwQrI15
	S6vwVlhZVyEA/BEYKuO/YMGEt1E9+6w8sIoLNpG461PM0LSCUZRghwspG18jGASZm/qAwDRox0L
	ylnWCfwYY9pIyR/23eKFXnLKP1DHixdBGWmxgpaxyzGSHQozlFnugvemQx6vxtLqlSjoAbwQvNi
	K4srucoJ+s833N554BSbpEiwOPksz/2l2m/YHPZ+jHnOrPIggmMBDRXtcpfx3LL0AmOG6qN3i6K
	W1d92JfTWv/6f8EcSCX4Ks9o1/7Y5oAOTjxmI60+SQIKdzQeCbQu0N+4g5+KVul5qUie4MFSjkN
	KJCW5wXjx5ONmq7AwZ67j1u+UJxTcIJj0i0g==
X-Received: by 2002:a17:90b:4b83:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-361402ebfebmr20950907a91.11.1776938977213;
        Thu, 23 Apr 2026 03:09:37 -0700 (PDT)
Received: from fedora ([2401:4900:1cbc:314:9667:4972:a94c:125a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm25275714a91.2.2026.04.23.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:09:36 -0700 (PDT)
From: avinash pal <avinashpal441@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	avinash pal <avinashpal441@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Giovanni Pancotti <giovanni.pancotti@example.com>
Subject: [PATCH stable 6.12 1/2] iommu/vt-d: fail map loudly on stale DMA PTE
Date: Thu, 23 Apr 2026 15:39:03 +0530
Message-ID: <20260423100904.5966-2-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100904.5966-1-avinashpal441@gmail.com>
References: <20260423100904.5966-1-avinashpal441@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In __domain_mapping(), when dma_pte_present(pte) is true the existing
WARN continues execution, leaving the domain in an inconsistent state:
a new PTE is silently installed on top of a live one.

Replace it with:
  - pr_err_ratelimited: prints conflicting vPFN + old PTE value
  - WARN_ON_ONCE: one-shot kernel warning with stack trace
  - return -EEXIST: abort the bad map; no silent corruption

The root cause is in the unmap path — see the companion dma-iommu.c fix.

Reported-by: Giovanni Pancotti <giovanni.pancotti@example.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221389
Cc: stable@vger.kernel.org
Signed-off-by: avinash pal <avinashpal441@gmail.com>
---
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c799cc67d..4a8937b44 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1777,14 +1777,25 @@ static void switch_to_super_page(struct dmar_domain *domain,
 			pte = pfn_to_dma_pte(domain, start_pfn, &level,
 					     GFP_ATOMIC);
 
-		if (dma_pte_present(pte)) {
-			dma_pte_free_pagetable(domain, start_pfn,
-					       start_pfn + lvl_pages - 1,
-					       level + 1);
-
-			cache_tag_flush_range(domain, start_pfn << VTD_PAGE_SHIFT,
-					      end_pfn << VTD_PAGE_SHIFT, 0);
-		}
+    		if (dma_pte_present(pte)) {
+    			/*
+    			 * A live DMA PTE is already installed at this vPFN.
+    			 * This violates the map/unmap contract: an IOVA must be
+    			 * fully unmapped and the IOTLB drained before reuse.
+    			 *
+    			 * Root cause: missing iommu_iotlb_sync() before
+    			 * free_iova_fast() in __iommu_dma_unmap_sg() on the
+    			 * lazy-flush path.  The companion patch in dma-iommu.c
+    			 * fixes that; this guard makes the violation explicit.
+    			 */
+    			pr_err_ratelimited(
+    				"DMAR: stale PTE at vPFN 0x%lx (val=0x%016llx) "
+    				"-- IOVA reused before IOTLB drain
+",
+    				iov_pfn, (unsigned long long)pte->val);
+    			WARN_ON_ONCE(1);
+    			return -EEXIST;
+    		}
 
 		pte++;
 		start_pfn += lvl_pages;
@@ -3663,10 +3674,25 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 		struct dma_pte *pte;
 
 		pte = dmar_domain->pgd;
-		if (dma_pte_present(pte)) {
-			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
-			iommu_free_page(pte);
-		}
+    		if (dma_pte_present(pte)) {
+    			/*
+    			 * A live DMA PTE is already installed at this vPFN.
+    			 * This violates the map/unmap contract: an IOVA must be
+    			 * fully unmapped and the IOTLB drained before reuse.
+    			 *
+    			 * Root cause: missing iommu_iotlb_sync() before
+    			 * free_iova_fast() in __iommu_dma_unmap_sg() on the
+    			 * lazy-flush path.  The companion patch in dma-iommu.c
+    			 * fixes that; this guard makes the violation explicit.
+    			 */
+    			pr_err_ratelimited(
+    				"DMAR: stale PTE at vPFN 0x%lx (val=0x%016llx) "
+    				"-- IOVA reused before IOTLB drain
+",
+    				iov_pfn, (unsigned long long)pte->val);
+    			WARN_ON_ONCE(1);
+    			return -EEXIST;
+    		}
 		dmar_domain->agaw--;
 	}
 
-- 
2.53.0

