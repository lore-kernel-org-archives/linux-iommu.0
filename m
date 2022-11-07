Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB82AD527
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667834338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DPVWQ+YraXRChqzr4SQlG/qjPD1QpM0ZmFrgY+kvQEQ=;
	b=gd6w2bMniN8FYHUZ7hlaIMIgidZplfIaZn7BE5XdlsCN1+xA2JNsUkP1TRyhTaZatmdg6F
	jPYJFCXWfNrKunOLiOPadHHSrDVnJklWHgMECaJ1WJ02O79UYXR4xsduqb+SCuajUWwK2E
	0VWJoGTUUNuMxpdo2H+B9qpTHFxRu5A=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-572-PlYUo0HLP4OGfyRb2V0Fow-1; Mon, 07 Nov 2022 10:18:57 -0500
X-MC-Unique: PlYUo0HLP4OGfyRb2V0Fow-1
Received: by mail-il1-f198.google.com with SMTP id h6-20020a92c266000000b00300624bf414so8952687ild.14
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 07:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPVWQ+YraXRChqzr4SQlG/qjPD1QpM0ZmFrgY+kvQEQ=;
        b=lXW08Hn2mZA4lJIKBvhLfwCpOdVx4D4DLPttWjIM+5nyPJkbF1OFaq5c2YlikNhsCa
         zXf8bAijbjy+DxN5ZIcNnKwj/DBYir9FEanc+OvWI2uwqM/V0KaVG6h1uziJ691PW4hr
         QolJdVCFQPL9j6RytzSBI49WmpEOyEM5mANoH564IlwOwu4gR+TbrXlItyt/zEaSVoFt
         Jc8sAToQc5b564FZ5IGw1CTHn9PaYf+tMx+VW6xMM53dSBL07ZialPFYGOiicGdIHVEc
         qWc91mM6Rhab7MxyIeg+t3r7xhJfa10Zo0JF09hoA6jsJGmtVnQome3egHsAht7jfi9S
         VPKg==
X-Gm-Message-State: ACrzQf2x3AMSUBVqArvXVX9T/77f7Lkj0mTvi51Y0oGWM/39/PxPRuTM
	w65KJcEx1oMBaadv/R3rJ6nUfZWTgWggrnwxTR+g6HTGX4XWkhyV47qxGL3QdJX9dHn5IhEFdoV
	ptj6U/u6kVWshLqU=
X-Received: by 2002:a92:d74f:0:b0:300:ad95:35c5 with SMTP id e15-20020a92d74f000000b00300ad9535c5mr25950890ilq.137.1667834336875;
        Mon, 07 Nov 2022 07:18:56 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4lWUzVNR72O39IQE6LeiepbZvM9WXMUgdmYx2bv2/TRXid0tlwA/a3n4EvaTSlM1yrwXs6uQ==
X-Received: by 2002:a92:d74f:0:b0:300:ad95:35c5 with SMTP id e15-20020a92d74f000000b00300ad9535c5mr25950861ilq.137.1667834336637;
        Mon, 07 Nov 2022 07:18:56 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z101-20020a0293ee000000b0037556012c63sm2771396jah.132.2022.11.07.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:18:55 -0800 (PST)
Date: Mon, 7 Nov 2022 08:18:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 dri-devel@lists.freedesktop.org, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Longfang Liu <liulongfang@huawei.com>,
 linux-s390@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Halil Pasic <pasic@linux.ibm.com>,
 iommu@lists.linux.dev, Nicolin Chen <nicolinc@nvidia.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, intel-gfx@lists.freedesktop.org,
 Zhi Wang <zhi.a.wang@intel.com>, Jason Herne <jjherne@linux.ibm.com>, Eric
 Farman <farman@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko
 Carstens <hca@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, Harald
 Freudenberger <freude@linux.ibm.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, intel-gvt-dev@lists.freedesktop.org, Tony Krowiak
 <akrowiak@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Sven Schnelle
 <svens@linux.ibm.com>, Robin Murphy <robin.murphy@arm.com>, Lu Baolu
 <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 04/10] vfio: Move storage of allow_unsafe_interrupts to
 vfio_main.c
Message-ID: <20221107081853.18727337.alex.williamson@redhat.com>
In-Reply-To: <Y2kF75zVD581UeR2@nvidia.com>
References: <0-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<4-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<20221026152442.4855c5de.alex.williamson@redhat.com>
	<Y1wiCc33Jh5QY+1f@nvidia.com>
	<20221031164526.0712e456.alex.williamson@redhat.com>
	<Y2kF75zVD581UeR2@nvidia.com>
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

On Mon, 7 Nov 2022 09:19:43 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Oct 31, 2022 at 04:45:26PM -0600, Alex Williamson wrote:
> 
> > > It is one idea, it depends how literal you want to be on "module
> > > parameters are ABI". IMHO it is a weak form of ABI and the need of
> > > this paramter in particular is not that common in modern times, AFAIK.
> > > 
> > > So perhaps we just also expose it through vfio.ko and expect people to
> > > migrate. That would give a window were both options are available.  
> > 
> > That might be best.  Ultimately this is an opt-out of a feature that
> > has security implications, so I'd rather error on the side of requiring
> > the user to re-assert that opt-out.  It seems the potential good in
> > eliminating stale or unnecessary options outweighs any weak claims of
> > preserving an ABI for a module that's no longer in service.  
> 
> Ok, lets do this
> 
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -55,6 +55,11 @@ static struct vfio {
>  bool vfio_allow_unsafe_interrupts;
>  EXPORT_SYMBOL_GPL(vfio_allow_unsafe_interrupts);
>  
> +module_param_named(allow_unsafe_interrupts,
> +                  vfio_allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(allow_unsafe_interrupts,
> +                "Enable VFIO IOMMU support for on platforms without interrupt remapping support.");
> +
>  static DEFINE_XARRAY(vfio_device_set_xa);
>  static const struct file_operations vfio_group_fops;
> 
> > However, I'd question whether vfio is the right place for that new
> > module option.  As proposed, vfio is only passing it through to
> > iommufd, where an error related to lack of the hardware feature is
> > masked behind an -EPERM by the time it gets back to vfio, making any
> > sort of advisory to the user about the module option convoluted.  It
> > seems like iommufd should own the option to opt-out universally, not
> > just through the vfio use case.  Thanks,  
> 
> My thinking is this option shouldn't exist at all in other iommufd
> users. eg I don't see value in VDPA supporting it.

I disagree, the IOMMU interface is responsible for isolating the
device, this option doesn't make any sense to live in vfio-main, which
is the reason it was always a type1 option.  If vdpa doesn't allow full
device access such that it can guarantee that a device cannot generate
a DMA that can spoof MSI, then it sounds like the flag we pass when
attaching a device to iommfd should to reflect this difference in usage.
The driver either requires full isolation, default, or can indicate a
form of restricted DMA programming that prevents interrupt spoofing.
The policy whether to permit unsafe configurations should exist in one
place, iommufd.  Thanks,

Alex

