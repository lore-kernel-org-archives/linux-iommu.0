Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E4DFA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 11:50:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5772C20854
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lmwm5xOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5772C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 351C9D3B;
	Wed, 16 Oct 2019 11:50:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4E756D0A
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 11:50:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A1FA688E
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 11:50:34 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j11so27709013wrp.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Xfs3L/lYc6zDzxN7DSH41Pri4/NZ12+1KernicuYiqA=;
	b=Lmwm5xOgxzDvX0xUkGR+74pw7AOCWlzpfe1LzjT90UwFalzx2CiPCP2mNWVnAM6LF/
	8nWb1/E/TBHPIno81umCXr6TEZf46Kz2CrV61hVl99ULvxMkIbSVRkPk3poAKlJHTS4J
	cPRwvVEZmyPPj+W9bNn3OQS4flwTToroFhzySmtVFLy9Y25NbXJdRjBRVQZ+nmbFf2Xz
	WNsrke281EH1p8hX+iiOAY27Ma2P0IKRi+r17jkPfjpESZwRjNWBjyd+t2RBaEbU6M/e
	a4YCQWDzWlTkzPwdUP2oWH5CcAhbHRfycgT+CB1a12B5XDSGv8UzHkoVBxTkjizSq2vt
	Omew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Xfs3L/lYc6zDzxN7DSH41Pri4/NZ12+1KernicuYiqA=;
	b=i71hsEDj8SzwXEu2uq2ytjrLOEbJI1AwqdwF9AheOhwRydmo7nMzdlyr7rzSCPXZ5L
	8jn7ZAAbnvHcjz9/NRgCFFJQ7JGQLRgeW4v6osybUOz/TJPPRhZuSSxu1S6h6kFA4IsJ
	AxTNzxBhWjtT4Qu4cN69O90ypgi0rfbTfHehs3GhUdezFtJcxpUqZTFsWR2dr7ZBS7Bg
	oGVV/E0FLuXVEoaQzVrx2amyJD3Mv0K9E1xpz5iuY96fTWaizQxrjfMkiJLK5mSpvsVy
	qVWTtENo2Bo8N7l6lfMRKVChX853s6CxPlIKEhEzWCzHiGK8SaDTdWL2eXRYtWqr3lWc
	uEBg==
X-Gm-Message-State: APjAAAXtBioiTKD95uyNKDcrTBtXUJNyFCMQn7DZcsj1GdVeiXWTSmuT
	h8VA4k5inZ0gNCrcMkoktRs=
X-Google-Smtp-Source: APXvYqzvIfFURxdXKSuhHE5QkOrdTS1xLwMDfrdilHnRBTrz6C24IgnISPG71UwFbpL1nbMOkFtuGg==
X-Received: by 2002:a5d:4f8f:: with SMTP id d15mr2463922wru.126.1571226633196; 
	Wed, 16 Oct 2019 04:50:33 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
	by smtp.gmail.com with ESMTPSA id l6sm2573001wmg.2.2019.10.16.04.50.31
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 16 Oct 2019 04:50:32 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/3] iommu/tegra-smmu: Fix page tables in > 4 GiB memory
Date: Wed, 16 Oct 2019 13:50:26 +0200
Message-Id: <20191016115026.1768745-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016115026.1768745-1-thierry.reding@gmail.com>
References: <20191016115026.1768745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
	iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

Page tables that reside in physical memory beyond the 4 GiB boundary are
currently not working properly. The reason is that when the physical
address for page directory entries is read, it gets truncated at 32 bits
and can cause crashes when passing that address to the DMA API.

Fix this by first casting the PDE value to a dma_addr_t and then using
the page frame number mask for the SMMU instance to mask out the invalid
bits, which are typically used for mapping attributes, etc.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 9425d01a95ac..63a147b623e6 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -159,9 +159,9 @@ static bool smmu_dma_addr_valid(struct tegra_smmu *smmu, dma_addr_t addr)
 	return (addr & smmu->pfn_mask) == addr;
 }
 
-static dma_addr_t smmu_pde_to_dma(u32 pde)
+static dma_addr_t smmu_pde_to_dma(struct tegra_smmu *smmu, u32 pde)
 {
-	return pde << 12;
+	return (dma_addr_t)(pde & smmu->pfn_mask) << 12;
 }
 
 static void smmu_flush_ptc_all(struct tegra_smmu *smmu)
@@ -554,6 +554,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 				  dma_addr_t *dmap)
 {
 	unsigned int pd_index = iova_pd_index(iova);
+	struct tegra_smmu *smmu = as->smmu;
 	struct page *pt_page;
 	u32 *pd;
 
@@ -562,7 +563,7 @@ static u32 *tegra_smmu_pte_lookup(struct tegra_smmu_as *as, unsigned long iova,
 		return NULL;
 
 	pd = page_address(as->pd);
-	*dmap = smmu_pde_to_dma(pd[pd_index]);
+	*dmap = smmu_pde_to_dma(smmu, pd[pd_index]);
 
 	return tegra_smmu_pte_offset(pt_page, iova);
 }
@@ -604,7 +605,7 @@ static u32 *as_get_pte(struct tegra_smmu_as *as, dma_addr_t iova,
 	} else {
 		u32 *pd = page_address(as->pd);
 
-		*dmap = smmu_pde_to_dma(pd[pde]);
+		*dmap = smmu_pde_to_dma(smmu, pd[pde]);
 	}
 
 	return tegra_smmu_pte_offset(as->pts[pde], iova);
@@ -629,7 +630,7 @@ static void tegra_smmu_pte_put_use(struct tegra_smmu_as *as, unsigned long iova)
 	if (--as->count[pde] == 0) {
 		struct tegra_smmu *smmu = as->smmu;
 		u32 *pd = page_address(as->pd);
-		dma_addr_t pte_dma = smmu_pde_to_dma(pd[pde]);
+		dma_addr_t pte_dma = smmu_pde_to_dma(smmu, pd[pde]);
 
 		tegra_smmu_set_pde(as, iova, 0);
 
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
