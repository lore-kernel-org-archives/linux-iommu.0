Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC257F
	for <iommu@lists.linux.dev>; Sun, 11 Sep 2022 06:29:05 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 981B4401A0;
	Sun, 11 Sep 2022 08:29:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662877743;
	bh=GneY6Ecu3NUsu8ui/Ovw7m7RoUYEjwy3cLKx7pxMGK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+MafS8mUkInV3HrSn/qLZ9z/DHphX4Jj7NAq6WB5p+61d6Z5JLKWRsezXBygU4h/
	 abjQRQ7jTrVkrZZqYdy0nYcUL6ZxHfsDeYFZzyazHZQKJMDYjYg+R2bUG1JjWWq8/8
	 GLNyPDdnZyRJt/MatVvpPVxG8qRQGNSWgFNBa8mh7YudlsPsduazQQ16NmlaO4gnnC
	 PSCvHp0cYBo5UCQNYz5Nmwth+BzL6nq45yUkOROjB5tMgnSehXpRqwrbuhwr8vrpHJ
	 l0hEjwPSvhigiPZ4DBCVJwdCYfwqYYrOkvaUFrK6y1FLyPrBWqmZFj1Ho6/U42Nnzc
	 3NPv/MPDlc1fA==
Date: Sun, 11 Sep 2022 08:29:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH rc] iommu: Fix false ownership failure on AMD systems
 with PASID activated
Message-ID: <Yx2ALbxV6mwxwOZm@8bytes.org>
References: <0-v1-ea566e16b06b+811-amd_owner_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-ea566e16b06b+811-amd_owner_jgg@nvidia.com>

On Fri, Sep 09, 2022 at 04:46:31PM -0300, Jason Gunthorpe wrote:
>  drivers/iommu/amd/iommu_v2.c |  2 ++
>  drivers/iommu/iommu.c        | 21 +++++++++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)

Applied, thanks.
