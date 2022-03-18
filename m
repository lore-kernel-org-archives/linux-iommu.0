Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E30DC433FE
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 17:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3AA1E401A3;
	Fri, 18 Mar 2022 17:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFluRL4CEVds; Fri, 18 Mar 2022 17:43:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5A2540117;
	Fri, 18 Mar 2022 17:43:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8B39C0033;
	Fri, 18 Mar 2022 17:43:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4A11C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 17:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DB04401A3
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 17:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFV_z1P4DU5c for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 17:43:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6178A40117
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 17:43:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 977971515;
 Fri, 18 Mar 2022 10:43:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 270B73F7B4;
 Fri, 18 Mar 2022 10:43:03 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org, baolu.lu@linux.intel.com, andreas.noever@gmail.com,
 michael.jamet@intel.com, mika.westerberg@linux.intel.com,
 YehezkelShB@gmail.com
Subject: [PATCH v2 0/2] thunderbolt: Make iommu_dma_protection more accurate
Date: Fri, 18 Mar 2022 17:42:56 +0000
Message-Id: <cover.1647624084.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org, hch@lst.de,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com
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

OK, here's chapter 3 in the story of "but I really just want to
remove iommu_present()", which is the second go at this approach
on the Thunderbolt end, but now improving the IOMMU end as well
since the subtlety of why that still matters has been clarified.
Previous thread here:

https://lore.kernel.org/linux-iommu/f887686a-e7e4-f031-97e8-dbeb1c088095@arm.com/T/

Thanks,
Robin.


Robin Murphy (2):
  iommu: Add capability for pre-boot DMA protection
  thunderbolt: Make iommu_dma_protection more accurate

 drivers/iommu/intel/iommu.c  |  2 ++
 drivers/thunderbolt/domain.c | 12 +++--------
 drivers/thunderbolt/nhi.c    | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h        |  7 ++++++
 include/linux/thunderbolt.h  |  2 ++
 5 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
