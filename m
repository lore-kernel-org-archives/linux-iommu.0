Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE93CD8D6
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855383; cv=none; b=qfgoXVbZSdqychFka8FoZ6Hvyteif5aNpQ5FiqSi6jANe05C5bfgELAdEBtkQqHaHV3YxKVE2p9e1n0KwdhlWF10OUgkeCHw54H/GEKMgrkSB7aPKJ0F2HAU2zuPLy/8WoAVfs3tgsma/tptHxqB6lWHvGibo6sOus2qpJPEnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855383; c=relaxed/simple;
	bh=ga8vGwvSmhUL1pKv8aHlbvNC8T5Wa5HQgen+aUReqkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvAWGv/XE14qjBkUGYmCN9r2fcY0NRJrLHEO9pi7G0UBdxREWcf+opE6wVwXxeodZCCrLjPYgqZuDIqnfxPph5MQpMoZ/+veF1drmt49B3/p7936INxTdGe5N7Ed9X9JaSzT/85krgCBPSgn/idqAStVJ4OnwCyLD2nJZZHcenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BG/8x+gh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BG/8x+gh"
Received: from localhost (unknown [167.220.233.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FF1B20B6F01;
	Wed, 22 Apr 2026 03:56:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FF1B20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776855380;
	bh=zL1dDNwvufKUSr+YG3beM+nH61rTQO3dO4cLmHNSj8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BG/8x+ghPAfsmIKtVHqd8Kat1yQE3stKf5D325fl9dAZjF/yY0e6h3qS/ZipcCNUE
	 7c48cXRtrI+Lu3rR6jA2lCcQP3BBAlYL0+a3om1fjOg/2gFBOdhP5tob2851XoHy7J
	 qamt4gUb210HF+NL1+Egm8BOoui4bLI8sLCaMUKE=
Date: Wed, 22 Apr 2026 18:56:11 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	jon.grimm@amd.com, vasant.hegde@amd.com, frank.gorishek@amd.com, 
	thomas.lendacky@amd.com, santosh.shukla@amd.com
Subject: Re: [PATCH 4/4] iommu/amd: Introduce boot option
 ivmd=seg:bus:dev.fun,start,size,flags
Message-ID: <fbukzk36novjgroplqqzqwfhzvrfb5gklcogfcv772yww6agnn@mlj4hmbhb42v>
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
 <20260420170033.6780-5-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420170033.6780-5-suravee.suthikulpanit@amd.com>

On Mon, Apr 20, 2026 at 05:00:33PM +0000, Suravee Suthikulpanit wrote:
> IVRS table contains IVMD blocks, which allow firmware to specify memory
> usage requirements to communicate to system software based on its needs
> or on hardware characteristics. Each IVMD entry may be per-device, range
> of devices.
> 
> Some BIOS specify incorrect or missing IVMD entry. Introduce a new ivmd
> boot option to allow user to specify up-to 4 per-device IVMD entries at
> boot time. The entries are stored during driver initialization, and will
> be added to the per-segment ivmd_entry_map so that they can be included
> during struct iommu_ops.get_resv_regions.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  16 +++
>  drivers/iommu/amd/amd_iommu_types.h           |  14 +++
>  drivers/iommu/amd/init.c                      | 104 +++++++++++++++++-
>  3 files changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a550630644..e680a258008f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2897,6 +2897,22 @@ Kernel parameters
>  			  PCI device ID 00:14.5, write the parameter as:
>  				ivrs_acpihid[0001:00:14.5]=AMD0020:0
>  
> +	ivmd		[HW,X86-64]
> +			Supplement IVMD unity mapping or exclusion ranges from
> +			the kernel command line (in addition to the IVRS ACPI
> +			table). May be specified multiple times.
> +
> +			Form:
> +				ivmd=segment:bus:dev.fn,start,length,flags
> +
> +			start and length are byte counts (decimal or 0x hex).
> +			flags is the IVMD flags byte (UNITY, IR, IW, EXCL bits
> +			per the AMD IOMMU specification). Use segment 0 for
> +			PCI segment zero.
> +
> +			Example:
> +				ivmd=0000:00:01.0,0xe0000000,0x100000,0xb
> +
>  	js=		[HW,JOY] Analog joystick
>  			See Documentation/input/joydev/joystick.rst.
>  
[...]

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 4b62bb89a12c..7d60143d4711 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -208,10 +208,12 @@ enum iommu_init_state {
>  static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
>  static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
>  static struct acpihid_map_entry __initdata early_acpihid_map[EARLY_MAP_SIZE];
> +static struct ivmd_cmdline early_ivmd_cmdline_map[EARLY_MAP_SIZE] __initdata;
>  
>  static int __initdata early_ioapic_map_size;
>  static int __initdata early_hpet_map_size;
>  static int __initdata early_acpihid_map_size;
> +static int early_ivmd_cmdline_map_size __initdata;
>  
>  static bool __initdata cmdline_maps;
>  
> @@ -2653,6 +2655,47 @@ static int __init init_ivmd_map_range(struct ivmd_header *m,
>  	return 0;
>  }
>  
> +static int __init apply_ivmd_cmdline_entries(struct acpi_table_header *ivrs_base)
> +{
> +	int i;
> +	struct ivmd_entry *e;
> +	struct amd_iommu_pci_seg *pci_seg;
> +
> +	for (i = 0; i < early_ivmd_cmdline_map_size; i++) {
> +		struct ivmd_cmdline *cmd = &early_ivmd_cmdline_map[i];
> +
> +		pci_seg = get_pci_segment(cmd->pci_seg, ivrs_base);
> +		if (!pci_seg) {
> +			pr_err("ivmd: PCI segment %#x unavailable\n",
> +			       cmd->pci_seg);
> +			continue;
> +		}
> +
> +		if (cmd->devid > pci_seg->last_bdf) {
> +			pr_err("%s: requestor %#x:%#02x:%#02x.%#02x exceeds segment %#x last BDF %#x\n",
> +			       __func__, cmd->pci_seg, PCI_BUS_NUM(cmd->devid),
> +			       PCI_SLOT(cmd->devid), PCI_FUNC(cmd->devid),
> +			       pci_seg->id, pci_seg->last_bdf);
> +			continue;
> +		}
> +
> +		e = kzalloc(sizeof(*e), GFP_KERNEL);
> +		if (!e) {
> +			kfree(cmd);

cmd points to the early_ivmd_cmdline_map, shall not be kfreed.
> +			return -ENOMEM;
> +		}
[...]

> +static int __init parse_ivmd(char *str)
> +{
> +	u32 seg, bus, dev, fn;
> +	unsigned long long range_start, range_len;
> +	unsigned int flags;
> +	struct ivmd_cmdline *cmd;
> +
> +	if (!str)
> +		goto invalid;
> +
> +	if (sscanf(str, "%x:%x:%x.%x,%llu,%llu,%x",
> +		   &seg, &bus, &dev, &fn, &range_start,
> +		   &range_len, &flags) != 7)

sscanf with %llu cannot parse values with 0x prefix, which the doc above claims
to accept.

> +		goto invalid;
> +

B.R.
Yu
