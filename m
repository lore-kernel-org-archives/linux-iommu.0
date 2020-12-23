Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42797C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:52:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C530320674
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6FCD687241;
	Wed, 23 Dec 2020 08:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 75YhfRq5Ysgv; Wed, 23 Dec 2020 08:52:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E78E871E6;
	Wed, 23 Dec 2020 08:52:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E25B5C1787;
	Wed, 23 Dec 2020 08:52:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B18A2C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9002785CA8
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HDO8SYm1kHK for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:52:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7139B85C97
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3mzr93rw3bP5ndgOkj2J3rKWLzLdUR7cBci5P56NY/A=; b=e7DvOMVGT/z24nyz8RevO5TNuL
 WdyEBLPTXKZhnYQ2+JVThOyNcxf1W5KmTwA5W+HXZ8RE0mSTFAIkiLI0qGI4zRULn4wEHAusY5Vbe
 D24ApPSkSgchloP395V8Td00Gs/g6HoEYWoOCASf4iAdUL3iFj2TNNS33xKjYQM6AaQA/TOVozKYh
 1sDh3FDP4ocjoCLt1zgYr+7Khy+s/SqFXCFz4AQ2Ur0gzSqXXjkBfokXBTz1QUm1C1hgs0V+bSlqw
 PBsf/QGD/O0JyNCf9CiaF68I94p3AU25XOkvlee4xZxdJq3JNylV8r+FV5TvU99JNFVaeGRyMp2C4
 W6+6dNow==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1krzs9-0008Rh-6Z; Wed, 23 Dec 2020 08:51:53 +0000
Date: Wed, 23 Dec 2020 08:51:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 1/7] iommu: Move iotlb_sync_map out from __iommu_map
Message-ID: <20201223085153.GA30643@infradead.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201216103607.23050-2-yong.wu@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, Greg Kroah-Hartman <gregkh@google.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 16, 2020 at 06:36:01PM +0800, Yong Wu wrote:
> In the end of __iommu_map, It alway call iotlb_sync_map.
> This patch moves iotlb_sync_map out from __iommu_map since it is
> unnecessary to call this for each sg segment especially iotlb_sync_map
> is flush tlb all currently.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

What about adding a little helper that does the NULL check and method
call instead of duplicating it all over?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
