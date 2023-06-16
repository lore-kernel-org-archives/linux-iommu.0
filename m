Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B689A1879
	for <iommu@lists.linux.dev>; Fri, 16 Jun 2023 14:39:16 +0000 (UTC)
Received: from 8bytes.org (p200300c27725a60086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7725:a600:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 345D8224B97;
	Fri, 16 Jun 2023 16:31:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1686925883;
	bh=NQK9AGxc7OYDL4MJgF9sHOf7CT8apO/4Wj/sqwn3ILA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN1E7eB7S9gZFSSOEnGpemOZpMaBmUVHFPduSLwzvvF6D7B4O3SHJa8q/hsah/Jhc
	 A92/jlDehZBd2kaYNrb9LAfA7XJ9O4jtr71vSlTi+4Jb+rBrBXE87SL04fZCRaSwLh
	 jc1r0HwH69iSc+0dn22wTGUFyYOdBGgbjnlQilRHZq1n7jGs/vfcst4mt+YCmQB1uw
	 BCAe7xHvCg24kbJmxwojZJpqlXuT2N4tDSj2/Vc7VEnoU88Kn6XG93h9i/3d9tyBwq
	 0emYUtTmaZFBSj09rm9ao2x1V0E6SgeTe8W8a2todAUoFWeyJN8rCZH9I2LenYsSgW
	 vVYDhZB1MaC7A==
Date: Fri, 16 Jun 2023 16:31:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Fix DTE_IRQ_PHYS_ADDR_MASK macro
Message-ID: <ZIxyOohwBv6Bkb0w@8bytes.org>
References: <20230609090327.5923-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609090327.5923-1-vasant.hegde@amd.com>

On Fri, Jun 09, 2023 at 09:03:27AM +0000, Vasant Hegde wrote:
> Interrupt Table Root Pointer is 52 bit and table must be aligned to start
> on a 128-byte boundary. Hence first 6 bits are ignored.
> 
> Current code uses address mask as 45 instead of 46bit. Use GENMASK_ULL
> macro instead of manually generating address mask.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
