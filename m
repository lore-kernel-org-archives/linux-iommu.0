Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BE1AED39;
	Thu,  4 Jul 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102751; cv=none; b=I6QYp/eTJ6VTvkpTq4StUw95ZBJZn0F9dGMOYR45kFRLovpH1hwP+8HNLDNovNGBEp70aO39YT4RXPuOEq+2NBX6u6HMMj3dMgRGp/57JFWYkDiQcaWDDD4zgxpCSu8Mv2H6Qxk3lrhtHnDjIbpRo8YhjdChMl2aNvjJXbWE+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102751; c=relaxed/simple;
	bh=4TqqG+6gW7sExbSc1fa3XwDb/nyy6iV4f8aqglDYIS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clucMDup7ZYHwBMHUJ3Pp/gcI9q7pzoBFCD0+46xTJf/cPid2sdHgYWsw9bqpag5fDskXjmwoa4MNByXWttJSrVXkqkXk4rCnGhnUc8aLw6PVXgCZsijIjGzAbzuh/sy9yxZ8XagtDB9TJ5geCJ7uaq66pImJrcQEiv6TQ4pmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGcZvGhp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGcZvGhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FC1C3277B;
	Thu,  4 Jul 2024 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102749;
	bh=4TqqG+6gW7sExbSc1fa3XwDb/nyy6iV4f8aqglDYIS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mGcZvGhpiCFJxCg5MFKIgFwN0DjdrJzgg305KWBMNwcvSwheMjvg2+DMCwiYNlRMO
	 8wezWa3GlSRKqZtHGmERCrSRGBJ7pGKpwlngEspfCif86OY6EUt2SN4ESIwkpoI1VD
	 0+REjFXfs2ImiHANv2CM91Ic4PxkUsiM8vAotyUD4n5VFHBc7yF9Pk6GszNM3DJ5ja
	 egCGJEAu8lAySsVBZQty5h/GV+K+e1XfbRo+0eQuJSDfEuezuPY129BrwhnhCxMSYa
	 Akmrv0zLO4CTeVBxV12AT1rIF0Vcztq/kposhNyOyzGaIk+p7v/NR85DQeOJrtgVcv
	 4QZx3A5e/eFQA==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
Date: Thu,  4 Jul 2024 15:18:56 +0100
Message-Id: <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240610085555.88197-1-baolu.lu@linux.intel.com>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 10 Jun 2024 16:55:34 +0800, Lu Baolu wrote:
> The IOMMU subsystem has undergone some changes, including the removal
> of iommu_ops from the bus structure. Consequently, the existing domain
> allocation interface, which relies on a bus type argument, is no longer
> relevant:
> 
>     struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> 
> [...]

Applied a few of these to iommu (iommufd/paging-domain-alloc), thanks!

[01/21] iommu: Add iommu_paging_domain_alloc() interface
        https://git.kernel.org/iommu/c/a27bf2743cb8
[02/21] iommufd: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/26a581606fab
[03/21] vfio/type1: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/60ffc4501722
[04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/9c159f6de1ae
[05/21] drm/msm: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/45acf35af200

[10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/d5b7485588df
[11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/ef50d41fbf1c

[14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
        https://git.kernel.org/iommu/c/3b10f25704be
[15/21] iommu/vt-d: Add helper to allocate paging domain
        https://git.kernel.org/iommu/c/9e9ba576c259

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
