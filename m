Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D535183CA6;
	Tue, 13 Aug 2024 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543135; cv=none; b=MajCh7BLg0zKo/HPPF20+XVV2HEN+HjeX9vLnxxSIgY16/4+wOqTUgAHvX11Hzl4SvXTeJsQPSRUXA/+1JO3aTBLt9FyXNnIbYph4cA7zj/5yhmDpD6Wb5rdacVTt3AYxPulNjL/C3mR+0tYPrdfO1pMedn/RRXLJpk3NKRr8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543135; c=relaxed/simple;
	bh=Lw8CahXCDTaL5yyR0GiF61FLObnrlbhn5LVatwodznc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFkkRNpz5hoHSM3cjyhWtcUGr3w0TjDDTznRM28d1kzEjFm6g9WfbxKBmAqwXivkWdwIwUKfzr8L/bxcwLsoSWE7ML4Ld8I/eoA46qq+UvyLJHXYrzs6A10GtjVcKDvIIHhZBUXhdS3MS+3r5GFh8k/ZEqcDc9XQDJhcL0v4Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/z6yAq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/z6yAq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3231EC4AF0B;
	Tue, 13 Aug 2024 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723543134;
	bh=Lw8CahXCDTaL5yyR0GiF61FLObnrlbhn5LVatwodznc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/z6yAq1WMVIBm22fwOInT5eFmkxz5Y7UWaE2qYEd/IlzBqrDqyeAKnE8kjAB8vbF
	 n7FzVAnjXtWN8kQi+ThF5Cpyit6YXsPH2/ijuIlRTuPScXPqYMbm9gkkhFuaS2SS1m
	 L5dYzafNqogVrJrop5Ov4YG9TpJmSJ9tq5sF2eNo=
Date: Tue, 13 Aug 2024 11:58:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
Subject: Re: [PATCH v4 0/2] DMA IOMMU static calls
Message-ID: <2024081330-dismiss-unsealed-0f21@gregkh>
References: <cover.1721818168.git.leon@kernel.org>
 <20240805122050.GA480973@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805122050.GA480973@unreal>

On Mon, Aug 05, 2024 at 03:20:50PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 24, 2024 at 09:04:47PM +0300, Leon Romanovsky wrote:
> 
> <...>
> 
> > Leon Romanovsky (2):
> >   dma: call unconditionally to unmap_page and unmap_sg callbacks
> >   dma: add IOMMU static calls with clear default ops
> > 
> >  MAINTAINERS                 |   1 +
> >  drivers/iommu/Kconfig       |   2 +-
> >  drivers/iommu/dma-iommu.c   | 121 ++++++++++----------------
> >  drivers/iommu/intel/Kconfig |   1 -
> >  include/linux/device.h      |   5 ++
> 
> Greg,
> 
> Can you please ack the change in the include/linux/device.h file?

I thought we were trying to get away from adding iommu stuff to struct
device, but oh well :(

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
