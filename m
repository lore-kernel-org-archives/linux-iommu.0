Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C7C433DB
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 02:52:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D2B61984
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 02:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D2B61984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6240183B34;
	Sat, 20 Mar 2021 02:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q6xcM8f5Ppas; Sat, 20 Mar 2021 02:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AC7483F07;
	Sat, 20 Mar 2021 02:52:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 359B9C000B;
	Sat, 20 Mar 2021 02:52:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3767AC0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 02:52:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D41D83F07
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 02:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tq7mgex8bs8a for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 02:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D263F83B34
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 02:52:04 +0000 (UTC)
IronPort-SDR: liPeJA1+pl7G9XsNhWaFXg833dcUvFCdjFw3dGPTDSmkEnDkqAV+tz3erTWXhkiAToEtmMQJum
 ZsbfoWmgIOWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="190094239"
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; d="scan'208";a="190094239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2021 19:52:03 -0700
IronPort-SDR: qjpDpDNx3t0xf//3uJctk11VldlRpcPSXM8m8qegIoNLYXeQEBsmmf42C8v9j/G3wBJkl7sTtk
 amCNsVEE9i5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,263,1610438400"; d="scan'208";a="512686651"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2021 19:52:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Don't set then clear private data in
 prq_event_thread()
Date: Sat, 20 Mar 2021 10:41:56 +0800
Message-Id: <20210320024156.640798-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

The VT-d specification (section 7.6) requires that the value in the
Private Data field of a Page Group Response Descriptor must match
the value in the Private Data field of the respective Page Request
Descriptor.

The private data field of a page group response descriptor is set then
immediately cleared in prq_event_thread(). This breaks the rule defined
by the VT-d specification. Fix it by moving clearing code up.

Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Log:
v1->v2:
  - v1: https://lore.kernel.org/linux-iommu/20210309004641.3809653-1-baolu.lu@linux.intel.com/
  - Refine the commit title to make the affected field clear.
  - Refine the commit message to declare why the change matters.

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 677d7f6b43bb..5d590d63ab52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1034,12 +1034,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 				QI_PGRP_RESP_TYPE;
 			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
 				QI_PGRP_LPIG(req->lpig);
+			resp.qw2 = 0;
+			resp.qw3 = 0;
 
 			if (req->priv_data_present)
 				memcpy(&resp.qw2, req->priv_data,
 				       sizeof(req->priv_data));
-			resp.qw2 = 0;
-			resp.qw3 = 0;
 			qi_submit_sync(iommu, &resp, 1, 0);
 		}
 prq_advance:
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
