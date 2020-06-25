Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E9FC433E3
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11ED420709
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 13:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ED420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0295A879E9;
	Thu, 25 Jun 2020 13:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRB7rPE3tKBN; Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9C1787CD4;
	Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95820C08A5;
	Thu, 25 Jun 2020 13:08:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE1DC016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 87FD723143
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LFW89xcZYGX2 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 13:08:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 7FBC223119
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 13:08:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2FD2B4C4; Thu, 25 Jun 2020 15:08:39 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 07/13] iommu/pamu: Use dev_iommu_priv_get/set()
Date: Thu, 25 Jun 2020 15:08:30 +0200
Message-Id: <20200625130836.1916-8-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625130836.1916-1-joro@8bytes.org>
References: <20200625130836.1916-1-joro@8bytes.org>
Cc: linux-ia64@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Woodhouse <dwmw2@infradead.org>
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

From: Joerg Roedel <jroedel@suse.de>

Remove the use of dev->archdata.iommu_domain and use the private
per-device pointer provided by IOMMU core code instead.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/fsl_pamu_domain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 928d37771ece..b2110767caf4 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -323,7 +323,7 @@ static void remove_device_ref(struct device_domain_info *info, u32 win_cnt)
 	pamu_disable_liodn(info->liodn);
 	spin_unlock_irqrestore(&iommu_lock, flags);
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info->dev->archdata.iommu_domain = NULL;
+	dev_iommu_priv_set(info->dev, NULL);
 	kmem_cache_free(iommu_devinfo_cache, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
@@ -352,7 +352,7 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	 * Check here if the device is already attached to domain or not.
 	 * If the device is already attached to a domain detach it.
 	 */
-	old_domain_info = dev->archdata.iommu_domain;
+	old_domain_info = dev_iommu_priv_get(dev);
 	if (old_domain_info && old_domain_info->domain != dma_domain) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		detach_device(dev, old_domain_info->domain);
@@ -371,8 +371,8 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	 * the info for the first LIODN as all
 	 * LIODNs share the same domain
 	 */
-	if (!dev->archdata.iommu_domain)
-		dev->archdata.iommu_domain = info;
+	if (!dev_iommu_priv_get(dev))
+		dev_iommu_priv_set(dev, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
