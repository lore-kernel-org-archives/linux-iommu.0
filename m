Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527CC7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 07:20:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0146E21951
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 07:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0146E21951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CD68DDC;
	Wed, 24 Jul 2019 07:20:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 599AFDC8
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 07:20:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EA728701
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 07:20:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 05B9D3A2; Wed, 24 Jul 2019 09:19:59 +0200 (CEST)
Date: Wed, 24 Jul 2019 09:19:59 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v2 04/19] iommu: Introduce struct iommu_iotlb_gather
	for batching TLB flushes
Message-ID: <20190724071959.GE1524@8bytes.org>
References: <20190711171927.28803-1-will@kernel.org>
	<20190711171927.28803-5-will@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190711171927.28803-5-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux-foundation.org,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Will,

On Thu, Jul 11, 2019 at 06:19:12PM +0100, Will Deacon wrote:
>  static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
>  		size_t size)
>  {
> +	struct iommu_iotlb_gather iotlb_gather;
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
>  	size_t iova_off = iova_offset(iovad, dma_addr);
> +	size_t unmapped;
>  
>  	dma_addr -= iova_off;
>  	size = iova_align(iovad, size + iova_off);
> +	iommu_iotlb_gather_init(&iotlb_gather);
> +
> +	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
> +	WARN_ON(unmapped != size);
>  
> -	WARN_ON(iommu_unmap_fast(domain, dma_addr, size) != size);
>  	if (!cookie->fq_domain)
> -		iommu_tlb_sync(domain);
> +		iommu_tlb_sync(domain, &iotlb_gather);
>  	iommu_dma_free_iova(cookie, dma_addr, size);

I looked through your patches and was wondering if we can't make the
'struct iotlb_gather' a member of 'struct iommu_domain' and update it
transparently for the user? That would make things easier for users of
the iommu-api.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
