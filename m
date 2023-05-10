Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A363D60
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 18:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA1C433D2;
	Wed, 10 May 2023 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683742932;
	bh=N/BoGk2dK/WsdrxH9VOAyg5YKhSgV6KBcZoP0C48qzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyYZGV0GAmZgwtS777c6bVS3xjvlwVKxWJdPWDo1lkSlaTrO1i721JfvZLrPqZmmw
	 mXv0waCgeLnDckU71bTU+sMXI8aBN7HnW1vAiWO0E02zEm/4FUlKPQMy9tJNk9nhRC
	 qEOO3Pmo0fxKBqNX0BzV6whoXMDjktLv6dKVq7jozi0ITTJsJHpQWSD/DwOapRrxUp
	 vjRGQhdUt5dxg6gzudoqfGzWFZXv/JC1LDm56PPeW0j1cETfBcMPI6oC9NgH9wyH2D
	 820Aet3NaNJ/tw2RNE1eCvrJEDZYO7pXRV+U03aNhQjEkwaIA5/mEwKCYvKuuCqiKV
	 C5If3bQzmlGmg==
Date: Wed, 10 May 2023 11:22:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Adrian Huang <adrianhuang0701@gmail.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, iommu@lists.linux.dev,
	Jiwei Sun <sunjw10@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
Message-ID: <ZFvgz5VgVGEmyAuj@kbusch-mbp.dhcp.thefacebook.com>
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
 <20230503161759.GA1614@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503161759.GA1614@lst.de>

On Wed, May 03, 2023 at 06:17:59PM +0200, Christoph Hellwig wrote:
> dma_opt_mapping_size falls back to and is bound by dma_max_mapping_size.
> So I think we could just do this:

Thanks for discoverying this even futher simplifaction. This looks good
to me.

Adrian, are you okay with the suggestion?

> @@ -2956,7 +2956,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
>  	 * over a single page.
>  	 */
>  	dev->ctrl.max_hw_sectors = min_t(u32,
> -		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(&pdev->dev) >> 9);
> +		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
>  	dev->ctrl.max_segments = NVME_MAX_SEGS;
>  
>  	/*
