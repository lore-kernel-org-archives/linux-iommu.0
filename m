Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC2DC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:01:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF13461369
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 20:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF13461369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9890B60B7A;
	Thu,  3 Jun 2021 20:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zIFhurbXNrm5; Thu,  3 Jun 2021 20:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 441F5606C6;
	Thu,  3 Jun 2021 20:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC33C000E;
	Thu,  3 Jun 2021 20:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17CBDC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3D0D4059D
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R6TtAbjkoOyp for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 20:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 690A840596
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622750512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6+LhEY/maKDsGguwuWfmgtdd1oJK4V5TtjaYZTDv20=;
 b=fzgkrSiS8rAyWjVYwwhNkpnxs6l8Cm18Zn+GeMFLKFBjUDzfVREd3bOCr2yUv/XGt57AKF
 M8JOvw9fFQtb+jkmN/zKtYQqN6y4eT6CPP3EnYTBeP/PkcGN65WKWUatzlSDItjMmKaQ9q
 Nkp1l3zuMWzAXuhtUfinYZKuda9vR/o=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-X6VjlEtaN2GmbqLQGX3saA-1; Thu, 03 Jun 2021 16:01:49 -0400
X-MC-Unique: X6VjlEtaN2GmbqLQGX3saA-1
Received: by mail-ot1-f69.google.com with SMTP id
 a1-20020a9d47010000b0290320d09a96aaso3775956otf.16
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 13:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F6+LhEY/maKDsGguwuWfmgtdd1oJK4V5TtjaYZTDv20=;
 b=Lt9U/k9yt+DlPZjSw/8JxkxdWEnLbUEO7I6/w7ppx52F9lvEVzBB/42PtqHb649+GE
 lH1Sb7nfikALPhPz8kwWeXz1nxUBQZkjuVX5tYt9dG1hObFcMt2F+5uSP60dLmLsq0t5
 2pedmF+AV5OL4RzoTx8OaeJnIMwCB7YqjN8L5jUmN0R0KXvJqDw+W3a3NlaKG9fBd1/e
 NJKaMoB1LLUOB+c5Pq1BfW9guofn6CpuvPKXAQtPfCnhTGH3V0yNO069s+48VUqLMaoT
 QMN9Y8VvhNt/RdW9oFvxM+XqynhBUBd7COf9ly2YyNaahZ6fe7qk3/89qN740Uze0D1c
 W8yg==
X-Gm-Message-State: AOAM5339r3wcKFjniTc2quLHpVTaDmQFzW+alYIOzZDNddfYWk2veNqI
 m97soIMvuV/dmx/fwu+FVj28Py4fLOD8/cLEjnNK2rNSMx/jMxrBGJjEubEkn8FLr1/bvssDicL
 41hn7SfWPZgMvP8eVrOQ5J2oPE28Juw==
X-Received: by 2002:a05:6820:169:: with SMTP id k9mr788079ood.92.1622750508909; 
 Thu, 03 Jun 2021 13:01:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybJFE1PtzN0iAak9GBGh+YKYVXBvdZUdaTPamYD6BYxoi0dVe3UA/w7oY39pMfZVQl/8UgAw==
X-Received: by 2002:a05:6820:169:: with SMTP id k9mr788045ood.92.1622750508679; 
 Thu, 03 Jun 2021 13:01:48 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id p9sm891275otl.64.2021.06.03.13.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 13:01:48 -0700 (PDT)
Date: Thu, 3 Jun 2021 14:01:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210603140146.5ce4f08a.alex.williamson@redhat.com>
In-Reply-To: <20210603123401.GT1002214@nvidia.com>
References: <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <20210603123401.GT1002214@nvidia.com>
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

On Thu, 3 Jun 2021 09:34:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jun 02, 2021 at 08:50:54PM -0600, Alex Williamson wrote:
> > On Wed, 2 Jun 2021 19:45:36 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Wed, Jun 02, 2021 at 02:37:34PM -0600, Alex Williamson wrote:
> > >   
> > > > Right.  I don't follow where you're jumping to relaying DMA_PTE_SNP
> > > > from the guest page table... what page table?      
> > > 
> > > I see my confusion now, the phrasing in your earlier remark led me
> > > think this was about allowing the no-snoop performance enhancement in
> > > some restricted way.
> > > 
> > > It is really about blocking no-snoop 100% of the time and then
> > > disabling the dangerous wbinvd when the block is successful.
> > > 
> > > Didn't closely read the kvm code :\
> > > 
> > > If it was about allowing the optimization then I'd expect the guest to
> > > enable no-snoopable regions via it's vIOMMU and realize them to the
> > > hypervisor and plumb the whole thing through. Hence my remark about
> > > the guest page tables..
> > > 
> > > So really the test is just 'were we able to block it' ?  
> > 
> > Yup.  Do we really still consider that there's some performance benefit
> > to be had by enabling a device to use no-snoop?  This seems largely a
> > legacy thing.  
> 
> I've recently had some no-snoopy discussions lately.. The issue didn't
> vanish, it is still expensive going through all that cache hardware.
> 
> > > But Ok, back the /dev/ioasid. This answers a few lingering questions I
> > > had..
> > > 
> > > 1) Mixing IOMMU_CAP_CACHE_COHERENCY and !IOMMU_CAP_CACHE_COHERENCY
> > >    domains.
> > > 
> > >    This doesn't actually matter. If you mix them together then kvm
> > >    will turn on wbinvd anyhow, so we don't need to use the DMA_PTE_SNP
> > >    anywhere in this VM.
> > > 
> > >    This if two IOMMU's are joined together into a single /dev/ioasid
> > >    then we can just make them both pretend to be
> > >    !IOMMU_CAP_CACHE_COHERENCY and both not set IOMMU_CACHE.  
> > 
> > Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then we
> > need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
> > available based on the per domain support available.  That gives us the
> > most consistent behavior, ie. we don't have VMs emulating wbinvd
> > because they used to have a device attached where the domain required
> > it and we can't atomically remap with new flags to perform the same as
> > a VM that never had that device attached in the first place.  
> 
> I think we are saying the same thing..

Hrm?  I think I'm saying the opposite of your "both not set
IOMMU_CACHE".  IOMMU_CACHE is the mapping flag that enables
DMA_PTE_SNP.  Maybe you're using IOMMU_CACHE as the state reported to
KVM?

> > > 2) How to fit this part of kvm in some new /dev/ioasid world
> > > 
> > >    What we want to do here is iterate over every ioasid associated
> > >    with the group fd that is passed into kvm.  
> > 
> > Yeah, we need some better names, binding a device to an ioasid (fd) but
> > then attaching a device to an allocated ioasid (non-fd)... I assume
> > you're talking about the latter ioasid.  
> 
> Fingers crossed on RFCv2.. Here I mean the IOASID object inside the
> /dev/iommu FD. The vfio_device would have some kref handle to the
> in-kernel representation of it. So we can interact with it..
> 
> > >    Or perhaps more directly: an op attaching the vfio_device to the
> > >    kvm and having some simple helper 
> > >          '(un)register ioasid with kvm (kvm, ioasid)'
> > >    that the vfio_device driver can call that just sorts this out.  
> >
> > We could almost eliminate the device notion altogether here, use an
> > ioasidfd_for_each_ioasid() but we really want a way to trigger on each
> > change to the composition of the device set for the ioasid, which is
> > why we currently do it on addition or removal of a group, where the
> > group has a consistent set of IOMMU properties.  
> 
> That is another quite good option, just forget about trying to be
> highly specific and feed in the /dev/ioasid FD and have kvm ask "does
> anything in here not enforce snoop?"
> 
> With something appropriate to track/block changing that answer.
> 
> It doesn't solve the problem to connect kvm to AP and kvmgt though

It does not, we'll probably need a vfio ioctl to gratuitously announce
the KVM fd to each device.  I think some devices might currently fail
their open callback if that linkage isn't already available though, so
it's not clear when that should happen, ie. it can't currently be a
VFIO_DEVICE ioctl as getting the device fd requires an open, but this
proposal requires some availability of the vfio device fd without any
setup, so presumably that won't yet call the driver open callback.
Maybe that's part of the attach phase now... I'm not sure, it's not
clear when the vfio device uAPI starts being available in the process
of setting up the ioasid.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
