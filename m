Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1537C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 14:14:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5A2221EB
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 14:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff/CN0yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5A2221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A588F2DE2A;
	Thu, 24 Sep 2020 14:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9wmyy40yrWvx; Thu, 24 Sep 2020 14:14:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 80FCD2E104;
	Thu, 24 Sep 2020 14:14:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42C2CC0859;
	Thu, 24 Sep 2020 14:14:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25CC8C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1A76E86B15
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Db3pGjBKHgcw for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 14:14:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0CE5986A6F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 14:14:32 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e16so4039886wrm.2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:sender:from:date:message-id
 :subject:to:cc;
 bh=oKmEvP0fvH/MtuuMfd1/7oF0tm9aotVrqabNoBoq5kU=;
 b=Ff/CN0yzxu8BrvNMeqciq+FVYYVX2FOGfPQXwTLGfe0lQrivZ0ncLZjnJELMlFDvqr
 3L6kB8fT+Wb+X8vLs55KlIIyhJ3dJFr3Rj2DnyYz3Q20kFR5i2oziSiprcCaKqEXGFPy
 DCbOu9gcA3McuJjQY1+gmJb7WWf5qodLH1cN7EwBuRzkAnnvzXy6Tg66FHUh+prLRl22
 WU5UApmatapBNDHAADap1oxiGIPFpwFCnfz3pw3oFzr7izxHT1er/bWd7jQIB2frcuzi
 +b+RQNwSPaHQNlYq5+CxZ6HhbA9rDNzQNN7uVUnOWZ1j8rmwXx0L+XdP6pWlMFgk+gEj
 eXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
 :date:message-id:subject:to:cc;
 bh=oKmEvP0fvH/MtuuMfd1/7oF0tm9aotVrqabNoBoq5kU=;
 b=OXRCPyIvNOSvi3f3Rgq2CA/Y2bf/FKQkfQiWW6B5s7ADtFqQXRpwAf0BUsQSotXSpc
 XpztD7HTmK+l3xCPPNel6psHDH9DAW3fGEMFKXIqpogGpwbShlJF3LLNTf9od9rcE71M
 N43VpPe3HtGnaMM5TLyoJsbAjVnLckBmJOB6TkN47Tu/LKuUMUTumLv9xVfnJsQaltH5
 a8N4wj/0mqee3zt5PJKSLDEkI/uDybfKuu9oASdjbIdxXrX90XOxCIlrBSQ5Bl958Ogr
 6vPbgQYJPKiaCbJThO6Snh44h5ugmHzT9oI93nKG1oicUvzO5T4XV46fG8NMY3k/ZBWi
 x95A==
X-Gm-Message-State: AOAM5325gm/348YtAPM5gNPTfHvEXOfdT2N0B16rJDWwNoNKfvbFsycw
 z+W8Uri/mBaJzNd41dj6FLTzY+6D9DU+qEUvkA0=
X-Google-Smtp-Source: ABdhPJyNTqcd3aVlW3iItxA8DlolxWBS2LKF38N3Kl4q4kAwUYPjAmtzBpIhGbYdl5I4ht9nYkAIBiX3VLg1AotBuhw=
X-Received: by 2002:a5d:5261:: with SMTP id l1mr5339778wrc.193.1600956870566; 
 Thu, 24 Sep 2020 07:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
 <20200924082830.GB27174@8bytes.org>
 <37e767b8-8ec4-ae80-ea0d-1caf3cdab8fa@samsung.com>
 <20200924101640.GE2483160@ulmo>
 <bff57cbe-2247-05e1-9059-d9c66d64c407@arm.com>
 <832be601-c016-70b7-2b59-5f4915c53f85@samsung.com>
 <46f10f99-5da5-257a-4a02-984ff8ed8c6f@arm.com>
In-Reply-To: <46f10f99-5da5-257a-4a02-984ff8ed8c6f@arm.com>
X-Google-Sender-Delegation: ameersk@gmail.com
From: Shaik Ameer Basha <shaik.samsung@gmail.com>
Date: Thu, 24 Sep 2020 19:44:19 +0530
X-Google-Sender-Auth: HhYDNEdiSEFakz822RU-QAajhv0
Message-ID: <CAOD6ATp2g7JMvACzF+30EcdGygRNGxwTa-3VkGWuanaWPAdt2w@mail.gmail.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
To: Robin Murphy <robin.murphy@arm.com>
Cc: jean-philippe@linaro.org, Shaik Ameer Basha <shaik.ameer@samsung.com>,
 linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Ajay kumar <ajaynumb@gmail.com>,
 will@kernel.org, hch@lst.de
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

Hi Robin and Marek,


On Thu, Sep 24, 2020 at 4:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-09-24 11:47, Marek Szyprowski wrote:
> > Hi Robin,
> >
> > On 24.09.2020 12:40, Robin Murphy wrote:
> >> On 2020-09-24 11:16, Thierry Reding wrote:
> >>> On Thu, Sep 24, 2020 at 10:46:46AM +0200, Marek Szyprowski wrote:
> >>>> On 24.09.2020 10:28, Joerg Roedel wrote:
> >>>>> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
> >>>>>> It allows to remap given buffer at the specific IOVA address,
> >>>>>> although
> >>>>>> it doesn't guarantee that those specific addresses won't be later
> >>>>>> used
> >>>>>> by the IOVA allocator. Probably it would make sense to add an API for
> >>>>>> generic IOMMU-DMA framework to mark the given IOVA range as
> >>>>>> reserved/unused to protect them.
> >>>>> There is an API for that, the IOMMU driver can return IOVA reserved
> >>>>> regions per device and the IOMMU core code will take care of mapping
> >>>>> these regions and reserving them in the IOVA allocator, so that
> >>>>> DMA-IOMMU code will not use it for allocations.
> >>>>>
> >>>>> Have a look at the iommu_ops->get_resv_regions() and
> >>>>> iommu_ops->put_resv_regions().
> >>>>
> >>>> I know about the reserved regions IOMMU API, but the main problem here,
> >>>> in case of Exynos, is that those reserved regions won't be created by
> >>>> the IOMMU driver but by the IOMMU client device. It is just a result
> >>>> how
> >>>> the media drivers manages their IOVA space. They simply have to load
> >>>> firmware at the IOVA address lower than the any address of the used
> >>>> buffers.
> >>>
> >>> I've been working on adding a way to automatically add direct mappings
> >>> using reserved-memory regions parsed from device tree, see:
> >>>
> >>> https://lore.kernel.org/lkml/20200904130000.691933-1-thierry.reding@gmail.com/
> >>>
> >>> Perhaps this can be of use? With that you should be able to add a
> >>> reserved-memory region somewhere in the lower range that you need for
> >>> firmware images and have that automatically added as a direct mapping
> >>> so that it won't be reused later on for dynamic allocations.
> >>
> >> It can't easily be a *direct* mapping though - if the driver has to
> >> use the DMA masks to ensure that everything stays within the
> >> addressable range, then (as far as I'm aware) there's no physical
> >> memory that low down to equal the DMA addresses.
> >>
> >> TBH I'm not convinced that this is a sufficiently common concern to
> >> justify new APIs, or even to try to make overly generic. I think just
> >> implementing a new DMA attribute to say "please allocate/map this
> >> particular request at the lowest DMA address possible" would be good
> >> enough. Such a thing could also serve PCI drivers that actually care
> >> about SAC/DAC to give us more of a chance of removing the "try a
> >> 32-bit mask first" trick from everyone's hotpath...
> >
> > Hmm, I like the idea of such DMA attribute! It should make things really
> > simple, especially in the drivers. Thanks for the great idea! I will try
> > to implement it then instead of the workarounds I've proposed in
> > s5p-mfc/exynos4-is drivers.
>
> Right, I think it's fair to draw a line and say that anyone who wants a
> *specific* address needs to manage their own IOMMU domain.
>
> In the backend I suspect it's going to be cleanest to implement a
> dedicated iova_alloc_low() (or similar) function in the IOVA API that
> sidesteps all of the existing allocation paths and goes straight to the
> rbtree.

This is the place we started with..

But our solution was to provide an API which limits the allocation
range per device (dynamically) based on the driver request..
Something like,
    limit_iova_alloc_range(dev, low_iova, high_iova); /* via helpers */

When multiple devices use the same IOVA space, how we can handle api's
like " iova_alloc_low()" ?
And providing APIs like " limit_iova_alloc_range()" may cater similar
future requirements from drivers instead of worrying about
high/low/mid etc.

Again, flexibility should be there with user drivers to request the
range they want at any point of time...

Please let us know your inputs.

>
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
