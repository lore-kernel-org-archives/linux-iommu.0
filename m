Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9CFC4338F
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 16:08:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE3960E09
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 16:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEE3960E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B803560747;
	Thu, 29 Jul 2021 16:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnXMXzsetgu9; Thu, 29 Jul 2021 16:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7387F6063B;
	Thu, 29 Jul 2021 16:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D969C001A;
	Thu, 29 Jul 2021 16:08:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A82FC000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8A94838C9
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKxRXPFgTAkg for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 16:08:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 234A7838F0
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 16:08:50 +0000 (UTC)
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1m98aN-0004AD-4y; Thu, 29 Jul 2021 18:08:39 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, xxm@rock-chips.com, robin.murphy@arm.com,
 Ezequiel Garcia <ezequiel@collabora.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: Re: [PATCH v7 3/4] iommu: rockchip: Add internal ops to handle
 variants
Date: Thu, 29 Jul 2021 18:08:38 +0200
Message-ID: <3544194.oiGErgHkdL@diego>
In-Reply-To: <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
 <20210525121551.606240-4-benjamin.gaignard@collabora.com>
 <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

Hi Dafna,

Am Donnerstag, 29. Juli 2021, 17:59:26 CEST schrieb Dafna Hirschfeld:
> On 25.05.21 14:15, Benjamin Gaignard wrote:
> > @@ -879,7 +895,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> >   
> >   	for (i = 0; i < iommu->num_mmu; i++) {
> >   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
> > -			       rk_domain->dt_dma);
> > +			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
> 
> Hi,
> This is not related to that patch, I was wondring why are all mmu devices initialized
> with the same dt_dma?
> I see for example that the isp0_mmu in rk3399.dtsi has two resources. Can't each resource
> be initialized with different dt_dma and this way there are two dt tables instead of the two mmus pointing
> to the same dt table.

maybe
git log -1 cd6438c5f8446691afa4829fe1a9d7b656204f11

"iommu/rockchip: Reconstruct to support multi slaves
    
There are some IPs, such as video encoder/decoder, contains 2 slave iommus,
one for reading and the other for writing. They share the same irq and
clock with master.
    
This patch reconstructs to support this case by making them share the same
Page Directory, Page Tables and even the register operations.
That means every instruction to the reading MMU registers would be
duplicated to the writing MMU and vice versa."


Heiko


> 
> Thanks,
> Dafna
> 
> >   		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
> >   		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
> >   	}
> > @@ -1037,7 +1053,7 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
> >   	for (i = 0; i < NUM_DT_ENTRIES; i++) {
> >   		u32 dte = rk_domain->dt[i];
> >   		if (rk_dte_is_pt_valid(dte)) {
> > -			phys_addr_t pt_phys = rk_dte_pt_address(dte);
> > +			phys_addr_t pt_phys = rk_ops->pt_address(dte);
> >   			u32 *page_table = phys_to_virt(pt_phys);
> >   			dma_unmap_single(dma_dev, pt_phys,
> >   					 SPAGE_SIZE, DMA_TO_DEVICE);
> > @@ -1127,6 +1143,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
> >   	struct device *dev = &pdev->dev;
> >   	struct rk_iommu *iommu;
> >   	struct resource *res;
> > +	const struct rk_iommu_ops *ops;
> >   	int num_res = pdev->num_resources;
> >   	int err, i;
> >   
> > @@ -1138,6 +1155,17 @@ static int rk_iommu_probe(struct platform_device *pdev)
> >   	iommu->dev = dev;
> >   	iommu->num_mmu = 0;
> >   
> > +	ops = of_device_get_match_data(dev);
> > +	if (!rk_ops)
> > +		rk_ops = ops;
> > +
> > +	/*
> > +	 * That should not happen unless different versions of the
> > +	 * hardware block are embedded the same SoC
> > +	 */
> > +	if (WARN_ON(rk_ops != ops))
> > +		return -EINVAL;
> > +
> >   	iommu->bases = devm_kcalloc(dev, num_res, sizeof(*iommu->bases),
> >   				    GFP_KERNEL);
> >   	if (!iommu->bases)
> > @@ -1226,6 +1254,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
> >   		}
> >   	}
> >   
> > +	dma_set_mask_and_coherent(dev, rk_ops->dma_bit_mask);
> > +
> >   	return 0;
> >   err_remove_sysfs:
> >   	iommu_device_sysfs_remove(&iommu->iommu);
> > @@ -1277,8 +1307,20 @@ static const struct dev_pm_ops rk_iommu_pm_ops = {
> >   				pm_runtime_force_resume)
> >   };
> >   
> > +static struct rk_iommu_ops iommu_data_ops_v1 = {
> > +	.pt_address = &rk_dte_pt_address,
> > +	.mk_dtentries = &rk_mk_dte,
> > +	.mk_ptentries = &rk_mk_pte,
> > +	.dte_addr_phys = &rk_dte_addr_phys,
> > +	.dma_addr_dte = &rk_dma_addr_dte,
> > +	.dma_bit_mask = DMA_BIT_MASK(32),
> > +};
> > +
> > +
> >   static const struct of_device_id rk_iommu_dt_ids[] = {
> > -	{ .compatible = "rockchip,iommu" },
> > +	{	.compatible = "rockchip,iommu",
> > +		.data = &iommu_data_ops_v1,
> > +	},
> >   	{ /* sentinel */ }
> >   };
> >   
> > 
> 




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
