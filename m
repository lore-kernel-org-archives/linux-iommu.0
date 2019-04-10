Return-Path: <SRS0=ghiB=SM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE9CC10F11
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 15:16:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C8C20820
	for <iommu@archiver.kernel.org>; Wed, 10 Apr 2019 15:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C8C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E800A1A4A;
	Wed, 10 Apr 2019 15:16:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E7D941A45
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 15:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9DD84851
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Apr 2019 15:16:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DDED374;
	Wed, 10 Apr 2019 08:16:09 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com
	[10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4E433F59C; 
	Wed, 10 Apr 2019 08:16:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: joro@8bytes.org
Subject: [PATCH v3 0/1] IOMMU SVA device driver interface
Date: Wed, 10 Apr 2019 16:15:15 +0100
Message-Id: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, zhangfei.gao@foxmail.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	christian.koenig@amd.com
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190410151515.uMOxgnF8S-qIguMMC7N_D4l-K_jiTkJ3omvcwIfZfms@z>

This is the device driver API for SVA (Shared Virtual Addressing).
Since v2 I removed the set_sva_ops() IOMMU operation as suggested by
Joerg, instead doing the sva_ops assignment in iommu.c.

The four dev_feature functions are implemented by Lu Baolu's IOMMU-aware
mdev series [2].

	iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_SVA) -> true/false
	iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
	iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_SVA) -> true/false

Patch 1/1 adds the next four functions, once the SVA feature is enabled:

	iommu_sva_bind(dev, mm, drvdata) -> handle
	iommu_sva_set_ops(handle, iommu_sva_ops) -> 0/err
	iommu_sva_get_pasid(handle) -> pasid/invalid
	iommu_sva_unbind(handle)

Generic implementation and SMMUv3 support can be found at [3].

[1] https://lore.kernel.org/lkml/20190320150258.3240-1-jean-philippe.brucker@arm.com/
[2] https://lore.kernel.org/lkml/20190325013036.18400-1-baolu.lu@linux.intel.com/
[3] git://linux-arm.org/linux-jpb.git sva/current
    http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current

Jean-Philippe Brucker (1):
  iommu: Bind process address spaces to devices

 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
