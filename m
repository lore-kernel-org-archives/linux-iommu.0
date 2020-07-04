Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F46C433DF
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 00:10:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DA520747
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 00:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PPtks7KG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DA520747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 21655226FC;
	Sat,  4 Jul 2020 00:10:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UaHJufh-mo6M; Sat,  4 Jul 2020 00:10:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 964EC226B2;
	Sat,  4 Jul 2020 00:10:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70B09C0888;
	Sat,  4 Jul 2020 00:10:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 034CEC0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 00:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E059F89468
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 00:10:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n7y3AYGuS2WS for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 00:10:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CC84A89466
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 00:10:21 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id b4so30140739qkn.11
 for <iommu@lists.linux-foundation.org>; Fri, 03 Jul 2020 17:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=geCQfDki29didolcfuw+TbJJyxx2pc+gBxki4/z7Vnc=;
 b=PPtks7KGO8Sg+XOv3s1BZ+93mrwdmhAgnlQKGF/lQkFwyqYDpaU2nXUlTChsfI7gHq
 PLNqKhAjR9/Lk6GRX2jkxdDzoXerL4AeB4pVbmqWiZHvjauwDE+mZW14PQTqBAXHyMZY
 7BzTrqVuapZLcgF1heG76Ipq48dQ4Uw/6+gB0SoLDhMujo5uIuIN/LmmhxE9pzr5vf3/
 LxAk8gpnyFkQCwl25OTKvABOXLk2wNdZlWZYjYhUdWO3rWS30wV8MJtXoYQmCnJlpu/V
 3YQM/B5tV60xMUqP+1gGQXOtsjFPFTomupFpmah5Z0NCwQPUUbk1dyEcigzmoXb9kZAD
 IS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=geCQfDki29didolcfuw+TbJJyxx2pc+gBxki4/z7Vnc=;
 b=YKsVDEJytBlq/atuCXy7UoOjysidyrryPIDr2hFbwWDCY6VrAgC5SlerGEHvF9udJ+
 ghkqhvzHoxjYcHulPhn2ofTqgiF3eTxuS10DVnPzDmGjSeqWJwY+qJRGbFU0n9xfAjaO
 zwafT8Psj5p/RQ9LtUCopv4UzxDa8VVGRKSQmaP14Ur6ukDxkadsUTtbC6teiYDOUpQS
 /I/bjWE++RJ6Lz+8gjXL1ARi4kdJWlinlRLFiDq2Ee/0gRxdDhYv4bT3dqqcbJPSnZcP
 dgPqIipbDdyusaSJg+KC34CXzl8wpfv65W2cWFDTQueysaXdGBHeE9iz4rckBUvYeICc
 Z5vA==
X-Gm-Message-State: AOAM533vvLgo6FN4EeAQMBErFVkgUqirIEXdmXC5xPV0s0VHnvhr8Eoe
 /QlvetnKW0ul9NVI/g/BIvPWfw==
X-Google-Smtp-Source: ABdhPJzJEbBYJaLAyWsF1V/AYsqHau0FFxq/DO/Sli32yA1wcbU+Xj7NBOXk6JbqH9Dw8aiAMqZO0Q==
X-Received: by 2002:a37:8e42:: with SMTP id q63mr37229131qkd.16.1593821420735; 
 Fri, 03 Jul 2020 17:10:20 -0700 (PDT)
Received: from localhost.localdomain
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id d8sm11817272qkl.118.2020.07.03.17.10.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 03 Jul 2020 17:10:20 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] iommu: fix use-after-free in iommu_release_device
Date: Fri,  3 Jul 2020 20:10:03 -0400
Message-Id: <20200704001003.2303-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, will@kernel.org
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

In pci_disable_sriov(), i.e.,

 # echo 0 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs

iommu_release_device
  iommu_group_remove_device
    arm_smmu_domain_free
      kfree(smmu_domain)

Later,

iommu_release_device
  arm_smmu_release_device
    arm_smmu_detach_dev
      spin_lock_irqsave(&smmu_domain->devices_lock,

would trigger an use-after-free. Fixed it by call
arm_smmu_release_device() first before iommu_group_remove_device().

 BUG: KASAN: use-after-free in __lock_acquire+0x3458/0x4440
  __lock_acquire at kernel/locking/lockdep.c:4250
 Read of size 8 at addr ffff0089df1a6f68 by task bash/3356

 CPU: 5 PID: 3356 Comm: bash Not tainted 5.8.0-rc3-next-20200630 #2
 Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
 Call trace:
  dump_backtrace+0x0/0x398
  show_stack+0x14/0x20
  dump_stack+0x140/0x1b8
  print_address_description.isra.12+0x54/0x4a8
  kasan_report+0x134/0x1b8
  __asan_report_load8_noabort+0x2c/0x50
  __lock_acquire+0x3458/0x4440
  lock_acquire+0x204/0xf10
  _raw_spin_lock_irqsave+0xf8/0x180
  arm_smmu_detach_dev+0xd8/0x4a0
  arm_smmu_detach_dev at drivers/iommu/arm-smmu-v3.c:2776
  arm_smmu_release_device+0xb4/0x1c8
  arm_smmu_disable_pasid at drivers/iommu/arm-smmu-v3.c:2754
  (inlined by) arm_smmu_release_device at drivers/iommu/arm-smmu-v3.c:3000
  iommu_release_device+0xc0/0x178
  iommu_release_device at drivers/iommu/iommu.c:302
  iommu_bus_notifier+0x118/0x160
  notifier_call_chain+0xa4/0x128
  __blocking_notifier_call_chain+0x70/0xa8
  blocking_notifier_call_chain+0x14/0x20
  device_del+0x618/0xa00
  pci_remove_bus_device+0x108/0x2d8
  pci_stop_and_remove_bus_device+0x1c/0x28
  pci_iov_remove_virtfn+0x228/0x368
  sriov_disable+0x8c/0x348
  pci_disable_sriov+0x5c/0x70
  mlx5_core_sriov_configure+0xd8/0x260 [mlx5_core]
  sriov_numvfs_store+0x240/0x318
  dev_attr_store+0x38/0x68
  sysfs_kf_write+0xdc/0x128
  kernfs_fop_write+0x23c/0x448
  __vfs_write+0x54/0xe8
  vfs_write+0x124/0x3f0
  ksys_write+0xe8/0x1b8
  __arm64_sys_write+0x68/0x98
  do_el0_svc+0x124/0x220
  el0_sync_handler+0x260/0x408
  el0_sync+0x140/0x180

 Allocated by task 3356:
  save_stack+0x24/0x50
  __kasan_kmalloc.isra.13+0xc4/0xe0
  kasan_kmalloc+0xc/0x18
  kmem_cache_alloc_trace+0x1ec/0x318
  arm_smmu_domain_alloc+0x54/0x148
  iommu_group_alloc_default_domain+0xc0/0x440
  iommu_probe_device+0x1c0/0x308
  iort_iommu_configure+0x434/0x518
  acpi_dma_configure+0xf0/0x128
  pci_dma_configure+0x114/0x160
  really_probe+0x124/0x6d8
  driver_probe_device+0xc4/0x180
  __device_attach_driver+0x184/0x1e8
  bus_for_each_drv+0x114/0x1a0
  __device_attach+0x19c/0x2a8
  device_attach+0x10/0x18
  pci_bus_add_device+0x70/0xf8
  pci_iov_add_virtfn+0x7b4/0xb40
  sriov_enable+0x5c8/0xc30
  pci_enable_sriov+0x64/0x80
  mlx5_core_sriov_configure+0x58/0x260 [mlx5_core]
  sriov_numvfs_store+0x1c0/0x318
  dev_attr_store+0x38/0x68
  sysfs_kf_write+0xdc/0x128
  kernfs_fop_write+0x23c/0x448
  __vfs_write+0x54/0xe8
  vfs_write+0x124/0x3f0
  ksys_write+0xe8/0x1b8
  __arm64_sys_write+0x68/0x98
  do_el0_svc+0x124/0x220
  el0_sync_handler+0x260/0x408
  el0_sync+0x140/0x180

 Freed by task 3356:
  save_stack+0x24/0x50
  __kasan_slab_free+0x124/0x198
  kasan_slab_free+0x10/0x18
  slab_free_freelist_hook+0x110/0x298
  kfree+0x128/0x668
  arm_smmu_domain_free+0xf4/0x1a0
  iommu_group_release+0xec/0x160
  kobject_put+0xf4/0x238
  kobject_del+0x110/0x190
  kobject_put+0x1e4/0x238
  iommu_group_remove_device+0x394/0x938
  iommu_release_device+0x9c/0x178
  iommu_release_device at drivers/iommu/iommu.c:300
  iommu_bus_notifier+0x118/0x160
  notifier_call_chain+0xa4/0x128
  __blocking_notifier_call_chain+0x70/0xa8
  blocking_notifier_call_chain+0x14/0x20
  device_del+0x618/0xa00
  pci_remove_bus_device+0x108/0x2d8
  pci_stop_and_remove_bus_device+0x1c/0x28
  pci_iov_remove_virtfn+0x228/0x368
  sriov_disable+0x8c/0x348
  pci_disable_sriov+0x5c/0x70
  mlx5_core_sriov_configure+0xd8/0x260 [mlx5_core]
  sriov_numvfs_store+0x240/0x318
  dev_attr_store+0x38/0x68
  sysfs_kf_write+0xdc/0x128
  kernfs_fop_write+0x23c/0x448
  __vfs_write+0x54/0xe8
  vfs_write+0x124/0x3f0
  ksys_write+0xe8/0x1b8
  __arm64_sys_write+0x68/0x98
  do_el0_svc+0x124/0x220
  el0_sync_handler+0x260/0x408
  el0_sync+0x140/0x180

 The buggy address belongs to the object at ffff0089df1a6e00
  which belongs to the cache kmalloc-512 of size 512
 The buggy address is located 360 bytes inside of
  512-byte region [ffff0089df1a6e00, ffff0089df1a7000)
 The buggy address belongs to the page:
 page:ffffffe02257c680 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0089df1a1400
 flags: 0x7ffff800000200(slab)
 raw: 007ffff800000200 ffffffe02246b8c8 ffffffe02257ff88 ffff000000320680
 raw: ffff0089df1a1400 00000000002a000e 00000001ffffffff ffff0089df1a5001
 page dumped because: kasan: bad access detected
 page->mem_cgroup:ffff0089df1a5001

 Memory state around the buggy address:
  ffff0089df1a6e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff0089df1a6e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 >ffff0089df1a6f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                           ^
  ffff0089df1a6f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff0089df1a7000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Fixes: a6a4c7e2c5b8 ("iommu: Add probe_device() and release_device() call-backs")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ed1e14a1f0c..0eeb3251266a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -295,10 +295,10 @@ void iommu_release_device(struct device *dev)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
-	iommu_group_remove_device(dev);
 
 	ops->release_device(dev);
 
+	iommu_group_remove_device(dev);
 	module_put(ops->owner);
 	dev_iommu_free(dev);
 }
-- 
2.21.0 (Apple Git-122.2)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
