Return-Path: <SRS0=JlXp=XZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF5C32792
	for <iommu@archiver.kernel.org>; Mon, 30 Sep 2019 14:36:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A08421855
	for <iommu@archiver.kernel.org>; Mon, 30 Sep 2019 14:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A08421855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 255E0199E;
	Mon, 30 Sep 2019 14:36:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 641E8199D
	for <iommu@lists.linux-foundation.org>;
	Mon, 30 Sep 2019 14:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B6877735
	for <iommu@lists.linux-foundation.org>;
	Mon, 30 Sep 2019 14:36:55 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 4FC4CFE66C605F3E5AC5;
	Mon, 30 Sep 2019 22:36:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
	DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server
	id 14.3.439.0; Mon, 30 Sep 2019 22:36:46 +0800
From: John Garry <john.garry@huawei.com>
To: <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
	<sudeep.holla@arm.com>, <robin.murphy@arm.com>, <mark.rutland@arm.com>, 
	<will@kernel.org>
Subject: [RFC PATCH 0/6] SMMUv3 PMCG IMP DEF event support
Date: Mon, 30 Sep 2019 22:33:45 +0800
Message-ID: <1569854031-237636-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Cc: nleeder@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

This patchset adds IMP DEF event support for the SMMUv3 PMCG.

It is marked as an RFC as the method to identify the PMCG implementation
may be a quite disliked. And, in general, the series is somewhat
incomplete.

So the background is that the PMCG supports IMP DEF events, yet we have no
method to identify the PMCG to know the IMP DEF events.

A method for identifying the PMCG implementation could be using
PMDEVARCH, but we cannot rely on this being set properly, as whether this
is implemented is not defined in SMMUv3 spec.

Another method would be perf event aliasing, but this method of event
matching is based on CPU id, which would not guarantee same
uniqueness as PMCG implementation.

Yet another method could be to continue using ACPI OEM ID in the IORT
code, but this does not scale. And it is not suitable if we ever add DT
support to the PMCG driver.

The method used in this series is based on matching on the parent SMMUv3
IIDR. We store this IIDR contents in the arm smmu structure as the first
element, which means that we don't have to expose SMMU APIs - this is
the part which may be disliked.

The final two patches switch the pre-existing PMCG model identification
from ACPI OEM ID to the same parent SMMUv3 IIDR matching.

For now, we only consider SMMUv3' nodes being the associated node for
PMCG.

John Garry (6):
  ACPI/IORT: Set PMCG device parent
  iommu/arm-smmu-v3: Record IIDR in arm_smmu_device structure
  perf/smmuv3: Retrieve parent SMMUv3 IIDR
  perf/smmuv3: Support HiSilicon hip08 (hi1620) IMP DEF events
  perf/smmuv3: Match implementation options based on parent SMMU IIDR
  ACPI/IORT: Drop code to set the PMCG software-defined model

 drivers/acpi/arm64/iort.c     | 69 ++++++++++++++--------------
 drivers/iommu/arm-smmu-v3.c   |  5 +++
 drivers/perf/arm_smmuv3_pmu.c | 84 ++++++++++++++++++++++++++++++-----
 include/linux/acpi_iort.h     |  8 ----
 4 files changed, 112 insertions(+), 54 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
