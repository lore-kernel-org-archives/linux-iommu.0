Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF575C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC092075A
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 07:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqFXSJCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC092075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1254E86D59;
	Fri, 11 Sep 2020 07:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mSnrOrXCoAUM; Fri, 11 Sep 2020 07:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0D32886AAA;
	Fri, 11 Sep 2020 07:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E495DC0052;
	Fri, 11 Sep 2020 07:19:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F1BC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A282087752
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9+qslmes9nF5 for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 92A378770E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 07:19:00 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id u3so1266713pjr.3
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cGYTBEv6g30jYHt4cdTq/c1g79ggDOFP0r3LMo62bBA=;
 b=gqFXSJCchjmN+3IhIFj8p5RjLbBWt/19Ys9tktWnFE1eEYnt5q5iGnWHNhTMks+iqK
 b0NCEBV+tmQh/qf0Vap62vKCEX4BiEdJqWk/0fNXjsQjtqoje3xQ8tD64tNaCXhJGZEN
 +PdbkA+U6zcv69VRmd5Y7nB1UikA1Yd7/vUljAwpV1R0Cav2OxkSBA368tZa0/2lPNBH
 cpdQxOFw5+M4+8hVmvzVLWDp45ldlx4Zinyz/n9mG+uxuZczKE7TAl2YH/nYwCxTUzH0
 TDMkdYhHqMfrLRfqNJDqx2Zs6T6lnF/3y3Lo5EB+kBffm4tefn7oUQtp/pO+/Poix78v
 CRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=cGYTBEv6g30jYHt4cdTq/c1g79ggDOFP0r3LMo62bBA=;
 b=C7KW7qU1KWTCKz5rrv74pstgk6IZkw1zPPJOs7wiW8lSs1q5qt13NpwB7WBN5bBTGj
 oAQivGKbbEiK3ExdJqmSchHR9sb/BGAnE9P5q7MS7X5rr96ugIxHFyGMNkoB4oiJl3qP
 5ERkEP6QOiLVaHMJ3eFw04kSwscgKOCG69jl/yv+iszPCGPDyeZHdMI8Yo8KFESrSDiH
 Ei4CbDvEVngOV2M8Xo0a9j3yQydYlWjFUuatju2KiN7G2lZyNzNfjEGsVPaOb+p3SF3T
 MJPTikVBcoEtRj7+KwCKou86spoJKqFNrjoWS31W7eP122uOPZqgKmCJW81W6jLlqsCA
 9tog==
X-Gm-Message-State: AOAM532hXGVoy55u2Hv2YyzCFn3Vt4NU4ozW9AG3RjdkhXJufwj/nfmS
 5+RncyNOE2T2B8xp1NUOg1IFKT4RKMU=
X-Google-Smtp-Source: ABdhPJysb3zMsd21LwFN+cGxUyxUozexoZzDRQwFqu8uNQaMf6bEjsdKUDDmuSmGaf7sFabYFoiIwA==
X-Received: by 2002:a17:90a:ea0c:: with SMTP id
 w12mr1003887pjy.65.1599808740186; 
 Fri, 11 Sep 2020 00:19:00 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 131sm1264692pfc.20.2020.09.11.00.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 00:18:59 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org,
	thierry.reding@gmail.com
Subject: [PATCH 2/3] iommu/tegra-smmu: Fix iova->phys translation
Date: Fri, 11 Sep 2020 00:16:42 -0700
Message-Id: <20200911071643.17212-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
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

IOVA might not be always 4KB aligned. So tegra_smmu_iova_to_phys
function needs to add on the lower 12-bit offset from input iova.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 789d21c01b77..50b962b0647e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -795,7 +795,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
 
 	pfn = *pte & as->smmu->pfn_mask;
 
-	return SMMU_PFN_PHYS(pfn);
+	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
 static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
