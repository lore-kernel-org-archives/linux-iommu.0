Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D1AC10F03
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 00:40:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68586218D2
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 00:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68586218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 29B51ED0;
	Wed, 24 Apr 2019 00:40:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4F5BDECD
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 00:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id A2B1374A
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 00:40:05 +0000 (UTC)
Received: from mail-ot1-f70.google.com ([209.85.210.70])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dann.frazier@canonical.com>) id 1hJ5xD-0004c6-5n
	for iommu@lists.linux-foundation.org; Wed, 24 Apr 2019 00:40:03 +0000
Received: by mail-ot1-f70.google.com with SMTP id a2so9954496otk.13
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 17:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=HAJ+tsuhVeXXnt5g0+5qfIDYODvPMMpK3Zh37chKNPc=;
	b=M6SDP5pj5oRYDEQHFKNVHEwqIHoVlblSmrSi/CGle0ImCJpBqzql3zXovBIlq7PPnt
	aLQsrKlYy6kC8uOuYEbj0Zw1+f5la2oDo5QVEtXgVopdVVEwJxF75hd75kzQ1amPa/qz
	b2y0J2VGjkXARnq6sRN8CollN5E8u/d+LDEcBLpD7HeyYzbkAamaAMG4wqktGZaNM112
	qGv5jgr24lIpA8x3DngofLPzmQQcWZEbdUwfdlJFaZe6WOJZ3tblRKsQDjOpb4wIawCo
	lUuN6cllEtK3nQcRrCd65VHnXIHxK4PmX3J/C5a19fxdYQH/Ggla801HLmdkLrS4Rh3p
	gndg==
X-Gm-Message-State: APjAAAW6DthzPx8NHC3M2L+H5Y4Vsqy++VPQM8h4jd4fZG/7ua4ge8fQ
	jVG5Ip2M3gzu8OFLw4sW7dNDTnPOEgR3MeG0LyDeLGsVmryjkJT2FSmXr6OTWLf+BBxuRqVwl3e
	rjQ8ZpiAcdWTrFSO3TQrX5DFBwaYcQp3LqL+smk59JqRb5rHaIyUYxjpS9y9P3AA=
X-Received: by 2002:aca:c511:: with SMTP id v17mr3651418oif.124.1556066401975; 
	Tue, 23 Apr 2019 17:40:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0e4WJRVNRiguNI1//zAUIEyYuWcBl6vnE7VQGMLKBvKc3t094QzmR2EGAhr9F72Gg81zS4S+vG7/HUzW4SJk=
X-Received: by 2002:aca:c511:: with SMTP id v17mr3651400oif.124.1556066401613; 
	Tue, 23 Apr 2019 17:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190417204817.GA28897@xps13.dannf>
	<fa287dc4-59e9-0500-70ee-e96c2920d5a9@arm.com>
	<CALdTtnsHxwTjzw1asO886jYWB4LOY=UT_UGeco=f1SZzVNo7fw@mail.gmail.com>
In-Reply-To: <CALdTtnsHxwTjzw1asO886jYWB4LOY=UT_UGeco=f1SZzVNo7fw@mail.gmail.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Tue, 23 Apr 2019 18:39:50 -0600
Message-ID:
 <CALdTtnvUzoPLmgghRHb+gNOkivi3H7rhAaL96gLhkwOyK-ycWA@mail.gmail.com>
Subject: Re: [RFC] arm64: swiotlb: cma_alloc error spew
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424003950.zwzJDXu2-Iz3jorSuwOJSaQqNJ9pboFgVD64akBhISg@z>

On Tue, Apr 23, 2019 at 12:03 PM dann frazier
<dann.frazier@canonical.com> wrote:
>
> On Tue, Apr 23, 2019 at 5:32 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 17/04/2019 21:48, dann frazier wrote:
> > > hey,
> > >    I'm seeing an issue on a couple of arm64 systems[*] where they spew
> > > ~10K "cma: cma_alloc: alloc failed" messages at boot. The errors are
> > > non-fatal, and bumping up cma to a large enough size (~128M) gets rid
> > > of them - but that seems suboptimal. Bisection shows that this started
> > > after commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
> > > coherent allocations"). It looks like __dma_direct_alloc_pages()
> > > is opportunistically using CMA memory but falls back to non-CMA if CMA
> > > disabled or unavailable. I've demonstrated that this fallback is
> > > indeed returning a valid pointer. So perhaps the issue is really just
> > > the warning emission.
> >
> > The CMA area being full isn't necessarily an ignorable non-problem,
> > since it means you won't be able to allocate the kind of large buffers
> > for which CMA was intended. The question is, is it actually filling up
> > with allocations that deserve to be there, or is this the same as I've
> > seen on a log from a ThunderX2 system where it's getting exhausted by
> > thousands upon thousands of trivial single page allocations? If it's the
> > latter (CONFIG_CMA_DEBUG should help shed some light if necessary),
>
> Appears so. Here's a histogram of count/size w/ a cma= large enough to
> avoid failures:
>
> $ dmesg | grep "cma: cma_alloc(cma" | sed -r 's/.*count
> ([0-9]+)\,.*/\1/' | sort -n | uniq -c
>    2062 1
>      32 2
>     266 8
>       2 24
>       4 32
>     256 33

And IIUC, this is also a big culprit. The debugfs bitmap seems to show
that the alignment of each of these leaves 31 pages unused, which adds
up to 31MB!

  -dann

>       7 64
>       2 128
>       2 1024
>
>   -dann
>
> > then
> > that does lean towards spending a bit more effort on this idea:
> >
> > https://lore.kernel.org/lkml/20190327080821.GB20336@lst.de/
> >
> > Robin.
> >
> > > The following naive patch solves the problem for me - just silence the
> > > cma errors, since it looks like a soft error. But is there a better
> > > approach?
> > >
> > > [*] APM X-Gene & HiSilicon Hi1620 w/ SMMU disabled
> > >
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index 6310ad01f915b..0324aa606c173 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -112,7 +112,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
> > >          /* CMA can be used only in the context which permits sleeping */
> > >          if (gfpflags_allow_blocking(gfp)) {
> > >                  page = dma_alloc_from_contiguous(dev, count, page_order,
> > > -                                                gfp & __GFP_NOWARN);
> > > +                                                true);
> > >                  if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > >                          dma_release_from_contiguous(dev, page, count);
> > >                          page = NULL;
> > >
> > >
> > >
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
