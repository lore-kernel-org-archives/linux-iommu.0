Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99718C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 08:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0BEC7405CD;
	Thu, 24 Mar 2022 08:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmWsy04Ecv0e; Thu, 24 Mar 2022 08:13:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54FCA404B4;
	Thu, 24 Mar 2022 08:13:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28C61C001A;
	Thu, 24 Mar 2022 08:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81F91C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 08:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62ED160634
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 08:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lj7FDggof3Ud for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:13:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 104056068F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648109603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdR6oSXMqEs5QEeFJD+qqMG0zJL2wvv5dMMWUkVUeNU=;
 b=Qj1n2Y9TOQV5Ts7llIm2bw4FY1BnT/QpckIcUViJhfZcdA5vOObhGa+ic7a7IeyxEKj3lU
 wSDMDMmyTUBJOvLdXfTHimnM0g8935xB7+P6SmJLMPA33hqj0GHIWMXx0Yp5QzeKExhuoT
 HbT+hlPtpo/iWr8CEWAgYcNfrfyV0B0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-djcxkbFVP5GEXs93w3QFeQ-1; Thu, 24 Mar 2022 04:13:21 -0400
X-MC-Unique: djcxkbFVP5GEXs93w3QFeQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 r64-20020a1c2b43000000b0038b59eb1940so2929335wmr.0
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=kdR6oSXMqEs5QEeFJD+qqMG0zJL2wvv5dMMWUkVUeNU=;
 b=HXk4tfKsIudhiyy7lHKXAvdUJ92hmQGSlv6p0SeCfQRNhcweC+uQbr13FFI9NW55TM
 d3rVPOsq9FkqUMr6I8r8G4TU8/T4PFYLNuiNTSpp1NNANKyobI5PuQPSaKukdIIlnH1h
 2s4hsm8wxrn5i3bEEJfu4hibQMytvZPwLzooc4su+xAyhVadBh13Y5uQfbHH2Biiy2vY
 6Px8jvR/t76ESeJfbq2yZIts4LQ1KueQpkgsY5wUER/5RjdU+3xe4576tgwpqRBPxs1U
 wIsqG4XoTX+Y26y3OTE67xifsQlH53pONp4SYN3VqIc3WONksP0GtVV80lTh50b4Kt+o
 yCxQ==
X-Gm-Message-State: AOAM530/FOIINPY7l+/e2yA04FCLiAPLB/PttpHUr3r5tRuHhmlqjjwc
 3bl7jT2FsDhBVPUHpX5aWDAQuXeTQdhVEhHoBRdg+Xmqmvosyemib1nw6uKnOd/CaeHbtMO7yq5
 I0vvSHeV8+8D8jVQv6ZAKcymuVkHz2g==
X-Received: by 2002:adf:ed44:0:b0:203:f01a:8823 with SMTP id
 u4-20020adfed44000000b00203f01a8823mr3532523wro.715.1648109600329; 
 Thu, 24 Mar 2022 01:13:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykb968cvCLnkpRKg9daNsEmZubE3gLy10E3lBlAv85eiKoR4YsMpEUVyx/aU9lxRLfqvVTYg==
X-Received: by 2002:adf:ed44:0:b0:203:f01a:8823 with SMTP id
 u4-20020adfed44000000b00203f01a8823mr3532497wro.715.1648109600033; 
 Thu, 24 Mar 2022 01:13:20 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a1c6a01000000b0038c9f6a3634sm5479485wmc.7.2022.03.24.01.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 01:13:19 -0700 (PDT)
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <09a6557f-b881-081c-abdf-266516f7b0eb@redhat.com>
Date: Thu, 24 Mar 2022 09:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220324003342.GV11336@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 3/24/22 1:33 AM, Jason Gunthorpe wrote:
> On Wed, Mar 23, 2022 at 04:51:25PM -0600, Alex Williamson wrote:
>
>> My overall question here would be whether we can actually achieve a
>> compatibility interface that has sufficient feature transparency that we
>> can dump vfio code in favor of this interface, or will there be enough
>> niche use cases that we need to keep type1 and vfio containers around
>> through a deprecation process?
> Other than SPAPR, I think we can.
>
>> The locked memory differences for one seem like something that
>> libvirt wouldn't want hidden
> I'm first interested to have an understanding how this change becomes
> a real problem in practice that requires libvirt to do something
> different for vfio or iommufd. We can discuss in the other thread
>
> If this is the make or break point then I think we can deal with it
> either by going back to what vfio does now or perhaps some other
> friendly compat approach..
>
>> and we have questions regarding support for vaddr hijacking
> I'm not sure what vaddr hijacking is? Do you mean
> VFIO_DMA_MAP_FLAG_VADDR ? There is a comment that outlines my plan to
> implement it in a functionally compatible way without the deadlock
> problem. I estimate this as a small project.
>
>> and different ideas how to implement dirty page tracking, 
> I don't think this is compatibility. No kernel today triggers qemu to
> use this feature as no kernel supports live migration. No existing
> qemu will trigger this feature with new kernels that support live
> migration v2. Therefore we can adjust qemu's dirty tracking at the
> same time we enable migration v2 in qemu.
>
> With Joao's work we are close to having a solid RFC to come with
> something that can be fully implemented.
>
> Hopefully we can agree to this soon enough that qemu can come with a
> full package of migration v2 support including the dirty tracking
> solution.
>
>> not to mention the missing features that are currently well used,
>> like p2p mappings, coherency tracking, mdev, etc.
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
>
>> Where do we focus attention?  Is symlinking device files our proposal
>> to userspace and is that something achievable, or do we want to use
>> this compatibility interface as a means to test the interface and
>> allow userspace to make use of it for transition, if their use cases
>> allow it, perhaps eventually performing the symlink after deprecation
>> and eventual removal of the vfio container and type1 code?  Thanks,
> symlinking device files is definitely just a suggested way to expedite
> testing.
>
> Things like qemu that are learning to use iommufd-only features should
> learn to directly open iommufd instead of vfio container to activate
> those features.
>
> Looking long down the road I don't think we want to have type 1 and
> iommufd code forever. So, I would like to make an option to compile
> out vfio container support entirely and have that option arrange for
> iommufd to provide the container device node itself.
I am currently working on migrating the QEMU VFIO device onto the new
API because since after our discussions the compat mode cannot be used
anyway to implemented nesting. I hope I will be able to present
something next week.

Thanks

Eric
>
> I think we can get there pretty quickly, or at least I haven't got
> anything that is scaring me alot (beyond SPAPR of course)
>
> For the dpdk/etcs of the world I think we are already there.
>
> Jason
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
