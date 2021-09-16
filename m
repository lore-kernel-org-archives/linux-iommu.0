Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0334EC433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:13:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF95D61216
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF95D61216
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87BD1403F7;
	Thu, 16 Sep 2021 15:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xuvaYWHPdsOg; Thu, 16 Sep 2021 15:13:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D08240401;
	Thu, 16 Sep 2021 15:13:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 183BCC0011;
	Thu, 16 Sep 2021 15:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D917C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C72D613FF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iJavi7VGnVZF for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 15:13:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DBAA613F7
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NPS32LBo1lFtZC7655/bLaoki3lIovD5YIwjfW1yC8Q=; b=b1C6u2pCwjbh8Pui7S4jlbC58k
 dFsa822atqUzLNQu9UuIAdlZxt5gzcspO6OSB8pyMYNz22xqpZoX7EQV6VKl12uyQaQKIOibogR97
 nXvRgRysCzUCv3fR06s1jT9xTSpPeNQVe+LB1wzUJs/XlmX0m5kQUzswSY72DS9b3EOf2vNhHQDl8
 Ker/OTkbkDTevoUBjBh39inp+Ve/KDdGASCMULUwvoNqhGkDMVRx+oaHwFQsS6qPeGZ/YASrSQk6R
 31NN5sukfAwldI2ek0qxuDhWdqYd+/O7y/CfXd3O9GRe/A8yF5KOSvuIw6H1RMIbRLTfidKa41UpJ
 Q53havLA==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1mQsRw-0005Xx-8k; Thu, 16 Sep 2021 17:33:16 +0300
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Subject: [PATCH v2 6/8] drm/tegra: falcon: Set DMACTX field on DMA transactions
Date: Thu, 16 Sep 2021 17:33:00 +0300
Message-Id: <20210916143302.2024933-7-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916143302.2024933-1-mperttunen@nvidia.com>
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: Mikko Perttunen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The DMACTX field determines which context, as specified in the
TRANSCFG register, is used. While during boot it doesn't matter
which is used, later on it matters and this value is reused by
the firmware.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/falcon.c | 8 ++++++++
 drivers/gpu/drm/tegra/falcon.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/tegra/falcon.c b/drivers/gpu/drm/tegra/falcon.c
index 223ab2ceb7e6..8bdb72f08f58 100644
--- a/drivers/gpu/drm/tegra/falcon.c
+++ b/drivers/gpu/drm/tegra/falcon.c
@@ -48,6 +48,14 @@ static int falcon_copy_chunk(struct falcon *falcon,
 	if (target == FALCON_MEMORY_IMEM)
 		cmd |= FALCON_DMATRFCMD_IMEM;
 
+	/*
+	 * Use second DMA context (i.e. the one for firmware). Strictly
+	 * speaking, at this point both DMA contexts point to the firmware
+	 * stream ID, but this register's value will be reused by the firmware
+	 * for later DMA transactions, so we need to use the correct value.
+	 */
+	cmd |= FALCON_DMATRFCMD_DMACTX(1);
+
 	falcon_writel(falcon, offset, FALCON_DMATRFMOFFS);
 	falcon_writel(falcon, base, FALCON_DMATRFFBOFFS);
 	falcon_writel(falcon, cmd, FALCON_DMATRFCMD);
diff --git a/drivers/gpu/drm/tegra/falcon.h b/drivers/gpu/drm/tegra/falcon.h
index c56ee32d92ee..1955cf11a8a6 100644
--- a/drivers/gpu/drm/tegra/falcon.h
+++ b/drivers/gpu/drm/tegra/falcon.h
@@ -50,6 +50,7 @@
 #define FALCON_DMATRFCMD_IDLE			(1 << 1)
 #define FALCON_DMATRFCMD_IMEM			(1 << 4)
 #define FALCON_DMATRFCMD_SIZE_256B		(6 << 8)
+#define FALCON_DMATRFCMD_DMACTX(v)		(((v) & 0x7) << 12)
 
 #define FALCON_DMATRFFBOFFS			0x0000111c
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
