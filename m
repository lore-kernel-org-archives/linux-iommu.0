From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] iommu/amd: set iommu for early mapped ioapic/hpet
Date: Wed, 3 Sep 2014 17:05:38 +0200
Message-ID: <20140903150538.GJ28786@8bytes.org>
References: <053191AD6E9023439BF3970DE870051856D1EF3AC4@APSHAXMS02.ap.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <053191AD6E9023439BF3970DE870051856D1EF3AC4-vLFws2UBKuUBqgaMIWwxlo3UfPj+9hkl@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Su, Friendy" <Friendy.Su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 01, 2014 at 02:17:44PM +0800, Su, Friendy wrote:
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 3783e0b..148ab61 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -747,7 +747,7 @@ static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line)
>  	return 0;
>  }
>  
> -static int __init add_early_maps(void)
> +static int __init add_early_maps(struct amd_iommu *iommu)
>  {
>  	int i, ret;
>  
> @@ -758,6 +758,11 @@ static int __init add_early_maps(void)
>  					 early_ioapic_map[i].cmd_line);
>  		if (ret)
>  			return ret;
> +		/*
> +		 * early mapped ioapci overrides ACPI IVRS,
> +		 * they should be always controlled by iommu.
> +		 */
> +		set_iommu_for_device(iommu, early_ioapic_map[i].devid);
>  	}
>  
>  	for (i = 0; i < early_hpet_map_size; ++i) {
> @@ -767,6 +772,11 @@ static int __init add_early_maps(void)
>  					 early_hpet_map[i].cmd_line);
>  		if (ret)
>  			return ret;
> +		/*
> +		 * early mapped hpet overrides ACPI IVRS,
> +		 * they should be always controlled by iommu.
> +		 */
> +		set_iommu_for_device(iommu, early_hpet_map[i].devid);

This doesn't work on machines with multiple IOMMUs in it. Also the
problem only exists if there is no IVHD entry in the IVRS table for the
device containing IOAPIC and HPET.

But if this IVHD entry is not present we can't reliably know which IOMMU
is responsible for a given IOAPIC/HPET.


	Joerg
