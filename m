Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E314C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 03:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02B5260D6D;
	Mon,  7 Mar 2022 03:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZmjs76xK9Gm; Mon,  7 Mar 2022 03:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DDC9960D88;
	Mon,  7 Mar 2022 03:55:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B253CC0012;
	Mon,  7 Mar 2022 03:55:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6EEC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E15B340193
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHSMbRxEZHI1 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 03:55:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5C12400B9
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:55:34 +0000 (UTC)
X-UUID: 2c5287f01a0f4632a8214a70db01be8c-20220307
X-UUID: 2c5287f01a0f4632a8214a70db01be8c-20220307
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1052100488; Mon, 07 Mar 2022 11:55:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 11:55:29 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 7 Mar 2022 11:55:28 +0800
To: <robin.murphy@arm.com>
Subject: RE: [PATCH] iommu/iova: Free all CPU rcache for retry when iova alloc
 failure
Date: Mon, 7 Mar 2022 11:49:27 +0800
Message-ID: <20220307034927.23159-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <906a446e-3e25-5813-d380-de699a84b6f4@arm.com>
References: <906a446e-3e25-5813-d380-de699a84b6f4@arm.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Ning.Li@mediatek.com,
 matthias.bgg@gmail.com, stable@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
From: "yf.wang--- via iommu" <iommu@lists.linux-foundation.org>
Reply-To: yf.wang@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 2022-03-04 at 14:03 +0000, Robin Murphy wrote:
> 
> OK, so either there's a mystery bug where IOVAs somehow get freed on 
> offline CPUs, or the hotplug notifier isn't working correctly, or
> you've 
> contrived a situation where alloc_iova_fast() is actually racing
> against 
> iova_cpuhp_dead(). In the latter case, the solution is "don't do
> that".
> 
> This change should not be necessary.
> 
> Thanks,
> Robin.

Hi Robin,

You are right, kernel 5.15 already has this patch, but kernel 5.10
not contain.

Thanks,
Yunfei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
