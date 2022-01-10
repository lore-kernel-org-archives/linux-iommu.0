Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52FCC433FE
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 11:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82BF48239A;
	Mon, 10 Jan 2022 11:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cW1DxkkoeEPI; Mon, 10 Jan 2022 11:43:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6D33581A9C;
	Mon, 10 Jan 2022 11:43:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53AFDC002F;
	Mon, 10 Jan 2022 11:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6F77C001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 11:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A58CA408E3
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 11:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDxRJyJOrwvm for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 11:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04A92408E2
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 11:43:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 675691F4341F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641815001;
 bh=qfdA38UV8rxTxGZXUeaOK67ifAtN+GX7ogFR3pqhe3E=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=GbGeOl3ElrEfAbWKu7HuLcsqmZNTsV5mLhcFol3/mI7QS14/9DcbiP9i1TRFU2C2f
 l8OSZ+mkmPzoq4KRAJThArDrwv4rDvuKF8Cv6KS9ce33lwgBzJdYZCnvnGxQuYfdEL
 bqDeUO5LVTtsrN8THSCo3XuA19u29dlPi0Em94ZsJQlJdvLqCWwH4u0M+wUrRnczVi
 7C1ZC0NsjEfFE2LiKhRwainELvqFgypkULQbbJIITPehBElsslgS1nauOGmSBKtEbI
 OUQ0yiW+3whbBsbblvBjOYMNRxxT1u73ToGdYHqKeCDm2dG1V7HRJ3tGhu66r7bowU
 MDHQZVWe/XXbQ==
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Always check runtime PM status in
 tlb flush range callback
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
 linux-media@vger.kernel.org, sebastian.reichel@collabora.com
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
 <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <f91157b6-886c-2d69-451e-6ddeb52f95d7@collabora.com>
Date: Mon, 10 Jan 2022 12:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> In case of v4l2_reqbufs() it is possible, that a TLB flush is done
> without runtime PM being enabled. In that case the "Partial TLB flush
> timed out, falling back to full flush" warning is printed.
> 
> Commit c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> introduced has_pm as optimization to avoid checking runtime PM
> when there is no power domain attached. But without the PM domain
> there is still the device driver's runtime PM suspend handler, which
> disables the clock. Thus flushing should also be avoided when there
> is no PM domain involved.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
