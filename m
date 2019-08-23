Return-Path: <SRS0=APMu=WT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF50C3A5A1
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 02:47:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B49D233A0
	for <iommu@archiver.kernel.org>; Fri, 23 Aug 2019 02:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B49D233A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1197012D8;
	Fri, 23 Aug 2019 02:47:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 79C07D85
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 02:46:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE2748A2
	for <iommu@lists.linux-foundation.org>;
	Fri, 23 Aug 2019 02:46:57 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 19377A30A9AEE019E02A;
	Fri, 23 Aug 2019 10:46:55 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
	DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server
	id 14.3.439.0; Fri, 23 Aug 2019 10:46:47 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, John Garry
	<john.garry@huawei.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will@kernel.org>, Joerg Roedel <joro@8bytes.org>, iommu
	<iommu@lists.linux-foundation.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/2] improve the concurrency of arm_smmu_atc_inv_domain()
Date: Fri, 23 Aug 2019 10:45:49 +0800
Message-ID: <20190823024551.24448-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

v2 --> v3:
As Will Deacon's suggestion, I changed the lock type of
arm_smmu_domain.devices_lock from spinlock_t to rwlock_t, and I saw that the
performance is all right. And further use nr_ats_masters to quickly check have
no obvious effect, so I drop it.

Here is the performance data tested on my board:
Withou any change:
Jobs: 24 (f=24): [0.1% done] [9798M/0K /s] [2392K/0  iops] [09h:59m:13s]
Jobs: 24 (f=24): [0.1% done] [9782M/0K /s] [2388K/0  iops] [09h:59m:12s]
Jobs: 24 (f=24): [0.2% done] [9825M/0K /s] [2399K/0  iops] [09h:59m:11s]
Jobs: 24 (f=24): [0.2% done] [9836M/0K /s] [2401K/0  iops] [09h:59m:10s]

Change lock type from spinlock_t to rwlock_t:
Jobs: 24 (f=24): [0.1% done] [10996M/0K /s] [2685K/0  iops] [09h:59m:13s]
Jobs: 24 (f=24): [0.1% done] [10817M/0K /s] [2641K/0  iops] [09h:59m:12s]
Jobs: 24 (f=24): [0.2% done] [11083M/0K /s] [2706K/0  iops] [09h:59m:11s]
Jobs: 24 (f=24): [0.2% done] [10603M/0K /s] [2589K/0  iops] [09h:59m:10s]

Use nr_ats_masters:
Jobs: 24 (f=24): [0.2% done] [11105M/0K /s] [2711K/0  iops] [eta 09h:58m:40s]
Jobs: 24 (f=24): [0.2% done] [10511M/0K /s] [2566K/0  iops] [eta 09h:58m:39s]
Jobs: 24 (f=24): [0.2% done] [10560M/0K /s] [2578K/0  iops] [eta 09h:58m:38s]
Jobs: 24 (f=24): [0.2% done] [10494M/0K /s] [2562K/0  iops] [eta 09h:58m:37s]
Jobs: 24 (f=24): [0.2% done] [10528M/0K /s] [2570K/0  iops] [eta 09h:58m:36s]
Jobs: 24 (f=24): [0.3% done] [10638M/0K /s] [2597K/0  iops] [eta 09h:58m:35s]
Jobs: 24 (f=24): [0.3% done] [11158M/0K /s] [2724K/0  iops] [eta 09h:58m:34s]
Jobs: 24 (f=24): [0.3% done] [11386M/0K /s] [2780K/0  iops] [eta 09h:58m:32s]
Jobs: 24 (f=24): [0.3% done] [11118M/0K /s] [2714K/0  iops] [eta 09h:58m:32s]
Jobs: 24 (f=24): [0.3% done] [11031M/0K /s] [2693K/0  iops] [eta 09h:58m:31s]
Jobs: 24 (f=24): [0.3% done] [11361M/0K /s] [2774K/0  iops] [eta 09h:58m:30s]

v1 --> v2:
1. change the type of nr_ats_masters from atomic_t to int, and move its
   ind/dec operation from arm_smmu_enable_ats()/arm_smmu_disable_ats() to
   arm_smmu_attach_dev()/arm_smmu_detach_dev(), and protected by
   "spin_lock_irqsave(&smmu_domain->devices_lock, flags);"

Zhen Lei (2):
  iommu/arm-smmu-v3: don't add a master into smmu_domain before it's
    ready
  iommu/arm-smmu-v3: change the lock type of
    arm_smmu_domain.devices_lock

 drivers/iommu/arm-smmu-v3.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
