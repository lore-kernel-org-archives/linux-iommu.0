Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B2DC433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:33:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475342075E
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475342075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 018DC867ED;
	Wed, 27 Jan 2021 11:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 343SVZGfhmVM; Wed, 27 Jan 2021 11:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A66088650E;
	Wed, 27 Jan 2021 11:33:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F08BC013A;
	Wed, 27 Jan 2021 11:33:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB625C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A77C387103
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id atBjjgWELVEO for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 11:33:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id ED6B3870CE
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:33:33 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DQhK72fH0z7bnb;
 Wed, 27 Jan 2021 19:32:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 19:33:13 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] perf/smmuv3: Don't reserve the PMCG register spaces
Date: Wed, 27 Jan 2021 19:32:55 +0800
Message-ID: <20210127113258.1421-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

v2 --> v3:
Patch 3 is updated because https://lkml.org/lkml/2021/1/22/532 has been queued in advance.

v1 --> v2:
According to Robin Murphy's suggestion: https://lkml.org/lkml/2021/1/20/470
Don't reserve the PMCG register spaces, and reserve the entire SMMU register space.

v1:
Since the PMCG may implement its resigters space(4KB Page0 and 4KB Page1)
within the SMMUv3 64KB Page0. In this case, when the SMMUv3 driver reserves the
64KB Page0 resource in advance, the PMCG driver try to reserve its Page0 and
Page1 resources, a resource conflict occurs.

commit 52f3fab0067d6fa ("iommu/arm-smmu-v3: Don't reserve implementation
defined register space") reduce the resource reservation range of the SMMUv3
driver, it only reserves the first 0xe00 bytes in the 64KB Page0, to avoid
the above-mentioned resource conflicts.

But the SMMUv3.3 add support for ECMDQ, its registers space is also implemented
in the SMMUv3 64KB Page0. This means we need to build two separate mappings.
New features may be added in the future, and more independent mappings may be
required. The simple problem is complicated because the user expects to map the
entire SMMUv3 64KB Page0.

Therefore, the proper solution is: If the PMCG register resources are located in
the 64KB Page0 of the SMMU, the PMCG driver does not reserve the conflict resources
when the SMMUv3 driver has reserved the conflict resources before. Instead, the PMCG
driver only performs devm_ioremap() to ensure that it can work properly.

Zhen Lei (3):
  perf/smmuv3: Don't reserve the PMCG register spaces
  perf/smmuv3: Add a MODULE_SOFTDEP() to indicate dependency on SMMU
  iommu/arm-smmu-v3: Reserving the entire SMMU register space

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++--------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
 drivers/perf/arm_smmuv3_pmu.c               | 28 ++++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 24 deletions(-)

-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
