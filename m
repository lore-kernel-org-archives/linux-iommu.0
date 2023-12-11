Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7665102A
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7Z3ttmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702320593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB9mhIvJlXIIux4LJMz0ThVUKKa3x07C77ea6R/b5W4=;
	b=N7Z3ttmc3Haztv+kvvuk4O5JH1fVdXtWpP02gotgfkvc8eBT5wyGUZJOr+6pJzJBPOtAh6
	93cUlmeMR8JAnHN92eFjOObxgYClGDveX7vLVfdOGbGTNi6cBjZNhM1tXrg/uJ+mc6XdEI
	qhVjgZsL0/X5EzrWoKO0LjJw6BlA6oY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-uV_OK8h4MPO6SObQG7ww3Q-1; Mon, 11 Dec 2023 13:49:52 -0500
X-MC-Unique: uV_OK8h4MPO6SObQG7ww3Q-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b6e98365f9so524034839f.3
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 10:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702320592; x=1702925392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XB9mhIvJlXIIux4LJMz0ThVUKKa3x07C77ea6R/b5W4=;
        b=cMddJvnPZQn22CkXS3aSEhqHDD90k8GhCAASunCwDumssfPmUsV8sGlJizTCcSCNDt
         MPVN0HOjM5jMKsr0rh2Sn3WAm/6aIuGAhIvdLBVinPn7UNYZIUL+Sxb/+BBQdPw5jcqp
         x9H8dTo02xsqDIJDqLhnGkPOz4AEaZo/dfLisnyT3QFbzApJA6IyBN48aawUYqwQx0uB
         1fYjIFzKvb9KNlpEWHdywNzL+/uFQiIoCRmRrpbeepgayPXntUWNBpatFUPB6r9eF2dz
         SEQ9XMCBXJUc8pLL79WNBWPM5nM+xyw4U8NTxUvBcp+DeykYdo+Tnr29ytL7+3zuUt1a
         o0Ng==
X-Gm-Message-State: AOJu0YxlP5baCGtda5C3gzvzVJCWoZYaIvBJPfGY9v8YMAxhv0yQBpxM
	p/sq1h18euRMlN/hbwjIchr5WXku3zoOzqYINQXmuOWFCejBx5JM1W6AXbHKnZ8YaHI486EFTRV
	lfcG3IpRbL1HBPPs=
X-Received: by 2002:a05:6602:5c4:b0:7b7:cd9:69e4 with SMTP id w4-20020a05660205c400b007b70cd969e4mr5869251iox.17.1702320591922;
        Mon, 11 Dec 2023 10:49:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9BStqyJrk+wPBnz2NVGzUjSM91G8zGRKaMo7y/fs+I/Qqz3zD2APq+aikOivF1KWpRzNeLg==
X-Received: by 2002:a05:6602:5c4:b0:7b7:cd9:69e4 with SMTP id w4-20020a05660205c400b007b70cd969e4mr5869225iox.17.1702320591628;
        Mon, 11 Dec 2023 10:49:51 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id k18-20020a056638371200b0046921815eb5sm2056817jav.62.2023.12.11.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:49:51 -0800 (PST)
Date: Mon, 11 Dec 2023 11:49:49 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231211114949.273b21c0.alex.williamson@redhat.com>
In-Reply-To: <20231211181028.GL2944114@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
	<20231127063909.129153-4-yi.l.liu@intel.com>
	<20231211110345.1b4526c6.alex.williamson@redhat.com>
	<20231211181028.GL2944114@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
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

On Mon, 11 Dec 2023 14:10:28 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Dec 11, 2023 at 11:03:45AM -0700, Alex Williamson wrote:
> > On Sun, 26 Nov 2023 22:39:09 -0800
> > Yi Liu <yi.l.liu@intel.com> wrote:

> > >    the PF). Creating a virtual PASID capability in vfio-pci config space needs
> > >    to find a hole to place it, but doing so may require device specific
> > >    knowledge to avoid potential conflict with device specific registers like
> > >    hiden bits in VF config space. It's simpler by moving this burden to the
> > >    VMM instead of maintaining a quirk system in the kernel.  
> > 
> > This feels a bit like an incomplete solution though and we might
> > already posses device specific knowledge in the form of a variant
> > driver.  Should this feature structure include a flag + field that
> > could serve to generically indicate to the VMM a location for
> > implementing the PASID capability?  The default core implementation
> > might fill this only for PFs where clearly an emualted PASID capability
> > can overlap the physical capability.  Thanks,  
> 
> In many ways I would perfer to solve this for good by having a way to
> learn a range of available config space - I liked the suggestion to
> use a DVSEC to mark empty space.

Yes, DVSEC is the most plausible option for the device itself to convey
unused config space, but that requires hardware adoption so presumably
we're going to need to fill the gaps with device specific code.  That
code might live in a variant driver or in the VMM.  If we have faith
that DVSEC is the way, it'd make sense for a variant driver to
implement a virtual DVSEC to work out the QEMU implementation and set a
precedent.

I mostly just want us to recognize that this feature structure also has
the possibility to fill this gap and we're consciously passing it over
and should maybe formally propose the DVSEC solution and reference it
in the commit log or comments here to provide a complete picture.
Thanks,

Alex

