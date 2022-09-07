Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FC7E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:46:25 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 165A340712;
	Wed,  7 Sep 2022 10:46:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662540384;
	bh=xg5zndMCisjk/DyTZl08savG+VJ7TAZekV4kt3ao5WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhRcE/lKjEHmeV7IQew6xkVJqqw8XoOjm65ktMxnejXxBk1e3VPwIOqcZTbSu+hBy
	 MamRggV7qGTv6gXXfAv0XNHBLju0oaUIRx/bwNM1N+sSeFYAIC8dF1NTFedfbABCMw
	 LfWHVxCxgi3OxG1/10GDs3BAU5/HzmOZ5Uz4wkAPnbsFmzBfWN1hBaloXJLyH/GJlh
	 a+bU7Gb9p0WPPbYw6SEyPwH+PAlU+sjg/SrG1h+sNaGCIoKG2e0TUu4dKU7OaTyUAX
	 ptI7KIQqVbHYjQg0YSNMgV4QLZ7M2eAoWjxyamcUseotTcOSSgyIwdY28Yww3sET9x
	 2P2hGNLvp+VwA==
Date: Wed, 7 Sep 2022 10:46:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yuan Can <yuancan@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
	baolu.lu@linux.intel.com, jroedel@suse.de, hch@lst.de
Subject: Re: [PATCH -next] iommu: remove comment of dev_has_feat in struct doc
Message-ID: <YxhaXrT0l4xyLRMJ@8bytes.org>
References: <20220815013339.2552-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815013339.2552-1-yuancan@huawei.com>

On Mon, Aug 15, 2022 at 01:33:39AM +0000, Yuan Can wrote:
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
