Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC498C47080
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 04:15:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777E6613B4
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 04:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777E6613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15A104058B;
	Thu,  3 Jun 2021 04:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vfiP2bzG8s84; Thu,  3 Jun 2021 04:15:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 555914057E;
	Thu,  3 Jun 2021 04:15:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A66AC000E;
	Thu,  3 Jun 2021 04:15:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A0A2C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 04:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE9C8400D9
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 04:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJEEpdslORWN for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 04:15:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4E8F400B8
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 04:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622693699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2PxtKW9qJ+Vtox4Ih/NvHqS0Jy9B5n5YztFOiLLauQ=;
 b=AWIycqS6B6h5zwy0MerKa7Ykrhv09Feovcd+InUOIi1vQ8n5wwMwVbZ4X4LbhunOXYKMm5
 zKCAl1Vy2uERzYK+BNrMfZLDIOgutcQWEb+yZBAOLJAWI6vUFoSWfm3CMn7Mkmf7O58/Mg
 RL1nAbylv6uWh9vHED/rz0k3Bs6dXXw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-hlVltGKSMnGj2YbY9pYDaw-1; Thu, 03 Jun 2021 00:14:58 -0400
X-MC-Unique: hlVltGKSMnGj2YbY9pYDaw-1
Received: by mail-ot1-f71.google.com with SMTP id
 96-20020a9d07e90000b02903c030760be3so2504448oto.4
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 21:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c2PxtKW9qJ+Vtox4Ih/NvHqS0Jy9B5n5YztFOiLLauQ=;
 b=C1WAOtZQap4TUaHIw1JOnYprcEuuzkCgEgvh4P8qZ2Syi7b9OlInJw+OVyeFT6xw78
 DjwAFcdMpPrJYZY386+olnwxa7RJZbQ13DIiLPG8Qsl2bGxTm0XvCH7RPekO5XdI8sn5
 LPiw1O3rwA3Lmb5sbOpissva5sUvjaFzMWLrTKgaeslkJj1hSDW/lbQxCtetTT+QcMq/
 IdkHRAgzmS1nzrNu9W6kMQePCSbOe3GV+PMjguwYeIwyttgl+txsO4uMB/YSfhOTle7Q
 hzQakZAiC8QxLsUPgKnphMemzOvTrMSBMvuOjwQXv3rivNU2whVNR2mdS0KwEKBEHWP1
 gyxQ==
X-Gm-Message-State: AOAM5317LtW+7PNXG8OFdFL/rjfMKfs5KTRRrw72LdJ+xy68OzrN8SZW
 Ws/cHwjPKr0kQMPGbQoj0J5/LAE6B+DFfh/HdKx++1cbSWt8TqGK03jvPFcbZI7V6DYA5Zt9iHw
 lVRt13MTpjl7PzGxd744VQKZ5MJN99A==
X-Received: by 2002:a9d:75d2:: with SMTP id c18mr28307578otl.219.1622693697186; 
 Wed, 02 Jun 2021 21:14:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMVK/MDbfe2aoBwzokzamUhEXIbT+izHOFTQ060sbCY3SaNEqBjqgWXgPdNAX/pdyZ+/rtsA==
X-Received: by 2002:a9d:75d2:: with SMTP id c18mr28307561otl.219.1622693696891; 
 Wed, 02 Jun 2021 21:14:56 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id t39sm415459ooi.42.2021.06.02.21.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 21:14:56 -0700 (PDT)
Date: Wed, 2 Jun 2021 22:14:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210602221455.79a42878.alex.williamson@redhat.com>
In-Reply-To: <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210601162225.259923bc.alex.williamson@redhat.com>
 <MWHPR11MB1886E8454A58661DC2CDBA678C3D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210602160140.GV1002214@nvidia.com>
 <20210602111117.026d4a26.alex.williamson@redhat.com>
 <20210602173510.GE1002214@nvidia.com>
 <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <20210602224536.GJ1002214@nvidia.com>
 <20210602205054.3505c9c3.alex.williamson@redhat.com>
 <MWHPR11MB1886DC8ECF5D56FE485D13D58C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, 3 Jun 2021 03:22:27 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, June 3, 2021 10:51 AM
> > 
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
> Yes, there is indeed performance benefit for device to use no-snoop,
> e.g. 8K display and some imaging processing path, etc. The problem is
> that the IOMMU for such devices is typically a different one from the
> default IOMMU for most devices. This special IOMMU may not have
> the ability of enforcing snoop on no-snoop PCI traffic then this fact
> must be understood by KVM to do proper mtrr/pat/wbinvd virtualization 
> for such devices to work correctly.

The case where the IOMMU does not support snoop-control for such a
device already works fine, we can't prevent no-snoop so KVM will
emulate wbinvd.  The harder one is if we should opt to allow no-snoop
even if the IOMMU does support snoop-control.
 
> > > > This support existed before mdev, IIRC we needed it for direct
> > > > assignment of NVIDIA GPUs.  
> > >
> > > Probably because they ignored the disable no-snoop bits in the control
> > > block, or reset them in some insane way to "fix" broken bioses and
> > > kept using it even though by all rights qemu would have tried hard to
> > > turn it off via the config space. Processing no-snoop without a
> > > working wbinvd would be fatal. Yeesh
> > >
> > > But Ok, back the /dev/ioasid. This answers a few lingering questions I
> > > had..
> > >
> > > 1) Mixing IOMMU_CAP_CACHE_COHERENCY  
> > and !IOMMU_CAP_CACHE_COHERENCY  
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
> > Yes and no.  Yes, if any domain is !IOMMU_CAP_CACHE_COHERENCY then
> > we
> > need to emulate wbinvd, but no we'll use IOMMU_CACHE any time it's
> > available based on the per domain support available.  That gives us the
> > most consistent behavior, ie. we don't have VMs emulating wbinvd
> > because they used to have a device attached where the domain required
> > it and we can't atomically remap with new flags to perform the same as
> > a VM that never had that device attached in the first place.
> >   
> > > 2) How to fit this part of kvm in some new /dev/ioasid world
> > >
> > >    What we want to do here is iterate over every ioasid associated
> > >    with the group fd that is passed into kvm.  
> > 
> > Yeah, we need some better names, binding a device to an ioasid (fd) but
> > then attaching a device to an allocated ioasid (non-fd)... I assume
> > you're talking about the latter ioasid.
> >   
> > >    Today the group fd has a single container which specifies the
> > >    single ioasid so this is being done trivially.
> > >
> > >    To reorg we want to get the ioasid from the device not the
> > >    group (see my note to David about the groups vs device rational)
> > >
> > >    This is just iterating over each vfio_device in the group and
> > >    querying the ioasid it is using.  
> > 
> > The IOMMU API group interfaces is largely iommu_group_for_each_dev()
> > anyway, we still need to account for all the RIDs and aliases of a
> > group.
> >   
> > >    Or perhaps more directly: an op attaching the vfio_device to the
> > >    kvm and having some simple helper
> > >          '(un)register ioasid with kvm (kvm, ioasid)'
> > >    that the vfio_device driver can call that just sorts this out.  
> > 
> > We could almost eliminate the device notion altogether here, use an
> > ioasidfd_for_each_ioasid() but we really want a way to trigger on each
> > change to the composition of the device set for the ioasid, which is
> > why we currently do it on addition or removal of a group, where the
> > group has a consistent set of IOMMU properties.  Register a notifier
> > callback via the ioasidfd?  Thanks,
> >   
> 
> When discussing I/O page fault support in another thread, the consensus
> is that an device handle will be registered (by user) or allocated (return
> to user) in /dev/ioasid when binding the device to ioasid fd. From this 
> angle we can register {ioasid_fd, device_handle} to KVM and then call 
> something like ioasidfd_device_is_coherent() to get the property. 
> Anyway the coherency is a per-device property which is not changed 
> by how many I/O page tables are attached to it.

The mechanics are different, but this is pretty similar in concept to
KVM learning coherence using the groupfd today.  Do we want to
compromise on kernel control of wbinvd emulation to allow userspace to
make such decisions?  Ownership of a device might be reason enough to
allow the user that privilege.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
