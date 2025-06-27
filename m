Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48621858D
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008336; cv=none; b=UN2pfxWYbOmcG1ydnaeLwzWcIL4Yb0ii+GI5nAua0kem2mTifHNdLTw+I4uLtN4BVQb5n5slkOXTT39Z/X/3QL90ZR/LnOYrFJ0nwJVE4zI/b3as01iGjBmQCf02PPBbcL/KeHvgQQuwSBcJEqQr7NkjWOD0VTRX9/HCrOH+vHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008336; c=relaxed/simple;
	bh=hViMdqb6dxMsSc22iEs4gFV/W3OyUowtbhavaS4N2C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6v9ZtLtBFS0c+4S13UYKhNiP/G9TrKc27Aw7NhkiHQo55fm+Um4OEJAdeayu/CZlSb2FUDMg8z/3TsKIg9MM7WSzTqiIV+HGmfml2dcnvq5P5WqTVyyD4+JnrJ4Od1kZK/0Vg76iLrc9O6MNzWNDox0tS5XJA5TlkolXGiQ/sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=os8eh9Om; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="os8eh9Om"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 382E94D686;
	Fri, 27 Jun 2025 09:12:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751008333;
	bh=hViMdqb6dxMsSc22iEs4gFV/W3OyUowtbhavaS4N2C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=os8eh9OmTEn/Dx1LHcwVX5y/zK9/DPU+4gdnpJKgvmO8zgLCFp6UyZQzhdVu/eTB5
	 ymyVzF6dt2XSAV1mvIVjI4FKvk41lONyZrMBQn4PxkBdn1BcFwrjk/vusMYrkdD0+t
	 b4IEj9E5srjbXb25KOIHy0R+93xNZ1Hp+3MskKXm6EyeWCW/Myweg9idpwczBK5DIU
	 5UIc1k7ayRmlhP+3k0Yp1KlD3ld/piGG2aRMG6PjylYIXcPeC6+G8+jwYAjKQOlAD/
	 U7ACVw6okT+2NBBXG0Nx+ZNTUt18dp9sVNkVpInqzvcmgrKjHyI8oS+0vwQhkOXQub
	 +76+NJjhyQ8GQ==
Date: Fri, 27 Jun 2025 09:12:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Simon Xue <xxm@rock-chips.com>
Cc: will@kernel.org, heiko@sntech.de, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/rockchip: prevent iommus dead loop when two
 masters share one IOMMU
Message-ID: <aF5ETB6HEGywYKS9@8bytes.org>
References: <20250623010532.584409-1-xxm@rock-chips.com>
 <20250623020018.584802-1-xxm@rock-chips.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623020018.584802-1-xxm@rock-chips.com>

On Mon, Jun 23, 2025 at 10:00:18AM +0800, Simon Xue wrote:
> When two masters share an IOMMU, calling ops->of_xlate during
> the second master's driver init may overwrite iommu->domain set
> by the first. This causes the check if (iommu->domain == domain)
> in rk_iommu_attach_device() to fail, resulting in the same
> iommu->node being added twice to &rk_domain->iommus, which can
> lead to an infinite loop in subsequent &rk_domain->iommus operations.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 25c2325575cc ("iommu/rockchip: Add missing set_platform_dma_ops callback")
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> v3:
>    Add missing `Cc: stable@vger.kernel.org` in commit message.
>    No functional changes.
> v2:
>    No functional changes.
> ---
>  drivers/iommu/rockchip-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied for -rc, thanks.
