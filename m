Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80AAC433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 03:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41F2B60D6D;
	Mon,  7 Mar 2022 03:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9usQeYA-3M8m; Mon,  7 Mar 2022 03:24:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3BC56606C0;
	Mon,  7 Mar 2022 03:24:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4206C0012;
	Mon,  7 Mar 2022 03:24:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E77BC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03E2A404B2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9rke4xX8xtY9 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 03:24:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB287404BF
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:24:26 +0000 (UTC)
X-UUID: 5d3369bb49df482c9fe9d60bd641ae74-20220307
X-UUID: 5d3369bb49df482c9fe9d60bd641ae74-20220307
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yf.wang@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1177677395; Mon, 07 Mar 2022 11:24:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 7 Mar 2022 11:24:19 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 7 Mar 2022 11:24:18 +0800
To: <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/iova: Free all CPU rcache for retry when iova alloc
 failure
Date: Mon, 7 Mar 2022 11:18:18 +0800
Message-ID: <20220307031818.22875-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <33c2e244-95ef-406a-15eb-574cdf61b159@huawei.com>
References: <33c2e244-95ef-406a-15eb-574cdf61b159@huawei.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Libo.Kang@mediatek.com, yf.wang@mediatek.com,
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

On 2022-03-04 9:22, John Garry wrote:
> On 04/03/2022 04:46, yf.wang--- via iommu wrote:
> > ************* MEDIATEK Confidentiality Notice ********************
> > The 
> > information contained in this e-mail message (including any
> > attachments) may be confidential, proprietary, privileged, or 
> > otherwise exempt from disclosure under applicable laws. It is
> > intended 
> > to be
> 
> Can you please stop sending patches with this?

Hi John,

I will remote it later.

Thanks,
Yunfei.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
