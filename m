Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B8C433DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 16:58:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5798122C9C
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 16:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5798122C9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EA50985816;
	Mon, 18 Jan 2021 16:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id msXIHQrk1Cee; Mon, 18 Jan 2021 16:58:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04468856E9;
	Mon, 18 Jan 2021 16:58:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D562CC088B;
	Mon, 18 Jan 2021 16:58:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84756C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 655D11FFC1
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:58:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WTAGqhDN2Uwa for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 16:58:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id A61C01FE65
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:58:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76036222BB;
 Mon, 18 Jan 2021 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610989120;
 bh=0bKhzEZ2HOSFbpgHtimXEvYRPGe1qXAb+1JtaEmfCiQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LcT4LSccNgfsfftGAHO5+Er6JQxGKpLFfMWLD3u67HN3Hb7QO1fgXikzrpRuhhyef
 SVvft3JrmCeoJ3MssTo5V1t/EzaDxb4sYYE0or7cH49o+cPsNcBf/Al+gn4ye32RKA
 KXUP3ece7Osqhubt3XL/nmZoHnj+7Wnnss7nyT5yr73omdai3VYGdOo2o/8JHSACF3
 kUDbm1ifuQK80OJv8fOnub3scEU0caBV1uUaqAwRpojx5ux/rmovbCibhpDYxUvYyQ
 ze0rfzkgHbUvtXvlR/o8kCO6nL8UHghEYaQmC9TLa9rswXCoPx6nhPNSfLE3jGpc3h
 2/bFjkFJKQxCg==
Date: Mon, 18 Jan 2021 16:58:34 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 6/7] iommu/mediatek: Gather iova in iommu_unmap to
 achieve tlb sync once
Message-ID: <20210118165833.GA17722@willie-the-truck>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-7-yong.wu@mediatek.com>
 <e1e17782-a9f3-6b64-1630-bf29af5241cf@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1e17782-a9f3-6b64-1630-bf29af5241cf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
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

On Mon, Jan 18, 2021 at 04:35:22PM +0000, Robin Murphy wrote:
> On 2020-12-16 10:36, Yong Wu wrote:
> > In current iommu_unmap, this code is:
> > 
> > 	iommu_iotlb_gather_init(&iotlb_gather);
> > 	ret = __iommu_unmap(domain, iova, size, &iotlb_gather);
> > 	iommu_iotlb_sync(domain, &iotlb_gather);
> > 
> > We could gather the whole iova range in __iommu_unmap, and then do tlb
> > synchronization in the iommu_iotlb_sync.
> > 
> > This patch implement this, Gather the range in mtk_iommu_unmap.
> > then iommu_iotlb_sync call tlb synchronization for the gathered iova range.
> > we don't call iommu_iotlb_gather_add_page since our tlb synchronization
> > could be regardless of granule size.
> > 
> > In this way, gather->start is impossible ULONG_MAX, remove the checking.
> > 
> > This patch aims to do tlb synchronization *once* in the iommu_unmap.
> 
> Assuming the update to patch #4 simply results in "unsigned long end = iova
> + size - 1;" here,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

There's a v4 here:

https://lore.kernel.org/r/20210107122909.16317-1-yong.wu@mediatek.com

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
