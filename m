Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607D3203B0
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370328; cv=none; b=kO25NyQgU2mtjpqgOkafqAk0xle08XnWJmtpyTd9m/bxAlg6w2qTtfK3nQBjPBQ/pjEo24i3lfFpcTEathjHmM6dPcWngSOy1LqrSCQALwKOulvUvMHPnDPme7IFcK4vUwnoifPeeCohPUzTyNN4Z60hL22xaIy5g8VO8RJthxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370328; c=relaxed/simple;
	bh=ypIINiK+VTHnxnm4nmJ6is1n/6oSzGudvIzGb33OHjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z48o0MhepjRCRKavuLt5yGNMnWS17MVH0zHUDz2J3HQ4vgvGPb9zu2B2YaIjUJF4I6JTfk03GRxhWUWtuQf11EH4U75G1d6/RP708Z78A84MoRb/OYWv9d+ELL0CtUc6oQDNBrdF2vQix3GMkJUCvCpPH5AwQUBRWci3C+Rsy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=0YJ8mkzX; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="0YJ8mkzX"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 03BB85A704;
	Mon, 17 Nov 2025 10:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763370325;
	bh=ypIINiK+VTHnxnm4nmJ6is1n/6oSzGudvIzGb33OHjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0YJ8mkzXWfj7CQfHvG3jnNET9R93xHvh3eVa9v0dcdaDjgkZZmEQxTd7XqPYbdCuA
	 V8bfq1mKiklRJ3Bo4ZT5e/191SawMXa0iVFcnnnPhYidi9Ms1eB2L8IuvLGzQR19cp
	 jQKdo4dvuBki9vS3UZ7IsKP6hmtYcNgKi59gWwUKcP7jHlKNNHmPH+dko0Vln6xQeE
	 Di7bo459aJ8X7yCBRST9v6yXBJPWgsyjy1qJ0UV6iL4dRxtdj1OuXl1gVCvnyPUIEM
	 jXfwA7KG/QEWIl+d77bfurfNwSzb2G2gFNBIDKdzvpYD4pNMOkufbyMfZLtvS9FdeS
	 FpHLXKHEi8pPg==
Date: Mon, 17 Nov 2025 10:05:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Johan Hovold <johan@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] iommu: fix device leaks
Message-ID: <3l7ushv4ecobwqrdxcvkvaomv65ce2oyty7gpectln23jp2dtg@kkrjj5oig2cy>
References: <20251020045318.30690-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020045318.30690-1-johan@kernel.org>

On Mon, Oct 20, 2025 at 06:53:04AM +0200, Johan Hovold wrote:
> This series fixes device leaks in the iommu drivers, which pretty
> consistently failed to drop the reference taken by
> of_find_device_by_node() when looking up iommu platform devices.
> 
> Included are also a couple of related cleanups.
> 
> Johan
> 
> 
> Changes in v3
>  - fix mediatek use-after-free on probe deferral
>  - add acks and reviewed-bys from Marek, Yong and Thierry
> 
> Changes in v2
>  - drop omap reference sooner; remove unused pointer
>   - amend exynos commit message with reference to partial fix
>    - amend tegra commit message with reference to partial fix
>     - add Robin's ack
> 
> 
> Johan Hovold (14):
>   iommu/apple-dart: fix device leak on of_xlate()
>   iommu/qcom: fix device leak on of_xlate()
>   iommu/exynos: fix device leak on of_xlate()
>   iommu/ipmmu-vmsa: fix device leak on of_xlate()
>   iommu/mediatek: fix device leak on of_xlate()
>   iommu/mediatek: fix use-after-free on probe deferral
>   iommu/mediatek: simplify dt parsing error handling
>   iommu/mediatek-v1: fix device leak on probe_device()
>   iommu/mediatek-v1: fix device leaks on probe()
>   iommu/mediatek-v1: add missing larb count sanity check
>   iommu/omap: fix device leaks on probe_device()
>   iommu/omap: simplify probe_device() error handling
>   iommu/sun50i: fix device leak on of_xlate()
>   iommu/tegra: fix device leak on probe_device()
> 
>  drivers/iommu/apple-dart.c              |  2 ++
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 +++-----
>  drivers/iommu/exynos-iommu.c            |  9 +++----
>  drivers/iommu/ipmmu-vmsa.c              |  2 ++
>  drivers/iommu/mtk_iommu.c               | 34 +++++++++++++++++--------
>  drivers/iommu/mtk_iommu_v1.c            | 28 ++++++++++++++++----
>  drivers/iommu/omap-iommu.c              |  7 ++---
>  drivers/iommu/omap-iommu.h              |  2 --
>  drivers/iommu/sun50i-iommu.c            |  2 ++
>  drivers/iommu/tegra-smmu.c              |  5 ++--
>  10 files changed, 63 insertions(+), 38 deletions(-)

Applied, thanks.
