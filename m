Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC86386
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 00:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O5dE0jMz"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso174739fac.1
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701305165; x=1701909965; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGfesKWk6hIGgQDOksuxdOXdV/4i0gK7DjvWJInD9Kc=;
        b=O5dE0jMzMhdWjZy+B3l4xO35UUxHGQVg7RfZTql9vOcjqENMqCfJux1pf3D25lvzJU
         rbjs6qm23d+pQ+55u6C2b3ea+gxXhIV2py9YVxdPJ2qf0VDmclpae75Qlrch0VLwsJbl
         qp66/D5waNwO6ZThShdqCILD8WNG6OQ0O8YVA3HBRKxja71iCa5E8F3DraULgSTqjEt3
         wkJw9aSoDJ9DkSdOrHASLkPGgPLL175/X2EA2LRMORL2ZEykCwIv1g/pWrVOU624jfu0
         Z6XXgUmd+jNL6+EOS3aWy2aQFzWNXG3goZ2DHnE4QugpzaoE+aF6Hf15LNZBQkfyQTnP
         O2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701305165; x=1701909965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGfesKWk6hIGgQDOksuxdOXdV/4i0gK7DjvWJInD9Kc=;
        b=OSf2M7O/F1+Wv4lFyvEVktdZLQ7UBbpDHLrJuf+ffSSe5L5omM1sDsFyWUdgJc7p0+
         zOP1lEIsxOyGu9muA0fT8jmqPQCJn9/hoWlujtK/9353gR3G8JihWXQw0Zxfn7Ke8Ssd
         23RLry0S7wDLDpJ6SLYdjbtPA8xFaEOFx4aZ2bpdK9MUObvu4U6wpzjl1v4IVev58/D4
         GPq6MGlYjT+UBoOhiLlbgASHdzX4Dbq1OpFvjzxotpqdRb2pTzCaRZum1o//Nc3vG06T
         +7XMMIc7iN9DIyCvoW/1qnUvG7eq5E+nwvvBsG+kZfztg2dLgp90p9Dyg94y1XiKrYgx
         Uc8Q==
X-Gm-Message-State: AOJu0YxXEuIhxytbpykhW28UaMcOlQZHDmycuhaHp0/RSnu+VMl3aO/5
	fj+w5onlxhsDcQPjUtfYcYRKFA==
X-Google-Smtp-Source: AGHT+IH0QnaZj4Srt21JiVw/aqbEQCLMM8IUp7yXueL4iz88oaZRnRpsZVc5esr77Xqw2FDtMOcfOA==
X-Received: by 2002:a05:6870:3326:b0:1fa:2b51:cc8b with SMTP id x38-20020a056870332600b001fa2b51cc8bmr18739526oae.32.1701305164620;
        Wed, 29 Nov 2023 16:46:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id mn13-20020a0568700c8d00b001fa3ab0a3bdsm2224484oab.31.2023.11.29.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:46:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8VBr-005r2g-CG;
	Wed, 29 Nov 2023 20:46:03 -0400
Date: Wed, 29 Nov 2023 20:46:03 -0400
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
Subject: Re: [PATCH 2/7] OF: Simplify DMA range calculations
Message-ID: <20231130004603.GB1394392@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:42:59PM +0000, Robin Murphy wrote:
> Juggling start, end, and size values for a range is somewhat redundant
> and a little hard to follow. Consolidate down to just using inclusive
> start and end, which saves us worrying about size overflows for full
> 64-bit ranges (note that passing a potentially-overflowed value through
> to arch_setup_dma_ops() is benign for all current implementations, and
> this is working towards removing that anyway).

In iommu code I've been trying to use consistent language with other
parts of the kernel like interval tree and maple tree:

 * In this file the term 'last' indicates an inclusive and closed interval, eg
 * [0,0] refers to a single PFN. 'end' means an open range, eg [0,0) refers to
 * no PFNs.

Here I think you've swapped end to mean last?

Regardless the change looks correct

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
