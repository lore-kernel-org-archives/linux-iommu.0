Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C89C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 18:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A37781384;
	Mon, 13 Dec 2021 18:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFxft-lsfmCh; Mon, 13 Dec 2021 18:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C01D8137F;
	Mon, 13 Dec 2021 18:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12AAFC002F;
	Mon, 13 Dec 2021 18:33:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AEB0C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 483E740250
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tq-group.com header.b="CR36BrI/";
 dkim=pass (2048-bit key) header.d=tq-group.com header.b="aGj4l0MC"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUI4RFmvfQMn for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 12:40:38 +0000 (UTC)
X-Greylist: delayed 00:07:12 by SQLgrey-1.8.0
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B6A240243
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1639399237; x=1670935237;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BDj9ra8itOriardQ6ZRvtI5csjEmV2CGanL5WbQl7dU=;
 b=CR36BrI/3mqaBvrTcIN2Qw3otgeJ3sAJK+w81RdNIg9noIOL5qzoaWz6
 uM0I0YxMWeCkYS4edbHE0VDcx39I63vH7s1xon0M06f4S4HVcNewHOBoL
 /EyqSasgACZeAUjJDIMUdvqjtXEeU0KB8EZXza7/rDGl5/EXDLaQ+UrVN
 36+lOZRJlgxDtDLRSrHd+jSZ9Wu7OMW8ULlBvKz2Lxan58wo9XtTcBGWK
 UFhRm94/2+YuMdIAunvsM630oMFniuEVc8nDlwgVlbYzUy7fFaRDzgsG0
 j8Q/IBVaYe2g1YuhJPF6axaQCXc2LkGwUocQcFjBW6hCu5enOlugYZx0L w==;
X-IronPort-AV: E=Sophos;i="5.88,202,1635199200"; d="scan'208";a="21010718"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
 by mx1-pgp.tq-group.com with ESMTP; 13 Dec 2021 13:33:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
 by tq-pgp-pr1.tq-net.de (PGP Universal service);
 Mon, 13 Dec 2021 13:33:21 +0100
X-PGP-Universal: processed;
 by tq-pgp-pr1.tq-net.de on Mon, 13 Dec 2021 13:33:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1639398801; x=1670934801;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BDj9ra8itOriardQ6ZRvtI5csjEmV2CGanL5WbQl7dU=;
 b=aGj4l0MC3mKowFrmvLlcbmhjx2jxmfEohBfTL6zHpmalJNNJfA9DcfvI
 M2lEMp19C9+swqPGnY2klrfqFETOAccBK7egk6vElUfqO7ZsAbszk29A3
 VmxdpxXLv8hGhkT7B7I3+WSuACT0d1j5Hpz5dKH+id+XHSJy9qRDWzoUO
 BiLFi1n3zS3WenSJ0PP82OzdLqziRkVyOQ35aLZsBzbXUCJSHRrid0AXA
 DSAMwp3cxvpLctvZOA/meicQ7vS4DmgGwL/B84U1qVC1weTithlgmpkWY
 LzMynwQBJk5zm5VtbvkPpVsZ/VT83PlxctO6QJPDZbLt2pa2rmN3A0Oc6 g==;
X-IronPort-AV: E=Sophos;i="5.88,202,1635199200"; d="scan'208";a="21010717"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 13 Dec 2021 13:33:21 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9A511280065;
 Mon, 13 Dec 2021 13:33:20 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/1] dma-direct: Fix dma_direct_use_pool helper
Date: Mon, 13 Dec 2021 13:33:11 +0100
Message-Id: <20211213123311.2399611-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Dec 2021 18:33:25 +0000
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

During refactoring the logic around gfpflags_allow_blocking() got inverted
due to missing '!'. Fix this by adding it back.

Fixes: 8d7c141bb80f ("dma-direct: add a dma_direct_use_pool helper")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
I bisected this to the commit in 'Fixed:' tag. Here is the splat:
------------[ cut here ]------------                                                                                                                                                                                                                                           
Failed to get suitable pool for 30be0000.ethernet                                                                                                                                                                                                                              
WARNING: CPU: 0 PID: 62 at kernel/dma/pool.c:279 dma_alloc_from_pool+0x88/0x1d0                                                                                                                                                                                                
Modules linked in:                                                                                                                                                                                                                                                             
CPU: 0 PID: 62 Comm: kworker/u8:2 Not tainted 5.16.0-rc4-tq+ #238                                                                                                                                                                                                              
Hardware name: TQ-Systems GmbH i.MX8MQ TQMa8MQ on MBa8Mx (DT)                                                                                                                                                                                                                  
Workqueue: events_unbound deferred_probe_work_func                                                                                                                                                                                                                             
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)                                                                                                                                                                                                                
pc : dma_alloc_from_pool+0x88/0x1d0                                                                                                                                                                                                                                            
lr : dma_alloc_from_pool+0x88/0x1d0                                                                                                                                                                                                                                            
sp : ffff8000126b3860                                                                                                                                                                                                                                                          
x29: ffff8000126b3860 x28: ffff800012133d68 x27: 0000000000000000                                                                                                                                                                                                              
x26: ffff0000c03e0000 x25: ffff8000126b3930 x24: ffff0000c08ee010                                                                                                                                                                                                              
x23: ffff800012133d48 x22: ffff80001011f4b0 x21: ffff800011712820                                                                                                                                                                                                              
x20: 0000000000018000 x19: ffff0000c0ef8000 x18: 0000000000000014                                                                                                                                                                                                              
x17: 756420676e697375 x16: 202c646e756f6620 x15: 0000000000000000                                                                                                                                                                                                              
x14: 0000000000000000 x13: 20726f66206c6f6f x12: 7020656c62617469                                                                                                                                                                                                              
x11: 656820747563205b x10: 000000000000000a x9 : ffff8000126b3860                                                                                                                                                                                                              
x8 : 000000000000000a x7 : 0000000000000011 x6 : 000000000000000a
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000ffffffff
x2 : ffff800011eb6b30 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 dma_alloc_from_pool+0x88/0x1d0
 dma_direct_alloc+0x8c/0x39c
 dma_alloc_attrs+0x7c/0xe4
 dmam_alloc_attrs+0x68/0xbc
 fec_enet_init+0xfc/0x504
 fec_probe+0x558/0x8b0
 platform_probe+0x64/0x100
 call_driver_probe+0x28/0x130
 really_probe+0xbc/0x390
 __driver_probe_device+0xfc/0x144
 driver_probe_device+0xcc/0x150
 __device_attach_driver+0xd4/0x180
 bus_for_each_drv+0x74/0xc4
 __device_attach+0xd8/0x1e0
 device_initial_probe+0x10/0x20
 bus_probe_device+0x90/0xa0
 deferred_probe_work_func+0x9c/0xf0
 process_one_work+0x1cc/0x360
 worker_thread+0x214/0x3b0
 kthread+0x150/0x160
 ret_from_fork+0x10/0x20
---[ end trace 3934c72dbe137fa9 ]---

 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d0a317ed8f02..50f48e9e4598 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -162,7 +162,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
  */
 static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 {
-	return gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
+	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
