Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB5AC433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 14:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9800960B1B;
	Thu, 10 Feb 2022 14:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jwP4a-N4gUA1; Thu, 10 Feb 2022 14:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6DA8860AB5;
	Thu, 10 Feb 2022 14:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41646C0011;
	Thu, 10 Feb 2022 14:54:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F9DBC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 02:44:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FBF760E38
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 02:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3cjjJRR4wGO for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 02:44:48 +0000 (UTC)
X-Greylist: delayed 00:12:04 by SQLgrey-1.8.0
Received: from h4.fbrelay.privateemail.com (h4.fbrelay.privateemail.com
 [131.153.2.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 242A760BF2
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 02:44:48 +0000 (UTC)
Received: from MTA-06-3.privateemail.com (mta-06-1.privateemail.com
 [68.65.122.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 15C2D1801691
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 21:32:43 -0500 (EST)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
 by mta-06.privateemail.com (Postfix) with ESMTP id BA63018000AD;
 Wed,  9 Feb 2022 21:32:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
 t=1644460360; bh=bat2b2vczdAO3gG1eSLsoPHTCx/Y+HGptLuu8z8kW/g=;
 h=From:To:Cc:Subject:Date:From;
 b=ztPswVJK3qLcaydP8DO220wPp+b+Tv86I+fCBCl9BubJ9aY9NfVJaxpegp3/XvoHd
 QWCOFCwfB+VfW6yiuonWij5IznhHkvDhvTLjQVdF/mtzhhlLHVuI/p71jDkrRg8jlC
 KbWS/CgjOBmbcuTAGSQdnGc/1gxREEpH54It6F404FdadAqozuoQ0WdRWS6yNWNSe7
 oLGxFmQsFIsCr4RmLoaWb6nVxvPoCNUIoVIR4Fq56Rp6tml+mK6yiPNUd/mNkHHgBj
 uin3doYw4IBI2jB/KJX2S6EsziGbyfRNsplBnkNgsOf75kCYcB/WAJqO+LpKHwftAk
 fdgFekeW6v26g==
Received: from warhead.local (unknown [10.20.151.143])
 by mta-06.privateemail.com (Postfix) with ESMTPA id 06FC818000A1;
 Wed,  9 Feb 2022 21:32:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
 t=1644460360; bh=bat2b2vczdAO3gG1eSLsoPHTCx/Y+HGptLuu8z8kW/g=;
 h=From:To:Cc:Subject:Date:From;
 b=ztPswVJK3qLcaydP8DO220wPp+b+Tv86I+fCBCl9BubJ9aY9NfVJaxpegp3/XvoHd
 QWCOFCwfB+VfW6yiuonWij5IznhHkvDhvTLjQVdF/mtzhhlLHVuI/p71jDkrRg8jlC
 KbWS/CgjOBmbcuTAGSQdnGc/1gxREEpH54It6F404FdadAqozuoQ0WdRWS6yNWNSe7
 oLGxFmQsFIsCr4RmLoaWb6nVxvPoCNUIoVIR4Fq56Rp6tml+mK6yiPNUd/mNkHHgBj
 uin3doYw4IBI2jB/KJX2S6EsziGbyfRNsplBnkNgsOf75kCYcB/WAJqO+LpKHwftAk
 fdgFekeW6v26g==
From: Marco Bonelli <marco@mebeim.net>
To: dwmw2@infradead.org
Subject: [PATCH] iommu/vt-d: Add missing "__init" for rmrr_sanity_check()
Date: Thu, 10 Feb 2022 03:31:41 +0100
Message-Id: <20220210023141.9208-1-marco@mebeim.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Thu, 10 Feb 2022 14:54:58 +0000
Cc: linux-kernel@vger.kernel.org, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

rmrr_sanity_check() calls arch_rmrr_sanity_check(), which is marked as
"__init". Add the annotation for rmrr_sanity_check() too. This function is
currently only called from dmar_parse_one_rmrr() which is also "__init".

Signed-off-by: Marco Bonelli <marco@mebeim.net>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..7a308fd8d4b9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3691,7 +3691,7 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
-static int rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
+static int __init rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	if (!IS_ALIGNED(rmrr->base_address, PAGE_SIZE) ||
 	    !IS_ALIGNED(rmrr->end_address + 1, PAGE_SIZE) ||
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
