Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FEDC433E0
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 04:44:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399092312A
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 04:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399092312A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDAC386A4C;
	Thu,  7 Jan 2021 04:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hwaN8JZtn6K; Thu,  7 Jan 2021 04:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 64C638692E;
	Thu,  7 Jan 2021 04:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 427B3C1DA9;
	Thu,  7 Jan 2021 04:44:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E65B9C0891
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 04:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C957320462
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 04:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dp0hbSfeBIYh for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 04:44:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 763BF203AA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 04:44:37 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBDC84vtmzj2Xl;
 Thu,  7 Jan 2021 12:43:48 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 7 Jan 2021 12:44:25 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, <kvm@vger.kernel.org>,
 <kvmarm@lists.cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Will Deacon <will@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 0/6] vfio/iommu_type1: Some optimizations about dirty tracking
Date: Thu, 7 Jan 2021 12:43:55 +0800
Message-ID: <20210107044401.19828-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Alexios Zavras <alexios.zavras@intel.com>,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Julien Thierry <julien.thierry.kdev@gmail.com>
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

Hi,

In patch series[1], I put forward some fixes and optimizations for
vfio_iommu_type1. This extracts and improves the optimization part
of it.

[1] https://lore.kernel.org/linux-iommu/20201210073425.25960-1-zhukeqian1@huawei.com/T/#t

Thanks,
Keqian


Keqian Zhu (6):
  vfio/iommu_type1: Make an explicit "promote" semantic
  vfio/iommu_type1: Ignore external domain when promote pinned_scope
  vfio/iommu_type1: Initially set the pinned_page_dirty_scope
  vfio/iommu_type1: Drop parameter "pgsize" of vfio_dma_bitmap_alloc_all
  vfio/iommu_type1: Drop parameter "pgsize" of vfio_iova_dirty_bitmap
  vfio/iommu_type1: Drop parameter "pgsize" of update_user_bitmap

 drivers/vfio/vfio_iommu_type1.c | 67 +++++++++++++--------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
