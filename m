Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCF28EB
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 14:28:36 +0000 (UTC)
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
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-nSoHO21BMme7M7x_qOQ5cw-1; Fri, 24 Jun 2022 10:28:34 -0400
X-MC-Unique: nSoHO21BMme7M7x_qOQ5cw-1
Received: by mail-il1-f198.google.com with SMTP id b11-20020a92340b000000b002d3dbbc7b15so1509435ila.5
        for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 07:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=p4JvKqCiOdKw+A9E4Z2S6cfj22fiQzAHjq7B7dp14dQ=;
        b=DQ6tqp37BG/UJjOKiJHrQ83cTUaTCEq5+A06C+rAHUkWklAP5FHdDsfchT6zzOOmxa
         jIItliZJew7VjyrdJW/Rgzz9wJNdNHSBdK9gP5ckNBXju2P4maeSaiot4BAtfuKzHrmt
         KbXU1X4f4wnlHELLfdlS7SExK3h3aisGvS8bHRAvGaeH1NFw+I00l3+DNyWKgHqZIMg1
         LEf9oDczP0qk16rt3h/YM1LmkeSwzeT365s6OtVtGAQEb8CjcxPRCSoMfN0yfJgJGhZn
         PUd7/QC629ijKBX2L/idoFDJkD8/MJgiuhE6XudEUbrGpGYLpP6glApvOliK/qvUW4KS
         KSBQ==
X-Gm-Message-State: AJIora9+yaLZj2QSgG9f+oZebHOccQ/Js9kqV0XFob+e7STwdo15fAni
	KgBAZFDGT8qWB96R4xNPcj4nsGW/5tnohpAaifQa72TYfQwLwrEJmSu9Nnbji38G3RgYEdHAwwo
	Ol0yLEum94csBH6w=
X-Received: by 2002:a6b:4e14:0:b0:674:f787:ccc9 with SMTP id c20-20020a6b4e14000000b00674f787ccc9mr3406922iob.55.1656080913725;
        Fri, 24 Jun 2022 07:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAYENMFVMTMR+qSukJBYoPPYDA1IawKk6u6vxfGS5ZaF7SIgNQl/j1f+D7x5oOoyI0hy3bnw==
X-Received: by 2002:a6b:4e14:0:b0:674:f787:ccc9 with SMTP id c20-20020a6b4e14000000b00674f787ccc9mr3406911iob.55.1656080913442;
        Fri, 24 Jun 2022 07:28:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id l5-20020a02cce5000000b003314d7b59b0sm1125426jaq.88.2022.06.24.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 07:28:32 -0700 (PDT)
Date: Fri, 24 Jun 2022 08:28:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, cohuck@redhat.com,
 iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20220624142831.LBEija5MHWEtQbX5QrTsV5IlmsIJM4J-busXJHgHfNE@z>

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

