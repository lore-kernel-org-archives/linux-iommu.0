Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CDCC56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 16:44:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738C921741
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 16:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738C921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 209F487905;
	Thu, 26 Nov 2020 16:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OoG9zf0LGogS; Thu, 26 Nov 2020 16:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 29F1E878EB;
	Thu, 26 Nov 2020 16:44:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15BA0C163C;
	Thu, 26 Nov 2020 16:44:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51AF3C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 16:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3CED1877A5
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 16:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2HpZiOOW2n4n for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 16:44:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2316786D93
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 16:44:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5F631B;
 Thu, 26 Nov 2020 08:43:59 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 571FC3F23F;
 Thu, 26 Nov 2020 08:43:56 -0800 (PST)
Subject: Re: [PATCH v4 12/24] iommu/mediatek: Move hw_init into attach_device
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-13-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <55bb14ef-f674-e55c-0803-43d91093eccb@arm.com>
Date: Thu, 26 Nov 2020 16:43:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111123838.15682-13-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 anan.sun@mediatek.com, kernel-team@android.com,
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

On 2020-11-11 12:38, Yong Wu wrote:
> In attach device, it will update the pagetable base address register.
> Move the hw_init function also here. Then it only need call
> pm_runtime_get/put one time here if m4u has power domain.

Doesn't that mean you'll end up writing most of the registers twice 
every time? (first from mtk_iommu_resume(), then again from 
mtk_iommu_hw_init())

It might be neater to have mtk_iommu_hw_init() simply populate the 
mtk_iommu_suspend_reg data with the initial values at probe time and 
manually call mtk_iommu_resume() if the hardware is already powered up 
at that point. Or maybe just don't bother saving those registers on 
suspend and put the initialisation directly in the resume path.

Robin.

> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 55f9b329e637..cfdf5ce696fd 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -125,6 +125,8 @@ struct mtk_iommu_domain {
>   
>   static const struct iommu_ops mtk_iommu_ops;
>   
> +static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
> +
>   /*
>    * In M4U 4GB mode, the physical address is remapped as below:
>    *
> @@ -380,12 +382,16 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>   {
>   	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>   	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	int ret;
>   
>   	if (!data)
>   		return -ENODEV;
>   
>   	/* Update the pgtable base address register of the M4U HW */
>   	if (!data->m4u_dom) {
> +		ret = mtk_iommu_hw_init(data);
> +		if (ret)
> +			return ret;
>   		data->m4u_dom = dom;
>   		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
>   		       data->base + REG_MMU_PT_BASE_ADDR);
> @@ -729,10 +735,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, data);
>   
> -	ret = mtk_iommu_hw_init(data);
> -	if (ret)
> -		return ret;
> -
>   	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
>   				     "mtk-iommu.%pa", &ioaddr);
>   	if (ret)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
