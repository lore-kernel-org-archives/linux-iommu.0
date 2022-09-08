Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1027C
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 13:30:11 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CAA83240A5A;
	Thu,  8 Sep 2022 15:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662643810;
	bh=Z4JVioXDDILyUGjWKgYVPIoqYq8euTPmyssisCH3Db8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YU14oQeFdR3h6d+G1dh3jJBJL5O8JRZekDuuPQPfD+L8m8fnnYI+eAFW30pCsjWcr
	 oyVludzo3lH7BannwIXr+ZTK4Ox5WFPTp3P34uHC7MjXX8MHDGLo0m9gELygj6kx/Z
	 /fjd88nANfAJ8OwiNQPqFoF7Yt936VeKwxkgPwCTw/FKtPt8ZhMnuz+1wJZCY8WiK+
	 1jGLQwAI0tX1q80PPOeuvmJaqPm68DXkl4PNjEc4rH8k9I4eOmM5wzQkpKoXdE7kol
	 03lV8t6Pk7klWAYSFbaGwJdolEV06asTt6uJv33FX1neeWxSkYNH/opx+A1uvqsT/H
	 1H2etSjfBMVQw==
Date: Thu, 8 Sep 2022 15:30:09 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YxnuYTrkC5yoHH84@8bytes.org>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
 <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com>
 <YxneJ2RqaatKmoYT@8bytes.org>
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com>
 <Yxnr1gBIGwdinIkr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxnr1gBIGwdinIkr@nvidia.com>

On Thu, Sep 08, 2022 at 10:19:18AM -0300, Jason Gunthorpe wrote:
> What is the use case for having PASID nested under another level of
> translation?

Virtualization. Basically having a device access process address spaces
inside a virtual machine. That got never put into code, but it was the
rationale behind it.

Regards,

	Joerg
