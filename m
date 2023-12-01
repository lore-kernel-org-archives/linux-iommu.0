Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A721171C
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PDNrvdUo"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77dd073b5baso115532285a.1
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701440668; x=1702045468; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBsvr3M7y7nivS2i0Ob2cINhbfVirpoyS0qfXlH/VdM=;
        b=PDNrvdUoYQL7S33vOSKU22sqhhzRPgc2HTOK72loggDUobMeBFqzP52usAQQs00ADy
         4KPUJw1G8pB5PEePCPzJs/66as00/47zgIgwlAjhMOfALq1e8hNJ2dJppwRXN9XxfoJQ
         HbIzU68Rz7BYXwDDF/DmIeepLbNgRwFG7WO/+4MT93H2DbJVSo5MhR/6tJqvNPGDvz2E
         DTxkvIu8e+W4sDniZ7YHUUzx3i3ZDM/F7d6NlYIyieEVb5jWGKszB3Ez9ThlsUdLvXJv
         HpQV74MRMAPkaFWUbwB7ZsOcX33LeLLrOq3OWHfNYxF5y1imNyfjuXxZxqy+gQ8+w+ws
         ylsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440668; x=1702045468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBsvr3M7y7nivS2i0Ob2cINhbfVirpoyS0qfXlH/VdM=;
        b=qnRd27+ARhbpS0cEKac/PhFAr9xvOeq6EVpkkN3YNvLR77+cICfCVcZyVHHLObl28L
         fEdP6HGHsQ93P44LfKVwHSuv+KkPg2FrNuEbCfxnRZ2TmvJRDaiwfZr3kvwD5217YQUc
         E3u455IgrLM37eEYDA+k0lF0To4/HkVdne0Q+Oe18Nn3v6zhO5iJib6TTgiKCUBMt8Rk
         jMyLAD3Xz1AT/3yR0hr4WkJfGZjDADzdDFcL7mCe0vgfzbb50pzb9jSzI3CK8abLzmWx
         pvyq8Ck5lKYklFXLjLKR8hKvCtAA1a0w0crpwUY8pXfAD5We/c6lIvWOnX6UmRREd8f8
         1uCw==
X-Gm-Message-State: AOJu0YwOK1bPYb6HP5x8K22+C1nMa/nDuYK3hpqlJ5G8wu8PTEuf8TLi
	miAgL/L8gzf7nh38AKY484Ed3Q==
X-Google-Smtp-Source: AGHT+IFhbf0pnfqRmkrdAgeW6divQjwDnNZXsygeLqQa4cWucFhgEwsEVMG94jE+nlw/p5nE/n3K4A==
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr24340270qkn.14.1701440668556;
        Fri, 01 Dec 2023 06:24:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a122f00b0077d606bec92sm1519643qkj.108.2023.12.01.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:24:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r94RP-006FTp-4e;
	Fri, 01 Dec 2023 10:24:27 -0400
Date: Fri, 1 Dec 2023 10:24:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231201142427.GJ1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.
> 
> When an IO page fault occurs on the first-stage translation table, the
> IOMMU hardware can deliver the page fault to user space through the
> IOMMUFD framework. User space can then handle the page fault and respond
> to the device top-down through the IOMMUFD. This allows user space to
> implement its own IO page fault handling policies.
> 
> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.

This is probably backwards, userspace should allocate the FD with a
dedicated ioctl and provide it during domain allocation.

If the userspace wants a fd per domain then it should do that. If it
wants to share fds between domains that should work too.

Jason
