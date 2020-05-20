Return-Path: <SRS0=jIn/=7C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD659C433E0
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 13:58:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68ACA207F9
	for <iommu@archiver.kernel.org>; Wed, 20 May 2020 13:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CjbbxN8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68ACA207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D50987985;
	Wed, 20 May 2020 13:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Y6a2IWqDA3P; Wed, 20 May 2020 13:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 91C0A87857;
	Wed, 20 May 2020 13:58:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77BE3C07FF;
	Wed, 20 May 2020 13:58:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D6BDC0176
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 13:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 422E388767
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 13:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ifbuwErWaFG for <iommu@lists.linux-foundation.org>;
 Wed, 20 May 2020 13:58:07 +0000 (UTC)
X-Greylist: delayed 00:07:16 by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AB1778872E
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 13:58:07 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id w64so2960699wmg.4
 for <iommu@lists.linux-foundation.org>; Wed, 20 May 2020 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lTWjeswxH0l98lyAxNqRNJAIOGggfbasSyUWJF3O/mI=;
 b=CjbbxN8hygEVQLVlGrH7l+/V/HdHKau/Ebvqwk35rM13T4gaQNRQy7FepGskwmW3na
 +RHf7e1uuO7h0fovTB5z0nEvtSTAPxYrR+kFXWhjKT9xQIyhn1hzLCv7DYoGzBdAU2cy
 /DVgXsWaQCgLoKd3OHE1X0o8+YbdAu18dWgfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lTWjeswxH0l98lyAxNqRNJAIOGggfbasSyUWJF3O/mI=;
 b=YtUzxDX55uFEgIwzYGdvJrmxn6QWIaLXlE8HMswaUqZRaAa9DK0U6ivRElfwU48A3C
 LKGjJb00IJNsHbz71yk+Btcs1tr04uguRYdiYAOm16io3srgPvLpSaMbIadW5qObdM8b
 YAYas76T+MWNMaFPAZ5TS3CPsF2SMZJKiziHO55dgZFILxZm9kjCh+2H8j26byQxl7aE
 E7xqcII05mQ1MQUqdppO414lKEqNER8iuTH7AFS5rgRLtYhq6XhKc1ehV6m8pwNYEbd3
 96lOw7kJXrw9s7OAK1PNOUl6r5faKcwdKll6YRn1ebaQEXyxCCym99tSOR5x+URgl9l2
 PGGA==
X-Gm-Message-State: AOAM5313Xh0dyAG8K70TpFRaN4wX7qv22HvSorZbqQzbumE+7vTDdGOv
 UJB6zjT5JnWx+LwhFiPPwNPJmHrxqLY8RGHxSqwF5rI7
X-Google-Smtp-Source: ABdhPJyaXGaSNp9tyc7HR3h1s5MPA9ExbrcjOq9FSNfXd4CqVCIoj7d0aI/ZbycoUGoC9EKycGOKogZNdnICVdwHSus=
X-Received: by 2002:a05:600c:d6:: with SMTP id
 u22mr4468679wmm.45.1589982649690; 
 Wed, 20 May 2020 06:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-10-james.quinlan@broadcom.com>
 <20200520054349.GB2180554@kroah.com>
In-Reply-To: <20200520054349.GB2180554@kroah.com>
Date: Wed, 20 May 2020 09:50:36 -0400
Message-ID: <CA+-6iNyQFauYc0ZNbzRmao_oOZD8XM+1D0XE133HP_-zgMLzuA@mail.gmail.com>
Subject: Re: [PATCH 09/15] device core: Add ability to handle multiple dma
 offsets
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 20, 2020 at 1:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 19, 2020 at 04:34:07PM -0400, Jim Quinlan wrote:
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index ac8e37cd716a..6cd916860b5f 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -493,6 +493,8 @@ struct dev_links_info {
> >   * @bus_dma_limit: Limit of an upstream bridge or bus which imposes a smaller
> >   *           DMA limit than the device itself supports.
> >   * @dma_pfn_offset: offset of DMA memory range relatively of RAM
> > + * @dma_map: Like dma_pfn_offset but used when there are multiple
> > + *           pfn offsets for multiple dma-ranges.
> >   * @dma_parms:       A low level driver may set these to teach IOMMU code about
> >   *           segment limitations.
> >   * @dma_pools:       Dma pools (if dma'ble device).
> > @@ -578,7 +580,12 @@ struct device {
> >                                            allocations such descriptors. */
> >       u64             bus_dma_limit;  /* upstream dma constraint */
> >       unsigned long   dma_pfn_offset;
> > -
> > +#ifdef CONFIG_DMA_PFN_OFFSET_MAP
> > +     const void *dma_offset_map;     /* Like dma_pfn_offset, but for
> > +                                      * the unlikely case of multiple
> > +                                      * offsets. If non-null, dma_pfn_offset
> > +                                      * will be 0. */
> > +#endif
> >       struct device_dma_parameters *dma_parms;
> >
> >       struct list_head        dma_pools;      /* dma pools (if dma'ble) */
>
> I'll defer to Christoph here, but I thought we were trying to get rid of
> stuff like this from struct device, not add new things to it for dma
Hi Greg,

I wasn't aware of this policy.  I put it in 'struct device' because
just like the existing dma_pfn_offset; it seemed to be the only way to
pull this off.  I'll certainly follow any ideas on alternative
strategies from Christoph et al.

> apis.  And why is it a void *?
Just wanted to minimize the number of lines I've added to device.h, no
other reason.

Thanks,
Jim
>
> thanks,
>
> greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
