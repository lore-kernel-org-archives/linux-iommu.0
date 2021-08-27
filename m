Return-Path: <SRS0=n6uX=NS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7BAC4320A
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 09:25:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301FC60EBD
	for <iommu@archiver.kernel.org>; Fri, 27 Aug 2021 09:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 301FC60EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF259403E2;
	Fri, 27 Aug 2021 09:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9jJ7u4NyjWm; Fri, 27 Aug 2021 09:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDD8B40412;
	Fri, 27 Aug 2021 09:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 956A8C001A;
	Fri, 27 Aug 2021 09:25:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23BDAC001A
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 09:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1247540412
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 09:25:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CXEtmPb1OP_w for <iommu@lists.linux-foundation.org>;
 Fri, 27 Aug 2021 09:25:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4788C403E2
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 09:25:15 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id me10so12420626ejb.11
 for <iommu@lists.linux-foundation.org>; Fri, 27 Aug 2021 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CQZSVnOjQTaOC4XZpSSeU/UltZMxftQtIHXd0FC9LUY=;
 b=Eiyqj+g5ZX6aj2srxpZtcC1FQBOndljXdzjzQhW3jQfg0AKnowg66sDkXhGEBa7ROp
 +53SIt2MmLtIoE8yXSbpYJx4I/VEj5rzSssq48dyRj2K9LTMGIxWpkX+rBd7bgLzzewm
 H7LTLql0SrRgfWYFJmh/kVwAwOxH4PN1xEh8cDnMjmoUUMNdlPpdKQKSpqobDjvAldfC
 cXn76T6Mu1zSuEcmMGjIeXjOf1VizyeMqiQ0WOFK5MjuDVZ5/RoACxnjGi7LF45nwgrQ
 Nfv9gXViN5n0dobPAoA9idt9BLeLe79P5wpff7nWT0kBWd8juzoAhi6J/RJ88ud8v62V
 8eEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CQZSVnOjQTaOC4XZpSSeU/UltZMxftQtIHXd0FC9LUY=;
 b=H7jtCQDGnd1bo6G/Vi5DY+xyRGKFFogCu+0pBhrQidVax0pmqJAxnRHPatytYBGIvK
 Lr6pwaO4TCNN9Mtuj/DX8C0gM5uve0IP/opiBfy/82C/hQHqfWwAeO9sNe1gThSXXUmG
 2iNCW0Qs4IPB+/KZv+jp93+X0nH0FHtQX2W3UltQ89YR1d3I0Tlm9YqNNGXeNqscXzHD
 cgMoX7xdYLaTHpMGQ2cJNbj0oavqAz9lZVYSZCFmL+ngd+lAYkJlNnajXvPCqkrgKBrm
 VDxSZMDssDgUM9QJyTZv6rfDRN0hY7HgOKAEfnvl3z0Qz6qgu7A7taDSVP7l3dnk0aEE
 2f+A==
X-Gm-Message-State: AOAM530x+9FcTQTWueP14BIIsJYeKM0tx/HEwBtLAPLvRkXF+JGLyyIj
 a+ck+yZIAeSE0pnJaPAlkzmjkc3L4C5FNPg95ToY
X-Google-Smtp-Source: ABdhPJwgcugxvkltcJohlXGHniUZmyhYLawWLaSxMYUiHXpZPra5boRHFyGEQTo7QNVw0MBfE++H/HV9ev3Dyf8sBpg=
X-Received: by 2002:a17:906:659:: with SMTP id
 t25mr8879799ejb.372.1630056313220; 
 Fri, 27 Aug 2021 02:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-11-xieyongji@bytedance.com>
 <2d807de3-e245-c2fb-ae5d-7cacbe35dfcb@huawei.com>
In-Reply-To: <2d807de3-e245-c2fb-ae5d-7cacbe35dfcb@huawei.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 27 Aug 2021 17:25:02 +0800
Message-ID: <CACycT3uRvB2K7LeVpdv+DkGJGjdORMa2uk5T_PYswtddNOjV4A@mail.gmail.com>
Subject: Re: [PATCH v11 10/12] vduse: Implement an MMU-based software IOTLB
To: John Garry <john.garry@huawei.com>
Cc: kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christian Brauner <christian.brauner@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Liu Xiaodong <xiaodong.liu@intel.com>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Stefan Hajnoczi <stefanha@redhat.com>,
 songmuchun@bytedance.com, Jens Axboe <axboe@kernel.dk>,
 He Zhe <zhe.he@windriver.com>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 bcrl@kvack.org, netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
 Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>
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

On Fri, Aug 27, 2021 at 4:53 PM John Garry <john.garry@huawei.com> wrote:
>
> On 18/08/2021 13:06, Xie Yongji wrote:
> > +
> > +static dma_addr_t
> > +vduse_domain_alloc_iova(struct iova_domain *iovad,
> > +                     unsigned long size, unsigned long limit)
> > +{
> > +     unsigned long shift = iova_shift(iovad);
> > +     unsigned long iova_len = iova_align(iovad, size) >> shift;
> > +     unsigned long iova_pfn;
> > +
> > +     /*
> > +      * Freeing non-power-of-two-sized allocations back into the IOVA caches
> > +      * will come back to bite us badly, so we have to waste a bit of space
> > +      * rounding up anything cacheable to make sure that can't happen. The
> > +      * order of the unadjusted size will still match upon freeing.
> > +      */
> > +     if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> > +             iova_len = roundup_pow_of_two(iova_len);
>
> Whether it's proper to use this "fast" API or not here, this seems to be
> copied verbatim from dma-iommu.c, which tells me that something should
> be factored out.
>

Agreed.

> Indeed, this rounding up seems a requirement of the rcache, so not sure
> why this is not done there.
>

Me too. I guess it is to let users know that space is wasted.

Thanks,
Yongji
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
