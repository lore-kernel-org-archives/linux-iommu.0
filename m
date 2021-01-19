Return-Path: <SRS0=ZMVL=GW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12331C433E0
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 04:43:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A04422241
	for <iommu@archiver.kernel.org>; Tue, 19 Jan 2021 04:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A04422241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 50C8B87099;
	Tue, 19 Jan 2021 04:43:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h77pLDLeGxb2; Tue, 19 Jan 2021 04:43:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1355887093;
	Tue, 19 Jan 2021 04:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3763C088B;
	Tue, 19 Jan 2021 04:43:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 200FBC013A
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 04:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0BE25869C3
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 04:43:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GVZ4-JLl2-cj for <iommu@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 04:43:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5E53786998
 for <iommu@lists.linux-foundation.org>; Tue, 19 Jan 2021 04:43:35 +0000 (UTC)
IronPort-SDR: 2xVk0F6fvdiAAf1lcwzwOqZ4q2n2ECS5P3XpcHkjp9XHBf0x63bP0fPE4X6zW72SNZM1hHeWoc
 +sWUwfM2d7lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="242946580"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; d="scan'208";a="242946580"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2021 20:43:28 -0800
IronPort-SDR: NW9dqf6KtdlALryM0MREyu/mJ7SYUtBJxtasRoqhXw9ue89C2l7l4gnor2eIDlzEsaHTQNqIiE
 dq+vV6SPnIDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; d="scan'208";a="466555975"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2021 20:43:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Correctly check addr alignment in
 qi_flush_dev_iotlb_pasid()
Date: Tue, 19 Jan 2021 12:35:00 +0800
Message-Id: <20210119043500.1539596-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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

An incorrect address mask is being used in the qi_flush_dev_iotlb_pasid()
to check the address alignment. This leads to a lot of spurious kernel
warnings:

[  485.837093] DMAR: Invalidate non-aligned address 7f76f47f9000, order 0
[  485.837098] DMAR: Invalidate non-aligned address 7f76f47f9000, order 0
[  492.494145] qi_flush_dev_iotlb_pasid: 5734 callbacks suppressed
[  492.494147] DMAR: Invalidate non-aligned address 7f7728800000, order 11
[  492.508965] DMAR: Invalidate non-aligned address 7f7728800000, order 11

Fix it by checking the alignment in right way.

Fixes: 288d08e780088 ("iommu/vt-d: Handle non-page aligned address")
Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 004feaed3c72..02e7c10a4224 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1496,7 +1496,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
+	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
 		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
 				    addr, size_order);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
