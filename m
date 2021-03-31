Return-Path: <SRS0=WBHG=I5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6883C433C1
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 03:06:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E43619EF
	for <iommu@archiver.kernel.org>; Wed, 31 Mar 2021 03:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E43619EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 103FE60A85;
	Wed, 31 Mar 2021 03:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TIqf9J08xL7O; Wed, 31 Mar 2021 03:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E92C860A53;
	Wed, 31 Mar 2021 03:06:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2923C000B;
	Wed, 31 Mar 2021 03:06:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F149C000A
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 510A0842A2
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id hb1SgaLFXTq2 for <iommu@lists.linux-foundation.org>;
 Wed, 31 Mar 2021 03:05:59 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 8D55784299
 for <iommu@lists.linux-foundation.org>; Wed, 31 Mar 2021 03:05:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617159959; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=LA0HvulGChES4Iq3dFXt9FdLxjexMjVouvPCQ5TYibM=;
 b=Fp14x4xRIZ9aKJ3LAj/P57INjDmGdBns+pfDkLQ1FfJcPGN8l7nOoIpHOySqO40mC+yCZ2ia
 ez5BHAcATPCDj9aI2e687oq7Wa36XMkv+zqgzWgWPjYSjkOMJ51kfGgo5192e4BHy81d0juO
 djYzlExUIbPGulGxivJiisYj7hE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6063e5e903cfff345233c07c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 31 Mar 2021 03:00:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 7E67AC43462; Wed, 31 Mar 2021 03:00:56 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BE97C433C6;
 Wed, 31 Mar 2021 03:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BE97C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/5] Optimization for unmapping iommu mapped buffers
Date: Tue, 30 Mar 2021 20:00:37 -0700
Message-Id: <20210331030042.13348-1-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
 robin.murphy@arm.com, pratikp@codeaurora.org
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

These patches implement a callback called unmap_pages to the io-pgtable
code and IOMMU drivers which unmaps an IOVA range that consists of a
number of pages of the same page size that is supported by the IOMMU
hardware, and allows for clearing multiple entries in the same set of
indirect calls. The reason for introducing unmap_pages is to give
other IOMMU drivers/io-pgtable formats time to change to using the new
unmap_pages callback, so that the transition to using this approach can be
done piecemeal.

The same optimization is applicable for mapping buffers, however, the
error handling in the io-pgtable layer couldn't be handled cleanly, as we
would need to invoke iommu_unmap to unmap the parts of the buffer that
were mapped, and then do any TLB maintenance. However, that seemed like a
layering violation.

Any feedback is very much appreciated.

Thanks,
Isaac

Isaac J. Manjarres (5):
  iommu/io-pgtable: Introduce unmap_pages() as a page table op
  iommu: Add an unmap_pages() op for IOMMU drivers
  iommu: Add support for the unmap_pages IOMMU callback
  iommu/io-pgtable-arm: Implement arm_lpae_unmap_pages()
  iommu/arm-smmu: Implement the unmap_pages IOMMU driver callback

 drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 +++++
 drivers/iommu/io-pgtable-arm.c        | 114 +++++++++++++++++++++-----
 drivers/iommu/iommu.c                 |  44 ++++++++--
 include/linux/io-pgtable.h            |   4 +
 include/linux/iommu.h                 |   4 +
 5 files changed, 159 insertions(+), 26 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
