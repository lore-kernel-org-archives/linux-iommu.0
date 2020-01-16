Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2673BC33CAF
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 17:02:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A3620730
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 17:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkPLUsO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A3620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C025886500;
	Thu, 16 Jan 2020 17:02:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbWG3K-V0VEt; Thu, 16 Jan 2020 17:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DEABF864D0;
	Thu, 16 Jan 2020 17:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE69C1D88;
	Thu, 16 Jan 2020 17:02:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA6A9C077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 17:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D46CF86905
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 17:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6iHVDZqUFcY for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 17:02:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8CD9C8698E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 17:02:08 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B15E21D56;
 Thu, 16 Jan 2020 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579194128;
 bh=+2g8YbRkKj4/ek6gIMPpD8fSakK9WKulrjtOujpsfPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KkPLUsO51UWJ4wdD1bJU6qkmUXqER31E1miB0OYTybhJ9Amkm+3ZpJjhIEjwW2Sjk
 Fv6kVJ9DKltMHEcaOIJKuuEFNdl052ZqbUoFx9lMuhqxgDj9dWJmDb/vF/xle8lO4u
 NXqbDecvwr/brunVztAjFFomVhrmdDqiJnYrR8Xk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 219/671] iommu: Fix IOMMU debugfs fallout
Date: Thu, 16 Jan 2020 11:52:08 -0500
Message-Id: <20200116165940.10720-102-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Joerg Roedel <jroedel@suse.de>, Gary R Hook <gary.hook@amd.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 18b3af4492a0aa6046b86d712f6ba4cbb66100fb ]

A change made in the final version of IOMMU debugfs support replaced the
public function iommu_debugfs_new_driver_dir() by the public dentry
iommu_debugfs_dir in <linux/iommu.h>, but forgot to update both the
implementation in iommu-debugfs.c, and the patch description.

Fix this by exporting iommu_debugfs_dir, and removing the reference to
and implementation of iommu_debugfs_new_driver_dir().

Fixes: bad614b24293ae46 ("iommu: Enable debugfs exposure of IOMMU driver internals")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu-debugfs.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
index 3b1bf88fd1b0..f03548942096 100644
--- a/drivers/iommu/iommu-debugfs.c
+++ b/drivers/iommu/iommu-debugfs.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 
 struct dentry *iommu_debugfs_dir;
+EXPORT_SYMBOL_GPL(iommu_debugfs_dir);
 
 /**
  * iommu_debugfs_setup - create the top-level iommu directory in debugfs
@@ -23,9 +24,9 @@ struct dentry *iommu_debugfs_dir;
  * Emit a strong warning at boot time to indicate that this feature is
  * enabled.
  *
- * This function is called from iommu_init; drivers may then call
- * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
- * directory to be used to expose internal data.
+ * This function is called from iommu_init; drivers may then use
+ * iommu_debugfs_dir to instantiate a vendor-specific directory to be used
+ * to expose internal data.
  */
 void iommu_debugfs_setup(void)
 {
@@ -48,19 +49,3 @@ void iommu_debugfs_setup(void)
 		pr_warn("*************************************************************\n");
 	}
 }
-
-/**
- * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
- * @vendor: name of the vendor-specific subdirectory to create
- *
- * This function is called by an IOMMU driver to create the top-level debugfs
- * directory for that driver.
- *
- * Return: upon success, a pointer to the dentry for the new directory.
- *         NULL in case of failure.
- */
-struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
-{
-	return debugfs_create_dir(vendor, iommu_debugfs_dir);
-}
-EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
