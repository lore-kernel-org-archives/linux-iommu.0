Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C045C1C
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dpZ4YqZt"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d84ec109fbso529316a34.3
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701346547; x=1701951347; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJCc9G3EC+NAjT0tK5yC9iiI0skMSbzKL4bpKApwWpE=;
        b=dpZ4YqZt8yVlI+/Uqxo2as7CBz1WeeQMZTUO+OjcpoA1BEVRohmdqFeit9RRAOz1/c
         H0sQEUzbxWkhMg6kcN9ioqnnJ9F0+haQbWQ2E5lC0bmlCP8w37hvbLfo7kItbFB+oHj9
         dbqN4wuJJ9Wy7KYZ9Y2rZH3rekm9gmZZr7xzpIz5IKo4IvAsFAI56/m0NnkVw2QanwmB
         ktuqnBHMw1kKWRYgG9WiVWZSFEtIFcE/aQls04uu6er3wMQ2Opd8XsmndMJvyNE+qd9b
         5CRBH+ILT5HaANt7woqPftqqBMp3FX5uKCowkHenSRHDYup8kz7gxWJ/A+N9dbN3nv3r
         C92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701346547; x=1701951347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJCc9G3EC+NAjT0tK5yC9iiI0skMSbzKL4bpKApwWpE=;
        b=wTrxwvgSGOPX7iXiIT1BG9D9HM1tlL3Br4ITgEaTg7/VCNQairea5VyyhyLaqTjpbl
         itAZsI4spmTDnxlcSnzO0iMVoKUmFljpX5tD9qWcExyveugOQXLA94gDSFLeWQ42QvgP
         GFb6LcCepHw9j1PrtSCnROYnhOJSq91z6sJ/jtajPpGudGtkLytOTYXQKVZedULXWnvw
         N/g32GrQsZP8/OLrVn8nbYXtw8nbQ6bWv0x/yVi+gO+WHxvsSA2lK9wH6dTWnbO+3l9S
         yFmHaV/utMUEqJa4QhWu6mQ+fKc81G+sRWvhC8QhZ5YuY2PffgGioPNuCaPqQ9NH7x45
         wlLA==
X-Gm-Message-State: AOJu0Yzrm+L7gGio6D0WVkYbkgAdhA6yjNKQNcnKR4ZguwtjXPlIJk8j
	ySO8ThWzgv3GnRQAqAHbm5v8SA==
X-Google-Smtp-Source: AGHT+IH4aK3LYbDZTOXkpMfqtUQj0FJCc/XdP+zPGlT1qcjW2LqvVfNRQxQAJceD1zjJyXpuw++Cpw==
X-Received: by 2002:a05:6870:9e83:b0:1fa:1bf6:b6a3 with SMTP id pu3-20020a0568709e8300b001fa1bf6b6a3mr23299174oab.28.1701346546810;
        Thu, 30 Nov 2023 04:15:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id b26-20020a9d6b9a000000b006b74bea76c0sm127412otq.47.2023.11.30.04.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 04:15:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8fxI-005u3o-RF;
	Thu, 30 Nov 2023 08:15:44 -0400
Date: Thu, 30 Nov 2023 08:15:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
Message-ID: <20231130121544.GC1394392@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <20231129201020.GK1312390@ziepe.ca>
 <2f2582df-fb56-4b46-8ce3-364879b34734@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2582df-fb56-4b46-8ce3-364879b34734@linux.intel.com>

On Thu, Nov 30, 2023 at 12:06:59PM +0800, Baolu Lu wrote:
> On 2023/11/30 4:10, Jason Gunthorpe wrote:
> > On Tue, Nov 14, 2023 at 09:10:34AM +0800, Lu Baolu wrote:
> > > The latest VT-d spec indicates that when remapping hardware is disabled
> > > (TES=0 in Global Status Register), upstream ATS Invalidation Completion
> > > requests are treated as UR (Unsupported Request).
> > > 
> > > Consequently, the spec recommends in section 4.3 Handling of Device-TLB
> > > Invalidations that software refrain from submitting any Device-TLB
> > > invalidation requests when address remapping hardware is disabled.
> > > 
> > > Verify address remapping hardware is enabled prior to submitting Device-
> > > TLB invalidation requests.
> > > 
> > > Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by default")
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
> > >   1 file changed, 18 insertions(+)
> > How did you get to the point where flush_dev_iotlb could even be
> > called if the iommu has somehow been globally disabled?
> > 
> > Shouldn't the attach of the domain compeltely fail if the HW is
> > disabled?
> > 
> > If the domain is not attached to anything why would flushing happen?
> 
> The VT-d hardware can be in a state where the hardware is on but DMA
> translation is deactivated. In this state, the device probe process
> during boot proceeds as follows:
> 
> 1) Initialize the IOMMU contexts: This sets up the data structures that
>    the IOMMU uses to manage address translation for DMA operations.
> 
> 2) Register the IOMMU devices: This registers the IOMMU devices to the
>    core. The core then probes devices on buses like PCI.
> 
> 3) Enable DMA translation: This step activates DMA translation.
> 
> With regard to step 2), the call to iommu_flush_iotlb_all() in
> iommu_create_device_direct_mappings() can potentially cause device TBL
> invalidation when the VT-d DMA translation is deactivated.

You are trying to create an atomic change at boot from non-translating
to DMA translating for HW that doesn't support the identity mode?

This should probably get a comment in this patch..

Jason
