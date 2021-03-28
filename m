Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F77C433E2
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E386193E
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E386193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC5F840337;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ixD91wxciSqZ; Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00DFF40330;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 235BAC0019;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 553A9C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37B91400C4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kJU-b5sDg1bg for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99D95400C8
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:08 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id iu14so120264qvb.4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cGEIwK2mIWlt0praWPVjHqx3787sD2c2+ZgIrWeWC10=;
 b=MHcOVXxwuQq9uqXkVVuBX0gJCRJ7glGGeVEfFXw0gIUK0eSzsVxe1AZARAhuSRj3YZ
 fN0P0USAorbIlhKL+tBir5YICqCcUJgAHIdtl7kbbjsKMDY4jYibPNUn3NaaV7Q8EWoo
 SLCd3+axdfEe2JQgQ0IA5JDtmlwwY/78RnCy1OD6/3OYMG9Pi0P4Td5hpINwGDG0ZVHP
 /wwa+3iDJ6RBYE1AEyFziDbGBYl8YxN7l4N0Nj3tZs04HUgSpxd0XYTb+bpMd7rAFOv/
 Ka2nQ91BkVfuIiwh7j5oP5m22bSKTwFZz8/56aHeupoIJtY5Q6H7slSTKfgf7lJTmOyP
 yQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cGEIwK2mIWlt0praWPVjHqx3787sD2c2+ZgIrWeWC10=;
 b=aIc/viDnoiG3mctV+soY6JKxZrvKtIap8pftJ+TjqAk8JKmX12JcpBX0zrxxGYZXkd
 9KlazqnDJaT66TLW/RoHSADrMA2LYnPrP2tyef5UE/Qdqa7i5w85UlEK4YClXkdm6AwB
 i3qtSlIxizFut9ivOTdM3lwXjDIEEp4wMUceLtq/Ghka0obSlDgAjEH87oCiGl1W/JLp
 u1A4BMpoNugwpnHaUs25JAQb0GgpCAPWtSYPHoiirYmVHwDof687BoXDtIb403dLP5Cu
 pMIwepEv8NciJfBJhMiPtWk8ULd8lPsA75WB4X75j5uli722NqzjjzH9wl0ltvB9eYa1
 cXfA==
X-Gm-Message-State: AOAM531sU4Zlzk2nNtGEM6z5tGjg8zSpMNAqIWA9g1g4tFwQDEmOh/XI
 4LlwDQycWsPZaRkCeA/Mtlk=
X-Google-Smtp-Source: ABdhPJzupTYmpyqK8HSRMpnyKZA7fy0qU0f4/K+gj2k9q8PjKZlDEA4s8A98+bzdSWZWkwnQeq1lbQ==
X-Received: by 2002:a0c:ea81:: with SMTP id d1mr23183110qvp.57.1616975767611; 
 Sun, 28 Mar 2021 16:56:07 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:07 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 02/30] altera-msgdma.c: Couple of typos fixed
Date: Mon, 29 Mar 2021 05:22:58 +0530
Message-Id: <c9dc34e16508c7444d3407d775eb6f921ff81f06.1616971780.git.unixbhaskar@gmail.com>
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

s/assosiated/associated/
s/oder/order/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/altera-msgdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index 9a841ce5f0c5..c3483bf2aaa7 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -152,7 +152,7 @@ struct msgdma_extended_desc {
 /**
  * struct msgdma_sw_desc - implements a sw descriptor
  * @async_tx: support for the async_tx api
- * @hw_desc: assosiated HW descriptor
+ * @hw_desc: associated HW descriptor
  * @node: node to move from the free list to the tx list
  * @tx_list: transmit list node
  */
@@ -510,7 +510,7 @@ static void msgdma_copy_one(struct msgdma_device *mdev,
 	 * of the DMA controller. The descriptor will get flushed to the
 	 * FIFO, once the last word (control word) is written. Since we
 	 * are not 100% sure that memcpy() writes all word in the "correct"
-	 * oder (address from low to high) on all architectures, we make
+	 * order (address from low to high) on all architectures, we make
 	 * sure this control word is written last by single coding it and
 	 * adding some write-barriers here.
 	 */
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
