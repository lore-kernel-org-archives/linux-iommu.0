Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F5C433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 15:43:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC9E20723
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qiOxssgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC9E20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2F45884F6;
	Thu, 15 Oct 2020 15:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rWTRZ+4ltm-A; Thu, 15 Oct 2020 15:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BC2988504;
	Thu, 15 Oct 2020 15:43:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27FCDC0052;
	Thu, 15 Oct 2020 15:43:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB228C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 15:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9934B20496
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 15:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 97Vb3Vwu4HWK for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 15:43:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 8DDAF2049C
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 15:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UfF27sEhMEzOUuKtPSUEIOacG1Uky8VuZ8tGa3014PI=; b=qiOxssgQW83wNoO58DAw8tk3KM
 6/ParIJvMZcFbEexanutV1KdiUSZOc3afV+2l385wIqUCM9Bql2GiliQ7M12ViBDqRZMTv6GsgZ7i
 syWH7IiNDdCFjYdl9rmUk42ULFbtRTpf1BD1qC0MndqdpcL7hGW1qoHq9gVSH0A/HOkXMSTlwbcGf
 PjGyBfbQF5bpNnaIkY8JQWQiX1CW8OPnbXw5euPHZvPN/fnOYCHsTQ2Kpoq6UaDpavzkVc5nbMwFX
 GMHLA0c5pnv6/tjJra+LzV/VR7fzT+gd0EZL7JkRykOuyDTrvSIR6OOM8r+VjfPdu6RWp2HQ/8yDh
 ebdqRieQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kT5PA-00027N-RG; Thu, 15 Oct 2020 15:43:00 +0000
Date: Thu, 15 Oct 2020 16:43:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Jonathan Marek <jonathan@marek.ca>, David Airlie <airlied@linux.ie>,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 2/3] drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent
 cache maintenance
Message-ID: <20201015154300.GA8047@infradead.org>
References: <20201002075321.GA7547@infradead.org>
 <b22fb797-67b0-a912-1d23-2b47c9a9e674@marek.ca>
 <20201005082914.GA31702@infradead.org>
 <3e0b91be-e4a4-4ea5-7d58-6e71b8d51932@marek.ca>
 <20201006072306.GA12834@infradead.org>
 <148a1660-f0fc-7163-2240-6b94725342b5@marek.ca>
 <20201007062519.GA23519@infradead.org>
 <c3baadae-8e20-86a6-44f5-4571a8d3035e@arm.com>
 <20201015065532.GA15371@infradead.org>
 <20201015153334.GF438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201015153334.GF438822@phenom.ffwll.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Thu, Oct 15, 2020 at 05:33:34PM +0200, Daniel Vetter wrote:
> On Thu, Oct 15, 2020 at 07:55:32AM +0100, Christoph Hellwig wrote:
> > On Tue, Oct 13, 2020 at 02:42:38PM +0100, Robin Murphy wrote:
> > > I still think this situation would be best handled with a variant of
> > > dma_ops_bypass that also guarantees to bypass SWIOTLB, and can be set
> > > automatically when attaching to an unmanaged IOMMU domain.
> > 
> > dma_ops_bypass should mostly do the right thing as-is.  swiotlb bouncing
> > is triggered of two things:
> > 
> >  1) the dma_mask.  This is under control of the driver, and obviously
> >     if it is too small for a legit reason we can't just proceed
> 
> Somewhat related, but is there a way to tell the dma-api to fail instead
> of falling back to swiotlb? In many case for gpu drivers it's much better
> if we fall back to dma_alloc_coherent and manage the copying ourselves
> instead of abstracting this away in the dma-api. Currently that's "solved"
> rather pessimistically by always allocating from dma_alloc_coherent if
> swiotlb could be in the picture (at least for ttm based drivers, i915 just
> falls over).

Is this for the alloc_pages plus manually map logic in various drivers?

They should switch to the new dma_alloc_pages API that I'll send to
Linus for 5.10 soon.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
