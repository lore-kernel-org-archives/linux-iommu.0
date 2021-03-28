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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB5C433E6
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6274661938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6274661938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C677838F7;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3UKp9wHpV1GO; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D39748398E;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94D6AC000B;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F00FC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5762605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qDESkC52yBoP for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55DD3605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:43 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id 30so5684026qva.9
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rruIrfqaU4LV0f/3DETW92os/6jYETGIbvTMrRY/HO8=;
 b=bGnHyBFVOutt4P2ONnjyaSIeJvIRzETak6KwFJ7ir2Nn/GqZgVtFuQhT8cWFVCJCF4
 nOmS5/3lsk0F21Pui0C1nfch9n42xfmm27QVRq2RUbd469ITaO2YTyoT6yca1dt3kEIA
 WrrB+5zNMv5REpdJe2JR74UmZr5+PTYnt/XmXcfAg0fv6Fy7GCSeRicj7d/SVnq3Qu/D
 UKRgx0ggNDlvFtQyqwIWq00SNVHxRapkrohVs+rT8HcJE0cam15uS2VWEv/I+wPd8Sx3
 oxsNNTD4FAJ8DW0fVQi+ybJ+sHJ776F4pG4SBgFnsTZUI5HwctVd0uJCZQ7w/2oBe12l
 xa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rruIrfqaU4LV0f/3DETW92os/6jYETGIbvTMrRY/HO8=;
 b=fAsu19Izm2OA+3qMWsTnKGlE/ZHG8s3Q47UJkLm4ZHMuuNn3JFmUun66moVXSecgJp
 5GplagpgJkfdmrFQIlvX6FDCXl7LFW93jIo/vPSt+q9YgkxVxqOfTOHImaskwfDIWvqn
 IAxODI4ID9JnwiERMcM5MfSZV8KJHYVRTxI7v+rvLoQzHNt7hDOk3A7s7nGMjv5IZxdf
 3c8YvFP52iPkjlXHnMqtW1vYPIbxJK6lkb7+OpZtKaHK/HYDp5x89lDBJfunmNFpw1mO
 mIgRGASqvcX12q/1FFZ24vcubqOQh6qzJG4hN4MjFgFExEwe2+e/7lMljHIR0d7CSKB8
 aLpA==
X-Gm-Message-State: AOAM530t1Z3hvVvpN6vLxjxyTUMr6lHaM98j0YUfUQuaDdLLY5nIDZLe
 U2JtUb7Cqp3JL//8sDeSGKg=
X-Google-Smtp-Source: ABdhPJwGtK6xTmnuLSPnSFT/2CTh7pV1MaTzw54JyGs6QVwUBLmi4sfOAtAfjo+zm2N6Vm+LRKQfow==
X-Received: by 2002:ad4:5614:: with SMTP id ca20mr22679724qvb.37.1616975802324; 
 Sun, 28 Mar 2021 16:56:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:41 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 09/30] mv_xor.h: Fixed a typo
Date: Mon, 29 Mar 2021 05:23:05 +0530
Message-Id: <c7ff7a7dbd93aecfc5b97f55a3ccaf23fd8a7c6b.1616971780.git.unixbhaskar@gmail.com>
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

s/writen/written/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/mv_xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/mv_xor.h b/drivers/dma/mv_xor.h
index d86086b05b0e..c87cefd38a07 100644
--- a/drivers/dma/mv_xor.h
+++ b/drivers/dma/mv_xor.h
@@ -99,7 +99,7 @@ struct mv_xor_device {
  * @common: common dmaengine channel object members
  * @slots_allocated: records the actual size of the descriptor slot pool
  * @irq_tasklet: bottom half where mv_xor_slot_cleanup runs
- * @op_in_desc: new mode of driver, each op is writen to descriptor.
+ * @op_in_desc: new mode of driver, each op is written to descriptor.
  */
 struct mv_xor_chan {
 	int			pending;
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
