Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C2CC433EF
	for <iommu@archiver.kernel.org>; Sat,  5 Mar 2022 00:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7B70408CD;
	Sat,  5 Mar 2022 00:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fthuqr0vE_62; Sat,  5 Mar 2022 00:03:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EB99408D0;
	Sat,  5 Mar 2022 00:03:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70F9DC0012;
	Sat,  5 Mar 2022 00:03:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7D57C000B
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 00:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC1A783E83
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 00:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PFLWg0Q8HOEE for <iommu@lists.linux-foundation.org>;
 Sat,  5 Mar 2022 00:03:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD1F783E80
 for <iommu@lists.linux-foundation.org>; Sat,  5 Mar 2022 00:03:45 +0000 (UTC)
X-UUID: d4708299e3234759b8b7d1d628fb891a-20220305
X-UUID: d4708299e3234759b8b7d1d628fb891a-20220305
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 974430699; Sat, 05 Mar 2022 08:03:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 5 Mar 2022 08:03:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sat, 5 Mar 2022 08:03:37 +0800
To: <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Improve 32-bit free space estimate
Date: Sat, 5 Mar 2022 08:03:37 +0800
Message-ID: <20220305000337.24995-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <77b0c978-7caa-c333-6015-1d784b5daf3f@arm.com>
References: <77b0c978-7caa-c333-6015-1d784b5daf3f@arm.com>
MIME-Version: 1.0
X-MTK: N
Cc: wsd_upstream@mediatek.com, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, miles.chen@mediatek.com,
 yf.wang@mediatek.com, will@kernel.org
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Joerg, Robin,

> Applied without stable tag for now. If needed, please consider
> re-sending it for stable when this patch is merged upstream.

> Yeah, having figured out the history, I ended up with the opinion that 
> it was a missed corner-case optimisation opportunity, rather than an 
> actual error with respect to intent or implementation, so I 
> intentionally left that out. Plus figuring out an exact Fixes tag might 
> be tricky - as above I reckon it probably only started to become 
> significant somwehere around 5.11 or so.
> 
> All of these various levels of retry mechanisms are only a best-effort 
> thing, and ultimately if you're making large allocations from a small 
> space there are always going to be *some* circumstances that still 
> manage to defeat them. Over time, we've made them try harder, but that 
> fact that we haven't yet made them try hard enough to work well for a 
> particular use-case does not constitute a bug. However as Joerg says, 
> anyone's welcome to make a case to Greg to backport a mainline commit if 
> it's a low-risk change with significant benefit to real-world stable 
> kernel users.

Got it, thank you. 
We will try to push to the android LTS trees we need.

Thanks,
Miles

> 
> Thanks all!
> 
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
