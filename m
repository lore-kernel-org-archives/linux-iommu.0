Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CBC432BE
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D66D60EE7
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D66D60EE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6401680A4B;
	Wed, 11 Aug 2021 02:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E8ZjBgXdDGGP; Wed, 11 Aug 2021 02:44:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E55698367B;
	Wed, 11 Aug 2021 02:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 969D6C0010;
	Wed, 11 Aug 2021 02:44:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B550AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A46778367C
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T6MQo09daQmE for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:44:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9AF88367B
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:07 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id b7so734430plh.7
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qegFIKnQxZw4wxrrKT+itOQUvH07gg9i31emr5EQUb4=;
 b=RpTikaOmvpWwhBu76RwlPbsObyEP8VBGJW4O3kl7/3R7kPEt0F1chIpOfr1IjPjQBa
 vpanoB+b2m/11+QKLDdu4+wX35ur2FG5V/fzPTeWDmrryi4W1iBRn+DMCB6FL3kdI+Tn
 0pjynKjbONb2PPmb3boUZFiwjIRHZ0pyXeizQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qegFIKnQxZw4wxrrKT+itOQUvH07gg9i31emr5EQUb4=;
 b=RSqaRXGcSxTtJBn45sjA9msHm9ODMkwfx9Pai0DPEJflo9tlENkk28MRtI/CUd9N2l
 78NC3qMicp3NFYOD+5zDajc0LKhFu7T5EI8QZ17kmkXA3mzqGWF5AkMWUdYmyXuoWnjG
 l23cEin9bMlCzwaBn6ghcu4Gm9K/oHFGQVvYKQR+jUDGAkjFRSJpCsC0JfqMyv6L5DZ+
 kYiHD5UNdFUCe2Ees3GQciJXY9s+Ie4tY6LpCrduV6CZEU7XOl6WvRANrDzTvnr3Y/rY
 gLNc0t8CTvGtsOWp+0C+KCPGTPTUfETDBHWSmzgjqt28DX7AKPbbSVCHEq8sUDnM3tOP
 fdsA==
X-Gm-Message-State: AOAM531rk9XzwBNBGA6Pd4k4C6mey9tPxh7/5XUI6+Qlsnm1dghgy/xf
 fa16wu18a8VzG8RPac9GEWFS9w==
X-Google-Smtp-Source: ABdhPJxpAtpMRVCkIy0CeKRG1iq4BSx19vJTWB5BGIzxIogqH5LE+bVlWj3wiiCx6ViPagQt5ibgjw==
X-Received: by 2002:a17:90a:c8c:: with SMTP id
 v12mr8177299pja.37.1628649847154; 
 Tue, 10 Aug 2021 19:44:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
 by smtp.gmail.com with UTF8SMTPSA id t9sm32800688pgc.81.2021.08.10.19.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 19:44:06 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 0/5] Fixes for dma-iommu swiotlb bounce buffers
Date: Wed, 11 Aug 2021 11:42:42 +0900
Message-Id: <20210811024247.1144246-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>
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

This patch set includes various fixes for dma-iommu's swiotlb bounce
buffers for untrusted devices. There are three fixes for correctness
issues, one performance issue, and one general cleanup.

The min_align_mask issue was found when running fio on an untrusted nvme
device with bs=512. The other issues were found via code inspection, so
I don't have any specific use cases where things were not working, nor
any concrete performance numbers.

v2 -> v3:
 - Add new patch to address min_align_mask bug
 - Set SKIP_CPU_SYNC flag after syncing in map/unmap
 - Properly call arch_sync_dma_for_cpu in iommu_dma_sync_sg_for_cpu

v1 -> v2:
 - Split fixes into dedicated patches
 - Less invasive changes to fix arch_sync when mapping
 - Leave dev_is_untrusted check for strict iommu

David Stevens (5):
  dma-iommu: fix sync_sg with swiotlb
  dma-iommu: fix arch_sync_dma for map
  dma-iommu: add SKIP_CPU_SYNC after syncing
  dma-iommu: Check CONFIG_SWIOTLB more broadly
  dma-iommu: account for min_align_mask

 drivers/iommu/dma-iommu.c | 97 +++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 44 deletions(-)

-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
