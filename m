Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A44C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 07:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3772960B22;
	Thu,  9 Jun 2022 07:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFrzezvgmiRG; Thu,  9 Jun 2022 07:12:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31B7F60E1A;
	Thu,  9 Jun 2022 07:12:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BB5AC0039;
	Thu,  9 Jun 2022 07:12:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAE81C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 07:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA56341C2E
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 07:12:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tf3GzfXIjmmg for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 07:12:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E604841C0F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654758724; x=1686294724;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/iNWtyXhoUjFCJMWGA58jiCCwl0OUy7BEC+3COjS34M=;
 b=PeY6MYnLIcqhP/iM5JkOdbex2MX0N9reQ2DkhWStou+W8DFKWL9JMVUo
 +DCjSQMTgu9PAG8Y733/4p64oER8P9wXbIEz2AsHl/8cnyu/1YoLm8cQw
 3Rts0ZCvZ1F7EAhIgJxq7DZCEuJyMGHuNv56pKxPIhrC244YWeqtPQ6xo
 d5mzXR36VxNWGGzTXE4R4vtAeT/0ZrBqdNKXfhRGsEkedzjbghCv8AIYV
 ofs5OFrS/t03nfrGynbsdQIHOHWtNmcsgUU7uVvzHa9AziUXSsgZdyCXA
 uCtpNE1bG44TfNo8btSY+erC+70Rcovg9VkIDCwVya1xgTpOO60C9aRsQ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="302546270"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="302546270"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 00:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; d="scan'208";a="580445921"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 09 Jun 2022 00:12:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Will Deacon <will@kernel.org>, Joao Martins <joao.m.martins@oracle.com>
Subject: [RFC PATCHES 2/2] iommu: Replace put_pages_list() with
 iommu_free_pgtbl_pages()
Date: Thu,  9 Jun 2022 15:08:11 +0800
Message-Id: <20220609070811.902868-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609070811.902868-1-baolu.lu@linux.intel.com>
References: <20220609070811.902868-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Therefore, RCU protected page free will take effect if necessary.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/amd/io_pgtable.c | 5 ++---
 drivers/iommu/dma-iommu.c      | 6 ++++--
 drivers/iommu/intel/iommu.c    | 4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6608d1717574..a62d5dafd7f2 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -423,7 +423,7 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 	}
 
 	/* Everything flushed out, free pages now */
-	put_pages_list(&freelist);
+	iommu_free_pgtbl_pages(&dom->domain, &freelist);
 
 	return ret;
 }
@@ -503,8 +503,7 @@ static void v1_free_pgtable(struct io_pgtable *iop)
 
 	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(dom);
-
-	put_pages_list(&freelist);
+	iommu_free_pgtbl_pages(&dom->domain, &freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f90251572a5d..a948358c3e51 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -132,7 +132,8 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 		if (fq->entries[idx].counter >= counter)
 			break;
 
-		put_pages_list(&fq->entries[idx].freelist);
+		iommu_free_pgtbl_pages(cookie->fq_domain,
+				       &fq->entries[idx].freelist);
 		free_iova_fast(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
@@ -228,7 +229,8 @@ static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
 		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
 
 		fq_ring_for_each(idx, fq)
-			put_pages_list(&fq->entries[idx].freelist);
+			iommu_free_pgtbl_pages(cookie->fq_domain,
+					       &fq->entries[idx].freelist);
 	}
 
 	free_percpu(cookie->fq);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 19024dc52735..f429671e837f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1891,7 +1891,7 @@ static void domain_exit(struct dmar_domain *domain)
 		LIST_HEAD(freelist);
 
 		domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw), &freelist);
-		put_pages_list(&freelist);
+		iommu_free_pgtbl_pages(&domain->domain, &freelist);
 	}
 
 	kfree(domain);
@@ -4510,7 +4510,7 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				      start_pfn, nrpages,
 				      list_empty(&gather->freelist), 0);
 
-	put_pages_list(&gather->freelist);
+	iommu_free_pgtbl_pages(domain, &gather->freelist);
 }
 
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
