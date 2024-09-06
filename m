Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A311D31A6
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638032; cv=none; b=s9iCY1EVQeMLHrfuOyWE/kmI4fDuer0Ezq2G9kH0YIOuP4cykKQw1LSqSnF1GhM/UEn7e/+p2jE0faHi/08WC/OI5kyrcazfQfMz6tZ5azNC3b1obgIgkMaKuJPDvno+sMppsczdjOrEiXq0avtMhxCuFIh/n/asIQxlziZy3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638032; c=relaxed/simple;
	bh=3n4uFWmGNrY6fUUHiiFlg861B3W1rHG+cmit8+vyGFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ6V4smRjRkWlJbDrlVBpn8WTIUblwNTRSUShJArfdpfXLc69RFbHFUHpXZP6pNYpdwukk2XKo1dmd+JOek1YFJ1Wx9OJ6Jpf0XlP3ubgPEARvyzKjja+nPTMwgHVasDaHkJi3UUERUFg6d68R856RukfzVr+22bfnCG5CKjz0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ddhQxWef; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ddhQxWef"
Received: from DESKTOP-0403QTC. (unknown [50.53.30.84])
	by linux.microsoft.com (Postfix) with ESMTPSA id 736D420B742F;
	Fri,  6 Sep 2024 08:53:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 736D420B742F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725638024;
	bh=dhAAxzw1xFRgF69XavoCwMzTfsG/qTXxokC1sfRlo18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ddhQxWefplbTwLcvAfLUySDnemE6h5j0s+jB74N0VHX7ETyITa/ZLiNYVuu2VbKl/
	 4FTpB0LgaLTK6PMKfQqaUC7c1ZMGeh0C9JKUD9TMx1A7UKIMq6zJaCAu86BB3049mx
	 7k+trQ0Q6DTu1wCnyLdzc0lVKhPsaEhdMSYSaHdA=
Date: Fri, 6 Sep 2024 08:53:43 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
 <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
 <ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
 <santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>
Subject: Re: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Message-ID: <20240906085343.615b9489@DESKTOP-0403QTC.>
In-Reply-To: <20240906121308.5013-3-suravee.suthikulpanit@amd.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
	<20240906121308.5013-3-suravee.suthikulpanit@amd.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Suravee,

On Fri, 6 Sep 2024 12:13:05 +0000
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> The current implementation does not follow 128-bit write requirement
> to update DTE as specified in the AMD I/O Virtualization Techonology
> (IOMMU) Specification.
> 
> Therefore, modify the struct dev_table_entry to contain union of u128
> data array, and introduce two helper functions:
> 
>   * update_dte256() to update DTE using two 128-bit cmpxchg
>     operations to update 256-bit DTE with the modified structure.
> 
>   * get_dte256() to copy 256-bit DTE to the provided structrue.
> 
> In addition, when access/update 256-bit DTE, it needs to be locked
> to prevent cmpxchg128 failure and data tearing. Therefore, introduce
> a per-DTE spin_lock struct dev_data.dte_lock to provide
> synchronization across get_dte256() and update_dte256().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 ++-
>  drivers/iommu/amd/iommu.c           | 80
> +++++++++++++++++++++++++---- 2 files changed, 76 insertions(+), 10
> deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h
> b/drivers/iommu/amd/amd_iommu_types.h index
> c9f9a598eb82..1836da2d9e60 100644 ---
> a/drivers/iommu/amd/amd_iommu_types.h +++
> b/drivers/iommu/amd/amd_iommu_types.h @@ -833,6 +833,7 @@ struct
> devid_map { struct iommu_dev_data {
>  	/*Protect against attach/detach races */
>  	spinlock_t lock;
> +	spinlock_t dte_lock;              /* DTE lock for 256-bit
> access */ 
>  	struct list_head list;		  /* For
> domain->dev_list */ struct llist_node dev_data_list;  /* For global
> dev_data_list */ @@ -883,7 +884,10 @@ extern struct amd_iommu
> *amd_iommus[MAX_IOMMUS];
>   * Structure defining one entry in the device table
>   */
>  struct dev_table_entry {
> -	u64 data[4];
> +	union {
> +		u64 data[4];
> +		u128 data128[2];
> +	};
>  };
>  
>  /*
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 87c5385ce3f2..b994e7837306 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -85,6 +85,45 @@ static void set_dte_entry(struct amd_iommu *iommu,
>   *
>   ****************************************************************************/
>  
> +static void update_dte256(struct amd_iommu *iommu, struct
> iommu_dev_data *dev_data,
> +			  struct dev_table_entry *new)
> +{
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
> +	struct dev_table_entry old;
> +	u128 tmp;
> +
> +	lockdep_assert_held(&dev_data->dte_lock);
> +
> +	old.data128[0] = ptr->data128[0];
> +	old.data128[1] = ptr->data128[1];
> +
> +	tmp = cmpxchg128(&ptr->data128[1], old.data128[1],
> new->data128[1]);
> +	if (tmp == old.data128[1]) {
If you are able to deal with the failure, why not use try_cmpxchg128
for the hi 128 bit also? It is more efficient.

> +		if (!try_cmpxchg128(&ptr->data128[0],
> &old.data128[0], new->data128[0])) {
> +			/* Restore hi 128-bit */
> +			cmpxchg128(&ptr->data128[1],
> new->data128[1], tmp);
> +			pr_err("%s: Failed. devid=%#x,
> dte=%016llx:%016llx:%016llx:%016llx\n",
> +			       __func__, dev_data->devid,
> new->data[0], new->data[1],
> +			       new->data[2], new->data[3]);
> +		}
> +	}
> +}
> +
> +static void get_dte256(struct amd_iommu *iommu, struct
> iommu_dev_data *dev_data,
> +		      struct dev_table_entry *dte)
> +{
> +	struct dev_table_entry *ptr;
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +
> +	lockdep_assert_held(&dev_data->dte_lock);
> +
> +	ptr = &dev_table[dev_data->devid];
> +
> +	dte->data128[0] = ptr->data128[0];
> +	dte->data128[1] = ptr->data128[1];
> +}
> +
>  static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain
> *pdom) {
>  	return (pdom && (pdom->pd_mode == PD_MODE_V2));
> @@ -205,6 +244,7 @@ static struct iommu_dev_data
> *alloc_dev_data(struct amd_iommu *iommu, u16 devid) return NULL;
>  
>  	spin_lock_init(&dev_data->lock);
> +	spin_lock_init(&dev_data->dte_lock);
>  	dev_data->devid = devid;
>  	ratelimit_default_init(&dev_data->rs);
>  
> @@ -232,9 +272,11 @@ static struct iommu_dev_data
> *search_dev_data(struct amd_iommu *iommu, u16 devid 
>  static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
>  {
> +	struct dev_table_entry dte;
>  	struct amd_iommu *iommu;
> -	struct dev_table_entry *dev_table;
> +	struct iommu_dev_data *dev_data, *alias_data;
>  	u16 devid = pci_dev_id(pdev);
> +	int ret;
>  
>  	if (devid == alias)
>  		return 0;
> @@ -243,13 +285,28 @@ static int clone_alias(struct pci_dev *pdev,
> u16 alias, void *data) if (!iommu)
>  		return 0;
>  
> -	amd_iommu_set_rlookup_table(iommu, alias);
> -	dev_table = get_dev_table(iommu);
> -	memcpy(dev_table[alias].data,
> -	       dev_table[devid].data,
> -	       sizeof(dev_table[alias].data));
> +	/* Get DTE for pdev */
> +	dev_data = dev_iommu_priv_get(&pdev->dev);
> +	if (!dev_data)
> +		return -EINVAL;
>  
> -	return 0;
> +	spin_lock(&dev_data->dte_lock);
> +	get_dte256(iommu, dev_data, &dte);
> +	spin_unlock(&dev_data->dte_lock);
> +
> +	/* Setup for alias */
> +	alias_data = search_dev_data(iommu, alias);
> +	if (!alias_data) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	spin_lock(&alias_data->dte_lock);
> +	update_dte256(iommu, alias_data, &dte);
> +	amd_iommu_set_rlookup_table(iommu, alias);
> +	spin_unlock(&alias_data->dte_lock);
> +out:
> +	return ret;
>  }
>  
>  static void clone_aliases(struct amd_iommu *iommu, struct device
> *dev) @@ -583,10 +640,15 @@ static void
> amd_iommu_uninit_device(struct device *dev) static void
> dump_dte_entry(struct amd_iommu *iommu, u16 devid) {
>  	int i;
> -	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dev_table_entry dte;
> +	struct iommu_dev_data *dev_data = find_dev_data(iommu,
> devid); +
> +	spin_lock(&dev_data->dte_lock);
> +	get_dte256(iommu, dev_data, &dte);
> +	spin_unlock(&dev_data->dte_lock);
>  
>  	for (i = 0; i < 4; ++i)
> -		pr_err("DTE[%d]: %016llx\n", i,
> dev_table[devid].data[i]);
> +		pr_err("DTE[%d]: %016llx\n", i, dte.data[i]);
>  }
>  
>  static void dump_command(unsigned long phys_addr)

