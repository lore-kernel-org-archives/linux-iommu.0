Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFFC76194
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 18:09:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECB1218F0
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZqEhfFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECB1218F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 30EACD93;
	Thu, 25 Jul 2019 18:09:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CDDB0D30
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 18:09:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com
	[209.85.217.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4E739B0
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 18:09:18 +0000 (UTC)
Received: by mail-vs1-f67.google.com with SMTP id m8so34379378vsj.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yQkJfAq6w2vHWXCGY8CJlX7sAf5KrI5hGh5G/DWUbSE=;
	b=nZqEhfFRSm0yhJHGECsERx8km+FW6sLeuBozoNXLRjEwXSQkj/j4YsA+L4+TVOTFy8
	ZMlqrqE8BdCPn5504Lui8tNIIXrqzuoDpXFipkd7MrmCbOJ0EHdsYiBARVFk05UIDxRC
	8dcGpYtkf3xgVrilvgs5mUAIPcS4h6BW0dsqz7woQ3R8UzzN9tylqY9SNtOkMu50tsJp
	MY0920heANbwqrtwpmZofFxHb3Yb4NNcWBMhhETgETdbb7fjjlJH3jAvE3FWUfPniEsO
	EH3oc+RUZL5c63fFpfL48Ex+/Nq7bNPe11l4tZddmkW3aewOmgRpiX2QqRnjJ1eOcpi4
	JnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yQkJfAq6w2vHWXCGY8CJlX7sAf5KrI5hGh5G/DWUbSE=;
	b=DfWNDjAN0FiSaDV++DTyWqavw1piD0xnj23dcRhzOoON0AlwwHIHbQp5VWKAYiD4l1
	cSUw0EL1N/9wNNnrJRYrzMLjVSbYozJIKOMoUEcISwNIEchoRuNxOCS6kHt/VQfpRftQ
	5CIizrpphnKwjeZHMDmSANKhHKPC+Zv1a5fPwmxFVvr6R73njQ7O6L/kckxp/Sr1rtnv
	l8RaM6pwx8X0rgnZMVd3Dbb5/4tQO4mgFPns0MyzVSgtf8b5yqan3s5+sEp8N9j+K5NW
	XlfXmd7/wvJ57s1aDl797SoxpZVcDWHToewBNE00tr8CJdQodjCDeFZ5fVhzJfrcL9rY
	L8ZA==
X-Gm-Message-State: APjAAAVLxNUYj5Lskhj5HI2uE9j/NFgajlouY8tDNhj+XvaBjoE5HYEq
	YyXSQgwBqyfSub7Xn3Yd+ePFC/Vd4pNsbqK8aF4=
X-Google-Smtp-Source: APXvYqxrHq2+gGn17JuXE8+fJgfmZKHhv5dRuqNmbs504UKMlMZPJgnA5bVtfzJ2LHYPIaZ1PFVLHSc/4HCYmcyyUE4=
X-Received: by 2002:a67:fc19:: with SMTP id o25mr57199329vsq.106.1564078157202;
	Thu, 25 Jul 2019 11:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
	<57f8aa35-d460-9933-a547-fbf578ea42d3@arm.com>
	<20190716121026.GB2388@lst.de>
In-Reply-To: <20190716121026.GB2388@lst.de>
From: Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date: Thu, 25 Jul 2019 23:39:08 +0530
Message-ID: <CACDBo56RWh=kjhEm_eOpzkTuZ+A-VEuCYPnVJW1BYAXrP6LERg@mail.gmail.com>
Subject: Re: cma_remap when using dma_alloc_attr :- DMA_ATTR_NO_KERNEL_MAPPING
To: Christoph Hellwig <hch@lst.de>
Cc: pankaj.suryawanshi@einfochips.com, minchan@kernel.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	minchan.kim@gmail.com, Robin Murphy <robin.murphy@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Jul 16, 2019 at 5:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 16, 2019 at 01:02:19PM +0100, Robin Murphy wrote:
> >> Lets say 4k video allocation required 300MB cma memory but not required
> >> virtual mapping for all the 300MB, its require only 20MB virtually mapped
> >> at some specific use case/point of video, and unmap virtual mapping after
> >> uses, at that time this functions will be useful, it works like ioremap()
> >> for cma_alloc() using dma apis.
> >
> > Hmm, is there any significant reason that this case couldn't be handled
> > with just get_vm_area() plus dma_mmap_attrs(). I know it's only *intended*
> > for userspace mappings, but since the basic machinery is there...
>
> Because the dma helper really are a black box abstraction.
>
> That being said DMA_ATTR_NO_KERNEL_MAPPING and DMA_ATTR_NON_CONSISTENT
> have been a constant pain in the b**t.  I've been toying with replacing
> them with a dma_alloc_pages or similar abstraction that just returns
> a struct page that is guaranteed to be dma addressable by the passed
> in device.  Then the driver can call dma_map_page / dma_unmap_page /
> dma_sync_* on it at well.  This would replace DMA_ATTR_NON_CONSISTENT
> with a sensible API, and also DMA_ATTR_NO_KERNEL_MAPPING when called
> with PageHighmem, while providing an easy to understand API and
> something that can easily be fed into the various page based APIs
> in the kernel.
>
> That being said until we get arm moved over the common dma direct
> and dma-iommu code, and x86 fully moved over to dma-iommu it just
> seems way too much work to even get it into the various architectures
> that matter, never mind all the fringe IOMMUs.  So for now I've just
> been trying to contain the DMA_ATTR_NON_CONSISTENT and
> DMA_ATTR_NO_KERNEL_MAPPING in fewer places while also killing bogus
> or pointless users of these APIs.


I agree with you Christoph, users want page based api, which is useful
in many scenarios, but
As of now i think we have to move with this type of api which is
useful when dma_alloc (for cma )call with DMA_ATTR_NO_KERNEL_MAPPING,
and mapped again to kernel space, this api is useful mostly for 32-bit
system which has 4GB of limited virtual memory (its very less for
android devices) as we have already dma_mmap_attr() for user space
mapping.
This api is also useful for one who directly want to use cma_alloc()
in their own drivers. For example ion-cma.c.
Please let me know if any recommendation/suggestion/improvement required ?

Regards,
Pankaj
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
