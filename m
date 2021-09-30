Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F24C433F5
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 11:26:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E8C615E0
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 11:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1E8C615E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 908C8840E2;
	Thu, 30 Sep 2021 11:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQPVSMmBDrCB; Thu, 30 Sep 2021 11:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F4B8840DE;
	Thu, 30 Sep 2021 11:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F043C000F;
	Thu, 30 Sep 2021 11:26:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39F35C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 11:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 309B16071F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 11:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4kISQncRyUOo for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 11:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D0F960715
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 11:26:12 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1] (unknown
 [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E54671F44AE1;
 Thu, 30 Sep 2021 12:26:09 +0100 (BST)
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-12-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <11fe281d-4873-245b-f506-452900f33d3b@collabora.com>
Date: Thu, 30 Sep 2021 13:26:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813065324.29220-12-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, chao.hao@mediatek.com,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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



On 13.08.21 08:53, Yong Wu wrote:
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> The previous SoC don't have PM. Only mt8192 has power-domain,
> and it is display's power-domain which nearly always is enabled.

hi, I see that in mt1873.dtsi, many devices that uses the iommu have the
'power-domains' property.

> 
> When there are 2 M4U HWs, it may has problem.
> In this function, we get the pm_status via the m4u dev, but it don't
> reflect the real power-domain status of the HW since there may be other
> HW also use that power-domain.
> 
> Currently we could not get the real power-domain status, thus always
> pm_runtime_get here.
> 
> Prepare for mt8195, thus, no need fix tags here.
> 
> This patch may drop the performance, we expect the user could
> pm_runtime_get_sync before dma_alloc_attrs which need tlb ops.
> 

Could you explain this sentence a bit? should the user call pm_runtime_get_sync
before calling dma_alloc_attrs?

Thanks,
Dafna

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index add23a36a5e2..abc721a1da21 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -238,8 +238,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   
>   	for_each_m4u(data, head) {
>   		if (has_pm) {
> -			if (pm_runtime_get_if_in_use(data->dev) <= 0)
> +			ret = pm_runtime_resume_and_get(data->dev);
> +			if (ret < 0) {
> +				dev_err(data->dev, "tlb flush: pm get fail %d.\n", ret);
>   				continue;
> +			}
>   		}
>   
>   		spin_lock_irqsave(&data->tlb_lock, flags);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
