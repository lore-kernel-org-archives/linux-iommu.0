Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB161C4167B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:27:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7843F23C1A
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 18:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7843F23C1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E8CC8741C;
	Wed,  9 Dec 2020 18:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnTPDSObPF-o; Wed,  9 Dec 2020 18:27:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BD9BE873E6;
	Wed,  9 Dec 2020 18:27:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAB7AC0FA7;
	Wed,  9 Dec 2020 18:27:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0450BC013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E681C8741C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:27:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6M-T0tnj7uK for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 18:27:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7E271873CF
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 18:27:19 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Crlr04j05z7By3;
 Thu, 10 Dec 2020 02:26:40 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 02:27:03 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v4 0/3] iommu/iova: Solve longterm IOVA issue
Date: Thu, 10 Dec 2020 02:23:06 +0800
Message-ID: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

This series contains a patch to solve the longterm IOVA issue which
leizhen originally tried to address at [0].

A sieved kernel log is at the following, showing periodic dumps of IOVA
sizes, per CPU and per depot bin, per IOVA size granule:
https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test

Notice, for example, the following logs:
[13175.355584] print_iova1 cpu_total=40135 depot_total=3866 total=44001
[83483.457858] print_iova1 cpu_total=62532 depot_total=24476 total=87008

Where total IOVA rcache size has grown from 44K->87K over a long time.

Along with this patch, I included the following:
- A smaller helper to clear all IOVAs for a domain
- Change polarity of the IOVA magazine helpers

Differences to v3:
- Drop Cong's patch, already accepted
- Add tags
- Rebased

Differnces to v2:
- Update commit message for patch 3/4

Differences to v1:
- Add IOVA clearing helper
- Add patch to change polarity of mag helpers
- Avoid logically-redundant extra variable in __iova_rcache_insert()

[0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/4b74d40a-22d1-af53-fcb6-5d70183705a8@huawei.com/

John Garry (3):
  iommu/iova: Add free_all_cpu_cached_iovas()
  iommu/iova: Avoid double-negatives in magazine helpers
  iommu/iova: Flush CPU rcache for when a depot fills

 drivers/iommu/iova.c | 58 ++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
