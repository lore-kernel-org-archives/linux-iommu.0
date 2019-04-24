Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D822C282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:32:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF87F218FE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F4MBxL3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF87F218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9A31213B8;
	Wed, 24 Apr 2019 14:32:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F73011B0
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:32:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EC83E786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 14:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HH6es2owcH1NcV2/iXg+dvHnsEeqH9IglqJIj3+7hj8=;
	b=F4MBxL3d56lZLKwK2Dt9NbXbG
	Y6yc9XvLpG4AXRwmThWqtySUpjjaMbKclSBKS+x7vFyIy0ZA+oANaRj6QhwwCwz8VtjlPcVGg9JFC
	cOL3sF5/EmtJKKT4Q0OGQlx/T3fr9fwc9u+6ca9mMxieBuBYo1hx05k0QfvgterpvNu37rdj8DFHz
	vee6uyung/Ue7elGZKJiSYTKEfeIpSWUlBUDq+QIu6K58DGk2H2q9BJ83wEkFhTdUuDgs5sQaitxN
	DngHKU7Q+1iNG6WraZo5JIkwKC2rTNzcZK70jgc8sNF/4oqnn8wklLOhVlczF24mrSbj1zZj07utm
	eJ9QdC7eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hJIx4-0008FO-5m; Wed, 24 Apr 2019 14:32:46 +0000
Date: Wed, 24 Apr 2019 07:32:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190424143246.GA24079@infradead.org>
References: <20190424141900.8883-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424141900.8883-1-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424143246.twDsSxCId0PzuzkeMQHUKk7KWspd0SwIDDTV2n2fx9E@z>

On Wed, Apr 24, 2019 at 03:18:59PM +0100, Tom Murphy via iommu wrote:
> check if there is a not-present cache present and flush it if there is.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f7cdd2ab7f11..8ef43224aae0 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
>  		pte[i] = __pte;
>  
>  	update_domain(dom);
> +	if (!dom->updated) {
> +		if (unlikely(amd_iommu_np_cache)) {
> +			domain_flush_pages(dom, bus_addr, page_size);
> +			domain_flush_complete(dom);
> +		}
> +	}

The two conditions can go into one if statement to make this a little
more clear.

And I'd really like to understand the unlikely - amd_iommu_np_cache
is set based on a hardware capability, so it seems rather odd to mark
it unlikely.  Dynamic branch prediction really should do the right thing
here usually.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
