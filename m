Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522FC433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 00:04:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4FFF61073
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 00:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4FFF61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9778860796;
	Fri,  8 Oct 2021 00:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1dPjhkAzKjL; Fri,  8 Oct 2021 00:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 94EFC60654;
	Fri,  8 Oct 2021 00:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74716C000F;
	Fri,  8 Oct 2021 00:04:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8E32C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 00:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A94D34011A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 00:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9sos2XZQ-R4o for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 00:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 340C0400E5
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 00:04:45 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQT0v5Qt3zWjPG;
 Fri,  8 Oct 2021 08:03:11 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 08:04:39 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 08:04:38 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>, <will@kernel.org>,
 <joro@8bytes.org>
Subject: [PATCH v3 0/2] iommu/vt-d: boost the mapping process
Date: Fri, 8 Oct 2021 08:04:31 +0800
Message-ID: <20211008000433.1115-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Cc: "Longpeng\(Mike\)" <longpeng2@huawei.com>, iommu@lists.linux-foundation.org,
 arei.gonglei@huawei.com, linux-kernel@vger.kernel.org
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

Hi guys,

We found that the __domain_mapping() would take too long when
the memory region is too large, we try to make it faster in this
patchset. The performance number can be found in PATCH 2, please
review when you free, thanks.

Changes v2 -> v3:
 - make first_pte_in_page() neater  [Baolu]
 - remove meaningless BUG_ON() in __domain_mapping()  [Baolu]

Changes v1 -> v2:
 - Fix compile warning on i386  [Baolu]

Longpeng(Mike) (2):
  iommu/vt-d: convert the return type of first_pte_in_page to bool
  iommu/vt-d: avoid duplicated removing in __domain_mapping

 drivers/iommu/intel/iommu.c | 11 ++++++-----
 include/linux/intel-iommu.h | 10 ++++++++--
 2 files changed, 14 insertions(+), 7 deletions(-)

-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
