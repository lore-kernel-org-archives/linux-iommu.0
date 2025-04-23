Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD00280A35
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431343; cv=none; b=VsQk0fwLmlTWyXnB5gh1HSeHFxkG/Ii21QU/28R02yjvNDbrhJYv5yeZqrSSyhCMnifVp+6M2ZrwY7a9hJT3Dryp1HnHeiGDLq4/u+W/qYopCCRDaZx6DklV3NvtDe7RP8IBJDL7XtIDfPIBNPs6s6a3GKGb18klKFCe9Q9VpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431343; c=relaxed/simple;
	bh=jMGBnlKKS3wriE0M2t3GS1b7w0yLhTPXvhMeTWbbHrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdONRS+ZJSZ2zk6COyZSxE2ZoaElQhK370dSgF/Mc99josyY97G+Q4mr5d/JT+mmN0+LnC5uS8cV3mnGzC2m4SvkSgj2Kqp3OY65oT0lZGnUbgPPxWUPVoQwcXdAeOHyGb5RGaLz3G5tNr7QbzsOZvJNRdrgIdcltj26uWCvK3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XnCsjVw6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XnCsjVw6"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6eeb7589db4so2217606d6.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745431340; x=1746036140; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/H5CAwHQKAGhhgyjSbvaHcVayhHkcFdusJoJuYFxH8=;
        b=XnCsjVw6EX9u3UYVigG9xMhbgftcagbiLKYMLha19QKVNKvQpqJVF4OnYJgNiQKoEo
         //dOe4tNzCV7F+XJZ+532CAWRFAYpWDPiFQSNvY9edP3Yx6UBclTSOeC963GCG7mmanN
         h039ePjC+dS7WR0wqS20bFuLrjpsbxoE4lOsm3cYOMiO3UsL8WUygGsM0+oY4W4nMeid
         U5nPu86kBICu0rFrKUvm405REWlZDsPGOxNfKc+ocoD07LfpjUdawUcwUzDUW4aM8bFv
         902aFpyA6Lh8D5Z7MKIrlpR1/VH5ieczhe0dPmh0iLjMFSyo2NmxosW9U0jm+myBVm1V
         AaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431340; x=1746036140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/H5CAwHQKAGhhgyjSbvaHcVayhHkcFdusJoJuYFxH8=;
        b=E/8zsnnGGiYb3l1n2WkKQANrUbFYbLCztKXdPz/G40+e5tAdmrtPn2zmz1/THaiSEy
         0staUyhx9fo7k41Za3U3N1cofg8uGmoR/Xkn1uiWnBLRNmJSjzAOvGRzQxnJkuxDMzJ/
         b6jLUuSfsurgOe4rt6UoFfHIG5dB79N6YLVv1STg/x77fICV947wFKGCwOyoO59F88z1
         fSLxKA5KYPNtx5dVe1NwPIjtowgEGn1G7sX6ZQSa/RTJyJH0OkrtSsTltETmdX+illpD
         tGJXOWlpKPxaZy56h2UeQfVCLhgjCZaX/PdBipH+AS0W2HgSEM3dynrQewQM9MbcfjAY
         OsTw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPcsXVf7xDu/jOsb36K12i1vGiDbWUvEZKx+nezcFIDBRpfxAxm8pJ10jPiun7gDeOrLy2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YydELsofVSs362yDcjyAnazsC27ckxPa/c8XZ5GU0I9H+QvISk/
	lduVZEaFqWmBxzHqyFxGghXeztocpLhI7JoV3+YlA1MtwI4hq1GpYqNJFl5XL4g=
X-Gm-Gg: ASbGnctzAZ5DJF2uRSlyDBAnRxLkXwcnl5usAZHKC2IfQ2iJ852cQNz+B2Da/HXrlpA
	XHKxxrdnpJajR7L9IB5R6NqkB4WmdUxf7InVKe3qX1QmVQW2/0qT45nh39exLiGOs3QimOGJTrQ
	u8KWMuNMSSTonR6S/Z1u+/wgtSW+diFhkIGIOhrQX4oVwooqRvZVzVSu3CQdw+ehquYLBxMyuRv
	ct/zehVWCUICxUHeEHh7/km69gt9w7HfxPapMvk7vxpMcCqllcxhkl9LRe28Itz/vCaIMaGr1Qm
	MYYRMw788GsB3GKdhRPFkAwMdQzlq74RmWKQZ2ydTdReucsdgAb1QvDAR5CVHt4J2U6QjW/xLYS
	2RhEJqGDtFFMPVnyQYFE=
X-Google-Smtp-Source: AGHT+IHxXzsMEe6MN5UQygppndiI4ddaFnTKWUy8FtozhFzNSVoZsB8f3DMDl3MfRyMHEIrbMun+Mw==
X-Received: by 2002:a05:6214:19c8:b0:6ee:ba58:e099 with SMTP id 6a1803df08f44-6f2c454e522mr330593466d6.15.1745431340219;
        Wed, 23 Apr 2025 11:02:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c3ba3fsm73300796d6.125.2025.04.23.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:02:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eQN-00000007LrM-0sGN;
	Wed, 23 Apr 2025 15:02:19 -0300
Date: Wed, 23 Apr 2025 15:02:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 16/24] vfio/mlx5: Rewrite create mkey flow to allow
 better code reuse
Message-ID: <20250423180219.GR1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <eefe5ad450fd434dff981963ec3c61df7b3734e1.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefe5ad450fd434dff981963ec3c61df7b3734e1.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:07AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Change the creation of mkey to be performed in multiple steps:
> data allocation, DMA setup and actual call to HW to create that mkey.
> 
> In this new flow, the whole input to MKEY command is saved to eliminate
> the need to keep array of pointers for DMA addresses for receive list
> and in the future patches for send list too.
> 
> In addition to memory size reduce and elimination of unnecessary data
> movements to set MKEY input, the code is prepared for future reuse.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c | 157 ++++++++++++++++++++----------------
>  drivers/vfio/pci/mlx5/cmd.h |   4 +-
>  2 files changed, 91 insertions(+), 70 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
