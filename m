Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237C3258B
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657130610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBlFjIiB9ZC4gvoYyy90cQtMpZILwrGOgeqSFzZ8m1s=;
	b=W2+30qm6LRxDKb5EdriLGiSA/CyflO8u+BQB5X3bVkT7OUUc0NKLyx4dZEXaE2apbtdNIw
	O1FO/nhwIRDBfuQRDZsk7xwd/KLqhO1NtlB/x+q0oZRyGl9TEvTydgbxCEbFYeFxSPdtBi
	e96WT8CnIyhXG8KEAZyTp8UttNaqni4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-r25I1lffMUiLZiCIYEAdQg-1; Wed, 06 Jul 2022 14:03:29 -0400
X-MC-Unique: r25I1lffMUiLZiCIYEAdQg-1
Received: by mail-io1-f72.google.com with SMTP id o6-20020a5eda46000000b00674f9e7e8b4so8484596iop.1
        for <iommu@lists.linux.dev>; Wed, 06 Jul 2022 11:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VBlFjIiB9ZC4gvoYyy90cQtMpZILwrGOgeqSFzZ8m1s=;
        b=yDZsux88A9GoDSLyreuu8imWW92zGcXWQozaNX8UU6jhFhAzSAgzf/7t7b9iluSFkG
         oVyM2+AAS65sKdSsc1GIojO9IKffeVrBcXT9YYSFCE/y8y8Z4l7bwRRZvj7zd7+ccpN/
         aHPBzYu+mU+JyO6LWnMx4tSETC01G6QlmDyPkbvsrwqFS8AtI/kIjAr/Ko12LQDPc38F
         Ya6XDRRe40+iLa5E5tdVzKQ4UZ5g88JRNAXfytogItdFGwH6PVnJX1d+lkgUc9Ww0OAd
         nMNwFwdDLogcK1hVVTesuwyxDm1sbGbvAWvNgZdwQM+F6ZlICWMznSZN9aDkwRTT1XBM
         gVRw==
X-Gm-Message-State: AJIora/GFJ8TJtaf35WFnXhep2jpLTyQ+lU5A1BKV81ieolGFJq2+cAU
	FCZWa9q+6F/Tow85qI2XVTA3ofJGWCE5WbK4WKQjoyRgSmUKbMkIKeQ94s4BJhphd5LMR70K2C6
	dsJqYPWJQ7SFfAVc=
X-Received: by 2002:a05:6638:218f:b0:33c:caf0:a61c with SMTP id s15-20020a056638218f00b0033ccaf0a61cmr26531515jaj.198.1657130608192;
        Wed, 06 Jul 2022 11:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tABH1Ic8RqUAALPXzLJn+RofmhnwMLRPJ18ZPWLjNFSi2aNVbpdWUQPpp6mJB+LAKijjE03g==
X-Received: by 2002:a05:6638:218f:b0:33c:caf0:a61c with SMTP id s15-20020a056638218f00b0033ccaf0a61cmr26531473jaj.198.1657130607865;
        Wed, 06 Jul 2022 11:03:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id co14-20020a0566383e0e00b0033efe711a37sm1538401jab.35.2022.07.06.11.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:03:27 -0700 (PDT)
Date: Wed, 6 Jul 2022 12:03:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <joro@8bytes.org>, <will@kernel.org>, <marcan@marcan.st>,
 <sven@svenpeter.dev>, <robin.murphy@arm.com>, <robdclark@gmail.com>,
 <baolu.lu@linux.intel.com>, <orsonzhai@gmail.com>,
 <baolin.wang7@gmail.com>, <zhang.lyra@gmail.com>,
 <jean-philippe@linaro.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
 <suravee.suthikulpanit@amd.com>, <alyssa@rosenzweig.io>,
 <dwmw2@infradead.org>, <mjrosato@linux.ibm.com>,
 <gerald.schaefer@linux.ibm.com>, <thierry.reding@gmail.com>,
 <vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <cohuck@redhat.com>,
 <thunder.leizhen@huawei.com>, <christophe.jaillet@wanadoo.fr>,
 <chenxiang66@hisilicon.com>, <john.garry@huawei.com>,
 <yangyingliang@huawei.com>, <iommu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <kvm@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] cover-letter: Simplify vfio_iommu_type1
 attach/detach routine
Message-ID: <20220706120325.4741ff34.alex.williamson@redhat.com>
In-Reply-To: <YsXMMCX5LY/3IOtf@Asurada-Nvidia>
References: <20220701214455.14992-1-nicolinc@nvidia.com>
	<20220706114217.105f4f61.alex.williamson@redhat.com>
	<YsXMMCX5LY/3IOtf@Asurada-Nvidia>
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

On Wed, 6 Jul 2022 10:53:52 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Wed, Jul 06, 2022 at 11:42:17AM -0600, Alex Williamson wrote:
> 
> > On Fri, 1 Jul 2022 14:44:50 -0700
> > Nicolin Chen <nicolinc@nvidia.com> wrote:
> >   
> > > This is a preparatory series for IOMMUFD v2 patches. It enforces error
> > > code -EMEDIUMTYPE in iommu_attach_device() and iommu_attach_group() when
> > > an IOMMU domain and a device/group are incompatible. It also drops the
> > > useless domain->ops check since it won't fail in current environment.
> > >
> > > These allow VFIO iommu code to simplify its group attachment routine, by
> > > avoiding the extra IOMMU domain allocations and attach/detach sequences
> > > of the old code.
> > >
> > > Worths mentioning the exact match for enforce_cache_coherency is removed
> > > with this series, since there's very less value in doing that as KVM will
> > > not be able to take advantage of it -- this just wastes domain memory.
> > > Instead, we rely on Intel IOMMU driver taking care of that internally.
> > >
> > > This is on github:
> > > https://github.com/nicolinc/iommufd/commits/vfio_iommu_attach  
> > 
> > How do you foresee this going in, I'm imagining Joerg would merge the
> > first patch via the IOMMU tree and provide a topic branch that I'd
> > merge into the vfio tree along with the remaining patches.  Sound
> > right?  Thanks,  
> 
> We don't have any build dependency between the IOMMU change and
> VFIO changes, yet, without the IOMMU one, any iommu_attach_group()
> failure now would be a hard failure without a chance falling back
> to a new_domain, which is slightly different from the current flow.
> 
> For a potential existing use case that relies on reusing existing
> domain, I think it'd be safer to have Joerg acking the first change
> so you merge them all? Thank!

Works for me, I'll look for buy-in + ack from Joerg.  Thanks,

Alex

