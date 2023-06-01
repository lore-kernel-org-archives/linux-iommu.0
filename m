Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630B200BA
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 09:57:54 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E21BC224B45;
	Thu,  1 Jun 2023 11:48:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1685612910;
	bh=pF+Egy6iA+ZwOAT2x7ihrgeZOqh087YTNMbwRgLqIrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mB3vC+pwm0gNIHj16iWUa8xaiGMgDqLBsonBEt0bR2i6c3Gj8AcexkJ7yUrYSNA3w
	 KEiqT1Qw0trrIgUfCGsGnW/wqeLG8GFvD30obSwCK6ZwdtYa7a9v2IRwbp5crOtmc4
	 vTXd/gbCY7Bg6X0DG85NUNT1cXHMO/pc9Mi6cuEVUOc8/P+ODqg1uYIEOfj0XTqvis
	 WNXuAtqFhpzAfIctVhU4efMJkNj6bhYGwPNHXq6MvMewx7fKV7Xi9YegB1emIHG2NP
	 C9uDFpyqCtJhJq+0FFu75tjTxOAKkIfzStjIh23RITIRnyukWelkf2GOQq4Q4kxkTS
	 yopqBe1wBMjTA==
Date: Thu, 1 Jun 2023 11:48:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Li Yang <leoyang.li@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 0/3] Remove iommu_group_remove_device() from fsl
Message-ID: <ZHhpbAqrIPp33iit@8bytes.org>
References: <0-v2-ce71068deeec+4cf6-fsl_rm_groups_jgg@nvidia.com>
 <ZGxcmJ3vH0Smqqxu@8bytes.org>
 <ZHP1zv48iZUV5Ypj@nvidia.com>
 <87leh658ly.fsf@mail.lhotse>
 <ZHX9nu234ehZWVwU@nvidia.com>
 <87leh5yobf.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leh5yobf.fsf@mail.lhotse>

On Wed, May 31, 2023 at 05:04:04PM +1000, Michael Ellerman wrote:
> Great, yep consider it:
> 
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

Alright, applied them for 6.5.

