Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71246ECE58D
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 06:57:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AED620B7C
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 06:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZwHQym2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AED620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DD6D3A7F;
	Wed,  9 Oct 2019 06:57:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C2DAEA70
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 06:57:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 725085F4
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vKBYsQl0kFkDyRT0YqTcpHkTEz1PkuhlbRjhgXM8cpI=;
	b=ZwHQym2evAmhibdUSByOi4oUR
	bjhksOQoCEsVgWc1Q7wt4kWAT4Qn+mT8oJq1nsHWv5QWqRdAYS23zZXfCI1HjYth326SrqPDAWzaX
	txIsXC5PlOjyr0IVvhgCg9ccyKd2Cei3w0mr3fkf+Zf4ZC6zFU1fNeU6slJbqWmNKZG7mBmOd2pfh
	He9wexKeaahpCma16N86FmPTvXYD2/HNgyX18UreFdYmTusZFm6MQ7fMiQK3E5MijC/wUeWkH1nVt
	Tf1uXz2T15Why6bUyJ5C5oAKWlSAVLY93rRlxUmzU/SLNOTxQP8m1LNRvZ5tBZT1XDPyuE+C910Ht
	+3kNrli3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red
	Hat Linux)) id 1iI5uw-0004hU-S3; Wed, 09 Oct 2019 06:57:50 +0000
Date: Tue, 8 Oct 2019 23:57:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/3] iommu/amd: Implement dma_[un]map_resource()
Message-ID: <20191009065750.GA17832@infradead.org>
References: <20191008221837.13067-1-logang@deltatee.com>
	<20191008221837.13067-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191008221837.13067-2-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, Kit Chow <kchow@gigaio.com>,
	linux-kernel@vger.kernel.org
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

On Tue, Oct 08, 2019 at 04:18:35PM -0600, Logan Gunthorpe wrote:
> From: Kit Chow <kchow@gigaio.com>
> 
> Currently the Intel IOMMU uses the default dma_[un]map_resource()

s/Intel/AMD/ ?

> +static dma_addr_t map_resource(struct device *dev, phys_addr_t paddr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	struct protection_domain *domain;
> +	struct dma_ops_domain *dma_dom;
> +
> +	domain = get_domain(dev);
> +	if (PTR_ERR(domain) == -EINVAL)
> +		return (dma_addr_t)paddr;

I thought that case can't happen anymore?

Also note that Joerg just applied the patch to convert the AMD iommu
driver to use the dma-iommu ops.  Can you test that series and check
it does the right thing for your use case?  From looking at the code
I think it should.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
