Return-Path: <SRS0=mply=KV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFBC47082
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 18:59:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7CC2613DD
	for <iommu@archiver.kernel.org>; Wed, 26 May 2021 18:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CC2613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7FE0640228;
	Wed, 26 May 2021 18:59:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ybNh2eKcJINu; Wed, 26 May 2021 18:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50323401EA;
	Wed, 26 May 2021 18:59:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FBA1C000E;
	Wed, 26 May 2021 18:59:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05D43C0001
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 18:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D27E183BC6
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 18:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id POuRls_PXb6K for <iommu@lists.linux-foundation.org>;
 Wed, 26 May 2021 18:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AF0083BAA
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622055554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoYRZh+gg2Z2kIQtfA8WYSEBkw/ZAfL87pNCe/N+cRg=;
 b=h65tnUdYi+1khgloaAElHADUrkRrNHSsmECZkP3jqiK64uCTTb/w8meVznjvaEkUl1y/YZ
 9VWZahSE3UuMQdrVIBIWnW2VvsTMA0bbQ6ZmRbLUdAhTil91BGRrtVm8NixNa0UrQrxTZi
 ug4N7op8xW9q1g/Nm0H6H9WwHsF7c+w=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-_3baGMBAPK6SrlBaE7hJ6g-1; Wed, 26 May 2021 14:59:11 -0400
X-MC-Unique: _3baGMBAPK6SrlBaE7hJ6g-1
Received: by mail-ot1-f69.google.com with SMTP id
 h8-20020a9d6a480000b02902edb9406104so1189361otn.5
 for <iommu@lists.linux-foundation.org>; Wed, 26 May 2021 11:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DoYRZh+gg2Z2kIQtfA8WYSEBkw/ZAfL87pNCe/N+cRg=;
 b=I18YDcwCIwaK/ZW5rgnxWqwbAsTqjOuMG/RKop8uF2ZweTovrbG+DRZOnij/RIlcuE
 CyJHt6pBhYHR60EVM54WO9NzJVbG9PXOE+I/i6tq64kmkW/g1N3lU4/qfLDX1Ymk1k2c
 94ucKODC6p+u1Jwq9qSWbWueDxN8sXTuV2FVF9m56HGxRhr46ufXr5UNFHcdUWs3rSZC
 lIOlJ3ZbLeXE8qFdXLDi1RrJmpMlNTzerRd/usCEsfOH+aD3ZsSzS9hLmu5ZM8njIIQn
 2YKF2qLk8rZoA9WSSRN5AtTM5fgS24/bZ0ILvJgErEC+3EKEvxPQd+HkN9D0RSLELdZ3
 051w==
X-Gm-Message-State: AOAM532sV/e+PEanbO5zHOBwGX6TPzBMaQqd7T5sp0B+p1I6EtBzaAl9
 WapCnaEZ+dRcUair6ifKbGOhINFU+O8AIi14B/AiYunOP3qGXYf4grLC29ldfi6eMb/T6YI42EJ
 7ee3k/nBai/M5Gio9ZiXUBl/sGgzNtw==
X-Received: by 2002:a9d:170e:: with SMTP id i14mr3484577ota.356.1622055551225; 
 Wed, 26 May 2021 11:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo3tyzehBt9NJTGiTbwUqpbdhoOW/Rc6ORs95QCF1BRJHbfzK/B96RXUwLS1GYrraEl5xI2A==
X-Received: by 2002:a9d:170e:: with SMTP id i14mr3484559ota.356.1622055550969; 
 Wed, 26 May 2021 11:59:10 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id w198sm10395oie.26.2021.05.26.11.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 11:59:10 -0700 (PDT)
Date: Wed, 26 May 2021 12:59:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210526125905.61e00a18.alex.williamson@redhat.com>
In-Reply-To: <6f9dad1a-4e15-1703-d6f4-1b51b7fde15a@nvidia.com>
References: <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box>
 <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
 <20210525165252.6959d9da.alex.williamson@redhat.com>
 <6f9dad1a-4e15-1703-d6f4-1b51b7fde15a@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, 
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
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

On Wed, 26 May 2021 23:40:02 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/26/2021 4:22 AM, Alex Williamson wrote:
> > On Wed, 26 May 2021 00:56:30 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> On 5/25/2021 5:07 AM, Jason Gunthorpe wrote:  
> >>> On Mon, May 24, 2021 at 05:52:58PM +1000, David Gibson wrote:
> >>>      
> >>>>>> I don't really see a semantic distinction between "always one-device
> >>>>>> groups" and "groups don't matter".  Really the only way you can afford
> >>>>>> to not care about groups is if they're singletons.  
> >>>>>
> >>>>> The kernel driver under the mdev may not be in an "always one-device"
> >>>>> group.  
> >>>>
> >>>> I don't really understand what you mean by that.  
> >>>
> >>> I mean the group of the mdev's actual DMA device may have multiple
> >>> things in it.
> >>>        
> >>>>> It is a kernel driver so the only thing we know and care about is that
> >>>>> all devices in the HW group are bound to kernel drivers.
> >>>>>
> >>>>> The vfio device that spawns from this kernel driver is really a
> >>>>> "groups don't matter" vfio device because at the IOMMU layer it should
> >>>>> be riding on the physical group of the kernel driver.  At the VFIO
> >>>>> layer we no longer care about the group abstraction because the system
> >>>>> guarentees isolation in some other way.  
> >>>>
> >>>> Uh.. I don't really know how mdevs are isolated from each other.  I
> >>>> thought it was because the physical device providing the mdevs
> >>>> effectively had an internal IOMMU (or at least DMA permissioning) to
> >>>> isolate the mdevs, even though the physical device may not be fully
> >>>> isolated.
> >>>>
> >>>> In that case the virtual mdev is effectively in a singleton group,
> >>>> which is different from the group of its parent device.  
> >>>      
> >>
> >> That's correct.
> >>  
> >>> That is one way to view it, but it means creating a whole group
> >>> infrastructure and abusing the IOMMU stack just to create this
> >>> nonsense fiction.  
> >>
> >> I really didn't get how this abuse the IOMMU stack.
> >> mdev can be used in 3 different ways:
> >> 1. non-iommu backed mdev devices where mdev vendor driver takes care to
> >> DMA map (iommu_map) and isolation is through device hardware internal
> >> MMU. Here vfio_iommu_type1 module provides a way to validate and pin
> >> pages required by mdev device for DMA mapping. Then IOMMU mapping is
> >> done by mdev vendor driver which is owner driver of physical device.
> >>
> >> 2. iommu backed mdev devices for SRIOV where mdev device is created per
> >> VF (mdev device == VF device) then that mdev device has same iommu
> >> protection scope as VF associated to it. Here mdev device is virtual
> >> device which uses features of mdev and represents underlying VF device,
> >> same as vfio-pci but with additional mdev features.  
> > 
> > What features would those be?  There are no mdev specific parts of the
> > vfio uAPI.
> > 
> > The mdev device is a virtual device, by why it it virtual in this case?
> > Aren't we effectively assigning the VF itself (mdev device == VF device)
> > with a bunch of extra support code to fill in the gaps of the VF
> > implementing the complete device model in hardware?
> > 
> > We're effectively creating this virtual device, creating a fake IOMMU
> > group, and trying to create this association of this virtual device to
> > the real VF in order to shoehorn it into the mdev model.  What do we
> > get from that model other than lifecycle management (ie. type selection)
> > and re-use of a bunch of code from the driver supporting the 1) model
> > above?
> >   
> 
> Yes, the lifecycle management which is in mdev is not in vfio-pci variant.
> 
> > This specific model seems better served by a device specific peer
> > driver to vfio-pci (ie. a "vfio-pci variant").  You effectively already
> > have the code for this driver, it's just in the format of an mdev
> > driver rather than a vfio "bus driver".  The work Jason references
> > relative to Max aims to make these kinds of drivers easier to implement
> > through re-use of vfio-pci code.
> > 
> > There are certainly other solutions we could come up with for selecting
> > a specific device type for a vfio-pci variant driver to implement other
> > than pretending this model actually belongs in mdev, right?  Thanks,
> >   
> 
> Sure and would like to see type selection mechanism to be implemented in 
> vfio-pci variant.


A driver provided sysfs attribute would obviously fill the short
term gap, long term maybe this would be standardized via netlink.  It
seems a bit analogous to setting the MAC address for a VF on an SR-IOV
NIC or VF namespace configuration for an SR-IOV NVMe device.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
