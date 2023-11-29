Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891C57304
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VMtREw5s"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ce322b62aeso154894a34.3
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701291010; x=1701895810; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z14ncuPizPQTpz34E/qdK1zleu0e7/OH8lwfu0qFocg=;
        b=VMtREw5s610XQXc0MMtKspGaJ8dpQQFPThr3sdzlge2KGgGudeVbytHS6HDq+m2+MK
         p9dhLiRkO/MWVNeiCVYt7gsY+01Y/QzapI0zWoO3FmmsX794OYNEJmjRA6t2i3aebkJo
         sJrm9IHgfbLrlq2YO+M79bbPCijHMX0wKZtvfFpEmoyt40dWlBDr1L41QCliOpjZzdHC
         EDCpcIM4YzcHbYO0MNC1r23xyfXjQucrCU/P7UL45EFTRxuUdCHRUexhzeZyX6JsalvP
         KTY3HdnGc6retSJzYuPcAA0+Av2630mLda65bLnqZnQxvsqWu7fFT49iyQZxnho1ItHL
         A8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291010; x=1701895810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z14ncuPizPQTpz34E/qdK1zleu0e7/OH8lwfu0qFocg=;
        b=PF71D+t313qhY5P5dRAsxRtypWZxAO1YzyfZWK9oE7ucCu5yMN7DNbqksGqm14YJ+s
         t3irGIGOzjSf4QP5QLeoKMKwdgBi+jGqB3pZKqZqZ4rQKsx98fZrZLaqZnDPKL7B7Kv4
         oEcE20FWOQPiZ4f11iJKjENb8x4vFLzh+k5EuXr69rSB1+Cc58YeZb7Ane22Y0nCe1M4
         78IK4m1laJ36XaTre03nyswh+ltD4xV29hn0CMRMU3QyFJByjIrRmHWrKTHftRgGJyUo
         Kqp3adjgG5UMIdGBdOScc3FEEYpafoet0verY6eEwvKZK/HkDAUVLzzzMNoT0r1A3bB8
         Ub4w==
X-Gm-Message-State: AOJu0YyhKurbsT+Z5vLKxST8ms2qU9jWZ4w3egjCRBUN+aV6ji9zafsQ
	mRJyzSJCbumGC0CbPW69wCYHsw==
X-Google-Smtp-Source: AGHT+IGgKdfE8YcFNMWNxw13U7YpCs8rnHcqlluxJCfOn0tU84fkZFp4MzoV02U2Np+AMlZvjw1IBA==
X-Received: by 2002:a05:6870:d622:b0:1fa:ca3:7069 with SMTP id a34-20020a056870d62200b001fa0ca37069mr20658402oaq.16.1701291009170;
        Wed, 29 Nov 2023 12:50:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id yu6-20020a05687c224600b001fa6ba84054sm1349572oab.55.2023.11.29.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:50:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8RVX-005pjC-Mb;
	Wed, 29 Nov 2023 16:50:07 -0400
Date: Wed, 29 Nov 2023 16:50:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20231129205007.GR1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <7fe5a0d2bc855ac38dff326f3e64ba394bc262d4.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe5a0d2bc855ac38dff326f3e64ba394bc262d4.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:03PM +0000, Robin Murphy wrote:
> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> which means there should be no harm in instead running it off the back
> of iommu_probe_device() itself, as is currently done for x86 and s390
> with .probe_finalize bodges. Pull it all into the main flow properly.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c  |  2 --
>  drivers/iommu/amd/iommu.c    |  8 --------
>  drivers/iommu/dma-iommu.c    | 17 ++++-------------
>  drivers/iommu/dma-iommu.h    |  6 ++++++
>  drivers/iommu/intel/iommu.c  |  7 -------
>  drivers/iommu/iommu.c        |  2 ++
>  drivers/iommu/s390-iommu.c   |  6 ------
>  drivers/iommu/virtio-iommu.c | 10 ----------
>  include/linux/iommu.h        |  7 -------
>  9 files changed, 12 insertions(+), 53 deletions(-)

Yes! That probe_finalize() stuff is not nice

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 824989874dee..3a0901165b69 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -589,6 +589,8 @@ int iommu_probe_device(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	iommu_setup_dma_ops(dev);
> +

I'm pretty sure this should be inside the group mutex lock.

The setting of dev->dma_ops should exactly follow the setting of
group->domain, and all transitions, including from the sysfs override
file should update it, right?

Thus to avoid races agsinst concurrent sysfs this should be locked.

I think you can just put this in iommu_setup_default_domain() and it
will take care of all the cases?

Once in iommu_setup_default_domain() it is easy to call it with the
domain argument and it can know the domain type without using
iommu_is_dma_domain() which is one of the very last few places
checking for the DMA domain type.

Jason
