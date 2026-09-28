Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34982370ADB;
	Mon, 28 Sep 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618940; cv=none; b=KSFrs0rMxJ0zUeRCDhsLar+ZaQ/fMOCeGgEFwthLHO3/upFripKYfYDcktqOHS1B84qg6CqR8AqDdxOWlC4zWgu+Yz86sFF1faQh2RR06AG85OdkdxuDWWzg+LWcuxtBCKj5jXTVvdpkat6BWzCub65XULr43JuDBisQO0f6NvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618940; c=relaxed/simple;
	bh=LtIqr0CIJFLR+nLRxDp+OfeiwO+39zHZGdsr3O+0Zhk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZRd2ZeHUnSqnVIlUJZjjpYLchi9iG48CiFiPfoqNbazxs4fOn58KIwlKIunnuXF0Lzc05knoSF7cyacx2zYTKJaVAZ892Vz1+UTMNzJ7OBqNKR172sa7pW+9aTYnwJTO3nIB/LA+3pErZZW21VEWE9gINiefG4QGbjtQTGuAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OhzR8DeS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OhzR8DeS"
Received: from localhost (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C4AE20B7166;
	Mon, 28 Sep 2026 11:08:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C4AE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790618885;
	bh=ktWdNt9xNw4TRrZB7z7m2v01mS6rN8HoJOQeaS7hSlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OhzR8DeSfQXFomwGXHp5rpEPj734HoxWE4Qng34gvVNvbu4aHTmZ/TFkofZxL7ITj
	 TvFS84+zrrEXhT69uorUiBvx8xAprOryBraAcFUfH3b5Sxr3+pGH6qU+hFvLNKlZDO
	 hJqLtmPOYQlsbZb0Kb4mPAb8OPX09kPtzymuEH1o=
Date: Mon, 28 Sep 2026 11:08:54 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alexey Kardashevskiy
 <aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
 <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
 <yilun.xu@linux.intel.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini
 <pbonzini@redhat.com>, jacob.pan@linux.microsoft.com
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260928110854.00003ff0@linux.microsoft.com>
In-Reply-To: <20260928161738.GB1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
	<20260917140159.1163281-6-aneesh.kumar@kernel.org>
	<179027891416.104879.10365675178574704349.b4-review@b4>
	<yq5ald8pkhj7.fsf@kernel.org>
	<20260925122305.GG9354@nvidia.com>
	<yq5a5wzpr7b9.fsf@kernel.org>
	<20260928121147.GP9354@nvidia.com>
	<yq5azex1peqt.fsf@kernel.org>
	<20260928161738.GB1616761@nvidia.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 28 Sep 2026 13:17:38 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 28, 2026 at 09:09:06PM +0530, Aneesh Kumar K.V wrote:
> 
> > Does that mean the SMMU driver will return viommu_ops before
> > iommu_ops->viommu_init() is called? If so, should viommu_init() be
> > moved into viommu_ops?  
> 
> That's probably the cleanest arrangement, yeah. Then the TSM ops are
> just the same 'get_viommu_ops' call under TSM and it is easy to put in
> a flag 'must have null hwpt' that goes at the right point.
> 
This should also work for the parentless hypervisor vIOMMU in my RFC:
https://lore.kernel.org/linux-iommu/20260925190742.1575380-1-jacob.pan@linux.microsoft.com/T/#t

I will give below a try, I currently have below (can be avoided if
get_viommu_ops() can simply return NULL for the hypervisor type):

size_t amd_iommufd_get_viommu_size(struct device *dev, enum
iommu_viommu_type viommu_type) {
+	/* AMD vIOMMUs require a nesting parent; hypervisor vIOMMUs
are parentless. */
+	if (viommu_type == IOMMU_VIOMMU_TYPE_HYPERVISOR)
+		return 0;
+

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 4dc306a4b5c620..269f67346ac760 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3214,8 +3214,7 @@ const struct iommu_ops amd_iommu_ops = {
>  	.is_attach_deferred = amd_iommu_is_attach_deferred,
>  	.def_domain_type = amd_iommu_def_domain_type,
>  	.page_response = amd_iommu_page_response,
> -	.get_viommu_size = amd_iommufd_get_viommu_size,
> -	.viommu_init = amd_iommufd_viommu_init,
> +	.get_viommu_ops = amd_iommufd_get_viommu_ops,
>  };
>  
>  #ifdef CONFIG_IRQ_REMAP
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index 52300b867c1f20..e86890a59865db 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -32,11 +32,19 @@ void *amd_iommufd_hw_info(struct device *dev, u32
> *length, enum iommu_hw_info_ty return hwinfo;
>  }
>  
> -size_t amd_iommufd_get_viommu_size(struct device *dev, enum
> iommu_viommu_type viommu_type) +static size_t
> amd_iommufd_get_viommu_size(struct device *dev,
> +					  enum iommu_viommu_type
> viommu_type) {
>  	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
>  }
>  
> +const struct iommufd_viommu_ops *
> +amd_iommufd_get_viommu_ops(struct device *dev,
> +			   enum iommu_viommu_type viommu_type)
> +{
> +	return &amd_viommu_ops;
> +}
> +
>  int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct
> iommu_domain *parent, const struct iommu_user_data *user_data)
>  {
> @@ -73,5 +81,7 @@ static void amd_iommufd_viommu_destroy(struct
> iommufd_viommu *viommu)
>   * struct iommufd_viommu_ops - vIOMMU specific operations
>   */
>  static const struct iommufd_viommu_ops amd_viommu_ops = {
> +	.get_viommu_size = amd_iommufd_get_viommu_size,
> +	.viommu_init = amd_iommufd_viommu_init,
>  	.destroy = amd_iommufd_viommu_destroy,
>  };
> diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
> index 62e9e1bebfbe59..6729f8f37506b7 100644
> --- a/drivers/iommu/amd/iommufd.h
> +++ b/drivers/iommu/amd/iommufd.h
> @@ -8,13 +8,12 @@
>  
>  #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
>  void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum
> iommu_hw_info_type *type); -size_t amd_iommufd_get_viommu_size(struct
> device *dev, enum iommu_viommu_type viommu_type); -int
> amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct
> iommu_domain *parent,
> -			    const struct iommu_user_data *user_data);
> +const struct iommufd_viommu_ops *
> +amd_iommufd_get_viommu_ops(struct device *dev,
> +			   enum iommu_viommu_type viommu_type);
>  #else
>  #define amd_iommufd_hw_info NULL
> -#define amd_iommufd_viommu_init NULL
> -#define amd_iommufd_get_viommu_size NULL
> +#define amd_iommufd_get_viommu_ops NULL
>  #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>  
>  #endif /* AMD_IOMMUFD_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c index
> ab1078a97d801e..b848219f91c984 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c @@ -532,20
> +532,28 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu
> *viommu, return ret; }
>  
> +static size_t arm_vsmmu_get_size(struct device *dev,
> +				 enum iommu_viommu_type viommu_type)
> +{
> +	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
> +}
> +
>  static const struct iommufd_viommu_ops arm_vsmmu_ops = {
> +	.get_viommu_size = arm_vsmmu_get_size,
> +	.viommu_init = arm_vsmmu_init,
>  	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
>  	.cache_invalidate = arm_vsmmu_cache_invalidate,
>  	.vdevice_init = arm_vsmmu_vdevice_init,
>  };
>  
> -size_t arm_smmu_get_viommu_size(struct device *dev,
> -				enum iommu_viommu_type viommu_type)
> +const struct iommufd_viommu_ops *
> +arm_smmu_get_viommu_ops(struct device *dev, enum iommu_viommu_type
> viommu_type) {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct arm_smmu_device *smmu = master->smmu;
>  
>  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> -		return 0;
> +		return NULL;
>  
>  	/*
>  	 * FORCE_SYNC is not set with FEAT_NESTING. Some study of
> the exact HW @@ -553,7 +561,7 @@ size_t
> arm_smmu_get_viommu_size(struct device *dev,
>  	 * any change to remove this.
>  	 */
>  	if (WARN_ON(smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
> -		return 0;
> +		return NULL;
>  
>  	/*
>  	 * Must support some way to prevent the VM from bypassing
> the cache @@ -565,14 +573,14 @@ size_t
> arm_smmu_get_viommu_size(struct device *dev, */
>  	if (!arm_smmu_master_canwbs(master) &&
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> -		return 0;
> +		return NULL;
>  
>  	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
> -		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
> +		return &arm_vsmmu_ops;
>  
> -	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_size)
> -		return 0;
> -	return smmu->impl_ops->get_viommu_size(viommu_type);
> +	if (!smmu->impl_ops || !smmu->impl_ops->get_viommu_ops)
> +		return NULL;
> +	return smmu->impl_ops->get_viommu_ops(viommu_type);
>  }
>  
>  int arm_vsmmu_init(struct iommufd_viommu *viommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c index
> 5732f3ba0122d6..eaf7fb1f40453f 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c @@ -4389,8 +4389,7 @@
> static const struct iommu_ops arm_smmu_ops = {
> .get_resv_regions	= arm_smmu_get_resv_regions,
> .page_response		= arm_smmu_page_response,
> .def_domain_type	= arm_smmu_def_domain_type,
> -	.get_viommu_size	= arm_smmu_get_viommu_size,
> -	.viommu_init		= arm_vsmmu_init,
> +	.get_viommu_ops		= arm_smmu_get_viommu_ops,
>  	.user_pasid_table	= 1,
>  	.owner			= THIS_MODULE,
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
> @@ -5489,8 +5488,8 @@ static struct arm_smmu_device
> *arm_smmu_impl_probe(struct arm_smmu_device *smmu) 
>  	ops = new_smmu->impl_ops;
>  	if (ops) {
> -		/* get_viommu_size and vsmmu_init ops must be paired
> */
> -		if (WARN_ON(!ops->get_viommu_size !=
> !ops->vsmmu_init)) {
> +		/* get_viommu_ops and vsmmu_init ops must be paired
> */
> +		if (WARN_ON(!ops->get_viommu_ops !=
> !ops->vsmmu_init)) { ret = -EINVAL;
>  			goto err_remove;
>  		}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h index
> 50f8321e979cef..6675f4232be075 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h +++
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h @@ -886,7 +886,8 @@
> struct arm_smmu_impl_ops { */
>  	void *(*hw_info)(struct arm_smmu_device *smmu, u32 *length,
>  			 enum iommu_hw_info_type *type);
> -	size_t (*get_viommu_size)(enum iommu_viommu_type
> viommu_type);
> +	const struct iommufd_viommu_ops *(*get_viommu_ops)(
> +		enum iommu_viommu_type viommu_type);
>  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
>  			  const struct iommu_user_data *user_data);
>  };
> @@ -1260,8 +1261,8 @@ struct arm_vsmmu {
>  #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
>  void *arm_smmu_hw_info(struct device *dev, u32 *length,
>  		       enum iommu_hw_info_type *type);
> -size_t arm_smmu_get_viommu_size(struct device *dev,
> -				enum iommu_viommu_type viommu_type);
> +const struct iommufd_viommu_ops *
> +arm_smmu_get_viommu_ops(struct device *dev, enum iommu_viommu_type
> viommu_type); int arm_vsmmu_init(struct iommufd_viommu *viommu,
>  		   struct iommu_domain *parent_domain,
>  		   const struct iommu_user_data *user_data);
> @@ -1276,9 +1277,9 @@ arm_vsmmu_alloc_domain_nested(struct
> iommufd_viommu *viommu, u32 flags, int
> arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu, struct
> iommu_user_data_array *array); #else
> -#define arm_smmu_get_viommu_size NULL
> -#define arm_smmu_hw_info NULL
> +#define arm_smmu_get_viommu_ops NULL
>  #define arm_vsmmu_init NULL
> +#define arm_smmu_hw_info NULL
>  #define arm_vsmmu_alloc_domain_nested NULL
>  #define arm_vsmmu_cache_invalidate NULL
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c index
> 6644075c1431ec..bcb5f3efdb190d 100644 ---
> a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c +++
> b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c @@ -892,11 +892,14
> @@ static void *tegra241_cmdqv_hw_info(struct arm_smmu_device *smmu,
> u32 *length, return info; }
>  
> -static size_t tegra241_cmdqv_get_vintf_size(enum iommu_viommu_type
> viommu_type) +static const struct iommufd_viommu_ops
> tegra241_cmdqv_viommu_ops; +
> +static const struct iommufd_viommu_ops *
> +tegra241_cmdqv_get_viommu_ops(enum iommu_viommu_type viommu_type)
>  {
>  	if (viommu_type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV)
> -		return 0;
> -	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
> +		return NULL;
> +	return &tegra241_cmdqv_viommu_ops;
>  }
>  
>  static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
> @@ -907,7 +910,7 @@ static struct arm_smmu_impl_ops
> tegra241_cmdqv_impl_ops = { .device_remove = tegra241_cmdqv_remove,
>  	/* For user-space use */
>  	.hw_info = tegra241_cmdqv_hw_info,
> -	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
> +	.get_viommu_ops = tegra241_cmdqv_get_viommu_ops,
>  	.vsmmu_init = tegra241_cmdqv_init_vintf_user,
>  };
>  
> @@ -1289,7 +1292,15 @@ static int tegra241_vintf_init_vsid(struct
> iommufd_vdevice *vdev) return 0;
>  }
>  
> -static struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> +static size_t tegra241_cmdqv_get_vintf_size(struct device *dev,
> +					    enum iommu_viommu_type
> viommu_type) +{
> +	return VIOMMU_STRUCT_SIZE(struct tegra241_vintf, vsmmu.core);
> +}
> +
> +static const struct iommufd_viommu_ops tegra241_cmdqv_viommu_ops = {
> +	.get_viommu_size = tegra241_cmdqv_get_vintf_size,
> +	.viommu_init = arm_vsmmu_init,
>  	.destroy = tegra241_cmdqv_destroy_vintf_user,
>  	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
>  	/* Non-accelerated commands will be still handled by the
> kernel */ diff --git a/drivers/iommu/iommufd/selftest.c
> b/drivers/iommu/iommufd/selftest.c index
> 25387969ab7536..3c997de987247b 100644 ---
> a/drivers/iommu/iommufd/selftest.c +++
> b/drivers/iommu/iommufd/selftest.c @@ -767,7 +767,15 @@ static int
> mock_hw_queue_init_phys(struct iommufd_hw_queue *hw_queue, u32 index,
> return rc; }
>  
> -static struct iommufd_viommu_ops mock_viommu_ops = {
> +static size_t mock_get_viommu_size(struct device *dev,
> +				   enum iommu_viommu_type
> viommu_type); +static int mock_viommu_init(struct iommufd_viommu
> *viommu,
> +			    struct iommu_domain *parent_domain,
> +			    const struct iommu_user_data *user_data);
> +
> +static const struct iommufd_viommu_ops mock_viommu_ops = {
> +	.get_viommu_size = mock_get_viommu_size,
> +	.viommu_init = mock_viommu_init,
>  	.destroy = mock_viommu_destroy,
>  	.alloc_domain_nested = mock_viommu_alloc_domain_nested,
>  	.cache_invalidate = mock_viommu_cache_invalidate,
> @@ -783,6 +791,14 @@ static size_t mock_get_viommu_size(struct device
> *dev, return VIOMMU_STRUCT_SIZE(struct mock_viommu, core);
>  }
>  
> +static const struct iommufd_viommu_ops *
> +mock_get_viommu_ops(struct device *dev, enum iommu_viommu_type
> viommu_type) +{
> +	if (viommu_type != IOMMU_VIOMMU_TYPE_SELFTEST)
> +		return NULL;
> +	return &mock_viommu_ops;
> +}
> +
>  static int mock_viommu_init(struct iommufd_viommu *viommu,
>  			    struct iommu_domain *parent_domain,
>  			    const struct iommu_user_data *user_data)
> @@ -854,8 +870,7 @@ static const struct iommu_ops mock_ops = {
>  	.probe_device = mock_probe_device,
>  	.page_response = mock_domain_page_response,
>  	.user_pasid_table = true,
> -	.get_viommu_size = mock_get_viommu_size,
> -	.viommu_init = mock_viommu_init,
> +	.get_viommu_ops = mock_get_viommu_ops,
>  };
>  
>  static void mock_domain_free_nested(struct iommu_domain *domain)
> diff --git a/drivers/iommu/iommufd/viommu.c
> b/drivers/iommu/iommufd/viommu.c index f7951057a1e564..25eef8aef3e84e
> 100644 --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -26,7 +26,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd
> *ucmd) struct iommufd_viommu *viommu;
>  	struct iommufd_device *idev;
>  	struct iommu_device *iommu_dev;
> -	const struct iommu_ops *ops;
> +	const struct iommufd_viommu_ops *ops;
>  	size_t viommu_size;
>  	int rc;
>  
> @@ -42,8 +42,12 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd
> *ucmd) rc = -EOPNOTSUPP;
>  		goto out_put_idev;
>  	}
> -	ops = iommu_dev->ops;
> -	if (!ops->get_viommu_size || !ops->viommu_init) {
> +	if (!iommu_dev->ops->get_viommu_ops) {
> +		rc = -EOPNOTSUPP;
> +		goto out_put_idev;
> +	}
> +	ops = iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
> +	if (!ops || WARN_ON_ONCE(!ops->get_viommu_size ||
> !ops->viommu_init)) { rc = -EOPNOTSUPP;
>  		goto out_put_idev;
>  	}
> @@ -100,8 +104,8 @@ int iommufd_viommu_alloc_ioctl(struct
> iommufd_ucmd *ucmd) if (rc)
>  		goto out_put_hwpt;
>  
> -	/* It is a driver bug that viommu->ops isn't filled */
> -	if (WARN_ON_ONCE(!viommu->ops)) {
> +	/* It is a driver bug if init selects a different ops table
> */
> +	if (WARN_ON_ONCE(viommu->ops != ops)) {
>  		rc = -EOPNOTSUPP;
>  		goto out_put_hwpt;
>  	}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 05f7cee1375eed..b37b09f934c1dd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -46,6 +46,7 @@ struct iommu_dma_msi_cookie;
>  struct iommu_fault_param;
>  struct iommufd_ctx;
>  struct iommufd_viommu;
> +struct iommufd_viommu_ops;
>  struct msi_desc;
>  struct msi_msg;
>  
> @@ -669,16 +670,8 @@ __iommu_copy_struct_to_user(const struct
> iommu_user_data *dst_data,
>   *		- IOMMU_DOMAIN_DMA: must use a dma domain
>   *		- 0: use the default setting
>   * @default_domain_ops: the default ops for domains
> - * @get_viommu_size: Get the size of a driver-level vIOMMU structure
> for a given
> - *                   @dev corresponding to @viommu_type. Driver
> should return 0
> - *                   if vIOMMU isn't supported accordingly. It is
> required for
> - *                   driver to use the VIOMMU_STRUCT_SIZE macro to
> sanitize the
> - *                   driver-level vIOMMU structure related to the
> core one
> - * @viommu_init: Init the driver-level struct of an iommufd_viommu
> on a physical
> - *               IOMMU instance @viommu->iommu_dev, as the set of
> virtualization
> - *               resources shared/passed to user space IOMMU
> instance. Associate
> - *               it with a nesting @parent_domain. It is required
> for driver to
> - *               set @viommu->ops pointing to its own viommu_ops
> + * @get_viommu_ops: Return the vIOMMU operations supported by @dev
> for
> + *                  @viommu_type, or NULL if the type is unsupported
>   * @owner: Driver module providing these ops
>   * @identity_domain: An always available, always attachable identity
>   *                   translation.
> @@ -729,11 +722,8 @@ struct iommu_ops {
>  
>  	int (*def_domain_type)(struct device *dev);
>  
> -	size_t (*get_viommu_size)(struct device *dev,
> -				  enum iommu_viommu_type
> viommu_type);
> -	int (*viommu_init)(struct iommufd_viommu *viommu,
> -			   struct iommu_domain *parent_domain,
> -			   const struct iommu_user_data *user_data);
> +	const struct iommufd_viommu_ops *(*get_viommu_ops)(
> +		struct device *dev, enum iommu_viommu_type
> viommu_type); 
>  	const struct iommu_domain_ops *default_domain_ops;
>  	struct module *owner;
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 3087f5b2def848..a13fa3d447467a 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -142,6 +142,16 @@ struct iommufd_hw_queue {
>  
>  /**
>   * struct iommufd_viommu_ops - vIOMMU specific operations
> + * @get_viommu_size: Get the size of a driver-level vIOMMU structure
> for a given
> + *                   @dev corresponding to @viommu_type. Driver
> should return 0
> + *                   if vIOMMU isn't supported accordingly. It is
> required for
> + *                   driver to use the VIOMMU_STRUCT_SIZE macro to
> sanitize the
> + *                   driver-level vIOMMU structure related to the
> core one
> + * @viommu_init: Init the driver-level struct of an iommufd_viommu
> on a physical
> + *               IOMMU instance @viommu->iommu_dev, as the set of
> virtualization
> + *               resources shared/passed to user space IOMMU
> instance. Associate
> + *               it with a nesting @parent_domain. It is required
> for driver to
> + *               set @viommu->ops pointing to its own viommu_ops
>   * @destroy: Clean up all driver-specific parts of an
> iommufd_viommu. The memory
>   *           of the vIOMMU will be free-ed by iommufd core after
> calling this op
>   * @alloc_domain_nested: Allocate a IOMMU_DOMAIN_NESTED on a vIOMMU
> that holds a @@ -184,6 +194,11 @@ struct iommufd_hw_queue {
>   *                      does, it should set it to the
> @hw_queue->destroy pointer */
>  struct iommufd_viommu_ops {
> +	size_t (*get_viommu_size)(struct device *dev,
> +				  enum iommu_viommu_type
> viommu_type);
> +	int (*viommu_init)(struct iommufd_viommu *viommu,
> +			   struct iommu_domain *parent_domain,
> +			   const struct iommu_user_data *user_data);
>  	void (*destroy)(struct iommufd_viommu *viommu);
>  	struct iommu_domain *(*alloc_domain_nested)(
>  		struct iommufd_viommu *viommu, u32 flags,

