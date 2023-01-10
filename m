Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE1B6FBB
	for <iommu@lists.linux.dev>; Tue, 10 Jan 2023 12:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772AFC433D2;
	Tue, 10 Jan 2023 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673352062;
	bh=dJUumUaWZHmrgtk7/xY3OEo27gkthFqWeeR6gHs6HOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4WC9jfJMLxaxiqNcsXCvwkNvFxPM6bIvkbosFonTMJvAQiqNYYSF9tVUjh/DEDco
	 xaDXUYg8cNkNueOfVlZQc0+9qYPMrkudzoazJa3q75pZJ7c5sEhaLZwhnZakMbaW1o
	 /bqsnQDNHhyxJHfMtPgB34xKe2NyxggjhZtsyo0mHLbv8w9esN3KQQ3vgcID7sP/Tg
	 jAeNPrOsRcv1l5TNJU/wAzoyPJ6jWRopbt5DSBHj04uaa95zEm9gC6COIpCsH5CCNY
	 cQeTXBkwp8LXHZs2Dfs80mMy1nmMdNI0DPRNCW1GVsxgB9SRDum4BJJc153gqxtlxr
	 4AmQs83fq388w==
Date: Tue, 10 Jan 2023 12:00:57 +0000
From: Will Deacon <will@kernel.org>
To: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: liulongfang <liulongfang@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] iommu: fix smmu initialization memory leak problem
Message-ID: <20230110120056.GA9119@willie-the-truck>
References: <20221121030421.19295-1-liulongfang@huawei.com>
 <20221121180552.GB7645@willie-the-truck>
 <cb6fcc72-bb50-5fb9-f7c3-648538fbd376@huawei.com>
 <20221129152452.GB26561@willie-the-truck>
 <fe32de72-caf4-f6bb-565f-93ea1d3a003b@huawei.com>
 <20221201133118.GA28489@willie-the-truck>
 <4fb97e88-92df-2738-a078-f8269aa76870@huawei.com>
 <b27ea07e-67a2-43ed-3611-9a11495fc032@wanadoo.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b27ea07e-67a2-43ed-3611-9a11495fc032@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 20, 2022 at 10:37:51PM +0100, Marion & Christophe JAILLET wrote:
> 
> Le 20/12/2022 à 04:17, liulongfang a écrit :
> > On 2022/12/1 21:31, Will Deacon Wrote:
> > > On Thu, Dec 01, 2022 at 08:42:02PM +0800, liulongfang wrote:
> > > > On 2022/11/29 23:24, Will Deacon wrote:
> > > > > On Tue, Nov 22, 2022 at 08:00:39PM +0800, liulongfang wrote:
> > > > > > On 2022/11/22 2:05, Will Deacon wrote:
> > > > > > > On Mon, Nov 21, 2022 at 11:04:21AM +0800, Longfang Liu wrote:
> > Hi Christophe:
> > "[PATCH] iommu/arm-smmu-v3: Fix an error handling path in arm_smmu_device_probe()"
> > 
> > the patch you sent is the same as mine. The maintainer hopes to optimize the queue
> > application part of iopf with devres_alloc().
> 
> You also added a arm_smmu_device_disable() call in the error handling path.
> Looks good to me, but should be confirmed by s.o who knows the hardware.
> 
> That said, I think that what has been suggested by Will Deacon would be
> something like:
> 
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ab160198edd6..1994990decb8 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2930,6 +2930,11 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device
> *smmu)
>      return 0;
>  }
> 
> +static void arm_smmu_free_queues(void *ptr)
> +{
> +    iopf_queue_free(ptr);
> +}
> +
>  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  {
>      int ret;
> @@ -2957,6 +2962,11 @@ static int arm_smmu_init_queues(struct
> arm_smmu_device *smmu)
>          smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
>          if (!smmu->evtq.iopf)
>              return -ENOMEM;
> +
> +        ret = devm_add_action_or_reset(smmu->dev, arm_smmu_free_queues,
> +                           smmu->evtq.iopf);
> +        if (ret)
> +            return ret;
>      }
> 
>      /* priq */
> @@ -3832,16 +3842,21 @@ static int arm_smmu_device_probe(struct
> platform_device *pdev)
>      ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>                       "smmu3.%pa", &ioaddr);
>      if (ret)
> -        return ret;
> +        goto err_reset;
> 
>      ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>      if (ret) {
>          dev_err(dev, "Failed to register iommu\n");
> -        iommu_device_sysfs_remove(&smmu->iommu);
> -        return ret;
> +        goto err_sysfs_add;
>      }
> 
>      return 0;
> +
> +err_sysfs_add:
> +    iommu_device_sysfs_remove(&smmu->iommu);
> +err_reset:
> +    arm_smmu_device_disable(smmu);
> +    return ret;
>  }

I don't see the need for this hunk -- we presently call
iommu_device_sysfs_remove() if iommu_device_register() fails, so that
can stay as-is. If it's necessary to call arm_smmu_device_disable() then
I think that should be a separate patch because it doesn't seem related
to the freeing of the iopf queue at all.

Otherwise, I'm happy to queue something like this using
devm_add_action_or_reset(), thanks.

Will
