Return-Path: <SRS0=bugC=HJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F40C433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 08:26:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A410764DC4
	for <iommu@archiver.kernel.org>; Sun,  7 Feb 2021 08:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410764DC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 46F4285FB4;
	Sun,  7 Feb 2021 08:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0tTryvEmBsH; Sun,  7 Feb 2021 08:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D9AE85FAE;
	Sun,  7 Feb 2021 08:26:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E0F5C0174;
	Sun,  7 Feb 2021 08:26:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83C81C013A
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 08:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6F3B787153
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 08:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IocL+BdjTkzh for <iommu@lists.linux-foundation.org>;
 Sun,  7 Feb 2021 08:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C7AEA86864
 for <iommu@lists.linux-foundation.org>; Sun,  7 Feb 2021 08:26:27 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYMf66cr2zjKdl;
 Sun,  7 Feb 2021 16:25:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:26:15 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-api@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v3 0/2] mempinfd: Add new syscall to provide memory pin
Date: Sun, 7 Feb 2021 16:18:02 +0800
Message-ID: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, jgg@ziepe.ca,
 gregkh@linuxfoundation.org, zhangfei.gao@linaro.org, liguozhu@hisilicon.com
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

This series adds a new mempinfd syscall to offer a common way to pin/unpin
memory.

Patch 1/2 is about mempinfd codes.
Patch 2/2 adds a simple test tool about mempinfd.

Change logs:
------------
v2 -> v3:
 - Follow suggestions from Greg and Kevin, add a new syscall.
 - Add input check.
 - Use xa_insert to replace xa_store.
 - Add lock to pretect pin and xa_insert.
v1 -> v2:
 - Some tiny fixes.
 - Follow Greg's suggestion to get mm-list and iommu-list involved.

Links:
------
 - v2: https://www.spinics.net/lists/kernel/msg3808926.html
 - v1: https://www.spinics.net/lists/kernel/msg3805205.html

Zhou Wang (2):
  mempinfd: Add new syscall to provide memory pin
  selftests/vm: add mempinfd test

 arch/arm64/include/asm/unistd.h       |   2 +-
 arch/arm64/include/asm/unistd32.h     |   2 +
 fs/Makefile                           |   1 +
 fs/mempinfd.c                         | 199 ++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h              |   1 +
 include/uapi/asm-generic/unistd.h     |   4 +-
 include/uapi/linux/mempinfd.h         |  23 ++++
 init/Kconfig                          |   6 +
 tools/testing/selftests/vm/Makefile   |   1 +
 tools/testing/selftests/vm/mempinfd.c | 131 ++++++++++++++++++++++
 10 files changed, 368 insertions(+), 2 deletions(-)
 create mode 100644 fs/mempinfd.c
 create mode 100644 include/uapi/linux/mempinfd.h
 create mode 100644 tools/testing/selftests/vm/mempinfd.c

-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
