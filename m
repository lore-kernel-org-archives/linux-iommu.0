Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B3249EB
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhrbQhRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=ZhrbQhRZR1NNIm3C+HVzlzFTddOkFA1UG9qmPZhAMZeZSJKHBxrQIZIJKvq7l0nQvf96FW
	IIpTCRts0b3rpD9LvtBKuAEMlIxNc0NPR3jlLVb9os890hwmI0NZilJnpGNCSnhYMvalEL
	cHnrIWaKk1BvAjInZck82wc5atTglog=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-H_knyhdqNlqor5olvzWucw-1; Mon, 13 Nov 2023 15:14:48 -0500
X-MC-Unique: H_knyhdqNlqor5olvzWucw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a839b31a0dso100747257b3.0
        for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 12:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906487; x=1700511287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=k0ONJxHISARTC8QMrITlN1bPWhBABDE8/9z0O/IwflWrqIV1H6qz6Ma20MMaDLBF2T
         96+GzrMvLzMeF7lvrGsWpltOxfNa3Mx12mx2tjjfp2Bvrx5/F23lS9EGQ70n/s6EaXkz
         oE0FSxMB1lmgcP34jpGukpln0tMTpQEbd7Brf9mqprXrNiTnMT5FFQ7LlT+/ck70iA9n
         QqUIFtlnNrC0aohLcguL61QPBAD4zm4Z3i69VbFLudcsPMdjVI0u8pzjw7EqJR5UX0+E
         STpzOV8AbavFR6Umv+SVNclMreCx1RLb8jYs74I3jxOZBIOO04QUaWwJ/GAXRyNtLq5U
         cV5w==
X-Gm-Message-State: AOJu0YwOml8rRk3bF411Aq8L+bFR7vc9YzJqex6gQMl/IJHJJplOAdfg
	z8l7AEFqHUZ8ApnbeSvrig724oJ/sX545iOKJet59hc+Ssn0Ufu05BozoZPoaSOhUxMSl7M4S59
	6YcUdv2QrIKqZKFs=
X-Received: by 2002:a25:5:0:b0:da0:3510:d46b with SMTP id 5-20020a250005000000b00da03510d46bmr6598070yba.52.1699906487810;
        Mon, 13 Nov 2023 12:14:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtyhAPtrfBL5j0rs4OChIjX0J0MQ7pAdoQ6mY8g3IfqhpmTKneVz9ovn0oCERZBj6Wc4LsPQ==
X-Received: by 2002:a25:5:0:b0:da0:3510:d46b with SMTP id 5-20020a250005000000b00da03510d46bmr6598052yba.52.1699906487554;
        Mon, 13 Nov 2023 12:14:47 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id mg3-20020a056214560300b0065afcf19e23sm2297469qvb.62.2023.11.13.12.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:14:47 -0800 (PST)
Date: Mon, 13 Nov 2023 13:14:45 -0700
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
Subject: Re: [PATCH RFC 11/17] iommu: Hold iommu_probe_device_lock while
 calling ops->of_xlate
Message-ID: <5qix66x7f4mgnnylgy4uv2g5oeqxkwvdkrbleyxxfw3hlrhsth@fsqukzhyal6r>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <11-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <11-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

