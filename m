Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57D5C4321A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B3720896
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B3720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 87B28D4B;
	Tue, 11 Jun 2019 13:46:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 09BB9D3E
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 489716D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 13:46:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E44344;
	Tue, 11 Jun 2019 06:46:09 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 289C03F557; 
	Tue, 11 Jun 2019 06:46:08 -0700 (PDT)
From: Will Deacon <will.deacon@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC CFT 0/6] Try to reduce lock contention on the SMMUv3 command
	queue
Date: Tue, 11 Jun 2019 14:45:57 +0100
Message-Id: <20190611134603.4253-1-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi all,

This patch series is an attempt to reduce lock contention when inserting
commands into the Arm SMMUv3 command queue. Unfortunately, our initial
benchmarking has shown mixed results across the board and the changes in
the last patch don't appear to justify their complexity. Based on that,
I only plan to queue the first patch for the time being.

Anyway, before I park this series, I thought it was probably worth
sharing it in case it's useful to somebody. If you have a system where
you believe I/O performance to be limited by the SMMUv3 command queue
then please try these patches and let me know what happens, even if it's
just more bad news.

Patches based on 5.2-rc3. I've also pushed them out to my iommu/devel
branch for the moment:

  https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/devel

Thanks,

Will

--->8

Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Cc: Jan Glauber <jglauber@marvell.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Vijay Kilary <vkilari@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>

Will Deacon (6):
  iommu/arm-smmu-v3: Increase maximum size of queues
  iommu/arm-smmu-v3: Separate s/w and h/w views of prod and cons indexes
  iommu/arm-smmu-v3: Drop unused 'q' argument from Q_OVF macro
  iommu/arm-smmu-v3: Move low-level queue fields out of arm_smmu_queue
  iommu/arm-smmu-v3: Operate directly on low-level queue where possible
  iommu/arm-smmu-v3: Reduce contention during command-queue insertion

 drivers/iommu/arm-smmu-v3.c | 725 ++++++++++++++++++++++++++++++++------------
 1 file changed, 534 insertions(+), 191 deletions(-)

-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
