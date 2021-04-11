Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD893C43460
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 06:33:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6289060233
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 06:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289060233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20085836F6;
	Sun, 11 Apr 2021 06:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h10muLeNYB2w; Sun, 11 Apr 2021 06:33:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 176EA836F1;
	Sun, 11 Apr 2021 06:33:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF0CFC000B;
	Sun, 11 Apr 2021 06:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6763AC000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 445C7403A4
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m_zKcjD6Uhi3 for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 06:33:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69EEF403A3
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 06:33:02 +0000 (UTC)
IronPort-SDR: mFZnOSFWc76y8AP0Ov2QKJSbq1u43Mkkrk18nuHD6tkjlFsSjeU/guhAeIZ50q607CxaXyvyft
 +HdSMDYaUyAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="181124352"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; d="scan'208";a="181124352"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2021 23:33:01 -0700
IronPort-SDR: i9OKvhbG4YO9IHwkD1Vg/oxLhZrn8lM6ghMUnTffFHgUnjw6+NpDr5OQPyGZGAbmppqGSAX8Tk
 8AtzBRifn4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; d="scan'208";a="442678699"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2021 23:32:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix build error of pasid_enable_wpe() with
 !X86
Date: Sun, 11 Apr 2021 14:23:12 +0800
Message-Id: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kernel test robot <lkp@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Sanjay Kumar <sanjay.k.kumar@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

Commit f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor
SVM") added pasid_enable_wpe() which hit below compile error with !X86.

../drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
../drivers/iommu/intel/pasid.c:554:22: error: implicit declaration of function 'read_cr0' [-Werror=implicit-function-declaration]
  554 |  unsigned long cr0 = read_cr0();
      |                      ^~~~~~~~
In file included from ../include/linux/build_bug.h:5,
                 from ../include/linux/bits.h:22,
                 from ../include/linux/bitops.h:6,
                 from ../drivers/iommu/intel/pasid.c:12:
../drivers/iommu/intel/pasid.c:557:23: error: 'X86_CR0_WP' undeclared (first use in this function)
  557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
      |                       ^~~~~~~~~~
../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |                                          ^
../drivers/iommu/intel/pasid.c:557:23: note: each undeclared identifier is reported only once for each function it appears in
  557 |  if (unlikely(!(cr0 & X86_CR0_WP))) {
      |                       ^~~~~~~~~~
../include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
   78 | # define unlikely(x) __builtin_expect(!!(x), 0)
      |

Add the missing dependency.

Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: f68c7f539b6e9 ("iommu/vt-d: Enable write protect for supervisor SVM")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 477b2e1d303c..72646bafc52f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -551,6 +551,7 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 
 static inline int pasid_enable_wpe(struct pasid_entry *pte)
 {
+#ifdef CONFIG_X86
 	unsigned long cr0 = read_cr0();
 
 	/* CR0.WP is normally set but just to be sure */
@@ -558,6 +559,7 @@ static inline int pasid_enable_wpe(struct pasid_entry *pte)
 		pr_err_ratelimited("No CPU write protect!\n");
 		return -EINVAL;
 	}
+#endif
 	pasid_set_wpe(pte);
 
 	return 0;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
