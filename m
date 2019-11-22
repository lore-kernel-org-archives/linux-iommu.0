Return-Path: <SRS0=Z7Xn=ZO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B77C432C0
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:25:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C132067D
	for <iommu@archiver.kernel.org>; Fri, 22 Nov 2019 03:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XZMJrLP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C132067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E47388A13;
	Fri, 22 Nov 2019 03:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lAhG3BMvOyE8; Fri, 22 Nov 2019 03:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C203E888C4;
	Fri, 22 Nov 2019 03:25:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4518C1DD8;
	Fri, 22 Nov 2019 03:25:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C300C18DA
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5706820450
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rn3WaJpxbEvo for <iommu@lists.linux-foundation.org>;
 Fri, 22 Nov 2019 03:25:25 +0000 (UTC)
X-Greylist: delayed 00:23:28 by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 085B520431
 for <iommu@lists.linux-foundation.org>; Fri, 22 Nov 2019 03:25:25 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id n4so6286927qte.2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Nov 2019 19:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dtosei2WN9GMgSJa41yHggbCmmspG55kEXkqTZYgrxQ=;
 b=XZMJrLP5pumaNiOkQSku9hZ/Ex7KQRPGWfh0IHF4XUW182EFj//9CscFh12cCbuxqz
 cK7h43jax4RKPHaLtfEgBNH3q0V3X/bhlvV5XOzH1I5g2IbHK1S0wnfcrhs3shu44UqW
 9M5+HjpYVoPU4RqpEvWq8lBEXxFnn7Hw1lL4mABF5+m+QpxHuGCWe+sKF0GqQ+XvNY1w
 plrpIYgFTcBcXxOCQrXE1PbaHqw//lQEu3F0xlKte0M+dbgttyawCN2uf/+lo2AcNSVq
 aumNw2ydMsLhv2diO//lcEYCXegLiFZO4rj3vhI+KtFeHCdRxJ/uCEW8lnWKy6Mp1Jux
 aG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dtosei2WN9GMgSJa41yHggbCmmspG55kEXkqTZYgrxQ=;
 b=hm3a0JH3z3IfyXdIofgv1wE+zyyHLSU6nTHjCy0jse6tLKodTuZQuInj5u3VG/aL0u
 XIaVWiP6upK8AT6hEDrhTs7MLRmG+nrGmrI4tXihCtpzqNgX4AHjNBufl2plFRtC0POc
 Eg2/UqeZDSE6sLlEYM22cFdBu6i+4TmZRbAnKk5f5unHsABkc00FQ78NKm+MM74Q0Wfs
 pN5/BH5ATUgLbUWslSSilZ3lUY7IqNCmGKIEW1D4SIssfYbv/Kb7PY+lZJhbBnDY4iAC
 41gOG0kPHaxqF66Gjbf+C6kqY1OPV043NpBzkVUXop/Vkqwb8RHgsJOrJmtH/mbcIgab
 FYSg==
X-Gm-Message-State: APjAAAUmdd102PcSNneUFWAzQXEtxYT1mrEgP39UQY6ghT8+x8LYyzvk
 VCd6EuuqQF1ChKFGqcdhU5tSgiXBe+/qyQ==
X-Google-Smtp-Source: APXvYqzHHA+GsVokJj9Z/PfUI+0XpRUH38+kPJ+eB7MwYuzX5dpnbiPDjZalZbEpsSDZAsjSjQA5DA==
X-Received: by 2002:a37:a18d:: with SMTP id
 k135mr11093412qke.342.1574391321495; 
 Thu, 21 Nov 2019 18:55:21 -0800 (PST)
Received: from ovpn-126-0.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id n18sm2582804qtl.40.2019.11.21.18.55.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 18:55:20 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH v2] iommu/iova: silence warnings under memory pressure
Date: Thu, 21 Nov 2019 21:55:10 -0500
Message-Id: <20191122025510.4319-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 joe@perches.com, dwmw2@infradead.org
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

When running heavy memory pressure workloads, this 5+ old system is
throwing endless warnings below because disk IO is too slow to recover
from swapping. Since the volume from alloc_iova_fast() could be large,
once it calls printk(), it will trigger disk IO (writing to the log
files) and pending softirqs which could cause an infinite loop and make
no progress for days by the ongoimng memory reclaim. This is the counter
part for Intel where the AMD part has already been merged. See the
commit 3d708895325b ("iommu/amd: Silence warnings under memory
pressure"). Since the allocation failure will be reported in
intel_alloc_iova(), so just call printk_ratelimted() there and silence
the one in alloc_iova_mem() to avoid the expensive warn_alloc().

 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 slab_out_of_memory: 66 callbacks suppressed
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: iommu_iova, object size: 40, buffer size: 448, default order:
0, min order: 0
   node 0: slabs: 1822, objs: 16398, free: 0
   node 1: slabs: 2051, objs: 18459, free: 31
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: iommu_iova, object size: 40, buffer size: 448, default order:
0, min order: 0
   node 0: slabs: 1822, objs: 16398, free: 0
   node 1: slabs: 2051, objs: 18459, free: 31
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: iommu_iova, object size: 40, buffer size: 448, default order:
0, min order: 0
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 1: slabs: 381, objs: 2286, free: 27
   node 1: slabs: 381, objs: 2286, free: 27
   node 1: slabs: 381, objs: 2286, free: 27
   node 1: slabs: 381, objs: 2286, free: 27
   node 0: slabs: 1822, objs: 16398, free: 0
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 1: slabs: 2051, objs: 18459, free: 31
   node 0: slabs: 697, objs: 4182, free: 0
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
   node 1: slabs: 381, objs: 2286, free: 27
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 0: slabs: 697, objs: 4182, free: 0
   node 1: slabs: 381, objs: 2286, free: 27
 hpsa 0000:03:00.0: DMAR: Allocating 1-page iova failed
 warn_alloc: 96 callbacks suppressed
 kworker/11:1H: page allocation failure: order:0,
mode:0xa20(GFP_ATOMIC), nodemask=(null),cpuset=/,mems_allowed=0-1
 CPU: 11 PID: 1642 Comm: kworker/11:1H Tainted: G    B
 Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420 Gen9, BIOS U19
12/27/2015
 Workqueue: kblockd blk_mq_run_work_fn
 Call Trace:
  dump_stack+0xa0/0xea
  warn_alloc.cold.94+0x8a/0x12d
  __alloc_pages_slowpath+0x1750/0x1870
  __alloc_pages_nodemask+0x58a/0x710
  alloc_pages_current+0x9c/0x110
  alloc_slab_page+0xc9/0x760
  allocate_slab+0x48f/0x5d0
  new_slab+0x46/0x70
  ___slab_alloc+0x4ab/0x7b0
  __slab_alloc+0x43/0x70
  kmem_cache_alloc+0x2dd/0x450
 SLUB: Unable to allocate memory on node -1, gfp=0xa20(GFP_ATOMIC)
  alloc_iova+0x33/0x210
   cache: skbuff_head_cache, object size: 208, buffer size: 640, default
order: 0, min order: 0
   node 0: slabs: 697, objs: 4182, free: 0
  alloc_iova_fast+0x62/0x3d1
   node 1: slabs: 381, objs: 2286, free: 27
  intel_alloc_iova+0xce/0xe0
  intel_map_sg+0xed/0x410
  scsi_dma_map+0xd7/0x160
  scsi_queue_rq+0xbf7/0x1310
  blk_mq_dispatch_rq_list+0x4d9/0xbc0
  blk_mq_sched_dispatch_requests+0x24a/0x300
  __blk_mq_run_hw_queue+0x156/0x230
  blk_mq_run_work_fn+0x3b/0x40
  process_one_work+0x579/0xb90
  worker_thread+0x63/0x5b0
  kthread+0x1e6/0x210
  ret_from_fork+0x3a/0x50
 Mem-Info:
 active_anon:2422723 inactive_anon:361971 isolated_anon:34403
  active_file:2285 inactive_file:1838 isolated_file:0
  unevictable:0 dirty:1 writeback:5 unstable:0
  slab_reclaimable:13972 slab_unreclaimable:453879
  mapped:2380 shmem:154 pagetables:6948 bounce:0
  free:19133 free_pcp:7363 free_cma:0

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use dev_err_ratelimited() and improve the commit messages.

 drivers/iommu/intel-iommu.c | 3 ++-
 drivers/iommu/iova.c        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6db6d969e31c..c01a7bc99385 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3401,7 +3401,8 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	iova_pfn = alloc_iova_fast(&domain->iovad, nrpages,
 				   IOVA_PFN(dma_mask), true);
 	if (unlikely(!iova_pfn)) {
-		dev_err(dev, "Allocating %ld-page iova failed", nrpages);
+		dev_err_ratelimited(dev, "Allocating %ld-page iova failed",
+				    nrpages);
 		return 0;
 	}
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 41c605b0058f..aa1a56aaa5ee 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -233,7 +233,7 @@ static DEFINE_MUTEX(iova_cache_mutex);
 
 struct iova *alloc_iova_mem(void)
 {
-	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_NOWARN);
 }
 EXPORT_SYMBOL(alloc_iova_mem);
 
-- 
2.21.0 (Apple Git-122.2)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
