Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90635C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 08:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 460A941C1B;
	Fri, 17 Dec 2021 08:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SwOvv68-ybxS; Fri, 17 Dec 2021 08:38:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BF5941C13;
	Fri, 17 Dec 2021 08:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE13C002F;
	Fri, 17 Dec 2021 08:38:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84681C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FF0B84B4D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eiepKkvM7j4t for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 08:38:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B35DF83EBD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 08:38:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="325999646"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="325999646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2021 00:38:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="662786076"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 00:38:48 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 4/4] iommu/vt-d: Use correctly sized arguments for bit field
Date: Fri, 17 Dec 2021 16:38:17 +0800
Message-Id: <20211217083817.1745419-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
References: <20211217083817.1745419-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Kees Cook <keescook@chromium.org>,
 Yury Norov <yury.norov@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
 Nick Desaulniers <ndesaulniers@google.com>, iommu@lists.linux-foundation.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

From: Kees Cook <keescook@chromium.org>

The find.h APIs are designed to be used only on unsigned long arguments.
This can technically result in a over-read, but it is harmless in this
case. Regardless, fix it to avoid the warning seen under -Warray-bounds,
which we'd like to enable globally:

In file included from ./include/linux/bitmap.h:9,
                 from drivers/iommu/intel/iommu.c:17:
drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
./include/linux/find.h:119:37: warning: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Warray-bounds]
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                     ^~~~~
drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
 2115 |         int pds, max_pde;
      |                  ^~~~~~~

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20211215232432.2069605-1-keescook@chromium.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 73ad4578de25..56671c7f4c08 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2102,10 +2102,10 @@ static void domain_exit(struct dmar_domain *domain)
  */
 static inline unsigned long context_get_sm_pds(struct pasid_table *table)
 {
-	int pds, max_pde;
+	unsigned long pds, max_pde;
 
 	max_pde = table->max_pasid >> PASID_PDE_SHIFT;
-	pds = find_first_bit((unsigned long *)&max_pde, MAX_NR_PASID_BITS);
+	pds = find_first_bit(&max_pde, MAX_NR_PASID_BITS);
 	if (pds < 7)
 		return 0;
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
