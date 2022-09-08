Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B57C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 12:21:04 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CEC12240A5A;
	Thu,  8 Sep 2022 14:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662639656;
	bh=jgTOxZAP4LMzAGkSaYYjJu/Jgu9rxZTRA0ZaDm9zBVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8Yvee5oLsYKNYOmK73PYzE0W3aGqeRcoSqvHBZ3o4sCXT21usVAGjsbPIxqsEOUN
	 8DWeGbqobs3uZzBsUnNgsxqT0JOBHw9Do4wIF0uNl/V3SmPBq3nL13PEwATfaOwwOb
	 AzM0ImVocNsFCX+80YTg8sTD3vSH0PYOK1+XPJ0RtVBgQLgNJKCzYc1gabL4pjLi4+
	 4vaSGi5GZ2Q4U53/ZJ9GyeWHxeHyQ9bVEYpAI/CxtUjI8qx5tNha8C4mIepnMtiYin
	 DAOrBqsvPSavt4/DkyS4KnacOcK5QwwXK+yZ+gqJdMRbFokXc0Qx4sLZogRtrUZE6W
	 vR+du9ppYW4xw==
Date: Thu, 8 Sep 2022 14:20:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YxneJ2RqaatKmoYT@8bytes.org>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
 <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxjMQpGYaHfsiuL+@nvidia.com>

On Wed, Sep 07, 2022 at 01:52:18PM -0300, Jason Gunthorpe wrote:
> Why can an identity map be attached to the RID in v2, but not a full
> translation? It seems like a very strange design that entering PASID
> mode completely breaks RID support.

The reason is that AMD IOMMUs do two-level translation, which means that
the addresses in the PASID page-tables are translated via the v1
page-table again. In order to be able to use Linux page-tables for PASID
mappings the v1 page-table needs to be identity mapped.

Regards,

	Joerg
