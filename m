Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4400443B
	for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667256331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcWeOKGAq8wttzU4CxXOEF2dDnjMMLoZymWv1KKckJE=;
	b=X9XHBielS8ISbbbdT95tzpmYmVdBVNjNiDHwNWcTaIF4A38wBSg7V3JlyIXW85ZjzbuirV
	BtUrJNElbANRWW6kOmrWmR8tBtdUlA5Yyv3UpFNzbl0bn9BaqwMa15hVbyZK5qws2j5A+9
	prgy8WCe47Ru7B6A3LTiMJDOskV2L4M=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-ZLv1NzfUPJiZ9bXcTsRX4Q-1; Mon, 31 Oct 2022 18:45:30 -0400
X-MC-Unique: ZLv1NzfUPJiZ9bXcTsRX4Q-1
Received: by mail-io1-f69.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso9229127ioo.22
        for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 15:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcWeOKGAq8wttzU4CxXOEF2dDnjMMLoZymWv1KKckJE=;
        b=lyPUjAtHeqA628oLiC3joXxsP6XImYiIfQKrc2UMenqe3NGh0YEn8cl5ntUU1AuFHb
         ACOubcOZjBQ6TutBfYw85JJKRlSytkxyp9KWE9qIzJvA9DknQJBsyt2i50c/IDRswu2t
         EfdwYEq6TTL+9Cix0xSS6IyBcPKrobwQfLgtAWQB6eNtVtQVlAhEf+UUZZXo/SP7pdRt
         WbojGMEOB2AVznjzQse3FRGrVGNsK5F72FPyWdLSKHneCINsAhpJn86GGyV84K3O4dlz
         GclXTXj+J6JJJjEo10CscpQey3UOsmPafHPPT+5hlJocJO0BTpoauzlt9gEjeXDk5Anu
         ejrQ==
X-Gm-Message-State: ACrzQf1NojpHtN2zGivVfwD6+Wrp8lhntVswpV3C2gpSM3kLEs7nQe7L
	HDz+YTlcQVpDKDKTIJ1ugNTCuV2Kt4eRjIOf7B+1W61xrxYXaUVN8bklngeBz2YwTgzJfk4XMgg
	rquSbVg7WrUZhNRk=
X-Received: by 2002:a6b:ba41:0:b0:6bd:1970:16ac with SMTP id k62-20020a6bba41000000b006bd197016acmr8720510iof.15.1667256329601;
        Mon, 31 Oct 2022 15:45:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4VfhsMAuyXCH5HPHtMnIJqQGlZT/T/OmjKoluwi54wXJ63m+zcNwWVSXkyLmiQm1Q3/6FVkw==
X-Received: by 2002:a6b:ba41:0:b0:6bd:1970:16ac with SMTP id k62-20020a6bba41000000b006bd197016acmr8720475iof.15.1667256329251;
        Mon, 31 Oct 2022 15:45:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t20-20020a02b194000000b003738c0a80b4sm3202099jah.144.2022.10.31.15.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:45:28 -0700 (PDT)
Date: Mon, 31 Oct 2022 16:45:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, David Airlie
 <airlied@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Diana Craciun <diana.craciun@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 iommu@lists.linux.dev, Jani Nikula <jani.nikula@linux.intel.com>, Jason
 Herne <jjherne@linux.ibm.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Kevin
 Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, Peter Oberparleiter
 <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Robin Murphy
 <robin.murphy@arm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Sven Schnelle
 <svens@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Zhi Wang <zhi.a.wang@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 04/10] vfio: Move storage of allow_unsafe_interrupts to
 vfio_main.c
Message-ID: <20221031164526.0712e456.alex.williamson@redhat.com>
In-Reply-To: <Y1wiCc33Jh5QY+1f@nvidia.com>
References: <0-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<4-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<20221026152442.4855c5de.alex.williamson@redhat.com>
	<Y1wiCc33Jh5QY+1f@nvidia.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

On Fri, 28 Oct 2022 15:40:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Oct 26, 2022 at 03:24:42PM -0600, Alex Williamson wrote:
> > On Tue, 25 Oct 2022 15:17:10 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > This legacy module knob has become uAPI, when set on the vfio_iommu_type1
> > > it disables some security protections in the iommu drivers. Move the
> > > storage for this knob to vfio_main.c so that iommufd can access it too.  
> > 
> > I don't really understand this, we're changing the behavior of the
> > iommufd_device_attach() operation based on the modules options of
> > vfio_iommu_type1,   
> 
> The specific reason it was done is that we had a misconfigured test VM
> in the farm that needed it, and that VM has since been fixed. But it
> did highlight we should try to preserve this in some way.
> 
> > which may not be loaded or even compiled into the
> > kernel.  Our compatibility story falls apart when VFIO_CONTAINER is not
> > set, iommufd sneaks in to usurp /dev/vfio/vfio, and the user's module
> > options for type1 go unprocessed.  
> 
> There are two aspects here, trying to preseve the
> allow_unsafe_interrupts knob as it is already as some ABI in the best
> way we can.
> 
> And the second is how do we make this work in the new world where
> there may be no type 1 module at all. This patch is not trying to
> address that topic. I am expecting a range of small adjustments before
> VFIO_CONTAINER=n becomes really fully viable.
> 
> > I hate to suggest that type1 becomes a module that does nothing more
> > than maintain consistency of this variable when the full type1 isn't
> > available, but is that what we need to do?  
> 
> It is one idea, it depends how literal you want to be on "module
> parameters are ABI". IMHO it is a weak form of ABI and the need of
> this paramter in particular is not that common in modern times, AFAIK.
> 
> So perhaps we just also expose it through vfio.ko and expect people to
> migrate. That would give a window were both options are available.

That might be best.  Ultimately this is an opt-out of a feature that
has security implications, so I'd rather error on the side of requiring
the user to re-assert that opt-out.  It seems the potential good in
eliminating stale or unnecessary options outweighs any weak claims of
preserving an ABI for a module that's no longer in service.

However, I'd question whether vfio is the right place for that new
module option.  As proposed, vfio is only passing it through to
iommufd, where an error related to lack of the hardware feature is
masked behind an -EPERM by the time it gets back to vfio, making any
sort of advisory to the user about the module option convoluted.  It
seems like iommufd should own the option to opt-out universally, not
just through the vfio use case.  Thanks,

Alex

