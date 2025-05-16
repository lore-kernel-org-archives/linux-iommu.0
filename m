Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEDB1361
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747377931; cv=none; b=SJIOZAmmcBxx+LZjFtpEryY+t4xNIpZspDGLJnQKzd+8+DXdMUg/saaFoGPOJiu944/Pq8Vf4rZQ/FbqoL33cO9bb/vLUyv7OWNS+3vDu2oluRKmyJG0vV6DVRETKw/YEvX0wrdc2U8VKIUlhWnFgrVY0zmerd6xb5osMFZ0vvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747377931; c=relaxed/simple;
	bh=4PqGR88p/sS4l3DEwVrJvao/LMbDQhYsWmLuThxyg3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guAdtlcOZwyXb0WOhIGlWZWU4F+RooYRSvv5r+fMZ9v2Jai+/54lU8serjRwN3N7cgqwVgaDiaJXavvjk1jdM/IkhCvHvq5gtikYvN4eWHjGkhmr40TOh+GRpYHHUmGnt2swqb2tkz8p15UctMkKX0HOm6F4BbAPXvBjwNk3aQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kQKAcxKs; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kQKAcxKs"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 016414B65F;
	Fri, 16 May 2025 08:45:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747377928;
	bh=4PqGR88p/sS4l3DEwVrJvao/LMbDQhYsWmLuThxyg3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQKAcxKsFPco0m28bnXz2F5leyXo9CnHTkcYL8qBTwXhpEQMM7SXUTpKbCxnts6Rj
	 Ise9D+crSeRxaKpcLsPFEvmC2uH7Lff5FBe64QQ/YpfBKFG15LTiHkhVGM2jKhCAhj
	 xaYPRbCen5ROusk5ZNwXyiXL/7YfxRYJR/3lHBs9T/DSKufE+ByKzdTr0aO/Rb5N/l
	 saX6fZrg/GP0lfbQYEoUfuZcIkQabR67fr+nUqhuB+EJVmrJlzgPueWgXo/Jf1oMKc
	 W2w1A06khpq9iNfJocAm+Ays7eDv35Nu+qIgUA9pbby+Nmw2+SqyeKSdaHBgukepx9
	 7691hl/E2sVaw==
Date: Fri, 16 May 2025 08:45:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tushar Dave <tdave@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	jgg@nvidia.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
Message-ID: <aCbfBqVu1C9Jtk7F@8bytes.org>
References: <20250505211524.1001511-1-tdave@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505211524.1001511-1-tdave@nvidia.com>

Hi Tushar,

On Mon, May 05, 2025 at 02:15:24PM -0700, Tushar Dave wrote:
>  drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)

This doesn't apply to v6.15-rc6, can you please rebase and send a new
version?

Thanks,

	Joerg
> 
