Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC928FC
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 13:08:04 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4CE85242C83;
	Wed, 22 Mar 2023 14:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679490483;
	bh=MxF5HJR344mx8GdjGWa061I5iQNtgPbBGawxMrvEQmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjYmHVz4RZlIOzHrwxcJN98i1uVxv2v3Zea2ay+im0oPktZtagmUSPjCf4iHEB4KT
	 Jamq+PF/cTPhzyWtRzB9lWuXoccy0J80gu5uRqrcV2Uq794ScQAuQK7l5AXWK+sli5
	 WP/mVV0ecoq31SJmsOnpN7mHI0rT/ar66WKh1czND0e3KHerGinUlXHj/Pl/CQT7Ai
	 iYnDs0gTPQqXKe5/8EQecFYky9USVpPGYctgcjeJoFHyNMPwaFtSzq4KE7C8klXMsN
	 Sk/3xUyyBW6zIncXI2nw8+hKW4/kpp+zOUZal0f9cbD4LCEO26NuXcY5Bx8SobdJm5
	 X/q8yDEHUgLQQ==
Date: Wed, 22 Mar 2023 14:08:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 9/9] iommu: Remove __iommu_group_for_each_dev()
Message-ID: <ZBr9skYtbsX42UNo@8bytes.org>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <9-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>

Hi Jason,

I like the general direction of this. Just a cosmetic nit below:

On Tue, Mar 21, 2023 at 04:53:21PM -0300, Jason Gunthorpe wrote:
> -	__iommu_group_for_each_dev(group, &gtype,
> -				   probe_get_default_domain_type);
> +	list_for_each_entry(gdev, &group->devices, list)
> +		probe_get_default_domain_type(gdev->dev, &gtype);

Can you introduce a macro instead? Something like for_each_group_dev()
or similar. This makes it easier to read in the future.

Regards,

	Joerg

