Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A07AC04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 11:53:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C07A20883
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 11:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C07A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 183561838;
	Mon, 27 May 2019 11:53:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F334E1823
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 11:53:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0AEABA9
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 11:53:00 +0000 (UTC)
Received: from ramsan ([84.194.111.163]) by albert.telenet-ops.be with bizsmtp
	id HPsy2000G3XaVaC06PsyAT; Mon, 27 May 2019 13:52:59 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hVEBW-0001O2-DG; Mon, 27 May 2019 13:52:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hVEBW-0000ao-BN; Mon, 27 May 2019 13:52:58 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH v4 1/6] iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
Date: Mon, 27 May 2019 13:52:48 +0200
Message-Id: <20190527115253.2114-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527115253.2114-1-geert+renesas@glider.be>
References: <20190527115253.2114-1-geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

As of commit 7af9a5fdb9e0ca33 ("iommu/ipmmu-vmsa: Use
iommu_device_sysfs_add()/remove()"), IOMMU devices show up under
/sys/class/iommu/, but their "devices" subdirectories are empty.
Likewise, devices tied to an IOMMU do not have an "iommu" backlink.

Make sure all links are created, on both arm32 and arm64.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
v4:
  - Add Reviewed-by, Tested-by,

v3:
  - Fix sysfs path typo in patch description,

v2:
  - Add Reviewed-by.
---
 drivers/iommu/ipmmu-vmsa.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9a380c10655e182d..9f2b781e20a0eba6 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -885,27 +885,37 @@ static int ipmmu_init_arm_mapping(struct device *dev)
 
 static int ipmmu_add_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
 	struct iommu_group *group;
+	int ret;
 
 	/*
 	 * Only let through devices that have been verified in xlate()
 	 */
-	if (!to_ipmmu(dev))
+	if (!mmu)
 		return -ENODEV;
 
-	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA))
-		return ipmmu_init_arm_mapping(dev);
+	if (IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)) {
+		ret = ipmmu_init_arm_mapping(dev);
+		if (ret)
+			return ret;
+	} else {
+		group = iommu_group_get_for_dev(dev);
+		if (IS_ERR(group))
+			return PTR_ERR(group);
 
-	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+		iommu_group_put(group);
+	}
 
-	iommu_group_put(group);
+	iommu_device_link(&mmu->iommu, dev);
 	return 0;
 }
 
 static void ipmmu_remove_device(struct device *dev)
 {
+	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
+
+	iommu_device_unlink(&mmu->iommu, dev);
 	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
