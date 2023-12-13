Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3458286B6
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMR/eR2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C32C433C7;
	Wed, 13 Dec 2023 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702474017;
	bh=tTkWgnCf7qbAjRUYgLwtyMCwD8/VID33RXzYSjUxeKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMR/eR2VL/VA6p82WsMjF2GGJtOiJLWXnVIT1WE9AoL+dVSTzg0nQI/5hz50pVkkq
	 WxgxKBs7T0iDBBdcGYq0SpVxA1GqLqMh0ad6AmHVK0ySkYXbX5ohBv3OsHuLAz6UQE
	 LwXFUji67wWpvKCtsHx29PHthpU42DEkX9QRpj/crqCsrlrzgm72ssVjJorWdglGYv
	 DWWM8UlYSomqPX7eudaD9jVLeOFHWawB3fuL01K523XAvsTiXSbuplcfURCdj5LIp/
	 wI9iNEgKefS8IJ7NWizgWtpu8iRE6zHK0izmW2lu3sr+c3tX4Ndm0xBuEDGmmgwEvw
	 qtKokhKFFhOTg==
Date: Wed, 13 Dec 2023 13:26:52 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu: Convert to a global static
 identity domain
Message-ID: <20231213132651.GB31729@willie-the-truck>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <2-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132708.GB29569@willie-the-truck>
 <20231212141516.GE3014157@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212141516.GE3014157@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 10:15:16AM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 01:27:08PM +0000, Will Deacon wrote:
> > > +static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> > > +					struct device *dev)
> > > +{
> > > +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> > > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > > +	struct arm_smmu_device *smmu;
> > > +	int ret;
> > > +
> > > +	if (!cfg)
> > > +		return -ENODEV;
> > > +	smmu = cfg->smmu;
> > > +
> > > +	ret = arm_smmu_rpm_get(smmu);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
> > > +
> > > +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> > > +	pm_runtime_use_autosuspend(smmu->dev);
> > 
> > This is cargo-culted from arm_smmu_attach_dev() with the comments dropped
> > and it's not clear at all to me that the autosuspend delay makes any sense
> > for the identity domain.
> 
> Indeed, however it was how it worked before this split up.

Yeah, and I suppose given that I certainly don't have an easy way to test
this, there's a lot to be said for preserving the current behaviour.

> > So I think it would be better to either drop the call to
> > pm_runtime_set_autosuspend_delay() 
> 
> I looked through it more carefully and this does seem like the right
> thing, so I will drop them.

In the interests of getting this queued, I've gone ahead and stuck 'em
in a helper. We can drop the call later, but it would be good to either
test that or get confirmation from Rob that it doesn't break anything
first.

Will

--->8

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dde912f8ef35..dec912c27141 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -82,6 +82,23 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 		pm_runtime_put_autosuspend(smmu->dev);
 }
 
+static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
+{
+	/*
+	 * Setup an autosuspend delay to avoid bouncing runpm state.
+	 * Otherwise, if a driver for a suspended consumer device
+	 * unmaps buffers, it will runpm resume/suspend for each one.
+	 *
+	 * For example, when used by a GPU device, when an application
+	 * or game exits, it can trigger unmapping 100s or 1000s of
+	 * buffers.  With a runpm cycle for each buffer, that adds up
+	 * to 5-10sec worth of reprogramming the context bank, while
+	 * the system appears to be locked up to the user.
+	 */
+	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
+	pm_runtime_use_autosuspend(smmu->dev);
+}
+
 static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
@@ -1141,21 +1158,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	/* Looks ok, so add the device to the domain */
 	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_TRANS,
 				      smmu_domain->cfg.cbndx, fwspec);
-
-	/*
-	 * Setup an autosuspend delay to avoid bouncing runpm state.
-	 * Otherwise, if a driver for a suspended consumer device
-	 * unmaps buffers, it will runpm resume/suspend for each one.
-	 *
-	 * For example, when used by a GPU device, when an application
-	 * or game exits, it can trigger unmapping 100s or 1000s of
-	 * buffers.  With a runpm cycle for each buffer, that adds up
-	 * to 5-10sec worth of reprogramming the context bank, while
-	 * the system appears to be locked up to the user.
-	 */
-	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
-	pm_runtime_use_autosuspend(smmu->dev);
-
+	arm_smmu_rpm_use_autosuspend(smmu);
 rpm_put:
 	arm_smmu_rpm_put(smmu);
 	return ret;
@@ -1178,9 +1181,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 		return ret;
 
 	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
-
-	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
-	pm_runtime_use_autosuspend(smmu->dev);
+	arm_smmu_rpm_use_autosuspend(smmu);
 	arm_smmu_rpm_put(smmu);
 	return 0;
 }
