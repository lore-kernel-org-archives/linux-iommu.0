Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982E7486
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="em6uRppE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7789cb322deso48571085a.3
        for <iommu@lists.linux.dev>; Thu, 02 Nov 2023 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698929264; x=1699534064; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ+GdWawOo3FT7vEf5mwevTBQUu7eDKWKnvNYW/PsMc=;
        b=em6uRppERksUOJ+5l7mbnnRc890xiYPvjIg+U2IKORL/Lnl+3aDGMoRBUuCHLPXCLz
         zdRgtBYCpZ01szaOmPd5HvRFEQk2jlw1Gz5QyPwYFV9/WDls6iRvXJ/+DlasZiPHo1+6
         wB2QLCGsy82r/Kogu2OfilzdP1uOSW8ZKQFwqkNtImXjSgNV/UwmVZU0bAoDCnalIRBd
         iTUygwIALoNjRM+qC5oSez0iFAKvG2cXHBK1XDRwg8RzwBCkqOjtrfQndNEB0kVx+hfe
         M2/y+MeOOPiqDtY+7ac6KPPAJNAYwXNaMNyyBOX5uwX9QwX3dyBiysZV16XLXOcNP7Ql
         GHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929264; x=1699534064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ+GdWawOo3FT7vEf5mwevTBQUu7eDKWKnvNYW/PsMc=;
        b=hkj3bYll286mB8Rc4XAn5wUtS5Rk9wv9zrGBr+KRFlSPJO1YySxFCuiGb0N9RQ7Tio
         nXp6qS7pMyLnsAm38LLO45Hipkl8wOgQI4GMEgBPxa5+OKZgdUNpg/WNKXy7qbQhBM3l
         FeuUbPsvpHn1NsGTfP6gicy2FvWudvlbQLti+fXeSGssRD4CYIObBv45qGpFNHjS8ZlI
         7SGVF2wOV7aTlvqd4g9QcIu/pNVRlqYPDKXioBvb1CtjDeB+Kz+ncCH8scdqeYQBjKFW
         N7PHFD/zry9eOF+esDbYD0Is4NqIzG/LnZMT8bZ05JlUmvuWau73M6Q2xW8KQBzejMfB
         5eow==
X-Gm-Message-State: AOJu0YyrW04rBviikpScTVzd1BKamkKYbLWB7MjMUfciYtZUqMrT9S8M
	lEgTWyecsjiUD47pTnTKGGfvRQ==
X-Google-Smtp-Source: AGHT+IFxFiOR7UXzaPpwFSzkWqw0zJo0m72p87r7wZ2km12vbMwY4rfJeHI3ydNPhYo9BA85V7lP4Q==
X-Received: by 2002:a05:620a:35e:b0:775:9bb1:9ac4 with SMTP id t30-20020a05620a035e00b007759bb19ac4mr18012659qkm.61.1698929263726;
        Thu, 02 Nov 2023 05:47:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id r18-20020a05620a299200b007770673e757sm2291720qkp.94.2023.11.02.05.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:47:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qyX6s-0004kn-JW;
	Thu, 02 Nov 2023 09:47:42 -0300
Date: Thu, 2 Nov 2023 09:47:42 -0300
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
Message-ID: <20231102124742.GA4634@ziepe.ca>
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

Having now looked more closely at the ARM requirements it seems we
will need generic events, not just page fault events to have a
complete emulation.

So I'd like to see this generalized into a channel to carry any
events..

> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.

This is the right way to approach it, and more broadly this shouldn't
be an iommufd specific thing. Kernel drivers will also need to create
fault capable PAGING iommu domains.

Jason
