Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A6EC74A5B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 16:24:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CB520838
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 16:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gAz4ET5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CB520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 06E0553DC;
	Thu, 11 Jul 2019 16:24:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15A655352
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 16:18:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com
	[209.85.217.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ECA0D88E
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 16:18:03 +0000 (UTC)
Received: by mail-vs1-f65.google.com with SMTP id a186so3025082vsd.7
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=b+cG1tTNIT8vyBDamuWQU7Q8BkXJo14FevzuM5Gnb24=;
	b=gAz4ET5S3vPh5pe2Xkp4fm2GOI2krQN7MsVLeA6tR+Z7xtZ0VyhLDTOT2Ub4nlDnKq
	Dbfdtp5Urdye3lqnltelIy8/uXcwd82CtHZ+KPzXEkZOI4YsXU+I4HEW7ZQwMdaBcGD9
	BpoSO1nKdppKqVMcEMgYENHOKC4uO6HlaKhviQiG3wXZPji1TMEngmACIveXTurzCTBz
	vusQFsrSVPf1maLNr1r2UILzU22+Qj1/lNvaam7ceZTN1kzqgF1m/NHYXT8kdqVu5tbl
	Qd/JdXW29HvYepqvv1y3f9v6VXjzLKEVQOr5fyxWDlFJp8v/R0yqRptzksbbivYN5BPu
	bsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=b+cG1tTNIT8vyBDamuWQU7Q8BkXJo14FevzuM5Gnb24=;
	b=QQyqLBKdVpTzhNHT3KrlI5o2j6JCuXIkNRfFO7LEWfKhKcipA/IOnj6k8FwBxUSzZC
	1XYYw2mfkUmbbbGELyM7Ent76TNBMhAIW96lriK2Wcg+HRZ/M6Z2qn1ooo5JJ3mJL5mG
	pSv2XWcxrxPHvIqm8/p7wrcrO8I45TEZACYAah52t7Rsr43yIE0iN6gSRDy+2KSOjmrB
	t1RfQLYVmATUl+zFHtnWT3ITLIZYBzl1XPWOHI+8XCBAMgwFoByDk1CAFAwBz4+dvkO6
	XXIqVOXsQj4nAGCyFZyLVeypINKHdnAOQNisjukiNWHn/lK+4yeUqGDZK5bL4ZgCJgVH
	gd6g==
X-Gm-Message-State: APjAAAXyNuqocjNh7F7YoWV/+0VSOSF46oAj/3nVsMTtCxeOBgwK77m1
	BJkzj4iJ9yasfL+MqZaEiHz/sw==
X-Google-Smtp-Source: APXvYqxltyjmsNj/nb8bUQp+32rwb7mo8D5CMMYCV7KYmWTJRqhvB9IHbI2B3WokHDj4YgJGnwY77A==
X-Received: by 2002:a05:6102:8c:: with SMTP id
	t12mr5568901vsp.143.1562861882866; 
	Thu, 11 Jul 2019 09:18:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id v5sm6960119vsi.24.2019.07.11.09.18.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Jul 2019 09:18:01 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH v2] iommu/amd: fix a crash in iova_magazine_free_pfns
Date: Thu, 11 Jul 2019 12:17:45 -0400
Message-Id: <1562861865-23660-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: iommu@lists.linux-foundation.org, torvalds@linux-foundation.org, hch@lst.de,
	linux-kernel@vger.kernel.org
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

The commit b3aa14f02254 ("iommu: remove the mapping_error dma_map_ops
method") incorrectly changed the checking from dma_ops_alloc_iova() in
map_sg() causes a crash under memory pressure as dma_ops_alloc_iova()
never return DMA_MAPPING_ERROR on failure but 0, so the error handling
is all wrong.

   kernel BUG at drivers/iommu/iova.c:801!
    Workqueue: kblockd blk_mq_run_work_fn
    RIP: 0010:iova_magazine_free_pfns+0x7d/0xc0
    Call Trace:
     free_cpu_cached_iovas+0xbd/0x150
     alloc_iova_fast+0x8c/0xba
     dma_ops_alloc_iova.isra.6+0x65/0xa0
     map_sg+0x8c/0x2a0
     scsi_dma_map+0xc6/0x160
     pqi_aio_submit_io+0x1f6/0x440 [smartpqi]
     pqi_scsi_queue_command+0x90c/0xdd0 [smartpqi]
     scsi_queue_rq+0x79c/0x1200
     blk_mq_dispatch_rq_list+0x4dc/0xb70
     blk_mq_sched_dispatch_requests+0x249/0x310
     __blk_mq_run_hw_queue+0x128/0x200
     blk_mq_run_work_fn+0x27/0x30
     process_one_work+0x522/0xa10
     worker_thread+0x63/0x5b0
     kthread+0x1d2/0x1f0
     ret_from_fork+0x22/0x40

Fixes: b3aa14f02254 ("iommu: remove the mapping_error dma_map_ops method")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Fix the offensive commit directly.

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 73740b969e62..b607a92791d3 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2533,7 +2533,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	npages = sg_num_pages(dev, sglist, nelems);
 
 	address = dma_ops_alloc_iova(dev, dma_dom, npages, dma_mask);
-	if (address == DMA_MAPPING_ERROR)
+	if (!address)
 		goto out_err;
 
 	prot = dir2prot(direction);
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
