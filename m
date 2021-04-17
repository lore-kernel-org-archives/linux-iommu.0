Return-Path: <SRS0=S5kk=JO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D32C433B4
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 14:03:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC29611ED
	for <iommu@archiver.kernel.org>; Sat, 17 Apr 2021 14:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC29611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAD0883DA7;
	Sat, 17 Apr 2021 14:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8AHC5r2twish; Sat, 17 Apr 2021 14:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C51FF83A5A;
	Sat, 17 Apr 2021 14:03:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 972C5C001A;
	Sat, 17 Apr 2021 14:03:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE9E5C0019
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 06:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4DD940145
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 06:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EDgr-lvQ4XO5 for <iommu@lists.linux-foundation.org>;
 Sat, 17 Apr 2021 06:17:21 +0000 (UTC)
X-Greylist: delayed 00:09:47 by SQLgrey-1.8.0
Received: from mail.siol.net (mailoutvs26.siol.net [185.57.226.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 391D840113
 for <iommu@lists.linux-foundation.org>; Sat, 17 Apr 2021 06:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTP id C3A8F523302;
 Sat, 17 Apr 2021 08:07:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id ujWJtRf9z93L; Sat, 17 Apr 2021 08:07:30 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Postfix) with ESMTPS id 8284852334B;
 Sat, 17 Apr 2021 08:07:30 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net
 [89.212.178.211]) (Authenticated sender: jernej.skrabec@siol.net)
 by mail.siol.net (Postfix) with ESMTPA id 59D425232B3;
 Sat, 17 Apr 2021 08:07:28 +0200 (CEST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 4/8] iommu/sun50i: Fix spelling mistake "consits" ->
 "consists"
Date: Sat, 17 Apr 2021 08:07:28 +0200
Message-ID: <4000375.Ibcesr10vN@jernej-laptop>
In-Reply-To: <20210326062412.1262-5-thunder.leizhen@huawei.com>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
 <20210326062412.1262-5-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 17 Apr 2021 14:03:24 +0000
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

Hi!

Dne petek, 26. marec 2021 ob 07:24:08 CEST je Zhen Lei napisal(a):
> There is a spelling mistake in a comment, fix it.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/sun50i-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
