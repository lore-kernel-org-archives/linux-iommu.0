Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39D539F
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 12:17:08 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5141D24000A;
	Wed,  7 Sep 2022 14:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662553027;
	bh=2nVr7UVYAxkZ9GPJrQl7z3cD8SviZ1y40ZwmRWs7WwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8ndfyW5uGFHBrCrN8kfHxycBfRKoUKCt71gIQR4rb5DzxR/cqt64LfmaG78E+90bE
	 Ukh7bkqkjcitoqe2OVXslhAZuB+mf77YTEG5yOFx5ak03uRYYKFZxLDLbugi0EAds3
	 B5Dn2Gh/7pdjNTDPzS36xXKLwCQv1T+Mg/eWfoTmm6JF0MlW+145cejR63p9fA6N1s
	 mRPaqXrf24hOHL6YjrAMybL6qs8oUVsWjdlySxHEQjkbPC9QhoRoy6x4r/VUDkcdah
	 AEjkNz2Ty7smRoF9LMzj0lGntCUeVQnGOCfVrMbTBHkBHyr9DYsNfbUczEJTDYC+Kg
	 tTCyutpA1+zwg==
Date: Wed, 7 Sep 2022 14:17:06 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iommu: Retire iommu_capable()
Message-ID: <YxiLwrBr6PnNilvr@8bytes.org>
References: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>

On Mon, Aug 15, 2022 at 04:26:49PM +0100, Robin Murphy wrote:
> With all callers now converted to the device-specific version, retire
> the old bus-based interface, and give drivers the chance to indicate
> accurate per-instance capabilities.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied, thanks Robin.
