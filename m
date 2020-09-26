Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ADCC47426
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 08:12:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAC221D24
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmkUGQOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAC221D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1EEC986CB5;
	Sat, 26 Sep 2020 08:12:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7nWZoEScHQO; Sat, 26 Sep 2020 08:12:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 95E3D86CA1;
	Sat, 26 Sep 2020 08:12:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82E4EC0890;
	Sat, 26 Sep 2020 08:12:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BACCEC0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 08:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A985F874B2
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 08:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a7xkgFYg4nSt for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 08:12:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 36613874A7
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 08:12:31 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id c3so536351plz.5
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cQy5r4UWby+Vec3bHtXW3n4G3fBT+msNMsjI9PpDyho=;
 b=hmkUGQOxgKIIyd8RLw/iYtrNnngZVsFSDi3UNm49yNZvc9/e5SaLtgUORdlPu/tUrW
 WPVYP1/4TVOB3PvNL4ogHylbdwdIOrd/b99aYyaU8j+G5J/m+8L4Vi2AECD1elfyRnIV
 W+1bnmZNKiiLDkw6XWqRy16clWzv64ECP1J11No6VVt6XHEjlWTt8ChdqgFfn94U6VHI
 AzkNPal30me6t9+ZI1I6G/8VltIivzMCd2k/W859yV82tLJJslA5prJ6oglFzgPVvNFG
 yoKE+ruxqH54BTOKR6ZZFBcxNVs53OWovo8wstDioYEKZTRf4Mso9ZujbHQiCBVwnV+j
 HXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cQy5r4UWby+Vec3bHtXW3n4G3fBT+msNMsjI9PpDyho=;
 b=W8eH8HuD4fZYj/z6+Unc/b6QrTcjgX90Gl9DsaDf6DLl8D6RZbK2g+v2E4oTBXv2Op
 /augktGWtNVNlyeIOuVmHcisQgzz+EIFlXnksM/GgCLmkjpr0n5tSlUJOACtINsGBaNx
 6KSc4SHH8obEkVz1otIVwVH1BSD8olJFsnY3liEnE3kKeluHJV2N1rUXMrG5uaQcUl9n
 PuPZgwY7MVWybYSiO7MFE8tFs3X5XchHA7g2XuZVWD0IEB8Mq00696Iw1k7CDl/6haKQ
 N4mCsckZcVu+PVSTIFppi6rIMzTBtstAYhwEdch+8KlUKr820VgdWa9VgU0rqSyNnWEX
 /D1A==
X-Gm-Message-State: AOAM533AWN4cFccamR8R5qburOkXiFqrYw8uFpyp3laEN7+BgljUzal+
 7SHyrpfLCxYQp2JzU03Pf85ZV9WAaJ4=
X-Google-Smtp-Source: ABdhPJzPsRm9Rhazt7BinH4NVa9O18uaL9DvZqntqAKhVGdEb1LQI9AysWQn9R25hWM3cMtqpMTQVw==
X-Received: by 2002:a17:902:b7c4:b029:d2:173:34ba with SMTP id
 v4-20020a170902b7c4b02900d2017334bamr3029562plz.57.1601107950759; 
 Sat, 26 Sep 2020 01:12:30 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i1sm4833497pfk.21.2020.09.26.01.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 01:12:30 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	krzk@kernel.org
Subject: [PATCH 2/5] iommu/tegra-smmu: Expend mutex protection range
Date: Sat, 26 Sep 2020 01:07:16 -0700
Message-Id: <20200926080719.6822-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926080719.6822-1-nicoleotsuka@gmail.com>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

This is used to protect potential race condition at use_count.
since probes of client drivers, calling attach_dev(), may run
concurrently.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6335285dc373..b10e02073610 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -256,26 +256,19 @@ static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
 {
 	unsigned long id;
 
-	mutex_lock(&smmu->lock);
-
 	id = find_first_zero_bit(smmu->asids, smmu->soc->num_asids);
-	if (id >= smmu->soc->num_asids) {
-		mutex_unlock(&smmu->lock);
+	if (id >= smmu->soc->num_asids)
 		return -ENOSPC;
-	}
 
 	set_bit(id, smmu->asids);
 	*idp = id;
 
-	mutex_unlock(&smmu->lock);
 	return 0;
 }
 
 static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 {
-	mutex_lock(&smmu->lock);
 	clear_bit(id, smmu->asids);
-	mutex_unlock(&smmu->lock);
 }
 
 static bool tegra_smmu_capable(enum iommu_cap cap)
@@ -420,17 +413,21 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as)
 {
 	u32 value;
-	int err;
+	int err = 0;
+
+	mutex_lock(&smmu->lock);
 
 	if (as->use_count > 0) {
 		as->use_count++;
-		return 0;
+		goto err_unlock;
 	}
 
 	as->pd_dma = dma_map_page(smmu->dev, as->pd, 0, SMMU_SIZE_PD,
 				  DMA_TO_DEVICE);
-	if (dma_mapping_error(smmu->dev, as->pd_dma))
-		return -ENOMEM;
+	if (dma_mapping_error(smmu->dev, as->pd_dma)) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
 
 	/* We can't handle 64-bit DMA addresses */
 	if (!smmu_dma_addr_valid(smmu, as->pd_dma)) {
@@ -453,24 +450,35 @@ static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 	as->smmu = smmu;
 	as->use_count++;
 
+	mutex_unlock(&smmu->lock);
+
 	return 0;
 
 err_unmap:
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
+err_unlock:
+	mutex_unlock(&smmu->lock);
+
 	return err;
 }
 
 static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 				    struct tegra_smmu_as *as)
 {
-	if (--as->use_count > 0)
+	mutex_lock(&smmu->lock);
+
+	if (--as->use_count > 0) {
+		mutex_unlock(&smmu->lock);
 		return;
+	}
 
 	tegra_smmu_free_asid(smmu, as->id);
 
 	dma_unmap_page(smmu->dev, as->pd_dma, SMMU_SIZE_PD, DMA_TO_DEVICE);
 
 	as->smmu = NULL;
+
+	mutex_unlock(&smmu->lock);
 }
 
 static int tegra_smmu_attach_dev(struct iommu_domain *domain,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
