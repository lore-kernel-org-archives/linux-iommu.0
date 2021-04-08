Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D9AC433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7E4610FA
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E4610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84BD0404F3;
	Thu,  8 Apr 2021 13:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UX5pUPQ3KnRV; Thu,  8 Apr 2021 13:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43532400D3;
	Thu,  8 Apr 2021 13:59:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21B43C000D;
	Thu,  8 Apr 2021 13:59:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A16B2C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FD4E404F3
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMDnMqg5I6UN for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 13:59:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6F15404DD
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:59:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71230610E5;
 Thu,  8 Apr 2021 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617890346;
 bh=8IWsl6GMqV37UR3jv77+NqftgTcuKg05o/NA/LPP4A8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u/oPYDZbpEOEszEg/96PQJpKDuG1uU70tsaXBC+UBvWu9kwgxiQ6H1WbC0O8MiOcm
 kiJP9FhX9EHzzDblJnpvQ4nKl9fgAIF+fKgk3bgHQ3npgq8S/qnT03xEVFM1eadnpr
 MoKH4vtF+uWEg5acT5ZXAwaPZQNLpaOxfcy5YCr/pSj1IdQdD36gac8mY3PpxTy674
 wY4cxxCQl9y170YtFGx5xfDmBfgLGF7r0CW9x0NLTlXjPBRRb5dU8VJdk53EbRJVHg
 4KfxPMHgNBr11+a+4vrYdHoBriB2i0Tn/FKAFXh+K0gEIVU9J3XWzHMByZWD6s5EHA
 kxvB0wRZNjBDw==
Date: Thu, 8 Apr 2021 14:59:02 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v4 06/15] iommu: Split 'addr_merge' argument to
 iommu_pgsize() into separate parts
Message-ID: <20210408135901.GB17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-7-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408045241.27316-7-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Wed, Apr 07, 2021 at 09:52:32PM -0700, Isaac J. Manjarres wrote:
> From: Will Deacon <will@kernel.org>
> 
> The 'addr_merge' parameter to iommu_pgsize() is a fabricated address
> intended to describe the alignment requirements to consider when
> choosing an appropriate page size. On the iommu_map() path, this address
> is the logical OR of the virtual and physical addresses.
> 
> Subsequent improvements to iommu_pgsize() will need to check the
> alignment of the virtual and physical components of 'addr_merge'
> independently, so pass them in as separate parameters and reconstruct
> 'addr_merge' locally.
> 
> No functional change.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  drivers/iommu/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index bcd623862bf9..ab689611a03b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2357,12 +2357,13 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>  }
>  EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>  
> -static size_t iommu_pgsize(struct iommu_domain *domain,
> -			   unsigned long addr_merge, size_t size)
> +static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
> +			   phys_addr_t paddr, size_t size)
>  {
>  	unsigned int pgsize_idx;
>  	unsigned long pgsizes;
>  	size_t pgsize;
> +	phys_addr_t addr_merge = paddr | iova;

^^^ this needs to be 'unsigned long' as it was before (otherwise using
GENMASK _is_ a problem).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
