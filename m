Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F223A8
	for <iommu@lists.linux.dev>; Thu, 23 Jun 2022 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656016556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBmUQROEGSBi6KZ4o9E9bBpH1DEN5yNQ4K8Bp+Z/iq4=;
	b=CPzm4RqyO4RL06TxxQKf9e7y7T4S0v1ZjCJwe3FuMIVccdIILiEf4v19uGvtyeV0/5j1xJ
	HVeOUDjgxTz+jFE2JF9KdWosM9+Pv+qZNiF+T4qi5lVqhgGDYG6nqy/ugWzcjzw8aY9Xyl
	wOqFFrpxYWEbyHmjF9pR8q5tKSbPbk8=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-lC-YzqJCNF6CJ5KhRfEGrQ-1; Thu, 23 Jun 2022 16:35:55 -0400
X-MC-Unique: lC-YzqJCNF6CJ5KhRfEGrQ-1
Received: by mail-io1-f71.google.com with SMTP id y22-20020a056602215600b00673b11a9cd5so290939ioy.7
        for <iommu@lists.linux.dev>; Thu, 23 Jun 2022 13:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jBmUQROEGSBi6KZ4o9E9bBpH1DEN5yNQ4K8Bp+Z/iq4=;
        b=tGnfBibPdYidmy7O+rCfWc8IsU1RZ94r2cFV9NID24lPhQVbyGKz//oHKrYmSRF3Bj
         /tg932QVNZymkdTG1eFjVF/ScfQl9SfiEdI4ROXIPJ95NequWNvlC9WoXABCfFaKdHsR
         dAstp6+wEx4LLgRB3nh8wOgkPVOgSSJecVXibU0na+DZOa1D4TD0xygqWUY7yZzfOj13
         vKzLhklwJXn3vhp40+0uAo/3vIaAY9WijjZh9U03eH1UUt/Kfk44O3CwM+VLkY4Zt9lH
         tnYXKBhWE7WugiE0Xqcwmg8AYm4EwnYHx7QmTTBfk6K9ua5/6vOSb0hjd0Vvb0N3Vkc3
         xDVA==
X-Gm-Message-State: AJIora9RYJjK/G4Ar9o9+Ya0+3sp2CfLev4nSfNgIR1Bw5mPdjBgwuRU
	BCATJafc7SpWRKmmAlxZglmLsQ8BeMUSmF6W8wnzk7vs0b9SRmsOU6SdrR2N+qk+DVarSE6xvSb
	QljU+9uVKVDAufNU=
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id s3-20020a02c503000000b00339ec67b0a4mr2600648jam.27.1656016554290;
        Thu, 23 Jun 2022 13:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uY4A4ulPkvl+0HkPHVJxiXM5mroTpWUdfuh0+GS53HXI+mhS1f3l3m2WS35NzqHwDBGAYR9g==
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id s3-20020a02c503000000b00339ec67b0a4mr2600627jam.27.1656016553968;
        Thu, 23 Jun 2022 13:35:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w16-20020a02cf90000000b00339c3906b08sm151280jar.177.2022.06.23.13.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:35:53 -0700 (PDT)
Date: Thu, 23 Jun 2022 14:35:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220623143552.634779e0.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276A79834CCB5954A3025DF8CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
	<20220622161721.469fc9eb.alex.williamson@redhat.com>
	<BN9PR11MB5276A79834CCB5954A3025DF8CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
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
Message-ID: <20220623203552.CiXddh1qXByRlcrn0OtJVWH6PZxnCMkQ_Z0b_OdgL6c@z>

On Thu, 23 Jun 2022 08:46:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, June 23, 2022 6:17 AM
> >   
> > >
> > >  	ret = -EIO;
> > > -	domain->domain = iommu_domain_alloc(bus);
> > > +	domain->domain = iommu_domain_alloc(iommu_api_dev->dev-
> > >bus);  
> > 
> > It makes sense to move away from a bus centric interface to iommu ops
> > and I can see that having a device interface when we have device level
> > address-ability within a group makes sense, but does it make sense to
> > only have that device level interface?  For example, if an iommu_group
> > is going to remain an aspect of the iommu subsystem, shouldn't we be
> > able to allocate a domain and test capabilities based on the group and
> > the iommu driver should have enough embedded information reachable
> > from
> > the struct iommu_group to do those things?  This "perform group level
> > operations based on an arbitrary device in the group" is pretty klunky.
> > Thanks,
> >   
> 
> This sounds a right thing to do.
> 
> btw another alternative which I'm thinking of is whether vfio_group
> can record the bus info when the first device is added to it in
> __vfio_register_dev(). Then we don't need a group interface from
> iommu to test if vfio is the only user having such requirement.

That might be more simple, but it's just another variation on vfio
picking an arbitrary device from a group to satisfy the iommu interface
rather than operating on an iommu subsystem provided object.  Thanks,

Alex

