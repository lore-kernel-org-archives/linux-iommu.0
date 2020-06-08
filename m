Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC237C433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 03:39:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F512076A
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 03:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F512076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1C75C204AD;
	Mon,  8 Jun 2020 03:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gf+Fzdyv21Hg; Mon,  8 Jun 2020 03:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B5BEB2002F;
	Mon,  8 Jun 2020 03:39:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99688C07FF;
	Mon,  8 Jun 2020 03:39:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D691C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 03:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 155CC853F8
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 03:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fsjsjPbUY8aG for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 03:39:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 32C8D84FBB
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 03:39:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R781e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0U-spSA6_1591587544; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U-spSA6_1591587544) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 08 Jun 2020 11:39:04 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, agross@kernel.org,
 bjorn.andersson@linaro.org, matthias.bgg@gmail.com, robdclark@gmail.com,
 robh@kernel.org, tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 1/2] iommu: Mark __iommu_map/__iommu_map_sg as static
Date: Mon,  8 Jun 2020 11:38:40 +0800
Message-Id: <4c593e1c69112238d46604967dc390a304f35d1d.1591587029.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
References: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
References: <cover.1591587029.git.baolin.wang@linux.alibaba.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, baolin.wang@linux.alibaba.com,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Now the __iommu_map() and __iommu_map_sg() are used only in iommu.c
file, so mark them as static.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/iommu/iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ac91024..04ba8f7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1924,8 +1924,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int __iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
+		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	const struct iommu_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
@@ -2075,9 +2075,9 @@ size_t iommu_unmap_fast(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_unmap_fast);
 
-size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
-		    struct scatterlist *sg, unsigned int nents, int prot,
-		    gfp_t gfp)
+static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
+			     struct scatterlist *sg, unsigned int nents, int prot,
+			     gfp_t gfp)
 {
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
