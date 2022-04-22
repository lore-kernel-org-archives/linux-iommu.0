Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F7DC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 14:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55D8F60A97;
	Fri, 22 Apr 2022 14:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6dKTFjnjmJq; Fri, 22 Apr 2022 14:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B73F61011;
	Fri, 22 Apr 2022 14:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65AA7C0086;
	Fri, 22 Apr 2022 14:40:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7F8EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3C0D823A0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GswW1cPCM6pv for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 06:24:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E75C823CB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:47 +0000 (UTC)
X-UUID: a4a683bd9aa74ce3a19a7f8c23b5e5aa-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:68f808bf-3bef-4ea0-9bfb-0fdfdaef7935, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,A
 CTION:release,TS:34
X-CID-INFO: VERSION:1.1.4, REQID:68f808bf-3bef-4ea0-9bfb-0fdfdaef7935, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:34
X-CID-META: VersionHash:faefae9, CLOUDID:f82f94f0-da02-41b4-b6df-58f4ccd36682,
 C
 OID:ff4a062f609c,Recheck:0,SF:13|15|28|100|17|19|48|101,TC:nil,Content:1,E
 DM:-3,File:nil,QS:0,BEC:nil
X-UUID: a4a683bd9aa74ce3a19a7f8c23b5e5aa-20220422
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <mark-pk.tsai@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2090162785; Fri, 22 Apr 2022 14:24:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 14:24:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Fri, 22 Apr 2022 14:24:41 +0800
To: <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
 <robin.murphy@arm.com>
Subject: [PATCH 2/2] remoteproc: Fix dma_mem leak after rproc_shutdown
Date: Fri, 22 Apr 2022 14:24:36 +0800
Message-ID: <20220422062436.14384-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Fri, 22 Apr 2022 14:40:41 +0000
Cc: yj.chiang@mediatek.com, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, mark-pk.tsai@mediatek.com,
 matthias.bgg@gmail.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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
From: Mark-PK Tsai via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Release dma coherent memory before rvdev is free in
rproc_rvdev_release().

Below is the kmemleak report:
unreferenced object 0xffffff8051c1a980 (size 128):
  comm "sh", pid 4895, jiffies 4295026604 (age 15481.896s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003a0f3ec0>] dma_declare_coherent_memory+0x44/0x11c
    [<00000000ad243164>] rproc_add_virtio_dev+0xb8/0x20c
    [<00000000d219c8e9>] rproc_vdev_do_start+0x18/0x24
    [<00000000e694b468>] rproc_start+0x22c/0x3e0
    [<000000000b938941>] rproc_boot+0x4a4/0x860
    [<000000003c4dc532>] state_store.52856+0x10c/0x1b8
    [<00000000df2297ac>] dev_attr_store+0x34/0x84
    [<0000000083a53bdb>] sysfs_kf_write+0x60/0xbc
    [<000000008ed830df>] kernfs_fop_write+0x198/0x458
    [<0000000072b9ad06>] __vfs_write+0x50/0x210
    [<00000000377d7469>] vfs_write+0xe4/0x1a8
    [<00000000c3fc594e>] ksys_write+0x78/0x144
    [<000000009aef6f4b>] __arm64_sys_write+0x1c/0x28
    [<0000000003496a98>] el0_svc_common+0xc8/0x22c
    [<00000000ea3fe7a3>] el0_svc_compat_handler+0x1c/0x28
    [<00000000d1a85a4e>] el0_svc_compat+0x8/0x24

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/remoteproc/remoteproc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c510125769b9..8e28290eefa9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -461,6 +461,7 @@ static void rproc_rvdev_release(struct device *dev)
 	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
 
 	of_reserved_mem_device_release(dev);
+	dma_release_coherent_memory(dev);
 
 	kfree(rvdev);
 }
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
