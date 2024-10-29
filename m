Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278FE20401E
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192708; cv=none; b=S+9IOAaPrh8HqxMZMw+DsNMYj6AzxlDIO16GJXLmGVSPvEtsfTIr5ljr7LDX+Til6rKV1t+OkB8EcFkVSCogLwgRc89rXFAwn+aMH6P7EnxxTd3TEhzDuyZiqPNyPpvxZtZGQTBSgQfdlauzW+RwZnZV4uM+alIHAlBzOvl5h7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192708; c=relaxed/simple;
	bh=eH17U5iBFIa1Xemd4TTLtZPVFnYTiOpDfOaOdchseTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAe4GdJqhnDqndpRwrQ3bmuNDGQQVvanycCRgTbmibtef/NIJSdFCpOfMf1evMnwjWkvig1ux5fgasd5wVgK4u13elFsmR6tKz2Umdqxwjwj/gejkwS2b6RjfWsbx/F3x0+UqS7r08d5i508xMcE5YTLx9jvMEg1r+l0AKQs4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OvqM/nJd; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OvqM/nJd"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E03332A8D55;
	Tue, 29 Oct 2024 10:05:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730192704;
	bh=eH17U5iBFIa1Xemd4TTLtZPVFnYTiOpDfOaOdchseTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvqM/nJdIN4RIHkOZXT/boGA06HOCSNDia/ch0HOAtXn8Y2f0qs+VNfZmWe1TBAab
	 oVrw8Y12u2hz6G2pRm2+fbfog0Xyyw8Bwh1Ur9Q/DHk39e7+PsWkkikajdeualC/LF
	 YlYJmry+Mo9xqehf0SQQHPrxP2pLRtY8hkWLE+4uv+7E1l5c4EuthLdJm1XKEp9hWT
	 W6QbRKp1BqMhVYAcd2/keR64P1dhZT19hc12bvTV3FDumLJx9we3i4sa3/CHwYSOl/
	 UBhUMYyLDlh9RW377Plzn5H6dB5ydJMjC6+NtmRqxOqNEAtW489rnJhMFqXoq7beS+
	 Ps1bL2l7NNtMg==
Date: Tue, 29 Oct 2024 10:05:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	Lyude Paul <lyude@redhat.com>, Beleswar Padhi <b-padhi@ti.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] iommu: Refactoring domain allocation interface
Message-ID: <ZyClPkzekxXKqTFV@8bytes.org>
References: <20241009041147.28391-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009041147.28391-1-baolu.lu@linux.intel.com>

On Wed, Oct 09, 2024 at 12:11:43PM +0800, Lu Baolu wrote:
> Lu Baolu (4):
>   remoteproc: Use iommu_paging_domain_alloc()
>   media: nvidia: tegra: Use iommu_paging_domain_alloc()
>   drm/nouveau/tegra: Use iommu_paging_domain_alloc()
>   iommu: Remove iommu_domain_alloc()
> 
>  include/linux/iommu.h                         |  6 ----
>  .../drm/nouveau/nvkm/engine/device/tegra.c    |  4 +--
>  drivers/iommu/iommu.c                         | 36 -------------------
>  .../media/platform/nvidia/tegra-vde/iommu.c   |  7 ++--
>  drivers/remoteproc/remoteproc_core.c          |  6 ++--
>  5 files changed, 9 insertions(+), 50 deletions(-)

Applied, thanks.
