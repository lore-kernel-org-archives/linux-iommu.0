Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F92377A
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCBtycbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699048058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+aB8ULpCtjf+Gcfe540UtUd+NJKrSGjq+RpmL2JNA8=;
	b=HCBtycbFaL1++lG56qUhQzpRtK38/bhWeDn7cTO/Xw6qanNsxPdwdSvGMJM2KgM59i9hio
	MT81Q/oWYRxjx97u4UUGmpt4SLbWDLK93NnzT4EWGtfysFZfhSA26KCmxjifRc03e07sHf
	AiFTbho7TI743n/7wNMOhTBwF6u51tM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-lUrX-rYLNTGvfOx6pKEkgQ-1; Fri, 03 Nov 2023 17:47:37 -0400
X-MC-Unique: lUrX-rYLNTGvfOx6pKEkgQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc3ad55c75so20177615ad.0
        for <iommu@lists.linux.dev>; Fri, 03 Nov 2023 14:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699048057; x=1699652857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+aB8ULpCtjf+Gcfe540UtUd+NJKrSGjq+RpmL2JNA8=;
        b=KWT3dKJ9vTyytwcnIhrczwoaYu9WUdJD4sH/AFPdZNTBHCGXkN9ad7FqrGtUiAG44z
         zP48IBrgdutGl1F7sRtDJJjEfkaFL8BPIduMcbl+qBeGuqfnV+D5uhZCv2Sabg1xz2fq
         GqC/ot+bx1JxeARfkKqmMQ9eT1Fac+NyUG907Mw+8PhP6BEQEwSEZP8fNdizCI1dL+Xh
         dxr/pUECzDwmWUBfK3k2zkcX3+w/91Ei519aJNpubZhX6PWS6ssHYHtcMlT7P3zw0NrY
         KFqtw49HclozwPyPdV6TFnZJhGQDH3LGCYFKOkS9wL7nJ8Q6XZzsDP5exKIze/Qx4wLK
         XoLg==
X-Gm-Message-State: AOJu0Yzz8FS63TP4i7ULKuymJFq6wL59xnrzIHipQ1azJQCsBIEbB6ET
	5WHXyZwneotqe/mZFksu47OnX6HjJKOgDR7wBEXVjV+dC+4bSwKzcRGy6p5lf6e2YnURL4AYSEC
	e2JrtIFByH3/EGNE=
X-Received: by 2002:a17:902:d28b:b0:1c7:755d:ccc8 with SMTP id t11-20020a170902d28b00b001c7755dccc8mr17083750plc.29.1699048056768;
        Fri, 03 Nov 2023 14:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdAXninLAKiU84+Ewx4UvETdEvykTsgu1OMaAqceXcjYCMbCq9Ef0fn5aeDPHxQVvb9/cevQ==
X-Received: by 2002:a17:902:d28b:b0:1c7:755d:ccc8 with SMTP id t11-20020a170902d28b00b001c7755dccc8mr17083727plc.29.1699048056432;
        Fri, 03 Nov 2023 14:47:36 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902ec8e00b001cc2c7a30f2sm1807591plg.155.2023.11.03.14.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 14:47:35 -0700 (PDT)
Date: Fri, 3 Nov 2023 14:47:35 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 02/17] of: Do not return struct iommu_ops from
 of_iommu_configure()
Message-ID: <2qhocnpfy4lbmfm4erccztrwoec5sjphvktcyvxdb75qbjyozu@aht6gj2zzuhj>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <2-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ld3rrnpix5x5kirfjlk6oafhoikkge4fgvcljhmiljuqge5266@asdcw5cfp53e>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2023 at 02:42:01PM -0700, Jerry Snitselaar wrote:
> On Fri, Nov 03, 2023 at 01:44:47PM -0300, Jason Gunthorpe wrote:
> > Nothing needs this pointer. Return a normal error code with the usual
> > IOMMU semantic that ENODEV means 'there is no IOMMU driver'.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/of_iommu.c | 29 ++++++++++++++++++-----------
> >  drivers/of/device.c      | 22 +++++++++++++++-------
> >  include/linux/of_iommu.h | 13 ++++++-------
> >  3 files changed, 39 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 157b286e36bf3a..e2fa29c16dd758 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -107,20 +107,26 @@ static int of_iommu_configure_device(struct device_node *master_np,
> >  		      of_iommu_configure_dev(master_np, dev);
> >  }
> >  
> > -const struct iommu_ops *of_iommu_configure(struct device *dev,
> > -					   struct device_node *master_np,
> > -					   const u32 *id)
> > +/*
> > + * Returns:
> > + *  0 on success, an iommu was configured
> > + *  -ENODEV if the device does not have any IOMMU
> > + *  -EPROBEDEFER if probing should be tried again
> > + *  -errno fatal errors
> 
> It looks to me like it will only return 0, -ENODEV, or -EPROBEDEFER
> with other -errno getting boiled down to -ENODEV.
> 

Ah, I should've looked at the next patch first. So, never mind on this
and the question about the dev_dbg.


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

