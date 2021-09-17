Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79608C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 20:04:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125E2611C3
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 20:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 125E2611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D03C84047E;
	Fri, 17 Sep 2021 20:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id epI5pZSxRPKz; Fri, 17 Sep 2021 20:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C861400EA;
	Fri, 17 Sep 2021 20:04:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63D5AC000F;
	Fri, 17 Sep 2021 20:04:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA9BC000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 20:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AF3261BEA
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 20:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id grIA7bBWjP0A for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 20:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C305860B91
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 20:04:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18D11611C3;
 Fri, 17 Sep 2021 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631909091;
 bh=mEyjE0OtAQmdOBy6JF1uWMiaz+LsaQ2TOO9N0GzD4q8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=TwffbNS4RL5k7jgYAk9bPvqGar9gPSXlDk7tGrFRJS6vG73q/79FwFr4xCCJNw66u
 faPcb3eKXbUXcWv89rMvuYi/3EqZIZqPynZ0WV/pN974Hj6SuS9OvfoEUzia0kGSgw
 mzsjR/DoMpf7tw4UA3fGaUygmCF//mPQMFR0RSwEkTVgEGfu0fJtHyKA2mJa1p15cL
 7iBAO8W5stpj5jk+KUlDxzg1MU6JehWVMawg6sskx2DvAncMAwMtsqXL9ioGWwOMYY
 VslTVrm1j8TiDQ36VTupNVotaWGVYguVOhI/f4EI09U3JMvFkddeor/0PdlCclJ7XV
 T6eyo4p4Y6/pA==
Date: Fri, 17 Sep 2021 13:04:50 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH v2 1/4] swiotlb-xen: ensure to issue well-formed
 XENMEM_exchange requests
In-Reply-To: <7b3998e3-1233-4e5a-89ec-d740e77eb166@suse.com>
Message-ID: <alpine.DEB.2.21.2109171304380.21985@sstabellini-ThinkPad-T480s>
References: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com>
 <7b3998e3-1233-4e5a-89ec-d740e77eb166@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Wilk <konrad.wilk@oracle.com>, lkml <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, "hch@lst.de" <hch@lst.de>
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

On Fri, 17 Sep 2021, Jan Beulich wrote:
> While the hypervisor hasn't been enforcing this, we would still better
> avoid issuing requests with GFNs not aligned to the requested order.
> Instead of altering the value also in the call to panic(), drop it
> there for being static and hence easy to determine without being part
> of the panic message.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> I question how useful it is to wrap "bytes" in PAGE_ALIGN(), when it is
> a multiple of a segment's size anyway (or at least was supposed to be,
> prior to "swiotlb-xen: maintain slab count properly"). But that's
> perhaps yet another separate patch.
> ---
> v2: Drop logging of alignment. Wrap lines.
> 
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -230,10 +230,11 @@ retry:
>  	/*
>  	 * Get IO TLB memory from any location.
>  	 */
> -	start = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
> +	start = memblock_alloc(PAGE_ALIGN(bytes),
> +			       IO_TLB_SEGSIZE << IO_TLB_SHIFT);
>  	if (!start)
> -		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -		      __func__, PAGE_ALIGN(bytes), PAGE_SIZE);
> +		panic("%s: Failed to allocate %lu bytes\n",
> +		      __func__, PAGE_ALIGN(bytes));
>  
>  	/*
>  	 * And replace that memory with pages under 4GB.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
