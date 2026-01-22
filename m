Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C8434AB16;
	Thu, 22 Jan 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069923; cv=none; b=f0V+CZbIMI5s/NNmhxw/gnf9auCAAbf6BB3qgCxPAjOQbQYLKkeiYKSIF0hcv2wy6T4bxCjbyuBlXfWzi8+ANhKUybxtMpQoPUMgC6T7ax9Gs6g4fgdsD+e6+rgammDdzWpiBkEhxUNUHvvAoegPHbfJZJIs2G5C6XcZbjP5zrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069923; c=relaxed/simple;
	bh=7CIJ7TMjYpB8LpC3GI/NHJut7LLEZIAawxgiBGDf2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skYSVwpFp51WIqu8PIYZHiuqW14c+lNqSmgnVma7dEXD2ZXHtewpY5n0wtqXQfctiY+PpDrrZIGm1exVXkmNwlq2X67RStx0hk7ursHsWHgrvEYj3JxUqptBpyxc9bu0GAXbeEXzFHzKA1WtNQb13oITidk7xLV9YCIWC9q1w8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=PvMWY5uf; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PvMWY5uf"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0012B1C03FC;
	Thu, 22 Jan 2026 09:18:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769069920;
	bh=7CIJ7TMjYpB8LpC3GI/NHJut7LLEZIAawxgiBGDf2Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PvMWY5ufBPgoOXsVdUw8Vj0CniCI9dAvxLDn4lDpuXmCKwHf2Gc0icqZELzs5/bxF
	 hNLma+GYNrjzkPOB2Qi4+AsUIA14s87i2YIrIns6zc4PhvuV2MRETKhUZppOhAc+ZO
	 QGhIF9P8a4rD10CKsr/W1YkuraSl0HsyvSmpxqlG2GQMDNQAFqIbyjiclWtBAR7EBY
	 rwJVIzSjmh5iHWabfQ7oKB0IW2zjK9M184vYXLOwjmqd4/Z2zhJpdOFOGEe0Bw4xGJ
	 PUWjW1bFZxAX6H9BTIBQAsDq7KiGmJLoJoO7pCJbKEBPMHsAltRtUIfPrAsN/CBAPq
	 YvZDKQkPYin5g==
Date: Thu, 22 Jan 2026 09:18:38 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org, 
	will@kernel.org, robin.murphy@arm.com, robin.clark@oss.qualcomm.com, 
	hanguidong02@gmail.com, quic_c_gdjako@quicinc.com, dmitry.baryshkov@oss.qualcomm.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
Message-ID: <mo5v74ryxfwik4ggr56c2xha34sfwq2kq6suxi65pbqxrdppnj@oqkirr2kgrey>
References: <20260121141215.29658-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121141215.29658-1-dakr@kernel.org>

On Wed, Jan 21, 2026 at 03:12:01PM +0100, Danilo Krummrich wrote:
> Commit 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in
> qcom_smmu_impl_init") intended to also probe the TBU driver when
> CONFIG_ARM_SMMU_QCOM_DEBUG is disabled, but also moved the corresponding
> platform_driver_register() call into qcom_smmu_impl_init() which is
> called from arm_smmu_device_probe().
> 
> However, it neither makes sense to register drivers from probe()
> callbacks of other drivers, nor does the driver core allow registering
> drivers with a device lock already being held.
> 
> The latter was revealed by commit dc23806a7c47 ("driver core: enforce
> device_lock for driver_match_device()") leading to a deadlock condition
> described in [1].
> 
> Additionally, it was noted by Robin that the current approach is
> potentially racy with async probe [2].
> 
> Hence, fix this by registering the qcom_smmu_tbu_driver from
> module_init(). Unfortunately, due to the vendoring of the driver, this
> requires an indirection through arm-smmu-impl.c.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/7ae38e31-ef31-43ad-9106-7c76ea0e8596@sirena.org.uk/
> Link: https://lore.kernel.org/lkml/DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/0c0d3707-9ea5-44f9-88a1-a65c62e3df8d@arm.com/ [2]
> Fixes: dc23806a7c47 ("driver core: enforce device_lock for driver_match_device()")
> Fixes: 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in qcom_smmu_impl_init")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Joerg Roedel <joerg.roedel@amd.com>

This patch should go via the branch that contains

	dc23806a7c47 ("driver core: enforce device_lock for driver_match_device()").
	
Otherwise we add a Fixes tag pointing to a commit which comes later in the git
history.


-Joerg

