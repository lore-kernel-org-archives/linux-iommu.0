Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34658C31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 05:45:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12390208C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 05:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12390208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFB21B6C;
	Thu, 15 Aug 2019 05:45:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E7D788B1
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 05:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 787758AC
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 05:45:31 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id DCF73649FA0FCEA333F3;
	Thu, 15 Aug 2019 13:45:10 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
	DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server
	id 14.3.439.0; Thu, 15 Aug 2019 13:45:03 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Jean-Philippe
	Brucker" <jean-philippe@linaro.org>, John Garry <john.garry@huawei.com>,
	"Robin Murphy" <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Joerg
	Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] add nr_ats_masters for quickly check
Date: Thu, 15 Aug 2019 13:44:37 +0800
Message-ID: <20190815054439.30652-1-thunder.leizhen@huawei.com>
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

v1 --> v2:
1. change the type of nr_ats_masters from atomic_t to int, and move its
   ind/dec operation from arm_smmu_enable_ats()/arm_smmu_disable_ats() to
   arm_smmu_attach_dev()/arm_smmu_detach_dev(), and protected by
   "spin_lock_irqsave(&smmu_domain->devices_lock, flags);"

Zhen Lei (2):
  iommu/arm-smmu-v3: don't add a master into smmu_domain before it's
    ready
  iommu/arm-smmu-v3: add nr_ats_masters for quickly check

 drivers/iommu/arm-smmu-v3.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
