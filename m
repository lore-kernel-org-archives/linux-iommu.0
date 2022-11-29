Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A28F55
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 15:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E3EC43470;
	Tue, 29 Nov 2022 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669735498;
	bh=oulE4EpquB5gQZxaRIvcA8IeEjziBicDGjQZcYqDanw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAyZQunYozQ59YWWFFWZhs0zSM4q2zars8eSyBNL28myjZ4Nrk9UObo0SxnIr7YIY
	 XoyaAyboaWHvcdzOEim34ggEhQh/qT1v86ocK0T505nWOpClHJaezFU8VHB2OEDKjH
	 kajhhR1a8qyuxYmZogTY00vIhV6hnHKQRCoVdC9yURaUmkTlqI5U2qlN/nefaQutnm
	 hc9PQ6QwQlHir1/Wgv8LYyH/lBToePoRtEB4SOKkAe1c9bgiFPQWidBvYKtrDGjdi2
	 jOzC6APQJvZ8OpvMRxTwevLujvBPdsbjjVuxTF0eWSjhUN3ue9KFWhuM7TT41FZcbg
	 XeMcY7hQhOSyg==
Date: Tue, 29 Nov 2022 15:24:53 +0000
From: Will Deacon <will@kernel.org>
To: liulongfang <liulongfang@huawei.com>
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: fix smmu initialization memory leak problem
Message-ID: <20221129152452.GB26561@willie-the-truck>
References: <20221121030421.19295-1-liulongfang@huawei.com>
 <20221121180552.GB7645@willie-the-truck>
 <cb6fcc72-bb50-5fb9-f7c3-648538fbd376@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb6fcc72-bb50-5fb9-f7c3-648538fbd376@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 22, 2022 at 08:00:39PM +0800, liulongfang wrote:
> On 2022/11/22 2:05, Will Deacon wrote:
> > On Mon, Nov 21, 2022 at 11:04:21AM +0800, Longfang Liu wrote:
> >> When iommu_device_register() in arm_smmu_device_probe() fails,
> >> in addition to sysfs needs to be deleted, device should also
> >> be disabled, and the memory of iopf needs to be released to
> >> prevent memory leak of iopf.
> >>
> >> Changes v1 -> v2:
> >> 	-Improve arm_smmu_device_probe() abnormal exit function.
> >>
> >> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >> ---
> >>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
> >>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> index ab160198edd6..b892f5233f88 100644
> >> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >> @@ -3815,7 +3815,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>  	/* Initialise in-memory data structures */
> >>  	ret = arm_smmu_init_structures(smmu);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err_iopf;
> >>  
> >>  	/* Record our private device structure */
> >>  	platform_set_drvdata(pdev, smmu);
> >> @@ -3826,22 +3826,28 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>  	/* Reset the device */
> >>  	ret = arm_smmu_device_reset(smmu, bypass);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err_iopf;
> >>  
> >>  	/* And we're up. Go go go! */
> >>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
> >>  				     "smmu3.%pa", &ioaddr);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err_reset;
> >>  
> >>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> >>  	if (ret) {
> >>  		dev_err(dev, "Failed to register iommu\n");
> >> -		iommu_device_sysfs_remove(&smmu->iommu);
> >> -		return ret;
> >> +		goto err_sysfs_add;
> >>  	}
> >>  
> >>  	return 0;
> >> +err_sysfs_add:
> >> +	iommu_device_sysfs_remove(&smmu->iommu);
> >> +err_reset:
> >> +	arm_smmu_device_disable(smmu);
> >> +err_iopf:
> >> +	iopf_queue_free(smmu->evtq.iopf);
> >> +	return ret;
> > 
> > I previously suggested using devres_alloc() for this instead. Did that
> > not work?
> > 
> 
> This patch is only for fixing iopf's memory leak.
> The use of devres_alloc() is an optimization solution for iopf queue management,
> which is another set of patch matters.

Great, I look forward to that set of patches!

Will
