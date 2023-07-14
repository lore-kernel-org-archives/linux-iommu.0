Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CCB134D2
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:22:10 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 86B4528012A;
	Fri, 14 Jul 2023 16:22:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689344529;
	bh=Cf3GvOf2T+3qm+D2uaFvT9lOZj6W7oZl1wP5Gr+2TBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyyfyMVlpi/2oN262Hdv8c+qTC369k7CkujcDvuILI2ToD0LotVnaMNtCuOoy83z3
	 isIn3n9a0S4Iqd9xxzVeEDgdMrgcDuMsvGdA1wD0XNlJD78G3MAztepvBtkQOnunb+
	 HLvauVVJjnJcHEREcns6es8nRxTpwh6K3IDYvVHYDGCwFfYGX+B3HF30nguJFQjWjb
	 E2BcVF5sNO894hPo/nfIbuVHDewNKi0jgZji2AqjZvkyDah6BBkbhYQ/Qt8eUXlHb5
	 +DuOg5RsRUMU/0f5Tl0ZcS8wTLpFdmXTIj/SWWzCjUitPf5p5tmpjnhArpEy7UCRri
	 IOA/k2IPHK1JA==
Date: Fri, 14 Jul 2023 16:22:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/3] iommu/amd: Consolidate PPR log handling
Message-ID: <ZLFaEBO4PmGUF13A@8bytes.org>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628054554.6131-1-vasant.hegde@amd.com>

On Wed, Jun 28, 2023 at 05:45:51AM +0000, Vasant Hegde wrote:
> Vasant Hegde (3):
>   iommu/amd: Disable PPR log/interrupt in iommu_disable()
>   iommu/amd: Consolidate PPR log enablement
>   iommu/amd: Enable PPR/GA interrupt after interrupt handler setup
> 
>  drivers/iommu/amd/init.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Applied, thanks.
