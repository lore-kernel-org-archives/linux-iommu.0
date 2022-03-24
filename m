Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0BEC433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 20:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F50260BC5;
	Thu, 24 Mar 2022 20:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PWf0UTfZTVTZ; Thu, 24 Mar 2022 20:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 49A9B605C9;
	Thu, 24 Mar 2022 20:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A923C0012;
	Thu, 24 Mar 2022 20:40:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 503E7C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 20:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A3C760B5E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 20:40:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwLOPk0T3qTA for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 20:40:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38708605C9
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648154423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcqkWAtIoHhKaWHguuTSHckFy2uV+KOK7nFBpa+JxJo=;
 b=em4wD0rtdSBJQX2Dm1/gTtxGd7l9quNqfyB009HTAEfMY/FpmAzlXB7E5Bk7iAMOUOtUPo
 KHo1HpI74JPl8yCS/6gRA1x4HukOGjDHuE4JrEcpziGfj37NL7q//LVmNGjMJE4oIOPTdx
 KBrld5Y9Yh1N19Ai8DHrZ72CnnE5I9Y=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-rn96SBANP5qNjVXFRgpgeg-1; Thu, 24 Mar 2022 16:40:20 -0400
X-MC-Unique: rn96SBANP5qNjVXFRgpgeg-1
Received: by mail-il1-f198.google.com with SMTP id
 x6-20020a923006000000b002bea39c3974so3443190ile.12
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 13:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=YcqkWAtIoHhKaWHguuTSHckFy2uV+KOK7nFBpa+JxJo=;
 b=twYA8wfQxLPgDCKnUxNSbOdWbTu7NPEa1h2947SQDhHt2di83h+RVp7SXAKOlXSqGx
 m0dPOcIQ15Ym4HpO1StwgoVj2h0DgrV1hvo1N894yyTT8EgOvp8LEjf/JrrjRzGbIXQA
 hwrBlyCcd/FDa5GwuLvmi/VD6TCKCZqTN3wkkCKslC6Q5953xNejXj4eNe3VtlS4ZsQr
 3vO0esrx3WwrdaCZVzhM9Q9j7kO9FawS/Yja0e9Q8g5TJ7/WaIp+Ia0yTlYR9euzygUJ
 ufNNXRgEzQwQffozXwZevtQm+KVW2urw5+4wuw8BLHv59tIV3SzrNlc/Z5w1GnKf2r9u
 Erkw==
X-Gm-Message-State: AOAM5323BQN44M95PuM/owI7pr+Ge83p9R8ocNIN8i1b11eHcDOUnj4L
 sDwvlb2h4FoMxRkeXTgu72EjdLBExsgNhhLJmfeD36tE1db5UmSr2m1hK0l87Ks4SY1Ux2LCuCb
 L8iWQtygJ0Lwwug+PjsqhYNN1rV1WK/mGS+nqVT1neCyoUUHbdGQUK5BCoICu3ELuDA74OOXz6h
 jL985TQoiac++vqTI=
X-Received: by 2002:a5d:9da0:0:b0:646:4297:19de with SMTP id
 ay32-20020a5d9da0000000b00646429719demr3763048iob.192.1648154419030; 
 Thu, 24 Mar 2022 13:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwopmqoCIMeyEsE8B56txeb229eqdmXoF3CZI0belX8dei6vqWnikSzyfxA9iLbrgAEVuuhIw==
X-Received: by 2002:a5d:9da0:0:b0:646:4297:19de with SMTP id
 ay32-20020a5d9da0000000b00646429719demr3763023iob.192.1648154418710; 
 Thu, 24 Mar 2022 13:40:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 q4-20020a056e0215c400b002c5fdff3087sm2320928ilu.29.2022.03.24.13.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 13:40:18 -0700 (PDT)
Date: Thu, 24 Mar 2022 14:40:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Message-ID: <20220324144015.031ca277.alex.williamson@redhat.com>
In-Reply-To: <20220322161521.GJ11336@nvidia.com>
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 kvm@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
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

On Tue, 22 Mar 2022 13:15:21 -0300
Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org> wrote:

> On Tue, Mar 22, 2022 at 09:29:23AM -0600, Alex Williamson wrote:
> 
> > I'm still picking my way through the series, but the later compat
> > interface doesn't mention this difference as an outstanding issue.
> > Doesn't this difference need to be accounted in how libvirt manages VM
> > resource limits?    
> 
> AFACIT, no, but it should be checked.
> 
> > AIUI libvirt uses some form of prlimit(2) to set process locked
> > memory limits.  
> 
> Yes, and ulimit does work fully. prlimit adjusts the value:
> 
> int do_prlimit(struct task_struct *tsk, unsigned int resource,
> 		struct rlimit *new_rlim, struct rlimit *old_rlim)
> {
> 	rlim = tsk->signal->rlim + resource;
> [..]
> 		if (new_rlim)
> 			*rlim = *new_rlim;
> 
> Which vfio reads back here:
> 
> drivers/vfio/vfio_iommu_type1.c:        unsigned long pfn, limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> drivers/vfio/vfio_iommu_type1.c:        unsigned long limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> 
> And iommufd does the same read back:
> 
> 	lock_limit =
> 		task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> 	npages = pages->npinned - pages->last_npinned;
> 	do {
> 		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
> 		new_pages = cur_pages + npages;
> 		if (new_pages > lock_limit)
> 			return -ENOMEM;
> 	} while (atomic_long_cmpxchg(&pages->source_user->locked_vm, cur_pages,
> 				     new_pages) != cur_pages);
> 
> So it does work essentially the same.

Well, except for the part about vfio updating mm->locked_vm and iommufd
updating user->locked_vm, a per-process counter versus a per-user
counter.  prlimit specifically sets process resource limits, which get
reflected in task_rlimit.

For example, let's say a user has two 4GB VMs and they're hot-adding
vfio devices to each of them, so libvirt needs to dynamically modify
the locked memory limit for each VM.  AIUI, libvirt would look at the
VM size and call prlimit to set that value.  If libvirt does this to
both VMs, then each has a task_rlimit of 4GB.  In vfio we add pinned
pages to mm->locked_vm, so this works well.  In the iommufd loop above,
we're comparing a per-task/process limit to a per-user counter.  So I'm
a bit lost how both VMs can pin their pages here.

Am I missing some assumption about how libvirt users prlimit or
sandboxes users?

> The difference is more subtle, iouring/etc puts the charge in the user
> so it is additive with things like iouring and additively spans all
> the users processes.
> 
> However vfio is accounting only per-process and only for itself - no
> other subsystem uses locked as the charge variable for DMA pins.
> 
> The user visible difference will be that a limit X that worked with
> VFIO may start to fail after a kernel upgrade as the charge accounting
> is now cross user and additive with things like iommufd.

And that's exactly the concern.
 
> This whole area is a bit peculiar (eg mlock itself works differently),
> IMHO, but with most of the places doing pins voting to use
> user->locked_vm as the charge it seems the right path in today's
> kernel.

The philosophy of whether it's ultimately a better choice for the
kernel aside, if userspace breaks because we're accounting in a
per-user pool rather than a per-process pool, then our compatibility
layer ain't so transparent.

> Ceratinly having qemu concurrently using three different subsystems
> (vfio, rdma, iouring) issuing FOLL_LONGTERM and all accounting for
> RLIMIT_MEMLOCK differently cannot be sane or correct.

I think everyone would agree with that, but it also seems there are
real differences between task_rlimits and per-user vs per-process
accounting buckets and I'm confused how that's not a blocker for trying
to implement transparent compatibility.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
