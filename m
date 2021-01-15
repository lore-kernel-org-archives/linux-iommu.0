Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCDC433E0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 03:46:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4159A23AC0
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 03:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4159A23AC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D94E186F21;
	Fri, 15 Jan 2021 03:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5GDHENtVxQEK; Fri, 15 Jan 2021 03:46:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A3E3387313;
	Fri, 15 Jan 2021 03:46:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EE0BC088B;
	Fri, 15 Jan 2021 03:46:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED236C013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 03:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DDA4E87130
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 03:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Y0dAT7eXiX6 for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 03:46:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 07BBA86F21
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 03:46:35 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id n4so15627904iow.12
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 19:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zn/E5DSPd3qJg+DTv9IwC7Z6z2pECZsgPkasFqGe2mo=;
 b=SlbAB2R28TVOPw4dT3y4+YKxnBvZIXRjddrKEDVYjmW3vvG3MDP0dEXICbitCBjDsh
 shg/YaDMPSBJC8TmtKZMEExrMsM7sLlrF7dj4kE9P1DHob7nRhpZZQNoE756taUh2vVw
 OwHAOHom27x10XansCH8DvCa2BNXVtylJjjRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zn/E5DSPd3qJg+DTv9IwC7Z6z2pECZsgPkasFqGe2mo=;
 b=l3ZxETLJK5g7LFrEIzIOz3y58HJpwj0hnnL/j/YeSoSGKQbNJ1Arw56qQzVztOybZ1
 7bS+BsTG+q/LgGyb4x79WiY7nXu5Ozi0plkEM/PaMu+DAWCTYSpOjmRghjvCSPaQb3q3
 RUwUPXZVKqN7e92UOqYvtvclpT9z5V6gEsZLGht/E3p/5rMueZ//AkmLK4FYYzNHZ+Hs
 u08gwm9KGQOJOIb97khJZMQCTQMZ3sHp9raTxlPnI/usb1IRouAP+gQjYno+Guj/4dHI
 fys2Png+XIIreJSuR7vA/Q8KmcEOBvvaOGXVgRGXgMgvlGDrKc22NEV/FVXSvn69I1lK
 rBiA==
X-Gm-Message-State: AOAM532exOe1vGLryENYxthdV+FlmbCKYGdZgrYZqGs3lfIPW4oJjVO9
 vvy+tFNboOG0OH3RQhENLD0Qd4poz6lCWg==
X-Google-Smtp-Source: ABdhPJwT3D+lD65BCwh7cCrxrozfhq16dpQ4i0T+/3AhE7hBgkS9YcfZzW23YoQl0OUA+BY03TKo0g==
X-Received: by 2002:a05:6e02:1a47:: with SMTP id
 u7mr9212207ilv.260.1610682393913; 
 Thu, 14 Jan 2021 19:46:33 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com.
 [209.85.166.47])
 by smtp.gmail.com with ESMTPSA id o17sm4490606ill.71.2021.01.14.19.46.31
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 19:46:32 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id e22so15688590iom.5
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 19:46:31 -0800 (PST)
X-Received: by 2002:a5d:9588:: with SMTP id a8mr2906589ioo.34.1610682391276;
 Thu, 14 Jan 2021 19:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-7-tientzu@chromium.org>
 <95e6dd76-5e18-e445-c351-19fba18f36de@gmail.com>
 <CALiNf29+8Yi93RacsZHr=qYBhQRwqujW6KZVVD=9xPMhpLH5pA@mail.gmail.com>
 <5f276678-3ab2-ddc8-640c-6dbbe173463c@gmail.com>
In-Reply-To: <5f276678-3ab2-ddc8-640c-6dbbe173463c@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 15 Jan 2021 11:46:20 +0800
X-Gmail-Original-Message-ID: <CALiNf28nW0CKsBRw-HQmz=jBJ3vK6cjoQZPu8Zx=Yn=RWPdVWQ@mail.gmail.com>
Message-ID: <CALiNf28nW0CKsBRw-HQmz=jBJ3vK6cjoQZPu8Zx=Yn=RWPdVWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/6] of: Add plumbing for restricted DMA pool
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Jan 15, 2021 at 2:52 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/14/21 1:08 AM, Claire Chang wrote:
> > On Wed, Jan 13, 2021 at 7:48 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 1/5/21 7:41 PM, Claire Chang wrote:
> >>> If a device is not behind an IOMMU, we look up the device node and set
> >>> up the restricted DMA when the restricted-dma-pool is presented.
> >>>
> >>> Signed-off-by: Claire Chang <tientzu@chromium.org>
> >>> ---
> >>
> >> [snip]
> >>
> >>> +int of_dma_set_restricted_buffer(struct device *dev)
> >>> +{
> >>> +     struct device_node *node;
> >>> +     int count, i;
> >>> +
> >>> +     if (!dev->of_node)
> >>> +             return 0;
> >>> +
> >>> +     count = of_property_count_elems_of_size(dev->of_node, "memory-region",
> >>> +                                             sizeof(phandle));
> >>
> >> You could have an early check for count < 0, along with an error
> >> message, if that is deemed useful.
> >>
> >>> +     for (i = 0; i < count; i++) {
> >>> +             node = of_parse_phandle(dev->of_node, "memory-region", i);
> >>> +             if (of_device_is_compatible(node, "restricted-dma-pool"))
> >>
> >> And you may want to add here an of_device_is_available(node). A platform
> >> that provides the Device Tree firmware and try to support multiple
> >> different SoCs may try to determine if an IOMMU is present, and if it
> >> is, it could be marking the restriced-dma-pool region with a 'status =
> >> "disabled"' property, or any variant of that scheme.
> >
> > This function is called only when there is no IOMMU present (check in
> > drivers/of/device.c). I can still add of_device_is_available(node)
> > here if you think it's helpful.
>
> I believe it is, since boot loader can have a shared Device Tree blob
> skeleton and do various adaptations based on the chip (that's what we
> do) and adding a status property is much simpler than insertion new
> nodes are run time.
>
> >
> >>
> >>> +                     return of_reserved_mem_device_init_by_idx(
> >>> +                             dev, dev->of_node, i);
> >>
> >> This does not seem to be supporting more than one memory region, did not
> >> you want something like instead:
> >>
> >>                 ret = of_reserved_mem_device_init_by_idx(...);
> >>                 if (ret)
> >>                         return ret;
> >>
> >
> > Yes. This implement only supports one restriced-dma-pool memory region
> > with the assumption that there is only one memory region with the
> > compatible string, restricted-dma-pool, in the dts. IIUC, it's similar
> > to shared-dma-pool.
>
> Then if here is such a known limitation it should be both documented and
> enforced here, you shouldn ot be iterating over all of the phandles that
> you find, stop at the first one and issue a warning if count > 1?

What I have in mind is there might be multiple memory regions, but
only one is for restriced-dma-pool.
Say, if you want a separated region for coherent DMA and only do
streaming DMA in this restriced-dma-pool region, you can add another
reserved-memory node with shared-dma-pool in dts and the current
implementation will try to allocate the memory via
dma_alloc_from_dev_coherent() first (see dma_alloc_attrs() in
/kernel/dma/mapping.c).
Or if you have vendor specific memory region, you can still set up
restriced-dma-pool by adding another reserved-memory node in dts.
Dose this make sense to you? I'll document this for sure.

> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
