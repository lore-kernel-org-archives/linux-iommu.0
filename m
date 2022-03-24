Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A590EC433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 22:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3ABBE6104C;
	Thu, 24 Mar 2022 22:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrHj5Q9Ir_ON; Thu, 24 Mar 2022 22:04:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D7127607FE;
	Thu, 24 Mar 2022 22:04:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACAA4C0012;
	Thu, 24 Mar 2022 22:04:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5666CC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 22:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33D5481CE3
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 22:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DUXHdU7XDMqv for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 22:04:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A74E681CAD
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648159447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2AFpyFlXBgco+VqYSZsqBuFpsgC1f/3TZbRqwznPwM=;
 b=bynabz7MXFJu3rtQGbFkrTASNCRU2TkQbeYQ0PmHXv8h5g07WvN07PDK9BfazTFQ6Qste8
 XY2mEQGRwFL34Hk0vafKOePnDXNddtl6l6+O8lN9aZt2vxZBe6roxm31lDECduwqNTARs9
 Ono3vbAVyXgIb8aN9GWOfi+Sbwu5gro=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-6yKOQfXHN4WoYWoe2d0O3g-1; Thu, 24 Mar 2022 18:04:06 -0400
X-MC-Unique: 6yKOQfXHN4WoYWoe2d0O3g-1
Received: by mail-il1-f198.google.com with SMTP id
 g2-20020a056e02130200b002c837b25e60so3540081ilr.20
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 15:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=G2AFpyFlXBgco+VqYSZsqBuFpsgC1f/3TZbRqwznPwM=;
 b=uZDg0uVKYqEJxY782x/YmGUovhp89dNaMF7yNhbSIOY8TG2R0S/RBmU8Zlf3gPzLIc
 BFQx/ch7BtMcjN05ad5TJC1JPvi+5igll3damax1tKk1kmK4Myc4tSrBGeWisGpY9FSh
 y17FNWIb+3PA7gr/akzK7JGuSnjprQzzYlXkXCkFI5fOPziHqIzlJOCMxq/lY00CfMil
 HYv74VKO2JaKDoN8Z1FAMD3n5wZi1kp5vj/ckk/Ou05IBUvqua3x+S1zDTHnqXbOCPxa
 koco7dz3sPjXJ2Ysx13fwC8uL0AvfASOqemY71FtL7q+INlrvd+fEoy3Y52IfVhmyeK8
 zxoA==
X-Gm-Message-State: AOAM533efSf3BkGRTGqSikNV8Vk8bvN7CwP6vfL8BekGCZay2FPiAlZU
 nXVB5TQ4gcMARV5AK9VAyHBkJlZc8fnKhUx+ZiQJky4atCL1YE6ghOkYAeoMfwxsI03naciQsii
 eJHrvuTWjRMb4bq34efjnFRNwqK3dgg==
X-Received: by 2002:a05:6638:13cf:b0:319:e4eb:ac0 with SMTP id
 i15-20020a05663813cf00b00319e4eb0ac0mr4067438jaj.209.1648159445311; 
 Thu, 24 Mar 2022 15:04:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgAdRk7l9Q4iHYdb0ppw6ZPRlja3+sEz7RMEsJ5GJTRVbl6/Ug4jB6W8gdKTPr3N+yE6FyfA==
X-Received: by 2002:a05:6638:13cf:b0:319:e4eb:ac0 with SMTP id
 i15-20020a05663813cf00b00319e4eb0ac0mr4067413jaj.209.1648159445007; 
 Thu, 24 Mar 2022 15:04:05 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 m5-20020a927105000000b002c60ed6d3afsm2068970ilc.69.2022.03.24.15.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 15:04:04 -0700 (PDT)
Date: Thu, 24 Mar 2022 16:04:03 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <20220324160403.42131028.alex.williamson@redhat.com>
In-Reply-To: <20220324003342.GV11336@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
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

On Wed, 23 Mar 2022 21:33:42 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 23, 2022 at 04:51:25PM -0600, Alex Williamson wrote:
> 
> > My overall question here would be whether we can actually achieve a
> > compatibility interface that has sufficient feature transparency that we
> > can dump vfio code in favor of this interface, or will there be enough
> > niche use cases that we need to keep type1 and vfio containers around
> > through a deprecation process?  
> 
> Other than SPAPR, I think we can.

Does this mean #ifdef CONFIG_PPC in vfio core to retain infrastructure
for POWER support?

> > The locked memory differences for one seem like something that
> > libvirt wouldn't want hidden  
> 
> I'm first interested to have an understanding how this change becomes
> a real problem in practice that requires libvirt to do something
> different for vfio or iommufd. We can discuss in the other thread
> 
> If this is the make or break point then I think we can deal with it
> either by going back to what vfio does now or perhaps some other
> friendly compat approach..
> 
> > and we have questions regarding support for vaddr hijacking  
> 
> I'm not sure what vaddr hijacking is? Do you mean
> VFIO_DMA_MAP_FLAG_VADDR ? There is a comment that outlines my plan to
> implement it in a functionally compatible way without the deadlock
> problem. I estimate this as a small project.
> 
> > and different ideas how to implement dirty page tracking,   
> 
> I don't think this is compatibility. No kernel today triggers qemu to
> use this feature as no kernel supports live migration. No existing
> qemu will trigger this feature with new kernels that support live
> migration v2. Therefore we can adjust qemu's dirty tracking at the
> same time we enable migration v2 in qemu.

I guess I was assuming that enabling v2 migration in QEMU was dependent
on the existing type1 dirty tracking because it's the only means we
have to tell QEMU that all memory is perpetually dirty when we have a
DMA device.  Is that not correct?  If we don't intend to carry type1
dirty tracking into iommufd compatibility and we need it for this
purpose, then our window for being able to rip it out entirely closes
when QEMU gains v2 migration support.

> With Joao's work we are close to having a solid RFC to come with
> something that can be fully implemented.
> 
> Hopefully we can agree to this soon enough that qemu can come with a
> full package of migration v2 support including the dirty tracking
> solution.
> 
> > not to mention the missing features that are currently well used,
> > like p2p mappings, coherency tracking, mdev, etc.  
> 
> I consider these all mandatory things, they won't be left out.
> 
> The reason they are not in the RFC is mostly because supporting them
> requires work outside just this iommufd area, and I'd like this series
> to remain self-contained.
> 
> I've already got a draft to add DMABUF support to VFIO PCI which
> nicely solves the follow_pfn security problem, we want to do this for
> another reason already. I'm waiting for some testing feedback before
> posting it. Need some help from Daniel make the DMABUF revoke semantic
> him and I have been talking about. In the worst case can copy the
> follow_pfn approach.
> 
> Intel no-snoop is simple enough, just needs some Intel cleanup parts.
> 
> mdev will come along with the final VFIO integration, all the really
> hard parts are done already. The VFIO integration is a medium sized
> task overall.
> 
> So, I'm not ready to give up yet :)

Ok, that's a more promising outlook than I was inferring from the long
list of missing features.

> > Where do we focus attention?  Is symlinking device files our proposal
> > to userspace and is that something achievable, or do we want to use
> > this compatibility interface as a means to test the interface and
> > allow userspace to make use of it for transition, if their use cases
> > allow it, perhaps eventually performing the symlink after deprecation
> > and eventual removal of the vfio container and type1 code?  Thanks,  
> 
> symlinking device files is definitely just a suggested way to expedite
> testing.
> 
> Things like qemu that are learning to use iommufd-only features should
> learn to directly open iommufd instead of vfio container to activate
> those features.

Which is kind of the basis for my question, QEMU is racing for native
support, Eric and Yi are already working on this, so some of these
compatibility interfaces might only have short term usefulness.

> Looking long down the road I don't think we want to have type 1 and
> iommufd code forever.

Agreed.

> So, I would like to make an option to compile
> out vfio container support entirely and have that option arrange for
> iommufd to provide the container device node itself.
> 
> I think we can get there pretty quickly, or at least I haven't got
> anything that is scaring me alot (beyond SPAPR of course)
> 
> For the dpdk/etcs of the world I think we are already there.

That's essentially what I'm trying to reconcile, we're racing both
to round out the compatibility interface to fully support QEMU, while
also updating QEMU to use iommufd directly so it won't need that full
support.  It's a confusing message.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
