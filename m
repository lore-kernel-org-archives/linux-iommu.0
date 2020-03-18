Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F79AC4332B
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4214A208FE
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJGy7/R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4214A208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E9B286B9E;
	Wed, 18 Mar 2020 20:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id isY-jfPsONXt; Wed, 18 Mar 2020 20:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7DB9686ACB;
	Wed, 18 Mar 2020 20:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC94C18DA;
	Wed, 18 Mar 2020 20:54:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74691C013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5F5AA266D9
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:54:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ENLmMVH6AR0F for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 20:54:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id F028323115
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:54:41 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 199C8208E0;
 Wed, 18 Mar 2020 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584564881;
 bh=fCNfBvEj8FxR11jKzYU+guYTmGDCT7dasMbitXaR4R0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gJGy7/R7qHbCazNYWG2tii+/UlomRi6MvG7Wnkn8EYRF6JJbojlVZFIa20mcogQo5
 oL9T0v0MhZyyi91kRln5yuoE8l+DoyVuWhG9kgwlt2TDEiURTOw2xUeO+TOxiYG393
 zpkUEG3jadliCv/8cV16s03qWuI4lBzb2cGUaBFY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 51/73] iommu/vt-d: Silence RCU-list debugging
 warnings
Date: Wed, 18 Mar 2020 16:53:15 -0400
Message-Id: <20200318205337.16279-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>
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

From: Qian Cai <cai@lca.pw>

[ Upstream commit f5152416528c2295f35dd9c9bd4fb27c4032413d ]

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
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dmar.c | 3 ++-
 include/linux/dmar.h | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 7196cabafb252..6ec5da4d028f9 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -363,7 +363,8 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
 {
 	struct dmar_drhd_unit *dmaru;
 
-	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list)
+	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list,
+				dmar_rcu_check())
 		if (dmaru->segment == drhd->segment &&
 		    dmaru->reg_base_addr == drhd->address)
 			return dmaru;
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index a7cf3599d9a1c..e0d52e9358c9c 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -73,11 +73,13 @@ extern struct list_head dmar_drhd_units;
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)
 
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
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
