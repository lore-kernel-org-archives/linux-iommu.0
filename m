Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B883260568
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758260577; cv=none; b=AMTGX0QD4NwzrlWLqHv05y/sQdDS23o+4LXp5EpWU3UTNcMNSRJQGQrCFPl2k1gOW5yCSciBkQ2u8c0UCHkDlFkILySM7YtZrqPXhdTNUp5V8emAF2462SN/M7XQYnY+blovxR6eOmREvbT1vqGAROf6wIvIm6vDPN7bV2dAalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758260577; c=relaxed/simple;
	bh=q4orb/9TcIzBYjB1lAxgyFEtZV3WTz8lFO2q41GLlcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwEwt8kJ2+gvNPE6vDaOkaO9Rp9kvgfGLQENkjeQe75Q6HESoEtvYMHrFal5IdO/2p+LOkU6S5Nk4u7jbPa2EJi9uquTN0TWI77htWFVj74pHbRqNj+lXhGHLuZbUqsOpB+veje5M8X9BZ4hW+XSiv0CrVJOLVwIVCL8pfaUy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4cQagnb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4cQagnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758260576; x=1789796576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q4orb/9TcIzBYjB1lAxgyFEtZV3WTz8lFO2q41GLlcw=;
  b=c4cQagnbN+k7O6JjWSXIky0k5XXk8dfb358C+HH78x9UHZwVn+euRjIl
   oREIFD7mHxXI1jID4dxmjZF8s4IIqh96vSPZsr6aDsHeJ9feENEzhq5lD
   w0N79DJ1lyUtha2yUSfty0J6mKd+dty48iNNTyIfTvppBB+72RFsOBvRn
   NgS4DPcCIWKfg9PN8+ojitwJNUbBph6N4PXMRv9e1BLlf9wYfZXut4KC7
   I8Thr1jhI39htQ+1Y6npZi0Po1rzZIAZiRnK1pA3B2WyouTQwr6zYgZEr
   oft/XDGSQbdbYB2ZDMRYV+kCTZB9FL+a4H6b7QUZZ7wUH7Y+HQZ+xIT8J
   w==;
X-CSE-ConnectionGUID: job+Uk9OQzqcwGYc/R1CTg==
X-CSE-MsgGUID: TS016a6VQeuo9ymZxs0gNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63235793"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="63235793"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 22:42:56 -0700
X-CSE-ConnectionGUID: +Vms+rOBQSqxVfmiElkoKg==
X-CSE-MsgGUID: Q6CmgcwOT0Wklf9A8kA2kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="180858678"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 22:42:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 4/8] mm: Introduce pure page table freeing function
Date: Fri, 19 Sep 2025 13:40:02 +0800
Message-ID: <20250919054007.472493-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250919054007.472493-1-baolu.lu@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave.hansen@linux.intel.com>

The pages used for ptdescs are currently freed back to the allocator
in a single location. They will shortly be freed from a second
location.

Create a simple helper that just frees them back to the allocator.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/mm.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f3db3a5ebefe..668d519edc0f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2884,6 +2884,13 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
 }
 #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
 
+static inline void __pagetable_free(struct ptdesc *pt)
+{
+	struct page *page = ptdesc_page(pt);
+
+	__free_pages(page, compound_order(page));
+}
+
 /**
  * pagetable_free - Free pagetables
  * @pt:	The page table descriptor
@@ -2893,12 +2900,10 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
  */
 static inline void pagetable_free(struct ptdesc *pt)
 {
-	struct page *page = ptdesc_page(pt);
-
 	if (ptdesc_test_kernel(pt))
 		ptdesc_clear_kernel(pt);
 
-	__free_pages(page, compound_order(page));
+	__pagetable_free(pt);
 }
 
 #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
-- 
2.43.0

