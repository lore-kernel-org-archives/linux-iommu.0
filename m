Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81CC4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 08:07:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37CE60FD8
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 08:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F37CE60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C03A4405F9;
	Wed, 28 Jul 2021 08:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZBbusa4nyPe; Wed, 28 Jul 2021 08:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 997B1405ED;
	Wed, 28 Jul 2021 08:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6678EC0010;
	Wed, 28 Jul 2021 08:07:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E44C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 08:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7882405F7
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 08:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZnJVmjS-Qv9 for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 08:07:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C599405ED
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 08:07:15 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GZR3673wVz7yfB;
 Wed, 28 Jul 2021 16:02:26 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:10 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 16:07:09 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <rostedt@goodmis.org>, <mingo@redhat.com>, <davem@davemloft.net>,
 <ast@kernel.org>, <ryabinin.a.a@gmail.com>
Subject: [PATCH v2 0/7] sections: Unify kernel sections range check and use
Date: Wed, 28 Jul 2021 16:13:13 +0800
Message-ID: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Cc: linux-s390@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
 mpe@ellerman.id.au, iommu@lists.linux-foundation.org, paulus@samba.org,
 benh@kernel.crashing.org, bpf@vger.kernel.org
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

There are three head files(kallsyms.h, kernel.h and sections.h) which
include the kernel sections range check, let's make some cleanup and
unify them.

1. cleanup arch specific text/data check and fix address boundary check
   in kallsyms.h
2. make all the basic/core kernel range check function into sections.h
3. update all the callers, and use the helper in sections.h to simplify
   the code

After this series, we have 5 APIs about kernel sections range check in
sections.h

 * is_kernel_core_data()	--- come from core_kernel_data() in kernel.h
 * is_kernel_rodata()		--- already in sections.h
 * is_kernel_text()		--- come from kallsyms.h
 * is_kernel_inittext()		--- come from kernel.h and kallsyms.h
 * is_kernel()			--- come from kallsyms.h


Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-arch@vger.kernel.org 
Cc: iommu@lists.linux-foundation.org
Cc: bpf@vger.kernel.org 

v2:
- add ACK/RW to patch2, and drop inappropriate fix tag
- keep 'core' to check kernel data, suggestted by Steven Rostedt
  <rostedt@goodmis.org>, rename is_kernel_data() to is_kernel_core_data()
- drop patch8 which is merged
- drop patch9 which is resend independently

v1:
https://lore.kernel.org/linux-arch/20210626073439.150586-1-wangkefeng.wang@huawei.com

Kefeng Wang (7):
  kallsyms: Remove arch specific text and data check
  kallsyms: Fix address-checks for kernel related range
  sections: Move and rename core_kernel_data() to is_kernel_core_data()
  sections: Move is_kernel_inittext() into sections.h
  kallsyms: Rename is_kernel() and is_kernel_text()
  sections: Add new is_kernel() and is_kernel_text()
  powerpc/mm: Use is_kernel_text() and is_kernel_inittext() helper

 arch/powerpc/mm/pgtable_32.c   |  7 +---
 arch/x86/kernel/unwind_orc.c   |  2 +-
 arch/x86/net/bpf_jit_comp.c    |  2 +-
 include/asm-generic/sections.h | 71 ++++++++++++++++++++++++++--------
 include/linux/kallsyms.h       | 21 +++-------
 include/linux/kernel.h         |  2 -
 kernel/cfi.c                   |  2 +-
 kernel/extable.c               | 33 ++--------------
 kernel/locking/lockdep.c       |  3 --
 kernel/trace/ftrace.c          |  2 +-
 mm/kasan/report.c              |  2 +-
 net/sysctl_net.c               |  2 +-
 12 files changed, 72 insertions(+), 77 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
