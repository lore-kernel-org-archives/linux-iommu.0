Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD453B8
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 09:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2028C433AB;
	Thu,  7 Sep 2023 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694078483;
	bh=/GS1WwYYzNZinEQSmtBBhJz/YUvo1u0JiMvkD09lhto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLGGR9u26RiI01krmX9vBDimL0Lxm9Fb1+00GbFy9eMyD0781Yn1ssVROhCWIbObg
	 bJtsbYG+P02WGz2QsZ5jcfD6pa3DwJDaRmGiKDnEhHWGknZmw1pBg48RJTZDnTQG0u
	 M1scnrJJQKMqHyZOitKjt9pukCr202LcOkjUxjXwrO1Em773MbAJASU1Gri/YJR/KP
	 fyNxw0KLR8Nwp2L6R1rN9s2Ocu+uwmyoBhOFZqW8SiqE8x5FDi+eXi038+FSF2hsLN
	 DZ6xi0fSHkn3WaYGrgyBOoUkR99X0jPl6/E48ooQxalzJelR/kT3HGkzR/v9BdZNnl
	 ML2o5x+e73GEA==
Date: Thu, 7 Sep 2023 10:21:17 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	zhurui <zhurui3@huawei.com>, Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tomas Krcka <krckatom@amazon.de>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu-v3: Fix error case of range command
Message-ID: <20230907092116.GA5731@willie-the-truck>
References: <661a7bb5-99e1-de16-d860-0cd17f7a0470@arm.com>
 <20230808162409.GB2890@willie-the-truck>
 <80ead8ee-4dbe-7b3c-44f5-944073a2a39d@arm.com>
 <412886be-644a-5b46-9bfa-1c9a358f9a5d@huawei.com>
 <280d0be7-7d41-ed78-bf4b-3db6c0076e22@arm.com>
 <197e87cd-91a2-dce8-716c-488b379abbaf@arm.com>
 <20230818162114.GB16216@willie-the-truck>
 <d05378c0-5b85-caaf-ae0d-49576adf7d86@huawei.com>
 <dafbccb4-f7be-838f-c037-91ff2dc324e4@linux.microsoft.com>
 <a71e17d8-f5c2-113b-b1ca-e2c011630850@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71e17d8-f5c2-113b-b1ca-e2c011630850@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Sep 06, 2023 at 01:59:55PM +0100, Robin Murphy wrote:
> On 2023-09-06 06:05, Easwar Hariharan wrote:
> > Could you please send out this patch since ZhuRui has confirmed it fixes
> > their issue and CC it to stable for v5.15+? Or if Will is willing to
> > pick it up off this thread, I can do the backport to stable.
> 
> I can resend after -rc1 if Will would prefer that. It's tagged as a fix so
> should hopefully get picked for stable automatically once it hits mainline.

Yes, please! Then I can queue it next week and send it to Joerg as a fix.

Will
