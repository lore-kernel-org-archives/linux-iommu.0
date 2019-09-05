Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B80EC43331
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 20:57:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EBC206BB
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 20:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SbY27Cfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EBC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C98DE1B3E;
	Thu,  5 Sep 2019 20:57:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 010E318E9
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 20:57:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
	[209.85.222.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6BCF3887
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 20:57:25 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id o11so3582801qkg.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 05 Sep 2019 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=+GMBVTc4YV/8dPn1BEq2LsTFKaa8HMVVMk+zrX4S1nM=;
	b=SbY27Cfn0VelE6EDWcMZslNIxHHxq/+o3RCMSslccCw2cCyjWgWX/0gN93cQbCWe53
	6UY+gzLWmtNbZeLlNDqjYSZzcJtFIqfbn4O+cx+akcHAYURcaNrSxW1rdKFeTRxvArpS
	uyQNvWk2gLA0xzfXdilhNE47/nF8b4SP9ZwfTBERhXGPh0bhDnTRuLCh/hxHgx7nhiJP
	6+XET5szH4In4kSou3WRpcDssJ7OOKC2du7pmeHH00YIEWVlrLSTtUkrZ1Ys1HczYzT4
	wvvZQay+FwaKiBn4M06jojYKHTsdNg8eJJAb/LghTZ5XP2XgGj2caaZNkf0ckXvtHiPa
	SXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+GMBVTc4YV/8dPn1BEq2LsTFKaa8HMVVMk+zrX4S1nM=;
	b=FKQ1zP3jNIDPFlx8QqhU5fV5kuX3k74hDC/Ys9qJQwrMsdkMFQq2gxQ5zZa0kTwpgq
	LcK+YAl398UxUDkrh6ik4SPU13PO6YM37umRUvt7WLMm1L1xhlAVxLA+T+x/WePfOlSs
	g6Vvoitrys1V6XvxH8UA/h20oZFYV1EAE+BFQRVnDsgvP7b1IBwYK3+wYqwUTctaGAL2
	Q3ono558JvbaOL2oPhObnomiYIIx/AcwKBfa1oaun/xyjWPYUmPWuT5IiCOVLqq3d/gU
	I62DypJUBs/n3ZutGyTrHxd2T6VlVAJLAEZyVzfT91mJ/h5IC6J8wt6qZFb1u24MhP16
	cy4A==
X-Gm-Message-State: APjAAAV7qAhAyAfEu8t4Xr64PUV7QklFtPkkGwbI3PUeThtEXrM6UMUS
	Y7Fgf0h2ZtWhXtqft8w8gC5IGA==
X-Google-Smtp-Source: APXvYqzdxQrSoR7cjpSOh5Leh3U8WkBvqTCVfgopweUcRCvJX2VfwWPjVb6STHWq+HNEtRIwi2mALg==
X-Received: by 2002:a37:4b06:: with SMTP id y6mr5238826qka.395.1567717044279; 
	Thu, 05 Sep 2019 13:57:24 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	n187sm1690248qkc.98.2019.09.05.13.57.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 05 Sep 2019 13:57:23 -0700 (PDT)
Message-ID: <1567717041.5576.102.camel@lca.pw>
Subject: Re: [RFC PATCH] iommu/amd: fix a race in increase_address_space()
From: Qian Cai <cai@lca.pw>
To: Joerg Roedel <jroedel@suse.de>
Date: Thu, 05 Sep 2019 16:57:21 -0400
In-Reply-To: <20190905114339.GC5457@suse.de>
References: <1567632262-21284-1-git-send-email-cai@lca.pw>
	<20190905114339.GC5457@suse.de>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: don.brace@microsemi.com, iommu@lists.linux-foundation.org,
	esc.storagedev@microsemi.com, hch@lst.de, linux-kernel@vger.kernel.org
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

On Thu, 2019-09-05 at 13:43 +0200, Joerg Roedel wrote:
> Hi Qian,
> 
> On Wed, Sep 04, 2019 at 05:24:22PM -0400, Qian Cai wrote:
> > 	if (domain->mode == PAGE_MODE_6_LEVEL)
> > 		/* address space already 64 bit large */
> > 		return false;
> > 
> > This gives a clue that there must be a race between multiple concurrent
> > threads in increase_address_space().
> 
> Thanks for tracking this down, there is a race indeed.
> 
> > +	mutex_lock(&domain->api_lock);
> >  	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
> >  				 size, DMA_BIDIRECTIONAL, dma_mask);
> > +	mutex_unlock(&domain->api_lock);
> >  
> >  	if (*dma_addr == DMA_MAPPING_ERROR)
> >  		goto out_free;
> > @@ -2696,7 +2698,9 @@ static void free_coherent(struct device *dev, size_t size,
> >  
> >  	dma_dom = to_dma_ops_domain(domain);
> >  
> > +	mutex_lock(&domain->api_lock);
> >  	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
> > +	mutex_unlock(&domain->api_lock);
> 
> But I think the right fix is to lock the operation in
> increase_address_space() directly, and not the calls around it, like in
> the diff below. It is untested, so can you please try it and report back
> if it fixes your issue?

Yes, it works great so far.

> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index b607a92791d3..1ff705f16239 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1424,18 +1424,21 @@ static void free_pagetable(struct protection_domain *domain)
>   * another level increases the size of the address space by 9 bits to a size up
>   * to 64 bits.
>   */
> -static bool increase_address_space(struct protection_domain *domain,
> +static void increase_address_space(struct protection_domain *domain,
>  				   gfp_t gfp)
>  {
> +	unsigned long flags;
>  	u64 *pte;
>  
> -	if (domain->mode == PAGE_MODE_6_LEVEL)
> +	spin_lock_irqsave(&domain->lock, flags);
> +
> +	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
>  		/* address space already 64 bit large */
> -		return false;
> +		goto out;
>  
>  	pte = (void *)get_zeroed_page(gfp);
>  	if (!pte)
> -		return false;
> +		goto out;
>  
>  	*pte             = PM_LEVEL_PDE(domain->mode,
>  					iommu_virt_to_phys(domain->pt_root));
> @@ -1443,7 +1446,10 @@ static bool increase_address_space(struct protection_domain *domain,
>  	domain->mode    += 1;
>  	domain->updated  = true;
>  
> -	return true;
> +out:
> +	spin_unlock_irqrestore(&domain->lock, flags);
> +
> +	return;
>  }
>  
>  static u64 *alloc_pte(struct protection_domain *domain,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
