Return-Path: <SRS0=EbOf=VF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F2C606D1
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 21:21:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8502086D
	for <iommu@archiver.kernel.org>; Mon,  8 Jul 2019 21:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWu3/Pae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8502086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AD3542B69;
	Mon,  8 Jul 2019 21:21:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D07AF2B6C
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 21:14:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6BEBC148
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Jul 2019 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4XqjvB8u7zFlxXzMlhyIg25Mo75kg5y/T/b1vOkvMuQ=;
	b=NWu3/Paeq68lAHmOovx1RaYCS
	+fMiEi/Dyw++wR2ttVjwSJmHlq/foLNSBJlOmh+88eM/Ab6ulFxxTyppdgPrpv+of7GSSA3oxR6sE
	yoLECi9GOFUmIc1MtFFdY62wCM6i5fSUAvmGwo+SvN5S4ZqkaTIo2E6Wrm6gLIDyJ26/MCA6ZPrrB
	TF0jYNMHldqUe7e0kl0Jtu7/yT7eo4KoqRdx2FT6l0YqQlX6EU2bveprYE5Byb2y+93t5ZtyYhwV0
	0zH5i7JYBisQRTL11u02Xa9VX9T/aPVK7vICA+lNYuk847206DZHp1GrZ2K9cvAoLU3vrjOcA/VFA
	L5BOQv/6g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
	helo=midway.dunlab)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hkaxy-0008K7-W3; Mon, 08 Jul 2019 21:14:31 +0000
Subject: Re: [PATCH] dma-mapping: mark dma_alloc_need_uncached as
	__always_inline
To: Christoph Hellwig <hch@lst.de>
References: <20190708195733.26501-1-hch@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <63deb5f2-8fca-e519-1e0c-b63e765bfc6f@infradead.org>
Date: Mon, 8 Jul 2019 14:14:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708195733.26501-1-hch@lst.de>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 7/8/19 12:57 PM, Christoph Hellwig wrote:
> Without the __always_inline at least i386 configs that have
> CONFIG_OPTIMIZE_INLINING set seem fail to inline
> dma_alloc_need_uncached, leading to a linker error because of
> undefined symbols.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  include/linux/dma-noncoherent.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 53ee36ecdf37..3813211a9aad 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -23,7 +23,7 @@ static inline bool dev_is_dma_coherent(struct device *dev)
>  /*
>   * Check if an allocation needs to be marked uncached to be coherent.
>   */
> -static inline bool dma_alloc_need_uncached(struct device *dev,
> +static __always_inline bool dma_alloc_need_uncached(struct device *dev,
>  		unsigned long attrs)
>  {
>  	if (dev_is_dma_coherent(dev))
> 


-- 
~Randy
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
