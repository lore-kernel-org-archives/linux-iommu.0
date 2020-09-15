Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C5C43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 14:05:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D90122204
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dhWwml11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D90122204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3750985735;
	Tue, 15 Sep 2020 14:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQymAmF2kus7; Tue, 15 Sep 2020 14:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 647A785692;
	Tue, 15 Sep 2020 14:05:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BBCEC0864;
	Tue, 15 Sep 2020 14:05:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60C2AC0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 14:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 456A420461
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 14:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id djK1Q1l7xyip for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 14:05:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by silver.osuosl.org (Postfix) with ESMTPS id C893A2044C
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 14:05:23 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FDsng9156976;
 Tue, 15 Sep 2020 14:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=9c0AXOcTWsVHzDzUN3KwIxGxdoDyDkNUwPGWxuGjmd0=;
 b=dhWwml113FRzQdGqLkIbc6s7Kz1Mskng7mEYQgO5don0ihgl3NFdyy9oZRf7wsgSY+ch
 QyGbau0ZNX4KvbMfybFK2sdblFn/2wj4HrXFL6cW4is5QCpN/U8k97avmL4kJrCgrOVv
 uXsx0Prew9O7aa654VnrEFewzbZcjoz4uHjgSsy4dmQ5w1SzZ1bj/3uFL5f5ju+5R5mI
 5I6tuXuyS/u8z2Rx+vFHQRY/gT1g4OkT+IIdPd0Br72uM62lejCiYpJH8Ygjt+2se70C
 uIdn2Nl2FgTufYrmoBoXCdvDiOILIBpa05NpsEbqey/75GeRtjv9aaEwZsg6SetmXyre rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 33gp9m57nd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2020 14:05:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FDshBU072893;
 Tue, 15 Sep 2020 14:03:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by userp3030.oracle.com with ESMTP id 33h88yb5cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Sep 2020 14:03:15 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FDt460076562;
 Tue, 15 Sep 2020 14:03:15 GMT
Received: from brm-x32-13.us.oracle.com (brm-x32-13.us.oracle.com
 [10.80.150.47]) by userp3030.oracle.com with ESMTP id 33h88yb5c4-1;
 Tue, 15 Sep 2020 14:03:15 +0000
From: Thomas Tai <thomas.tai@oracle.com>
To: konrad.wilk@oracle.com, m.szyprowski@samsung.com, hch@lst.de,
 robin.murphy@arm.com
Subject: [PATCH] dma-direct: Fix potential NULL pointer dereference
Date: Tue, 15 Sep 2020 08:03:14 -0600
Message-Id: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150117
Cc: thomas.tai@oracle.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
printing a warning message in swiotlb_map(). It is because dev->dma_mask
can potentially be a null pointer. Using the dma_get_mask() macro can
avoid the NULL pointer dereference.

Fixes: d323bb44e4d2 ("drm/virtio: Call the right shmem helpers")

[drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on minor 0
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 1 PID: 331 Comm: systemd-udevd Not tainted 5.9.0-rc4 #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
 BIOS 1.13.0-1ubuntu1 04/01/2014
 RIP: 0010:swiotlb_map+0x1ac/0x200
 Code: e8 d9 fc ff ff 80 3d 92 ee 4c 01 00 75 51 49 8b 84 24 48 02 00 00
 4d 8b 6c 24 50 c6 05 7c ee 4c 01 01 4d 8b bc 24 58 02 00 00 <4c> 8b 30
 4d 85 ed 75 04 4d 8b 2c 24 4c 89 e7 e8 10 6b 4f 00 4d 89
 RSP: 0018:ffff9f96801af6f8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000080
 RDX: 000000000000007f RSI: 0000000000000202 RDI: 0000000000000202
 RBP: ffff9f96801af748 R08: ffffffffffffffff R09: 0000000000000020
 R10: 0000000000000000 R11: ffff8fabfffa3000 R12: ffff8faad02c7810
 R13: 0000000000000000 R14: 0000000000000020 R15: 0000000000000000
 FS:  00007fabc63588c0(0000) GS:ffff8fabf7c80000(0000)
 knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000151496005 CR4: 0000000000370ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  dma_direct_map_sg+0x124/0x210
  dma_map_sg_attrs+0x32/0x50
  drm_gem_shmem_get_pages_sgt+0x6a/0x90 [drm]
  virtio_gpu_object_create+0x140/0x2f0 [virtio_gpu]
  ? ww_mutex_unlock+0x26/0x30
  virtio_gpu_mode_dumb_create+0xab/0x160 [virtio_gpu]
  drm_mode_create_dumb+0x82/0x90 [drm]
  drm_client_framebuffer_create+0xaa/0x200 [drm]
  drm_fb_helper_generic_probe+0x59/0x150 [drm_kms_helper]
  drm_fb_helper_single_fb_probe+0x29e/0x3e0 [drm_kms_helper]
  __drm_fb_helper_initial_config_and_unlock+0x41/0xd0 [drm_kms_helper]
  drm_fbdev_client_hotplug+0xe6/0x1a0 [drm_kms_helper]
  drm_fbdev_generic_setup+0xaf/0x170 [drm_kms_helper]
  virtio_gpu_probe+0xea/0x100 [virtio_gpu]
  virtio_dev_probe+0x14b/0x1e0 [virtio]
  really_probe+0x1db/0x440
  driver_probe_device+0xe9/0x160
  device_driver_attach+0x5d/0x70
  __driver_attach+0x8f/0x150
  ? device_driver_attach+0x70/0x70
  bus_for_each_dev+0x7e/0xc0
  driver_attach+0x1e/0x20
  bus_add_driver+0x152/0x1f0
  driver_register+0x74/0xd0
  ? 0xffffffffc0529000
  register_virtio_driver+0x20/0x30 [virtio]
  virtio_gpu_driver_init+0x15/0x1000 [virtio_gpu]
  do_one_initcall+0x4a/0x1fa
  ? _cond_resched+0x19/0x30
  ? kmem_cache_alloc_trace+0x16b/0x2e0
  do_init_module+0x62/0x240
  load_module+0xe0e/0x1100
  ? security_kernel_post_read_file+0x5c/0x70
  __do_sys_finit_module+0xbe/0x120
  ? __do_sys_finit_module+0xbe/0x120
  __x64_sys_finit_module+0x1a/0x20
  do_syscall_64+0x38/0x50
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
---
 include/linux/dma-direct.h | 2 +-
 kernel/dma/swiotlb.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 6e87225..7556067 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -168,7 +168,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 
 		dev_WARN_ONCE(dev, 1,
 			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+			     &dma_addr, size, dma_get_mask(dev), dev->bus_dma_limit);
 		return DMA_MAPPING_ERROR;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fa..aa7727b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -682,7 +682,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		dev_WARN_ONCE(dev, 1,
 			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+			&dma_addr, size, dma_get_mask(dev), dev->bus_dma_limit);
 		return DMA_MAPPING_ERROR;
 	}
 
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
