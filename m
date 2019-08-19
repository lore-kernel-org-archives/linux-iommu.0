Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB658C3A5A1
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 11:45:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3222086C
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 11:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3222086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 51B18E34;
	Mon, 19 Aug 2019 11:45:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C0E4DE30
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 11:45:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 77E4F8A6
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 11:45:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 514ED28;
	Mon, 19 Aug 2019 04:45:20 -0700 (PDT)
Received: from [10.37.12.162] (unknown [10.37.12.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2BA23F246;
	Mon, 19 Aug 2019 04:45:18 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH 01/11] xen/arm: use dma-noncoherent.h calls
	for xen-swiotlb cache maintainance
To: Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20190816130013.31154-1-hch@lst.de>
	<20190816130013.31154-2-hch@lst.de>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <65248838-f273-6097-22f4-e5809078ddba@arm.com>
Date: Mon, 19 Aug 2019 12:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816130013.31154-2-hch@lst.de>
Content-Language: en-US
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Christoph,

On 8/16/19 2:00 PM, Christoph Hellwig wrote:
> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
> +	     enum dma_data_direction dir, unsigned long attrs)
> +{
> +	unsigned long page_pfn = page_to_xen_pfn(page);
> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned long compound_pages =
> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
> +	bool local = (page_pfn <= dev_pfn) &&
> +		(dev_pfn - page_pfn < compound_pages);
> +

The Arm version as a comment here. Could we retain it?

> +	if (local)
> +		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
> +	else
> +		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
> +}
> +

Cheers,

-- 
Julien Grall
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
