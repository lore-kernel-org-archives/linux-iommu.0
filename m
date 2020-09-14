Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FEAC43461
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 11:28:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B123921973
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 11:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B123921973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4E9E5204DC;
	Mon, 14 Sep 2020 11:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUcx+X2ae8R0; Mon, 14 Sep 2020 11:28:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 39541203B4;
	Mon, 14 Sep 2020 11:28:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E426CC08A2;
	Mon, 14 Sep 2020 11:28:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F1F7C0859;
 Mon, 14 Sep 2020 11:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 47860870E2;
 Mon, 14 Sep 2020 11:28:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Au7qqXhHeH3v; Mon, 14 Sep 2020 11:28:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DC986870BA;
 Mon, 14 Sep 2020 11:28:15 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id d4so4897749wmd.5;
 Mon, 14 Sep 2020 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5v500JUZm9W3PLeTFD54h3IRmGCm5u9hSoivPSmRPeA=;
 b=TGV4iSUzqpHDfqibkBpw5D/wUifFd0yGnNGiHmCG1B7LPGIUOoNpyRqL8+UltWTJCc
 CoqKdmtIoO90AEQjXKCbXYEv+Qr9LWC7lRI6cQ6QOqdKfZ1W2siFPBU5D8HWtHDl0Pg9
 Px1CuLVo6hBAOVqeCtzSyjn+AGL361jNqb6/MGSdIBm+oKSUHWz4Vi3ZxGHA1PzeOo3O
 eWTvxfokj/raRjKUACud6osB/rOtA5hS2Fi7X+5Pt5f0bEWsdMKmrR5uWslcTY8jQ5q4
 yxvvkmKYPAyMPlx6OtFCADs9bfIjzpt3YozrQ/LaDFnzpLnFjP+pMF/jiF0FzA5A6sR1
 mZJg==
X-Gm-Message-State: AOAM530Guu5WJnH+ztWmoKb0UTX/GIOieKLE1XLFTwfYelAN0iMuekAM
 M+x17Qr8SizW7CTddDUt3Gg=
X-Google-Smtp-Source: ABdhPJyUdJukSZQy+o144Nuc5JlcCGIDb5NRAgTLHhy3hhKD/5DE2/RETjp2sTOsMtnSstmDqgdghA==
X-Received: by 2002:a1c:a551:: with SMTP id o78mr3264122wme.4.1600082894396;
 Mon, 14 Sep 2020 04:28:14 -0700 (PDT)
Received: from
 liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net
 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 04:28:14 -0700 (PDT)
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [PATCH RFC v1 04/18] iommu/hyperv: don't setup IRQ remapping when
 running as root
Date: Mon, 14 Sep 2020 11:27:48 +0000
Message-Id: <20200914112802.80611-5-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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
hooks are not applicable when Linux is the root.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/iommu/hyperv-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 8919c1c70b68..4da684ab292c 100644
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
