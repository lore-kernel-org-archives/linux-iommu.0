Return-Path: <SRS0=YHJ+=6U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD2C47247
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 02:03:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF1720721
	for <iommu@archiver.kernel.org>; Wed,  6 May 2020 02:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF1720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D35A186CD4;
	Wed,  6 May 2020 02:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iImlXEdzJ_un; Wed,  6 May 2020 02:03:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 38F9086D04;
	Wed,  6 May 2020 02:03:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28FF2C088B;
	Wed,  6 May 2020 02:03:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58F24C0859
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 02:03:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4A29F86D08
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 02:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VP-TdFU96-y6 for <iommu@lists.linux-foundation.org>;
 Wed,  6 May 2020 02:03:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 89A9386CD4
 for <iommu@lists.linux-foundation.org>; Wed,  6 May 2020 02:03:13 +0000 (UTC)
IronPort-SDR: io/duNT5ex4QWssIrKUEYFV4Z2xiKjkCLgXVX2OPkUpAVMp814ybC6GOwTLv1/XD9ZDncD6bDy
 MUcZQOILx+KA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 19:03:11 -0700
IronPort-SDR: EYAQbLoNwp3XOKfPvss+uAsi4T3AQA8oKDTXzARQK2Q7Pz/yFy6xL0UxT0Tn0+l5p7SFL0V+nt
 bOQXjH65zT6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,357,1583222400"; d="scan'208";a="369645032"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 05 May 2020 19:03:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 0/3] Replace private domain with per-group default domain
Date: Wed,  6 May 2020 09:59:44 +0800
Message-Id: <20200506015947.28662-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

Some devices are required to use a specific type (identity or dma) of
default domain when they are used with a vendor iommu. When the system
level default domain type is different from it, the vendor iommu driver
has to request a new default domain with either
iommu_request_dma_domain_for_dev() or iommu_request_dm_for_dev() in the
add_dev() callback. Unfortunately, these two helpers only work when the
group hasn't been assigned to any other devices, hence, some vendor iommu
driver has to use a private domain if it fails to request a new default
one.

Joerg proposed an on-going proposal which makes the default domain
framework to support configuring per-group default domain during boot
process.

https://lkml.org/lkml/2020/4/14/616
[This has been applied in iommu/next.]

Hence, there is no need to keep the private domain implementation
in the Intel IOMMU driver. This patch series aims to remove it.

Best regards,
baolu

Change log:
v3->v4:
 - Make the commit message of the first patch more comprehensive.

v2->v3:
 - Port necessary patches on the top of Joerg's new proposal.
   https://lkml.org/lkml/2020/4/14/616
   The per-group default domain proposed previously in this series
   will be deprecated due to a race concern between domain switching
   and device driver probing.

v1->v2:
 - Rename the iommu ops callback to def_domain_type

Lu Baolu (3):
  iommu/vt-d: Allow 32bit devices to uses DMA domain
  iommu/vt-d: Allow PCI sub-hierarchy to use DMA domain
  iommu/vt-d: Apply per-device dma_ops

 drivers/iommu/intel-iommu.c | 396 +++---------------------------------
 1 file changed, 26 insertions(+), 370 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
