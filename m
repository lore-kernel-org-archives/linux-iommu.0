Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76659C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BB76136E
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BB76136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 960A260704;
	Tue,  1 Jun 2021 14:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ky4btGjvLTBl; Tue,  1 Jun 2021 14:34:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8200F606C9;
	Tue,  1 Jun 2021 14:34:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B98FC000D;
	Tue,  1 Jun 2021 14:34:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09C0AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05B4760758
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SsEtZoEH6Gvo for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 14:34:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97991606C9
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:12 +0000 (UTC)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZ976ssJz6M4NR;
 Tue,  1 Jun 2021 22:21:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:06 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
Date: Tue, 1 Jun 2021 22:29:34 +0800
Message-ID: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
exceeds the IOVA rcache upper limit (meaning that they are not cached),
performance can be reduced. 

This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
from last rb tree node if iova search fails"), as discussed at [0].

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

Some figures for storage scenario (when increasing IOVA rcache range to
cover all DMA mapping sizes from the LLD):
v5.13-rc1 baseline:			1200K IOPS
With series:				1800K IOPS

All above are for IOMMU strict mode. Non-strict mode gives ~1800K IOPS in
all scenarios.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/1607538189-237944-1-git-send-email-john.garry@huawei.com/

Differences to v2:
- Drop DMA mapping API to allow LLD set set for now
- Update default domain immediately, instead of in reprobe
- Fix build warning

Differences to v1:
- Many
- Change method to not operate on a 'live' IOMMU domain:
	- rather, force device driver to be re-probed once
	  dma_max_opt_size is set, and reconfig a new IOMMU group then
- Add iommu sysfs max_dma_opt_size file, and allow updating same as how
  group type is changed 

John Garry (7):
  iommu: Reactor iommu_group_store_type()
  iova: Allow rcache range upper limit to be flexible
  iommu: Allow iommu_change_dev_def_domain() realloc default domain for
    same type
  iova: Add iova_domain_len_is_cached()
  iova: Add init_iova_domain_ext()
  iommu: Allow max opt DMA len be set for a group via sysfs
  dma-iommu: Use init_iova_domain_ext() for IOVA domain init

 drivers/iommu/dma-iommu.c |  17 +++-
 drivers/iommu/iommu.c     | 172 ++++++++++++++++++++++++++------------
 drivers/iommu/iova.c      |  63 +++++++++++---
 include/linux/iommu.h     |   6 ++
 include/linux/iova.h      |  21 ++++-
 5 files changed, 210 insertions(+), 69 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
