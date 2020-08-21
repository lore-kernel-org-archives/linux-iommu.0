Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE904C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A319E207DA
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pY2YbYHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A319E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66A8D883D7;
	Fri, 21 Aug 2020 13:16:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vys-fUeTxpKj; Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4F0E85933;
	Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADDB2C0890;
	Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0FCDC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 880FF85C11
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfLpQazmW-1s for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D0F9285FA6
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 13:16:15 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id o23so2257685ejr.1
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZnnZtMxmP4b7OMlDsIV6bQJbOj4fdGL8aaL1hhmjLLA=;
 b=pY2YbYHS5mikDdweoT7I0A6q9uT3ometn8FGbkCmiALLLRBZ7T5CUUIzOPSzePumsr
 5nVU/Of+D1O09VPiw+V19VBWqEeiR+ed6F2FuDNqj5OXZVpR1r7CKaXoH8BU2TGA//Mk
 REi4qfELDk/LPFv51pecAc0wLz0sjnbltg48c2UZ6oEGqEddU0eeHvEiktKMfM8CrXAR
 24BjGg9QPwJCXtKW16GNd3wBjTWgXDlouU7YYfmHXPSVH2UUgSKlFi6UCokoDcksLjeF
 CK67SeJGYmClge7RphPcpwaKaSeXvKeSAqpLlgFvQ5ACoV5W0wlnksDr2TVEpp4Owz1b
 j69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZnnZtMxmP4b7OMlDsIV6bQJbOj4fdGL8aaL1hhmjLLA=;
 b=P1F0UZDoGc1f/gm3AZi0cSozNC6x+4nVcdaROkMcGYBSjFU8IjW5hfury35Qai0xBh
 +LfQKr3L8tYPJQiwkhq+9FjkUYZnwurisv7DsaJk9QfefiVNOb/6fpInfCnpreeiT/mR
 6+V2ONIb16PfO9uey9BySPIDaLPvQLd4PfnOpr7ODy3hMJqfGR6FrVSVUk8vR0ulXNri
 jHgBSs0FNpBlb4dR0c8ZTGN2EqpgF+K5p3iHZ8ZZdzhyjOO/1JcFL7WrLos57MksHYRV
 YjX7WkJfX5x80DZwNwhggAVlkx0UDI7nqHECGw54s/mzVA52IBqhUfqOld1IXGnAwXnJ
 zcpQ==
X-Gm-Message-State: AOAM5339rxwEpup3EU/hiZAKV6BoL7Oy2wpxkk+KwqDBCYk03G2Kq+OY
 UVWJEhQkewipn7QFVcZlbv8oLw90TF79rALE
X-Google-Smtp-Source: ABdhPJzPzKZv0XqkxFhftdpeIsh87fWGpOtYot+rgSUcL/9LlvBX6pXEuFdZEBC/z0H9ehxzTOYJaw==
X-Received: by 2002:a17:906:e17:: with SMTP id
 l23mr2725404eji.13.1598015774044; 
 Fri, 21 Aug 2020 06:16:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 6/6] iommu/virtio: Enable x86 support
Date: Fri, 21 Aug 2020 15:15:40 +0200
Message-Id: <20200821131540.2801801-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, bhelgaas@google.com,
 jasowang@redhat.com
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

With the built-in topology description in place, x86 platforms can now
use the virtio-iommu.

Architectures that use the generic iommu_dma_ops should normally select
CONFIG_IOMMU_DMA themselves (from arch/*/Kconfig). Since not all x86
drivers have been converted yet, it's currently up to the IOMMU Kconfig
to select it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 98d28fdbc19a..d7cf158745eb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -383,8 +383,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA if X86
 	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
