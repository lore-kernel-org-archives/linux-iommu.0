Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B47C433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21AC610E5
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21AC610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B779C83FF6;
	Thu,  8 Apr 2021 13:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4HCkXdJOGJ94; Thu,  8 Apr 2021 13:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FBF083A63;
	Thu,  8 Apr 2021 13:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C839C000B;
	Thu,  8 Apr 2021 13:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA87C000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DD0B40105
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OI7e5yEwNd1V for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 13:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6CD840100
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:59:30 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AD6C610E5;
 Thu,  8 Apr 2021 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617890370;
 bh=5WxiFj+zfcSMpEsdijyRfOvg6VNorTqG6TDfdppl/PQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ctpePctjesOlc5aRRx2wqrL12H3cK8WmYPvrPcS9H6S3Md+VgnodkXnpZT9ILZwPG
 rFE5jCsQIHKRY1NYQ4BulpGW0n9U8c93OrbnKnreVVy6h9UQJAAskFSEbCaCA7pyu8
 0+SeFAk4I8h0Tg8CU2S7rsBOrFO2GAJ9340wb8kca+5CZVfGXaC+/OWovVkd/9OlRK
 He0/77Q/F6vVQsMHC4zLF21xTpRhv92+95jy7e2i90AVn0Wt2HsQamfax9BKq2zsV6
 D59gRIA5LFSKtxRXuCYQmxDZG1NWrggGu1GHAWhDdmIMKMFImBZMs3WGxvyCgE12+D
 PaZ22QWU/JAEA==
Date: Thu, 8 Apr 2021 14:59:26 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v4 09/15] iommu/io-pgtable-arm: Prepare PTE methods
 for handling multiple entries
Message-ID: <20210408135925.GC17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-10-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408045241.27316-10-isaacm@codeaurora.org>
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

On Wed, Apr 07, 2021 at 09:52:35PM -0700, Isaac J. Manjarres wrote:
> The PTE methods currently operate on a single entry. In preparation
> for manipulating multiple PTEs in one map or unmap call, allow them
> to handle multiple PTEs.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 78 +++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 87def58e79b5..ea66b10c04c4 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -232,20 +232,23 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
>  	free_pages((unsigned long)pages, get_order(size));
>  }
>  
> -static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep,
> +static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>  				struct io_pgtable_cfg *cfg)
>  {
>  	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
> -				   sizeof(*ptep), DMA_TO_DEVICE);
> +				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>  }

Have you tested this with CONFIG_DMA_API_DEBUG=y? I _think_ it should be
ok as long as we don't attempt to sync across a page boundary, but it would
be good to give it a spin just to check.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
