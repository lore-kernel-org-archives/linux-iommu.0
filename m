Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0BBC433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 07:50:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD40723120
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 07:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD40723120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 40121868D6;
	Thu,  7 Jan 2021 07:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CU9FQCRbahM; Thu,  7 Jan 2021 07:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B8BD8672B;
	Thu,  7 Jan 2021 07:50:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDA5C0891;
	Thu,  7 Jan 2021 07:50:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C5DFC013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 07:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2735D204CA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 07:50:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q0x5k3hsX5MQ for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 07:50:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id D604E204B7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 07:50:18 +0000 (UTC)
IronPort-SDR: ma68p0iumKZDkNe/Nd2AwGbkwOUJio0mm/lLollyD0IZ8vSdeb8yydPaNvngZSjpzYjx4AxnlF
 MMofYmV8jvDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="195945017"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; d="scan'208";a="195945017"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jan 2021 23:50:18 -0800
IronPort-SDR: 9YdZFIBcPf8U4ESpvdlwqFf73EDaS3lYkTKtl77/RxxXueoBQdik4LGfqBIvnbSHTrGj4EoBQb
 pzIepB77KerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; d="scan'208";a="351169562"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev2.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 06 Jan 2021 23:50:15 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v4 0/3] iommu/vt-d: Misc fixes on scalable mode
Date: Thu,  7 Jan 2021 00:03:54 +0800
Message-Id: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: kevin.tian@intel.com, ashok.raj@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, dan.carpenter@oracle.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Baolu, Joerg, Will,

This patchset aims to fix a bug regards to native SVM usage, and
also two bugs around subdevice (attached to device via auxiliary
manner) tracking and ineffective device_tlb flush.

v3 -> v4:
- Address comments from Baolu Lu and add acked-by
- Fix issue reported by "Dan Carpenter" and "kernel test robot"
- Add tested-by from Guo Kaijie on patch 1/3
- Rebase to 5.11-rc2
v3: https://lore.kernel.org/linux-iommu/20201229032513.486395-1-yi.l.liu@intel.com/

v2 -> v3:
- Address comments from Baolu Lu against v2
- Rebased to 5.11-rc1
v2: https://lore.kernel.org/linux-iommu/20201223062720.29364-1-yi.l.liu@intel.com/

v1 -> v2:
- Use a more recent Fix tag in "iommu/vt-d: Move intel_iommu info from struct intel_svm to struct intel_svm_dev"
- Refined the "iommu/vt-d: Track device aux-attach with subdevice_domain_info"
- Rename "iommu/vt-d: A fix to iommu_flush_dev_iotlb() for aux-domain" to be
  "iommu/vt-d: Fix ineffective devTLB invalidation for subdevices"
- Refined the commit messages
v1: https://lore.kernel.org/linux-iommu/20201220000352.183523-1-yi.l.liu@intel.com/

Regards,
Yi Liu

Liu Yi L (3):
  iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
    intel_svm_dev
  iommu/vt-d: Track device aux-attach with subdevice_domain_info
  iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

 drivers/iommu/intel/iommu.c | 148 ++++++++++++++++++++++++++++++++------------
 drivers/iommu/intel/svm.c   |   9 +--
 include/linux/intel-iommu.h |  18 ++++--
 3 files changed, 125 insertions(+), 50 deletions(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
