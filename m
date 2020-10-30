Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F6C4741F
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 02:58:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DC3207EA
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 02:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC3207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7F5D82107F;
	Fri, 30 Oct 2020 02:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uakt7ONnDU8r; Fri, 30 Oct 2020 02:58:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 59BC92045C;
	Fri, 30 Oct 2020 02:58:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B4FBC0859;
	Fri, 30 Oct 2020 02:58:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 273C0C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 02:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1691187436
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 02:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsmUerBHnoXN for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 02:58:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 90E918742C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 02:58:14 +0000 (UTC)
IronPort-SDR: KHrsv+wyEhZ+FMx0faweaVvT4sfk9ZlMpYTCwajv+UFT/DVSIP4XgUplLsEhPew3Dl1s6zKpaz
 VQ/eXjbW3y6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165054110"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="165054110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:58:14 -0700
IronPort-SDR: FD/AEwI0yVS5kY8jkVsWhYxD2oP8AKjMoLYNqDloNC5pFCqe/e5bkDF8HinCaODScUxx1yVJ9a
 zbAebystXiHg==
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; d="scan'208";a="469374387"
Received: from yisun1-ubuntu2.bj.intel.com ([10.238.144.104])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 29 Oct 2020 19:58:11 -0700
From: Yi Sun <yi.y.sun@linux.intel.com>
To: joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 jean-philippe@linaro.org
Subject: [PATCH v2 0/2] iommu: Fix a few issues related to PRQ
Date: Fri, 30 Oct 2020 10:37:22 +0800
Message-Id: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: iommu@lists.linux-foundation.org, Yi Sun <yi.y.sun@linux.intel.com>,
 linux-kernel@vger.kernel.org
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

We found a few issues about PRQ. So, two patches are cooked to
fix them. Please have a review. Thanks!

Changes from v1:
================
- Modify subject of patch 1 to make it more accurate.
- Move get_domain_info() up to the sanity check part in patch 1.
- Remove v1 patch 2 which is not suitable.
- Add description for current patch 2.
- Add 'Fixes:' tags for all patches.

Liu Yi L (1):
  iommu/vt-d: Fix sid not set issue in in intel_svm_bind_gpasid()

Liu, Yi L (1):
  iommu/vt-d: Fix a bug for PDP check in prq_event_thread

 drivers/iommu/intel/svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
