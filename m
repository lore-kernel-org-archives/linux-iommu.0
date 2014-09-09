From: "Su, Friendy" <Friendy.Su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Subject: RE: [PATCH v2 1/1] iommu/amd: set iommu for early mapped ioapic/hpet
Date: Tue, 9 Sep 2014 16:34:52 +0800
Message-ID: <053191AD6E9023439BF3970DE870051856D274B417@APSHAXMS02.ap.sony.com>
References: <053191AD6E9023439BF3970DE870051856D1EF3AC5@APSHAXMS02.ap.sony.com>
	<20140905135320.GP28786@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140905135320.GP28786-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: zh-CN
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Joerg,

> The problem you describe here should also be fixed by this (simpler)
> patch. Can you test this please?

The running result of this patch is correct.

My opinion is we should avoid modifying the original data "early_ioapic_map[i].devid" and "devid from IVHD" since they are original data from user command line and BIOS. At anytime, "early_ioapic_map[i].devid" should reflect the command line setting. So code should not give possibility to modify it. Same to "devid from IVHD" although it is just a local variable. This is why I imported a new argument to add_special_device().

Best Regards
Friendy

> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Friday, September 05, 2014 9:53 PM
> To: Su, Friendy
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v2 1/1] iommu/amd: set iommu for early mapped
> ioapic/hpet
> 
> On Fri, Sep 05, 2014 at 07:25:14PM +0800, Su, Friendy wrote:
> > This issue is found on a mother board whose BIOS reports wrong
> > IOAPIC devid in IVHD table. Without this fix, the early mapped
> > does not really override IVHD. So that the wrong reported IOAPIC
> > does not work.
> 
> The problem you describe here should also be fixed by this (simpler)
> patch. Can you test this please?
> 
> Thanks,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/amd_iommu_init.c
> b/drivers/iommu/amd_iommu_init.c
> index 3783e0b..b0522f1 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -712,7 +712,7 @@ static void __init set_dev_entry_from_acpi(struct
> amd_iommu *iommu,
>  	set_iommu_for_device(iommu, devid);
>  }
> 
> -static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line)
> +static int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
>  {
>  	struct devid_map *entry;
>  	struct list_head *list;
> @@ -731,6 +731,8 @@ static int __init add_special_device(u8 type, u8 id, u16
> devid, bool cmd_line)
>  		pr_info("AMD-Vi: Command-line override present for %s id %d -
> ignoring\n",
>  			type == IVHD_SPECIAL_IOAPIC ? "IOAPIC" : "HPET", id);
> 
> +		*devid = entry->devid;
> +
>  		return 0;
>  	}
> 
> @@ -739,7 +741,7 @@ static int __init add_special_device(u8 type, u8 id, u16
> devid, bool cmd_line)
>  		return -ENOMEM;
> 
>  	entry->id	= id;
> -	entry->devid	= devid;
> +	entry->devid	= *devid;
>  	entry->cmd_line	= cmd_line;
> 
>  	list_add_tail(&entry->list, list);
> @@ -754,7 +756,7 @@ static int __init add_early_maps(void)
>  	for (i = 0; i < early_ioapic_map_size; ++i) {
>  		ret = add_special_device(IVHD_SPECIAL_IOAPIC,
>  					 early_ioapic_map[i].id,
> -					 early_ioapic_map[i].devid,
> +					 &early_ioapic_map[i].devid,
>  					 early_ioapic_map[i].cmd_line);
>  		if (ret)
>  			return ret;
> @@ -763,7 +765,7 @@ static int __init add_early_maps(void)
>  	for (i = 0; i < early_hpet_map_size; ++i) {
>  		ret = add_special_device(IVHD_SPECIAL_HPET,
>  					 early_hpet_map[i].id,
> -					 early_hpet_map[i].devid,
> +					 &early_hpet_map[i].devid,
>  					 early_hpet_map[i].cmd_line);
>  		if (ret)
>  			return ret;
> @@ -978,10 +980,17 @@ static int __init init_iommu_from_acpi(struct
> amd_iommu *iommu,
>  				    PCI_SLOT(devid),
>  				    PCI_FUNC(devid));
> 
> -			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
> -			ret = add_special_device(type, handle, devid, false);
> +			ret = add_special_device(type, handle, &devid, false);
>  			if (ret)
>  				return ret;
> +
> +			/*
> +			 * add_special_device might update the devid in case a
> +			 * command-line override is present. So call
> +			 * set_dev_entry_from_acpi after add_special_device.
> +			 */
> +			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
> +
>  			break;
>  		}
>  		default:
