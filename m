Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D841872
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695866530; x=1727402530;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iUKFS5GB5DGWZui7mOi3K/pjI1nunzjyIYlCw8LrZtM=;
  b=ei/FTsV2XGVYovI84Kn9DDkk/fwQ2PArFiDMVqXTxQKXSjlPqRmXjSUs
   lF9N+v1t6oDNUwLHN8l+6kS4cjLnXzzqAPkiUR1Jbo+cXBTSnaIjJa9Bk
   NhMp53g2FHFpznKlefF0RSzvVKEu/uZCDmRPDmvPqXuP63sen6aX25IwL
   ZLMUyJty5Zx1fVAtNKP+dKxV5qEkyDLsB9IZZ+mSyytLFtWdmpz7l0ewL
   Wpw4baLzS8nPJVCeeAcXaFYQViQE4VgdoHU9qmPryLIeJgAMAwnzJObq3
   qE7yvJRQDBbXMKs8SUMQ7+6wwWzVYz+vwhP6RTbRHQaXmK/D3vT5YJKXX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="367031667"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="367031667"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 19:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="726062558"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="726062558"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 19:01:54 -0700
Message-ID: <8d931037-500f-1dff-5fb6-fe60d2e8af7d@linux.intel.com>
Date: Thu, 28 Sep 2023 09:58:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATH v3 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
Content-Language: en-US
To: Jingqi Liu <Jingqi.liu@intel.com>, iommu@lists.linux.dev,
 Tian Kevin <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20230927151536.67319-1-Jingqi.liu@intel.com>
 <20230927151536.67319-3-Jingqi.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230927151536.67319-3-Jingqi.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/27/23 11:15 PM, Jingqi Liu wrote:
> Add a debugfs directory per pair of {device, pasid} if the mappings of
> its page table are created and destroyed by the iommu_map/unmap()
> interfaces. i.e. /sys/kernel/debug/iommu/intel/<device source id>/<pasid>.
> Create a debugfs file in the directory for users to dump the page
> table corresponding to {device, pasid}. e.g.
> /sys/kernel/debug/iommu/intel/0000:00:02.0/0/domain_translation_struct.
> 
> When attaching device without pasid, create a debugfs file with
> PASID#0, i.e. RID_PASID. When attaching a domain to a pasid of device,
> create a debugfs file with the specified pasid.
> 
> When detaching without pasid, remove the directory and file for
> PASID#0. When detaching with pasid, remove the debugfs directory and
> file of the specified pasid. Remove the entire debugfs directory of
> the specified device for releasing device.
> e.g. /sys/kernel/debug/iommu/intel/0000:00:01.0
> 
> Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 133 ++++++++++++++++++++++++++++++++--
>   drivers/iommu/intel/iommu.c   |  29 ++++++++
>   drivers/iommu/intel/iommu.h   |  12 +++
>   3 files changed, 169 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
> index e2a3c37943a0..50dea53ba87c 100644
> --- a/drivers/iommu/intel/debugfs.c
> +++ b/drivers/iommu/intel/debugfs.c
> @@ -32,6 +32,11 @@ struct iommu_regset {
>   	const char *regs;
>   };
>   
> +struct show_domain_info {
> +	struct device *dev;
> +	ioasid_t pasid;
> +};
> +
>   #define DEBUG_BUFFER_SIZE	1024
>   static char debug_buf[DEBUG_BUFFER_SIZE];
>   
> @@ -111,6 +116,8 @@ static const struct iommu_regset iommu_regs_64[] = {
>   	IOMMU_REGSET_ENTRY(VCRSP),
>   };
>   
> +static struct dentry *intel_iommu_debug;
> +
>   static int iommu_regset_show(struct seq_file *m, void *unused)
>   {
>   	struct dmar_drhd_unit *drhd;
> @@ -673,16 +680,12 @@ static const struct file_operations dmar_perf_latency_fops = {
>   
>   void __init intel_iommu_debugfs_init(void)
>   {
> -	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
> -						iommu_debugfs_dir);
> +	intel_iommu_debug = debugfs_create_dir("intel", iommu_debugfs_dir);
>   
>   	debugfs_create_file("iommu_regset", 0444, intel_iommu_debug, NULL,
>   			    &iommu_regset_fops);
>   	debugfs_create_file("dmar_translation_struct", 0444, intel_iommu_debug,
>   			    NULL, &dmar_translation_struct_fops);
> -	debugfs_create_file("domain_translation_struct", 0444,
> -			    intel_iommu_debug, NULL,
> -			    &domain_translation_struct_fops);
>   	debugfs_create_file("invalidation_queue", 0444, intel_iommu_debug,
>   			    NULL, &invalidation_queue_fops);
>   #ifdef CONFIG_IRQ_REMAP
> @@ -692,3 +695,123 @@ void __init intel_iommu_debugfs_init(void)
>   	debugfs_create_file("dmar_perf_latency", 0644, intel_iommu_debug,
>   			    NULL, &dmar_perf_latency_fops);
>   }
> +
> +/* Create a debugfs directory for each device. */
> +void intel_iommu_debugfs_create_dev(struct device *dev)
> +{
> +	struct dentry *dev_dir;
> +
> +	dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
> +	if (!dev_dir) {
> +		dev_dir = debugfs_create_dir(dev_name(dev), intel_iommu_debug);
> +		if (IS_ERR(dev_dir))
> +			pr_info("%s: Failed to create debugfs directory.\n",
> +				dev_name(dev));
> +	} else
> +		dput(dev_dir);
> +}

Above could simply be like this:

void intel_iommu_debugfs_create_dev(struct device *dev)
{
	struct device_domain_info *info = dev_iommu_priv_get(dev);

	info->debugfs_entry = debugfs_create_dir(dev_name(dev),
			intel_iommu_debug);
}

Isn't it?

> +
> +void intel_iommu_debugfs_remove_dev(struct device *dev)
> +{
> +	struct dentry *dev_dir, *sub_dir, *dentry;
> +	struct list_head *plist;
> +
> +	dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
> +	if (!dev_dir)
> +		return;
> +
> +	list_for_each(plist, &(dev_dir->d_subdirs)) {
> +		sub_dir = list_entry(plist, struct dentry, d_child);
> +		if(sub_dir) {
> +			dentry = debugfs_lookup("domain_translation_struct",
> +						sub_dir);
> +			if (!dentry)
> +				continue;
> +
> +			if (dentry->d_inode->i_private)
> +				kfree(dentry->d_inode->i_private);
> +
> +			dput(dentry);
> +		}
> +	}
> +
> +	debugfs_remove_recursive(dev_dir);
> +	dput(dev_dir);
> +}

And this could simply be like this:

void intel_iommu_debugfs_remove_dev(struct device *dev)
{
	struct device_domain_info *info = dev_iommu_priv_get(dev);

	debugfs_remove(info->debugfs_entry);
}

> +
> +/*
> + * Create a debugfs directory per pair of {device, pasid},
> + * then create the corresponding debugfs file in this directory
> + * for user to dump its page table. e.g.
> + * /sys/kernel/debug/iommu/intel/0000:00:01.0/0/domain_translation_struct
> + */
> +void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
> +					  struct device *dev, u32 pasid)
> +{
> +	struct dentry *dev_dir, *pasid_dir;
> +	struct show_domain_info *sinfo;
> +	char dir_name[10];
> +
> +	/*
> +	 * The debugfs only dumps the page tables whose mappings are created
> +	 * and destroyed by the iommu_map/unmap() interfaces. Check the
> +	 * mapping type of the domain before creating debugfs directory.
> +	 */
> +	if (!domain || !(domain->type & __IOMMU_DOMAIN_PAGING))
> +		return;
> +
> +	dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
> +	if (!dev_dir)
> +		return;
> +
> +	sprintf(dir_name, "%x", pasid);
> +	pasid_dir = debugfs_create_dir(dir_name, dev_dir);
> +	if (IS_ERR(pasid_dir))
> +		goto dput_out;
> +
> +	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
> +	if (!sinfo)
> +		goto dput_out;
> +
> +	sinfo->dev = dev;
> +	sinfo->pasid = pasid;
> +	debugfs_create_file("domain_translation_struct", 0444,
> +			    pasid_dir, sinfo,
> +			    &domain_translation_struct_fops);
> +dput_out:
> +	dput(dev_dir);
> +}

And here,

void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
					  struct device *dev, u32 pasid)
{
	sprintf(dir_name, "%x", pasid);
	dev_pasid->debugfs_entry = debugfs_create_dir(dir_name,
			info->debugfs_entry);

	debugfs_create_file("domain_translation_struct", 0444,
			    dev_pasid->debugfs_entry, dev_pasid,
			    &domain_translation_struct_fops);
}

> +
> +/*
> + * Remove the debugfs directory and file corresponding to each pair of
> + * {device, pasid}.
> + */
> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 pasid)
> +{
> +	struct dentry *dev_dir, *pasid_dir, *dentry;
> +	char dir_name[10];
> +
> +	dev_dir = debugfs_lookup(dev_name(dev), intel_iommu_debug);
> +	if (!dev_dir)
> +		return;
> +
> +	sprintf(dir_name, "%x", pasid);
> +	pasid_dir = debugfs_lookup(dir_name, dev_dir);
> +	if (!pasid_dir)
> +		goto dput_dev;
> +
> +	dentry = debugfs_lookup("domain_translation_struct", pasid_dir);
> +	if (!dentry)
> +		goto dput_pasid;
> +
> +	if (dentry->d_inode->i_private)
> +		kfree(dentry->d_inode->i_private);
> +
> +	debugfs_remove_recursive(pasid_dir);
> +
> +	dput(dentry);
> +dput_pasid:
> +	dput(pasid_dir);
> +dput_dev:
> +	dput(dev_dir);
> +}

The same thing here:

	debugfs_remove(dev_pasid->debugfs_entry);

> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index dd8ff358867d..af9c989035a2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2488,6 +2488,13 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   
>   	iommu_enable_pci_caps(info);
>   
> +	/*
> +	 * Create a debugfs directory specified by RID_PASID
> +	 * in the debugfs device directory.
> +	 */
> +	intel_iommu_debugfs_create_dev_pasid(&info->domain->domain,
> +			                     dev, IOMMU_NO_PASID);

The function name is self-explained. So no need to add comments. Ditto
to all other places.

> +
>   	return 0;
>   }
>   
> @@ -3997,6 +4004,12 @@ static void device_block_translation(struct device *dev)
>   
>   	domain_detach_iommu(info->domain, iommu);
>   	info->domain = NULL;
> +
> +	/*
> +	 * Remove the debugfs directory specified by RID_PASID
> +	 * in the device debugfs directory.
> +	 */
> +	intel_iommu_debugfs_remove_dev_pasid(dev, IOMMU_NO_PASID);
>   }
>   
>   static int md_domain_init(struct dmar_domain *domain, int guest_width)
> @@ -4424,6 +4437,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   		}
>   	}
>   
> +	/* Create a debugfs directory per device. */
> +	intel_iommu_debugfs_create_dev(dev);
> +
>   	return &iommu->iommu;
>   }
>   
> @@ -4436,6 +4452,7 @@ static void intel_iommu_release_device(struct device *dev)
>   	dev_iommu_priv_set(dev, NULL);
>   	kfree(info);
>   	set_dma_ops(dev, NULL);
> +	intel_iommu_debugfs_remove_dev(dev);
>   }
>   
>   static void intel_iommu_probe_finalize(struct device *dev)
> @@ -4729,6 +4746,12 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   out_tear_down:
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
>   	intel_drain_pasid_prq(dev, pasid);
> +
> +	/*
> +	 * Remove the debugfs directory of the specified pasid
> +	 * in the device debugfs directory.
> +	 */
> +	intel_iommu_debugfs_remove_dev_pasid(dev, pasid);
>   }
>   
>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> @@ -4777,6 +4800,12 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
>   	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>   	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>   
> +	/*
> +	 * Create a debugfs directory with specified pasid
> +	 * in the debugfs device directory.
> +	 */
> +	intel_iommu_debugfs_create_dev_pasid(domain, dev, pasid);
> +
>   	return 0;
>   out_detach_iommu:
>   	domain_detach_iommu(dmar_domain, iommu);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index c18fb699c87a..f1c27e928886 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -883,8 +883,20 @@ static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid
>   
>   #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
>   void intel_iommu_debugfs_init(void);
> +void intel_iommu_debugfs_create_dev(struct device *dev);
> +void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
> +					  struct device *dev, u32 pasid);
> +void intel_iommu_debugfs_remove_dev(struct device *dev);
> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 pasid);
>   #else
>   static inline void intel_iommu_debugfs_init(void) {}
> +static inline void intel_iommu_debugfs_create_dev(struct device *dev) {}
> +static inline
> +void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
> +					  struct device *dev, u32 pasid) {}
> +static inline void intel_iommu_debugfs_remove_dev(struct device *dev) {}
> +static inline
> +void intel_iommu_debugfs_remove_dev_pasid(struct device *dev, u32 pasid) {}
>   #endif /* CONFIG_INTEL_IOMMU_DEBUGFS */
>   
>   extern const struct attribute_group *intel_iommu_groups[];

Best regards,
baolu
