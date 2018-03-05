From: Dongdong Liu <liudongdong3-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
Date: Mon, 5 Mar 2018 20:29:26 +0800
Message-ID: <6f55afcf-04b0-0dc4-6c75-064b70e6851c@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-36-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180212183352.22730-36-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

>
> +static int arm_smmu_enable_pri(struct arm_smmu_master_data *master)
> +{
> +	int ret, pos;
> +	struct pci_dev *pdev;
> +	/*
> +	 * TODO: find a good inflight PPR number. We should divide the PRI queue
> +	 * by the number of PRI-capable devices, but it's impossible to know
> +	 * about current and future (hotplugged) devices. So we're at risk of
> +	 * dropping PPRs (and leaking pending requests in the FQ).
> +	 */
> +	size_t max_inflight_pprs = 16;
> +	struct arm_smmu_device *smmu = master->smmu;
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !dev_is_pci(master->dev))
> +		return -ENOSYS;
> +
> +	pdev = to_pci_dev(master->dev);
> +
 From here
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return -ENOSYS;
to here, seems this code is not needed as it is already done in
pci_reset_pri().

Thanks,
Dongdong
> +
> +	ret = pci_reset_pri(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_enable_pri(pdev, max_inflight_pprs);
> +	if (ret) {
> +		dev_err(master->dev, "cannot enable PRI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	master->can_fault = true;
> +	master->ste.prg_resp_needs_ssid = pci_prg_resp_requires_prefix(pdev);
> +
> +	dev_dbg(master->dev, "enabled PRI");
> +
> +	return 0;
> +}
> +
>  static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
>  {
>  	struct pci_dev *pdev;
> @@ -2548,6 +2592,22 @@ static void arm_smmu_disable_ats(struct arm_smmu_master_data *master)
>  	pci_disable_ats(pdev);
>  }
>
> +static void arm_smmu_disable_pri(struct arm_smmu_master_data *master)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev_is_pci(master->dev))
> +		return;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!pdev->pri_enabled)
> +		return;
> +
> +	pci_disable_pri(pdev);
> +	master->can_fault = false;
> +}
> +
>  static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
>  				  struct arm_smmu_master_data *master)
>  {
> @@ -2668,12 +2728,13 @@ static int arm_smmu_add_device(struct device *dev)
>  		master->ste.can_stall = true;
>  	}
>
> -	arm_smmu_enable_ats(master);
> +	if (!arm_smmu_enable_ats(master))
> +		arm_smmu_enable_pri(master);
>
>  	group = iommu_group_get_for_dev(dev);
>  	if (IS_ERR(group)) {
>  		ret = PTR_ERR(group);
> -		goto err_disable_ats;
> +		goto err_disable_pri;
>  	}
>
>  	iommu_group_put(group);
> @@ -2682,7 +2743,8 @@ static int arm_smmu_add_device(struct device *dev)
>
>  	return 0;
>
> -err_disable_ats:
> +err_disable_pri:
> +	arm_smmu_disable_pri(master);
>  	arm_smmu_disable_ats(master);
>
>  	return ret;
> @@ -2702,6 +2764,8 @@ static void arm_smmu_remove_device(struct device *dev)
>  	if (master && master->ste.assigned)
>  		arm_smmu_detach_dev(dev);
>  	arm_smmu_remove_master(smmu, master);
> +
> +	arm_smmu_disable_pri(master);
>  	arm_smmu_disable_ats(master);
>
>  	iommu_group_remove_device(dev);
>
