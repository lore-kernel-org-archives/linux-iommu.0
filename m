Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63605C433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 09:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 183AD83E1D;
	Mon, 24 Jan 2022 09:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5fVuJUlSBZO; Mon, 24 Jan 2022 09:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A33B83E1A;
	Mon, 24 Jan 2022 09:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEC6C0031;
	Mon, 24 Jan 2022 09:37:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBD8AC002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AADB260BA4
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:37:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tMFVw_ggINCS for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 09:37:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AF1760B9F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=z/r63EfvVm9RGMh2KAen4T39zB4cnOCdcpB+cKli6kk=; b=44hIObpmhtBGdpXCw/Owm1z15D
 gX3B43MrVba/2WBdQfup9/lzCAMQUm574OPNrXbV9oozMfw5HxE96QnNtc8jdo9JbaFSEQsq69UHq
 xYViMyqTzihvBZAyNoQHnIh39jq5hr7SBtYvZn3S3GW1s3LiVnrPbxdul/P8pIUT5cGDzRuLcyJ6J
 o098rl9sploiMtLIIa/7RPAv8stiyivLwWVQ6wSaI3BMD5kYiYImyma7TCz8XIy9B2+iB8Wc2ODZq
 v9IJe+4PH9SUnn+OHDjjsVrp0A0cctGZf45rGQv1GUhVOYhPAQ5RapGmD/t7d5wsFASILlYgnlSzZ
 1xm7p5YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nBvmr-002p4d-M0; Mon, 24 Jan 2022 09:37:21 +0000
Date: Mon, 24 Jan 2022 01:37:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <Ye5zUapC/YcZs7kl@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220124071103.2097118-8-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
> Add a domain specific callback set, domain_ops, for vendor iommu driver
> to provide domain specific operations. Move domain-specific callbacks
> from iommu_ops to the domain_ops and hook them when a domain is allocated.

Ah, that's what I meant earlier.  Perfect!

Nit:  I don't think vendor is the right term here.

Maybe something like:

iommut: split struct iommu_ops

Move the domain specific operations out of struct iommu_ops into a new
structure that only has domain specific operations.  This solves
the problem of needing to know if the method vector for a given
operation needs to be retreived from the device or th domain.

> +struct domain_ops {

This needs to keep an iommu in the name, i.e. iommu_domain_ops.

> +	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);

Overly long line.

> +static inline void iommu_domain_set_ops(struct iommu_domain *domain,
> +					const struct domain_ops *ops)
> +{
> +	domain->ops = ops;
> +}

Do we really need this helper?

> +static const struct domain_ops amd_domain_ops;

Can we avoid these forward declarations or would that cause too much
churn?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
