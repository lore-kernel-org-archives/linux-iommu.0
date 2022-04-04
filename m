Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B283C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 11:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3E75400F4;
	Mon,  4 Apr 2022 11:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dS2hZ91OkCtn; Mon,  4 Apr 2022 11:33:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2529F4003C;
	Mon,  4 Apr 2022 11:33:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE214C002C;
	Mon,  4 Apr 2022 11:33:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2F7C0012;
 Mon,  4 Apr 2022 11:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30F0840339;
 Mon,  4 Apr 2022 11:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g_ponnMTYTdi; Mon,  4 Apr 2022 11:33:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8626A401F2;
 Mon,  4 Apr 2022 11:33:02 +0000 (UTC)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX7rM1QGyz67Lnh;
 Mon,  4 Apr 2022 19:30:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:32:58 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 12:32:55 +0100
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH RESEND v5 0/5] iommu: Allow IOVA rcache range be configured
Date: Mon, 4 Apr 2022 19:27:09 +0800
Message-ID: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, jasowang@redhat.com, mst@redhat.com,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
exceeds the IOVA rcache upper limit (meaning that they are not cached),
performance can be reduced. 

This may be much more pronounced from commit 4e89dce72521 ("iommu/iova:
Retry from last rb tree node if iova search fails"), as discussed at [0].

IOVAs which cannot be cached are highly involved in the IOVA ageing issue,
as discussed at [1].

This series allows the IOVA rcache range be configured, so that we may
cache all IOVAs per domain, thus improving performance.

A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
indirectly to configure the IOVA rcache range:
/sys/kernel/iommu_groups/X/max_opt_dma_size

This file is updated same as how the IOMMU group default domain type is
updated, i.e. must unbind the only device in the group first.

The inspiration here comes from block layer request queue sysfs
"optimal_io_size" file, in /sys/block/sdX/queue/optimal_io_size

Some old figures* for storage scenario (when increasing IOVA rcache range
to cover all DMA mapping sizes from the LLD):
v5.13-rc1 baseline:			1200K IOPS
With series:				1800K IOPS

All above are for IOMMU strict mode. Non-strict mode gives ~1800K IOPS in
all scenarios.

Based on v5.18-rc1
* I lost my high data throughout test setup

Differences to v4:
https://lore.kernel.org/linux-iommu/1626259003-201303-1-git-send-email-john.garry@huawei.com/
- Major rebase
- Change the "Refactor iommu_group_store_type()" to not use a callback
  and an op type enum instead
  - I didn't pick up Will's Ack as it has changed so much
- Use a domain feature flag to keep same default group type
- Add wrapper for default IOVA rcache range
- Combine last 2x patches

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/1607538189-237944-1-git-send-email-john.garry@huawei.com/

John Garry (5):
  iommu: Refactor iommu_group_store_type()
  iova: Allow rcache range upper limit to be flexible
  iommu: Allow iommu_change_dev_def_domain() realloc same default domain
    type
  iommu: Allow max opt DMA len be set for a group via sysfs
  iova: Add iova_len argument to iova_domain_init_rcaches()

 .../ABI/testing/sysfs-kernel-iommu_groups     |  16 ++
 drivers/iommu/dma-iommu.c                     |  15 +-
 drivers/iommu/iommu.c                         | 202 +++++++++++++-----
 drivers/iommu/iova.c                          |  37 ++--
 drivers/vdpa/vdpa_user/iova_domain.c          |   4 +-
 include/linux/iommu.h                         |   7 +
 include/linux/iova.h                          |   6 +-
 7 files changed, 212 insertions(+), 75 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
