Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7215CA90AF
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 09:53:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DF923128
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 09:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DF923128
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C8C986CE7;
	Wed, 13 May 2020 09:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PjTIG_0xA_Wk; Wed, 13 May 2020 09:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7874586C92;
	Wed, 13 May 2020 09:53:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BEADC0178;
	Wed, 13 May 2020 09:53:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 386B2C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 09:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 27B6E887F3
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 09:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6FuoLDs6vYh for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 09:53:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 74AA6887E6
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 09:53:09 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8FAD0379; Wed, 13 May 2020 11:53:05 +0200 (CEST)
Date: Wed, 13 May 2020 11:53:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 3/5] iommu: Add Allwinner H6 IOMMU driver
Message-ID: <20200513095304.GK9820@8bytes.org>
References: <cover.70f96f9afd2e04161ebece593ae6cd7e17eca41b.1588673353.git-series.maxime@cerno.tech>
 <dcccd40c46982b6ab2fc1c5bc199d045798fbe8e.1588673353.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dcccd40c46982b6ab2fc1c5bc199d045798fbe8e.1588673353.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, May 05, 2020 at 12:09:32PM +0200, Maxime Ripard wrote:
> +static u32 *sun50i_dte_get_page_table(struct sun50i_iommu_domain *sun50i_domain,
> +				      dma_addr_t iova, gfp_t gfp)
> +{
> +	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> +	unsigned long flags;
> +	u32 *page_table;
> +	u32 *dte_addr;
> +	u32 old_dte;
> +	u32 dte;
> +
> +	dte_addr = &sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
> +	dte = *dte_addr;
> +	if (sun50i_dte_is_pt_valid(dte)) {
> +		phys_addr_t pt_phys = sun50i_dte_get_pt_address(dte);
> +		return (u32 *)phys_to_virt(pt_phys);
> +	}
> +
> +	page_table = sun50i_iommu_alloc_page_table(iommu, gfp);
> +	if (IS_ERR(page_table))
> +		return page_table;
> +
> +	dte = sun50i_mk_dte(virt_to_phys(page_table));
> +	old_dte = cmpxchg(dte_addr, 0, dte);
> +	if (old_dte) {
> +		phys_addr_t installed_pt_phys =
> +			sun50i_dte_get_pt_address(old_dte);
> +		u32 *installed_pt = phys_to_virt(installed_pt_phys);
> +		u32 *drop_pt = page_table;
> +
> +		page_table = installed_pt;
> +		dte = old_dte;
> +		sun50i_iommu_free_page_table(iommu, drop_pt);
> +	}
> +
> +	sun50i_table_flush(sun50i_domain, page_table, PT_SIZE);
> +	sun50i_table_flush(sun50i_domain, dte_addr, 1);
> +
> +	spin_lock_irqsave(&iommu->iommu_lock, flags);
> +	sun50i_iommu_ptw_invalidate(iommu, iova);
> +	spin_unlock_irqrestore(&iommu->iommu_lock, flags);

Why is that needed, does the PTW also cache non-present entries?

> +static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +				 size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
> +	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> +	phys_addr_t pt_phys;
> +	dma_addr_t pte_dma;
> +	u32 *pte_addr;
> +	u32 dte;
> +
> +	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
> +	if (!sun50i_dte_is_pt_valid(dte))
> +		return 0;
> +
> +	pt_phys = sun50i_dte_get_pt_address(dte);
> +	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
> +	pte_dma = pt_phys + sun50i_iova_get_pte_index(iova) * PT_ENTRY_SIZE;
> +
> +	if (!sun50i_pte_is_page_valid(*pte_addr))
> +		return 0;
> +
> +	memset(pte_addr, 0, sizeof(*pte_addr));
> +	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +
> +	spin_lock(&iommu->iommu_lock);
> +	sun50i_iommu_ptw_invalidate(iommu, iova);
> +	spin_unlock(&iommu->iommu_lock);

And is that also needed? You clear a PTE here and not a top-level DT
entry. All these spinlocks in the map/unmap paths will truly hurt
performance.

And if it is really needed you can defer it into the iotlb_sync()
call-back.

> +static int sun50i_iommu_add_device(struct device *dev)
> +{
> +	struct sun50i_iommu *iommu;
> +	struct iommu_group *group;
> +
> +	iommu = sun50i_iommu_from_dev(dev);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	iommu_group_put(group);
> +
> +	return 0;
> +}
> +
> +static void sun50i_iommu_remove_device(struct device *dev)
> +{
> +	iommu_group_remove_device(dev);
> +}


These two call-backs have been renamed in the iommu-tree to
probe_device() and release_device() with slightly different semantics
and function signatures. I think for this driver they should look like
this:

	static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
	{
		struct sun50i_iommu *iommu;

		iommu = sun50i_iommu_from_dev(dev);
		if (!iommu)
			return ERR_PTR(-ENODEV);

		return &iommu->iommu;
	}

	static void sun50i_iommu_release_device(struct device *dev)
	{
	}

Can you pleas rebase these patches to the 'core' branch of the
iommu-tree and use these new call-backs?

The rest of your driver looks good to me. Good work!

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
