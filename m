Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8E1C433EF
	for <iommu@archiver.kernel.org>; Fri,  7 Jan 2022 08:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D523A42487;
	Fri,  7 Jan 2022 08:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnmKvluTJ3iW; Fri,  7 Jan 2022 08:09:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A878400E5;
	Fri,  7 Jan 2022 08:09:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71C66C0030;
	Fri,  7 Jan 2022 08:09:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDCA4C001E
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 08:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACFC86FC45
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 08:09:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYFPUNMIy9xr for <iommu@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 08:09:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2985660DDF
 for <iommu@lists.linux-foundation.org>; Fri,  7 Jan 2022 08:09:22 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id i8so4833274pgt.13
 for <iommu@lists.linux-foundation.org>; Fri, 07 Jan 2022 00:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=caUCLOkN9Sm5eFbTFlsGP0xGxd9i8A6ITsUxSKuDZSU=;
 b=WY/WNVDa2zoOWuTB2YVH4wuHLFq2e9CIso+fXhU/yxNqPV9XnMLUs0wHbcAcoSC8Cp
 ZdE9df2U1E1PBq0RNLJpJ6dAN/1F5Eewfpu4jvb1CSBW6Casb7KuqLiuzl71lW+E7uPj
 GyXI6xs7CBcNKVp1afXOFx23kY9H74FmQyPeklWjevF6nv2LAuEtif3vAvHzUAL+ICE0
 VbjgqgbboWbi4SOZCWoVgDxGTsjYSAfBQOEMIETCvifmIyvbmrNto9X4ZV7AKafuExyM
 kkOibA2PXx04DdKwBSDZ1ZYVq/nIUk2FpDAqJ2NEjKU6qYlO7g/7M5AgML58mJDvEcWO
 0FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=caUCLOkN9Sm5eFbTFlsGP0xGxd9i8A6ITsUxSKuDZSU=;
 b=HW4eb11LgAXFdZ1tjoURECKq1Y1PPVoSO6JQTXwtw/Ts6mmAJgLBz6+W2MBFf7L2aj
 QU39sV2rKdUy047uTObpSTGjCvC80X8NSP0sbJSxvSp0j7Ul7nDinKCoUfSJ/MneQXHS
 H1Pjz8sJoNeilUbtNe0c8IUFNqqnTIRdoRYnCk2MzSMAEuScX/e8MKb4I58aAAWI9Jvl
 6uexIuWYqnK2p9GgJgCiT6YjCz9DjsB+CiyKvpFzdLgszaXDBwxudy5HFpFvnpvNudO+
 wF3KU0CRyfn9iD9QNbeItTs78wkAfFKpp6yqPOfmi9JIVAEeJjh1ePw1k8rqO/U7AXwx
 Ducw==
X-Gm-Message-State: AOAM533RvhaFyHJqNo9fiFnCap44kgKecrCFfXbBtKS13P3RszVkV42x
 o0GSnSEVSEgEbf6pdAfqveQ=
X-Google-Smtp-Source: ABdhPJzXiICbOdrKbRllujNfXHikmjg0aDAbByOyuYXvxpGswTzgKfpOmmbL0h/jbB/xfkqNf5bN9A==
X-Received: by 2002:a62:7813:0:b0:4ba:7afa:3786 with SMTP id
 t19-20020a627813000000b004ba7afa3786mr63360812pfc.55.1641542961614; 
 Fri, 07 Jan 2022 00:09:21 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
 by smtp.googlemail.com with ESMTPSA id il18sm8686899pjb.37.2022.01.07.00.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jan 2022 00:09:21 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: 
Subject: [PATCH] iommu/tegra-smmu: Fix missing put_device() call in
 tegra_smmu_find
Date: Fri,  7 Jan 2022 08:09:11 +0000
Message-Id: <20220107080915.12686-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linmq006@gmail.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: 765a9d1d02b2 ("iommu/tegra-smmu: Fix mc errors on tegra124-nyan")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e900e3c46903..2561ce8a2ce8 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -808,8 +808,10 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 		return NULL;
 
 	mc = platform_get_drvdata(pdev);
-	if (!mc)
+	if (!mc) {
+		put_device(&pdev->dev);
 		return NULL;
+	}
 
 	return mc->smmu;
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
