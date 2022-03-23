Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E842C433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 20:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7707416E5;
	Wed, 23 Mar 2022 20:04:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0h2AbYUQBkcF; Wed, 23 Mar 2022 20:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 75C4D416E4;
	Wed, 23 Mar 2022 20:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55502C001A;
	Wed, 23 Mar 2022 20:04:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03736C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:04:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DAC2E4016C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bqfhf2WO0O3k for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 20:04:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD094400C4
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648065890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGz+TFNC14CQU3pjAYcKlEhO5o+YwP5watp7iY8Dy4Y=;
 b=dMXH5cL22UsQirNK5lZPWe151C+vMxa44fmwGiqrO1Sd54GKWpCHqABpw0F+s7bdxBRn42
 0tiH4ClaCV//6o/5eKzKKo9iF4RxVmvicOA/LAOMb8Pq3od6/zPAFnKqLCV7C8bCVWqQpl
 qR8c9mRG0t6d3cjspTFfah7UGY9hkP0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-o18Z_UwDOEe7nBLe1B6sng-1; Wed, 23 Mar 2022 16:04:49 -0400
X-MC-Unique: o18Z_UwDOEe7nBLe1B6sng-1
Received: by mail-io1-f69.google.com with SMTP id
 k20-20020a5e9314000000b00649d55ffa67so1736796iom.20
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 13:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=bGz+TFNC14CQU3pjAYcKlEhO5o+YwP5watp7iY8Dy4Y=;
 b=qcU64RfgaHZfd3Ea3iXQMROWEUTYujL+fibFUUX5y8nXLjhFJbbaJ4XVLCTvKzy282
 +EfrYhETrfqE6OmLSD8jo5wqf46E6l5vqkQjS+PGgvP3PH62Iq3E8FQU9MOFSCzIzO6Y
 MeAQn4KWCaG21P133ObjscKcGLgPVn9IQWCEupsttzuB4GqM383kdGiniexXCGsNMn8A
 SQ/q+XQSHuVEnSh5gSqntpDEkrowNVQDORyT+qU9LQwyyqCanxD6cNbgTFj1wR5RKMlE
 +iYRxFwnafci7DBb3PSF/dP5hA0N1Hk6ZB2JIMcOEySonIdAUQtFOLGkQZjrQ3inhdwn
 9/BQ==
X-Gm-Message-State: AOAM532pQcPiU7AevNEmXj8uE5n1NlUm2u2RATbTBH+MSD/DhMaAJ86o
 4VT7+A/3ed47npJlbO3J+aIEgOH2a0M1yM3X/ScrFcbzt7/ZZJvCQcJSGF2A3Onrs2u/P/Vk55B
 +vYOakLNRalP6MPNz5e1QXhkNci+7bw==
X-Received: by 2002:a05:6638:ec3:b0:321:367c:a325 with SMTP id
 q3-20020a0566380ec300b00321367ca325mr950228jas.156.1648065888422; 
 Wed, 23 Mar 2022 13:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi4Uc0TDUDV75l1oBqwHgylR118BxFgoAIzQq/nFzh0iyGv7+dfItdpVxdNTEbmSJZU9IBnw==
X-Received: by 2002:a05:6638:ec3:b0:321:367c:a325 with SMTP id
 q3-20020a0566380ec300b00321367ca325mr950206jas.156.1648065888213; 
 Wed, 23 Mar 2022 13:04:48 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 j15-20020a056e02154f00b002c7828da4desm458912ilu.0.2022.03.23.13.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 13:04:47 -0700 (PDT)
Date: Wed, 23 Mar 2022 14:04:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 08/12] iommufd: IOCTLs for the io_pagetable
Message-ID: <20220323140446.097fd8cc.alex.williamson@redhat.com>
In-Reply-To: <20220323193439.GS11336@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <8-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <20220323131038.3b5cb95b.alex.williamson@redhat.com>
 <20220323193439.GS11336@nvidia.com>
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

On Wed, 23 Mar 2022 16:34:39 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Mar 23, 2022 at 01:10:38PM -0600, Alex Williamson wrote:
> > On Fri, 18 Mar 2022 14:27:33 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > +static int conv_iommu_prot(u32 map_flags)
> > > +{
> > > +	int iommu_prot;
> > > +
> > > +	/*
> > > +	 * We provide no manual cache coherency ioctls to userspace and most
> > > +	 * architectures make the CPU ops for cache flushing privileged.
> > > +	 * Therefore we require the underlying IOMMU to support CPU coherent
> > > +	 * operation.
> > > +	 */
> > > +	iommu_prot = IOMMU_CACHE;  
> > 
> > Where is this requirement enforced?  AIUI we'd need to test
> > IOMMU_CAP_CACHE_COHERENCY somewhere since functions like
> > intel_iommu_map() simply drop the flag when not supported by HW.  
> 
> You are right, the correct thing to do is to fail device
> binding/attach entirely if IOMMU_CAP_CACHE_COHERENCY is not there,
> however we can't do that because Intel abuses the meaning of
> IOMMU_CAP_CACHE_COHERENCY to mean their special no-snoop behavior is
> supported.
> 
> I want Intel to split out their special no-snoop from IOMMU_CACHE and
> IOMMU_CAP_CACHE_COHERENCY so these things have a consisent meaning in
> all iommu drivers. Once this is done vfio and iommufd should both
> always set IOMMU_CACHE and refuse to work without
> IOMMU_CAP_CACHE_COHERENCY. (unless someone knows of an !IOMMU_CACHE
> arch that does in fact work today with vfio, somehow, but I don't..)

IIRC, the DMAR on Intel CPUs dedicated to IGD was where we'd often see
lack of snoop-control support, causing us to have mixed coherent and
non-coherent domains.  I don't recall if you go back far enough in VT-d
history if the primary IOMMU might have lacked this support.  So I
think there are systems we care about with IOMMUs that can't enforce
DMA coherency.

As it is today, if the IOMMU reports IOMMU_CAP_CACHE_COHERENCY and all
mappings make use of IOMMU_CACHE, then all DMA is coherent.  Are you
suggesting IOMMU_CAP_CACHE_COHERENCY should indicate that all mappings
are coherent regardless of mapping protection flags?  What's the point
of IOMMU_CACHE at that point?

> I added a fixme about this.
> 
> > This also seems like an issue relative to vfio compatibility that I
> > don't see mentioned in that patch.  Thanks,  
> 
> Yes, it was missed in the notes for vfio compat that Intel no-snoop is
> not working currently, I fixed it.

Right, I see it in the comments relative to extensions, but missed in
the commit log.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
