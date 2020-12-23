Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06281C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:36:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F5F22248
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F5F22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 675E2867A7;
	Wed, 23 Dec 2020 08:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Kp58yBJYu6T; Wed, 23 Dec 2020 08:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A3F486765;
	Wed, 23 Dec 2020 08:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FCD0C1787;
	Wed, 23 Dec 2020 08:36:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 384A8C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1DE86867A3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gEnrncfzfPHd for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:36:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3878A86765
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:36:09 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id v2so9970495pfm.9
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OfrCLZAsvCa9E+UEDy5cUIBPR5zJvNqTrXdr4SCdt8c=;
 b=UMtBz2ORbpVVyCNyCiHvLukqnZRr+r1kBszkzGgaFwSRTKhnXtkTKFOQ3j4EW8oH6w
 GFbFzzbhOy/70vwgvVKxApt7Q2zMX4OxTTGx9xgMIoDQkcRAdA14b3rhrMW+6EhQoTOJ
 TqJ6Iy2alC5vUZDfgy4IAEav+SfuPKmg9Nkxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OfrCLZAsvCa9E+UEDy5cUIBPR5zJvNqTrXdr4SCdt8c=;
 b=Ds4wHzFUeIFd9EY3htf9FLG4vR6OINE/mgbvhYcMApG7TumaDBtaZ9RN7E+ey70fIG
 mR2D0YyIBQCc+cQKw+I67ViUdPlFi8sl+NgrcSUmUW3+ZY5s7FDai7HtVLNZxM3oGqYp
 Y9d31kUpTlbpy/Ykk8Sb0LX9A20JKOg7eVi2WxNZvQuZHkCFU33ARoweS6oGayZgdxX3
 2ZfSxLauUETQGLOduEHmMQAVM3KkmtNZM5SZQTw92zKlUjUSBjColj1kVcCcjCP5AH3E
 UXR/A+yqDKDbqXGe483pgowluZSxtVa1kenTv7xOyP40Phi5PlPVBhAzVQR5Oslwf3aN
 v6pg==
X-Gm-Message-State: AOAM531htnJ/9ur2CyKO0SBKbRVpZ0YPysH9hm2lSFBi3gEH4Xhj+uX8
 JOMzpL3w6X9vbSpZNjAx1vQ86g==
X-Google-Smtp-Source: ABdhPJy/ufv05/kcnbxdEivoZ5wcPsxjZGhiKhgHTe44wYRRjbq3ykCToz7VfuynLjBYvDDkre6gdA==
X-Received: by 2002:a63:504e:: with SMTP id q14mr5162728pgl.21.1608712568834; 
 Wed, 23 Dec 2020 00:36:08 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id l197sm23336277pfd.97.2020.12.23.00.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:36:08 -0800 (PST)
Date: Wed, 23 Dec 2020 17:36:02 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 18/27] iommu/mediatek: Add power-domain operation
Message-ID: <X+MBcmzQn9iQWlVZ@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-19-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-19-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
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

On Wed, Dec 09, 2020 at 04:00:53PM +0800, Yong Wu wrote:
> In the previous SoC, the M4U HW is in the EMI power domain which is
> always on. the latest M4U is in the display power domain which may be
> turned on/off, thus we have to add pm_runtime interface for it.
> 
> When the engine work, the engine always enable the power and clocks for
> smi-larb/smi-common, then the M4U's power will always be powered on
> automatically via the device link with smi-common.
> 
> Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> If its power already is on, of course it is ok. if the power is off,
> the main tlb will be reset while M4U power on, thus the tlb flush while
> m4u power off is unnecessary, just skip it.
> 
> There will be one case that pm runctime status is not expected when tlb
> flush. After boot, the display may call dma_alloc_attrs before it call
> pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
> the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
> at that time, I also think this is ok.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 41 +++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fe3ee2b2bf5..0e9c03cbab32 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -184,6 +184,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
>  	struct mtk_iommu_data *data = cookie;
>  
>  	for_each_m4u(data) {
> +		if (!pm_runtime_active(data->dev))
> +			continue;

Is it guaranteed that the status is active in the check above, but then
the process is preempted and it goes down here?

Shouldn't we do something like below?

        ret = pm_runtime_get_if_active();
        if (!ret)
                continue;
        if (ret < 0)
                // handle error
        
        // Flush
        
        pm_runtime_put();

Similar comment to the other places being changed by this patch.

>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>  			       data->base + data->plat_data->inv_sel_reg);
>  		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> @@ -200,6 +202,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  	u32 tmp;
>  
>  	for_each_m4u(data) {
> +		/* skip tlb flush when pm is not active. */
> +		if (!pm_runtime_active(data->dev))
> +			continue;
> +
>  		spin_lock_irqsave(&data->tlb_lock, flags);
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>  			       data->base + data->plat_data->inv_sel_reg);
> @@ -384,6 +390,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  {
>  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	struct device *m4udev = data->dev;
> +	bool pm_enabled = pm_runtime_enabled(m4udev);
>  	int ret;
>  
>  	if (!data)
> @@ -391,12 +399,25 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  
>  	/* Update the pgtable base address register of the M4U HW */
>  	if (!data->m4u_dom) {
> +		if (pm_enabled) {
> +			ret = pm_runtime_get_sync(m4udev);
> +			if (ret < 0) {
> +				pm_runtime_put_noidle(m4udev);
> +				return ret;
> +			}
> +		}
>  		ret = mtk_iommu_hw_init(data);
> -		if (ret)
> +		if (ret) {
> +			if (pm_enabled)
> +				pm_runtime_put(m4udev);
>  			return ret;
> +		}
>  		data->m4u_dom = dom;
>  		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
>  		       data->base + REG_MMU_PT_BASE_ADDR);
> +
> +		if (pm_enabled)
> +			pm_runtime_put(m4udev);
>  	}
>  
>  	mtk_iommu_config(data, dev, true);
> @@ -747,10 +768,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	if (dev->pm_domain) {
>  		struct device_link *link;
>  
> +		pm_runtime_enable(dev);
> +
>  		link = device_link_add(data->smicomm_dev, dev,
>  				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>  		if (!link) {
>  			dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
> +			pm_runtime_disable(dev);
>  			return -EINVAL;
>  		}
>  	}
> @@ -785,8 +809,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  out_sysfs_remove:
>  	iommu_device_sysfs_remove(&data->iommu);
>  out_link_remove:
> -	if (dev->pm_domain)
> +	if (dev->pm_domain) {
>  		device_link_remove(data->smicomm_dev, dev);
> +		pm_runtime_disable(dev);
> +	}
>  	return ret;
>  }
>  
> @@ -801,8 +827,10 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>  		bus_set_iommu(&platform_bus_type, NULL);
>  
>  	clk_disable_unprepare(data->bclk);
> -	if (pdev->dev.pm_domain)
> +	if (pdev->dev.pm_domain) {
>  		device_link_remove(data->smicomm_dev, &pdev->dev);
> +		pm_runtime_disable(&pdev->dev);
> +	}
>  	devm_free_irq(&pdev->dev, data->irq, data);
>  	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
>  	return 0;
> @@ -834,6 +862,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>  	void __iomem *base = data->base;
>  	int ret;
>  
> +	/* Avoid first resume to affect the default value of registers below. */
> +	if (!m4u_dom)
> +		return 0;
>  	ret = clk_prepare_enable(data->bclk);
>  	if (ret) {
>  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
> @@ -847,9 +878,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>  	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
>  	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
> -	if (m4u_dom)
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
>  	return 0;
>  }
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
