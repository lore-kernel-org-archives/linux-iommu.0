Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C69AC433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:57:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B66613B8
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B66613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE399402D7;
	Tue,  6 Apr 2021 11:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4gB0IBV59_dx; Tue,  6 Apr 2021 11:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E104401D0;
	Tue,  6 Apr 2021 11:57:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DEB4C000B;
	Tue,  6 Apr 2021 11:57:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75290C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6291F402D7
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FMkap9D3qnWY for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 11:57:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2DF7401D0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:57:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 508D6613B3;
 Tue,  6 Apr 2021 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617710264;
 bh=kMBq36ttYBn25xInlOZKxP1/qXt+qqhvwqWmyd1Dln8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gXev4GvIBjXhDbxah9AysmMr/0AW/8gbpH7tY4WisGKlQ+ef9ieu5n6GjrrOlfaxs
 tjb1B8KyfF+qtWhDI13tyQ3n4AtODS8/H8RVxjMb5+BouYxAumKQ9X4Jut4THk6myO
 90elXiUc9HXI7u2r5eza1zY8s+89HVRdZ++wBFtK1aZ+7vLDZUZ8qXdHtcc0yir906
 QhAchivm6Hewn7MIk9QNhkPg/BwIpq2VKFwOX0VOI6uoD36RrnzvcjVNQSjToCp7cD
 P8GpkziCOaM9MbkYyCQowk57ghPAaO1eOYUNZQsJOgYnNQKLpu8Si128S9O+ysXr8+
 +yX9hVdlSo6cw==
Date: Tue, 6 Apr 2021 12:57:40 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v3 03/12] iommu/io-pgtable: Introduce map_pages() as
 a page table op
Message-ID: <20210406115739.GD13747@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-4-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210405191112.28192-4-isaacm@codeaurora.org>
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

On Mon, Apr 05, 2021 at 12:11:03PM -0700, Isaac J. Manjarres wrote:
> Mapping memory into io-pgtables follows the same semantics
> that unmapping memory used to follow (i.e. a buffer will be
> mapped one page block per call to the io-pgtable code). This
> means that it can be optimized in the same way that unmapping
> memory was, so add a map_pages() callback to the io-pgtable
> ops structure, so that a range of pages of the same size
> can be mapped within the same call.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>  include/linux/io-pgtable.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 2ed0c057d9e7..019149b204b8 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -143,6 +143,7 @@ struct io_pgtable_cfg {
>   * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
>   *
>   * @map:          Map a physically contiguous memory region.
> + * @map_pages:    Map a physically contiguous range of pages of the same size.
>   * @unmap:        Unmap a physically contiguous memory region.
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
>   * @iova_to_phys: Translate iova to physical address.
> @@ -153,6 +154,9 @@ struct io_pgtable_cfg {
>  struct io_pgtable_ops {
>  	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> +	int (*map_pages)(struct io_pgtable_ops *ops, unsigned long iova,
> +			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
> +			 int prot, gfp_t gfp, size_t *mapped);

How about returning 'size_t' and using IS_ERR_VALUE() instead of adding
the extra 'mapped' argument (i.e. return the size of the region mapped
or an error code)? I don't think we realistically need to care about map
sizes that overlap with the error region.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
