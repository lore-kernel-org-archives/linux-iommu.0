Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73B0C3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 12:11:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F1C20665
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 12:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F1C20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A0FA210B7;
	Thu, 15 Aug 2019 12:11:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E1F6D10A7
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 12:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C66CA711
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 12:11:43 +0000 (UTC)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 3F05632DDAE6107C412A;
	Thu, 15 Aug 2019 20:11:40 +0800 (CST)
Received: from HGHY4L002753561.china.huawei.com (10.133.215.186) by
	DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server
	id 14.3.439.0; Thu, 15 Aug 2019 20:11:32 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Jean-Philippe
	Brucker" <jean-philippe@linaro.org>, John Garry <john.garry@huawei.com>,
	"Robin Murphy" <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Joerg
	Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, Omer
	Peleg <omer@cs.technion.ac.il>, Adam Morrison <mad@cs.technion.ac.il>, 
	Shaohua Li <shli@fb.com>, Ben Serebrin <serebrin@google.com>,
	David Woodhouse <David.Woodhouse@intel.com>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-kernel
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] iommu/iova: enhance the rcache optimization
Date: Thu, 15 Aug 2019 20:11:02 +0800
Message-ID: <20190815121104.29140-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.215.186]
X-CFilter-Loop: Reflected
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

v1 --> v2
1. I did not chagne the patches but added this cover-letter.
2. Add a batch of reviewers base on
   9257b4a206fc ("iommu/iova: introduce per-cpu caching to iova allocation")
3. I described the problem I met in patch 2, but I hope below brief description
   can help people to quickly understand.
   Suppose there are six rcache sizes, each size can maximum hold 10000 IOVAs.
   --------------------------------------------
   |  4K   |  8K  | 16K  |  32K | 64K  | 128K |
   --------------------------------------------
   | 10000 | 9000 | 8500 | 8600 | 9200 | 7000 |
   --------------------------------------------
   As the above map displayed, the whole rcache buffered too many IOVAs. Now, the
   worst case can be coming, suppose we need 20000 4K IOVAs at one time. That means
   10000 IOVAs can be allocated from rcache, but another 10000 IOVAs should be 
   allocated from RB tree base on alloc_iova() function. But the RB tree currently
   have at least (9000 + 8500 + 8600 + 9200 + 7000) = 42300 nodes. The average speed
   of RB tree traverse will be very slow. For my test scenario, the 4K size IOVAs are
   frequently used, but others are not. So similarly, when the 20000 4K IOVAs are
   continuous freed, the first 10000 IOVAs can be quickly buffered, but the other
   10000 IOVAs can not.

Zhen Lei (2):
  iommu/iova: introduce iova_magazine_compact_pfns()
  iommu/iova: enhance the rcache optimization

 drivers/iommu/iova.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/iova.h |   1 +
 2 files changed, 95 insertions(+), 6 deletions(-)

-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
