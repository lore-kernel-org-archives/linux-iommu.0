Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD765C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 13:35:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4771C6100B
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 13:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4771C6100B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1098A60A44;
	Mon, 17 May 2021 13:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJFnDD2hOIQB; Mon, 17 May 2021 13:35:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F3D060A58;
	Mon, 17 May 2021 13:35:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE373C000E;
	Mon, 17 May 2021 13:35:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68442C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 13:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45F3B83ABC
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 13:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RiOgsHQ-1NO8 for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 13:35:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E425C83A93
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 13:35:02 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id c10so4794482qtx.10
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BBi0ImqVgaTdoUmufhblDvqZN98Dv2D+uHBf7NJmKTc=;
 b=fI4KjnpIUUKpAjz0x9Mzd07Rv5ptsOe1rhaTupiA8hmF87geY5yzv1KFjhj2KlQtNN
 9jwlCBJI1kXnwXZpR4fjxnEF/+MvGRBsFtjf5u7IZP8CQ1rdVAtvKWanISFV0QnesOzW
 6/AJFleh+D14Vt/LJZKJCdfr4tmhk6BZRTL2608U0hMq1yXvRS9NxoVsfEoOoSsNuVvx
 vP3nugx7H8NKy7lGHFTc0Hk+IEEMKRAAA2Xp2KtNverN3Z5XYxlydV3894Xr7A8P0Zgu
 bJUehgXTHdO3q1lXucrSXcvp4S9SlNPhgBa47ovmA9FPkZESI3Zj0F5i8X43JgN7CY5m
 UEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BBi0ImqVgaTdoUmufhblDvqZN98Dv2D+uHBf7NJmKTc=;
 b=jC9e1YLg4S/cvEAKtPB7Bb/bTNy7Ey4l+4Zut0JPlYSIvtmeCtGaHLogBkyxMPNERe
 RWgzdcUB3ypt7p0qP1ZNygEHnVo43z/0B/XDZXsbq9sM1fRUc7ZYfelS1UG8/kQ+ULwh
 RF77+5rylim+TcDcsZ+deesWt2K9jJNNxKqdS4B777j+Sg4dGsT68m4grWj5aHc4TGzd
 9ccJjO/sZzBTPgtcE5zyndJFmDtVFpHIw2qL09I6G5jNB3lMo7VVR8HInGlXv5rQv7S9
 5Zw9AIKmR26jg02PiUT/p2tH/QSXxBSL7YHNTGz6WeuP7wLhbaUMwzHiUc1yNUExT2Uu
 bnSg==
X-Gm-Message-State: AOAM530LAnxyGhPJeNhZCNA7za0XHxH9FwaX4ZIGV2VyR5OJYJnNLV0I
 LXCFKvqVWIBxCQ7r+hU+592P/Q==
X-Google-Smtp-Source: ABdhPJxSGyi8nwynzq/W6C6jsXKUHeSS9Dh1cS5HbaxJxw3+c/sfqmRtKrfd7kUKoLlziJIkPGtxdg==
X-Received: by 2002:a05:622a:170b:: with SMTP id
 h11mr42137196qtk.330.1621258501565; 
 Mon, 17 May 2021 06:35:01 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id g5sm11495475qtm.2.2021.05.17.06.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 06:35:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lidOe-009Gdr-0u; Mon, 17 May 2021 10:35:00 -0300
Date: Mon, 17 May 2021 10:35:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210517133500.GP1096940@ziepe.ca>
References: <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
 <20210517123010.GO1096940@ziepe.ca> <YKJnPGonR+d8rbu/@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKJnPGonR+d8rbu/@8bytes.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
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

On Mon, May 17, 2021 at 02:53:16PM +0200, Joerg Roedel wrote:
> On Mon, May 17, 2021 at 09:30:10AM -0300, Jason Gunthorpe wrote:
> > On Mon, May 17, 2021 at 02:22:06PM +0200, Joerg Roedel wrote:
> > > Yes, I know, We have the AUX-domain specific functions now, but I
> > > suggested a while back to turn the mdev code into its own bus
> > > implementation and let the IOMMU driver deal with whether it has an mdev
> > > or a pdev. When that is done the aux-specific functions can go away.
> > 
> > Yuk, no.
> > 
> > PASID is not connected to the driver model. It is inherently wrong to
> > suggest this.
> 
> There will be no drivers for that, but an mdev is a container for
> resources of a physical device which can be assigned to a virtual
> machine or a user-space process. In this way it fits very well into the
> existing abstractions.

There world is a lot bigger than just mdev and vfio.

> > PASID is a property of a PCI device and any PCI device driver should
> > be able to spawn PASIDs without silly restrictions.
> 
> Some points here:
> 
> 	1) The concept of PASIDs is not limited to PCI devices.

Do I have to type PASID/stream id/etc/etc in every place? We all know
this is gerenal, it is why Intel is picking IOASID for the uAPI name.

> 	2) An mdev is not a restriction. It is an abstraction with which
> 	   other parts of the kernel can work.

mdev is really gross, new things should avoid using it. It is also
100% VFIO specific and should never be used outside VFIO.

My recent work significantly eliminates the need for mdev at all, the
remaining gaps have to do with the way mdev hackily overrides the
iommu mechanisms in VFIO.

Tying any decision to the assumption that mdev will, or even should,
continue is not aligned with the direction things are going.

> > Fixing the IOMMU API is clearly needed here to get a clean PASID
> > implementation in the kernel.
> 
> You still have to convince me that this is needed and a good idea. By
> now I am not even remotely convinced and putting words like 'fixing',
> 'clearly' and 'silly' in a sentence is by far not enough for this to
> happen.

Well, I'm sorry, but there is a huge other thread talking about the
IOASID design in great detail and why this is all needed. Jumping into
this thread without context and basically rejecting all the
conclusions that were reached over the last several weeks is really
not helpful - especially since your objection is not technical.

I think you should wait for Intel to put together the /dev/ioasid uAPI
proposal and the example use cases it should address then you can give
feedback there, with proper context.

In this case the mdev specific auxdomain for PASID use is replaced by
sane /dev/ioasid objects - and how that gets implemented through the
iommu layer would still be a big TBD. Though I can't forsee any
quality implementation of /dev/ioasid being driven by a one io page
table per struct device scheme.

Hopefully Intel will make the reasons why, and the use cases
supporting the desgin, clear in their RFC.

> To be clear, I agree that the aux-domain specifics should be removed
> from the IOMMU-API, but the mdev-abstraction itself still makes sense.

Expect mdev is basically legacy too. 

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
