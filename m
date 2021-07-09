Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151A5C07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 03:35:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69C161447
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 03:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C161447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 608CA4058D;
	Fri,  9 Jul 2021 03:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fMCrzoS_Hotc; Fri,  9 Jul 2021 03:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 224B940607;
	Fri,  9 Jul 2021 03:35:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EED13C0010;
	Fri,  9 Jul 2021 03:35:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 799A4C000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 03:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 516DD40607
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 03:35:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W_P4LaiEhKPO for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 03:35:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13EB84058D
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 03:35:16 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 22-20020a17090a0c16b0290164a5354ad0so7461007pjs.2
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 20:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QgqesoC5qpl/edbOBllLil92AKJcrUsJTLsQmBAkv3M=;
 b=WSvB/aHB4PyQYa6s2owVlOvE5WTOZCBJtNvDp54FRHQ8Y5lQJLLT4k8EHF21mdgHQE
 dGaYSI2/YJ2vI6qpRcNDge5Vc/tCubf/Gfcb7eWHiAMTZnulsUGcqxGr/HtgRIpPmlhU
 A7OhK5uxFpSwpy/KUVpCKDa9Z0lYxlB35QKww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QgqesoC5qpl/edbOBllLil92AKJcrUsJTLsQmBAkv3M=;
 b=igeQz8MLiWK1Qb5TDLWyFO2W9tluMlU+iWodIcIh1UK7Qed6MnV6lYRa3fTxOvyuOy
 NGEyTnLlb4XjCCR17D38RnSA+PR8qGwnZzHRMJffZJ3RFIAvjB5kQ5Joph2HV21wnFfM
 t4UNFWj75rjVUdwkh3FWgVlCeeSDCV7ZiBlNa3oa6DPL3GzCwGFU1jpEhSGppwihLp+O
 OeqTllYhhIhlmJgbWXuKiJroZw5TylHow/miugEH529Du9CDBBi0I4gtTIfVgquPjOQc
 n9oQDusWiW3EHafabVqcwkKSb+YUkTLIe84ZnxPamDJDPGTPT6t2yPlOoXAuWsjgnBw1
 nnTg==
X-Gm-Message-State: AOAM533hqPmf4xpCVXHz6XxZuhVTt87qhBIT6f23MWQ6u0XZh2dPjJHR
 LaxAy60wPYk3HLJnOXf0Z3nEog==
X-Google-Smtp-Source: ABdhPJyscoeLU+fIni8rHH6VlaNI5+bdiO83XfOAz6wiKT+SHKtQYMVWdb5Ty1IRnZquh218puft0w==
X-Received: by 2002:a17:902:b111:b029:129:5cd0:110e with SMTP id
 q17-20020a170902b111b02901295cd0110emr27867718plr.51.1625801716483; 
 Thu, 08 Jul 2021 20:35:16 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
 by smtp.gmail.com with UTF8SMTPSA id gk20sm3942228pjb.17.2021.07.08.20.35.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 20:35:15 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/4] Fixes for dma-iommu swiotlb bounce buffers
Date: Fri,  9 Jul 2021 12:34:58 +0900
Message-Id: <20210709033502.3545820-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>
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

From: David Stevens <stevensd@chromium.org>

This patch set includes two fixes for bugs caused by mixing up the
original buffer's physical address and bounce buffer's physical address.
It also includes a performance fix that avoids an extra copy, as well as
a general cleanup fix.

The issues were found via code inspection, so I don't have any specific
use cases where things were not working, or any performance numbers.

v1 -> v2:
 - Split fixes into dedicated patches
 - Less invasive changes to fix arch_sync when mapping
 - Leave dev_is_untrusted check for strict iommu

David Stevens (4):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map with swiotlb
  dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
  dma-iommu: Check CONFIG_SWIOTLB more broadly

 drivers/iommu/dma-iommu.c | 63 ++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
