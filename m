Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6D20EB
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981817; cv=none; b=Uf95Wm2/NqaFfoCyDwop/bchQG4whPY21HxmdiHPWRGv/rdksFqZ8VUxDibpxejPyVz5Yr9WeH7rWh4dDm6uugMeOQ/iclZIIKiFH9gUlguzWFyBPqopIlNoq1mnMbPy4oVUzEviai7RYseDB1OcCT0SWkyCfk2wM/hlWdGZ+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981817; c=relaxed/simple;
	bh=9+nrEpuvLAfHEp3Yk5tT0aZkapAIdB1p6g3Y9EDJqm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZDeMPeOY4fwV29Hu6OQ8rNm2yxoyAfp1GCvD9ca5n8B9MPKYw9dHUa/6IhHyf3O88LnfAo6SwlyfP7OY6PYrzir7X5bXGcoZXp/8mzzNaR/lAhEEHRropIvd8AA1km7LMvm2TkEN140pAuZl6fEuLN8HhqjmlVHRJ2uP6VEQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=md2bcE2y; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="md2bcE2y"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 21C212A6C15;
	Tue, 15 Oct 2024 10:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1728981815;
	bh=9+nrEpuvLAfHEp3Yk5tT0aZkapAIdB1p6g3Y9EDJqm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=md2bcE2y9mYtnKVMb4u4Y+MU5C/uZp7POWR4CFlOQYImVLxg4gboyv0sOqlE2BvCp
	 5sB9UOS5t099Re08AAIfIymYi6S0mhaZp9G3rs7lL9J1oKrPG6PqS+jI1gcudjlScM
	 Sk9TvD5qV/dNx/cOrgZVZXJSL0GIyMI4TSQMvlaHPN0MYVY06gnh51G3NO/rkKU0R5
	 H+rtPJhITFMqojdFUCZtG6xiCJBDiEHBaX4kKnG0YajmnxoneiFMjEAZ/kUr+2NoEQ
	 iEOigkZFOdf6PpFjTgofWFWN/J7DpgfBFISg0EwHcQpXIsoQa+wL1bkWDhHGBUMc5N
	 izKh+2DPhtALg==
Date: Tue, 15 Oct 2024 10:43:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 08/10] iommu/amd: Convert dev_data lock from spinlock
 to mutex
Message-ID: <Zw4rNoSwn6n-Z0n1@8bytes.org>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-9-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910065812.6091-9-vasant.hegde@amd.com>

On Tue, Sep 10, 2024 at 06:58:10AM +0000, Vasant Hegde wrote:
> Currently in attach device path it takes dev_data->spinlock. But as per
> design attach device path can sleep. Also if device is PRI capable then
> it adds device to IOMMU fault handler queue which takes mutex. Hence
> currently PRI enablement is done outside dev_data lock.
> 
> Covert dev_data lock from spinlock to mutex so that it follows the
> design and also PRI enablement can be done properly.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/iommu.c           | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Pending on the clarification for the lock inversion change:

Reviewed-by: Joerg Roedel <jroedel@suse.de>
