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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E23C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B666861938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B666861938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 698DD83979;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r0w6_eC7_utf; Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39952838FB;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D94FC000B;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AFC1C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DAEF605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z2GAvpTQOEjV for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9006605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:13 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id y5so10918639qkl.9
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QaFxE7xJjw3q1QRzUlhL9vl2FAXABYAZdUNglx88dWM=;
 b=jp01Oafr+FYiNYOySvz698WmMQzo+I8B2paqvCFTlCTqcAAL37CMJwgpqQlkW5GHW2
 Dyvbvs+rlqMjPWQuuNHQDuAQ6uVGfCqAuD3H7xHGEPAJOWcAGOy/DrtrhvXYWLU0436d
 lVRkCgJp9jS4fhNJ0qaUC4akHDDGxNg25koKauz70I2VYZQOmotGc6b2/KGof4mKY6LW
 1TzvIv956J7EIBeJBzXRcahb54ThW1Yu5eyDfY18Lpqxxr6dAulMcI1wQw2QFXiQ3c2q
 Ui+ZEYtPOnzUjWjCc71Rex7kRCtuOwcEjgmEOD0DPvlk4vA+pudWfMcYnjP5m3D1ev0S
 YKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QaFxE7xJjw3q1QRzUlhL9vl2FAXABYAZdUNglx88dWM=;
 b=tjSQUqbLJ/CfQmnRQ9FpI2LYu9eXLO41EIqauLxNJnF4sFfjO52XtUI8MjoMR71217
 Ur6ddlN48Cn70TzARUEAz4mqDRO322LGvEGYNUMK3Y8A/jNcKp0n7FGXTIcz7ZIex9QH
 TsvWdxT8916seslQi0JL9LF+kZdDEmL3IsCVKkSQtPxpmfLDeK7/JaUEzj+SEdLHwwSN
 +UVmNUU9Md6pYkJfAgSU0kli45bxkMh8eH8D1Bcu7qQF7jU/s+Dzn3eK+9RPCro+pT1f
 OYjFvd2J+4qWrAtRzZ0gV7yMB763fKfb8EZLE7IBBAwoZHKoEm1s3Ix2uLPSXN3W9/zQ
 W8bg==
X-Gm-Message-State: AOAM531PmKUBLTMseoT5QxWo9RCrsOcYQUXCGGs+TdP+BXzK8cBRatVX
 L9IQSKiDw+KnY/y9l4PPBAg=
X-Google-Smtp-Source: ABdhPJx0o599PHMcyxzLn8eHnK8YWRJh3bbcuBhN5MPJAY682L8sA466e6YWGWWwK4DIft39eFQPyQ==
X-Received: by 2002:a37:e110:: with SMTP id c16mr23323591qkm.67.1616975772640; 
 Sun, 28 Mar 2021 16:56:12 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:12 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 03/30] amba-pl08x.c: Fixed couple of typos
Date: Mon, 29 Mar 2021 05:22:59 +0530
Message-Id: <b96052cd5c14956852fe7fc13ea47dac7b2b40e1.1616971780.git.unixbhaskar@gmail.com>
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


s/busses/buses/
s/accound/account/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/amba-pl08x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a24882ba3764..d15182634789 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -121,7 +121,7 @@ struct vendor_data {

 /**
  * struct pl08x_bus_data - information of source or destination
- * busses for a transfer
+ * buses for a transfer
  * @addr: current address
  * @maxwidth: the maximum width of a transfer on this bus
  * @buswidth: the width of this bus in bytes: 1, 2 or 4
@@ -1010,7 +1010,7 @@ static inline u32 pl08x_lli_control_bits(struct pl08x_driver_data *pl08x,
 	/*
 	 * Remove all src, dst and transfer size bits, then set the
 	 * width and size according to the parameters. The bit offsets
-	 * are different in the FTDMAC020 so we need to accound for this.
+	 * are different in the FTDMAC020 so we need to account for this.
 	 */
 	if (pl08x->vd->ftdmac020) {
 		retbits &= ~FTDMAC020_LLI_DST_WIDTH_MSK;
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
