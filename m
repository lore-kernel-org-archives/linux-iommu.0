Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B110A28
	for <iommu@lists.linux.dev>; Fri, 15 Dec 2023 08:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kX6Xr/82"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4F7AB1A230B;
	Fri, 15 Dec 2023 09:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702627493;
	bh=OEc02SFKyf0odkc4ajBNDpPdVcH6NRl4SOvhSR6cgYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX6Xr/82aVOXzjWE7WPTvlnwdtaALlR3lsRl2YBvjIaADja8Qs2keokoS9PRfl5e2
	 t6hfsoT6Yryb7TvAR6oZcsJVMKkVsbiSImJsezfrEZQkbfMDMtA5XxdEuNREi81L1H
	 vshCvTonthhUS7pAo2qj8m4ohl5T/ZhpYSJPPi+Y3Tv0YbXoheeQZl36A8HdMuH1c3
	 wzT3B40PzC53B2RTljiWCGskMXtFJZJpE9laKiO6eDHFnX/wTMXtZvNpXxvVTffusk
	 nW73GlL54ncrGMIBMA9Ll4apTnFtF+tRCa1sYSqpOCW8DUrSAZKpGL7Prf+KDX6Apx
	 lfMy5gBKY5axg==
Date: Fri, 15 Dec 2023 09:04:52 +0100
From: Joerg Roedel <joro@8bytes.org>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Tom Murphy <murphyt7@tcd.ie>, Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	kernel-team@android.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/dma: Trace bounce buffer usage when mapping
 buffers
Message-ID: <ZXwIpBoKpg3vVQvt@8bytes.org>
References: <20231208234141.2356157-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234141.2356157-1-isaacmanjarres@google.com>

On Fri, Dec 08, 2023 at 03:41:40PM -0800, Isaac J. Manjarres wrote:
>  drivers/iommu/dma-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
