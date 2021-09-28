Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F25C433F5
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 01:21:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0AC60FED
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 01:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B0AC60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7FC0608F7;
	Tue, 28 Sep 2021 01:21:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gb-EkLuDsEEl; Tue, 28 Sep 2021 01:21:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C0AA7605A1;
	Tue, 28 Sep 2021 01:21:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DCA6C0011;
	Tue, 28 Sep 2021 01:21:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3513C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 01:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC90C608F7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 01:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-lqJm71wjTc for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 01:21:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC9A6605A1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 01:21:48 +0000 (UTC)
X-UUID: 0472ea340c5f4a6cafb182f94f6d8091-20210928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=BLlymuonkhKMUQNrGodsUw+v+u1VEea3dRqmgRuo/6A=; 
 b=hX0CKKRGGXvxUqmTKxm69Qff3MSfxXB+BDGIXBGCPgyNsgAkiJT+aVwClbYTf2LH8MOYfhmdNk3NJ2xzSd9TTOk00EEXpZ4TynemgAwx34GXJ4ullZ9Olx/ndzpmlmBrnJTvnuII0CGaK0JPEy/w7CfQ4HXpkVlFG3pdjJso4qY=;
X-UUID: 0472ea340c5f4a6cafb182f94f6d8091-20210928
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1292667397; Tue, 28 Sep 2021 09:21:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Sep 2021 09:21:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Sep 2021 09:21:38 +0800
Message-ID: <d7db3e4c3c4a40843d60fe92666d7f9e90df8801.camel@mediatek.com>
Subject: Re: [PATCH] iommu/mediatek: fix out-of-range warning with clang
From: Yong Wu <yong.wu@mediatek.com>
To: Arnd Bergmann <arnd@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 28 Sep 2021 09:21:41 +0800
In-Reply-To: <20210927121857.941160-1-arnd@kernel.org>
References: <20210927121857.941160-1-arnd@kernel.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2021-09-27 at 14:18 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-14 notices that a comparison is never true when
> CONFIG_PHYS_ADDR_T_64BIT is disabled:
> 
> drivers/iommu/mtk_iommu.c:553:34: error: result of comparison of
> constant 5368709120 with expression of type 'phys_addr_t' (aka
> 'unsigned int') is always false [-Werror,-Wtautological-constant-out-
> of-range-compare]
>         if (dom->data->enable_4GB && pa >=
> MTK_IOMMU_4GB_MODE_REMAP_BASE)
>                                      ~~
> ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add an explicit check for the type of the variable to skip the check
> and the warning in that case.
> 
> Fixes: b4dad40e4f35 ("iommu/mediatek: Adjust the PA for the 4GB
> Mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
