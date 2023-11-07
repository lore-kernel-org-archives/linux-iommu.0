Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF334CDB
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ylx4N45T"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-41cd52c51abso37401511cf.2
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 09:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699379647; x=1699984447; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FW0RbAVGUFb+xdBElnhNAHeQGgYiHAEYAyCOW53R3XU=;
        b=Ylx4N45TX7nTY7pskGtinShdkHhUHf9kgqtl+o6OlYMnNqC+4qqUexZyid3jjYDNir
         O9aOHX39FJkqkT7epvHbcRbdrv0TTTCif0Ntu/O05+ZefK2hRhnp8ATha2Xuy8mSjQH1
         0DrXTttlXZy0xQQN1VJtGn/Gf7cxdCDN6u7rwqsJBwSVblFdcM+9mhtzBvbI7VyPO4Qz
         qw2LUbTKPWNW+ybxvXPSGY9GVlydXvwx+teXsDPSospHaVOyiwB9jtt85Jq1mN1I95f9
         BVLjv1isYAysFH4JpaBitAs4IqmHR//YsK7BAP/Y/Jqh2lb5KhY3R6k3mGQSWnktHduX
         8nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379647; x=1699984447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW0RbAVGUFb+xdBElnhNAHeQGgYiHAEYAyCOW53R3XU=;
        b=KP1eTet6iRn3szZ9XnkZy6zP66W4gGhPZBHnI9OBtSWmnQ1YKMHB+VywNk0XZuzpFq
         IWqBANFEzRx2+QGTIp9OgFSeKvyqTb42JnMdNnBd5pir05OeXGhLYDfPwZXlSP4andgh
         TclaaUqizGavzFflyzjq9SAghM17eXazU0rGbM6Y0CUCsr24+qfjdHxw9S/2GGHHNtXr
         izdWBEXnN0MqLbIUJzOCT7r9E9tSk+mdCNd07Xf05A2/JZRHjhiS6z2iyMTaLv7Q6aPz
         UAplVpLWyinB9Fv7GpBR/GJuWEMbpUrxMp1HNm7J7A2GQVIdhFfniiTyooRA78VeDw/w
         gQjg==
X-Gm-Message-State: AOJu0Yxlnxj7Ore14YoNMcM+0CWwgTbFECdNfp+tHIXDRdiftY/8Foil
	GomHiSZY0muO4JkzW9zKzJwR0Q==
X-Google-Smtp-Source: AGHT+IGQ+nRQt1M3ckW/OiQMHeS7z9x+pfYfws+XnYXuooXgVjVCkYIWxzYut+7AHyoqub3WHSQdKw==
X-Received: by 2002:a05:622a:d2:b0:41c:e76e:87f8 with SMTP id p18-20020a05622a00d200b0041ce76e87f8mr38242554qtw.34.1699379646766;
        Tue, 07 Nov 2023 09:54:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id a10-20020ac8720a000000b004181d77e08fsm107696qtp.85.2023.11.07.09.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:54:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0QH7-001YR3-Ob;
	Tue, 07 Nov 2023 13:54:05 -0400
Date: Tue, 7 Nov 2023 13:54:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231107175405.GD4634@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Nov 07, 2023 at 08:35:10AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, November 2, 2023 8:48 PM
> >
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > Hi folks,
> > >
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework for nested translation.
> > Nested
> > > translation is a hardware feature that supports two-stage translation
> > > tables for IOMMU. The second-stage translation table is managed by the
> > > host VMM, while the first-stage translation table is owned by user
> > > space. This allows user space to control the IOMMU mappings for its
> > > devices.
> > 
> > Having now looked more closely at the ARM requirements it seems we
> > will need generic events, not just page fault events to have a
> > complete emulation.
> 
> Can you elaborate?

There are many events related to object in guest memory or controlled
by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
the emulation is not working well.

> > > User space indicates its capability of handling IO page faults by
> > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > > for page fault delivery. On a successful return of HWPT allocation, the
> > > user can retrieve and respond to page faults by reading and writing to
> > > the file descriptor (FD) returned in out_fault_fd.
> > 
> > This is the right way to approach it, and more broadly this shouldn't
> > be an iommufd specific thing. Kernel drivers will also need to create
> > fault capable PAGING iommu domains.
> 
> Are you suggesting a common interface used by both iommufd and
> kernel drivers?

Yes
 
> but I didn't get the last piece. If those domains are created by kernel
> drivers why would they require a uAPI for userspace to specify fault
> capable?

Not to userspace, but a kapi to request a fault capable domain and to
supply the fault handler. Eg:

 iommu_domain_alloc_faultable(dev, handler);

Jason
