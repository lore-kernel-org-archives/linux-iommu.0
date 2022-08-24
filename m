Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37B7E
	for <iommu@lists.linux.dev>; Wed, 24 Aug 2022 06:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A68C433D6;
	Wed, 24 Aug 2022 06:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1661324165;
	bh=1jtX6ORxPIkayI4jhfqIZ8SoaBPm8JNXwJB+iwVWy7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYMW9PgshZgadVjDrUNF/ugumlll+uux2YBXEIh2cIdnM7+jadZraebMQwHPcJuHK
	 Atvjs8bLhf6RQVxZkWuLPLni6KsUwiw5Kd9l5dFgaW0BYcVeYBP68TyIuGE4gGM2uy
	 tTnycXxhA9OUlptt4Yr7BH2F4gGNuw/du04aQ100=
Date: Wed, 24 Aug 2022 08:56:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Yu Zhao <yuzhao@google.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 5.19 319/365] swiotlb: panic if nslabs is too small
Message-ID: <YwXLgq94hSd1TTak@kroah.com>
References: <20220823080118.128342613@linuxfoundation.org>
 <20220823080131.532813281@linuxfoundation.org>
 <c49d3b2b-9f5a-4257-9085-f7ac107cff40@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49d3b2b-9f5a-4257-9085-f7ac107cff40@oracle.com>

On Tue, Aug 23, 2022 at 10:25:27AM -0700, Dongli Zhang wrote:
> Adding Robin, Yu and swiotlb list.
> 
> Hi Greg,
> 
> There is an on-going discussion whether to revert this patch, because it breaks
> a corner case in MIPS when many kernel CONFIGs are not enabled (related to PCI
> and device). As a result, MIPS pre-allocates only PAGE_SIZE buffer as swiotlb.
> 
> https://lore.kernel.org/all/20220820012031.1285979-1-yuzhao@google.com/
> 
> However, the core idea of the patch is to panic on purpose if the swiotlb is
> configured with <1MB memory, in order to sync with the remap failure handler in
> swiotlb_init_remap().

Ok, I've dropped it from the 5.19 queue now.  If you want it added to a
future kernel release, just resend it.

thanks,

greg k-h
