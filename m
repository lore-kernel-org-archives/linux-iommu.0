Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86223C43140
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 08:56:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A61C20578
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 08:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A61C20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 09E8C1E87;
	Fri,  6 Sep 2019 08:56:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3534710C9
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 08:56:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 77BD6756
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 08:56:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id AD755AECB;
	Fri,  6 Sep 2019 08:56:49 +0000 (UTC)
Date: Fri, 6 Sep 2019 10:56:47 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/amd: Fix race in increase_address_space()
Message-ID: <20190906085647.GE5457@suse.de>
References: <1567632262-21284-1-git-send-email-cai@lca.pw>
	<20190905114339.GC5457@suse.de> <1567717041.5576.102.camel@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567717041.5576.102.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: don.brace@microsemi.com, iommu@lists.linux-foundation.org,
	esc.storagedev@microsemi.com, hch@lst.de, linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Sep 05, 2019 at 04:57:21PM -0400, Qian Cai wrote:
> On Thu, 2019-09-05 at 13:43 +0200, Joerg Roedel wrote:
> > But I think the right fix is to lock the operation in
> > increase_address_space() directly, and not the calls around it, like in
> > the diff below. It is untested, so can you please try it and report back
> > if it fixes your issue?
> 
> Yes, it works great so far.

Thanks for testing! I queued the patch below to the IOMMU tree and will
send it upstream for v5.3 today.

Thanks,

	Joerg

From 754265bcab78a9014f0f99cd35e0d610fcd7dfa7 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Fri, 6 Sep 2019 10:39:54 +0200
Subject: [PATCH] iommu/amd: Fix race in increase_address_space()

After the conversion to lock-less dma-api call the
increase_address_space() function can be called without any
locking. Multiple CPUs could potentially race for increasing
the address space, leading to invalid domain->mode settings
and invalid page-tables. This has been happening in the wild
under high IO load and memory pressure.

Fix the race by locking this operation. The function is
called infrequently so that this does not introduce
a performance regression in the dma-api path again.

Reported-by: Qian Cai <cai@lca.pw>
Fixes: 256e4621c21a ('iommu/amd: Make use of the generic IOVA allocator')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f853b96ee547..61de81965c44 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1435,18 +1435,21 @@ static void free_pagetable(struct protection_domain *domain)
  * another level increases the size of the address space by 9 bits to a size up
  * to 64 bits.
  */
-static bool increase_address_space(struct protection_domain *domain,
+static void increase_address_space(struct protection_domain *domain,
 				   gfp_t gfp)
 {
+	unsigned long flags;
 	u64 *pte;
 
-	if (domain->mode == PAGE_MODE_6_LEVEL)
+	spin_lock_irqsave(&domain->lock, flags);
+
+	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
 		/* address space already 64 bit large */
-		return false;
+		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
-		return false;
+		goto out;
 
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					iommu_virt_to_phys(domain->pt_root));
@@ -1454,7 +1457,10 @@ static bool increase_address_space(struct protection_domain *domain,
 	domain->mode    += 1;
 	domain->updated  = true;
 
-	return true;
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return;
 }
 
 static u64 *alloc_pte(struct protection_domain *domain,
-- 
2.16.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
