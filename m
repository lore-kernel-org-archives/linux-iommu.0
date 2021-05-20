Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B17AC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 14:34:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49BF61246
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 14:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49BF61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D7554048B;
	Thu, 20 May 2021 14:34:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B_RZhbbmfkGq; Thu, 20 May 2021 14:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23576403C7;
	Thu, 20 May 2021 14:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC27CC000E;
	Thu, 20 May 2021 14:34:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBDA9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD3B183046
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iiwl_2xQYJyw for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:34:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7CED82DA3
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 14:34:22 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id h24so1486385qtm.12
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OpoqGZ3A/8qRiAsl8YBeGFq3Y08k8ObE2zfSbQGbkDw=;
 b=gUM1zdl9Abha3cPJv5gRQZgKr1Ffmsd5MwHf2fIfUdraIoaE0cGoqbofW/xNNGw4Ad
 tIdaNqYlPU8oicIi5AtHsN4SylYLZCRQvidxSN2we34qHMt1NYx6OOPm5zmJ8PqWWlw4
 wiZdB1fwuwlsPBIRY3MTgmnnYj/Jbk476crStUxbBoOiMD7efzWEIV8xc3vuzoVPUfO1
 QY1YLNM5nKeEhWEMzwgpwyiVXMrnYgKqI1xockOg/9/BxckQFzBYOxyJ5ccmlzsO3dKo
 lYO87FEbmQIqC2CgYVbww7aOZd9Q0KPVIgPN1rLHv1JVoE8htlZTnFN+vjaIV8AvV7gb
 Ib9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OpoqGZ3A/8qRiAsl8YBeGFq3Y08k8ObE2zfSbQGbkDw=;
 b=s/HJVfRvAhIWtlAFUcBm4l22Wlw66fKJj6g4FMFWbHiCAAf8sRuUWYviKsf7DIVRPl
 hcsA/osekgTRVihbOe91SC4FY2yqdCdX4KHwXUgfv5jVydXoMxCeHQzxrM/EMcFGdCdC
 hJA6YApnADi2WqXnRRLlfcdhSYemecPUKkgZJWnyfDGjH2UKUEo1oFR6H3uUOLejhVPw
 0qtQU/P3ytQJbFfnKxzi/s3UYg1/U/zdifmjPJng4lC3zrQ+fC9A8R9cI3k7BamGoD9g
 8X0zjMsMMRvprgI4T1unTyTd3y14+nYqDcIxD3nnBiGEfTdp7lHZhnpGxR+CpZlLyM2E
 WeCA==
X-Gm-Message-State: AOAM530OLbmmFPK3emjEewSl/ytpXcI4/9Mc8lbau+9usH2Fxe1eywHJ
 7+yGbAvQcA5ewyt1JTgaFaiozg==
X-Google-Smtp-Source: ABdhPJwHOT/1k3DuCHDAx3Xvnqq9GL3kCgR+0mUPss3IDQnLOCtNIHl2f9EI7XlwZ2X6CoeaPh0j3g==
X-Received: by 2002:ac8:5419:: with SMTP id b25mr5300042qtq.328.1621521261577; 
 Thu, 20 May 2021 07:34:21 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id e19sm2035011qtr.45.2021.05.20.07.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 07:34:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ljjki-00BOJ9-6V; Thu, 20 May 2021 11:34:20 -0300
Date: Thu, 20 May 2021 11:34:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210520143420.GW1096940@ziepe.ca>
References: <YKJf7mphTHZoi7Qr@8bytes.org> <20210517123010.GO1096940@ziepe.ca>
 <YKJnPGonR+d8rbu/@8bytes.org> <20210517133500.GP1096940@ziepe.ca>
 <YKKNLrdQ4QjhLrKX@8bytes.org>
 <131327e3-5066-7a88-5b3c-07013585eb01@arm.com>
 <20210519180635.GT1096940@ziepe.ca>
 <MWHPR11MB1886C64EAEB752DE9E1633358C2B9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210519232459.GV1096940@ziepe.ca>
 <1d154445-f762-1147-0b8c-6e244e7c66dc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d154445-f762-1147-0b8c-6e244e7c66dc@arm.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 20, 2021 at 03:13:55PM +0100, Robin Murphy wrote:

> By "mdev-like" I mean it's very similar in shape to the general SIOV-style
> mediated device concept - i.e. a physical device with an awareness of
> operating on multiple contexts at once, using a Substream ID/PASID for each
> one - but instead of exposing control of the contexts to anyone else, they
> remain hidden behind the kernel driver which already has its own abstracted
> uAPI, so overall it ends up as more just internal housekeeping than any
> actual mediation. We were looking at the mdev code for inspiration, but
> directly using it was never the plan.

Well:
 - Who maps memory into the IOASID (ie the specific sub stream id)?
 - What memory must be mapped?
 - Who triggers DMA to this memory?
 
> The driver simply needs to keep track of the domains and PASIDs -
> when a process submits some work, it can look up the relevant
> domain, iommu_map() the user pages to the right addresses, dma_map()
> them for coherency, then poke in the PASID as part of scheduling the
> work on the physical device.

If you are doing stuff like this then the /dev/ioasid is what you
actually want. The userprocess can create its own IOASID, program the
io page tables for that IOASID to point to pages as it wants and then
just hand over a fully instantiated io page table to the device
driver.

What you are describing is the literal use case of /dev/ioasid - a
clean seperation of managing the IOMMU related parts through
/dev/ioasid and the device driver itself is only concerned with
generating device DMA that has the proper PASID/substream tag.

The entire point is to not duplicate all the iommu code you are
describing having written into every driver that just wants an IOASID.

In particular, you are talking about having a substream capable device
and driver but your driver's uAPI is so limited it can't address the
full range of substream configurations:

 - A substream pointing at a SVA
 - A substream pointing a IO page table nested under another
 - A substream pointing at an IOMMU page table shared by many users

And more. Which is bad.

> > We already talked about this on the "how to use PASID from the kernel"
> > thread.
> 
> Do you have a pointer to the right thread so I can catch up? It's not the
> easiest thing to search for on lore amongst all the other PASID-related
> business :(

Somewhere in here:

http://lore.kernel.org/r/20210517143758.GP1002214@nvidia.com

> FWIW my non-SVA view is that a PASID is merely an index into a set of
> iommu_domains, and in that context it doesn't even really matter *who*
> allocates them, only that the device driver and IOMMU driver are in sync :)

Right, this is where /dev/ioasid is going.

However it gets worked out at the kAPI level in the iommu layer the
things you asked for are intended to be solved, and lots more.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
