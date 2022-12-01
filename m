Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F065D1C10
	for <iommu@lists.linux.dev>; Thu,  1 Dec 2022 13:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E61C433C1;
	Thu,  1 Dec 2022 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669901483;
	bh=kLtneGY9D+ZSAz7b/D3t9fHi1UjdNmz2jAAh4dXlsIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pa6SiLdu66W91X5943Xdy7wmKkln33KXgdSx7ymB5q+unBRuCJv8T1lGrhJlgIcUM
	 drGqJLV1NqtPzd++5Wwh72mQCNi2I0TNLQtIKsfm8xIzeplSgTCW4VubEqHL3yhv/P
	 lfeNSW/LCFPWEesGD2LXQvKU46R/LFNU3UteQIaKDaKyWxIoo5qm+jO9oKJ7wgJR9g
	 eKx3P0SqfcG+5ft5UNg7zNelj99T8vmUdLmTHyNsYQYWAVHshmWJ1/TUF+k0qB1HJF
	 kCDuhCUsm2IUlsCysMC2tnG4/z5gs983od1JDaRVJ+BDKWk8sItPrrI0/OXT9muoLH
	 SaoFFwr/7IZBw==
Date: Thu, 1 Dec 2022 13:31:18 +0000
From: Will Deacon <will@kernel.org>
To: liulongfang <liulongfang@huawei.com>
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: fix smmu initialization memory leak problem
Message-ID: <20221201133118.GA28489@willie-the-truck>
References: <20221121030421.19295-1-liulongfang@huawei.com>
 <20221121180552.GB7645@willie-the-truck>
 <cb6fcc72-bb50-5fb9-f7c3-648538fbd376@huawei.com>
 <20221129152452.GB26561@willie-the-truck>
 <fe32de72-caf4-f6bb-565f-93ea1d3a003b@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe32de72-caf4-f6bb-565f-93ea1d3a003b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 01, 2022 at 08:42:02PM +0800, liulongfang wrote:
> On 2022/11/29 23:24, Will Deacon wrote:
> > On Tue, Nov 22, 2022 at 08:00:39PM +0800, liulongfang wrote:
> >> On 2022/11/22 2:05, Will Deacon wrote:
> >>> On Mon, Nov 21, 2022 at 11:04:21AM +0800, Longfang Liu wrote:
> >>>> When iommu_device_register() in arm_smmu_device_probe() fails,
> >>>> in addition to sysfs needs to be deleted, device should also
> >>>> be disabled, and the memory of iopf needs to be released to
> >>>> prevent memory leak of iopf.
> >>>>
> >>>> Changes v1 -> v2:
> >>>> 	-Improve arm_smmu_device_probe() abnormal exit function.
> >>>>
> >>>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> >>>> ---
> >>>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
> >>>>  1 file changed, 11 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>>> index ab160198edd6..b892f5233f88 100644
> >>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> >>>> @@ -3815,7 +3815,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>>  	/* Initialise in-memory data structures */
> >>>>  	ret = arm_smmu_init_structures(smmu);
> >>>>  	if (ret)
> >>>> -		return ret;
> >>>> +		goto err_iopf;
> >>>>  
> >>>>  	/* Record our private device structure */
> >>>>  	platform_set_drvdata(pdev, smmu);
> >>>> @@ -3826,22 +3826,28 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >>>>  	/* Reset the device */
> >>>>  	ret = arm_smmu_device_reset(smmu, bypass);
> >>>>  	if (ret)
> >>>> -		return ret;
> >>>> +		goto err_iopf;
> >>>>  
> >>>>  	/* And we're up. Go go go! */
> >>>>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
> >>>>  				     "smmu3.%pa", &ioaddr);
> >>>>  	if (ret)
> >>>> -		return ret;
> >>>> +		goto err_reset;
> >>>>  
> >>>>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
> >>>>  	if (ret) {
> >>>>  		dev_err(dev, "Failed to register iommu\n");
> >>>> -		iommu_device_sysfs_remove(&smmu->iommu);
> >>>> -		return ret;
> >>>> +		goto err_sysfs_add;
> >>>>  	}
> >>>>  
> >>>>  	return 0;
> >>>> +err_sysfs_add:
> >>>> +	iommu_device_sysfs_remove(&smmu->iommu);
> >>>> +err_reset:
> >>>> +	arm_smmu_device_disable(smmu);
> >>>> +err_iopf:
> >>>> +	iopf_queue_free(smmu->evtq.iopf);
> >>>> +	return ret;
> >>>
> >>> I previously suggested using devres_alloc() for this instead. Did that
> >>> not work?
> >>>
> >>
> >> This patch is only for fixing iopf's memory leak.
> >> The use of devres_alloc() is an optimization solution for iopf queue management,
> >> which is another set of patch matters.
> > 
> > Great, I look forward to that set of patches!
> > 
> 
> Will this patch be merged into the next branch?

I don't plan to merge this one, no. I'll wait for the other patches which do
this using devres_alloc() instead.

Thanks,

Will
