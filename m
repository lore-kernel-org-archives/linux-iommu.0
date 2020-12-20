Return-Path: <SRS0=TI1w=FX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAFFC4361B
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 00:04:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513CA20780
	for <iommu@archiver.kernel.org>; Sat, 19 Dec 2020 00:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513CA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33E6C86A78;
	Sat, 19 Dec 2020 00:04:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zjMpyNOSPZCd; Sat, 19 Dec 2020 00:04:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 23B2586E53;
	Sat, 19 Dec 2020 00:04:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18E89C1786;
	Sat, 19 Dec 2020 00:04:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8CF0C0893
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCFD286D16
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HIFAu52yeZZt for <iommu@lists.linux-foundation.org>;
 Sat, 19 Dec 2020 00:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C217686A78
 for <iommu@lists.linux-foundation.org>; Sat, 19 Dec 2020 00:04:25 +0000 (UTC)
IronPort-SDR: P6KMthTtilAYjWwut1D7kleTlsSpyFKpXdfDLT4YJa5f624ElZZ0pcsVMS7DIzG1G95iS2hsYZ
 S2i8x5FFZ1gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="154749393"
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; d="scan'208";a="154749393"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2020 16:04:04 -0800
IronPort-SDR: P+HOox3oMxnO9UWzXrKj3nclKglWiBI6/+X34r0krAFwDo1AR8h2xVISafVlVfGNNwX8is5PZF
 B5krmhsgt4fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,431,1599548400"; d="scan'208";a="340800914"
Received: from yiliu-dev.bj.intel.com (HELO iov-dev.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Dec 2020 16:04:00 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: baolu.lu@linux.intel.com, jacob.jun.pan@intel.com, xin.zeng@intel.com,
 Kaijie.Guo@intel.com, will@kernel.org, joro@8bytes.org
Subject: [PATCH 0/4] iommu/vtd-: Misc fixes on scalable mode
Date: Sun, 20 Dec 2020 08:03:49 +0800
Message-Id: <20201220000352.183523-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, ashok.raj@intel.com
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

This patchset aims to fix a bug regards to SVM usage on native, and
also several bugs around subdevice (attached to device via auxiliary
manner) tracking and ineffective device_tlb flush.

Regards,
Yi Liu

Liu Yi L (3):
  iommu/vt-d: Move intel_iommu info from struct intel_svm to struct
    intel_svm_dev
  iommu/vt-d: Track device aux-attach with subdevice_domain_info.
  iommu/vt-d: A fix to iommu_flush_dev_iotlb() for aux-domain

 drivers/iommu/intel/iommu.c | 182 ++++++++++++++++++++++++++++++------
 drivers/iommu/intel/svm.c   |   9 +-
 include/linux/intel-iommu.h |  13 ++-
 3 files changed, 168 insertions(+), 36 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
