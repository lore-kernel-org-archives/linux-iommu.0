Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79604286B6
	for <iommu@lists.linux.dev>; Wed, 13 Dec 2023 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eljD2EsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B942AC433C8;
	Wed, 13 Dec 2023 13:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702474026;
	bh=Vu4tH6NoZiRIiSTSRBcXtGlXq8JD/ureEjJXGIWGJ2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eljD2EsQSBnWdBWlRNT6j4/+o8diULNUE66pnBZNx8SgFxAt02x8tnEPVautxnAVz
	 Uy9BPMct8QtnhYrQYXm1xbbIh63Q3PEXNTWSJXW+dHYcFs/PCqCvbVJ3o03M7UkT5e
	 wjlw5C+sPqwlCi6+kVd5V1sI/GKLOfGkxjiW3TUrluADJU9ZOONc677/m4BalNM7y3
	 uTONBGoC/dJQefKCwsqCGv3oYduAruZk0/B6nSqy+/CMMV94HT+r00yxbquA1OJqf4
	 zx957K8Xyz73u13oZhBscG6+cztqDnwrab0ZDiDK07hYxO65uv2WfO4H4CK/IPMtRc
	 UEDURCH+3ucvQ==
Date: Wed, 13 Dec 2023 13:27:01 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Message-ID: <20231213132700.GC31729@willie-the-truck>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132651.GA29569@willie-the-truck>
 <20231212140307.GD3014157@nvidia.com>
 <20231212141023.GA29699@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212141023.GA29699@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 02:10:23PM +0000, Will Deacon wrote:
> On Tue, Dec 12, 2023 at 10:03:07AM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 12, 2023 at 01:26:51PM +0000, Will Deacon wrote:
> > > Why do we need to handle the 'dev && !cfg' case here, instead g
> > > returning NULL?
> > 
> > dev && !cfg is impossible these days, so we can shuffle the if and
> > then just crash on that case like the other drivers do.
> 
> Thanks, that would simplify it a little.

Folded in the diff below.

Will

--->8

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 536e47e3a65a..b0a6b367d8a2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -861,7 +861,6 @@ static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
 
 static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 {
-	struct arm_smmu_master_cfg *cfg = NULL;
 	struct arm_smmu_domain *smmu_domain;
 
 	/*
@@ -876,13 +875,10 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->cb_lock);
 
-	if (dev)
-		cfg = dev_iommu_priv_get(dev);
-	if (cfg) {
-		int ret;
+	if (dev) {
+		struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
 
-		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
-		if (ret) {
+		if (arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev)) {
 			kfree(smmu_domain);
 			return NULL;
 		}
