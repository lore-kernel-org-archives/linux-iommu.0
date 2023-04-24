Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A127E9
	for <iommu@lists.linux.dev>; Mon, 24 Apr 2023 16:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D466C433D2;
	Mon, 24 Apr 2023 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682354261;
	bh=f0tQJ3C9w8njZRPMSk5toxWyDDKhAtvSqcBeGFZA8O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLna5VHw30LjdqRGKVJdHLEdhCNwr113Y7C/AeJVJmVqqFC5gFnEawbOWfb7ZLlTj
	 0clQgbJDgAHYt0n98jEQDaUwnBG3urPNXAWShmBERJNfwa6pUy1AOrcg2Ng+bIAlvG
	 rNhwgDKMLquXbm97QM1ehFpTf8C2fqE0iz8iNQUJYaB86lVPz2KLjpytMjzG12HDmV
	 gCUMB73e0pg0IbZrwWwDBV6fy7BByWuhEA4cwNm8XaK9q6QKxCDbW51pMa3iBcE3t3
	 B56aLfd9kcsec5GBmPGvDu524PeozK8YwUKnKFC6gLqOggHYV35cEN8ZD2I/cdjXzv
	 bK0fJRUAkIQ2A==
Date: Mon, 24 Apr 2023 10:37:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	iommu@lists.linux.dev, Jiwei Sun <sunjw10@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation
Message-ID: <ZEawUwOBMkibGybW@kbusch-mbp.dhcp.thefacebook.com>
References: <20230421080800.18837-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421080800.18837-1-adrianhuang0701@gmail.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
