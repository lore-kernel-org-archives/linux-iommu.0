Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04369C43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 12:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A059861067;
	Tue,  5 Jul 2022 12:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A059861067
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oEUGLjgU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MIW_NA-ep_bE; Tue,  5 Jul 2022 12:58:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F6E260EAB;
	Tue,  5 Jul 2022 12:58:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F6E260EAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE03C0032;
	Tue,  5 Jul 2022 12:58:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07B3EC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3E284087B
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3E284087B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=oEUGLjgU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hgYPgScgcEnT for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 12:58:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 770B140873
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 770B140873
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 12:58:45 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id z41so15201131ede.1
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K8sz6qEujOk4h013kpPVYfRwZBm/BZHYeZBvWv+Q0zw=;
 b=oEUGLjgUVdWwQ8k+Y2aWyvkFjYZ3FREb6j09KGl8Jx14hqcpyFxW6LE9IUy+chauBa
 pottkoAMu9N5SPumEiE1VbDjcFglEgUgHw4KTk5kkFZ06APNckDvsEX/as07RfYHxrjY
 ydbwBesiWVEr49nkouXPKAgE+3LcHXjs9E6OGOMWhb7udusNFp2uWfwu/4tF8hNgX1Hv
 rLGVWnkpyJymnmZf7aq1AcUGx0MkkWjn1YRRoYNWPsrFO1djf3UkjvKocWhEsuodP9Al
 tzNpzhT7WncOiXk+7E/3VhYWsn3jP6orS4gpnkktdt3VlZnSm1MeZc4w79wOV/Bwlljf
 MTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K8sz6qEujOk4h013kpPVYfRwZBm/BZHYeZBvWv+Q0zw=;
 b=7TbVGJhNpOaGv63GcLBl04HXkQoie29XsE+642teDYEj3eQNn5/ZZMeTvhdzo7JnJW
 8WqmGLOiCE7hO9z/bM+4NtBVnKbhiPrk9yVAsVAC49hpEW1ZRpuV6FrhcT22L0PT4PYU
 SYAi1mbr4rNhnYYzgmU4qpH5djiA65i/vRtLZR07J2WDUFQxQtfQmIhkRNvXOG/wqalX
 mZmmnWqvj9xBp2AU0IS35cNDijl5EqTN7hFXLDDPnZWMbxxnTQa5UYzWpn3XG5rACPS8
 nSBuPAKc/gGtzQQIyzB1qIrdz+Vs5Nz6LAJb7ysd/pp0zMSc1r5EcKsiQPDfJmonVdOJ
 1Hiw==
X-Gm-Message-State: AJIora9I0/yXg421WSJxrIgmb2ElWW8rX0rBB7SukmfznZUmvnwPflKP
 3+a0PQNjvqFte1QR33cU2AM=
X-Google-Smtp-Source: AGRyM1upns2GtVrLDYg10SyzedcRjRBfIM0zN31nsHmp+MMQ26hybeFXZC6J46sU0RG6V0NzTHIX/w==
X-Received: by 2002:a05:6402:26d6:b0:435:ba41:dbb0 with SMTP id
 x22-20020a05640226d600b00435ba41dbb0mr46048821edd.242.1657025924863; 
 Tue, 05 Jul 2022 05:58:44 -0700 (PDT)
Received: from localhost
 (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 eg37-20020a05640228a500b0043a587eb95dsm4535515edb.5.2022.07.05.05.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 05:58:43 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 3/5] iommu: dma: Use of_iommu_get_resv_regions()
Date: Tue,  5 Jul 2022 14:58:32 +0200
Message-Id: <20220705125834.431711-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705125834.431711-1-thierry.reding@gmail.com>
References: <20220705125834.431711-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Will Deacon <will@kernel.org>, Sameer Pujar <spujar@nvidia.com>,
 iommu@lists.linux-foundation.org,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, linux-tegra@vger.kernel.org,
 Janne Grunau <j@jannau.net>, Robin Murphy <robin.murphy@arm.com>,
 asahi@lists.linux.dev
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

From: Thierry Reding <treding@nvidia.com>

For device tree nodes, use the standard of_iommu_get_resv_regions()
implementation to obtain the reserved memory regions associated with a
device.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1910f4f1612b..84fad59bc789 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,6 +23,7 @@
 #include <linux/list_sort.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -389,6 +390,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
