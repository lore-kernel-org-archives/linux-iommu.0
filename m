Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D3C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 13:13:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AC02073C
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 13:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AC02073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0B4BC21537;
	Tue, 24 Nov 2020 13:13:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14wtZ2tIUJq4; Tue, 24 Nov 2020 13:13:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A7CA0203D7;
	Tue, 24 Nov 2020 13:13:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BA8BC0891;
	Tue, 24 Nov 2020 13:13:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2596BC0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A51085D39
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zkC1HsShD4rx for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 13:13:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 66D2585C95
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:13:31 +0000 (UTC)
IronPort-SDR: UbzteUuOh5CrDFIWIQFDRUHL8xhrmMgTKkVb8XlGut2JJrCk8GAc40ODs8ov0lsvl7Qg4z+2VP
 cWMaGMMeSzDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172037937"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="172037937"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2020 05:13:30 -0800
IronPort-SDR: /4IoJzqUjN2RdAup2H1oyId6005W/Kv4m0xbrbJMXI/GRTCPdzd4uyEzSO414ugG9+jphPwYrO
 J36B2FgvuyEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; d="scan'208";a="432602175"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 05:13:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v10 0/4] iommu: Add support to change default domain of an
 iommu group
Date: Tue, 24 Nov 2020 21:06:00 +0800
Message-Id: <20201124130604.2912899-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

The last post of this series:

https://lore.kernel.org/linux-iommu/20201121135620.3496419-1-baolu.lu@linux.intel.com/

Change log in this series:
 1. Changes according to comments at
    https://lore.kernel.org/linux-iommu/20201123120449.GB10233@willie-the-truck/
    - Remove the unnecessary iommu_get_mandatory_def_domain_type()

Best regards,
baolu

Lu Baolu (1):
  iommu: Move def_domain type check for untrusted device into core

Sai Praneeth Prakhya (3):
  iommu: Add support to change default domain of an iommu group
  iommu: Take lock before reading iommu group default domain type
  iommu: Document usage of "/sys/kernel/iommu_groups/<grp_id>/type" file

 .../ABI/testing/sysfs-kernel-iommu_groups     |  29 ++
 drivers/iommu/intel/iommu.c                   |   7 -
 drivers/iommu/iommu.c                         | 248 +++++++++++++++++-
 3 files changed, 267 insertions(+), 17 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
