Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B49C433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 16:10:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA67420A8B
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 16:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA67420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4728C20003;
	Mon,  3 Aug 2020 16:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RYZwJFIzXk78; Mon,  3 Aug 2020 16:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01B032051D;
	Mon,  3 Aug 2020 16:10:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD924C0050;
	Mon,  3 Aug 2020 16:10:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3145C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 16:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BBD4087B84
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 16:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAEPTSHC9kln for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 16:10:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1419087B08
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 16:10:05 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5B266B6F2;
 Mon,  3 Aug 2020 16:10:18 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: amit.pundir@linaro.org,
	hch@lst.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] dma-pool fixes
Date: Mon,  3 Aug 2020 18:09:54 +0200
Message-Id: <20200803160956.19235-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, rientjes@google.com,
 Robin Murphy <robin.murphy@arm.com>
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

Now that we have an explanation to Amir's issue, I took the liberty to
respin the previous dma-pool fixes series with some changes/fixes of my
own.

---

Changes since v1:
 - Make cma_in_zone() more strict, GFP_KERNEL doesn't default to true
   now

 - Check if phys_addr_ok() exists prior calling it

Christoph Hellwig (1):
  dma-pool: fix coherent pool allocations for IOMMU mappings

Nicolas Saenz Julienne (1):
  dma-pool: Only allocate from CMA when in same memory zone

 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 +++-
 kernel/dma/pool.c           | 148 ++++++++++++++++++++----------------
 5 files changed, 95 insertions(+), 78 deletions(-)

-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
