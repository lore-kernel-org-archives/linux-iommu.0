Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D03A29A2
	for <iommu@lists.linux.dev>; Thu, 16 Mar 2023 18:42:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8142F4;
	Thu, 16 Mar 2023 11:42:57 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09A373F67D;
	Thu, 16 Mar 2023 11:42:11 -0700 (PDT)
Message-ID: <cacb6338-6dc9-e8b6-426c-aeed3104c8af@arm.com>
Date: Thu, 16 Mar 2023 18:42:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, will@kernel.org,
 kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
 <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
 <ZAtS21vqhp7LqA+B@nvidia.com> <ZBJvLsfeIRhV6cME@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZBJvLsfeIRhV6cME@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2023 1:21 am, Nicolin Chen wrote:
> Hi Robin,
> 
> How do you think about Jason's proposal below? I'd like to see
> us come to an agreement on an acceptable solution...

I think it's so thoroughly broken that I suspect Cunningham's law might
be at play, but fine, you win :) Hopefully it's sufficiently obvious how
the other pieces would fit around the patch below. FWIW I'd still prefer
a generic domain->s2_domain pointer rather than any op at all, but I'm
happy enough with this compromise.

Thanks,
Robin.

----->8-----
Subject: [PATCH] iommu/dma: Support MSIs through nested domains

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be in the legacy-VFIO-style case where we're
using host-managed MSIs with an identity mapping at stage 1, where it is
the underlying stage 2 domain which owns an MSI cookie and holds the
corresponding dynamic mappings. Hook up the new op to resolve what we
need from a nested domain.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
  1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 99b2646cb5c7..66b0d5fa49f8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1642,6 +1642,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
  	return NULL;
  }
  
+/*
+ * Nested domains may not have an MSI cookie or accept mappings, but they may
+ * be related to a domain which does, so we let them tell us what they need.
+ */
+static struct iommu_domain *iommu_dma_get_msi_mapping_domain(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
+	    domain->ops->get_msi_mapping_domain)
+		domain = domain->ops->get_msi_mapping_domain(domain);
+	return domain;
+}
+
  /**
   * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
   * @desc: MSI descriptor, will store the MSI page
@@ -1652,7 +1666,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
  {
  	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
  	struct iommu_dma_msi_page *msi_page;
  	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
  
@@ -1685,7 +1699,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
  void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
  {
  	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
  	const struct iommu_dma_msi_page *msi_page;
  
  	msi_page = msi_desc_get_iommu_cookie(desc);
-- 
2.39.2.101.g768bb238c484.dirty

