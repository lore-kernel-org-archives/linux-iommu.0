Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD03C3A59E
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 09:21:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F34E22CF8
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 09:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F34E22CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E98C1375;
	Mon, 26 Aug 2019 09:21:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EF5F81371
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 09:20:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 85CF38A3
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 09:20:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46384227A81; Mon, 26 Aug 2019 11:20:01 +0200 (CEST)
Date: Mon, 26 Aug 2019 11:20:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [Xen-devel] [PATCH 01/11] xen/arm: use dma-noncoherent.h calls
	for xen-swiotlb cache maintainance
Message-ID: <20190826092001.GA13476@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
	<20190816130013.31154-2-hch@lst.de>
	<65248838-f273-6097-22f4-e5809078ddba@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65248838-f273-6097-22f4-e5809078ddba@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Aug 19, 2019 at 12:45:17PM +0100, Julien Grall wrote:
> On 8/16/19 2:00 PM, Christoph Hellwig wrote:
>> +static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
>> +	     dma_addr_t dev_addr, unsigned long offset, size_t size,
>> +	     enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	unsigned long page_pfn = page_to_xen_pfn(page);
>> +	unsigned long dev_pfn = XEN_PFN_DOWN(dev_addr);
>> +	unsigned long compound_pages =
>> +		(1<<compound_order(page)) * XEN_PFN_PER_PAGE;
>> +	bool local = (page_pfn <= dev_pfn) &&
>> +		(dev_pfn - page_pfn < compound_pages);
>> +
>
> The Arm version as a comment here. Could we retain it?

I've added it in this patch, altough the rewrites later on mean it will
go away in favour of a new comment elsewhere anyway.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
