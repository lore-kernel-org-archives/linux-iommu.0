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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E09C433E1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4413861938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4413861938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D994683927;
	Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cg-TpzDNawu; Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E161839F9;
	Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFD1CC002D;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 890FDC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B783838DE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j_AESaCkOrCe for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:57:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0D728387D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:27 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id q26so10933082qkm.6
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r/yLPPo841dOFvgXTquZIbBYSrAfKw7ph65+PVkCETM=;
 b=kqSj7aCUIqDznfRqoW0QgxanHBokTPho/STAgy/fC8CA3oXoCgHhFZhBx0bJLndhc8
 wZXHyS8nNnyL4m3H41Q5sXrJUArJwb4e3uvpRO6ZiiPmvqonD2DdrFEfo3DQvOZ5GNLc
 saLjVc0lRUjJtgagE8u6Yu8CITfDcO85EeHQWIC6qGIwBV9GPuHXwhP71WdYcSnqksrV
 FNU26qKEnM5rl5JDN5FsqwYdmveQ1Fh4viKid8oVbsEdm6o45iKO9Hgzr7Yxaox21zzb
 ww77wgJoQflTxFMPJgrI3Y4ozqFjMr9xfHfwriPaNfSlEl7FNt79jmEG4sqtEa2Qq+uS
 lsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r/yLPPo841dOFvgXTquZIbBYSrAfKw7ph65+PVkCETM=;
 b=ZIt+nRhiDUfBMaJ3N9xfVg27mE5TG1C35Ls75d8kR7L8SgNxJi6QGrvCigLocaDvXQ
 iBoqsi9VqFl6RQ90fzkUYl/Q3DpCxAOcgIkiT/uihUt9NRLIYHFt/RuTWBY85MDtgmYb
 2oqP8VZF5bHFYiT0//AhLdF5DgEPXmCK4595lMuZRt/VMCgFlGaFxuXELB5PkY6NRMpm
 nrqNlhDVV7A/714qutOWc55IjTF/LL7dR/4sEY0Gre+/PDBOiNzok2ja4kiXQmbtX+lE
 HugCMYHqCSW0MviOGkPir4aojacLBZpZinLT7XQQ63y0gZD6pt5NEOdorctofrGoFY7g
 2uoQ==
X-Gm-Message-State: AOAM531z0O5uQRPxh9uE+RAd8pXTNMe6Ivup55ZfCrXv+LDYg7QVwMp8
 Wxgu7XqyhcqnPFIuXiN4ulJzImuBoSqXQwDW
X-Google-Smtp-Source: ABdhPJzlIJVsP1+e9L67X5sWl3v37tzXkq6IkG/ls+Iz+DhefXkxs3HuwQvPjNj/yaULuKiNhdk4uA==
X-Received: by 2002:a05:620a:1650:: with SMTP id
 c16mr23014988qko.477.1616975846867; 
 Sun, 28 Mar 2021 16:57:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:26 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 18/30] tegra20-apb-dma.c: Fixed a typo
Date: Mon, 29 Mar 2021 05:23:14 +0530
Message-Id: <58f465e8c502b9f5cb07a2174a8103133defcbb9.1616971780.git.unixbhaskar@gmail.com>
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

s/programing/programming/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 71827d9b0aa1..e64789432587 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -475,7 +475,7 @@ static void tegra_dma_configure_for_next(struct tegra_dma_channel *tdc,

 	/*
 	 * If interrupt is pending then do nothing as the ISR will handle
-	 * the programing for new request.
+	 * the programming for new request.
 	 */
 	if (status & TEGRA_APBDMA_STATUS_ISE_EOC) {
 		dev_err(tdc2dev(tdc),
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
