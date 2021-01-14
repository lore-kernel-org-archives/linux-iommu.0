Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7891C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 19:27:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D6B23B46
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 19:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D6B23B46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB1628677D;
	Thu, 14 Jan 2021 19:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BO6-xQn5NJKX; Thu, 14 Jan 2021 19:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EFED184ECF;
	Thu, 14 Jan 2021 19:27:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D05DAC088B;
	Thu, 14 Jan 2021 19:27:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3525FC013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 19:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 29B0A86961
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 19:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2tqaIY8BfscN for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 19:27:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 165CA85754
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 19:27:35 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id c18so468515oto.3
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 11:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VEeqdZkDifn0VyJEJKrWR4ztWRK6vfNBUVg/0z1SB/E=;
 b=hG0VRiqeyWsT0z0+qg5bHt4IQqE+LkPuQUvmh0G8CDnDe2SISAEgQ9nI5vrU12chq/
 DZGKDVYM9x1as0ypWzTdBKYn+dQ1jadprMOOWDuPxMTVzXuHcl3wciyphKG0pGFgJ+xN
 jMRr54eW2taJCFmHYdYCpmjPCahlwIR7y0UjDLlbW/BGdpfGeCiQ01uSdPyBu9iFS02e
 fXI9iLDA98pneMPkwUCYr/AYMReOuSqbYvU0O3vE+nHcLHXyo/Z2jU22sKVfEhg/hX1S
 KVY63YEgeSp/vkru86MOapsM8nP6xD/y2agrSvU1W6T9pY9ze0vK/wLiLbqGmQmmlVPI
 6Lsw==
X-Gm-Message-State: AOAM5313G6fr/htK9tBn/DzFxVQuseta+jj/Gh6OYEBIqVG1uii8dkTB
 dQ53Aq1BVmLChsemI5jdAQ==
X-Google-Smtp-Source: ABdhPJyYwiGGmezeN+wyEHvNPOPyKigxB7dYEfZtRaxnNgEofQKzxycwX+PBMxfL7z5b0J6I8OHScA==
X-Received: by 2002:a05:6830:19da:: with SMTP id
 p26mr5479965otp.80.1610652454370; 
 Thu, 14 Jan 2021 11:27:34 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z189sm1222803oia.28.2021.01.14.11.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 11:27:33 -0800 (PST)
Received: (nullmailer pid 3425359 invoked by uid 1000);
 Thu, 14 Jan 2021 19:27:32 -0000
Date: Thu, 14 Jan 2021 13:27:32 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
Message-ID: <20210114192732.GA3401278@robh.at.kernel.org>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111111914.22211-7-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
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

On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> "dev->dma_range_map" contains the devices' dma_ranges information,
> This patch moves dma_range_map before of_iommu_configure. The iommu
> driver may need to know the dma_address requirements of its iommu
> consumer devices.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/of/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index aedfaaafd3e7..1d84636149df 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  	dev_dbg(dev, "device is%sdma coherent\n",
>  		coherent ? " " : " not ");
>  
> +	dev->dma_range_map = map;
>  	iommu = of_iommu_configure(dev, np, id);
>  	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>  		kfree(map);
> +		dev->dma_range_map = NULL;

Not really going to matter, but you should probably clear dma_range_map 
before what it points to is freed.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

>  		return -EPROBE_DEFER;
>  	}
>  
> @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>  
>  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>  
> -	dev->dma_range_map = map;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> -- 
> 2.18.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
