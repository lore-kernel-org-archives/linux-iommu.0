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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28868C43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E672465E
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlM4L+5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E672465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F16587019;
	Fri, 20 Dec 2019 00:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpQXNNMo8mjW; Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F0ED87046;
	Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 678E5C1AE8;
	Fri, 20 Dec 2019 00:32:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52967C077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3BD9C8768B
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m5Ef+3fe5808 for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 00:32:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0CC1087627
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 00:32:34 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id f20so3332167plj.5
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 16:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uQbeCCqbXt+TANvd9D2T1EUoXbYPHKnFq/HMhRHqLLk=;
 b=KlM4L+5/d17GS8edHbVCqPbHiJlES5jOQEPTRygl9a/rcXjJSULDlWnn3CnxoCNDxX
 iK6Re9a4D/xw67PH/qceV8QHfN5uq0ynVl/YID62PAERj1thJ2LTF0Fx23bi9QPqJ1gm
 Gj8iD/szjoOaQsDWV7yVwMnYTJ6sihPSD5ONPsF4SorBE6BwDAHl4EnoXT8xNgT94r0C
 mi882Zb75Az80Wu0BoYaLiZywfxp6Cb9HNX9mexMI1bfOyIPaIcVg9dNpU3gUr0CoLDX
 JAW5buDBnWUNFiqoBOiO9/HTffRveKFlvfHtKf/ty+AY3Wfy+Of+PqcvWWgYiWVosfal
 vK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uQbeCCqbXt+TANvd9D2T1EUoXbYPHKnFq/HMhRHqLLk=;
 b=O4SDbUacEy6olkT1Tl/cRfSFjsl6umEDrKhBjh4bntTSDHEktFsoR3dbu6ANyL0nRG
 Tsdh6BI4tSr8WLfwArfnCCd4XvyyN2UR9rGOBLhI/VYyhiGvSBHY7oDgmCY2/SYU5dYA
 N147TuGBw18BBWRzs2nGuqWFkXwU8uAabwUopPCG7pVNMN/z1dcQgyBIg8N2uMeJjdpf
 7xDTyBjNxC+PGz8hAFNYK5+KexWc/0Z5vPAtPIZMBoHYnVo1LobcWwoGlhAJKuLsy0fP
 Ky1lMYhNpxByFFs3Sxq9w0Z3Stcj7GkVW0sAh3IZdwTntIHqwnagzMpID6NeVFE9CF5I
 4eBQ==
X-Gm-Message-State: APjAAAWZ5i5bPEILgSumQf1Mlp//MGoO1wad2vdVlAyHtnsqiRe/k7K4
 S36Ipz0Kzq7UJC6VSceyRMY=
X-Google-Smtp-Source: APXvYqwRPFEm1HepTdAK1icU4d6knUegC4DnaNNyJNEVD+B/H2wm8meL7y1fed/osKoMs9+ttxYvUA==
X-Received: by 2002:a17:902:6948:: with SMTP id
 k8mr11816011plt.223.1576801953545; 
 Thu, 19 Dec 2019 16:32:33 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a23sm10145845pfg.82.2019.12.19.16.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 16:32:33 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org
Subject: [PATCH 2/4] iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
Date: Thu, 19 Dec 2019 16:29:12 -0800
Message-Id: <20191220002914.19043-3-nicoleotsuka@gmail.com>
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

PAGE_SHIFT and PAGE_MASK are defined corresponding to the page size
for CPU virtual addresses, which means PAGE_SHIFT could be a number
other than 12, but tegra-smmu maintains fixed 4KB IOVA pages and has
fixed [21:12] bit range for PTE entries.

So this patch replaces all PAGE_SHIFT/PAGE_MASK references with the
macros defined with SMMU_PTE_SHIFT.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 63a147b623e6..5594b47a88bf 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -127,6 +127,11 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define SMMU_PDE_SHIFT 22
 #define SMMU_PTE_SHIFT 12
 
+#define SMMU_PAGE_MASK		(~(SMMU_SIZE_PT-1))
+#define SMMU_OFFSET_IN_PAGE(x)	((unsigned long)(x) & ~SMMU_PAGE_MASK)
+#define SMMU_PFN_PHYS(x)	((phys_addr_t)(x) << SMMU_PTE_SHIFT)
+#define SMMU_PHYS_PFN(x)	((unsigned long)((x) >> SMMU_PTE_SHIFT))
+
 #define SMMU_PD_READABLE	(1 << 31)
 #define SMMU_PD_WRITABLE	(1 << 30)
 #define SMMU_PD_NONSECURE	(1 << 29)
@@ -644,7 +649,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *as, unsigned long iova,
 			       u32 *pte, dma_addr_t pte_dma, u32 val)
 {
 	struct tegra_smmu *smmu = as->smmu;
-	unsigned long offset = offset_in_page(pte);
+	unsigned long offset = SMMU_OFFSET_IN_PAGE(pte);
 
 	*pte = val;
 
@@ -680,7 +685,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 		pte_attrs |= SMMU_PTE_WRITABLE;
 
 	tegra_smmu_set_pte(as, iova, pte, pte_dma,
-			   __phys_to_pfn(paddr) | pte_attrs);
+			   SMMU_PHYS_PFN(paddr) | pte_attrs);
 
 	return 0;
 }
@@ -716,7 +721,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
@@ -1034,7 +1039,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	smmu->dev = dev;
 	smmu->mc = mc;
 
-	smmu->pfn_mask = BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
+	smmu->pfn_mask =
+		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;
 	dev_dbg(dev, "address bits: %u, PFN mask: %#lx\n",
 		mc->soc->num_address_bits, smmu->pfn_mask);
 	smmu->tlb_mask = (smmu->soc->num_tlb_lines << 1) - 1;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
