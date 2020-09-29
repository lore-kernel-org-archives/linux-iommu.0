Return-Path: <SRS0=l9dJ=DG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69978C4346E
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:03:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B7120C09
	for <iommu@archiver.kernel.org>; Tue, 29 Sep 2020 06:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXuJQuGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B7120C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AED686FEB;
	Tue, 29 Sep 2020 06:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j4BkzO8-YmrU; Tue, 29 Sep 2020 06:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0DEA686FD5;
	Tue, 29 Sep 2020 06:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5A45C016F;
	Tue, 29 Sep 2020 06:03:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C946C0051
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7B4E686FD5
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mZ2MY2l6iO6K for <iommu@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 06:03:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AF65486FCF
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 06:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=48XgreAjZs4gur0K4ZOCA5DaxMVnkVf7Jp8MpcZsDas=; b=oXuJQuGq0ROHVISt/bjm7XwpEh
 yG1nifrbWvewLtpXqRZ9xyNslwmyidUDLomZWW23JWBNnJAvP6eIetGY6HpbtslVV9oFUmTRnH492
 7h7vO7W1sZ/atG+giK+SI9EcEpbQYGXCgsmL4XSnR+ZbjtLwmu5KeJ/Ix7yXEiFiDpu+mkJf8atJy
 4pT+9vlpeuXzcjNoezx+i0Y6cm69s2ISSTlbkTndF1TyYZ/x/z9cmYxWBtKjDs8jj+kwYacrk8ILP
 4Rqpb+UvBAghohjGOS1gwmSRuFahG2XBHC+chUMcdhvDJq5AdhdDc1x+gjpNddd7uzfIpZaHUHTfj
 RAGa15Qg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kN8jD-0001sZ-AE; Tue, 29 Sep 2020 06:03:07 +0000
Date: Tue, 29 Sep 2020 07:03:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC 2/3] iommu: Account for dma_mask and iommu aperture in IOVA
 reserved regions
Message-ID: <20200929060307.GA6564@infradead.org>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928195037.22654-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928195037.22654-3-eric.auger@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: alex.williamson@redhat.com, jean-philippe.brucker@arm.com,
 dwmw2@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 eric.auger.pro@gmail.com
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

On Mon, Sep 28, 2020 at 09:50:36PM +0200, Eric Auger wrote:
> VFIO currently exposes the usable IOVA regions through the
> VFIO_IOMMU_GET_INFO ioctl. However it fails to take into account
> the dma_mask of the devices within the container. The top limit
> currently is defined by the iommu aperture.

Can we take a step back here?  The dma_mask only has a meaning for
the DMA API, and not the iommu API, it should have no relevance here.

More importantly if we are using vfio no dma_mask should be set to
start with.

> +		if (geo.aperture_end < ULLONG_MAX && geo.aperture_end != geo.aperture_start) {

Please avoid pointlessly overlong lines.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
