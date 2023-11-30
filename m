Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E455386
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="htpgIwRF"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d52e0065fso186776eaf.0
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701304792; x=1701909592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqKTf6r/9DX5X0G9N0YPszfAss74aB4UlJwKc4ipXlY=;
        b=htpgIwRFHaIEjl9itPq9xbgt3M9d7TG5AyqdhUL30SRmxI78U2uWg2e3jjaxRuted3
         luPtViNn1G12mdGj0AvNgMyqKfid6lSJvIn2SlCcc6yMUf8eMZDBRFYnqrsVzxMq+7C9
         6UIZ6/igNCwMyBtmsqF0F/kwPfeutBVwL186Ft3jy5cCOtJLjdykEBDybPF+atNefbCa
         edcyCYbX93earG/WVQOWjuqJ5kJDNUpSXtNJhA+MoJpwW+YwXC4R4RJd6tk4XbBpGYok
         yw4WrOHs4qsv6+QUfv13Ja0NRIsMucJdZ72rp4zJHPbkEpPxELB0k7R+WktgDafMBepU
         a8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304792; x=1701909592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqKTf6r/9DX5X0G9N0YPszfAss74aB4UlJwKc4ipXlY=;
        b=YqIPY+ZUGrOq540NPuVYuePmSjEp485t2YDITICYQUFu0CDmnylYpN0P/dytSzRdbD
         7ychPClUy/dzOcg3urmharZbgd2rwFrxAd6LymyqZSWYv4rbjmOO6vibhTye9mJGxPHk
         j5R8tCHt4pvinJxO2FzWmU7nhUb/aiSLdyyVOg2shEwi40NfgUumqx4W6cTVP9ElmoTN
         rB8pfp68PY36W9MiU2IE7fVSaOSAuT7cRu8uc12NaEJ4IV0EIwlk8yAaOqEQHJEk4wtS
         7SwZYjPVS1fD1+S/b1FYsnaTP2JSOPmHGeIh422mUurtxFqISSqQ3gXAMlyEssjxO8HK
         Yxsw==
X-Gm-Message-State: AOJu0Yxips18IReX+7nxoggN2eVnZt0E+brEj3E/ZGcOMaZ79hfzGD9y
	rtIt5kLo7kosYf1Bj2qan4seYw==
X-Google-Smtp-Source: AGHT+IG4kpqJkp5MuGe0QWOyJQ+HDuDWisfSFN2LiYZ3lNwDJg400B3FZHlbHx5WpKar2Jc43DZwNA==
X-Received: by 2002:a4a:a645:0:b0:58d:6bf6:4daf with SMTP id j5-20020a4aa645000000b0058d6bf64dafmr7941560oom.2.1701304792652;
        Wed, 29 Nov 2023 16:39:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b0057327cecdd8sm2410792oon.10.2023.11.29.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:39:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8V5r-005qzk-3H;
	Wed, 29 Nov 2023 20:39:51 -0400
Date: Wed, 29 Nov 2023 20:39:51 -0400
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
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <20231130003951.GA1394392@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> Return the Root Complex/Named Component memory address size limit as an
> inclusive limit value, rather than an exclusive size.  This saves us
> having to special-case 64-bit overflow, and simplifies our caller too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/dma.c  |  9 +++------
>  drivers/acpi/arm64/iort.c | 18 ++++++++----------
>  include/linux/acpi_iort.h |  4 ++--
>  3 files changed, 13 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
