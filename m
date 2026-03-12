Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9201A23B1
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318142; cv=none; b=irCkWAUQqLgYGwqdGS/vVkQ4jxl2Z06Ivu/d/8F8rc5AlUHAFDY1sdH9DnNlpEb8LSoqVbewuhlgYc/eSgegCmvU8hRdgORSL3K6xi93DrjlHe6nKbx3cT1hVqMfHPFanLdinJBwvgEJnOQ90NqLhdgzhD00fQVqDwjb2VA1yYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318142; c=relaxed/simple;
	bh=CIqUqdezJUt7fx005uAPCwnbutghZRMPmBs/ZUdJIEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLGuBU7DF/C3bkI9fch/nkVGwpjT+LStKxvYLRRQDxWYWElwa1RyHUd/cF7EXqYkSQJSllrH/If4JkHJhMvttYDgBqz4gJ1w6zXhZWpOTlqEIpH4Y9q2rVIoxtDUmLe4SvM3/K8LkNn5TBQjjDLbAJbTMxFNSjHFBgKz6QwjZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ProU09kI; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ProU09kI"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-899a9f445cbso12827646d6.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318140; x=1773922940; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TimmS2+Pbosg7L15RHI5hJFu+i/J4kMKaqKEQ2F4CiA=;
        b=ProU09kI1HwtFJ8oM/YKBTeZAhMs6rOS45RdaOFt2g5i1bWCFw/PI57frqywept9oW
         LA+hkkUwNli6s3kXhq4fnup4bBWLjB3o/3CmnRiA5M2BB8E68x3Ml7Cv0srn7oR/2qX6
         GcmLmJjYSooRyygr+ub+MXW1zE/d2s1GZwUTYkvb2RTbcdE0UxENxiK3DU1Zvi/C+VZr
         OqyWaiPSScFPWjzBYUb65bFZ5ntcgQdgoBpXepijHQ3uv9J4gSENSLAVuG1ZgQMYiZ5a
         sKnFxxrHahMoAMHBxVdXaGAQpDtaRDdpewrP9haIbvYb4P7GVb+IeW5Lp34voODAFYal
         xahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318140; x=1773922940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TimmS2+Pbosg7L15RHI5hJFu+i/J4kMKaqKEQ2F4CiA=;
        b=kp55StgjzR57zRq4iJcNFXeqf70ugaPtVz1NVzuu5raJY0hQa/dNPGdCxJ6lch34BD
         9cf8XP8bFbm7vNfsuF1Ax2ASQXY0LHZ9sw7A49eCO9KfeprEH1U9d2MoazCBNYkxaYpV
         7QfllpmPuVshQC5h5GHeX1k36d1fC/z9itiRZxgK1Rel714JeuFsMHg4h+2/NYVyBnmk
         FcSspwVo6wy2ZtKUi5IiQpdyIEjMqDt8DH2QQ03UMyG9bZOcH1eX5VfLl/JP/pQGtngr
         Kgm5JZTACqrBpCKkUtbtY/GUrL+Eo96mVgRqeZfOtGVyKWwVVja9bjLwGcrDo4sm8Ft8
         yMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE1204P+9GgHgb5uPumTyGOAo64D2IhUrCgydhML8OJ5GtCrjc0vWhzny5mdLGI9nEfPk8AQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWtRylJz8DW8xNKreCB26DvB7qzF006aODcgog6avNV9AavEHQ
	wzSUHiUm/nKWsdC7rVS8727qRZv1/3CeO1W1ghNsrx3zNaHXxHEdz8IttI1iIeblrn8=
X-Gm-Gg: ATEYQzxWbb1cE35Clnft8wi0ksnT6wUDlv6Zs2W95kYnVCVKR+JqkscA6DfEt0RRyTF
	RXCpUiNDURqTW74gR0wEyMSGvAGNnRKb9UWmo5BdzQf1hL8aRyZRe4XjNq0XbF31UXvpedDG5vC
	Dz+squPnaDt7PYcyeCeROLZ5uCFWdomCPQi0YQu0it/2o3TrD484rT+9KF7ro1binbQLQizxSYi
	jAfw/svtInWC0jVmVUuMg1xCV1XvxsUyFe6Aef3PTAvnsHPkz0TRjTTKO7wQkm1q6T9DBgRBwPW
	uKaEEv0YKpnRqKKFTXjBlfQ67+DoELUomDPkPytv3nIepBZX4jlOtDwHGvfh3K+ks1cvxktocQ0
	hN4ykBOe/yvQ/b6lnPVq34twU6GVxzCZ8Qj0wJFiKYMEuEyo/BP4kKhyo1Zb/bx/ZKaK1rPlRnK
	zHixEjhL1Elg8mltc62/wcLAyPpvTGOsOOHOMpmTkWot4/IRo1w/x+G3Svc3VNGw5dmWuloXfCu
	3vlNyYC
X-Received: by 2002:ad4:5aeb:0:b0:89a:149:bef8 with SMTP id 6a1803df08f44-89a66ab8864mr83684736d6.47.1773318140521;
        Thu, 12 Mar 2026 05:22:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfd520sm33832386d6.36.2026.03.12.05.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:22:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f3S-00000006euK-0fs1;
	Thu, 12 Mar 2026 09:22:18 -0300
Date: Thu, 12 Mar 2026 09:22:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 7/8] RDMA/umem: Tell DMA mapping that UMEM requires
 coherency
Message-ID: <20260312122218.GF1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-7-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:50PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The RDMA subsystem exposes DMA regions through the verbs interface, which
> assumes a coherent system. Use the DMA_ATTR_REQUIRE_COHERENCE attribute to
> ensure coherency and avoid taking the SWIOTLB path.
> 
> In addition, a given region may be exported multiple times, which will trigger
> warnings about cacheline overlaps. These warnings are suppressed when using
> the new attribute.
 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
