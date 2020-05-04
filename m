Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C40BC47264
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07662075E
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 12:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07662075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B8B4922EDD;
	Mon,  4 May 2020 12:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vEUO55FpSm0T; Mon,  4 May 2020 12:54:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 998EF22DD3;
	Mon,  4 May 2020 12:54:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E007C088C;
	Mon,  4 May 2020 12:54:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC6B1C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A9C2F8693B
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7RWP5MQ5enFX for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 12:54:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 51D3687589
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 12:54:17 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B004139F; Mon,  4 May 2020 14:54:14 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/5] iommu/amd: Fix race conditions around
 increase_address_space()
Date: Mon,  4 May 2020 14:54:08 +0200
Message-Id: <20200504125413.16798-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Cc: Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org
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

Hi,

Qian reported more race conditions around the dma-mapping
code path in the AMD IOMMU driver. The race condtions are
between increas_address_space() and fetch_pte(), there were
two of them:

	1) the 'pt_root' and 'mode' fields of 'struct
	   protection_domain' relate to each other so that
	   they must be updated together atomically.

	2) The increase_address_space() function publishes
	   the updated page-table before it has been written
	   to the DTE. This might cause PTEs to be mapped
	   and addresses handed to the device which are not
	   yet reachable through the DTE entry, causing IO
	   page-faults.

This patch-set fixes these issues, as tested by Qian Cai.

Thanks a lot again for reporting these issued and testing
the fixes!

Regards,

	Joerg


Joerg Roedel (5):
  iommu/amd: Fix race in increase_address_space()/fetch_pte()
  iommu/amd: Do not loop forever when trying to increase address space
  iommu/amd: Call domain_flush_complete() in update_domain()
  iommu/amd: Update Device Table in increase_address_space()
  iommu/amd: Do not flush Device Table in iommu_map_page()

 drivers/iommu/amd_iommu.c       | 198 +++++++++++++++++++++++++-------
 drivers/iommu/amd_iommu_types.h |   9 +-
 2 files changed, 161 insertions(+), 46 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
