Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434FC47086
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 22:53:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8761F613D6
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 22:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8761F613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F5E060B64;
	Tue, 25 May 2021 22:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3aBmk5PrZ0dQ; Tue, 25 May 2021 22:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E104660617;
	Tue, 25 May 2021 22:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFABCC000D;
	Tue, 25 May 2021 22:53:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4333C0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 22:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A6D483B8F
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 22:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LFF0oValqzS8 for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 22:53:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7440C83B72
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621983181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBoHc3TMtFMMXyl4OvwN2G9ZYTn+3x2tRvNpJ1JHSJM=;
 b=L+C+j7E3S0uqyeG/GrxECkKYrC2nY/7D4XGMj7O47RH/bHIH/M7YD+x9FI57vxpwgjxHAm
 UFgLZv+UfYKr9R1sIRuOFPXafexmHkTI9ZLgYOrWHjkzx9mlHsm2Z25gRUBIan/3Nlwi/H
 wivAu9JWKjGoQc3P/+1Ljh+GYNmSlIs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-WPd9ZqC8Nla38ILznRp7Dg-1; Tue, 25 May 2021 18:52:57 -0400
X-MC-Unique: WPd9ZqC8Nla38ILznRp7Dg-1
Received: by mail-oo1-f71.google.com with SMTP id
 a3-20020a4ab7830000b0290218f0eb9462so9931624oop.1
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 15:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SBoHc3TMtFMMXyl4OvwN2G9ZYTn+3x2tRvNpJ1JHSJM=;
 b=NlbIbRHamuFnSeomo/ZSFmbQCOhvKqvInJelY89I0aJ9lVjYc2+0fLYk2JG4dEqvrx
 /nU51sbcE76iwxwaIN64dOENIHP1dJ4XB5Y9tfqgO4njaLTobRsX+UGnlPOvh0RqQOZF
 jHaOV6cRxFu/81S9SK81WovZtNhGvCNSYxFK77wzzYEUJM5+ocNefrlL/9qAJPsv9iKN
 dtYIFW2pzZiyYZEjJXyfuYxYHJVdvyCTBFRLCSF8FfJWjjlS+ZWX2ycnx0bBm0VCaDWB
 vamBStaSBsigyjLkb6mlU4TwGALGcdIihFWjgf7nxCpB75/lN62CRDah3kswdDTTTgIY
 tS3w==
X-Gm-Message-State: AOAM532KMUTu8/YchCi4SidNIEPbyPmG/ttLqF8EhcxkkhptT2KzbiuF
 ZUpnW2UD6P72790RJt6RsvhbAiErbZR5Tj3BdlHPTx2E2k1cZmFdsiVMR9zIj1PQhl4MDnEcoRL
 y8vg9UPeD63dtaZD7r97SeY1sqA9euw==
X-Received: by 2002:a9d:6457:: with SMTP id m23mr5131otl.11.1621983176607;
 Tue, 25 May 2021 15:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRjs1O3WclZbbD9WDAdj+hJXQH5q9/JRXCUepCdSgt9KXIP4TuN1LyaOo7T20Cp8BhXQC/OQ==
X-Received: by 2002:a9d:6457:: with SMTP id m23mr5122otl.11.1621983176368;
 Tue, 25 May 2021 15:52:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id r7sm3833207oom.46.2021.05.25.15.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 15:52:55 -0700 (PDT)
Date: Tue, 25 May 2021 16:52:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210525165252.6959d9da.alex.williamson@redhat.com>
In-Reply-To: <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
References: <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, 
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Wed, 26 May 2021 00:56:30 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/25/2021 5:07 AM, Jason Gunthorpe wrote:
> > On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:
> >   
> >>>> I don't really see a semantic distinction between "always one-device
> >>>> groups" and "groups don't matter".  Really the only way you can afford
> >>>> to not care about groups is if they're singletons.  
> >>>
> >>> The kernel driver under the mdev may not be in an "always one-device"
> >>> group.  
> >>
> >> I don't really understand what you mean by that.  
> > 
> > I mean the group of the mdev's actual DMA device may have multiple
> > things in it.
> >     
> >>> It is a kernel driver so the only thing we know and care about is that
> >>> all devices in the HW group are bound to kernel drivers.
> >>>
> >>> The vfio device that spawns from this kernel driver is really a
> >>> "groups don't matter" vfio device because at the IOMMU layer it should
> >>> be riding on the physical group of the kernel driver.  At the VFIO
> >>> layer we no longer care about the group abstraction because the system
> >>> guarentees isolation in some other way.  
> >>
> >> Uh.. I don't really know how mdevs are isolated from each other.  I
> >> thought it was because the physical device providing the mdevs
> >> effectively had an internal IOMMU (or at least DMA permissioning) to
> >> isolate the mdevs, even though the physical device may not be fully
> >> isolated.
> >>
> >> In that case the virtual mdev is effectively in a singleton group,
> >> which is different from the group of its parent device.  
> >   
> 
> That's correct.
> 
> > That is one way to view it, but it means creating a whole group
> > infrastructure and abusing the IOMMU stack just to create this
> > nonsense fiction.  
> 
> I really didn't get how this abuse the IOMMU stack.
> mdev can be used in 3 different ways:
> 1. non-iommu backed mdev devices where mdev vendor driver takes care to
> DMA map (iommu_map) and isolation is through device hardware internal
> MMU. Here vfio_iommu_type1 module provides a way to validate and pin
> pages required by mdev device for DMA mapping. Then IOMMU mapping is
> done by mdev vendor driver which is owner driver of physical device.
> 
> 2. iommu backed mdev devices for SRIOV where mdev device is created per
> VF (mdev device == VF device) then that mdev device has same iommu
> protection scope as VF associated to it. Here mdev device is virtual
> device which uses features of mdev and represents underlying VF device,
> same as vfio-pci but with additional mdev features.

What features would those be?  There are no mdev specific parts of the
vfio uAPI.

The mdev device is a virtual device, by why it it virtual in this case?
Aren't we effectively assigning the VF itself (mdev device == VF device)
with a bunch of extra support code to fill in the gaps of the VF
implementing the complete device model in hardware?

We're effectively creating this virtual device, creating a fake IOMMU
group, and trying to create this association of this virtual device to
the real VF in order to shoehorn it into the mdev model.  What do we
get from that model other than lifecycle management (ie. type selection)
and re-use of a bunch of code from the driver supporting the 1) model
above?

This specific model seems better served by a device specific peer
driver to vfio-pci (ie. a "vfio-pci variant").  You effectively already
have the code for this driver, it's just in the format of an mdev
driver rather than a vfio "bus driver".  The work Jason references
relative to Max aims to make these kinds of drivers easier to implement
through re-use of vfio-pci code.

There are certainly other solutions we could come up with for selecting
a specific device type for a vfio-pci variant driver to implement other
than pretending this model actually belongs in mdev, right?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
