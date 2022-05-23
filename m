Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2954EC433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 06:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5ECB60BE1;
	Mon, 23 May 2022 06:02:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id McsEupkSXp3j; Mon, 23 May 2022 06:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3548360BC7;
	Mon, 23 May 2022 06:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C52AC0032;
	Mon, 23 May 2022 06:02:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01061C002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D45324051E
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:02:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ozlabs-ru.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIF4egDUeiit for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 06:02:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2FC394036A
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:02:30 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id j21so12579669pga.13
 for <iommu@lists.linux-foundation.org>; Sun, 22 May 2022 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=CBEYVwIZQhT+UhPlnJdnuhbpF2UURS4qszw9FdEhw0I=;
 b=t/RdIJIuYwl2VMpFTQoeBSXZB7QArWCAxwwDRPIePsGtxTx5KbZkgebXJt+lW5+M/6
 MS4CrtmdkAVxQdESBF359GGPmshMo5Xvz3dZq+LytGvmLsSEninCPQhJ7ojMjHTScBKM
 8wmBXgXT0xiz1U9RoUYD2WbJoVjWOsQ9N7i4IGSMY1K1SVZbntvFRnPUxi9RX4Pq7ZoZ
 loKaJvxsxJZmOPA0f/vgVQijjzxpqbFgQMUcuHofMyFMAKKae9StsqJtPXyVZorqT+s4
 EZIPhLxEiQ+XtTgaGP6kpCxNw8+iJ2WRQ0P0Ckr4sjrSw9+PAtnHdMapB2x52yaqvrh3
 YPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=CBEYVwIZQhT+UhPlnJdnuhbpF2UURS4qszw9FdEhw0I=;
 b=zuNHXYsYbvgBf7TPyMcJHQxp90il2lZSF64GylQZug/lNmJH+7jFmp8JSf14SAz6mN
 qreqy4/GfDvL7cAAOPgSA/fXEdXxjOO0ojA7kcS8ZgLWVZ2X5ROGHDVopnP1aqcZpzC1
 rePK6sK6nQG1igO9k0vc/5KDy8sKUpPfx6ZPkbpgWz1RJpsJssCkLrmLyjrj5K2imUl2
 MPAeKX81mq+iOTogmaIlYPDcUxlF2/3gqcvBohe2I5Q2KH4CRGo2mNxY1ewWjQK+8yqI
 nQ/sGehL2j7ck09NkvpyuYiOv0W0TcE8HU97gYGgAxHhKxKVRItPFcArd/+BHFsg3DVn
 So5g==
X-Gm-Message-State: AOAM532x8blFrDyKSxmzjJATw7M6NgBZz9AxKgEXG7cDZf6naoWRG/Ft
 HUd7RKqDt8VhgsYo/h7R5wOAGQ==
X-Google-Smtp-Source: ABdhPJyxnzlELYXaqj+Z2nDLyGrKUitiaPAE9+9y6IQ5wsnBouBDi/g5hWmWCRDhmOQhsXXrBHq7cw==
X-Received: by 2002:a65:6d08:0:b0:3c6:8a08:3b9f with SMTP id
 bf8-20020a656d08000000b003c68a083b9fmr18984902pgb.147.1653285750356; 
 Sun, 22 May 2022 23:02:30 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au.
 [110.175.254.242]) by smtp.gmail.com with ESMTPSA id
 i124-20020a62c182000000b005187eb4194esm4069067pfg.118.2022.05.22.23.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 May 2022 23:02:29 -0700 (PDT)
Message-ID: <67692fa1-6539-3ec5-dcfe-c52dfd1e46b8@ozlabs.ru>
Date: Mon, 23 May 2022 16:02:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101
 Thunderbird/100.0
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Content-Language: en-US
To: David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323165125.5efd5976.alex.williamson@redhat.com>
 <20220324003342.GV11336@nvidia.com>
 <20220324160403.42131028.alex.williamson@redhat.com> <YmqqXHsCTxVb2/Oa@yekko>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <YmqqXHsCTxVb2/Oa@yekko>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 4/29/22 00:53, David Gibson wrote:
> On Thu, Mar 24, 2022 at 04:04:03PM -0600, Alex Williamson wrote:
>> On Wed, 23 Mar 2022 21:33:42 -0300
>> Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>>> On Wed, Mar 23, 2022 at 04:51:25PM -0600, Alex Williamson wrote:
>>>
>>>> My overall question here would be whether we can actually achieve a
>>>> compatibility interface that has sufficient feature transparency that we
>>>> can dump vfio code in favor of this interface, or will there be enough
>>>> niche use cases that we need to keep type1 and vfio containers around
>>>> through a deprecation process?
>>>
>>> Other than SPAPR, I think we can.
>>
>> Does this mean #ifdef CONFIG_PPC in vfio core to retain infrastructure
>> for POWER support?
> 
> There are a few different levels to consider for dealing with PPC.
> For a suitable long term interface for ppc hosts and guests dropping
> this is fine: the ppc specific iommu model was basically an
> ill-conceived idea from the beginning, because none of us had
> sufficiently understood what things were general and what things where
> iommu model/hw specific.
> 
> ..mostly.  There are several points of divergence for the ppc iommu
> model.
> 
> 1) Limited IOVA windows.  This one turned out to not really be ppc
> specific, and is (rightly) handlded generically in the new interface.
> No problem here.
> 
> 2) Costly GUPs.  pseries (the most common ppc machine type) always
> expects a (v)IOMMU.  That means that unlike the common x86 model of a
> host with IOMMU, but guests with no-vIOMMU, guest initiated
> maps/unmaps can be a hot path.  Accounting in that path can be
> prohibitive (and on POWER8 in particular it prevented us from
> optimizing that path the way we wanted).  We had two solutions for
> that, in v1 the explicit ENABLE/DISABLE calls, which preaccounted
> based on the IOVA window sizes.  That was improved in the v2 which
> used the concept of preregistration.  IIUC iommufd can achieve the
> same effect as preregistration using IOAS_COPY, so this one isn't
> really a problem either.


I am getting rid of those POWER8-related realmode handlers as POWER9 has 
MMU enabled when hcalls are handled. Costly GUP problem is still there 
though (which base IOAS should solve?).


> 3) "dynamic DMA windows" (DDW).  The IBM IOMMU hardware allows for 2 IOVA
> windows, which aren't contiguous with each other.  The base addresses
> of each of these are fixed, but the size of each window, the pagesize
> (i.e. granularity) of each window and the number of levels in the
> IOMMU pagetable are runtime configurable.  Because it's true in the
> hardware, it's also true of the vIOMMU interface defined by the IBM
> hypervisor (and adpoted by KVM as well).  So, guests can request
> changes in how these windows are handled.  Typical Linux guests will
> use the "low" window (IOVA 0..2GiB) dynamically, and the high window
> (IOVA 1<<60..???) to map all of RAM.  However, as a hypervisor we
> can't count on that; the guest can use them however it wants.


The guest actually does this already. AIX has always been like that, 
Linux is forced to do that for SRIOV VFs as there can be many VFs and 
TCEs (==IOPTEs) are limited resource. The today's pseries IOMMU code 
first tried mapping 1:1 (as it has been for ages) but if there is not 
enough TCEs - it removes the first window (which increases the TCE 
budget), creates a new 64bit window (as big as possible but not 
necessarily enough for 1:1, 64K/2M IOMMU page sizes allowed) and does 
map/unmap as drivers go.


Which means the guest RAM does not need to be all mapped in that base 
IOAS suggested down this thread as that would mean all memory is pinned 
and powervm won't be able to swap it out (yeah, it can do such thing 
now!). Not sure if we really want to support this or stick to a simpler 
design.



> 
> (3) still needs a plan for how to fit it into the /dev/iommufd model.
> This is a secondary reason that in the past I advocated for the user
> requesting specific DMA windows which the kernel would accept or
> refuse, rather than having a query function - it connects easily to
> the DDW model.  With the query-first model we'd need some sort of
> extension here, not really sure what it should look like.
> 
> 
> 
> Then, there's handling existing qemu (or other software) that is using
> the VFIO SPAPR_TCE interfaces.  First, it's not entirely clear if this
> should be a goal or not: as others have noted, working actively to
> port qemu to the new interface at the same time as making a
> comprehensive in-kernel compat layer is arguably redundant work.
> 
> That said, if we did want to handle this in an in-kernel compat layer,
> here's roughly what you'd need for SPAPR_TCE v2:
> 
> - VFIO_IOMMU_SPAPR_TCE_GET_INFO
>      I think this should be fairly straightforward; the information you
>      need should be in the now generic IOVA window stuff and would just
>      need massaging into the expected format.
> - VFIO_IOMMU_SPAPR_REGISTER_MEMORY /
>    VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
>      IIUC, these could be traslated into map/unmap operations onto a
>      second implicit IOAS which represents the preregistered memory
>      areas (to which we'd never connect an actual device).  Along with
>      this VFIO_MAP and VFIO_UNMAP operations would need to check for
>      this case, verify their addresses against the preregistered space
>      and be translated into IOAS_COPY operations from the prereg
>      address space instead of raw IOAS_MAP operations.  Fiddly, but not
>      fundamentally hard, I think.
> 
> For SPAPR_TCE_v1 things are a bit trickier
> 
> - VFIO_IOMMU_ENABLE/VFIO_IOMMU_DISABLE
>      I suspect you could get away with implementing these as no-ops.
>      It wouldn't be strictly correct, but I think software which is
>      using the interface correctly should work this way, though
>      possibly not optimally.  That might be good enough for this ugly
>      old interface.
> 
> And... then there's VFIO_EEH_PE_OP.  It's very hard to know what to do
> with this because the interface was completely broken for most of its
> lifetime.  EEH is a fancy error handling feature of IBM PCI hardware
> somewhat similar in concept, though not interface, to PCIe AER.  I have
> a very strong impression that while this was a much-touted checkbox
> feature for RAS, no-one, ever. actually used it.  As evidenced by the
> fact that there was, I believe over a *decade* in which all the
> interfaces were completely broken by design, and apparently no-one
> noticed.
> 
> So, cynically, you could probably get away with making this a no-op as
> well.  If you wanted to do it properly... well... that would require
> training up yet another person to actually understand this and hoping
> they get it done before they run screaming.  This one gets very ugly
> because the EEH operations have to operate on the hardware (or
> firmware) "Partitionable Endpoints" (PEs) which correspond one to one
> with IOMMU groups, but not necessarily with VFIO containers, but
> there's not really any sensible way to expose that to users.
> 
> You might be able to do this by simply failing this outright if
> there's anything other than exactly one IOMMU group bound to the
> container / IOAS (which I think might be what VFIO itself does now).
> Handling that with a device centric API gets somewhat fiddlier, of
> course.
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
