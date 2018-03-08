From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
Date: Thu, 8 Mar 2018 16:24:36 +0000
Message-ID: <20180308172436.00006554@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-36-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 12 Feb 2018 18:33:50 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> For PCI devices that support it, enable the PRI capability and handle
> PRI Page Requests with the generic fault handler.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
A couple of nitpicks.

> ---
>  drivers/iommu/arm-smmu-v3.c | 174 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 119 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 8d09615fab35..ace2f995b0c0 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -271,6 +271,7 @@
>  #define STRTAB_STE_1_S1COR_SHIFT	4
>  #define STRTAB_STE_1_S1CSH_SHIFT	6
>  
> +#define STRTAB_STE_1_PPAR		(1UL << 18)
>  #define STRTAB_STE_1_S1STALLD		(1UL << 27)
>  
>  #define STRTAB_STE_1_EATS_ABT		0UL
> @@ -346,9 +347,9 @@
>  #define CMDQ_PRI_1_GRPID_SHIFT		0
>  #define CMDQ_PRI_1_GRPID_MASK		0x1ffUL
>  #define CMDQ_PRI_1_RESP_SHIFT		12
> -#define CMDQ_PRI_1_RESP_DENY		(0UL << CMDQ_PRI_1_RESP_SHIFT)
> -#define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
> -#define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
> +#define CMDQ_PRI_1_RESP_FAILURE		(0UL << CMDQ_PRI_1_RESP_SHIFT)
> +#define CMDQ_PRI_1_RESP_INVALID		(1UL << CMDQ_PRI_1_RESP_SHIFT)
> +#define CMDQ_PRI_1_RESP_SUCCESS		(2UL << CMDQ_PRI_1_RESP_SHIFT)
Mixing fixing up this naming with the rest of the patch does make things a
little harder to read than they would have been if done as separate patches.
Worth splitting?

>  
>  #define CMDQ_RESUME_0_SID_SHIFT		32
>  #define CMDQ_RESUME_0_SID_MASK		0xffffffffUL
> @@ -442,12 +443,6 @@ module_param_named(disable_ats_check, disable_ats_check, bool, S_IRUGO);
>  MODULE_PARM_DESC(disable_ats_check,
>  	"By default, the SMMU checks whether each incoming transaction marked as translated is allowed by the stream configuration. This option disables the check.");
>  
> -enum pri_resp {
> -	PRI_RESP_DENY,
> -	PRI_RESP_FAIL,
> -	PRI_RESP_SUCC,
> -};
> -
>  enum arm_smmu_msi_index {
>  	EVTQ_MSI_INDEX,
>  	GERROR_MSI_INDEX,
> @@ -530,7 +525,7 @@ struct arm_smmu_cmdq_ent {
>  			u32			sid;
>  			u32			ssid;
>  			u16			grpid;
> -			enum pri_resp		resp;
> +			enum page_response_code	resp;
>  		} pri;
>  
>  		#define CMDQ_OP_RESUME		0x44
> @@ -615,6 +610,7 @@ struct arm_smmu_strtab_ent {
>  	struct arm_smmu_s2_cfg		*s2_cfg;
>  
>  	bool				can_stall;
> +	bool				prg_resp_needs_ssid;
>  };
>  
>  struct arm_smmu_strtab_cfg {
> @@ -969,14 +965,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  		cmd[0] |= (u64)ent->pri.sid << CMDQ_PRI_0_SID_SHIFT;
>  		cmd[1] |= ent->pri.grpid << CMDQ_PRI_1_GRPID_SHIFT;
>  		switch (ent->pri.resp) {
> -		case PRI_RESP_DENY:
> -			cmd[1] |= CMDQ_PRI_1_RESP_DENY;
> +		case IOMMU_PAGE_RESP_FAILURE:
> +			cmd[1] |= CMDQ_PRI_1_RESP_FAILURE;
>  			break;
> -		case PRI_RESP_FAIL:
> -			cmd[1] |= CMDQ_PRI_1_RESP_FAIL;
> +		case IOMMU_PAGE_RESP_INVALID:
> +			cmd[1] |= CMDQ_PRI_1_RESP_INVALID;
>  			break;
> -		case PRI_RESP_SUCC:
> -			cmd[1] |= CMDQ_PRI_1_RESP_SUCC;
> +		case IOMMU_PAGE_RESP_SUCCESS:
> +			cmd[1] |= CMDQ_PRI_1_RESP_SUCCESS;
>  			break;
>  		default:
>  			return -EINVAL;
> @@ -1180,9 +1176,16 @@ static int arm_smmu_page_response(struct iommu_domain *domain,
>  		cmd.resume.sid		= sid;
>  		cmd.resume.stag		= resp->page_req_group_id;
>  		cmd.resume.resp		= resp->resp_code;
> +	} else if (master->can_fault) {
> +		cmd.opcode		= CMDQ_OP_PRI_RESP;
> +		cmd.substream_valid	= resp->pasid_present &&
> +					  master->ste.prg_resp_needs_ssid;
> +		cmd.pri.sid		= sid;
> +		cmd.pri.ssid		= resp->pasid;
> +		cmd.pri.grpid		= resp->page_req_group_id;
> +		cmd.pri.resp		= resp->resp_code;
>  	} else {
> -		/* TODO: put PRI response here */
> -		return -EINVAL;
> +		return -ENODEV;
>  	}
>  
>  	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> @@ -1309,6 +1312,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>  			  STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1) <<
>  			 STRTAB_STE_1_STRW_SHIFT);
>  
> +		if (ste->prg_resp_needs_ssid)
> +			dst[1] |= STRTAB_STE_1_PPAR;
> +
>  		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
>  		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE) &&
>  		   !ste->can_stall)
> @@ -1536,40 +1542,32 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  
>  static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
>  {
> -	u32 sid, ssid;
> -	u16 grpid;
> -	bool ssv, last;
> -
> -	sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
> -	ssv = evt[0] & PRIQ_0_SSID_V;
> -	ssid = ssv ? evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK : 0;
> -	last = evt[0] & PRIQ_0_PRG_LAST;
> -	grpid = evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK;
> -
> -	dev_info(smmu->dev, "unexpected PRI request received:\n");
> -	dev_info(smmu->dev,
> -		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
> -		 sid, ssid, grpid, last ? "L" : "",
> -		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
> -		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
> -		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
> -		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
> -		 evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT);
> -
> -	if (last) {
> -		struct arm_smmu_cmdq_ent cmd = {
> -			.opcode			= CMDQ_OP_PRI_RESP,
> -			.substream_valid	= ssv,
> -			.pri			= {
> -				.sid	= sid,
> -				.ssid	= ssid,
> -				.grpid	= grpid,
> -				.resp	= PRI_RESP_DENY,
> -			},
> -		};
> +	u32 sid = evt[0] >> PRIQ_0_SID_SHIFT & PRIQ_0_SID_MASK;
>  
> -		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
> -	}
> +	struct arm_smmu_master_data *master;
> +	struct iommu_fault_event fault = {
> +		.type		= IOMMU_FAULT_PAGE_REQ,
> +		.last_req	= !!(evt[0] & PRIQ_0_PRG_LAST),
> +		.pasid_valid	= !!(evt[0] & PRIQ_0_SSID_V),
> +		.pasid		= evt[0] >> PRIQ_0_SSID_SHIFT & PRIQ_0_SSID_MASK,
> +		.page_req_group_id = evt[1] >> PRIQ_1_PRG_IDX_SHIFT & PRIQ_1_PRG_IDX_MASK,
> +		.addr		= evt[1] & PRIQ_1_ADDR_MASK << PRIQ_1_ADDR_SHIFT,
> +	};
> +
> +	if (evt[0] & PRIQ_0_PERM_READ)
> +		fault.prot |= IOMMU_FAULT_READ;
> +	if (evt[0] & PRIQ_0_PERM_WRITE)
> +		fault.prot |= IOMMU_FAULT_WRITE;
> +	if (evt[0] & PRIQ_0_PERM_EXEC)
> +		fault.prot |= IOMMU_FAULT_EXEC;
> +	if (evt[0] & PRIQ_0_PERM_PRIV)
> +		fault.prot |= IOMMU_FAULT_PRIV;
> +
> +	master = arm_smmu_find_master(smmu, sid);
> +	if (WARN_ON(!master))
> +		return;
> +
> +	iommu_report_device_fault(master->dev, &fault);
>  }
>  
>  static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
> @@ -1594,6 +1592,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>  		}
>  
>  		if (queue_sync_prod(q) == -EOVERFLOW)
> +			/*
> +			 * TODO: flush pending faults, since the SMMU might have
> +			 * auto-responded to the Last request of a pending
> +			 * group
> +			 */
>  			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
>  	} while (!queue_empty(q));
>  
> @@ -1647,7 +1650,8 @@ static int arm_smmu_flush_queues(struct notifier_block *nb,
>  	if (master) {
>  		if (master->ste.can_stall)
>  			arm_smmu_flush_queue(smmu, &smmu->evtq.q, "evtq");
> -		/* TODO: add support for PRI */
> +		else if (master->can_fault)
> +			arm_smmu_flush_queue(smmu, &smmu->priq.q, "priq");
>  		return 0;
>  	}
>  
> @@ -2533,6 +2537,46 @@ static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
>  	return 0;
>  }
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
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
> +	if (!pos)
> +		return -ENOSYS;
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

The function ordering gets a bit random as you add all the new ones,
Might be better to keep each disable following each enable.

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
