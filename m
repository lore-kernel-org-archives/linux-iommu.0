Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114CCC433DB
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 20:34:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98BFC2313E
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 20:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BFC2313E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3931B8691C;
	Wed,  6 Jan 2021 20:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QZNDOba1AsM3; Wed,  6 Jan 2021 20:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B228786916;
	Wed,  6 Jan 2021 20:34:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB66EC0891;
	Wed,  6 Jan 2021 20:34:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67049C0891;
 Wed,  6 Jan 2021 20:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 55B2A873D4;
 Wed,  6 Jan 2021 20:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fCt5T7c7d7v; Wed,  6 Jan 2021 20:33:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D2CB4873CE;
 Wed,  6 Jan 2021 20:33:58 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id i9so3592326wrc.4;
 Wed, 06 Jan 2021 12:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iQMtgq3pUcrjj3NVCdkiQSStjiewGBjHdwkFAPCFR6A=;
 b=PFi8r3lV43CTYSgwKLbPbaLJ67V3TAW450IJDLOqhOlHJiyveD1HkfWvytDWmRjM5k
 DbroOPErv9QVOoyj40eNmXhKJMPMvxtTUlIQNsPimLjb85MnpAz9fkYEnS7sGdPTClYT
 oImqLKcuXA7sqL1MTV+t8GFdG+5NAUGrn3IkWg51Kce1CIT96uRGg14aX68QlmS39n44
 BWmTPWH43VHazQ9A0W+O+cHrxw376mFThDF18TdfuDxM7db67hi/XPIhzG6PqikcO6fs
 1ey1i0TYiMdthQz8ZNoz5jIRJXs6sN2bujj0IgaHFWJEjB4Rr6iCUHqHn4jTkpAxDCNa
 rl9Q==
X-Gm-Message-State: AOAM530xP0rc5/229dqUs2hdHnnJe/SxyE5IjPmCDFfSR/hXjPwEmqWu
 Bikup8hHu/lQvXP6gKwobQtoYyN+Xzk=
X-Google-Smtp-Source: ABdhPJzua7u0Xi2cAQqaPz7tdaucPPPz5eFSOQ1Ul7ScWmk7+7JzInjstK7tIJXCPKNakTqmjaYS+A==
X-Received: by 2002:adf:a495:: with SMTP id g21mr6160651wrb.198.1609965237426; 
 Wed, 06 Jan 2021 12:33:57 -0800 (PST)
Received: from
 liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net
 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Jan 2021 12:33:57 -0800 (PST)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [PATCH v4 04/17] iommu/hyperv: don't setup IRQ remapping when running
 as root
Date: Wed,  6 Jan 2021 20:33:37 +0000
Message-Id: <20210106203350.14568-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
MIME-Version: 1.0
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Stephen Hemminger <sthemmin@microsoft.com>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
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
index 1d21a0b5f724..b7db6024e65c 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -20,6 +20,7 @@
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
 #include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
 
 #include "irq_remapping.h"
 
@@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
 
 	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
 	    x86_init.hyper.msi_ext_dest_id() ||
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
