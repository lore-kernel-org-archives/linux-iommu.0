Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D7AC3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 15:36:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3498E21739
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 15:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3498E21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 02F6D2049D;
	Mon,  2 Mar 2020 15:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6OpYkvMKIk33; Mon,  2 Mar 2020 15:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 12F6020494;
	Mon,  2 Mar 2020 15:36:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC5C5C1AE2;
	Mon,  2 Mar 2020 15:36:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C0CCC013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 75FD885BFA
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OKFWrCfD-ncw for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 15:36:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9D07C85BCA
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 15:36:12 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9B23D5BC; Mon,  2 Mar 2020 16:36:09 +0100 (CET)
Date: Mon, 2 Mar 2020 16:36:06 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v2 2/4] iommu: Add Allwinner H6 IOMMU driver
Message-ID: <20200302153606.GB6540@8bytes.org>
References: <cover.a31c229a83f1d92e6928ae2adb70887da0fd44b3.1582222496.git-series.maxime@cerno.tech>
 <6864f0f28825bb7a2ec1c0d811a4aacdecf5f945.1582222496.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6864f0f28825bb7a2ec1c0d811a4aacdecf5f945.1582222496.git-series.maxime@cerno.tech>
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

Hi Maxime,

On Thu, Feb 20, 2020 at 07:15:14PM +0100, Maxime Ripard wrote:
> +struct sun50i_iommu_domain {
> +	struct iommu_domain domain;
> +
> +	/* Number of devices attached to the domain */
> +	refcount_t refcnt;
> +
> +	/* Lock to modify the Directory Table */
> +	spinlock_t dt_lock;

I suggest you make page-table updates lock-less. Otherwise this lock
will become a bottle-neck when using the IOMMU through DMA-API.

> +
> +static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +			    phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
> +	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> +	u32 pte_index;
> +	u32 *page_table, *pte_addr;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&sun50i_domain->dt_lock, flags);
> +	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
> +	if (IS_ERR(page_table)) {
> +		ret = PTR_ERR(page_table);
> +		goto out;
> +	}
> +
> +	pte_index = sun50i_iova_get_pte_index(iova);
> +	pte_addr = &page_table[pte_index];
> +	if (sun50i_pte_is_page_valid(*pte_addr)) {

You can use unlikely() here.

> +		phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
> +		dev_err(iommu->dev,
> +			"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
> +			&iova, &page_phys, &paddr, prot);
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	*pte_addr = sun50i_mk_pte(paddr, prot);
> +	sun50i_table_flush(sun50i_domain, pte_addr, 1);

This maps only one page, right? But the function needs to map up to
'size' as given in the parameter list.

> +
> +	spin_lock_irqsave(&iommu->iommu_lock, flags);
> +	sun50i_iommu_tlb_invalidate(iommu, iova);
> +	spin_unlock_irqrestore(&iommu->iommu_lock, flags);

Why is there a need to flush the TLB here? The IOMMU-API provides
call-backs so that the user of the API can decide when it wants
to flush the IO/TLB. Such flushes are usually expensive and doing them
on every map and unmap will cost significant performance.

> +static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +				 size_t size, struct iommu_iotlb_gather *gather)
> +{
> +	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
> +	struct sun50i_iommu *iommu = sun50i_domain->iommu;
> +	unsigned long flags;
> +	phys_addr_t pt_phys;
> +	dma_addr_t pte_dma;
> +	u32 *pte_addr;
> +	u32 dte;
> +
> +	spin_lock_irqsave(&sun50i_domain->dt_lock, flags);
> +
> +	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
> +	if (!sun50i_dte_is_pt_valid(dte)) {
> +		spin_unlock_irqrestore(&sun50i_domain->dt_lock, flags);
> +		return 0;
> +	}
> +
> +	pt_phys = sun50i_dte_get_pt_address(dte);
> +	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
> +	pte_dma = pt_phys + sun50i_iova_get_pte_index(iova) * PT_ENTRY_SIZE;
> +
> +	if (!sun50i_pte_is_page_valid(*pte_addr)) {
> +		spin_unlock_irqrestore(&sun50i_domain->dt_lock, flags);
> +		return 0;
> +	}
> +
> +	memset(pte_addr, 0, sizeof(*pte_addr));
> +	sun50i_table_flush(sun50i_domain, pte_addr, 1);
> +
> +	spin_lock(&iommu->iommu_lock);
> +	sun50i_iommu_tlb_invalidate(iommu, iova);
> +	sun50i_iommu_ptw_invalidate(iommu, iova);
> +	spin_unlock(&iommu->iommu_lock);

Same objections as in the map function. This only unmaps one page, and
is the IO/TLB flush really needed here?

> +static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
> +{
> +	struct sun50i_iommu_domain *sun50i_domain;
> +
> +	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;

I think you should at least also support identity domains here. The
iommu-core code might allocate those for default domains.


Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
