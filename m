Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC24C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 19:07:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D7E60C40
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 19:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D7E60C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C711B87374;
	Wed, 27 Jan 2021 19:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LT-Bi-PDMDNK; Wed, 27 Jan 2021 19:07:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 212A487366;
	Wed, 27 Jan 2021 19:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DECAAC08A1;
	Wed, 27 Jan 2021 19:07:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02CC1C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ECDD086C3E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZa-xOiY4pBg for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 19:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F0DAA86C39
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:07:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CC8564DB4
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611774435;
 bh=+2fq9fqcnJYIGiasm2Y78NeRv8I7YIdMcOI8TxM795s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=YhRvfHT6RV1BMZil1zdzFYbHrjCJm7nZH8PN85tJkCvVMFjd6eDbEasUTop/t+LPD
 +og8JbTEYZzAi04vEHfuIFInmDsmd231LW3n5RVJFYyM6vY3hmYrtWNfd8A82XdX6m
 DjpPaS8pSa/DuHZYs6mKcfXHpOXTTFE56zyLkjQntGO4C+hsC0Ykvmz47tpeTx/84l
 zXaW1LY6a8F7/TYczF+XBpza56l2dKK/8HzbEQZeM6w1bYXSP9+Xt5hPZiwG5xTEFf
 wAw/S9OAFRpNo71WJjOFETco8uFIl0z2ETgQOd81ch+lFz7xSSy2QicZgzOBZ8Zlq9
 XFs7hqikGgclQ==
Received: by mail-ej1-f50.google.com with SMTP id w1so4168848ejf.11
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:07:15 -0800 (PST)
X-Gm-Message-State: AOAM531LhmUTDJqIHvhq4izuwyYmDK1oy+yQnnMGm+Dy053Ve6BzFfvr
 2uDU3AQQ/GXxSvGzQPAgbaBSZVjE5acmJA+C5A==
X-Google-Smtp-Source: ABdhPJwZ642wt52ernlRSW6Ok++wbRCAdfK+zZt0YWbSRLkd8I/BHIp2pHEsvorc0aidjP5dLvbM2BPXjvTf/vQ2vrY=
X-Received: by 2002:a17:906:c9d8:: with SMTP id
 hk24mr8285418ejb.468.1611774433585; 
 Wed, 27 Jan 2021 11:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20210119105203.15530-1-yong.wu@mediatek.com>
In-Reply-To: <20210119105203.15530-1-yong.wu@mediatek.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 27 Jan 2021 13:07:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
Message-ID: <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To: Yong Wu <yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Tomasz Figa <tfiga@google.com>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jan 19, 2021 at 4:52 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
> supplanting dma_pfn_offset") always update dma_range_map even though it was
> already set, like in the sunxi_mbus driver. the issue is reported at [1].
> This patch avoid this(Updating it only when dev has valid dma-ranges).

only when dev *doesn't* have valid dma-ranges?

> Meanwhile, dma_range_map contains the devices' dma_ranges information,
> This patch moves dma_range_map before of_iommu_configure. The iommu
> driver may need to know the dma_address requirements of its iommu
> consumer devices.
>
> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com/
>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset"),
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/device.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..1122daa8e273 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -162,9 +162,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>         mask = DMA_BIT_MASK(ilog2(end) + 1);
>         dev->coherent_dma_mask &= mask;
>         *dev->dma_mask &= mask;
> -       /* ...but only set bus limit if we found valid dma-ranges earlier */
> -       if (!ret)
> +       /* ...but only set bus limit and range map if we found valid dma-ranges earlier */
> +       if (!ret) {
>                 dev->bus_dma_limit = end;
> +               dev->dma_range_map = map;
> +       }
>
>         coherent = of_dma_is_coherent(np);
>         dev_dbg(dev, "device is%sdma coherent\n",
> @@ -172,6 +174,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>
>         iommu = of_iommu_configure(dev, np, id);
>         if (PTR_ERR(iommu) == -EPROBE_DEFER) {
> +               /* Don't touch range map if it wasn't set from a valid dma-ranges */
> +               if (!ret)
> +                       dev->dma_range_map = NULL;
>                 kfree(map);
>                 return -EPROBE_DEFER;
>         }
> @@ -181,7 +186,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>
>         arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>
> -       dev->dma_range_map = map;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> --
> 2.18.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
