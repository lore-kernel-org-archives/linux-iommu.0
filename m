Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE50C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:41:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBFA613DE
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFA613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53A1960BA2;
	Thu,  3 Jun 2021 20:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJTkR9xVGcRP; Thu,  3 Jun 2021 20:41:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8E6660BB2;
	Thu,  3 Jun 2021 20:41:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA932C000D;
	Thu,  3 Jun 2021 20:41:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24252C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0FA18433F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IjxLvz4WvRHA for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 20:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E479B8433C
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622752901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLv3J4sXkt9z19cRT1XYaQD2oi8vzzx5bPwW4C7AJSo=;
 b=hHTmQjM3SCzAkZZzvnw4zD6gqF3T2kCpHytvjFGzkAmkbHS7XbSGYNaPgjSsHxHlpmwHLK
 RkjYzxoA7OqoT/xgL5tOhwobwLlt8MU/XFMDo4I7W72XAnbZW1wBdyT/ZgStOBeVCPTD4x
 LHy5QNf18AebVqoupdcLk9R0UNG+2fA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-Em1DFqmJMQOCgdMokCaydg-1; Thu, 03 Jun 2021 16:41:40 -0400
X-MC-Unique: Em1DFqmJMQOCgdMokCaydg-1
Received: by mail-oi1-f200.google.com with SMTP id
 r194-20020acaa8cb0000b02901f15926212dso3564545oie.12
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 13:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qLv3J4sXkt9z19cRT1XYaQD2oi8vzzx5bPwW4C7AJSo=;
 b=jnI8P2puPmntrCx9Hu7b+gKKHPNE/XUtvIhyIz1LjuxCkf+qAspT/CzPMruiVwN0oS
 JLpwN7t1M5t4FiY8YdbKaMdOa2fWD/zBn+IGTJjjtZ3RzydB4WHGlAgZo9fYx5BxhSGR
 iKGqwlA6L2wqhyWkXlCtoqiZ5tV4OvSw68H1DirRzFfb0QxJfRmM+5gIpcEK6C7fV1rO
 pjgRFUdLUI/FaO5hRA2Mb1T6fjPe3O7KU7IibZRDCLDT+DHu2bm2KXZ2UN7ikRyT82A1
 SS2kLmD+PFnq9curdkNeACi5vO3TZH2APQ4kslmSHhyd/p7KF690Y6UhSCzzv/5H5vJV
 XaCA==
X-Gm-Message-State: AOAM532Kz9YGPdXnfbuOvMeWUhdmzxMrS7C5LKvjIvTK/vW0dWkiYA1D
 UoycmgRIEj+0JZgmVk/obrc5hgvV0I94xOZYh3QVzOke8mVf3hzJtG0Gaad1i1siAMxfNKV8Y8B
 QvBxYaibMtjk1iAI3D/nsKZj9YJ3YVw==
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr986991ott.190.1622752899527; 
 Thu, 03 Jun 2021 13:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLIRY2X/fmxM+nr4TMws/lLcuX+l7GhTX4Ij4lEgnN5xDncIaqE9ba/YtSx5Zz0gC7BSFScA==
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr986965ott.190.1622752899308; 
 Thu, 03 Jun 2021 13:41:39 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id m28sm897060otr.81.2021.06.03.13.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 13:41:38 -0700 (PDT)
Date: Thu, 3 Jun 2021 14:41:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603144136.2b68c5c5.alex.williamson@redhat.com>
In-Reply-To: <20210603124036.GU1002214@nvidia.com>
References: <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603124036.GU1002214@nvidia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
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

On Thu, 3 Jun 2021 09:40:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Jun 03, 2021 at 03:22:27AM +0000, Tian, Kevin wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Thursday, June 3, 2021 10:51 AM
> > > 
> > > On Wed, 2 Jun 2021 19:45:36 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >   
> > > > On Wed, Jun 02, 2021 at 02:37:34PM -0600, Alex Williamson wrote:
> > > >  
> > > > > Right.  I don't follow where you're jumping to relaying DMA_PTE_SNP
> > > > > from the guest page table... what page table?  
> > > >
> > > > I see my confusion now, the phrasing in your earlier remark led me
> > > > think this was about allowing the no-snoop performance enhancement in
> > > > some restricted way.
> > > >
> > > > It is really about blocking no-snoop 100% of the time and then
> > > > disabling the dangerous wbinvd when the block is successful.
> > > >
> > > > Didn't closely read the kvm code :\
> > > >
> > > > If it was about allowing the optimization then I'd expect the guest to
> > > > enable no-snoopable regions via it's vIOMMU and realize them to the
> > > > hypervisor and plumb the whole thing through. Hence my remark about
> > > > the guest page tables..
> > > >
> > > > So really the test is just 'were we able to block it' ?  
> > > 
> > > Yup.  Do we really still consider that there's some performance benefit
> > > to be had by enabling a device to use no-snoop?  This seems largely a
> > > legacy thing.  
> > 
> > Yes, there is indeed performance benefit for device to use no-snoop,
> > e.g. 8K display and some imaging processing path, etc. The problem is
> > that the IOMMU for such devices is typically a different one from the
> > default IOMMU for most devices. This special IOMMU may not have
> > the ability of enforcing snoop on no-snoop PCI traffic then this fact
> > must be understood by KVM to do proper mtrr/pat/wbinvd virtualization 
> > for such devices to work correctly.  
> 
> Or stated another way:
> 
> We in Linux don't have a way to control if the VFIO IO page table will
> be snoop or no snoop from userspace so Intel has forced the platform's
> IOMMU path for the integrated GPU to be unable to enforce snoop, thus
> "solving" the problem.

That's giving vfio a lot of credit for influencing VT-d design.

> I don't think that is sustainable in the oveall ecosystem though.

Our current behavior is a reasonable default IMO, but I agree more
control will probably benefit us in the long run.

> 'qemu --allow-no-snoop' makes more sense to me

I'd be tempted to attach it to the -device vfio-pci option, it's
specific drivers for specific devices that are going to want this and
those devices may not be permanently attached to the VM.  But I see in
the other thread you're trying to optimize IOMMU page table sharing.

There's a usability question in either case though and I'm not sure how
to get around it other than QEMU or the kernel knowing a list of
devices (explicit IDs or vendor+class) to select per device defaults.

> > When discussing I/O page fault support in another thread, the consensus
> > is that an device handle will be registered (by user) or allocated (return
> > to user) in /dev/ioasid when binding the device to ioasid fd. From this 
> > angle we can register {ioasid_fd, device_handle} to KVM and then call 
> > something like ioasidfd_device_is_coherent() to get the property. 
> > Anyway the coherency is a per-device property which is not changed 
> > by how many I/O page tables are attached to it.  
> 
> It is not device specific, it is driver specific
> 
> As I said before, the question is if the IOASID itself can enforce
> snoop, or not. AND if the device will issue no-snoop or not.
> 
> Devices that are hard wired to never issue no-snoop are safe even with
> an IOASID that cannot enforce snoop. AFAIK really only GPUs use this
> feature. Eg I would be comfortable to say mlx5 never uses the no-snoop
> TLP flag.
> 
> Only the vfio_driver could know this.

Could you clarify "vfio_driver"?  The existing vfio-pci driver can't
know this, beyond perhaps probing if the Enable No-snoop bit is
hardwired to zero.  It's the driver running on top of vfio that
ultimately controls whether a capable device actually issues no-snoop
TLPs, but that can't be known to us.  A vendor variant of vfio-pci
might certainly know more about how its device is used by those
userspace/VM drivers.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
