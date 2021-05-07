Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F521C433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 12:50:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B069A61469
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 12:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B069A61469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50410607B2;
	Fri,  7 May 2021 12:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MykGmQtAw88n; Fri,  7 May 2021 12:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4316A606D3;
	Fri,  7 May 2021 12:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26431C000D;
	Fri,  7 May 2021 12:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EAD6C0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 12:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04A2C60814
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 12:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5DLB_9R8sAo for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 12:50:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE4A8607B2
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 12:50:10 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc9F52R6VzqTD8;
 Fri,  7 May 2021 20:46:49 +0800 (CST)
Received: from huawei.com (10.174.185.226) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 20:50:00 +0800
From: Wang Xingang <wangxingang5@huawei.com>
To: <will@kernel.org>, <joro@8bytes.org>
Subject: [PATCH 0/1] iommu/of: Fix request and enable ACS for
 of_iommu_configure
Date: Fri, 7 May 2021 12:49:52 +0000
Message-ID: <1620391793-18744-1-git-send-email-wangxingang5@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Cc: xieyingtai@huawei.com, wangxingang5@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com
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

From: Xingang Wang <wangxingang5@huawei.com>

When request ACS in of_iommu_configure, the pci_acs_init procedure has
already been called. The pci device probe procedure is like the following:
pci_host_common_probe
    pci_device_add
        pci_acs_init
of_iommu_configure
    pci_request_acs

The pci_request_acs() does not work because the pci_acs_init and
pci_enable_acs procedure has already finished, so the ACS is not
enabled as expected.  Besides, the ACS is enabled only if IOMMU is
detected and the device is pci.

So this fix 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core
when configuring IOMMU linkage"), add pci_enable_acs() and IOMMU check
to make sure ACS is enabled for the pci_device.

Xingang Wang (1):
  iommu/of: Fix request and enable ACS for of_iommu_configure

 drivers/iommu/of_iommu.c | 10 +++++++++-
 drivers/pci/pci.c        |  2 +-
 include/linux/pci.h      |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
