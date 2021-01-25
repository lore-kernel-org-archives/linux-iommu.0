Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4FEC433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 01:18:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A901522571
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 01:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A901522571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FA40870AC;
	Mon, 25 Jan 2021 01:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Haib8HnhilJZ; Mon, 25 Jan 2021 01:18:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28D5A87036;
	Mon, 25 Jan 2021 01:18:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B5FAC08A1;
	Mon, 25 Jan 2021 01:18:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE9DEC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 01:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A504A86726
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 01:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1VF0gzgKKJJy for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 01:18:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4647866B2
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 01:18:45 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DPBn521Bkzj60N;
 Mon, 25 Jan 2021 09:17:45 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.218) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 09:18:33 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <m.szyprowski@samsung.com>, <hch@lst.de>, <robin.murphy@arm.com>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH RESEND] dma-mapping: benchmark: fix kernel crash when
 dma_map_single fails
Date: Mon, 25 Jan 2021 14:13:06 +1300
Message-ID: <20210125011306.25060-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.202.218]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linuxarm@openeuler.org
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

if dma_map_single() fails, kernel will give the below oops since
task_struct has been destroyed and we are running into the memory
corruption due to use-after-free in kthread_stop():

[   48.095310] Unable to handle kernel paging request at virtual address 000000c473548040
[   48.095736] Mem abort info:
[   48.095864]   ESR = 0x96000004
[   48.096025]   EC = 0x25: DABT (current EL), IL = 32 bits
[   48.096268]   SET = 0, FnV = 0
[   48.096401]   EA = 0, S1PTW = 0
[   48.096538] Data abort info:
[   48.096659]   ISV = 0, ISS = 0x00000004
[   48.096820]   CM = 0, WnR = 0
[   48.097079] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000104639000
[   48.098099] [000000c473548040] pgd=0000000000000000, p4d=0000000000000000
[   48.098832] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   48.099232] Modules linked in:
[   48.099387] CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W
[   48.099887] Hardware name: linux,dummy-virt (DT)
[   48.100078] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   48.100516] pc : __kmalloc_node+0x214/0x368
[   48.100944] lr : __kmalloc_node+0x1f4/0x368
[   48.101458] sp : ffff800011f0bb80
[   48.101843] x29: ffff800011f0bb80 x28: ffff0000c0098ec0
[   48.102330] x27: 0000000000000000 x26: 00000000001d4600
[   48.102648] x25: ffff0000c0098ec0 x24: ffff800011b6a000
[   48.102988] x23: 00000000ffffffff x22: ffff0000c0098ec0
[   48.103333] x21: ffff8000101d7a54 x20: 0000000000000dc0
[   48.103657] x19: ffff0000c0001e00 x18: 0000000000000000
[   48.104069] x17: 0000000000000000 x16: 0000000000000000
[   48.105449] x15: 000001aa0304e7b9 x14: 00000000000003b1
[   48.106401] x13: ffff8000122d5000 x12: ffff80001228d000
[   48.107296] x11: ffff0000c0154340 x10: 0000000000000000
[   48.107862] x9 : ffff80000fffffff x8 : ffff0000c473527f
[   48.108326] x7 : ffff800011e62f58 x6 : ffff0000c01c8ed8
[   48.108778] x5 : ffff0000c0098ec0 x4 : 0000000000000000
[   48.109223] x3 : 00000000001d4600 x2 : 0000000000000040
[   48.109656] x1 : 0000000000000001 x0 : ff0000c473548000
[   48.110104] Call trace:
[   48.110287]  __kmalloc_node+0x214/0x368
[   48.110493]  __vmalloc_node_range+0xc4/0x298
[   48.110805]  copy_process+0x2c8/0x15c8
[   48.111133]  kernel_clone+0x5c/0x3c0
[   48.111373]  kernel_thread+0x64/0x90
[   48.111604]  kthreadd+0x158/0x368
[   48.111810]  ret_from_fork+0x10/0x30
[   48.112336] Code: 17ffffe9 b9402a62 b94008a1 11000421 (f8626802)
[   48.112884] ---[ end trace d4890e21e75419d5 ]---

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/dma/map_benchmark.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index b1496e744c68..1b1b8ff875cb 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -147,8 +147,10 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	atomic64_set(&map->sum_sq_unmap, 0);
 	atomic64_set(&map->loops, 0);
 
-	for (i = 0; i < threads; i++)
+	for (i = 0; i < threads; i++) {
+		get_task_struct(tsk[i]);
 		wake_up_process(tsk[i]);
+	}
 
 	msleep_interruptible(map->bparam.seconds * 1000);
 
@@ -183,6 +185,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	}
 
 out:
+	for (i = 0; i < threads; i++)
+		put_task_struct(tsk[i]);
 	put_device(map->dev);
 	kfree(tsk);
 	return ret;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
