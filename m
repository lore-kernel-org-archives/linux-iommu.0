Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3905DC04A6B
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 15:27:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066D2205ED
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hcd0xdYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066D2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B011948CB;
	Mon,  6 May 2019 15:27:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2BDB748BD
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 15:26:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 88C03196
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 15:26:01 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id f7so7479966wrq.1
	for <iommu@lists.linux-foundation.org>;
	Mon, 06 May 2019 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=xeGLYO6i2VSRu5H4X1RyT0Fbjs6360jEYGuSU3WOP/A=;
	b=hcd0xdYLqFYgYv2eL7s5b6JCuHh1odcVomvqSKLwC3AIoO3IQaEgf2LpxHs0EK74ne
	M7YNLXwmytch3qP2tlBG9bqjRkcOhCmr/py10NfIOdATfr3OsjRafHXaP8vhnIOtqVlH
	apd+VNcMnp4WXnN776eAgFMIq+QEGSVlahJb1KQaDRq8ADwaWJJ1BAiJnQ6Pg/DLqLe1
	9DQLTnCh8CgvmkyEdXzhx4q3TFjq6oi6jVdoivzuk/xV+RdrJiCHWdlkeE/vuct5i3zO
	VCVrqU/tGDznXBXoRIVK0Uy5G8HIeSeugk92s+Zaj5qlT4KKqUfhAiLQ6NNaq3QhBPV4
	N9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xeGLYO6i2VSRu5H4X1RyT0Fbjs6360jEYGuSU3WOP/A=;
	b=DWf+f+Om6o5A6yTv8IV2fU+QJ61lGQWbMzCwVRF+OHlw4kvUqVHWBkX0DbghfFct2N
	R5ykKA5K+cSvgFFxhZmVWov6tKIOgZd/H/fbFlQ1PRgvGGTkW/EuSjZkvkm9Yf2JOYqf
	wASGQn09bAZysM56yuiDrR+CvXUYiFEMB+wCve5V3O6SBz/3S987Oalabms5UpYhhfsV
	LMRAPYcTrGu7XHpge2BmCjQ7FBVWqb+QSn9XEI4yE/4n+5gg8EChjemmGb52mhNmF9GU
	Y7CK2jQGAXm88wLDWs4vQbYyH5ZW+xslkuKXLSY+dG9zAdrE/x2bvaWWIHWSJTPP2qNG
	wg+Q==
X-Gm-Message-State: APjAAAUgZKvUytEM0QnIygA0c1gbKjuey/kTdE91EDlTBQEErUm+/GxJ
	tbCa/kgnzQSdSTQ1Xe6PIx8K3XPFk44ZbugabmzSCQ==
X-Google-Smtp-Source: APXvYqyZUZ1kX4ydrErn48Ckg2JFr53umWKc3FsggM5j1bv+J2lQu85q8hn54/gyAI2b8jB/towaCWQX/o2aBK8IjK4=
X-Received: by 2002:a5d:5551:: with SMTP id g17mr20076879wrw.50.1557156360093; 
	Mon, 06 May 2019 08:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
	<20190429020925.18136-6-baolu.lu@linux.intel.com>
	<20190429200338.GA8412@infradead.org>
	<9c1d1e16-fdab-0494-8720-97ff20013da4@linux.intel.com>
In-Reply-To: <9c1d1e16-fdab-0494-8720-97ff20013da4@linux.intel.com>
Date: Mon, 6 May 2019 16:25:48 +0100
Message-ID: <CAPL0++6UmAzVQCm0MBD056DsA-13qVTSK1x737tXXkFzooWzNA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] iommu/vt-d: Implement def_domain_type iommu ops
	entry
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

It looks like there is a bug in this code.

The behavior before this patch in __intel_map_single was that
iommu_no_mapping would call remove the attached si_domain for 32 bit
devices  (in the  dmar_remove_one_dev_info(dev) call in
iommu_no_mapping) and then allocate a new domain in
get_valid_domain_for_dev
old:
if (iommu_no_mapping(dev))
   return paddr;
domain = get_valid_domain_for_dev(dev);
if (!domain)
   return DMA_MAPPING_ERROR;

but in the new code we remove the attached si_domain but we WON'T
allocate a new domain and instead just return an error when we call
find_domain
new:
        if (iommu_no_mapping(dev))
                return paddr;

        domain = find_domain(dev);
        if (!domain)
                return DMA_MAPPING_ERROR;

This is a bug, right?

On Tue, Apr 30, 2019 at 3:18 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Christoph,
>
> On 4/30/19 4:03 AM, Christoph Hellwig wrote:
> >> @@ -3631,35 +3607,30 @@ static int iommu_no_mapping(struct device *dev)
> >>      if (iommu_dummy(dev))
> >>              return 1;
> >>
> >> -    if (!iommu_identity_mapping)
> >> -            return 0;
> >> -
> >
> > FYI, iommu_no_mapping has been refactored in for-next:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=x86/vt-d&id=48b2c937ea37a3bece0094b46450ed5267525289
>
> Oh, yes! Thanks for letting me know this. Will rebase the code.
>
> >
> >>      found = identity_mapping(dev);
> >>      if (found) {
> >> +            /*
> >> +             * If the device's dma_mask is less than the system's memory
> >> +             * size then this is not a candidate for identity mapping.
> >> +             */
> >> +            u64 dma_mask = *dev->dma_mask;
> >> +
> >> +            if (dev->coherent_dma_mask &&
> >> +                dev->coherent_dma_mask < dma_mask)
> >> +                    dma_mask = dev->coherent_dma_mask;
> >> +
> >> +            if (dma_mask < dma_get_required_mask(dev)) {
> >
> > I know this is mostly existing code moved around, but it really needs
> > some fixing.  For one dma_get_required_mask is supposed to return the
> > required to not bounce mask for the given device.  E.g. for a device
> > behind an iommu it should always just return 32-bit.  If you really
> > want to check vs system memory please call dma_direct_get_required_mask
> > without the dma_ops indirection.
> >
> > Second I don't even think we need to check the coherent_dma_mask,
> > dma_direct is pretty good at always finding memory even without
> > an iommu.
> >
> > Third this doesn't take take the bus_dma_mask into account.
> >
> > This probably should just be:
> >
> >               if (min(*dev->dma_mask, dev->bus_dma_mask) <
> >                   dma_direct_get_required_mask(dev)) {
>
> Agreed and will add this in the next version.
>
> Best regards,
> Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
