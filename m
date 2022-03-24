Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA02C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 02:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F39BB60B2A;
	Thu, 24 Mar 2022 02:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpKgs0P2YpuD; Thu, 24 Mar 2022 02:57:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8A3860AD0;
	Thu, 24 Mar 2022 02:57:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7505AC0012;
	Thu, 24 Mar 2022 02:57:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B793C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 02:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC4B24011C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 02:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qduxzg_0hAhP for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 02:57:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B10D9400C6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 02:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648090645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yl90AA/Y+H6NGy6q46+IoWaG7Q0hgnj/jg+yUw8fNDI=;
 b=ZmW2GWr2EHLxKWIAYSGuSc0syawSbI+u3E/Ki9yYW97fjpV9pGDTS+DOJvUtetzbEfuqwY
 XxhPZo0T/hftvCslsMY3OwUxQmh1OpLWpzdpvXCJ5/B9D4dbhAqx/M2dEk95HrswALTDNG
 Tp/+/HDZw0KiMsaFes37BtLmarpFYkc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-ykaiH0XIO2auY0EDsAtygw-1; Wed, 23 Mar 2022 22:57:24 -0400
X-MC-Unique: ykaiH0XIO2auY0EDsAtygw-1
Received: by mail-lj1-f197.google.com with SMTP id
 v8-20020a2e7a08000000b002498273eb20so1306266ljc.7
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yl90AA/Y+H6NGy6q46+IoWaG7Q0hgnj/jg+yUw8fNDI=;
 b=Nkcj58+DSso4BSXPHkvtUCseCMGlRNCqDK9IXDtqTuCkP0USi3DOlkQZpz5nCfHbE5
 efn1/Jl2loz2x5MO0+jNb27pWIm7ZhhvdNxz/ujrzDFE0KFpF0ndFjv6EQc3r5m6g79E
 NEj5LPhMow82mY7A99I8gGxd+wSB5DI6TRNWSUmOIB1gou29I38POAFCwmDLy0d8a0MV
 ra0QJe/ttdYrjRuydwwGFPeCoNcKk6dr6VHoaZAPzkxdkWWuNE60r730P/pdOYW4It2h
 RDNqib6BK4LKddrdZgbpdjehlDB60SbiF5wmMDRQ3LM50NLNYp1xQCxS2Ax1A/m8mftg
 nBdw==
X-Gm-Message-State: AOAM532phEegGFTalMRQTeyJJVFXOW7PL5zEvzqsTo5gHHWISOWctRCw
 4aBElQjEgRuIrboPZDcRpxl90EoVc0eAFOyKZ5ruVl4/gwdqdLm5TAC+E/w9LtGSqfJ9J6UcT4K
 sZaQChKom4M3BdAHHvhD0QJ3LktMGqEJQlhJ+I1mGuf5JNg==
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr2174743lfh.471.1648090642640; 
 Wed, 23 Mar 2022 19:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzJ/xz77RqYPbAnUsjAXWRE0dX/Yi/URV6UnaarPNR6y933aN7AFCJeX/r3r1226S/TQ5+hwXTTCCWAhuzJPQ=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr2174713lfh.471.1648090642411; Wed, 23
 Mar 2022 19:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 24 Mar 2022 10:57:11 +0800
Message-ID: <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be usable
 for iommufd
To: "Tian, Kevin" <kevin.tian@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
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

On Thu, Mar 24, 2022 at 10:42 AM Tian, Kevin <kevin.tian@intel.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, March 24, 2022 10:28 AM
> >
> > On Thu, Mar 24, 2022 at 10:12 AM Tian, Kevin <kevin.tian@intel.com> wrote:
> > >
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Wednesday, March 23, 2022 12:15 AM
> > > >
> > > > On Tue, Mar 22, 2022 at 09:29:23AM -0600, Alex Williamson wrote:
> > > >
> > > > > I'm still picking my way through the series, but the later compat
> > > > > interface doesn't mention this difference as an outstanding issue.
> > > > > Doesn't this difference need to be accounted in how libvirt manages VM
> > > > > resource limits?
> > > >
> > > > AFACIT, no, but it should be checked.
> > > >
> > > > > AIUI libvirt uses some form of prlimit(2) to set process locked
> > > > > memory limits.
> > > >
> > > > Yes, and ulimit does work fully. prlimit adjusts the value:
> > > >
> > > > int do_prlimit(struct task_struct *tsk, unsigned int resource,
> > > >               struct rlimit *new_rlim, struct rlimit *old_rlim)
> > > > {
> > > >       rlim = tsk->signal->rlim + resource;
> > > > [..]
> > > >               if (new_rlim)
> > > >                       *rlim = *new_rlim;
> > > >
> > > > Which vfio reads back here:
> > > >
> > > > drivers/vfio/vfio_iommu_type1.c:        unsigned long pfn, limit =
> > > > rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > drivers/vfio/vfio_iommu_type1.c:        unsigned long limit =
> > > > rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > >
> > > > And iommufd does the same read back:
> > > >
> > > >       lock_limit =
> > > >               task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
> > > > PAGE_SHIFT;
> > > >       npages = pages->npinned - pages->last_npinned;
> > > >       do {
> > > >               cur_pages = atomic_long_read(&pages->source_user-
> > > > >locked_vm);
> > > >               new_pages = cur_pages + npages;
> > > >               if (new_pages > lock_limit)
> > > >                       return -ENOMEM;
> > > >       } while (atomic_long_cmpxchg(&pages->source_user->locked_vm,
> > > > cur_pages,
> > > >                                    new_pages) != cur_pages);
> > > >
> > > > So it does work essentially the same.
> > > >
> > > > The difference is more subtle, iouring/etc puts the charge in the user
> > > > so it is additive with things like iouring and additively spans all
> > > > the users processes.
> > > >
> > > > However vfio is accounting only per-process and only for itself - no
> > > > other subsystem uses locked as the charge variable for DMA pins.
> > > >
> > > > The user visible difference will be that a limit X that worked with
> > > > VFIO may start to fail after a kernel upgrade as the charge accounting
> > > > is now cross user and additive with things like iommufd.
> > > >
> > > > This whole area is a bit peculiar (eg mlock itself works differently),
> > > > IMHO, but with most of the places doing pins voting to use
> > > > user->locked_vm as the charge it seems the right path in today's
> > > > kernel.
> > > >
> > > > Ceratinly having qemu concurrently using three different subsystems
> > > > (vfio, rdma, iouring) issuing FOLL_LONGTERM and all accounting for
> > > > RLIMIT_MEMLOCK differently cannot be sane or correct.
> > > >
> > > > I plan to fix RDMA like this as well so at least we can have
> > > > consistency within qemu.
> > > >
> > >
> > > I have an impression that iommufd and vfio type1 must use
> > > the same accounting scheme given the management stack
> > > has no insight into qemu on which one is actually used thus
> > > cannot adapt to the subtle difference in between. in this
> > > regard either we start fixing vfio type1 to use user->locked_vm
> > > now or have iommufd follow vfio type1 for upward compatibility
> > > and then change them together at a later point.
> > >
> > > I prefer to the former as IMHO I don't know when will be a later
> > > point w/o certain kernel changes to actually break the userspace
> > > policy built on a wrong accounting scheme...
> >
> > I wonder if the kernel is the right place to do this. We have new uAPI
>
> I didn't get this. This thread is about that VFIO uses a wrong accounting
> scheme and then the discussion is about the impact of fixing it to the
> userspace.

It's probably too late to fix the kernel considering it may break the userspace.

> I didn't see the question on the right place part.

I meant it would be easier to let userspace know the difference than
trying to fix or workaround in the kernel.

>
> > so management layer can know the difference of the accounting in
> > advance by
> >
> > -device vfio-pci,iommufd=on
> >
>
> I suppose iommufd will be used once Qemu supports it, as long as
> the compatibility opens that Jason/Alex discussed in another thread
> are well addressed. It is not necessarily to be a control knob exposed
> to the caller.

It has a lot of implications if we do this, it means iommufd needs to
inherit all the userspace noticeable behaviour as well as the "bugs"
of VFIO.

We know it's easier to find the difference than saying no difference.

Thanks

>
> Thanks
> Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
