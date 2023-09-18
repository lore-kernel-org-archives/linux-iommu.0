Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12000111A1
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 09:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA40C433C8;
	Mon, 18 Sep 2023 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695029027;
	bh=W9tDmRFz0n8cGL2lDybhVkX8mgpWmONNFSrwMAaOJ+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1ehrI5spUg4sXe5a8Yv6+CAa8T3JsQFIm8CA1nIgLkzdg4EsKxtmy1OQ6CxzU92k
	 6+mY5jQ7T8cDV4ooCZcZxOTNm+B5FKGStdncc5ST759apYEOMQb0h0dmknvkvPTino
	 fo/LTL7I7Hxwed/jKGdIVTbnQbP5s7jcWYWUdQpgovY8N07txFWcYso23OdUkqc1sz
	 tK7MkNZcWwWOiTzzidwYoumlFHNGKi2LEzlEtNUsY8DLENIxCJ39mFSBHkMkFdelSA
	 0aUOoSa42UT8Pe6s29TzO/6Nr3QdfNMByf65+yp0rY61fvnzi8KyxVvNHwEEcTdeIv
	 DDo7gBLhQKZ9w==
Date: Mon, 18 Sep 2023 10:23:42 +0100
From: Will Deacon <will@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, jgg@nvidia.com, jean-philippe@linaro.org,
	apopple@nvidia.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix soft lockup triggered by
 arm_smmu_mm_invalidate_range
Message-ID: <20230918092341.GB17341@willie-the-truck>
References: <20230901203904.4073-1-nicolinc@nvidia.com>
 <ZQQLNmmAOsNmvtDs@Asurada-Nvidia>
 <9334dfcd-7749-6ae1-1170-b4952f2b8181@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9334dfcd-7749-6ae1-1170-b4952f2b8181@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 18, 2023 at 01:33:31PM +0800, Baolu Lu wrote:
> On 9/15/23 3:43 PM, Nicolin Chen wrote:
> > I found this patch cannot be applied to v6.6-rc1 due to conflicts
> > with some new commits that were merged during the previous cycle.
> > 
> > I can redo a version rebasing on the v6.6-rc1, yet the new version
> > won't apply to earlier kernel stable trees. Is there a way to make
> > it happen that both mainline and earlier trees can have this fix?
> 
> Normally, bug fixes should first be submitted to the mainline kernel
> (also known as Linus's tree). If you use the "Fixes" and "CC-stable"
> tags, the patch will be automatically picked up for the appropriate
> stable kernels.
> 
> If the patch does not apply to any stable kernel that you want it to be
> there, you can then post a back-ported patch to the stable mailing list.
> 
> When doing so, it's better to include the following information:
> 
> - The mainline commit ID of the back-ported patch.
> - The versions of the stable kernel(s) to which you want the back-ported
>   patch to be applied.
> 
> Hope this helps.

Yup, please send a version against -rc1 so we can land that first.

Will
