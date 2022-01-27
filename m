Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780DDC433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 11:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 230BC84F76;
	Thu, 27 Jan 2022 11:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s9Cf3BqT62fr; Thu, 27 Jan 2022 11:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BDAC84E02;
	Thu, 27 Jan 2022 11:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5B7AC001A;
	Thu, 27 Jan 2022 11:17:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F3F9C000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49DE140B98
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:17:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GDBHudkkIT6e for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:17:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8580E40292
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:17:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B033F1F45091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643282235;
 bh=wZVt4wJ3ZIXwm5J3WkeI7DmuycE/6AgP9kxAmGl4MHk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RNpe9lY8NzKzJx8wUI+P77Ig0n7bSCYdR9WTVZzouOFw6c+LfKA1Kt6KIFOmCSjO3
 avcutdFnsOoW1N8IruruloGhYR9o1NgPvQA9mABR7Hq6ejP6NEhREHIAebGIbyhdth
 JWEWY7k+uAPjmo6BIPgOdD+0ZBOteQayMekEJAe/9ShguNUg/kwbt+LaRquKUT+Xwo
 GqBDAk/5+240cemf8Zn5kFDGKBolI2674mKtm4AnCwRaX3x0EM8gzJrDz8iH5chhlT
 Wxkpzu2KUmN92wCeUPl7swGx4YViUtqUfuuLRXa7vr8vZjpUjx4IjJLsuKQta7zGgw
 6/0p+2qKt+SYA==
Subject: Re: [PATCH v4 29/35] iommu/mediatek: Add mtk_iommu_bank_data structure
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-30-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <fd39758a-b5a7-c6d9-3d29-0c6221d0c533@collabora.com>
Date: Thu, 27 Jan 2022 12:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-30-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 25/01/22 09:56, Yong Wu ha scritto:
> Prepare for supporting multi-banks for the IOMMU HW, No functional change.
> 
> Add a new structure(mtk_iommu_bank_data) for each a bank. Each a bank have
> the independent HW base/IRQ/tlb-range ops, and each a bank has its special
> iommu-domain(independent pgtable), thus, also move the domain information
> into it.
> 
> In previous SoC, we have only one bank which could be treated as bank0(
> bankid always is 0 for the previous SoC).
> 
> After adding this structure, the tlb operations and irq could use
> bank_data as parameter.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
