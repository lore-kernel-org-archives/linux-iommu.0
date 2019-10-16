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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B27FA3728
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 11:50:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC4620854
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 11:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYpVk/Vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC4620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF9F1D13;
	Wed, 16 Oct 2019 11:50:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 274EDD0A
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 11:50:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 941BC70D
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 11:50:30 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j18so27671706wrq.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2AlPPBm4srKsAvpAcC+NwwAp6Rz/P7KMIyX2GM7hrRY=;
	b=HYpVk/VkIkhePa3U+OtGXpH89MDVJBwhV1l2OmFTM4UHRDyQHlxQ6qehExDezlPp8I
	jZilnoimIbQ51Mg5B9RXAwV/KcUD/JrjaZ/qPzL0ZdkSksavFkNUY2Uh8vZ+uK8yicKI
	ACXCEbZ5N5jmmr+R8/nwOjXuE2nGFoSSanqU5GVZws85tuAIPrHyypIYJL5mCjSyvrr2
	nskk8m9apb/hM8hDTUM2erE4CxxyI/Cu5Ds+AeSe5/Ehx3CKpQHNazN/FIr4uonI3+3l
	Asu3Eta4+w/fYZ4lu0Gz3YxdHry7D673L8vlqO3qnHDijdCTpJe/gd3ZbE7bEpFfnlhR
	EbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=2AlPPBm4srKsAvpAcC+NwwAp6Rz/P7KMIyX2GM7hrRY=;
	b=MrOt5grOLJGjJrvybOxeyPzwSbWMzSYNptrglKUdjNI/isml9LSqLaHKjSeZySONN+
	IKXJm8I5ivNOBodsLhvEndPRxEYdbAo9Q2VqWGts49GZiEIPsEyooPbSEUrpufMs08lD
	PZzI1oBkNb46Mx90PEBOQ3V0D3x3mA2IBArfx2R4cLf63tHSJTOd85YkFSFGCKu0leLF
	daiZAyiWVCy2vDrBGyLgsb7l3ogvX4hmLclz2NaPC6yW5INAu5WKvaghAiHhwF828+mB
	jIVXfWnHGDXvA7Lz2YjQX1WDmpthT4ae0XwS+Bs9K5wYbF2CobbRwa7OxJ4JpmZJCN/Q
	ZJqw==
X-Gm-Message-State: APjAAAXcdkQbNtsr0ka3PyQWpdj7Shq/HfGGALG17kr95MZ2sK0U6/hk
	+zYePNTcm89LQKRZGJTVSbk=
X-Google-Smtp-Source: APXvYqwSzNMdMd6jpDsyZY8yAC0uEwWQnLuosqnZfhIyJs9nvKRQZ5bDaDIHzz7HBpsSDwbbIiuW2A==
X-Received: by 2002:adf:f547:: with SMTP id j7mr2529411wrp.26.1571226629070;
	Wed, 16 Oct 2019 04:50:29 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
	by smtp.gmail.com with ESMTPSA id
	n7sm27110235wrt.59.2019.10.16.04.50.27
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 16 Oct 2019 04:50:27 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] iommu/tegra-smmu: Use non-secure register for flushing
Date: Wed, 16 Oct 2019 13:50:24 +0200
Message-Id: <20191016115026.1768745-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
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

From: Navneet Kumar <navneetk@nvidia.com>

Use PTB_ASID instead of SMMU_CONFIG to flush smmu.
PTB_ASID can be accessed from non-secure mode, SMMU_CONFIG cannot be.
Using SMMU_CONFIG could pose a problem when kernel doesn't have secure
mode access enabled from boot.

Signed-off-by: Navneet Kumar <navneetk@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 99f85fb5a704..03e667480ec6 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -240,7 +240,7 @@ static inline void smmu_flush_tlb_group(struct tegra_smmu *smmu,
 
 static inline void smmu_flush(struct tegra_smmu *smmu)
 {
-	smmu_readl(smmu, SMMU_CONFIG);
+	smmu_readl(smmu, SMMU_PTB_ASID);
 }
 
 static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
