Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B78C0F
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B1C433EF;
	Thu, 20 Apr 2023 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682004845;
	bh=0y0Ubgtd9eSBFBi02w7YnupFRElY3P46GHl24SGnCSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HORgfkbdYTrc35iWTzz7bH0VNyce/zGNZFbZu0SMqL/wgPhM2UgZ+/CHJOtjFHkwf
	 9pMPViUiR3i1UDEi7qiYFDMTErPvPjtbcc8bERptlRslOmhA3n1yMeTk8u5SBPHQyd
	 93SXTqCC/WTwkO5IR2n9Yt7UuPr8eODvHB9CGL6BZ4FymZhZt0HuDFaAMzn2wfALEY
	 vXs8F39gNfTHnI5ZWodfD056DFuxeECB0XB7KoAE1CKtnJ1Hx7b9i+0M9GS+oCWksj
	 wLO4kq6XL618O192Zt/kI0/54sA7RhCWiAsYhKjCDw5LkvlSxGR4sTSvB2YQOE4d5G
	 TTP7IYvYx4CUA==
Date: Thu, 20 Apr 2023 09:34:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH] nvme: clamp max_hw_sectors based on DMA optimized
 limitation
Message-ID: <ZEFba1hoBM5U+VU3@kbusch-mbp.dhcp.thefacebook.com>
References: <20230420130155.19281-1-adrianhuang0701@gmail.com>
 <ZEFaWnF+b87i91o/@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEFaWnF+b87i91o/@kbusch-mbp.dhcp.thefacebook.com>

On Thu, Apr 20, 2023 at 09:29:30AM -0600, Keith Busch wrote:
>  	struct nvme_dev *dev;
>  	int ret = -ENOMEM;
>  
> +	/*
> +	 * Limit the max command size to prevent iod->sg allocations going
> +	 * over a single page.
> +	 */
> +	size_t max_bytes = NVME_MAX_KB_SZ;

Oops, the above should say 'NVME_MAX_KB_SZ * 1024;'.
