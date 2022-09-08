Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E797C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 12:41:03 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4C5CC240A75;
	Thu,  8 Sep 2022 14:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662640862;
	bh=3EAIMIktzud9ToG2H1ZwVLs8o0Ql/FZgWEZPEjKxPBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1DFmhoa1Yk4G1/dAfY1skfvA2J2tRFSYGWpYQ+7le8JHgwQhl/KSVA/ne/sYcQYUj
	 ra45OAWJ3hbH1p3Jtc4SqLruxSsOsXLpnZYZzZ18HsZm9cl3iiXYjPxt/cV0imG8jc
	 lcSmU0wJWrI/SvY3VN17qlt5uk3nYORHbjjLB6AQXZQ0/qTXZm2k2VeAQX35jyfH/E
	 t9wqAgjm/Lwd9EW3hu033h+pis6yAmdVFJ7rtT8zfOIUUJP6dBIwbP1WjdOFxB3aTT
	 uL1W/Qek1illRLToEapOENFH0JvjYm7SuK18ud9DqgeB8d8N/8Gfw6fqVmFWlKaWBo
	 uvXEMc6uFYLSg==
Date: Thu, 8 Sep 2022 14:41:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Drop of_match_ptr()
Message-ID: <Yxni3d6CdI3FZ5D+@8bytes.org>
References: <dcab234a51ed2d9e79d2f960f6da5f59361a2931.1662566939.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcab234a51ed2d9e79d2f960f6da5f59361a2931.1662566939.git.robin.murphy@arm.com>

On Wed, Sep 07, 2022 at 05:12:12PM +0100, Robin Murphy wrote:
> Drop of_match_ptr() to avoid an unused variable warning when
> compile-testing with CONFIG_OF=n. The driver is not actually usable in
> that configuration, so there's no point trying to optimise out data.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> fixes "iommu/ipmmu-vmsa: Clean up bus_set_iommu()"

Applied, thanks.

