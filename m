Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24E7C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 12:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71164401F6;
	Wed,  8 Dec 2021 12:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oonQJJh2sav0; Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3CABF4035F;
	Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06EDEC006F;
	Wed,  8 Dec 2021 12:08:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55B4CC002F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29EA960F60
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C8PtKH66tEna for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 12:08:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 963406078C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9EC681F45C7B;
 Wed,  8 Dec 2021 12:08:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638965287; bh=L9d2/HDk7J7gj/gXjduUDMoRjsqJJjeSwDd7JPhOG9k=;
 h=From:To:Subject:Date:From;
 b=oBCBNfBpdFOfovUIiOFd2rS4JUzm/my5mfPfGW1At667YUHorYABd8psyv6pnFD7a
 cLP0FK+r4UZdQQUb6zi5p8/3TuVTpcnqsOuK7diMwO+zugLcxk99zRUWqwD+OLb5ro
 YFZBTw4Pxiay2V+kZdiUM9vUcF+kIQydtqtFzKROttPBmxb1UYGcZIg5sqXZgjNi2W
 EguiMMYdgfqF93sybRg/2X0YjFtFVZb/mcuy4T0y7M1wtP9H4N0QH1L2WJr6XqD7+r
 1k+HFC3//Oxdu2A0cOpIn+yw3Px4obMiw28qSROhcGyex/46Ee3yKUGAECDt4LW/zR
 /JnFyRLE+b6mQ==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU DRIVER),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
 linux-kernel@vger.kernel.org (open list), dafna.hirschfeld@collabora.com,
 kernel@collabora.com, linux-media@vger.kernel.org,
 sebastian.reichel@collabora.com
Subject: [PATCH v2 0/5] iommu/mediatek: Fix tlb flush logic
Date: Wed,  8 Dec 2021 14:07:39 +0200
Message-Id: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
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

Often devices allocate DMA buffers before they do
runtime pm resume. This is the case for example with v4l2
devices where buffers are allocated during 'VIDIOC_REQBUFS`
and runtime resume happens later usually during 'VIDIOC_STREAMON'.
In such cases the partial tlb flush when allocating will fail
since the iommu is runtime suspended. This will print a warning
and try to do full flush. But there is actually no need to flush
the tlb before the consumer device is turned on.

Fix the warning by skipping partial flush when allocating and instead
do full flash in runtime resume.

In order to do full flush from the resume cb, the test:

if (pm_runtime_get_if_in_use(data->dev) <= 0)
	    continue;

needs to be removed from the flush all func since pm_runtime_get_if_in_use
returns 0 while resuming and will skip the flush


This patchset is a combination of 4 patches already sent in a different
patchset: [1] and a warning fix from Sebastian Reichel

[1] https://lore.kernel.org/linux-devicetree/20210923115840.17813-1-yong.wu@mediatek.com/

changes since v1:
-----------------

* Added preparation patches to remove the unneeded 'for_each_m4u' usage
and add a spinlock to protect access to tlb control registers.
* remove the pm runtime status check as explained above.
* refactor commit logs and inline doc
* move the call to full flush to the bottom of the resume cb after all registers are updated.


Sebastian Reichel (1):
  iommu/mediatek: Always check runtime PM status in tlb flush range
    callback

Yong Wu (4):
  iommu/mediatek: Remove for_each_m4u in tlb_sync_all
  iommu/mediatek: Remove the power status checking in tlb flush all
  iommu/mediatek: Add tlb_lock in tlb_flush_all
  iommu/mediatek: Always tlb_flush_all when each PM resume

 drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
