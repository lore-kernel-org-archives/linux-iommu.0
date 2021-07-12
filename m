Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF06EC07E96
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 00:14:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DDC61042
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 00:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DDC61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0956160707;
	Mon, 12 Jul 2021 00:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6pZrU19CXrqi; Mon, 12 Jul 2021 00:14:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC32E605E8;
	Mon, 12 Jul 2021 00:14:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6916C0010;
	Mon, 12 Jul 2021 00:14:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E14AC000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 00:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4730060690
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 00:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BU0Yb-Pc_L22 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 00:14:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4FC8605E8
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 00:14:40 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id i4so7207118qvq.10
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 17:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cbWrCRAXNKnrsAOs9jzjwaP+o7LOU1NoMDrvo6psqh0=;
 b=pcZhmUBcBartxQVH+z7tpAIZMC86HC+ySHISakIRBBaS3KGUJa+s9ghxKBdpT3cesy
 LaKgepCTVBG43f87Q5L7av2e1NvU43Ui0UtZSSwGOIkiuxunRYGoitmjF+Q8fyPB7F9F
 G6S2trIQ8lVL1wploYqYw6O1vSea0sQXACuZBcd91DrQLo+ygk6V4DGlxpHX1TWpnFYM
 FzQrhG020laUrHf6orAxZWFOduVXCsGpxcGYlF0qDatd75s0qZwNyK5ROHlCcB75D225
 uk5HVuwBS1XGf5dzg7pzOlHN9iQZy0ehNZWwlTBnrGsuhpVgrJlltmJyCJAhYHPkgTjg
 rMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cbWrCRAXNKnrsAOs9jzjwaP+o7LOU1NoMDrvo6psqh0=;
 b=eAe+XFYqd/xWyLe+8Ql3i0CMLM204ds007qO0ANZj8Z6gXknRKRwL/d6YY6yewjy/9
 DiWjCsXjJgTqOggc31d0hP3RvK28xoO3ZXByceZyeVBnuQhLy9RMkubN/Ar/C/DJDXol
 qQHL8mHn5zNqapDejkSdpAZKl5wRKPHF026wG+mU5vtH1hj36F0oiPOEmskNPaUH+2Vn
 rothoaHmYIqiKScbhyXSVjXMvuweo0k9UzPwq09vDVuZ3sTRtOUUI1lr6I5/JRiG0fk3
 D86FcyyCw29S5eMgiiUwap6JsFequmG/nMMTr1liAVUATrcVvJ2v6efoe+Mmx16IzOcT
 C1gw==
X-Gm-Message-State: AOAM531losZIjijbQl9Tj0rRsm+yWkdSRxdiTYvZEguPejxYHyoQdloH
 1QdOnWE3Qi/Luidolhq3/2A=
X-Google-Smtp-Source: ABdhPJxOe5ByYnSBkxL9fC/fx33DHCY7UT7W1x8vp0k92vpxW0k3wg+UPpWI9Vis/OijUYmVaG97+Q==
X-Received: by 2002:a0c:9e6a:: with SMTP id z42mr34205762qve.37.1626048879641; 
 Sun, 11 Jul 2021 17:14:39 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru.
 [94.29.37.113])
 by smtp.gmail.com with ESMTPSA id b5sm687481qtk.46.2021.07.11.17.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jul 2021 17:14:39 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH v1] iommu/tegra-smmu: Change debugfs directory name
Date: Mon, 12 Jul 2021 03:13:41 +0300
Message-Id: <20210712001341.11166-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
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

Change debugfs directory name to "smmu", which is a much more obvious name
than the generic name of the memory controller device-tree node.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0a281833f611..093c270b9245 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1141,7 +1141,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	tegra_smmu_ahb_enable();
 
-	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, dev_name(dev));
+	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, "smmu");
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
