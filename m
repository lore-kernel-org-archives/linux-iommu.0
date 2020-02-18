Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3756BC34048
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:16:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0717020801
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nC+ckAaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0717020801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6C4F20489;
	Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogdsZ+TueLoS; Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 23BDB20005;
	Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 163B6C08A0;
	Tue, 18 Feb 2020 17:16:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91729C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:16:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 88E9F86C3A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:16:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQhkZ2IL6PzZ for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 17:16:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 521C986727
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DtnUK1xASlzt/HMPi6EpJNZIY4HCkmIAFuNb2drX+S0=; b=nC+ckAaT3f0TAwRj0Ixv6COnz/
 bA8ppTmtfdRbDRfBmTwGTFcdaCHxAYu9PVgc0w5snowjNkbT+n4eLW1hs54bAMcv0OKxlJTjHavJd
 H6gMAgypDPoZMtrY7/TZ82zhFO8PUHqCaXqU1KHWKMmFgJ/uZeuC9/w7wTfEN+SwvyLl934e1cw4n
 VO/cEhnVRwSmNe+zRgzOM+E0iq5RN3m2K4Xf6CQ+Kvud+VDqfpWJDDXeN4h2iwPQ0rrYI4Xs6yWZc
 hweugJeJIVA6jl7GSvXKH8i0l9nvCgc9svIb+7fOJo7kt/zfvx30a/iQevoRSoy8JZuPYPa3NFrVu
 6tnzLF2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j46Tp-0005de-Ng; Tue, 18 Feb 2020 17:16:17 +0000
Date: Tue, 18 Feb 2020 09:16:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/5] iommu/vt-d: Move deferred device attachment into
 helper function
Message-ID: <20200218171617.GB7067@infradead.org>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200217193858.26990-3-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, jroedel@suse.de,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
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

> +static void do_deferred_attach(struct device *dev)
>  {
> +	struct iommu_domain *domain;
>  
> +	dev->archdata.iommu = NULL;
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (domain)
> +		intel_iommu_attach_device(domain, dev);
> +}
> +
> +static struct dmar_domain *deferred_attach_domain(struct device *dev)
> +{
> +	if (unlikely(attach_deferred(dev)))
> +		do_deferred_attach(dev);
>  
>  	return find_domain(dev);
>  }

Can we start using proper sybmbol prefixes and avoid do_* names where
possible?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
