Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BF4C43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 14:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E8D48489C;
	Fri, 24 Jun 2022 14:28:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6E8D48489C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chHNKsX4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qSnsU883qUvg; Fri, 24 Jun 2022 14:28:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 17113848B1;
	Fri, 24 Jun 2022 14:28:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17113848B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8EDCC0039;
	Fri, 24 Jun 2022 14:28:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6FE5C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 870A8848B1
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:28:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 870A8848B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4QLUgrTvSYRw for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 14:28:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C21CD8489C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C21CD8489C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656080915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4JvKqCiOdKw+A9E4Z2S6cfj22fiQzAHjq7B7dp14dQ=;
 b=chHNKsX4l/r256r6McYA601XCObk48MqS4mb0o4IAJE02XJCQ6l9tjhUAZTFyrDKqMUE71
 GVUayCAQbZGHPjBcX+I/Ybc9TtBka8G1MsqCKZ2dfJ3vBAg3yc32B5pgohI73ml15n6nUn
 q6/GPy9rRzneAOCQ5s3JYfXgRLlNnLI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-SAyIkS79NWGJhkFhCFuS7g-1; Fri, 24 Jun 2022 10:28:34 -0400
X-MC-Unique: SAyIkS79NWGJhkFhCFuS7g-1
Received: by mail-il1-f200.google.com with SMTP id
 s6-20020a056e021a0600b002d8fcba296aso1487803ild.20
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 07:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=p4JvKqCiOdKw+A9E4Z2S6cfj22fiQzAHjq7B7dp14dQ=;
 b=2SrFZ6555Jwdub22Z8igsaP66pg3ffQbzoXDJrPAQis0/DkPzFk/zFUpbHJo4DNmKS
 lhGzMgvYys7BgH0rRddaPDM8MUsUljK4KJDYUVkR5fDh4+s9ajhgopKZoolSG76xLAko
 Mw5Nvw1ZsROj4lv8A88ci3xx4sBlGeIpWgRjluiZPLaNX3er1hAln+7yjDmWEe79x9An
 wB+sYu1D0pmmbjh6Lb3IZp6yu7SF6YeXnj05L105HRb35aq5z3AOxt1hkYHaSV4/cnOo
 Ntqax1JH2QfcdJE5Y0REPbOjiGM8ioIiBjzU80xhkCAII/Rl6jhJ7CUKfV0vQwpoNGHA
 EFIg==
X-Gm-Message-State: AJIora+1nlepH9qdFsExfoYe7GQ9M/T3mZFh6o117LEM4haQZCkLwVAh
 l6Py07benhfqfEzubQX/UszBCsEYZrTj3uDJ+hdsqQs6cfY1lYhUOWtigUzVUzTPTmARGWxX0FY
 mXFnzyM/PHI/JAxgAfIb+jGQXGhUvig==
X-Received: by 2002:a6b:4e14:0:b0:674:f787:ccc9 with SMTP id
 c20-20020a6b4e14000000b00674f787ccc9mr3406925iob.55.1656080913725; 
 Fri, 24 Jun 2022 07:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAYENMFVMTMR+qSukJBYoPPYDA1IawKk6u6vxfGS5ZaF7SIgNQl/j1f+D7x5oOoyI0hy3bnw==
X-Received: by 2002:a6b:4e14:0:b0:674:f787:ccc9 with SMTP id
 c20-20020a6b4e14000000b00674f787ccc9mr3406911iob.55.1656080913442; 
 Fri, 24 Jun 2022 07:28:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 l5-20020a02cce5000000b003314d7b59b0sm1125426jaq.88.2022.06.24.07.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jun 2022 07:28:32 -0700 (PDT)
Date: Fri, 24 Jun 2022 08:28:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220624082831.22de3d51.alex.williamson@redhat.com>
In-Reply-To: <20220624141836.GS4147@nvidia.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <20220622161721.469fc9eb.alex.williamson@redhat.com>
 <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
 <20220623170044.1757267d.alex.williamson@redhat.com>
 <20220624015030.GJ4147@nvidia.com>
 <20220624081159.508baed3.alex.williamson@redhat.com>
 <20220624141836.GS4147@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, 24 Jun 2022 11:18:36 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jun 24, 2022 at 08:11:59AM -0600, Alex Williamson wrote:
> > On Thu, 23 Jun 2022 22:50:30 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Thu, Jun 23, 2022 at 05:00:44PM -0600, Alex Williamson wrote:
> > >   
> > > > > >> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group)
> > > > > >> +{
> > > > > >> +	struct vfio_group *group = vfio_group_get_from_iommu(iommu_group);
> > > > > >> +	struct vfio_device *device;      
> > > > > > 
> > > > > > Check group for NULL.      
> > > > > 
> > > > > OK - FWIW in context this should only ever make sense to call with an 
> > > > > iommu_group which has already been derived from a vfio_group, and I did 
> > > > > initially consider a check with a WARN_ON(), but then decided that the 
> > > > > unguarded dereference would be a sufficiently strong message. No problem 
> > > > > with bringing that back to make it more defensive if that's what you prefer.    
> > > > 
> > > > A while down the road, that's a bit too much implicit knowledge of the
> > > > intent and single purpose of this function just to simply avoid a test.    
> > > 
> > > I think we should just pass the 'struct vfio_group *' into the
> > > attach_group op and have this API take that type in and forget the
> > > vfio_group_get_from_iommu().  
> > 
> > That's essentially what I'm suggesting, the vfio_group is passed as an
> > opaque pointer which type1 can use for a
> > vfio_group_for_each_vfio_device() type call.  Thanks,  
> 
> I don't want to add a whole vfio_group_for_each_vfio_device()
> machinery that isn't actually needed by anything.. This is all
> internal, we don't need to design more than exactly what is needed.
> 
> At this point if we change the signature of the attach then we may as
> well just pass in the representative vfio_device, that is probably
> less LOC overall.

That means that vfio core still needs to pick an arbitrary
representative device, which I find in fundamental conflict to the
nature of groups.  Type1 is the interface to the IOMMU API, if through
the IOMMU API we can make an assumption that all devices within the
group are equivalent for a given operation, that should be done in type1
code, not in vfio core.  A for-each interface is commonplace and not
significantly more code or design than already proposed.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
