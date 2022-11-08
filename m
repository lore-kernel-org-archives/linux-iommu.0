Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AEE28EE
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 13:20:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7360C433D6;
	Tue,  8 Nov 2022 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667913651;
	bh=F1MrMjvh/L1F4zxWBX7r8xXYoMUO4ZXMTGWde/+UFd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZaBgX2VaqGZgOh/2C0l++qPRlM8ueDrM9SLeSVBvUQEQ0+CNdo356p2qirP1dEgJ
	 p/H4iy/1oAwn0ait0PvZKuBfPMAnQDFDkXJtKbJiot6gOdqiqVGf0/w7jk8vpPsbFI
	 n39iYmDpzjVLSA1MXWr/cDCfrGf3A/+OHru3RiE4kPX3W97ALdEM6/h3yPQ0zjGCJZ
	 q1ivEC4oeiOD9WI4AegBBhj03IgPbMrHzOGR+4pXQwzPuGiX7waZ0und1RxcXF1J+j
	 MXeA9iQvAXVNy8WS4w2xu8rFWvjxhzh0obhV1OFgD6jSVycIiG4hb8lh5dBxyqba2D
	 JHeBEQ2z21fvg==
Date: Tue, 8 Nov 2022 13:20:42 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	kevin.tian@intel.com, quic_jjohnson@quicinc.com,
	suravee.suthikulpanit@amd.com, robdclark@gmail.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	jean-philippe@linaro.org, tglx@linutronix.de,
	shameerali.kolothum.thodi@huawei.com, christophe.jaillet@wanadoo.fr,
	yangyicong@hisilicon.com, yangyingliang@huawei.com,
	quic_saipraka@quicinc.com, jon@solid-run.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <20221108132041.GB22816@willie-the-truck>
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
 <20221107152645.GD21002@willie-the-truck>
 <Y2mfaG1/6hd1qykW@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2mfaG1/6hd1qykW@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Nov 07, 2022 at 04:14:32PM -0800, Nicolin Chen wrote:
> On Mon, Nov 07, 2022 at 03:26:45PM +0000, Will Deacon wrote:
> 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index ba47c73f5b8c..01fd7df16cb9 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >                       goto out_unlock;
> > >               }
> > >       } else if (smmu_domain->smmu != smmu) {
> > > -             dev_err(dev,
> > > -                     "cannot attach to SMMU %s (upstream of %s)\n",
> > > -                     dev_name(smmu_domain->smmu->dev),
> > > -                     dev_name(smmu->dev));
> > > -             ret = -ENXIO;
> > > +             ret = -EINVAL;
> > >               goto out_unlock;
> > >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > >                  master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> > > -             dev_err(dev,
> > > -                     "cannot attach to incompatible domain (%u SSID bits != %u)\n",
> > > -                     smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
> > >               ret = -EINVAL;
> > >               goto out_unlock;
> > >       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > >                  smmu_domain->stall_enabled != master->stall_enabled) {
> > > -             dev_err(dev, "cannot attach to stall-%s domain\n",
> > > -                     smmu_domain->stall_enabled ? "enabled" : "disabled");
> > >               ret = -EINVAL;
> > >               goto out_unlock;
> > >       }
> 
> > I think it would be helpful to preserve these messages using
> > dev_err_ratelimited() so that attach failure can be diagnosed without
> > having to hack the messages back into the driver.
> 
> Thank you for the review.
> 
> The change is already picked up last week. Yet, I can add prints
> back with a followup patch, if no one has a problem with that.

Sorry, I fell behind with upstream so I got to this late. A patch on top
would be fantastic!

> Also, I am not quite sure what the use case would be to have an
> error print. Perhaps dev_dbg() would be more fitting if it is
> just for diagnosis?

Sure, that works for me. I think the messages are useful for folks
triggering this path e.g. via sysfs but if they're limited to debug I think
that's better than removing them altogether.

Cheers,

Will
