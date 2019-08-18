Return-Path: <SRS0=WGHm=WO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F7DC3A589
	for <iommu@archiver.kernel.org>; Sun, 18 Aug 2019 22:38:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0525A21855
	for <iommu@archiver.kernel.org>; Sun, 18 Aug 2019 22:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0525A21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mni.thm.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 83FE8B3E;
	Sun, 18 Aug 2019 22:38:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5EA83B2F
	for <iommu@lists.linux-foundation.org>;
	Sun, 18 Aug 2019 22:38:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mout2.fh-giessen.de (mout2.fh-giessen.de [212.201.18.46])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A0CC7711
	for <iommu@lists.linux-foundation.org>;
	Sun, 18 Aug 2019 22:38:45 +0000 (UTC)
Received: from mx1.fh-giessen.de ([212.201.18.40])
	by mout2.fh-giessen.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hzTot-00006F-7x; Mon, 19 Aug 2019 00:38:39 +0200
Received: from mailgate-3.its.fh-giessen.de ([212.201.18.34])
	by mx1.fh-giessen.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hzTot-00BKMq-28; Mon, 19 Aug 2019 00:38:39 +0200
Received: from p2e561b42.dip0.t-ipconnect.de ([46.86.27.66]
	helo=[192.168.1.24]) by mailgate-3.its.fh-giessen.de with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
	(envelope-from <tobias.johannes.klausmann@mni.thm.de>)
	id 1hzTos-0003g0-O3; Mon, 19 Aug 2019 00:38:38 +0200
Subject: Re: regression in ath10k dma allocation
To: Hillf Danton <hdanton@sina.com>
References: <8fe8b415-2d34-0a14-170b-dcb31c162e67@mni.thm.de>
	<20190816164301.GA3629@lst.de>
	<af96ea6a-2b17-9b66-7aba-b7dae5bcbba5@mni.thm.de>
	<20190816222506.GA24413@Asurada-Nvidia.nvidia.com>
	<20190818031328.11848-1-hdanton@sina.com>
From: Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>
Message-ID: <acd7a4b0-fde8-1aa2-af07-2b469e5d5ca7@mni.thm.de>
Date: Mon, 19 Aug 2019 00:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:70.0) Gecko/20100101
	Thunderbird/70.0a1
MIME-Version: 1.0
In-Reply-To: <20190818031328.11848-1-hdanton@sina.com>
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
	davem@davemloft.net, Nicolin Chen <nicoleotsuka@gmail.com>,
	iommu@lists.linux-foundation.org, tobias.klausmann@freenet.de,
	robin.murphy@arm.com, Christoph Hellwig <hch@lst.de>, kvalo@codeaurora.org
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


On 18.08.19 05:13, Hillf Danton wrote:
> On Sat, 17 Aug 2019 00:42:48 +0200 Tobias Klausmann wrote:
>> Hi Nicolin,
>>
>> On 17.08.19 00:25, Nicolin Chen wrote:
>>> Hi Tobias
>>>
>>> On Fri, Aug 16, 2019 at 10:16:45PM +0200, Tobias Klausmann wrote:
>>>>> do you have CONFIG_DMA_CMA set in your config?  If not please make sure
>>>>> you have this commit in your testing tree, and if the problem still
>>>>> persists it would be a little odd and we'd have to dig deeper:
>>>>>
>>>>> commit dd3dcede9fa0a0b661ac1f24843f4a1b1317fdb6
>>>>> Author: Nicolin Chen <nicoleotsuka@gmail.com>
>>>>> Date:   Wed May 29 17:54:25 2019 -0700
>>>>>
>>>>>        dma-contiguous: fix !CONFIG_DMA_CMA version of dma_{alloc, free}_contiguous()
>>>> yes CONFIG_DMA_CMA is set (=y, see attached config), the commit you mention
>>>> above is included, if you have any hints how to go forward, please let me
>>>> know!
>>> For CONFIG_DMA_CMA=y, by judging the log with error code -12, I
>>> feel this one should work for you. Would you please check if it
>>> is included or try it out otherwise?
>>>
>>> dma-contiguous: do not overwrite align in dma_alloc_contiguous()
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c6622a425acd1d2f3a443cd39b490a8777b622d7
>>
>> Thanks for the hint, yet the commit is included and does not fix the
>> problem!
>>
Hi Hillf,

i just tested you first hunk (which comes from kernel/dma/direct.c if 
i'm not mistaken), it did not compile on its own, yet with a tiny bit of 
work it did, and it does indeed solve the regression. But if using that 
is the "right" way to do it, not sure, but its not on me to decide.

Anyway: Thanks for the hint,

Tobias


> Hi Tobias
>
> Two minor diffs below in hope that they might make sense.
>
> 1, fallback unless dma coherent ok.
>
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -246,6 +246,10 @@ struct page *dma_alloc_contiguous(struct
>   		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
>   
>   		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> +		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> +			dma_free_contiguous(dev, page, size);
> +			page = NULL;
> +		}
>   	}
>   
>   	/* Fallback allocation of normal pages */
> --
>
> 2, cleanup: cma unless contiguous
>
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -234,18 +234,13 @@ struct page *dma_alloc_contiguous(struct
>   	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	size_t align = get_order(PAGE_ALIGN(size));
>   	struct page *page = NULL;
> -	struct cma *cma = NULL;
> -
> -	if (dev && dev->cma_area)
> -		cma = dev->cma_area;
> -	else if (count > 1)
> -		cma = dma_contiguous_default_area;
>   
>   	/* CMA can be used only in the context which permits sleeping */
> -	if (cma && gfpflags_allow_blocking(gfp)) {
> +	if (count > 1 && gfpflags_allow_blocking(gfp)) {
>   		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
>   
> -		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
> +		page = cma_alloc(dev_get_cma_area(dev), count, cma_align,
> +							gfp & __GFP_NOWARN);
>   		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>   			dma_free_contiguous(dev, page, size);
>   			page = NULL;
> --
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
