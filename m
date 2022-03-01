Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5480DC43217
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 16:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E445160597;
	Tue,  1 Mar 2022 16:15:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3yt2lNsdMvJ; Tue,  1 Mar 2022 16:15:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9D6960E56;
	Tue,  1 Mar 2022 16:15:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA767C0033;
	Tue,  1 Mar 2022 16:15:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAA6BC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 16:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3BBC60E88
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 16:15:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9m9HpmLFuUiu for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 16:15:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2BEC60E56
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fQVo6iZ7pveZxOBVzKe3P9Mw1wzg2DyXVZs1ygpYCyU=; b=ABx4PzxJM+FAu+IX54XDrU8hOW
 X2dYxId2fXOaqFsVt3mQ48WENtcz2Pqong2poL3JoU24dlfvMv3JK/27iQ57QVtssbIvkcT/zdqVo
 e3oXn4i5+6rTC9hT0auzJ4opFac/Lu9ckHUm2zum0b57zgHKyXPDSJPYgyaeSpa3bSIe7r/L8kpUK
 VrFHZ6iUQcXth12Mx054dgseyeKYt7cqyRNEP1+8sHQBfV9nZ+JXmZLfr4bdE+NqlJPvxf3/o2xia
 9RdXIZVpHdrADlrU69aq5F3+HsSABojbDtyq8L1vVmliDpZq10MfWWc7W4iOLiKJJVH5XEJEgHAQu
 knG0FvUg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <cyndis@kapsi.fi>)
 id 1nP59r-0003Z8-11; Tue, 01 Mar 2022 18:15:27 +0200
From: cyndis@kapsi.fi
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v4 5/9] iommu/arm-smmu: Attach to host1x context device bus
Date: Tue,  1 Mar 2022 18:14:51 +0200
Message-Id: <20220301161455.4037062-6-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220301161455.4037062-1-cyndis@kapsi.fi>
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
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
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4bc75c4ce402..23082675d542 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -39,6 +39,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/fsl/mc.h>
+#include <linux/host1x_context_bus.h>
 
 #include "arm-smmu.h"
 
@@ -2051,8 +2052,20 @@ static int arm_smmu_bus_init(struct iommu_ops *ops)
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
2.35.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
