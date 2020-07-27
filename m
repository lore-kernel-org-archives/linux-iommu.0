Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D632DC433E8
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 08:52:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4EC20719
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 08:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jdh9vUaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4EC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5A41E203E3;
	Mon, 27 Jul 2020 08:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zt7CwdcrlLdT; Mon, 27 Jul 2020 08:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 609F0203D2;
	Mon, 27 Jul 2020 08:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40ABCC0050;
	Mon, 27 Jul 2020 08:52:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872D2C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 08:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 74FC786C34
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 08:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkbLm6lfHZXM for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 08:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id D740A86C0E
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 08:52:07 +0000 (UTC)
X-UUID: 4faa5b68767544c988f8a5078b80dc23-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=q34zqKlfJT1egqrpS4Z0LW4UkZCQFjyQJ1hrO1Kt++w=; 
 b=jdh9vUaEP2PlzjKm/2oker36hCtrU4F+ZAjB2yirdFYudZ0SNBA/h8ra30CPxk0Ue1jRLD4gswLnpoiX55DNLLt/CyNcWkR7bbJP6M7fWkjviEmKFUfhgUhXzYw5KnBSmjHDkaW1c8U96XW23RwYiLj5bdomeApnwD0X0MVlMbg=;
X-UUID: 4faa5b68767544c988f8a5078b80dc23-20200727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1620473155; Mon, 27 Jul 2020 16:52:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 16:51:59 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 16:51:58 +0800
Message-ID: <1595839778.2350.4.camel@mbjsdccf07>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
From: chao hao <Chao.Hao@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Mon, 27 Jul 2020 16:49:38 +0800
In-Reply-To: <20200711064846.16007-12-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-12-yong.wu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, chao hao <"Chao. Hao"@mediatek.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Sat, 2020-07-11 at 14:48 +0800, Yong Wu wrote:
> In the previous SoC, the M4U HW is in the EMI power domain which is
> always on. the latest M4U is in the display power domain which may be
> turned on/off, thus we have to add pm_runtime interface for it.
> 
> we should enable its power before M4U hw initial. and disable it after HW
> initialize.
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
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 54 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 931fdd19c8f3..03a6d66f4bef 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <asm/barrier.h>
> @@ -172,6 +173,19 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
>  	return container_of(dom, struct mtk_iommu_domain, domain);
>  }
>  
> +static int mtk_iommu_rpm_get(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		return pm_runtime_get_sync(dev);
> +	return 0;
> +}
> +
> +static void mtk_iommu_rpm_put(struct device *dev)
> +{
> +	if (pm_runtime_enabled(dev))
> +		pm_runtime_put_autosuspend(dev);
> +}
> +
>  static void mtk_iommu_tlb_flush_all(void *cookie)
>  {
>  	struct mtk_iommu_data *data = cookie;
> @@ -193,6 +207,11 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  	u32 tmp;
>  
>  	for_each_m4u(data) {
> +		/* skip tlb flush when pm is not active */
> +		if (pm_runtime_enabled(data->dev) &&
> +		    !pm_runtime_active(data->dev))
> +			continue;
> +
>  		spin_lock_irqsave(&data->tlb_lock, flags);
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>  			       data->base + data->plat_data->inv_sel_reg);
> @@ -377,15 +396,20 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  {
>  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	int ret;
>  
>  	if (!data)
>  		return -ENODEV;
>  
>  	/* Update the pgtable base address register of the M4U HW */
>  	if (!data->m4u_dom) {
> +		ret = mtk_iommu_rpm_get(dev);
> +		if (ret < 0)
> +			return ret;
>  		data->m4u_dom = dom;
>  		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
>  		       data->base + REG_MMU_PT_BASE_ADDR);
> +		mtk_iommu_rpm_put(dev);
>  	}
>  
>  	mtk_iommu_config(data, dev, true);
> @@ -543,10 +567,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	u32 regval;
>  	int ret;
>  
> -	ret = clk_prepare_enable(data->bclk);
> -	if (ret) {
> -		dev_err(data->dev, "Failed to enable iommu bclk(%d)\n", ret);
> -		return ret;
> +	/* bclk will be enabled in pm callback in power-domain case. */
> +	if (!pm_runtime_enabled(data->dev)) {
> +		ret = clk_prepare_enable(data->bclk);
> +		if (ret) {
> +			dev_err(data->dev, "Failed to enable iommu bclk(%d)\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	if (data->plat_data->m4u_plat == M4U_MT8173) {
> @@ -728,7 +756,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, data);
>  
> +	if (dev->pm_domain)
> +		pm_runtime_enable(dev);

hi yong,

If you put "pm_runtime_enable" here, it maybe not device_link with
smi_common for previous patch: 
if(i || !pm_runtime_enabled(dev))
    continue;

Whether put it up front?

best regards,
chao

> +
> +	ret = mtk_iommu_rpm_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = mtk_iommu_hw_init(data);
> +	mtk_iommu_rpm_put(dev);
>  	if (ret)
>  		return ret;
>  
> @@ -801,6 +837,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
>  		return ret;
>  	}
> +
> +	/* Avoid first resume to affect the default value of registers below. */
> +	if (!m4u_dom)
> +		return 0;
>  	writel_relaxed(reg->wr_len_ctrl, base + REG_MMU_WR_LEN_CTRL);
>  	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
>  	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> @@ -809,13 +849,13 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
>  	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
>  	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
> -	if (m4u_dom)
> -		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> -		       base + REG_MMU_PT_BASE_ADDR);
> +	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> +	       base + REG_MMU_PT_BASE_ADDR);
>  	return 0;
>  }
>  
>  static const struct dev_pm_ops mtk_iommu_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume, NULL)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
>  };
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
