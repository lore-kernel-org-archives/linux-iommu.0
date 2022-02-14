Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B8C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 13:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4B88400E0;
	Mon, 14 Feb 2022 13:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0G9GgKZracf; Mon, 14 Feb 2022 13:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E7AE40621;
	Mon, 14 Feb 2022 13:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36617C001A;
	Mon, 14 Feb 2022 13:16:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7925C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0C7140600
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQjuOuayVxQW for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 13:16:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A544A400E0
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 13:16:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A1DAB2FB; Mon, 14 Feb 2022 14:15:59 +0100 (CET)
Date: Mon, 14 Feb 2022 14:15:58 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] iommu/rockchip: : Use standard driver registration
Message-ID: <YgpWDkcftsILEjpq@8bytes.org>
References: <05ca5e1b29bdd350f4e20b9ceb031a2c281e23d2.1644005728.git.robin.murphy@arm.com>
 <c08d58bff340da6a829e76d66d2fa090a9718384.1644005728.git.robin.murphy@arm.com>
 <4984895.Adqdaih0Sd@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4984895.Adqdaih0Sd@phil>
Cc: will@kernel.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
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

On Fri, Feb 04, 2022 at 10:34:05PM +0100, Heiko Stuebner wrote:
> Am Freitag, 4. Februar 2022, 21:16:41 CET schrieb Robin Murphy:
> > It's been a long time since there was any reason to register IOMMU
> > drivers early. Convert to the standard platform driver helper.
> > 
> > CC: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied both, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
