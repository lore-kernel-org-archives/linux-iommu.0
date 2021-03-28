Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C0C433E8
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DC56193D
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DC56193D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9BB340366;
	Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7SY9Ynm2xxJC; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F110E40357;
	Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4596CC0032;
	Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6922EC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57AE0605BF
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UvFXfjUzKa-g for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:57:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BFDDB605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:57 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id h7so8243762qtx.3
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rk0U560xdi7ATXezYweBgD2EUyZ4bnHBlHOPTcEoREY=;
 b=ZLnI2Hw3GmiFb+BW4FldFixdVOm0/gTAYYcPGeNweT29zSncqaCxQl2ULX/m3x6yjk
 FlPvPCq6g1oh13jD6EQyG1JSSdz9G8bm3HGZ2akxZG2GJMQ9BC7QedLKEm34PtSwYA9Q
 9GLpxWPlLC/j45fuB1CB2u0k+GONoOh9eOlRvew+eCtM4IXd3/dem3muwmJ2LGUvv9pZ
 rKataNLRCg25wm/swBsArGMvPBDO2BXQknOCELLoUmLYNgIAwbOCOSxAGx2PbdugPEc1
 E84l/Bt6cNoKU6NHkm/vCejz/HyOc3AwND0Z16aeHxg7CDZpOR9OV5YCqN3yJaJzc09z
 OoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rk0U560xdi7ATXezYweBgD2EUyZ4bnHBlHOPTcEoREY=;
 b=H9JVBF4zZWiTrQHsUCnGgmtUYqkECzSotpqzutJsXhe0KShRFcVva3/+Aa5eWY2OJe
 XsluOzkvRuwbJR5kEduOEQUSH0/1WawtTm1d0Fs0Gv3TfunCte7xXGIR6AGoyHI/4eWZ
 cHBrFS433EciZojgl+AMW9foFv8/XUYhONmxpL+f0DcNBLunn7VgaPIBCASub2rBtE4N
 mpZ+WbFauEyq6EEwICKptMa7ioHlqh6aKMAoWiritrDHtHmUqPodpI5fh4ZqSljjYmlm
 /fuVcXxIymyMON5Z9Qs8voMy50FdfoupQSHq86RoHRJBIW7VVAWtRatqIl4nE0frFNEi
 BuGQ==
X-Gm-Message-State: AOAM532VRSWI4UM5eli0MBz5KR1lQqGXxk3txJA9tusR8dCQyYYnFubi
 JDkVS4uOISELws9He30IgWI=
X-Google-Smtp-Source: ABdhPJzfb/lAvD1VavVqudcTSNWwFXh9v8R3VckD2GeZAMNUEqCjOYPLz+1Z1e0dwqaRcAS+cSxIlw==
X-Received: by 2002:ac8:7e95:: with SMTP id w21mr19593417qtj.244.1616975876781; 
 Sun, 28 Mar 2021 16:57:56 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:56 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 24/30] Kconfig: Change Synopsys to Synopsis
Date: Mon, 29 Mar 2021 05:23:20 +0530
Message-Id: <1262e9e62498f961e5172205e66a9ef7c6f0f69d.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
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

s/Synopsys/Synopsis/  .....two different places.

..and for some unknown reason it introduce a empty line deleted and added
back.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0c2827fd8c19..30e8cc26f43b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -170,15 +170,15 @@ config DMA_SUN6I
 	  Support for the DMA engine first found in Allwinner A31 SoCs.

 config DW_AXI_DMAC
-	tristate "Synopsys DesignWare AXI DMA support"
+	tristate "Synopsis DesignWare AXI DMA support"
 	depends on OF || COMPILE_TEST
 	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-	  Enable support for Synopsys DesignWare AXI DMA controller.
+	  Enable support for Synopsis DesignWare AXI DMA controller.
 	  NOTE: This driver wasn't tested on 64 bit platform because
-	  of lack 64 bit platform with Synopsys DW AXI DMAC.
+	  of lack 64 bit platform with Synopsis DW AXI DMAC.

 config EP93XX_DMA
 	bool "Cirrus Logic EP93xx DMA support"
@@ -394,7 +394,7 @@ config MOXART_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
 	  Enable support for the MOXA ART SoC DMA controller.
-
+
 	  Say Y here if you enabled MMP ADMA, otherwise say N.

 config MPC512X_DMA
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
