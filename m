Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AECC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 01:06:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468EF64EBB
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 01:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468EF64EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 148B786757;
	Tue,  2 Feb 2021 01:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcg6MnxWS7ox; Tue,  2 Feb 2021 01:06:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 26CAF85802;
	Tue,  2 Feb 2021 01:06:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 190AEC0174;
	Tue,  2 Feb 2021 01:06:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B13FAC013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 93F4585823
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIYUGZ604qTZ for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 01:06:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DB91E85802
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 01:06:30 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id o16so13784301pgg.5
 for <iommu@lists.linux-foundation.org>; Mon, 01 Feb 2021 17:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5tWP56wGAsq5M1/6L0Nhx+Nff7Wx1AXO7jr86wZj1aM=;
 b=IVgPwKBKfNJ9jpRYoicL6hpd2wmOuRx6xSG+oELVY/zQuuhBTyLcF9eM/iOrSQK9XY
 hfa3wCKjPC5kjiiqsTwFOuMHg4lf3GQopkekSXhZFImOdjiGe5f1ugKUzKNiTJc/u+M4
 sNfMdGZLsEIgokugJxQ6Icjgzh4DJo2HFoVoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5tWP56wGAsq5M1/6L0Nhx+Nff7Wx1AXO7jr86wZj1aM=;
 b=GLjyg56XjPgHLkixZvWynM81cNI7cRe/bAjB/wjKGMhPiFP2CqiafYg+1LOW+PCvfX
 uC+77hNuCN9lv7pWgQgxuAP2ShHEcoUGmvExNuRkvrLW2Rn0qTQxkpFsTUrbRmzGrqaZ
 wWt7M0RDFEL16IXknQeUBmY2w39fczPtNOGuwqQ1iouMyqGK9K48Z7KBZSLYYSy1QOKH
 iBNoSgMxeRrnTT4YMd7wlX4fzaPoVjQTruz/xROcR6n3zXFTfkgZ3rvuWtVwd2X/8E6h
 9vZYDXP3Qa8UuNeVX1xrFEPEmgaok85IiBtf7DgaU53QHuR+ijI/K9jP7eVTwe1unMtI
 dmwA==
X-Gm-Message-State: AOAM533MsezeKGDisLBbkv4q5kL7j4TITklabfwJmRtYevA1CAD5NtyD
 xudELFzZgPwHj9lST+nlFvdHqA==
X-Google-Smtp-Source: ABdhPJwntOGwfW+QmkbBNMIa6+zYGCYzPyotiBWqhxHLBlUE+EHriVmMrDbRJc6c1OtSykVwqcKgdw==
X-Received: by 2002:aa7:8b0f:0:b029:1c0:e782:ba29 with SMTP id
 f15-20020aa78b0f0000b02901c0e782ba29mr18490270pfd.37.1612227990480; 
 Mon, 01 Feb 2021 17:06:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:d1cd:7a42:64fe:9bae])
 by smtp.gmail.com with ESMTPSA id b17sm20003282pfp.167.2021.02.01.17.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 17:06:29 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
 joro@8bytes.org
Subject: [PATCH] iommu: Properly pass gfp_t in _iommu_map() to avoid atomic
 sleeping
Date: Mon,  1 Feb 2021 17:06:23 -0800
Message-Id: <20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
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

Sleeping while atomic = bad.  Let's fix an obvious typo to try to avoid it.

The warning that was seen (on a downstream kernel with the problematic
patch backported):

 BUG: sleeping function called from invalid context at mm/page_alloc.c:4726
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: ksoftirqd/0
 CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.93-12508-gc10c93e28e39 #1
 Call trace:
  dump_backtrace+0x0/0x154
  show_stack+0x20/0x2c
  dump_stack+0xa0/0xfc
  ___might_sleep+0x11c/0x12c
  __might_sleep+0x50/0x84
  __alloc_pages_nodemask+0xf8/0x2bc
  __arm_lpae_alloc_pages+0x48/0x1b4
  __arm_lpae_map+0x124/0x274
  __arm_lpae_map+0x1cc/0x274
  arm_lpae_map+0x140/0x170
  arm_smmu_map+0x78/0xbc
  __iommu_map+0xd4/0x210
  _iommu_map+0x4c/0x84
  iommu_map_atomic+0x44/0x58
  __iommu_dma_map+0x8c/0xc4
  iommu_dma_map_page+0xac/0xf0

Fixes: d8c1df02ac7f ("iommu: Move iotlb_sync_map out from __iommu_map")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I haven't done any serious testing on this.  I saw a report of the
warning and the fix seemed obvious so I'm shooting it out.

 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3d099a31ddca..2b06b01850d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2441,7 +2441,7 @@ static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
 	const struct iommu_ops *ops = domain->ops;
 	int ret;
 
-	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
+	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
 	if (ret == 0 && ops->iotlb_sync_map)
 		ops->iotlb_sync_map(domain, iova, size);
 
-- 
2.30.0.365.g02bc693789-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
