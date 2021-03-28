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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B7C433E9
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A40061938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A40061938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 960C7607A0;
	Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMfP9xzgv3xm; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 745E1607B1;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 351D4C0021;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D01B6C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B145B605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8aLRMOBu5XL7 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:57:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1220F605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:12 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id g24so8230709qts.6
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VFtxWE0StKfcC+URsv7nAjsC2Kf78xuu9a0HtqKdSlU=;
 b=nofPQHYz+R+Oh7tBn2NrHqcJ60wz0I6awH3+nn+VeY57PjK9/aNKapSiLLecIClvPE
 Wv+VWFlug249FdqQUEnblJ5mnlCINYaNx63BE/qOihUhCU+JaQ/WqSPiCuKhfSjQbhGv
 sBRNZ9lVKQXJGBC11+kHxahv9pSjNr/fTi0d+YVlFs4PWEH7ZQGtYbkuhE6TF9M1XIi2
 OaPcpcSIEMOOc32j/1qRcNe0pfEquahJ0sNCoEtLMNpLSu5FueclTvKRvW/OcNHihNtC
 0IMi3H/cpoMpeAJG9jiZpJyTWlCGbUvhb9/0lczXT1gcHms5Qe+Z9kXEzBI1StWYjMxW
 2wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VFtxWE0StKfcC+URsv7nAjsC2Kf78xuu9a0HtqKdSlU=;
 b=UBwKcSJueWdjzR5e6lMZqPBr1xsTRlIIF1eZOQU5QoNylzuk7vxCli/EgvfW8t3CEo
 0HBWIuWCPW9pRKipX5+MA+650IpNyZRfoCAwWZkdz0xYOhAm/kgMCQcRI17+UfaOrPCI
 SJthFZE0Wszwv3ajoNHQlWtqE78RtINkArOO0zZK79jwZSo6Ty735ZEYvOqhnLeVnoNF
 k3lweX7AjDOTBp7dCER29GQj0Uw2HK4oP6Hmn5i7apJSr3YjITbvcuDbo53ebtSL1/rG
 iaFxsivTf2vl0CzJQ3aqyQMNCcSTBr+zHfM3fYWmp4s+v6F8HB57E8wHPxM1VTewuXtD
 RevA==
X-Gm-Message-State: AOAM533QlUkiYTO1H6dV+R16r9j7IVs4gcFnrI1NsNaGdURkoX1+efBW
 xgcUw4uxL+Qjg3oDRJYGFeU=
X-Google-Smtp-Source: ABdhPJzdepGd4ibSSylbqz3lykO6e7Iu/C1yudQOjI9dZGJHJpjheIp8QepnwzKrjFLrJcsbOfjQlg==
X-Received: by 2002:ac8:7fcd:: with SMTP id b13mr20277139qtk.68.1616975832021; 
 Sun, 28 Mar 2021 16:57:12 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:11 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 15/30] s3c24xx-dma.c: Few typos fixed
Date: Mon, 29 Mar 2021 05:23:11 +0530
Message-Id: <062bbb694c995aad9ca17a80bbc63716f116fd9f.1616971780.git.unixbhaskar@gmail.com>
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

s/transfered/transferred/
s/desintation/destination/  ...two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/s3c24xx-dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 8e14c72d03f0..045f2f531876 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -156,7 +156,7 @@ struct s3c24xx_sg {
  * struct s3c24xx_txd - wrapper for struct dma_async_tx_descriptor
  * @vd: virtual DMA descriptor
  * @dsg_list: list of children sg's
- * @at: sg currently being transfered
+ * @at: sg currently being transferred
  * @width: transfer width
  * @disrcc: value for source control register
  * @didstc: value for destination control register
@@ -920,7 +920,7 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_dma_cyclic(
 	}

 	/*
-	 * Always assume our peripheral desintation is a fixed
+	 * Always assume our peripheral destination is a fixed
 	 * address in memory.
 	 */
 	hwcfg |= S3C24XX_DISRCC_INC_FIXED;
@@ -1009,7 +1009,7 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_slave_sg(
 	}

 	/*
-	 * Always assume our peripheral desintation is a fixed
+	 * Always assume our peripheral destination is a fixed
 	 * address in memory.
 	 */
 	hwcfg |= S3C24XX_DISRCC_INC_FIXED;
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
