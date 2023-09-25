Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF211C96
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 10:42:25 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8AF861A225B;
	Mon, 25 Sep 2023 12:42:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695638544;
	bh=Wj3DQSLYtpmrxBqIe7Uuolk9CGT9XxdIxMMVCt4KJWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjZ7KAkdXVEZmaLaorS88E6H3fK3TkIRz1T4S2iE0oY3ych/lBmvkTfJ+POMWZNhT
	 35vDD+YEVtF4GdysmdwblXHlqp/B2Vx+eZ6DI7vas+EEcwkEQaC8/0QjKCyE4Mpuw9
	 HNqmrK0Ye6qIGovEob55rCK6hHwu39idIrUr2gkKPl8Y/m/qNmVbfhtO3m+FaMtBQk
	 hznJ2CjpMz8bYqp1AJuMgSuSA2TK/z9OmZjtwWgAKR6RxnZOv3Xyh12/uvA/Ub38Xk
	 T6WgwC5uHuh7XWnBprExmc5CFdfzXa0spG+Gq6RgJKcsB3hOikkrBRfzPAG+f1iDNS
	 himdwi5cAfnjA==
Date: Mon, 25 Sep 2023 12:42:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
	baolu.lu@linux.intel.com, Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] iommu/tegra-smmu: Drop unnecessary error check for
 for debugfs_create_dir()
Message-ID: <ZRFkD2eq56uGqH7R@8bytes.org>
References: <20230901073056.1364755-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901073056.1364755-1-ruanjinjie@huawei.com>

On Fri, Sep 01, 2023 at 03:30:56PM +0800, Jinjie Ruan wrote:
>  drivers/iommu/tegra-smmu.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.
