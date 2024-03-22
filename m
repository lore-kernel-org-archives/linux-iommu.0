Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CE3FB04
	for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128156; cv=none; b=L/fH3JF2WWikR/JxJ0LqqnKh7vgyPOIIpEOh+gHXNtt+1Y3r99JbN/tQQKvMyWeLgoa3ZWe+owHjptuA0ZmkkCuzKNvtuU7u0Sp/3aG6mNuAMUBbUGI5zsqPinMEk1afBal6DqzHfU1fLXsnlQDUyGgyYBZs5PJmYj+boZkagys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128156; c=relaxed/simple;
	bh=JRQSJkNbZDDh5hmntu8CppKCnDmLxnU8CBU620nL6DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMZNq2iYfPmH7r4yAHbI9hrLjtJKGxwZLamI2nFaUj7PQSE6iWJXLxhL8zyhgMEkrV7G3ykL/SS0BauD1LRKIwQFMoJ5FCop2y/RHMeTsPYyQAjV9zw/l5ItbKTrCN9PDiQcimdSY32ogmX61sCAHz6Nft/5K4kD66ym/DLhuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZhW7hb8w; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZhW7hb8w"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690d7a8f904so31297696d6.1
        for <iommu@lists.linux.dev>; Fri, 22 Mar 2024 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711128154; x=1711732954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2AQjZhkcpL+YcTkiIsVz9MRTBhpc8RMyyFuJbdJLXk=;
        b=ZhW7hb8wHG8Jj00w+KWYnQdwoRNhcDyPEnYNbjU9BffYUhqfYLASGQQKykOA7n3Z13
         m48lHWesnjdGSZjzj9H1GQBq0gsK2I7/lBXxLuB53vjLg2REG8T1CSITZ35QT5FUN3xd
         S5hoyhK9xSGIDSPGr0So1SReHx62GxSENVixf7cwfACpmIOeFu9Exj9p+H7FvxdPILBU
         zmHoQi8pFlm3acY5yazNoZhnrOccquiDdEI8qZxMGYAmDM4iwNlcIpT8jCPRk/XTKBLO
         c7ZlIzPYFGjRQQcbDfY8IUYi/IFQjtPoNZj656fCT7T8V7VgL696Vio2DJRMb1lLfdcf
         37cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711128154; x=1711732954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2AQjZhkcpL+YcTkiIsVz9MRTBhpc8RMyyFuJbdJLXk=;
        b=KyVYVYHxUvEOKCglQR/yd/C42Xu2LBKkpd3EdVwHU+jBGevDljQvrQfBaKORGMAyyH
         4tZnMiJ4VxXLBhXzPQqlgoUj7+VqmC/ovJdw/aTrekN45VvK/nRLFnJiQx61yTqRv2Ro
         j7ZBXDqAC5BcEhPOqUkEZi2m/TFE0K9uLSC6I7r9v5kZzRUDSIv92BfA0eK57dEr8bYq
         VakWQwJQ8ZuGSinvyK5++2B5DulJyR14mn6JM7TGxSDj26T45uSzPj5nox5N+7D9vCPT
         FI1TbirJ6jpelxMJCyx9srXPI9TCxvn+jxr4S7BQ9BPT3PALHifP4GDsarh+h+TKFikl
         xx7w==
X-Forwarded-Encrypted: i=1; AJvYcCU8NvBSWxmJ2Rt/83MfFAGBXMg72AmMNZ1+IS4R2QmL9sKVzlSGCdsdCTYg14CYXY+VhkGv75yJpJBMySJcKJ4df53Jfzc=
X-Gm-Message-State: AOJu0YwPhvstgowT1GY2fNU5snA7/FoqCRrZaFwOogRoM9VoasEtyOR5
	FdAFNes3bbL4WzWC8g8ORZl6VrYdril60hh8Qu6jdFTNriaaAkbIEdUYnE21cho=
X-Google-Smtp-Source: AGHT+IFkTNz9gzTcdcg16F0TwV7dxXOkqWGRizUzT+UpEdwSHdcAyu+RuzvoVxcbESzfseuHHEH9Lw==
X-Received: by 2002:a05:6214:1307:b0:690:b479:527e with SMTP id pn7-20020a056214130700b00690b479527emr4829755qvb.13.1711128153820;
        Fri, 22 Mar 2024 10:22:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kl6-20020a056214518600b00691281bf661sm1267511qvb.5.2024.03.22.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:22:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rnibA-00CUem-JS;
	Fri, 22 Mar 2024 14:22:32 -0300
Date: Fri, 22 Mar 2024 14:22:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] iommufd: Add iommufd fault object
Message-ID: <20240322172232.GK66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-5-baolu.lu@linux.intel.com>
 <ad4575588dd247fa8beae60963f36404@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4575588dd247fa8beae60963f36404@huawei.com>

On Wed, Mar 20, 2024 at 04:18:05PM +0000, Shameerali Kolothum Thodi wrote:
> 
> What I have noticed is that,
> -read interface works fine and I can receive struct tiommu_hwpt_pgfault data.
> -But once Guest handles the page faults and returns the page response,
>  the write to fault fd never reaches the kernel. The sequence is like below,
>  
>   sqe = io_uring_get_sqe(ring);
>   io_uring_prep_write(sqe, hwpt->fault_fd, resp, sizeof(*resp), 0);
>   io_uring_sqe_set_data(sqe, resp);
>   io_uring_submit(ring);
>   ret = io_uring_wait_cqe(ring, &cqe); 
>   ....
> Please find the function here[2]
> 
> The above cqe wait never returns and hardware times out without receiving
> page response. My understanding of io_uring default op is that it tries to 
> issue an sqe as non-blocking first. But it looks like the above write sequence
> ends up in kernel poll_wait() as well.Not sure how we can avoid that for
> write.

Ah, right, it is because poll can't be choosy about read/write, it has
to work equally for both directions. iommufd_fault_fops_poll() never
returns EPOLLOUT

It should just always return EPOLLOUT because we don't have any queue
to manage.

Jason
