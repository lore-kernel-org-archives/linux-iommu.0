Return-Path: <SRS0=kRV3=4W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9840DC3F2D2
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 20:15:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B70207FD
	for <iommu@archiver.kernel.org>; Thu,  5 Mar 2020 20:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EozR9uSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B70207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 310A384E7C;
	Thu,  5 Mar 2020 20:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yRhhfjfGDMCT; Thu,  5 Mar 2020 20:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD62684B60;
	Thu,  5 Mar 2020 20:15:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96289C1AE2;
	Thu,  5 Mar 2020 20:15:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 611C2C013E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 20:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4E7F884D41
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 20:15:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R7D8ll0ZuTvg for <iommu@lists.linux-foundation.org>;
 Thu,  5 Mar 2020 20:15:11 +0000 (UTC)
X-Greylist: delayed 00:13:54 by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7598384B60
 for <iommu@lists.linux-foundation.org>; Thu,  5 Mar 2020 20:15:11 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id d22so77140qtn.0
 for <iommu@lists.linux-foundation.org>; Thu, 05 Mar 2020 12:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=lsTlhJGBqft/K5JqQFXCrVXt13xPv+FZ9nKG6t7UOmg=;
 b=EozR9uSiJiM39xnIz4HVrzXuclwRJ8+ZZWJqMpNzGsvACotrZKpiUdmxNGGOd4Zf4c
 uZMnz5PgJrNe2sDXh/C/iKo7dev0UQl+t1n4s4xFFJDtQ9JGSgFlt9LPlemc8RR/QGjQ
 xQ9EYr5qy3G64IR3Z75yZYReixPS3W6+7w2oo5wU11XvorZQsbQZmXVEUU3UqP6rdjvz
 GHFOoyklE45X30nXTExNtPA1sVRNHLl+N0L5iw2pjJL3H/AuxdKGcQ/mRpXZwHOxq3l4
 nqdrWH4IAvurhiRjxe2SJWT1DzbFHWyHqfdlfY+b1YE/srNb8V9NxWxarem2B5G2V0Xu
 mEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lsTlhJGBqft/K5JqQFXCrVXt13xPv+FZ9nKG6t7UOmg=;
 b=t+FI+yb6Lxd7gu1W5gAKGw91J/NmemzbLHiKt6K6JNvQYVYftTPIj2MIk01FvEp3ny
 fLFY2fhvvOGWPyK43uEcGPBN5LT7hHkxkqBB9tK/MyVRp6OAQ6DjYFEF4eGgXyGg5upg
 l516NO5drScplZ8dcpaPWCzTAmQtca26CP+UwevmNnj/ECEMxN7WJdq1yuFR4dJR1rgP
 DDi1njET9aN5NWYxCh2QH93jJFbVOCf4UYnSEz0eW1TEbopfvz2LPjIyFRoddZiTu1Il
 V/WePFouFkLgrXly33lMmiHyo2zMNLYvM9F9gxaYnX6wvFV8WcJGAJud0EH9FsXtavNY
 YiwQ==
X-Gm-Message-State: ANhLgQ0dYhZIkJjugDHDKE5WXvWEbF9nl472A/HVnj5wJ7KEHh2UfO2E
 lQHjX4D9J2Tzgdzhl6juIgPOqg==
X-Google-Smtp-Source: ADFU+vsb7AANSdnCAfTh/bngRu53s2/B2h3q2rb2sPLMZz471ReHsGfGqA8mIvynejrExfdyPbRMnQ==
X-Received: by 2002:aed:218f:: with SMTP id l15mr399544qtc.247.1583439310499; 
 Thu, 05 Mar 2020 12:15:10 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id z6sm16254300qka.34.2020.03.05.12.15.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 12:15:09 -0800 (PST)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH -next] iommu/dmar: silence RCU-list debugging warnings
Date: Thu,  5 Mar 2020 15:15:02 -0500
Message-Id: <1583439302-11393-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Similar to the commit 02d715b4a818 ("iommu/vt-d: Fix RCU list debugging
warnings"), there are several other places that call
list_for_each_entry_rcu() outside of an RCU read side critical section
but with dmar_global_lock held. Silence those false positives as well.

 drivers/iommu/intel-iommu.c:4288 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1ad/0xb97

 drivers/iommu/dmar.c:366 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x125/0xb97

 drivers/iommu/intel-iommu.c:5057 RCU-list traversed in non-reader section!!
 1 lock held by swapper/0/1:
  #0: ffffffffa71892c8 (dmar_global_lock){++++}, at: intel_iommu_init+0x61a/0xb13

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/dmar.c | 3 ++-
 include/linux/dmar.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 071bb42bbbc5..7b16c4db40b4 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -363,7 +363,8 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 {
 	struct dmar_drhd_unit *dmaru;
 
-	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list)
+	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list,
+				dmar_rcu_check())
 		if (dmaru->segment == drhd->segment &&
 		    dmaru->reg_base_addr == drhd->address)
 			return dmaru;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 712be8bc6a7c..d7bf029df737 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -74,11 +74,13 @@ struct dmar_pci_notify_info {
 				dmar_rcu_check())
 
 #define for_each_active_drhd_unit(drhd)					\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (drhd->ignored) {} else
 
 #define for_each_active_iommu(i, drhd)					\
-	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
+	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
+				dmar_rcu_check())			\
 		if (i=drhd->iommu, drhd->ignored) {} else
 
 #define for_each_iommu(i, drhd)						\
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
