Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F90DC71142
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6AF20863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 17:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeTjpUw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6AF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E0FFD548A;
	Thu, 11 Jul 2019 17:28:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1A549530E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C5CF3886
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
	[217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4064A2166E;
	Thu, 11 Jul 2019 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562865579;
	bh=k/iOaZ5OkRD8Izs3xh+NcDcGmwj2+bi6abgC46LDDhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeTjpUw6enqun5t8UyRMD4xW165b84XiMVLjolugHs6uVhDMICSQAbPTNtmoGPQ/i
	1EaFgHAPEDaDMumvJpeNaul4DKYSvdsg0dWlou8dqXxcSTEGkwwCqmZDAm33Sk5DkB
	76RHgM2BeDg9nUjF3MPMv5wkQ/PoQIHq4IacLAnk=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 02/19] iommu/io-pgtable-arm: Remove redundant call to
	io_pgtable_tlb_sync()
Date: Thu, 11 Jul 2019 18:19:10 +0100
Message-Id: <20190711171927.28803-3-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
References: <20190711171927.28803-1-will@kernel.org>
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will@kernel.org>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Jon Masters <jcm@redhat.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Commit b6b65ca20bc9 ("iommu/io-pgtable-arm: Add support for non-strict
mode") added an unconditional call to io_pgtable_tlb_sync() immediately
after the case where we replace a block entry with a table entry during
an unmap() call. This is redundant, since the IOMMU API will call
iommu_tlb_sync() on this path and the patch in question mentions this:

 | To save having to reason about it too much, make sure the invalidation
 | in arm_lpae_split_blk_unmap() just performs its own unconditional sync
 | to minimise the window in which we're technically violating the break-
 | before-make requirement on a live mapping. This might work out redundant
 | with an outer-level sync for strict unmaps, but we'll never be splitting
 | blocks on a DMA fastpath anyway.

However, this sync gets in the way of deferred TLB invalidation for leaf
entries and is at best a questionable, unproven hack. Remove it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 1 -
 drivers/iommu/io-pgtable-arm.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 35de9ebb500c..6a6d6bb438d9 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -598,7 +598,6 @@ static size_t arm_v7s_split_blk_unmap(struct arm_v7s_io_pgtable *data,
 	}
 
 	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
-	io_pgtable_tlb_sync(&data->iop);
 	return size;
 }
 
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index b4e624afd1bb..b696b6c139cc 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -594,7 +594,6 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		tablep = iopte_deref(pte, data);
 	} else if (unmap_idx >= 0) {
 		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
-		io_pgtable_tlb_sync(&data->iop);
 		return size;
 	}
 
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
