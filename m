Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113B6C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 14:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B404983F6F;
	Fri, 22 Apr 2022 14:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5-pwRPaNZNp; Fri, 22 Apr 2022 14:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9EF4181B01;
	Fri, 22 Apr 2022 14:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD55C007E;
	Fri, 22 Apr 2022 14:40:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5D1EC002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 480F881DCB
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZYx-VgyRwaw for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 06:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 859E1823A0
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 06:24:46 +0000 (UTC)
X-UUID: 244b248a9c8143ab9665a120b063d961-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:5a2b6a49-19dd-4942-a433-db80654a85d7, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:faefae9, CLOUDID:7239beef-06b0-4305-bfbf-554bfc9d151a,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 244b248a9c8143ab9665a120b063d961-20220422
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <mark-pk.tsai@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 612951047; Fri, 22 Apr 2022 14:24:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Fri, 22 Apr 2022 14:24:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Fri, 22 Apr 2022 14:24:39 +0800
To: <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
 <robin.murphy@arm.com>
Subject: [PATCH 0/2] dma-mapping,
 remoteproc: Fix dma_mem leak after rproc_shutdown
Date: Fri, 22 Apr 2022 14:24:34 +0800
Message-ID: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Mark-PK Tsai (2):
  dma-mapping: Add dma_release_coherent_memory to DMA API
  remoteproc: Fix dma_mem leak after rproc_shutdown

 drivers/remoteproc/remoteproc_core.c |  1 +
 include/linux/dma-map-ops.h          |  3 +++
 kernel/dma/coherent.c                | 10 ++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
