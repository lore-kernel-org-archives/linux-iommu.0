Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA3C433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC61120738
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 09:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC61120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B3DDD883E0;
	Thu, 27 Aug 2020 09:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRy+zHKBi3qN; Thu, 27 Aug 2020 09:33:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D1D3888193;
	Thu, 27 Aug 2020 09:33:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A51C016F;
	Thu, 27 Aug 2020 09:33:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 589CFC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3D876204F2
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ABOhyj+bs5k for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 09:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by silver.osuosl.org (Postfix) with ESMTPS id 929D92001A
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 09:32:58 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5C54037C952DABB4656A;
 Thu, 27 Aug 2020 17:32:54 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.71) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 27 Aug 2020 17:32:46 +0800
From: Barry Song <song.bao.hua@hisilicon.com>
To: <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/3] iommu/arm-smmu-v3: permit users to disable msi polling
Date: Thu, 27 Aug 2020 21:29:54 +1200
Message-ID: <20200827092957.22500-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.126.200.71]
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, will@kernel.org
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

patch 1/3 and patch 2/3 are the preparation of patch 3/3 which permits users
to disable MSI-based polling by cmd line.

-v5:
  add Robin's reviewed-by

-v4:
  with respect to Robin's comments
  * cleanup the code of the existing module parameter disable_bypass
  * add ARM_SMMU_OPT_MSIPOLL flag. on the other hand, we only need to check
    a bit in options rather than two bits in features

Barry Song (3):
  iommu/arm-smmu-v3: replace symbolic permissions by octal permissions
    for module parameter
  iommu/arm-smmu-v3: replace module_param_named by module_param for
    disable_bypass
  iommu/arm-smmu-v3: permit users to disable msi polling

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
