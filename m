Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8E277C8E
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757051613; cv=none; b=B2w9IOzAaZ9gz2Q8s7CDos763S0cOCmyq5xS1FRkst15mxgQ7KLIoe6iLwO4uqkzc3EpCfVc2r0tyjmQtstDG2RAJdCFtuzu/umZDg25SIvNvtnimBHReyolKSYd5FyYx9gw960AKl7Uejx+LCXNYY6OaAyl89IQiRF2tM+OvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757051613; c=relaxed/simple;
	bh=06/+ZM2sQw/mZYTfVv/UgyDLaMzOZL+wDFfEyuV6AOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjf+M5v04LPdb1Kz8OZX9KerXhnARqdrYzUvyRl51/xnajCHY2sMCh8ZDlvuZ1DAk3PvgeKnMhdeUVVwqBWpp3g9xIn6/t4o3sN/5apd9cF2/Si3kZ15z+R0F9tb6lCxUxdqAAnfhHkl4t3ozNQPneJeTFQpCzkmeuSzdIj2Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kA3VqUNd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kA3VqUNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757051612; x=1788587612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06/+ZM2sQw/mZYTfVv/UgyDLaMzOZL+wDFfEyuV6AOo=;
  b=kA3VqUNd0nzxJqmGWcg3+VlyfURcuDnaRDO/unbW2xC1tExCfTPSLS85
   tIXuhv82OVtCvRahyAv2TqsJMNfrK8xVke3r7nTC0ilbFu/sV+07aKVzb
   BDhW4xmQuRjH0caZ059+Ays+rD0aj4VGodylS1Tf7MU/3hTrSebqu83X+
   ODvDviw/xMlIZJzJAYWG1MbfA//X8Jr3zn4NzTU1g17Rswf/WPQRityHF
   6apGN7n2OuR0uyf78h0g7dO/pmjFow9T2WcUtcmGnBMXAGVtQDE4U3Myk
   QUUNpYDW+/aVhD5DdSBxP7zbq5qzU6HmGopZuHUhnguUKA0nwNsvt0Lf9
   w==;
X-CSE-ConnectionGUID: +0/yGbd2TTGKowOoWEAJSA==
X-CSE-MsgGUID: 1cX3mk33TViOysXx89utow==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70015123"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="70015123"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 22:53:31 -0700
X-CSE-ConnectionGUID: 9YwW1+2cTLem58JfY/g7TA==
X-CSE-MsgGUID: rF0Kh1uNRRC9WUBmJy4+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="209257736"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2025 22:53:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 4/8] mm: Introduce pure page table freeing function
Date: Fri,  5 Sep 2025 13:50:59 +0800
Message-ID: <20250905055103.3821518-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
References: <20250905055103.3821518-1-baolu.lu@linux.intel.com>
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

