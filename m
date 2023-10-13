Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC1262B0
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmOg+8G/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697233901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhJ8SRDAsdQr3G0YpWQQAfHmnlmxFLHLMdnMLzMYnow=;
	b=AmOg+8G/NxmxHLCvdIxQwQuwWBRi/57mpV7Lcf/yblOkD0jb5TBfYP312py3awK7ybpXAJ
	vfAtUv06ZQCob/aS35QhtQkPDGH+vcwA9auSW2I2BdsHcJVPliZgWgaEOeG0xGgyM9IzcH
	MBelXNmBdQRkYw7a4CW/T20+7nnzZX4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-YfJzLN6ENCWzR9LJvMImTw-1; Fri, 13 Oct 2023 17:51:37 -0400
X-MC-Unique: YfJzLN6ENCWzR9LJvMImTw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7a2cc9ee5d0so176886039f.2
        for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 14:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697233897; x=1697838697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhJ8SRDAsdQr3G0YpWQQAfHmnlmxFLHLMdnMLzMYnow=;
        b=t/vJDSQqN3iMofT5hKRhC5wTZX7ry36vGBZlUppKep8IqCU808SebMhOOJ4onMIfD7
         tymAop3aX/qduLee4IEVP6Te+OEYGl0AwcJxClqT9nffKpa3zDsDkA3Gc0hIPB9RmgJl
         GK4iHSstsaqRV5Fxtw3c/V1/vL1CzRhcxVM2gM7btyp5o19d74dHktIWogQEvPtkO9uz
         W6poJMBzdIGoGKJgnTUXPsefUN1yjzSt25dT7XwYmIThs9ZgeXwlQM3hdmcFvR5shYCi
         DummzJ2+jrrm38jmlbacN6KsVNFQS3axEiD9qnweMRhKPmQb+7rihwuQvxQVJNC+j8mR
         ZwIQ==
X-Gm-Message-State: AOJu0YxH9dSiLAV05VgLVKtr31XuYMXccIiAD25pj9l7udZS7Z2ajbch
	54j/jxxE3Vo3s+NBMYWEKG9j33B9PggaZp2Nm8GqeKx9b3/377qwkB0Ja+Bdb1ElDgZQrVtDjiv
	lOPB9/x/3kLOQhqY=
X-Received: by 2002:a6b:ec17:0:b0:791:7e14:4347 with SMTP id c23-20020a6bec17000000b007917e144347mr31488014ioh.13.1697233897229;
        Fri, 13 Oct 2023 14:51:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgJfnAc1pGwIl+LmG0Sg1nTwLSfHLN45ZG0Fc/3K8qEvLlUR3bLmHHistY/nTAfvcNsdo+uw==
X-Received: by 2002:a6b:ec17:0:b0:791:7e14:4347 with SMTP id c23-20020a6bec17000000b007917e144347mr31488003ioh.13.1697233896987;
        Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id f26-20020a056602039a00b0078335414ddesm5036209iov.26.2023.10.13.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:51:36 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:51:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, Kevin Tian
 <kevin.tian@intel.com>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Yi Liu <yi.l.liu@intel.com>, Yi Y Sun
 <yi.y.sun@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v3 02/19] vfio: Move iova_bitmap into iommu core
Message-ID: <20231013155134.6180386e.alex.williamson@redhat.com>
In-Reply-To: <57e8b3ed-4831-40ff-a938-ee266da629c2@oracle.com>
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
	<20230923012511.10379-3-joao.m.martins@oracle.com>
	<20231013154821.GX3952@nvidia.com>
	<8a70e930-b0ef-4495-9c02-8235bf025f05@oracle.com>
	<11453aad-5263-4cd2-ac03-97d85b06b68d@oracle.com>
	<20231013171628.GI3952@nvidia.com>
	<77579409-c318-4bba-8503-637f4653c220@oracle.com>
	<20231013144116.32c2c101.alex.williamson@redhat.com>
	<57e8b3ed-4831-40ff-a938-ee266da629c2@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Oct 2023 22:20:31 +0100
Joao Martins <joao.m.martins@oracle.com> wrote:

> On 13/10/2023 21:41, Alex Williamson wrote:
> > On Fri, 13 Oct 2023 18:23:09 +0100
> > Joao Martins <joao.m.martins@oracle.com> wrote:
> >   
> >> On 13/10/2023 18:16, Jason Gunthorpe wrote:  
> >>> On Fri, Oct 13, 2023 at 06:10:04PM +0100, Joao Martins wrote:    
> >>>> On 13/10/2023 17:00, Joao Martins wrote:    
> >>>>> On 13/10/2023 16:48, Jason Gunthorpe wrote:    
> >>>> But if it's exists an IOMMUFD_DRIVER kconfig, then VFIO_CONTAINER can instead
> >>>> select the IOMMUFD_DRIVER alone so long as CONFIG_IOMMUFD isn't required? I am
> >>>> essentially talking about:    
> >>>
> >>> Not VFIO_CONTAINER, the dirty tracking code is in vfio_main:
> >>>
> >>> vfio_main.c:#include <linux/iova_bitmap.h>
> >>> vfio_main.c:static int vfio_device_log_read_and_clear(struct iova_bitmap *iter,
> >>> vfio_main.c:    struct iova_bitmap *iter;
> >>> vfio_main.c:    iter = iova_bitmap_alloc(report.iova, report.length,
> >>> vfio_main.c:    ret = iova_bitmap_for_each(iter, device,
> >>> vfio_main.c:    iova_bitmap_free(iter);
> >>>
> >>> And in various vfio device drivers.
> >>>
> >>> So the various drivers can select IOMMUFD_DRIVER
> >>>     
> >>
> >> It isn't so much that type1 requires IOMMUFD, but more that it is used together
> >> with the core code that allows the vfio drivers to do migration. So the concern
> >> is if we make VFIO core depend on IOMMU that we prevent
> >> VFIO_CONTAINER/VFIO_GROUP to not be selected. My kconfig read was that we either
> >> select VFIO_GROUP or VFIO_DEVICE_CDEV but not both  
> > 
> > That's not true.  We can have both.  In fact we rely on having both to
> > support a smooth transition to the cdev interface.  Thanks,  
> 
> On a triple look, mixed defaults[0] vs manual config: having IOMMUFD=y|m today
> it won't select VFIO_CONTAINER, nobody stops one from actually selecting it
> both. Unless I missed something

Oh!  I misunderstood your comment, you're referring to default
selections rather than possible selections.  So yes, if VFIO depends on
IOMMUFD then suddenly our default configs shift to IOMMUFD/CDEV rather
than legacy CONTAINER/GROUP.  So perhaps if VFIO selects IOMMUFD, that's
not exactly harmless currently.

I think Jason is describing this would eventually be in a built-in
portion of IOMMUFD, but I think currently that built-in portion is
IOMMU.  So until we have this IOMMUFD_DRIVER that enables that built-in
portion, it seems unnecessarily disruptive to make VFIO select IOMMUFD
to get this iova bitmap support.  Thanks,

Alex

> [0] Ref:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/vfio/Kconfig
> 
> menuconfig VFIO
> 	[...]
> 	select VFIO_GROUP if SPAPR_TCE_IOMMU || IOMMUFD=n
> 	select VFIO_DEVICE_CDEV if !VFIO_GROUP
> 	select VFIO_CONTAINER if IOMMUFD=n
> 	[...]
> 
> if VFIO
> config VFIO_DEVICE_CDEV
> 	[...]
> 	depends on IOMMUFD && !SPAPR_TCE_IOMMU
> 	default !VFIO_GROUP
> [...]
> config VFIO_GROUP
> 	default y
> [...]
> config VFIO_CONTAINER
> 	[...]
> 	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
> 	depends on VFIO_GROUP
> 	default y
> 

