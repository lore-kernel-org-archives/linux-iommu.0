Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB160EDE
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jBUj8iX2"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58dc434442dso604387eaf.0
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701290203; x=1701895003; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEEWYYfbaxLfYva0ae/C7ZnG1wW28/cSiuyFpLC5DM4=;
        b=jBUj8iX2wFu0bL4WTwhhSRYDyLxpQaZ3xudifhktGhthuabEuEj5Qba8B7ez/6P+UE
         PUpqjQxVkqeQomYY/WNrzTGiXG0YtQpqZ3Zm2UMKNhRZRyl9m+UJuaDxV4ZbBR2nT3J6
         B3PuONUq2Rpv2qRbDnQ1M4eWd9LIa7Eh0HMDXoMzCACpLwNXPwaRpItZTWUFjpCRphvp
         +IAtWQ8gKDcirrBHyhqKnM4YoyDRmG8dYsi1Ucsj3zOgsjNPDnZy7SRGCzY+NttX1A/T
         NKywtHL4ph7g+60EeJ8MXv6dMI69Dai0g8pBQdf28R4Rme+AvM9pC/hdu2gr0T+TEP/V
         LQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290204; x=1701895004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEEWYYfbaxLfYva0ae/C7ZnG1wW28/cSiuyFpLC5DM4=;
        b=jva1XEEQN+JNNe9MwhC0Nw/pdOOgF+ZyHn7UrpzDs8g7LhJrkpssb+aIRZMhrdzIyy
         ITPsNTk9jz5v3wyJlm8aCDYBaeG+kN+qli0AVbQdMwLgv2I1lc3gRy8DYyN/5PBRRZ1Q
         Y7PIpG5X4UhScKgFNDVDnFJdYgIfhqr5fJ3UI79/pl+WiiB904ornbZCIu3bjaL1lPDc
         +mM1UBfvm024azsvgVCPEC7OEPkkufoKRZ09IOhQEoB2KKQ+00Py64ZqbZNIGr3+ukP6
         QBx+xJrnWVDE+b3CLpuEphweJG50d6ENL9Im0PsNU1hZ2rYjRVmmUz0vrkhxkJFyMoIK
         zmcA==
X-Gm-Message-State: AOJu0Yy8yKMRhMA2GwQc+3RFfeBnHEvUhznlce873pEQEkTMJLc+05S+
	0KRPDbUj1nyWUScSumrx+e3rsg==
X-Google-Smtp-Source: AGHT+IHmOgaQ+837kiXjy012BQ8mhYf6brt1F8AtFjpilauVwFsZjspevsWNCbIpo0nFHydtgIy6ZQ==
X-Received: by 2002:a05:6871:3322:b0:1fa:29b7:f2a0 with SMTP id nf34-20020a056871332200b001fa29b7f2a0mr7173525oac.23.1701290203779;
        Wed, 29 Nov 2023 12:36:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z19-20020a056870515300b001efce0658e6sm3567983oak.39.2023.11.29.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:36:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8RIY-005pe4-9r;
	Wed, 29 Nov 2023 16:36:42 -0400
Date: Wed, 29 Nov 2023 16:36:42 -0400
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
Subject: Re: [PATCH 0/7] dma-mapping: Clean up arch_setup_dma_ops()
Message-ID: <20231129203642.GO1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:42:57PM +0000, Robin Murphy wrote:
> Hi all,
> 
> Prompted by Jason's proposal[1], here's a first step towards truly
> unpicking the dma_configure vs. IOMMU mess. As I commented before, we
> have an awful lot of accumulated cruft and technical debt here making
> things more complicated than they need to be, and we already have hacks
> on top of hacks trying to work around it, so polishing those hacks even
> further is really not a desirable direction of travel. And I do know
> they're hacks, because I wrote most of them and still remember enough of
> the context of the time ;)

I quite like this, I was also looking at getting rid of those other
parameters.

I wanted to take smaller steps because it is all pretty hairy.

One thing that still concerns me is if the FW data restricts the valid
IOVA window that really should be reflected into the reserved ranges
and not just dumped into the struct device for use by the DMA API.

Or, perhaps, viof/iommufd should be using the struct device data to
generate some additional reserved ranges?

Either way, I would like to see the dma_iommu and the rest of the
subsystem agree on what the valid IOVA ranges actually are.

Jason
