Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BD3C433EF
	for <iommu@archiver.kernel.org>; Mon, 22 Nov 2021 10:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C0BA80E08;
	Mon, 22 Nov 2021 10:44:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09AzHGvl2q2P; Mon, 22 Nov 2021 10:44:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8C44880DF3;
	Mon, 22 Nov 2021 10:44:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28020C0037;
	Mon, 22 Nov 2021 10:44:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFB6CC002E
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C93C040172
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WHSO_nAXXUES for <iommu@lists.linux-foundation.org>;
 Mon, 22 Nov 2021 10:44:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD08D40010
 for <iommu@lists.linux-foundation.org>; Mon, 22 Nov 2021 10:44:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: dafna) with ESMTPSA id 0363E1F4481E
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1637577860; bh=F0sCdl4LDNPsiVCBcFYo9Yve0hPNTO3tV9OSCtyVJ0I=;
 h=From:To:Cc:Subject:Date:From;
 b=Zhi4XWr0K4DNHK96YKsypStuWryd8MzOuLDyqiTHpBOUNhQCdttlcrDn9Z6OouRi2
 z8roA8RsKtPHY5rX5Il0X+DFtSsqKMkKY79ObzmJRIrldMCtDz2dhrpsVa2OE+WNB+
 +fonn97A7iFt6bTUfZzXWpUiYuC25UgHqxlATT3KgoE9tw8ghza/FRUMOrW6ypRMyU
 tapUzyO7PBNLjHzPo7oXv24zVZzXdo2L5J/Zl2AlKDBsuWIE9k5oQQAnXRJQDX6AFH
 okCkKXu1oue8Nhlc0boh6vAu6t1qLGUqiKuGbslKk79gQcoBPMlpTAP2q4pnJu5JHF
 RlLd6ovtDB2LA==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 0/2] iommu/mediatek: fix tlb flush logic
Date: Mon, 22 Nov 2021 12:43:58 +0200
Message-Id: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
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

Often devices allocate dma buffers before they do
runtime pm resume. This is the case for example with v4l2
devices where buffers are allocated during 'VIDIOC_REQBUFS`
and runtime resume happens later usually during 'VIDIOC_STREAMON'.
In such cases the partial tlb flush when allocating will fail
since the the iommu is runtime suspended. This will print a warning
and try to do full flush. But there is actually no need to flush
the tlb before the consumer device is turned on.

Fix the warning by skipping parital flush when allocating and instead
do full flash in runtime resume

This patchset is a combination of a patch already sent in a different
patchset: [1] and a warning fix from Sebastian Reichel

[1] https://lore.kernel.org/linux-devicetree/20210923115840.17813-13-yong.wu@mediatek.com/

Sebastian Reichel (1):
  iommu/mediatek: always check runtime PM status in tlb flush range
    callback

Yong Wu (1):
  iommu/mediatek: Always tlb_flush_all when each PM resume

 drivers/iommu/mtk_iommu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
