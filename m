Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75823C43219
	for <iommu@archiver.kernel.org>; Mon, 22 Nov 2021 10:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 162194030A;
	Mon, 22 Nov 2021 10:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eeq-cTDI1Q66; Mon, 22 Nov 2021 10:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F326F4030F;
	Mon, 22 Nov 2021 10:44:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D74ECC002E;
	Mon, 22 Nov 2021 10:44:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD06CC0012
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C271340293
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHgfidjH5tyV for <iommu@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:44:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 275394028A
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dafna) with ESMTPSA id 4AF961F4482B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637577861; bh=2Xsz33sJUCBtrvsBkiwQnxCnwbbplwf03p+yM44j+xY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJA57MhNimPrOD/OHLVYM5/Xo8lNmRfBCpTzhBYY55RjyHWXovzrC3+kCz2GFFB7s
 k9JcqtSNaVUN7UPZ3qOP61314DvDmpIy1LKVtBSOMXUZnSRJZkpSHSuPs3qKn2ms6q
 wa+0qLHqFE2jQ+t6mSitG3fXQHKBvRr3Atjyc3Q/x5N8sOvxhTPiNjToDVljORECTG
 cxG4n3LSaLr5LLzahXyAL0ZziNpaXur8ahl6hQ3Udfvp5fPNyq4z2xlR2dOa2lOHEu
 39YOqjPFb7yTbYgfLb16Ji/dc0kTGw0NF3HGEp/OIMFknQUarhrMwwdDohWVZP3G/4
 3ieNTmbk8eNGA==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/2] iommu/mediatek: Always tlb_flush_all when each PM resume
Date: Mon, 22 Nov 2021 12:43:59 +0200
Message-Id: <20211122104400.4160-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
Cc: open list <linux-kernel@vger.kernel.org>, sebastian.reichel@collabora.com,
 "moderated list:MEDIATEK IOMMU DRIVER"
 <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, linux-media@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Yong Wu <yong.wu@mediatek.com>

Prepare for 2 HWs that sharing pgtable in different power-domains.

When there are 2 M4U HWs, it may has problem in the flush_range in which
we get the pm_status via the m4u dev, BUT that function don't reflect the
real power-domain status of the HW since there may be other HW also use
that power-domain.

The function dma_alloc_attrs help allocate the iommu buffer which
need the corresponding power domain since tlb flush is needed when
preparing iova. BUT this function only is for allocating buffer,
we have no good reason to request the user always call pm_runtime_get
before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
in the pm_runtime_resume to make sure the tlb always is clean.

Another solution is always call pm_runtime_get in the tlb_flush_range.
This will trigger pm runtime resume/backup so often when the iommu
power is not active at some time(means user don't call pm_runtime_get
before calling dma_alloc_xxx), This may cause the performance drop.
thus we don't use this.

In other case, the iommu's power should always be active via device
link with smi.

The previous SoC don't have PM except mt8192. the mt8192 IOMMU is display's
power-domain which nearly always is enabled. thus no need fix tags here.
Prepare for mt8195.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[imporvie inline doc]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 25b834104790..28dc4b95b6d9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -964,6 +964,13 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	/*
+	 * Users may allocate dma buffer before they call pm_runtime_get,
+	 * in which case it will lack the necessary tlb flush.
+	 * Thus, make sure to update the tlb after each PM resume.
+	 */
+	mtk_iommu_tlb_flush_all(data);
+
 	/*
 	 * Uppon first resume, only enable the clk and return, since the values of the
 	 * registers are not yet set.
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
