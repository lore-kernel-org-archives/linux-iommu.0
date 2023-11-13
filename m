Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F624A08
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flqyw7pV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699906740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=flqyw7pVz6uNBBQQ2S5tLqgyHjs2xVfzD4uhNah7b6k0rwqfXW/Qi9sCL55QOV4Wp5Dm8n
	eC4UMRKE8dWDd74dRqpwbiqZVcslr/Cs3azqQ/hVSaHOxnqmc6Y4UcqeZIn+q9W/gJCYrR
	+oqy7dRR/Lu7VzKLnZ/Z61Zud3J2W5I=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-xDdXUJEROHuvu8rXhw0hRw-1; Mon, 13 Nov 2023 15:18:59 -0500
X-MC-Unique: xDdXUJEROHuvu8rXhw0hRw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41b83b8dbe1so58232921cf.1
        for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 12:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906739; x=1700511539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=FLkqLdvpTmop6SDXQkRPbNc2132yUSm/Wsfltf+qaBogoTDDe9cTS7PwB3m+B+KCZY
         knIFxGZ88wQYmjuoD7JJLbc5EfEB8zZ6oXpygjrfTDS9bk+riL2ajXFhs6LI958oNYZn
         diymYfSw7wnQzYMNxk4wjv+gEWItUyqxVQcZbPNiG0TAMnK6d012JQ5iRiujJAaPxxLF
         kBdVT5+i17ltGWzwthL3Miu1gwowqX94gDAxiZTcq/vA6KGauOLDMv1Y9h0xGmepNUbC
         EJVAfp7ZaM6+0apvC20q4sivV0hOGpbCSZZeJyAVnTXfTfxi7C/0xbirNNoZZxSPKAuV
         m0Cg==
X-Gm-Message-State: AOJu0YyEeuVysXUxxBrvAmMIIz0sJWrNtcQ6eXbzYJp7Z33sJRcmjdsQ
	F+uJFfD0qOSfviIBq6gafrqHdZHgnx2kSUaQrS0moom8P/eWo1DlPXDfw5GpBR/HUuAH69FsOGu
	UAdDc/s6HgSOFOm4=
X-Received: by 2002:a05:622a:1908:b0:41c:b6cf:a49e with SMTP id w8-20020a05622a190800b0041cb6cfa49emr292150qtc.10.1699906739318;
        Mon, 13 Nov 2023 12:18:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ4aN/cKUvDweqjuNq1K11+iEyXGsjit6950JrTQD9aZT2d8xoiBctpmKNKw2vmVX7XqpdQA==
X-Received: by 2002:a05:622a:1908:b0:41c:b6cf:a49e with SMTP id w8-20020a05622a190800b0041cb6cfa49emr292104qtc.10.1699906739106;
        Mon, 13 Nov 2023 12:18:59 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j5-20020ac84f85000000b00405502aaf76sm2177375qtw.57.2023.11.13.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:18:58 -0800 (PST)
Date: Mon, 13 Nov 2023 13:18:57 -0700
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
Subject: Re: [PATCH RFC 14/17] iommu: Remove pointless iommu_fwspec_free()
Message-ID: <22mlpmrdftubxzr46qci26p3aqojvv5p4ffroshlzubtwcw5cr@jwcl5scuttdi>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <14-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <14-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

