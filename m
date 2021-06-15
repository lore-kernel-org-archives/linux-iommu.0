Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590ECC48BE8
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 17:16:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBFA61403
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 17:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBFA61403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 789F840534;
	Tue, 15 Jun 2021 17:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CdDHNyIrGta1; Tue, 15 Jun 2021 17:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 000D140533;
	Tue, 15 Jun 2021 17:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCD03C0031;
	Tue, 15 Jun 2021 17:16:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A119EC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9170640292
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vATXQMMpg4tr for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 17:14:55 +0000 (UTC)
X-Greylist: delayed 00:06:05 by SQLgrey-1.8.0
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44821400C9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1623777295; x=1655313295;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=2Y+lDCjRmIpEy9DeVAnlX6cO0nhxVgrvbBBtRj51LMs=;
 b=tCzDs0HBVdwlU+SGcUlq1U81gdfJOY0jW5qS1hy9WDzfywTtHdRGB9eB
 NcDaFrZquz+10nGIAPMGYzdfq/mtzEroVpSYywqLSQ68V91WNuvWuO3vd
 KMTdP5TqBF6vchUCmtpY6kByWsBOwephc6qqenLaqAELZ8NMU29kqOZtt 0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2021 10:08:50 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Jun 2021 10:08:49 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 15 Jun 2021 10:08:49 -0700
From: Georgi Djakov <quic_c_gdjako@quicinc.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v6 00/15] Optimizing iommu_[map/unmap] performance
Date: Tue, 15 Jun 2021 10:08:18 -0700
Message-ID: <1623776913-390160-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
X-Mailman-Approved-At: Tue, 15 Jun 2021 17:16:44 +0000
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, djakov@kernel.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

When unmapping a buffer from an IOMMU domain, the IOMMU framework unmaps
the buffer at a granule of the largest page size that is supported by
the IOMMU hardware and fits within the buffer. For every block that
is unmapped, the IOMMU framework will call into the IOMMU driver, and
then the io-pgtable framework to walk the page tables to find the entry
that corresponds to the IOVA, and then unmaps the entry.

This can be suboptimal in scenarios where a buffer or a piece of a
buffer can be split into several contiguous page blocks of the same size.
For example, consider an IOMMU that supports 4 KB page blocks, 2 MB page
blocks, and 1 GB page blocks, and a buffer that is 4 MB in size is being
unmapped at IOVA 0. The current call-flow will result in 4 indirect calls,
and 2 page table walks, to unmap 2 entries that are next to each other in
the page-tables, when both entries could have been unmapped in one shot
by clearing both page table entries in the same call.

The same optimization is applicable to mapping buffers as well, so
these patches implement a set of callbacks called unmap_pages and
map_pages to the io-pgtable code and IOMMU drivers which unmaps or maps
an IOVA range that consists of a number of pages of the same
page size that is supported by the IOMMU hardware, and allows for
manipulating multiple page table entries in the same set of indirect
calls. The reason for introducing these callbacks is to give other IOMMU
drivers/io-pgtable formats time to change to using the new callbacks, so
that the transition to using this approach can be done piecemeal.

Changes since V5: 
(https://lore.kernel.org/r/20210408171402.12607-1-isaacm@codeaurora.org/)

* Rebased on next-20210515.
* Fixed minor checkpatch warnings - indentation, extra blank lines.
* Use the correct function argument in __arm_lpae_map(). (chenxiang)

Changes since V4:

* Fixed type for addr_merge from phys_addr_t to unsigned long so
  that GENMASK() can be used.
* Hooked up arm_v7s_[unmap/map]_pages to the io-pgtable ops.
* Introduced a macro for calculating the number of page table entries
  for the ARM LPAE io-pgtable format.

Changes since V3:

* Removed usage of ULL variants of bitops from Will's patches, as
  they were not needed.
* Instead of unmapping/mapping pgcount pages, unmap_pages() and
  map_pages() will at most unmap and map pgcount pages, allowing
  for part of the pages in pgcount to be mapped and unmapped. This
  was done to simplify the handling in the io-pgtable layer.
* Extended the existing PTE manipulation methods in io-pgtable-arm
  to handle multiple entries, per Robin's suggestion, eliminating
  the need to add functions to clear multiple PTEs.
* Implemented a naive form of [map/unmap]_pages() for ARM v7s io-pgtable
  format.
* arm_[v7s/lpae]_[map/unmap] will call
  arm_[v7s/lpae]_[map_pages/unmap_pages] with an argument of 1 page.
* The arm_smmu_[map/unmap] functions have been removed, since they
  have been replaced by arm_smmu_[map/unmap]_pages.

Changes since V2:

* Added a check in __iommu_map() to check for the existence
  of either the map or map_pages callback as per Lu's suggestion.

Changes since V1:

* Implemented the map_pages() callbacks
* Integrated Will's patches into this series which
  address several concerns about how iommu_pgsize() partitioned a
  buffer (I made a minor change to the patch which changes
  iommu_pgsize() to use bitmaps by using the ULL variants of
  the bitops)

Isaac J. Manjarres (12):
  iommu/io-pgtable: Introduce unmap_pages() as a page table op
  iommu: Add an unmap_pages() op for IOMMU drivers
  iommu/io-pgtable: Introduce map_pages() as a page table op
  iommu: Add a map_pages() op for IOMMU drivers
  iommu: Add support for the map_pages() callback
  iommu/io-pgtable-arm: Prepare PTE methods for handling multiple
    entries
  iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
  iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
  iommu/io-pgtable-arm-v7s: Implement arm_v7s_unmap_pages()
  iommu/io-pgtable-arm-v7s: Implement arm_v7s_map_pages()
  iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
  iommu/arm-smmu: Implement the map_pages() IOMMU driver callback

Will Deacon (3):
  iommu: Use bitmap to calculate page size in iommu_pgsize()
  iommu: Split 'addr_merge' argument to iommu_pgsize() into separate
    parts
  iommu: Hook up '->unmap_pages' driver callback

 drivers/iommu/arm/arm-smmu/arm-smmu.c |  18 ++--
 drivers/iommu/io-pgtable-arm-v7s.c    |  50 +++++++--
 drivers/iommu/io-pgtable-arm.c        | 188 ++++++++++++++++++++++------------
 drivers/iommu/iommu.c                 | 129 +++++++++++++++++------
 include/linux/io-pgtable.h            |   8 ++
 include/linux/iommu.h                 |   9 ++
 6 files changed, 287 insertions(+), 115 deletions(-)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
