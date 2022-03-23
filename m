Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58B7C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 22:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50F3E404B2;
	Wed, 23 Mar 2022 22:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1x45W4hDEb7U; Wed, 23 Mar 2022 22:51:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9AED8400E6;
	Wed, 23 Mar 2022 22:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB6EC0012;
	Wed, 23 Mar 2022 22:51:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 626B8C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58EF241B48
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ok2ahxoie5Z for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 22:51:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8039541B40
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648075889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXrtNBop4eytCkK2KN6cn5OV3XYINsz2pixN2ZjW6Ik=;
 b=bubOzKKHrDSveK3Qnn2pQ831cFYZARexybcO7MF5E8Rjc0Ld26+XX98F3TODytd4dsTrN1
 2uTsovIx1vB05pmjMyU4/MOgnCQ1l3MNwyZiKKkJPqMqidLlT6LEJEYOLGnXpjIis5Kmem
 DHbdstc7SX77/0Cl8gndtmVtNryqjro=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-poOgfPkQNHiHX35NTGIFlg-1; Wed, 23 Mar 2022 18:51:28 -0400
X-MC-Unique: poOgfPkQNHiHX35NTGIFlg-1
Received: by mail-il1-f199.google.com with SMTP id
 g5-20020a92dd85000000b002c79aa519f4so1731008iln.10
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 15:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=zXrtNBop4eytCkK2KN6cn5OV3XYINsz2pixN2ZjW6Ik=;
 b=KlrZJ3YXn/NRNYmWxjllnEznknPyqnS32Ei2TDRtdP9feswKTonYNbhz9+jantByIR
 TGwZfinhXigAB0H92+9h53Um6BUCHBxSEX3Ozcq44V+BdaVYBTBnAjcS1G50jOVGY2UE
 kTIdNWRyJTgNWgDOepdMfyzmIAplPhYDbymDzmcK271ZSGXd/LhITwEq+6Y944YbsZVk
 0T4rh45/2yJhLAOavGL0qYsNee7HxljxyzeYLxgNtloVIh697XJ5goIBt6IuqdSEx4iP
 f6SHAkx0UkBzMPp4YiC3OvIYi+xZ1pA6It/s3SeIo15r0nMUtO0xEE5nBnKd4aU0UoLV
 CJlw==
X-Gm-Message-State: AOAM531dHy/2/2LlwZakDZICdeSaOfzFglPgzbYlF1IGl5e09TmFsmGl
 rGAvx20s4Gh0TemDjGmEbkqMNB9SdLvC4Qvc7afFEAV3Fgf+nTgetMn9APqsIImYUUv9/aQ1/Sh
 rLvQo2PQ/AV2tbxcR0e6oRXhJjPspzw==
X-Received: by 2002:a02:6a60:0:b0:315:4758:1be1 with SMTP id
 m32-20020a026a60000000b0031547581be1mr1206129jaf.316.1648075887555; 
 Wed, 23 Mar 2022 15:51:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaJn0eLN0Gn/0djTc0vdh5GoRl0UtWStWyphWNYG4Z5xTQIQiC8E7G1j0lHiTi9xOjH2m+wQ==
X-Received: by 2002:a02:6a60:0:b0:315:4758:1be1 with SMTP id
 m32-20020a026a60000000b0031547581be1mr1206105jaf.316.1648075887341; 
 Wed, 23 Mar 2022 15:51:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 b11-20020a92c56b000000b002c76a618f52sm697615ilj.63.2022.03.23.15.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 15:51:27 -0700 (PDT)
Date: Wed, 23 Mar 2022 16:51:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 11/12] iommufd: vfio container FD ioctl compatibility
Message-ID: <20220323165125.5efd5976.alex.williamson@redhat.com>
In-Reply-To: <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <11-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
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

On Fri, 18 Mar 2022 14:27:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> iommufd can directly implement the /dev/vfio/vfio container IOCTLs by
> mapping them into io_pagetable operations. Doing so allows the use of
> iommufd by symliking /dev/vfio/vfio to /dev/iommufd. Allowing VFIO to
> SET_CONTAINER using a iommufd instead of a container fd is a followup
> series.
> 
> Internally the compatibility API uses a normal IOAS object that, like
> vfio, is automatically allocated when the first device is
> attached.
> 
> Userspace can also query or set this IOAS object directly using the
> IOMMU_VFIO_IOAS ioctl. This allows mixing and matching new iommufd only
> features while still using the VFIO style map/unmap ioctls.
> 
> While this is enough to operate qemu, it is still a bit of a WIP with a
> few gaps to be resolved:
> 
>  - Only the TYPE1v2 mode is supported where unmap cannot punch holes or
>    split areas. The old mode can be implemented with a new operation to
>    split an iopt_area into two without disturbing the iopt_pages or the
>    domains, then unmapping a whole area as normal.
> 
>  - Resource limits rely on memory cgroups to bound what userspace can do
>    instead of the module parameter dma_entry_limit.
> 
>  - VFIO P2P is not implemented. Avoiding the follow_pfn() mis-design will
>    require some additional work to properly expose PFN lifecycle between
>    VFIO and iommfd
> 
>  - Various components of the mdev API are not completed yet
>
>  - Indefinite suspend of SW access (VFIO_DMA_MAP_FLAG_VADDR) is not
>    implemented.
> 
>  - The 'dirty tracking' is not implemented
> 
>  - A full audit for pedantic compatibility details (eg errnos, etc) has
>    not yet been done
> 
>  - powerpc SPAPR is left out, as it is not connected to the iommu_domain
>    framework. My hope is that SPAPR will be moved into the iommu_domain
>    framework as a special HW specific type and would expect power to
>    support the generic interface through a normal iommu_domain.

My overall question here would be whether we can actually achieve a
compatibility interface that has sufficient feature transparency that we
can dump vfio code in favor of this interface, or will there be enough
niche use cases that we need to keep type1 and vfio containers around
through a deprecation process?

The locked memory differences for one seem like something that libvirt
wouldn't want hidden and we have questions regarding support for vaddr
hijacking and different ideas how to implement dirty page tracking, not
to mention the missing features that are currently well used, like p2p
mappings, coherency tracking, mdev, etc.

It seems like quite an endeavor to fill all these gaps, while at the
same time QEMU will be working to move to use iommufd directly in order
to gain all the new features.

Where do we focus attention?  Is symlinking device files our proposal
to userspace and is that something achievable, or do we want to use
this compatibility interface as a means to test the interface and
allow userspace to make use of it for transition, if their use cases
allow it, perhaps eventually performing the symlink after deprecation
and eventual removal of the vfio container and type1 code?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
