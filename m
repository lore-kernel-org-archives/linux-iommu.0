Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967E13731
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:17:07 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3D6D728012B;
	Fri, 14 Jul 2023 16:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689344226;
	bh=WFqu9evytvVryJFLeEKM+c2yep+jj9kszOcEObQpxLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=7ZTNA5abrPS1+xZP33hbcMdFB89oUKrWpw5pWMd2tku48tL5HXTwP/8NiFK6ziTCc
	 Xd6BZ1zjGkBGzuwod3UrOeKg6AyQ0iBr5I9WmaZlnu8md08v1e1+7Xl8q5ME9qtSwK
	 8HnSigqi9nD8kNSSiHvT4CMyCQogBeQ7/ZpHMxmBfsmAC9UsCtJ9EZXy9c800b+shN
	 hD5gVM4wuCyyTLhh6ViQippVhFM3ZYEU6/OALALtf53WHviAX8bF5XVe5WT1xa+Y5U
	 5bDwYLrv8j/YtsVLYNtnKGXo1n4gG7jkYD4sXn+mAJiFNFM1Oua0tNNL7GzVu404F+
	 tCsTeea0p49ew==
Date: Fri, 14 Jul 2023 16:17:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, jgg@nvidia.com,
	dmarcovitch@nvidia.com
Subject: Re: [PATCH v2 0/2] iommu/amd/iommu_v2: Fix refcount related issues
Message-ID: <ZLFY4TRFW7ON49Lv@8bytes.org>
References: <20230609105146.7773-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609105146.7773-1-vasant.hegde@amd.com>

On Fri, Jun 09, 2023 at 10:51:44AM +0000, Vasant Hegde wrote:
> Daniel Marcovitch (1):
>   iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
> 
> Vasant Hegde (1):
>   iommu/amd/iommu_v2: Clear pasid state in free path
> 
>  drivers/iommu/amd/iommu_v2.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.
