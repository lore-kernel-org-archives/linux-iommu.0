Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF20AC43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C382465E
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD5NDXyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C382465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B665E887C8;
	Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3HkoMEsI-Zx; Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C84B884D0;
	Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 228C9C077D;
	Fri, 20 Dec 2019 00:32:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D11EC077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 05D398716A
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQdimWwYg1Dm for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA9A987019
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id bd4so3326514plb.8
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rDhGn3D52iJxkHzCP3mTsRd2P8WhMkWO8X9jAcOeSIA=;
 b=rD5NDXyY4kT+DdfDWZH8k1yYtROAbNunav4TSQ9Gv/YSit70QvTlQegpXR9zvanMuC
 HGp2laefH3s6V/OjKnbqjZyMcbSQMMK+VUtdgdkngVv9QddZ0qDEIMK/xlfAXG5GK2H8
 kfbgxvDETi43cEpELuVN1NEgtzPGAIS9TIxd3rgNWDS/21v3TjQ7EeFGRQ1ctCepo23t
 eyUqjCIAJ9GqAWX3DkSXDGM1rFfFjU9RaVM7V1AdrZMxOIx6oH5weNS1uN+SaKwgqwDk
 ocYnxbDjpgUTSrMnHlHdPk9IzbsESESoBIWOsPlOiwcF77BWJM4Yh/89nZ8zbmHLSpHo
 Bcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rDhGn3D52iJxkHzCP3mTsRd2P8WhMkWO8X9jAcOeSIA=;
 b=kpsEZldSjzYnrQM3PuuGDs8YV7Oi1QvJyQtmGavheX1KyM4dJpixtLpk2FC4SrZzcw
 ymE+e5OU74znd50tf/534d76LbTgwRlSoQ+Lhdnis59HWXSSk2zDZxdGsFSw7Agne0q5
 oww8dXUuIJFWcpFlxBNGjLFryPq+6ASh9atAbP8z5drKyfqng6jCW27Rpj3HSM0Pv5wQ
 dH1SSlsl5TOzgLqECI1jn7dyQBOqAvlh2zdo/Uk60vRxf1G/3MVWK+avXGxdgFrMaiK6
 Ia0V0eJ4o0bhgFv403VJNxKbZZi1VmCV7xwmsHG4CPsqlhC1Txf9ZOGGbTDiFRH8ulei
 jDjA==
X-Gm-Message-State: APjAAAUTahlakXbqXbg1Ai0tVn6Vua046D5tor1K4yMlmAK0kq6OebBp
 LggrxDBz6tl2bppZlfXJ6uQ=
X-Google-Smtp-Source: APXvYqwSC6mIbKaAEPt+A8fSzCMKI1FstUpdwYnmK1yyvlti7s/8B2Pujsxd38trVP4lxkn8zJHh7A==
X-Received: by 2002:a17:902:6b09:: with SMTP id
 o9mr11031641plk.209.1576801955160; 
 Thu, 19 Dec 2019 16:32:35 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 16:32:34 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH 4/4] iommu/tegra-smmu: Prevent race condition between map and
 unmap
Date: Thu, 19 Dec 2019 16:29:14 -0800
Message-Id: <20191220002914.19043-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220002914.19043-1-nicoleotsuka@gmail.com>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

When testing with ethernet downloading, "EMEM address decode error"
happens due to race condition between map() and unmap() functions.

This patch adds a spin lock to protect content within as->[count]
and as->pts[pde] references, since a function call might be atomic.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3999ecb63cfa..236bc6d6d238 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -37,6 +37,7 @@ struct tegra_smmu {
 
 	unsigned long *asids;
 	struct mutex lock;
+	spinlock_t as_lock;
 
 	struct list_head list;
 
@@ -664,17 +665,23 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long flags;
 	dma_addr_t pte_dma;
 	u32 pte_attrs;
 	u32 *pte;
 
+	spin_lock_irqsave(&smmu->as_lock, flags);
 	pte = as_get_pte(as, iova, &pte_dma);
-	if (!pte)
+	if (!pte) {
+		spin_unlock_irqrestore(&smmu->as_lock, flags);
 		return -ENOMEM;
+	}
 
 	/* If we aren't overwriting a pre-existing entry, increment use */
 	if (*pte == 0)
 		tegra_smmu_pte_get_use(as, iova);
+	spin_unlock_irqrestore(&smmu->as_lock, flags);
 
 	pte_attrs = SMMU_PTE_NONSECURE;
 
@@ -694,6 +701,8 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
+	struct tegra_smmu *smmu = as->smmu;
+	unsigned long flags;
 	dma_addr_t pte_dma;
 	u32 *pte;
 
@@ -702,7 +711,10 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 		return 0;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma, 0);
+
+	spin_lock_irqsave(&smmu->as_lock, flags);
 	tegra_smmu_pte_put_use(as, iova);
+	spin_unlock_irqrestore(&smmu->as_lock, flags);
 
 	return size;
 }
@@ -1033,6 +1045,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	INIT_LIST_HEAD(&smmu->groups);
 	mutex_init(&smmu->lock);
+	spin_lock_init(&smmu->as_lock);
 
 	smmu->regs = mc->regs;
 	smmu->soc = soc;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
