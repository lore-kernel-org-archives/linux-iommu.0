Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F15C433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:35:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34086610CB
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 01:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34086610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 877B540623;
	Fri,  2 Apr 2021 01:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xk4xDldb4LuC; Fri,  2 Apr 2021 01:35:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7822740625;
	Fri,  2 Apr 2021 01:35:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43FF9C000A;
	Fri,  2 Apr 2021 01:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E53A4C0011
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id D585540605
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id 8XQyvE6PrH1a for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 01:35:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 4D5884017B
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 01:35:14 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617327316; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=CT+4abI4TFfH94RkyWUSnWETSNvyyN2buhCcJ59C9kU=;
 b=MkmWZ0qMCxaFcuYULNYsDK4HZKcyoFF+2XIm0HAhjGeAUn/U3GRqNmTFqQHR0kHdIWIXqRXG
 WfPG19IbbaLd7Ak8GMcn5sovRC6JMzr1AnKdW6YcZbn0n6DQnGQeiSxnbBhvwiaVCFqb5M6Z
 ALMlU+zm2pEyoLnE59pbRTk1XX0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 606674c4e0e9c9a6b6db1c53 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 01:35:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 393D3C433CA; Fri,  2 Apr 2021 01:35:00 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C2B1C433C6;
 Fri,  2 Apr 2021 01:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C2B1C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 00/12] Optimizing iommu_[map/unmap] performance
Date: Thu,  1 Apr 2021 18:34:39 -0700
Message-Id: <20210402013452.4013-1-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 will@kernel.org, pratikp@codeaurora.org
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

Changes since V1:

* Implemented the map_pages() callbacks
* Integrated Will's patches into this series which
  address several concerns about how iommu_pgsize() partitioned a
  buffer (I made a minor change to the patch which changes
  iommu_pgsize() to use bitmaps by using the ULL variants of
  the bitops)

Any feedback is very much appreciated.

Isaac J. Manjarres (9):
  iommu/io-pgtable: Introduce unmap_pages() as a page table op
  iommu: Add an unmap_pages() op for IOMMU drivers
  iommu/io-pgtable: Introduce map_pages() as a page table op
  iommu: Add a map_pages() op for IOMMU drivers
  iommu: Add support for the map_pages() callback
  iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
  iommu/io-pgtable-arm: Implement arm_lpae_map_pages()
  iommu/arm-smmu: Implement the unmap_pages() IOMMU driver callback
  iommu/arm-smmu: Implement the map_pages() IOMMU driver callback

Will Deacon (3):
  iommu: Use bitmap to calculate page size in iommu_pgsize()
  iommu: Split 'addr_merge' argument to iommu_pgsize() into separate
    parts
  iommu: Hook up '->unmap_pages' driver callback

 drivers/iommu/arm/arm-smmu/arm-smmu.c |  38 +++++
 drivers/iommu/io-pgtable-arm.c        | 219 ++++++++++++++++++++++----
 drivers/iommu/iommu.c                 | 128 +++++++++++----
 include/linux/io-pgtable.h            |   8 +
 include/linux/iommu.h                 |   9 ++
 5 files changed, 343 insertions(+), 59 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
