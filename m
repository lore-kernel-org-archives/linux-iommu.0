Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B71BC433F5
	for <iommu@archiver.kernel.org>; Fri, 26 Nov 2021 12:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03C42605E2;
	Fri, 26 Nov 2021 12:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ta8KBn5ZGwAT; Fri, 26 Nov 2021 12:02:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 046D46071D;
	Fri, 26 Nov 2021 12:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4856C001E;
	Fri, 26 Nov 2021 12:02:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E03DC000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 02:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24B7240335
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 02:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SplspC8qvn7G for <iommu@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:47:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68D7040012
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 02:47:41 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id k4so5727128plx.8
 for <iommu@lists.linux-foundation.org>; Thu, 25 Nov 2021 18:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N2rR2M205RaoXv2F1eYgORsUa0WkEJokTNFyh0m1jbQ=;
 b=G2bPd47mof2kPWU7wel0/tp2qN5l0O1ock7AVXOCjPcUgfdz+VGKWkXiYcX9y1PbIN
 Uvx3tGvdiFsjdWcDUHq3iDhH1az6OWWLRddAnuGMRXuAQjASQdHm0ixSfecMUpL9le/f
 eTADybm0qsmMMNVCByp9gq7imYV3VqBKjQnhY0tHT+6qwCx8XaUXkvRuey9ymCNi0yau
 WoLtDhIwjwasn2UdJ3wxPeYWjNgn2rqVtt87k79XaOwIYg6V+MpeZQfne8XEZGhAs8qK
 uIbwyrBUBzoVG2kLvZH+NxhP6qMXM6q23hqGf/n2i4+UUUlxzn35ojINybmpkkIdY6PH
 B+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N2rR2M205RaoXv2F1eYgORsUa0WkEJokTNFyh0m1jbQ=;
 b=VmPXqiySQwkyloNpay+FfDRqQlo/3W6goYG2WLvIn2xrD3LTcNAm7gCxfDcB8KbfOc
 8CAqhIcUtdy3yiD00oL9s6purbPf9KpbOGxPcXu87dCDJajvFTMw0AX4763gL6BgjrKa
 TxbJRtzJp7lz8UUApoVWJ1E88NPB5p+p/Ke3KHVjdzPoshWeySVbZh2j9dntxiS/81jm
 XhGcJKeJr4tybZR2dZ46NcIWgXKrc17yVuOrzuaYD7ZKvWOsm/N7rowYjItcD1F5xUFT
 /SXUwzRsc0eArB/MIGG7AzfCcAh5xh/Nf5g6bVQF0yUeBpwoLIA54Gydo7dzjVfUQRXf
 EKew==
X-Gm-Message-State: AOAM533OVBujV56bJYrdjH7Uo6wo6yrAwU0WL9yrS4bI8OLWsZaxE0tM
 hWYom+FeC1+qBuKbhaeYlec=
X-Google-Smtp-Source: ABdhPJx1btLLTBXEFgpXDPhTCJScji/umzB55h96FNh8lq7mlIt4d/IQDK9YMn2EtbU9mBvwLvrqGg==
X-Received: by 2002:a17:902:ab94:b0:143:beb5:b6a7 with SMTP id
 f20-20020a170902ab9400b00143beb5b6a7mr36447789plr.30.1637894860877; 
 Thu, 25 Nov 2021 18:47:40 -0800 (PST)
Received: from localhost.localdomain ([103.99.179.247])
 by smtp.gmail.com with ESMTPSA id k14sm4814513pff.6.2021.11.25.18.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 18:47:40 -0800 (PST)
From: Calvin Zhang <calvinzhang.cool@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Date: Fri, 26 Nov 2021 10:47:11 +0800
Message-Id: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 26 Nov 2021 12:02:34 +0000
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Calvin Zhang <calvinzhang.cool@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
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

Just like this:
commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").

Add kmemleak_ignore_phys() for CMA created from of reserved node.

Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
---
 kernel/dma/contiguous.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5c..66bd9a59615e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -50,6 +50,7 @@
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
+#include <linux/kmemleak.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -426,6 +427,9 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
+
+	kmemleak_ignore_phys(rmem->base);
+
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
