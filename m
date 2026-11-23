Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425532;
	b=0ZRKjdCtIGSsUThGfmBASMCR4ShviPTM4RKHLJf6arGdnKQ7xjwSt2EezR4N+pokoB4t
	 cj5W883nKykWWjU2fpD4ARw8yuUV/DeWRLfnriQ1TvKx52IlhoBPB3vIATRE69VJzHpl5
	 VHUDtFVtKUiGbv+pGOdWSnkQJf6J34dTW640csI4NV/7aMViw+kZSpo3uek6/KWpRsM+A
	 xOTygyiDnJAYkl2fT2rMRMG9p0ZXAEKxcGM0y25oYNslAqG17U/65eNk32S+hSwTseI0R
	 5LjzPDnSpDk+7ki8Jlxs40NY/E1SxlMFEbNdxBXVUzPcKBRX5LXhnHKSK+FEUiKt+Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425532;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dqE/KOb627CRmOK+uhuP8OssUSJk2WW8/Qlivr//l+A=;
	b=A4Fs6iTVShdyHYmEUj59Y4imAKhMKF8JYkYEkApHeHGbQvq2Gmku7z51LWOQ+3LcjCRu
	 Wu+a2tx26jTXlkrJGZdGKIX/1EK0JokVT3Pz49MLp9UDUboVDyPWb5kLyUwcsSM8odbSp
	 PIMONcSX6/wAw0pfzXAeRbyUENqq8ChBx6tXnTaePxjfN9tPaKeosFWz45VMfmW+n5Lt/
	 jiM2tLu8lEFOclaVqaVLEMHDerPCCzrmMpH8M3woKf3nrpFteAxLvifdYdC61/013b/Jy
	 wRD/JwTtsJ4w2jvoLxn56A9P8vjyygPTu13v6Se/vvbRtdxG9zKySI/SJSPJTre8kfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FED7606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FED7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3E0042436B3;
	Mon, 23 Nov 2026 10:18:50 +0100 (CET)
Date: Mon, 23 Nov 2026 10:18:49 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: iommu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommu/msm: Use identity domain for GPU and display
Message-ID: <awQE5aSSdXv9rTrv@8bytes.org>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029212344.346069-3-robin.clark@oss.qualcomm.com>

On Thu, Oct 29, 2026 at 02:23:43PM -0700, Rob Clark wrote:
> Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
> select direct mapping") for arm-smmu-qcom, match GPU and display compat
> strings to pick identity domain time.
> 
> The drm/msm driver attaches it's own domain, which it manages directly,
> so we don't want an iommu managed domain interfering.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/iommu/msm_iommu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks. Patch 1 needs to go through Will.

