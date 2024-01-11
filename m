Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872715E96
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PjojVn7s"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59612e4a21eso1859190eaf.3
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704984523; x=1705589323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrN/u7xLL+bkBWkVdwAioWUw4hwqypb2+jiPonctpyM=;
        b=PjojVn7sDLPjH6MddLBSeQQh3CMETEGkeZhRnlbQ4KmZe08qwQ+P93xapiGfja1KqB
         zOswsT8KckA1aBBuqeKj0YW19dRFr65hFMpDUyvUTB5wC6AVvgwiyPttULPGHIG6KdvU
         lR4+t4BHwbHnO0ID4XhRBl6HC7A6aPcRB5xpajWGoN+S1mWdkGwMkg1sdhzFHm6WoQ9v
         u3Km93BQ6yHBYBSamr/3/RgSDPerLEUrFM6YZLiUaU9jxmxABbqdRqw4A0ScOeW61Q1s
         zHRKfvojEUOYg4PWUiHt+oMFsvVTuaBxLFOH6OljfFvy4KMlzETb0x4L/p8GBeF2d8s5
         Nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984523; x=1705589323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrN/u7xLL+bkBWkVdwAioWUw4hwqypb2+jiPonctpyM=;
        b=EDlT6n0OGy7SBivonNwH9oxh6D69788x3HaDGRQyxuT5R/OWJ3tGaNmunvCewtGEla
         Izq7Cvx+pFtuIcO/JKvDWZKftoNK1qiImpTvlsTyr4jm8EAryN5Q8fO6EdBozLUMd9oF
         9ESfjeC6imGm0+yiSExuM2DvZptHPm6Knj3ls5wr5zF7zwpi16J5421sDX/49fz+GGgn
         I5giIfgiw83H+wcQ/M7CXt76/wzQUc506s5GMjydi5tIKNkBt8PNyNkmmiTLpnJpZ24x
         5rHlGAAuF7sFzhkLiI56dojrb1PIpO/ReVkvnqNZ1QyBaQl3THJlJLB+f7bhtIo8JxAo
         nlrA==
X-Gm-Message-State: AOJu0YxbfKedMXpBH+o916M31b4tcV6KnWgOh/HI6Sg4Wy6MMrXBL20T
	7bYEfRDldZ4hcxVwWlXVU3CFk1/rY7tblQ==
X-Google-Smtp-Source: AGHT+IFmdXOrokCK1WP95oOIGerHyQd/Znbs6+ctkcHiNb9val6YVB+UCc/1G2ZDKwu7lECzZ2wSEQ==
X-Received: by 2002:a05:6820:238e:b0:595:5276:5b1 with SMTP id co14-20020a056820238e00b00595527605b1mr1190596oob.19.1704984522914;
        Thu, 11 Jan 2024 06:48:42 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id w1-20020a4ae081000000b00594c1fa39efsm215624oos.14.2024.01.11.06.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:48:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rNwMK-0031Wz-UK;
	Thu, 11 Jan 2024 10:48:40 -0400
Date: Thu, 11 Jan 2024 10:48:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommufd/selftest: Use right iommu_ops for mock device
Message-ID: <20240111144840.GW50608@ziepe.ca>
References: <20240111073213.180020-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111073213.180020-1-baolu.lu@linux.intel.com>

On Thu, Jan 11, 2024 at 03:32:13PM +0800, Lu Baolu wrote:
> In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
> for the device from dev->iommu->fwspec if this field has been initialized
> before probing. Otherwise, it will lookup the global iommu device list
> and use the iommu_ops of the first iommu device which has no
> dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
> device on x86 platforms where dev->iommu->fwspec is not used.
> 
> Preallocate the fwspec for the mock device so that the right iommu ops can
> be used.

I really don't like this.

The lifecycle model for fwspec is already a bit confusing. Introducing
a new case where a driver pre-allocates the fwspec is making it worse,
not better.

eg iommu_init_device() error unwind will free this allocated fwspec
leaving the device broken. We don't have the concept of a fwspec that
is owned by the device, it is really owned by the probing code.

The fundamental issue is we now have a special kind of driver:

	fwspec = dev_iommu_fwspec_get(dev);
	if (fwspec && fwspec->ops)
		ops = fwspec->ops;
	else
		ops = iommu_ops_from_fwnode(NULL);
                                           ^^^^^^^^

Which represents a "global" non-fwspec using driver that will only
bind to devices that didn't parse into a fwspec.

The code above supports only one of these drivers at time, but allows
more than one to be registered - it is inconsistent.

I think the right/easy answer is to iterate over all the "global"
drivers and call their probe instead of just the first one.

Especially since my approach over here migrates the whole thing to work
by iterating:

https://lore.kernel.org/all/0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com/

And this patch:

https://lore.kernel.org/all/28-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com/

Is how I made the iterating logic, it could be pulled out and tidied a
bit.

Jason
