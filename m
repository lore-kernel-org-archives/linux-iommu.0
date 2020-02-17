Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E4C7619D
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 08:03:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7DF20726
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 08:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pR6w489j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7DF20726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B9D1186E1A;
	Mon, 17 Feb 2020 08:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mURemCMmH3L2; Mon, 17 Feb 2020 08:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 28E9386DF1;
	Mon, 17 Feb 2020 08:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 098F1C08A0;
	Mon, 17 Feb 2020 08:03:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ABB7C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 08:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0A77D20016
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 08:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7m2ndTilefWe for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 08:03:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by silver.osuosl.org (Postfix) with ESMTPS id A72E21FD90
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8P83UJrtckadRvtNN0mURBLMcfies6xy/6xqO0urT5o=; b=pR6w489jwpWzTZkIt7TS4VRUAT
 0iSpnLjSF3rARv6DXNVyvB6Aa8BpTMgegD65WXsrGIk3psu+zT3RutRyP/8rP6glPkf75451XC85e
 tLs9mTddvqYGiw6MYBcVAD0UGxELfFiWqXvOfSTq4oupG2xHkvrz9mFUFAYRhLSB5WgAsbWb/oWB6
 i0egE74ary8QC3yIaRA3wZ+eLHzFiNwnA5km1BSyqkaKvltZLF0MLQvQIO7gS0drwvPPv8qqiomGC
 CFI1U5+529P/6m+E+khKN6UFr+0beNGTLcNBxKVtKBIqHZO7D5UqpsmZV1QimSIrlgUPEz7J+mdlR
 XjylMqfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j3bNT-0005bX-51; Mon, 17 Feb 2020 08:03:39 +0000
Date: Mon, 17 Feb 2020 00:03:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH] iommu/iova: Add a best-fit algorithm
Message-ID: <20200217080339.GC10342@infradead.org>
References: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1581721602-17010-1-git-send-email-isaacm@codeaurora.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: pratikp@codeaurora.org, linux-kernel@vger.kernel.org,
 Liam Mark <lmark@codeaurora.org>, iommu@lists.linux-foundation.org,
 kernel-team@android.com
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

On Fri, Feb 14, 2020 at 03:06:42PM -0800, Isaac J. Manjarres wrote:
> From: Liam Mark <lmark@codeaurora.org>
> 
> Using the best-fit algorithm, instead of the first-fit
> algorithm, may reduce fragmentation when allocating
> IOVAs.

As we like to say in standards groups:  may also implies may not.
Please provide numbers showing that this helps, and preferably and
explanation how it doesn't hurt as well.

> + * Should be called prior to using dma-apis.
> + */
> +int iommu_dma_enable_best_fit_algo(struct device *dev)
> +{
> +	struct iommu_domain *domain;
> +	struct iova_domain *iovad;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || !domain->iova_cookie)
> +		return -EINVAL;
>  
> +	iovad = &((struct iommu_dma_cookie *)domain->iova_cookie)->iovad;
> +	iovad->best_fit = true;
>  	return 0;
>  }
> +EXPORT_SYMBOL(iommu_dma_enable_best_fit_algo);

Who is going to call this?  Patches adding exports always need a user
that goes along with the export.  Also drivers have no business calling
directly into dma-iommu.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
