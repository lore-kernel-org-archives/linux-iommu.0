Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB52CCA483
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 15:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14D4E4090D;
	Tue, 21 Jun 2022 15:11:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14D4E4090D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.a=rsa-sha256 header.s=20161220 header.b=LwXMf7kC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GzgFCgTKr5ln; Tue, 21 Jun 2022 15:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CDD30404E0;
	Tue, 21 Jun 2022 15:10:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDD30404E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3019AC0083;
	Tue, 21 Jun 2022 15:10:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6544C0039
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0D68404E5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0D68404E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tyNEggXX92xQ for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:10:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7DCDA404E0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DCDA404E0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tEnOk0m5EknjIwP5Wi5D0MEtwLqTocqed5XbSC4LxPw=; b=LwXMf7kCx1x5kbVqzdYdMTq38K
 f+cCCGgkMs3+BHcjuFfUe8OUdDVazudyC9arQ/xcBQOI43kSYZStulXJdpyEI9fg8EDHtaZM6PThV
 KXVQC/bofdmiJZKIntRayin8L0K8j4ZQ0Co+BdgkGV18mr+PfExFqsqroI3lzcnWY9yLWMaqnXtkf
 nm8IpLWvukhQQLWftyEvFxPH/aaCiYR5c/6/hcFgfGGD3V8iP5wsq0PpzjAaa9Qjo92ZZ5NmLaflA
 KXsWz48v2qqxXWEyU4D1oO3ti6ZPGEHBbzI46Wkqh3IR+dDBMBJ2I9yDcmac/7xEJNkLmWQrnuqSh
 IV2oXPuA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain) by mail.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <cyndis@kapsi.fi>)
 id 1o3fWT-00Ea3F-Ib; Tue, 21 Jun 2022 18:10:33 +0300
From: Mikko Perttunen <cyndis@kapsi.fi>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v6 01/10] iommu/arm-smmu: Attach to host1x context device bus
Date: Tue, 21 Jun 2022 18:10:13 +0300
Message-Id: <20220621151022.1416300-2-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621151022.1416300-1-cyndis@kapsi.fi>
References: <20220621151022.1416300-1-cyndis@kapsi.fi>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

From: Mikko Perttunen <mperttunen@nvidia.com>

Set itself as the IOMMU for the host1x context device bus, containing
"dummy" devices used for Host1x context isolation.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
This patch should only be applied if Robin Murphy's IOMMU bus
refactoring series doesn't get merged in time.
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ed3594f384e..74c4357f850b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -39,6 +39,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/fsl/mc.h>
+#include <linux/host1x_context_bus.h>
 
 #include "arm-smmu.h"
 
@@ -2056,8 +2057,20 @@ static int arm_smmu_bus_init(struct iommu_ops *ops)
 			goto err_reset_pci_ops;
 	}
 #endif
+#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
+	if (!iommu_present(&host1x_context_device_bus_type)) {
+		err = bus_set_iommu(&host1x_context_device_bus_type, ops);
+		if (err)
+			goto err_reset_fsl_mc_ops;
+	}
+#endif
+
 	return 0;
 
+err_reset_fsl_mc_ops: __maybe_unused;
+#ifdef CONFIG_FSL_MC_BUS
+	bus_set_iommu(&fsl_mc_bus_type, NULL);
+#endif
 err_reset_pci_ops: __maybe_unused;
 #ifdef CONFIG_PCI
 	bus_set_iommu(&pci_bus_type, NULL);
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
