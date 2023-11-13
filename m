Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3A24203
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRp5k9Oy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=JRp5k9OyUyCa4Oe46uqvUTpj/j2NlbNSIs2FqP5lgArpkAsewy0uJb+JK2aMVyykyjQQ8/
	Vxzqr0HTFUCzXaPMOOtKmkNBqAFAWSoo2ebpAnD3di/IyXtpcSnoOAkkH+vrUGzsKf9eoE
	Q9SKRCqdHNTvXe0x4RCyN6grC6Wbn5M=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-sQiFjMAAOfq7vn5yfVY7UQ-1; Mon, 13 Nov 2023 15:11:40 -0500
X-MC-Unique: sQiFjMAAOfq7vn5yfVY7UQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-589fa8cd181so3873746eaf.2
        for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 12:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906300; x=1700511100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ODpGJiPvlgCDRP4yOnFuGaub5zyQz1IX5Vybw2x4zs74MyJlZiAlCO6dxqCV5/92rE
         7RTpGhnuwOhPnjIkBYfaY32wGTvs/2fJlEPSeFwDtVFw/8FiJGZifg0e+EwxcdyTeoNz
         m9l9+i4JjVsyKzeFUN5jXnw68wRXt5fSAjewiTvAvdt65e5+gP6eR+z4wdio7vchO9hx
         Jw3M8OhWBU3UM9/+p1LXXWyB6MyEHN1zOy2ZRYreK21FVJ+tvdfMxZ1BdgdPesftPwFa
         ZrSML60QzaDYubbcs+OK0Rm7RHFCQwnKVl9dcHS44XoD42MztEKBeNCaNBFXBNmhsUuG
         7zpA==
X-Gm-Message-State: AOJu0YxKh3M+8RxXcFsv7VUktIuB6Fp/bgC2fbVY3Y37Z3AVy/1i+46I
	xCSJi/k/eIJ+ZjEK/R7Blcre8xp79eC8CwsFuNTA/l1hx2Y85N00I09QLBd1/nSGmggWH7ipLoK
	nSmleNZT4q3EoW0Y=
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367416rwb.25.1699906299912;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIOetclT7JIwJMgw/sY1gBz67FNYTbvIhgzf8jdwnJ0WmLDY550/th30Kkt+kh8RpDUm+sYQ==
X-Received: by 2002:a05:6358:2904:b0:168:e592:f8d2 with SMTP id y4-20020a056358290400b00168e592f8d2mr367389rwb.25.1699906299658;
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i2-20020ac87642000000b004194c21ee85sm2173891qtr.79.2023.11.13.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:11:39 -0800 (PST)
Date: Mon, 13 Nov 2023 13:11:37 -0700
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
Subject: Re: [PATCH RFC 07/17] iommu: Add iommu_probe_device_fwspec()
Message-ID: <uw2q27tpuqmxe5gzjjsmnjy2rvtztqomdh4czbws3yredeshzl@7zy6ls5ozqg7>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

