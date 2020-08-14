Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1686EC433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 16:23:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AC320774
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faTDxKkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AC320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92DCF8765F;
	Fri, 14 Aug 2020 16:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4jqzqxgAxF5z; Fri, 14 Aug 2020 16:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F37D387655;
	Fri, 14 Aug 2020 16:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAA27C013C;
	Fri, 14 Aug 2020 16:23:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0A6C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 16:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 80CE088734
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 16:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tkpjTvAajbUz for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 16:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 907EC88721
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 16:23:09 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id d2so5120955lfj.1
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5XUom1+N8VJF984pWSuHb/mTQ8k7XQqK3c1GXB5JLrs=;
 b=faTDxKkzEvzVfjje1Z55vXJsrvhO0hFBHdcT5Ih7idzEgEh4TTk7+M3nWvv7GVMmib
 wSctTzmweNycw0D4wGGCytA/5j2IQaYcu5deIMNFcs9Asa9AT9CSE9Tr1Ylj+EMYdmfo
 y9iJ6UJUJ74yd8avbXuUWecvZj30MAdXs81cjzDeWoAZPFNVMen/JGEbPQHBVnRio8pr
 RM9GALxhjZLq8h411eAzEiQNwHwNzhuG1guE4Zj8IVWLLpeFGZQ3UD3eS/Y81JgmQyrE
 ugNLHnQMJFaFjQI64FQEuXCKHRNNLp5qMXS4l2WlpYIqXlZV8Sw4LdQUVNUWSMLckDvT
 eDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5XUom1+N8VJF984pWSuHb/mTQ8k7XQqK3c1GXB5JLrs=;
 b=JaNCGEqVJIHvTmS4cxD++YtO4mZCCFi8BPn/U5Oq79Q2XOWEnsqKV2bRH8fItHTQP9
 i+iaheqiszXheLLli12/vSaz8TTwu/IeFmEX6NVsG/DsrGCnTA1WWf5fJlsIQvjcppGO
 GLpwS9Upv5iAKjFg39mOGvG/8XnmG6NSXKJpcQz1O/r3dRkpRPZZ8K2X08thaLsvifJq
 5BlJ5fAt/xzfl1rg+K17u/s5tPDSSqbLfBhoj+ZOLTFGBqGrBMndlPmD85gN0YLj1SUb
 VAgcBI/AbhT+/+t2YsDbqgk64GGcdokJuf+T7z8rD6KmG56SznehtDdkqsOKChyg1IfI
 Pf2Q==
X-Gm-Message-State: AOAM531kOUpaxddWbaK9KYZz8YkYypvCYc3ep7Z73OwOJwOdho0pkm/x
 G8HfI18LxJZTzIzLUqNUS2M=
X-Google-Smtp-Source: ABdhPJxmowXg0NDxMUTsjwWOYeEN/ouIAg/BQuR2y27kS5zC+cBqFm2eDK4gW0JuFeMHGisvMYxWVg==
X-Received: by 2002:ac2:58c6:: with SMTP id u6mr1574772lfo.105.1597422187536; 
 Fri, 14 Aug 2020 09:23:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.gmail.com with ESMTPSA id v14sm1846577ljk.10.2020.08.14.09.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:23:06 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around mapping
 operations
Date: Fri, 14 Aug 2020 19:22:52 +0300
Message-Id: <20200814162252.31965-1-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
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

The mapping operations of the Tegra SMMU driver are subjected to a race
condition issues because SMMU Address Space isn't allocated and freed
atomically, while it should be. This patch makes the mapping operations
atomic, it fixes an accidentally released Host1x Address Space problem
which happens while running multiple graphics tests in parallel on
Tegra30, i.e. by having multiple threads racing with each other in the
Host1x's submission and completion code paths, performing IOVA mappings
and unmappings in parallel.

Cc: <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: - No changes. Resending for visibility, please apply.

v2: - Now using mutex instead of spinlock.

    - The _locked postfix is replaced with the underscores prefix.


 drivers/iommu/tegra-smmu.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 124c8848ab7e..4315b6381354 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -49,6 +49,7 @@ struct tegra_smmu_as {
 	struct iommu_domain domain;
 	struct tegra_smmu *smmu;
 	unsigned int use_count;
+	struct mutex lock;
 	u32 *count;
 	struct page **pts;
 	struct page *pd;
@@ -308,6 +309,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	mutex_init(&as->lock);
+
 	/* setup aperture */
 	as->domain.geometry.aperture_start = 0;
 	as->domain.geometry.aperture_end = 0xffffffff;
@@ -655,8 +658,9 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 	smmu_flush(smmu);
 }
 
-static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int
+__tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+		 phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -685,8 +689,9 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	return 0;
 }
 
-static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
-			       size_t size, struct iommu_iotlb_gather *gather)
+static size_t
+__tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+		   size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	dma_addr_t pte_dma;
@@ -702,6 +707,31 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
+static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+	int ret;
+
+	mutex_lock(&as->lock);
+	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp);
+	mutex_unlock(&as->lock);
+
+	return ret;
+}
+
+static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
+			       size_t size, struct iommu_iotlb_gather *gather)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+
+	mutex_lock(&as->lock);
+	size = __tegra_smmu_unmap(domain, iova, size, gather);
+	mutex_unlock(&as->lock);
+
+	return size;
+}
+
 static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
