Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA048CD6
	for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ngooeXhw"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-77f3c84e0f6so283332685a.1
        for <iommu@lists.linux.dev>; Mon, 11 Dec 2023 06:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702306224; x=1702911024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zY0//tl2g5UpTN9HNsgH35wUdWi0GHrJKuCe+zbVGE=;
        b=ngooeXhwzZIBoEDS8QYUKk3HXrORG9ODbGU258Ujmc6OzgfbGtM0Cpo66/DI1XzdqZ
         24tYEpu0a3/qlZbMvCtPuuK6sapU5RGYC0xLNnABx0PelDM0r+M8HezwYJ4FCeUDfiD7
         FwAQbDVbRZwRm7bjECWPTi47jwInJ/D2puKomC6QVLUttxzIUdsgIdn8KLJsEW2NhFdk
         jdzi2PRAJ20yaIQWr0fTEJPjE7ZwHadfer+k7Epx+b5ZjjBrVf2d5wOG0ga1EIAPlROQ
         vz86mPjmOkJiJQjhvjL0/3iC+a1z5bJUaEhuAtH9LNaRK/FdEJyjeOIJK+3pl9xFcQKn
         WTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306224; x=1702911024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zY0//tl2g5UpTN9HNsgH35wUdWi0GHrJKuCe+zbVGE=;
        b=Niui34Hs16lNwOpo7XGPHfBoRqm8w/3uJCLnPYFODm8QpRHOCex4yJMzs+sWUolA7q
         GWR10/W0+5sJJ2sgIHg4VP87teJa7343gY5+Hn+VTpx9fb5n7WYdXKja+4vtgLzAr+xh
         x+Qp6C3mBJkpsr0EUeoBOLTPM2DksD61FbCnMhKVv+uzExqUUsqZmNlUVgbmYSEiUJbr
         A70Zlk2mCtAoQw+dFpDAeWgRlwTQ0jSzKLhn//XIVG3nVYw6K26rwlSeW1A6xCYuda5R
         baR+cIB2KPhh35oXEf+XTqPwphHdIbttgC8WkmI+edSjtAcWqfk/eiGBtfTPuUK4Qz37
         DD2Q==
X-Gm-Message-State: AOJu0YwYVNIiSWImfjCrg32dj3RjYCRj+tm6pONGDeHhi3AaAklI9yyO
	4w7qWU68ygiM43Q1WZgJtNLSPA==
X-Google-Smtp-Source: AGHT+IHGkLg/syuCG85iyYo/XNSnvoZo038HyAe/rHk+Y5RIFg9FCabNPYR9leNiDmLw0NWrT9WPlw==
X-Received: by 2002:a05:620a:36f1:b0:77f:7898:8a73 with SMTP id cz49-20020a05620a36f100b0077f78988a73mr1500354qkb.6.1702306223919;
        Mon, 11 Dec 2023 06:50:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id a10-20020a05620a124a00b0077d78c5b575sm2956728qkl.111.2023.12.11.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:50:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rChby-00Cbmb-Rh;
	Mon, 11 Dec 2023 10:50:22 -0400
Date: Mon, 11 Dec 2023 10:50:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] iommu: Refine locking for per-device fault data
 management
Message-ID: <20231211145022.GZ1489931@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-12-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207064308.313316-12-baolu.lu@linux.intel.com>

On Thu, Dec 07, 2023 at 02:43:07PM +0800, Lu Baolu wrote:
> The per-device fault data is a data structure that is used to store
> information about faults that occur on a device. This data is allocated
> when IOPF is enabled on the device and freed when IOPF is disabled. The
> data is used in the paths of iopf reporting, handling, responding, and
> draining.
> 
> The fault data is protected by two locks:
> 
> - dev->iommu->lock: This lock is used to protect the allocation and
>   freeing of the fault data.
> - dev->iommu->fault_parameter->lock: This lock is used to protect the
>   fault data itself.
> 
> Apply the locking mechanism to the fault reporting and responding paths.
> 
> The fault_parameter->lock is also added in iopf_queue_discard_partial().
> It does not fix any real issue, as iopf_queue_discard_partial() is only
> used in the VT-d driver's prq_event_thread(), which is a single-threaded
> path that reports the IOPFs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Yan Zhao <yan.y.zhao@intel.com>
> Tested-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/iommu/io-pgfault.c | 61 +++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
