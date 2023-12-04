Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9328DC7
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rqy0ykEG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42542b1ed5dso22134061cf.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701703931; x=1702308731; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=Rqy0ykEGKFeI2Fw9eA6XEKSonOOqUqi+Su7BHbj+isLFvuS3WXcMZ75cbiDHV/Xb0p
         AOBCPWGrPVFAFSVeYoqAXGUNacSqYQgas5uH7xu09PhqmT1qMXvG7z5zSfCIE7bGYG0o
         WRNUetn9YjtbVMWPG9jpYUl/2j7eX9u1v0RhmbCviblt5CYl/DLgtY/CJDJmlg91csGw
         kmpomDdOVHkAO4PuPMyxfNi2VPcRwqUHqfoTVS1yX+iHeiqnX9JFn8Gc3uPJglkVZ+Ab
         2RNfxGCRuEM1UgWao2wZxiwjA1y8g6xmSWhiKquxtHw6zcuDVTt4coXQHRsYahZk75HM
         hItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701703931; x=1702308731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNErOhF1qMkgPNVpHAnyVSyCwAUX/1YSBmZDFvsm8OU=;
        b=r6x0SsOBqq7jlJ6HliZEeE/BJYK09im/QIhzF0ZVhLzRKhQe0odjrMYZoKNyQcjk7h
         ZpRoaSV5oC2xHyFwKpbwbuZgEcJe1vMGEetkE9pThqlNbMQK82kWdflAjl1aECe8VyPj
         qe2oO9pQBQesYvuUR86ln9sPmaPR5Ofk9PUjovE5HoTOvMufMdHfSH/MEU1Gip+SSZkQ
         J7cSv2Vn8Cb74QGDOVlsFdT4jTmvtqEworixARimEzq1kqvqSwOpDDmsW471kPkg3Lkm
         5q49blwN2rc/lp8eLmibLcVGw7X2BsVaytdE2H7Grl1AZ7FXei68Y22gxUtIH7tvr5c9
         KSJQ==
X-Gm-Message-State: AOJu0Yw8CG0wHMIgWGlmmNSzwR5Xl5Ji40ZoUkEDZJh6K4VnUiPdlH65
	MWOGGcgKjgKfKCTnmnGFe1FxGg==
X-Google-Smtp-Source: AGHT+IEnloh+umt8D2CaTqj/3erJ8LZq5gKurAnArFiVByvdfAGoIgyiu/VWyqqDTZ8kj1dh4ApCGQ==
X-Received: by 2002:a05:622a:1c8:b0:425:4043:96e2 with SMTP id t8-20020a05622a01c800b00425404396e2mr6614490qtw.111.1701703930810;
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id df15-20020a05622a0ecf00b00423da75b0f4sm4371928qtb.71.2023.12.04.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:32:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rAAvZ-00B2r2-ML;
	Mon, 04 Dec 2023 11:32:09 -0400
Date: Mon, 4 Dec 2023 11:32:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joel Granados <j.granados@samsung.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231204153209.GN1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>

On Mon, Dec 04, 2023 at 04:07:44PM +0100, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > Hi folks,
> > 
> > This series implements the functionality of delivering IO page faults to
> > user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

I would expect no. Both a nested and un-nested configuration should
work.

Jason
