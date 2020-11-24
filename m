Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D87DC2D0E4
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 17:07:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A793120897
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 17:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A793120897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3223E8687D;
	Tue, 24 Nov 2020 17:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CTsw9fZWST5c; Tue, 24 Nov 2020 17:07:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E67A8685A;
	Tue, 24 Nov 2020 17:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BE5AC1DA1;
	Tue, 24 Nov 2020 17:07:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BCDEC1D9F;
 Tue, 24 Nov 2020 17:07:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4F686214EC;
 Tue, 24 Nov 2020 17:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1cmWTx33Ysd; Tue, 24 Nov 2020 17:07:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 51F172039C;
 Tue, 24 Nov 2020 17:07:53 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a186so3065739wme.1;
 Tue, 24 Nov 2020 09:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y+NYsCm9tGc6GjBoEZ7bi5tfuxFZISDvGMwp4S/BObI=;
 b=AAJfzu3V6FUGcK1GonoT/5BG4tOyEKxvcBQ031t8ayzdVS9vWY53rs2Y6XO+BgHTOe
 ZashN9hp6OSfRBtENLydIdP+2GSJxO5+i/1uXywpVcBvNlEfq5Bsuff9/00aBC3nm/no
 3NN4cVBW60Qksmhl5Jv/bPrM+EWl3OM+CB30EBaZby05VW7jiwWylTUS4L0bH6hGk4z4
 vDALQCsuF34gqGa06c+DbQancO7zQTLMhGX0Sk9aXDcazC6mqk3GEFM/9ekSnzOSrSg/
 mVhEiRmrc2gcYMLReDODQKIQaBtaCqxhXlOggv0evlCiTNlQju2SALMe5gU78W+BI2xi
 ekIw==
X-Gm-Message-State: AOAM531/gmEvsoGbiXQIoIF84cjD7ckE13SZoKIBMzPendoC0s2vONCt
 Vt+cuS/1f04Rz8bWpohPZbQ=
X-Google-Smtp-Source: ABdhPJyRy4oNI+baboiLauOZ5kuNcIz+UESSkuC95WYwMV/AE323XjTDVKemQQJZv331EIMXSitBHg==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr5780733wma.154.1606237671954; 
 Tue, 24 Nov 2020 09:07:51 -0800 (PST)
Received: from
 liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net
 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 09:07:51 -0800 (PST)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [PATCH v3 04/17] iommu/hyperv: don't setup IRQ remapping when running
 as root
Date: Tue, 24 Nov 2020 17:07:31 +0000
Message-Id: <20201124170744.112180-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
MIME-Version: 1.0
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
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

The IOMMU code needs more work. We're sure for now the IRQ remapping
hooks are not applicable when Linux is the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/iommu/hyperv-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e09e2d734c57..8d3ce3add57d 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -20,6 +20,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
 
 #include "irq_remapping.h"
 
@@ -143,7 +144,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 	int i;
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
-	    !x2apic_supported())
+	    !x2apic_supported() || hv_root_partition)
 		return -ENODEV;
 
 	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
