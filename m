Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC593C49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:42:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7331661375
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7331661375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EBF583CF9;
	Thu, 24 Jun 2021 13:42:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KlKztT-dtAa; Thu, 24 Jun 2021 13:42:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 15E8D83CFB;
	Thu, 24 Jun 2021 13:42:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E44E1C001A;
	Thu, 24 Jun 2021 13:42:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA084C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A89C883CFB
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x-ve9b4neO4f for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:42:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 563B883CF9
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:42:16 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id o6so14575290qkh.4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
 b=UtHXwFYLTrHgPc145mL3C9UB4ey+/nLdjIs7pvzujRNmQ5EAW+afyVO5yMkpxhaiYq
 EaZ0co1eAfBn5+AQMs9Q4Do4a1gFTjywNfS2sa9OFA0yAfKs040r9gAZmmies4dijQrQ
 9P1VJDPAdAgvB5owtJUn6dZ/rn754Mfv82gBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
 b=ujcHXo4wTzKLCRbkkSA+PRcxctkEkRGMqhzXUb1nOlkuGoi2VaezyvTC5jOMII1NGv
 1liBl/EgjOppTQiF4gw9xFP0/O+9WOSJ6iew8S/XXY+DQn54030+yADgErRn7W4qstj1
 vIB5Wl6qWa32KFYK7G5Ebnoa76FU9/0ElyJmgA29f+6mtGCg8xYOsILemn3/Jnd6bsm8
 hywr7MNxlf0PkNG6y8tWsOuOxOORgF4B/j/4PhAVUp4F/LLlFpA2NBiKrou4MmS/+Bzh
 Oi50Rus1Cj9x3HzYebeZ+uNBUkjBfHjhAe1JKC4Jro+fgr9zrv/OhbGW4szWooj4QEdy
 l9Lw==
X-Gm-Message-State: AOAM531rO3hiaUjjvemlOjHGl6UvGQhG2vcU1QIWitXr/hbNHsitI/gy
 smjzZLlghv3S+NoeitFo1dbxMeObzppBWQ==
X-Google-Smtp-Source: ABdhPJwMwiFkpcj2Eefcx39ngInF+2iKMXscNGQPLx67PhYn8MzJ/gbRVQt77Wb3g6kYuJYo5ECQ7w==
X-Received: by 2002:a05:620a:543:: with SMTP id
 o3mr5918054qko.80.1624542134868; 
 Thu, 24 Jun 2021 06:42:14 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com.
 [209.85.222.171])
 by smtp.gmail.com with ESMTPSA id z16sm183713qtu.66.2021.06.24.06.42.14
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jun 2021 06:42:14 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id x1so10625738qkp.7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 06:42:14 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr5223275ybb.257.1624542133615; 
 Thu, 24 Jun 2021 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid>
 <YNSKdhMACa9LFuVN@kroah.com>
In-Reply-To: <YNSKdhMACa9LFuVN@kroah.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 24 Jun 2021 06:42:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers: base: Add bits to struct device to control
 iommu strictness
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Sonny Rao <sonnyrao@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi,

On Thu, Jun 24, 2021 at 6:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:44PM -0700, Douglas Anderson wrote:
> > How to control the "strictness" of an IOMMU is a bit of a mess right
> > now. As far as I can tell, right now:
> > * You can set the default to "non-strict" and some devices (right now,
> >   only PCI devices) can request to run in "strict" mode.
> > * You can set the default to "strict" and no devices in the system are
> >   allowed to run as "non-strict".
> >
> > I believe this needs to be improved a bit. Specifically:
> > * We should be able to default to "strict" mode but let devices that
> >   claim to be fairly low risk request that they be run in "non-strict"
> >   mode.
> > * We should allow devices outside of PCIe to request "strict" mode if
> >   the system default is "non-strict".
> >
> > I believe the correct way to do this is two bits in "struct
> > device". One allows a device to force things to "strict" mode and the
> > other allows a device to _request_ "non-strict" mode. The asymmetry
> > here is on purpose. Generally if anything in the system makes a
> > request for strictness of something then we want it strict. Thus
> > drivers can only request (but not force) non-strictness.
> >
> > It's expected that the strictness fields can be filled in by the bus
> > code like in the patch ("PCI: Indicate that we want to force strict
> > DMA for untrusted devices") or by using the new pre_probe concept
> > introduced in the patch ("drivers: base: Add the concept of
> > "pre_probe" to drivers").
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  include/linux/device.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index f1a00040fa53..c1b985e10c47 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -449,6 +449,15 @@ struct dev_links_info {
> >   *           and optionall (if the coherent mask is large enough) also
> >   *           for dma allocations.  This flag is managed by the dma ops
> >   *           instance from ->dma_supported.
> > + * @force_strict_iommu: If set to %true then we should force this device to
> > + *                   iommu.strict regardless of the other defaults in the
> > + *                   system. Only has an effect if an IOMMU is in place.
>
> Why would you ever NOT want to do this?
>
> > + * @request_non_strict_iommu: If set to %true and there are no other known
> > + *                         reasons to make the iommu.strict for this device,
> > + *                         then default to non-strict mode. This implies
> > + *                         some belief that the DMA master for this device
> > + *                         won't abuse the DMA path to compromise the kernel.
> > + *                         Only has an effect if an IOMMU is in place.
>
> This feels in contrast to the previous field you just added, how do they
> both interact?  Would an enum work better?

Right that it never makes sense to set both bits so an enum could work
better, essentially it would be { dont_care, request_non_strict,
force_strict }.

In any case the whole idea of doing this at the device level looks
like it's not the right way to go anyway, so this patch and the
previous pre_probe one are essentially abandoned and I need to send
out a v2 with some different approaches.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
