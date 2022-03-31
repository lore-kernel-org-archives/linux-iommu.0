Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E4C433F5
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 04:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2656E60BEA;
	Thu, 31 Mar 2022 04:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GAW66K4E1g5f; Thu, 31 Mar 2022 04:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E28C460BA4;
	Thu, 31 Mar 2022 04:08:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC7AFC001D;
	Thu, 31 Mar 2022 04:08:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7483EC0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 04:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B47140467
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 04:08:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u9U5xS4_Gy2m for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 04:08:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A378B4031F
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 04:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TyI6lSLb2VMNQkD37oAbbw8GrUUXDy6JGKq3S68+GAs=; b=N2RXeHOlVWMotZnWmDzYjFmRvE
 1rwxS4cCRHz+rrLZW3bq1Klzv9tSR/P+pFfwJduGkx/RHOrXbiCGigZQezP+2RVGDrWeUW6b4ldS7
 Et5MhqtaU7oAaftlUdnP24FfW5v95xyYRqsGlVWKkHMEECZwvSZ3Xeu+n9h9yLangvp/XsKl9mWvO
 /5GM1jSiGKNMTxt2HGVyV0jgNaRgnd9B0SkYHVtMI7oHPcViliW7Dt7dpLkQub0DtM1tpkHMAr5E6
 3QoetEDLgY2g5033b79N10yje6RFYtjVWzlHVxBAlO11pMWi5ASbag1mt5Ugh5T1eB3zc0mC0GmAT
 y8Pda/ZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nZm71-000atJ-TS; Thu, 31 Mar 2022 04:08:43 +0000
Date: Wed, 30 Mar 2022 21:08:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: "dma-mapping: remove CONFIG_DMA_REMAP" causes AMD SME boot fail
Message-ID: <YkUpSy4snmZ7E5xX@infradead.org>
References: <1648659326.eabkokyuym.none.ref@localhost>
 <1648659326.eabkokyuym.none@localhost>
 <YkSa9d3JOExAiBXU@infradead.org>
 <1648667469.u35o6clg82.none@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1648667469.u35o6clg82.none@localhost>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
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

On Wed, Mar 30, 2022 at 03:17:20PM -0400, Alex Xu (Hello71) wrote:
> Excerpts from Christoph Hellwig's message of March 30, 2022 2:01 pm:
> > Can you try this patch, which is a bit of a hack?
> > 
> > diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> > index 50d209939c66c..61997c2ee0a17 100644
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -28,7 +28,8 @@ bool force_dma_unencrypted(struct device *dev)
> >  	 * device does not support DMA to addresses that include the
> >  	 * encryption mask.
> >  	 */
> > -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> > +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) &&
> > +	    !get_dma_ops(dev)) {
> >  		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
> >  		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
> >  						dev->bus_dma_limit);
> > 
> 
> This seems to work for me.

Ok, I'll try to come up with a less hacky version and will start a
discussion with the AMD folks that know memory encryption better.
Thanks for the report and testing already!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
