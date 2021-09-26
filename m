Return-Path: <SRS0=RzN/=OQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08850C433F5
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 13:15:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9763761019
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 13:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9763761019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 243F640298;
	Sun, 26 Sep 2021 13:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7xzTwEHuF26; Sun, 26 Sep 2021 13:15:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CA9A5400A8;
	Sun, 26 Sep 2021 13:15:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A21DC000F;
	Sun, 26 Sep 2021 13:15:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CDF1C000D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 13:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 199F94034E
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 13:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h6Kz23CPQedT for <iommu@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 13:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr
 [80.12.242.131])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAC604034C
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 13:14:57 +0000 (UTC)
Received: from pop-os.home ([90.126.248.220]) by mwinf5d33 with ME
 id yd7K2500H4m3Hzu03d7Lw8; Sun, 26 Sep 2021 15:07:22 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Sep 2021 15:07:22 +0200
X-ME-IP: 90.126.248.220
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, jonathanh@nvidia.com
Subject: [PATCH] iommu/tegra-smmu: Use devm_bitmap_zalloc when applicable
Date: Sun, 26 Sep 2021 15:07:18 +0200
Message-Id: <2c0f4da80c3b5ef83299c651f69a563034c1c6cb.1632661557.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

'smmu->asids' is a bitmap. So use 'devm_kzalloc()' to simplify code,
improve the semantic of the code and avoid some open-coded arithmetic in
allocator arguments.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/tegra-smmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0a281833f611..e900e3c46903 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1079,7 +1079,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    struct tegra_mc *mc)
 {
 	struct tegra_smmu *smmu;
-	size_t size;
 	u32 value;
 	int err;
 
@@ -1097,9 +1096,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	 */
 	mc->smmu = smmu;
 
-	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
-
-	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
+	smmu->asids = devm_bitmap_zalloc(dev, soc->num_asids, GFP_KERNEL);
 	if (!smmu->asids)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
