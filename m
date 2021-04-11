Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8388C433B4
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 21:13:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9C9610A6
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 21:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9C9610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B87940285;
	Sun, 11 Apr 2021 21:13:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwXjHav1vcfg; Sun, 11 Apr 2021 21:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAC584021D;
	Sun, 11 Apr 2021 21:13:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD1C4C000C;
	Sun, 11 Apr 2021 21:13:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B382C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 21:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7993B605F6
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 21:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zu2xXVw__Kkn for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 21:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 731746001E
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [46.188.10.168])
 by mail.ispras.ru (Postfix) with ESMTPSA id D0C8D40D3BFF;
 Sun, 11 Apr 2021 21:13:47 +0000 (UTC)
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/amd: Fix extended features logging
Date: Mon, 12 Apr 2021 00:13:30 +0300
Message-Id: <20210411211330.2252-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, iommu@lists.linux-foundation.org,
 Alexander Monakov <amonakov@ispras.ru>, Joerg Roedel <jroedel@suse.de>
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

print_iommu_info prints the EFR register and then the decoded list of
features on a separate line:

pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
 PPR X2APIC NX GT IA GA PC GA_vAPIC

The second line is emitted via 'pr_cont', which causes it to have a
different ('warn') loglevel compared to the previous line ('info').

Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
from the pci_info format string, but this doesn't work, as pci_info
calls implicitly append a newline anyway.

Printing the decoded features on the same line would make it quite long.
Instead, change pci_info() to pr_info() to omit PCI bus location info,
which is shown in the preceding message anyway. This results in:

pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
AMD-Vi: Extended features (0x206d73ef22254ade): PPR X2APIC NX GT IA GA PC GA_vAPIC
AMD-Vi: Interrupt remapping enabled

Fixes: 9a295ff0ffc9 ("iommu/amd: Print extended features in one line to fix divergent log levels")
Link: https://lore.kernel.org/lkml/alpine.LNX.2.20.13.2104112326460.11104@monopod.intra.ispras.ru
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org
---

v2: avoid pr_info(""), change pci_info() to pr_info() for a nicer
solution

 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 596d0c413473..62913f82a21f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1929,8 +1929,8 @@ static void print_iommu_info(void)
 		pci_info(pdev, "Found IOMMU cap 0x%hx\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pci_info(pdev, "Extended features (%#llx):",
-				 iommu->features);
+			pr_info("Extended features (%#llx):", iommu->features);
+
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
 					pr_cont(" %s", feat_str[i]);
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
