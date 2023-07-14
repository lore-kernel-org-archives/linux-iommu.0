Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3CE551
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:20:00 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 737FA28012B;
	Fri, 14 Jul 2023 16:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689344399;
	bh=feTI3IBNJs+aPb3Lr+bPRI+HjRuBPrZwHSVX/R1Rzw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=je65mMf67afeMPzSUjVYwwyNaUbVB5pcwceEeWqEVMZ/KcEHujutURdsM7SmG/rHy
	 P86s6690B8fvYYMqno449MV4uV/vSTWrsNjwdfx2S8g66tKoLjIBphitZOCrRiVyZ8
	 Bgz3v1NCatSw9M6Z/qKfLkYKaAVFBv1s59HKg5IgVx6yX4yiNV3oDe0fBzPKbK5fgq
	 HU9fshtrNgvdLJNyYHZhk297/oC3ez76iZt/pzSiXJKwbtOLVEYGRcgzsuglTaXYNW
	 TzLRryqXRs2MRo+rmMVBhmwxZdR1YyM7iI/0mYzCAIJY2xjFInLN4NiQ5lvaRkmpo9
	 rlB3rxYdmGMRQ==
Date: Fri, 14 Jul 2023 16:19:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	joao.m.martins@oracle.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/amd: Add PPR overflow support
Message-ID: <ZLFZjktnL1iHUvIG@8bytes.org>
References: <20230628051624.5792-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628051624.5792-1-vasant.hegde@amd.com>

On Wed, Jun 28, 2023 at 05:16:22AM +0000, Vasant Hegde wrote:
> Vasant Hegde (2):
>   iommu/amd: Generalize log overflow handling
>   iommu/amd: Handle PPR log overflow
> 
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  5 ++-
>  drivers/iommu/amd/init.c            | 60 ++++++++++++++++++++---------
>  drivers/iommu/amd/iommu.c           | 13 +++++--
>  4 files changed, 57 insertions(+), 22 deletions(-)

Applied, thanks.
