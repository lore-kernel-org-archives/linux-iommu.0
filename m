From: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Mon, 25 Aug 2014 06:58:25 +0000
Message-ID: <8121916dfcae4c4a9d71377081c082fc@BLUPR03MB566.namprd03.prod.outlook.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1408949099-18677-1-git-send-email-wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Yijing Wang
> Sent: Monday, August 25, 2014 12:15 PM
> To: Joerg Roedel
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; David Woodhouse; Jiang Liu
> Subject: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
> 
> We found some strange devices in HP C7000 and Huawei Storage Server. These
> devices can not be enumerated by OS, but they still did DMA read/write
> without OS management. Because iommu will not create the DMA mapping for
> these devices, the DMA read/write will be blocked by iommu hardware.
> 
> Eg.
> in HP C7000:
>  \-[0000:00]-+-00.0  Intel Corporation Xeon E5/Core i7 DMI2
>              +-01.0-[11]--
> 			 +-01.1-[02]--
> 			 +-02.0-[04]--+-00.0  Emulex Corporation OneConnect 10Gb NIC
> (be3)
> 	         |            +-00.1  Emulex Corporation OneConnect 10Gb NIC (be3)
> 	         |            +-00.2  Emulex Corporation OneConnect 10Gb iSCSI
> Initiator (be3)
> 	         |            \-00.3  Emulex Corporation OneConnect 10Gb iSCSI
> Initiator (be3)
> 	         +-02.1-[12]--
> Kernel only found four devices in bus 0x04, but we found following DMA errors in
> dmesg.
> 
> [ 1438.477262] DRHD: handling fault status reg 402
> [ 1438.498278] DMAR:[DMA Write] Request device [04:00.4] fault addr bdf70000
> [ 1438.498280] DMAR:[fault reason 02] Present bit in context entry is clear
> [ 1438.566458] DMAR:[DMA Write] Request device [04:00.5] fault addr bdf70000
> [ 1438.566460] DMAR:[fault reason 02] Present bit in context entry is clear
> [ 1438.635211] DMAR:[DMA Write] Request device [04:00.6] fault addr bdf70000
> [ 1438.635213] DMAR:[fault reason 02] Present bit in context entry is clear
> [ 1438.703849] DMAR:[DMA Write] Request device [04:00.7] fault addr bdf70000
> [ 1438.703851] DMAR:[fault reason 02] Present bit in context entry is clear
> 
> This patch add a kernel boot command parameter iommu=pt_force=domain:busnum
> that based iommu identity mapping and force to create identity for all devfn in
> the specific bus number to fix this issue.
> 
> Signed-off-by: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
> v1-v2: Documented to kernel-parameter, tested ok in the real broken platforms.
> ---
>  Documentation/kernel-parameters.txt |    2 +
>  arch/x86/include/asm/iommu.h        |    2 +
>  arch/x86/kernel/pci-dma.c           |    8 ++++++
>  drivers/iommu/intel-iommu.c         |   42 +++++++++++++++++++++++++++++++++++
>  4 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-
> parameters.txt
> index 5ae8608..d49a619 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1431,6 +1431,8 @@ bytes respectively. Such letter suffixes can also be
> entirely omitted.
>  		forcesac
>  		soft
>  		pt		[x86, IA-64]
> +		pt_force=[domain:bus] [x86] Force to create identity mapping
> +	                          for all devfn in specific pci bus.
> 
> 
>  	io7=		[HW] IO7 for Marvel based alpha systems
> diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
> index 345c99c..5e3a2d8 100644
> --- a/arch/x86/include/asm/iommu.h
> +++ b/arch/x86/include/asm/iommu.h
> @@ -5,6 +5,8 @@ extern struct dma_map_ops nommu_dma_ops;
>  extern int force_iommu, no_iommu;
>  extern int iommu_detected;
>  extern int iommu_pass_through;
> +extern int iommu_pt_force_bus;
> +extern int iommu_pt_force_domain;
> 
>  /* 10 seconds */
>  #define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index a25e202..bf21d97 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -44,6 +44,8 @@ int iommu_detected __read_mostly = 0;
>   * guests and not for driver dma translation.
>   */
>  int iommu_pass_through __read_mostly;
> +int iommu_pt_force_bus = -1;
> +int iommu_pt_force_domain = -1;
> 
>  extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
> 
> @@ -146,6 +148,7 @@ void dma_generic_free_coherent(struct device *dev, size_t
> size, void *vaddr,
>   */
>  static __init int iommu_setup(char *p)
>  {
> +	char *end;
>  	iommu_merge = 1;
> 
>  	if (!p)
> @@ -192,6 +195,11 @@ static __init int iommu_setup(char *p)
>  #endif
>  		if (!strncmp(p, "pt", 2))
>  			iommu_pass_through = 1;
> +		if (!strncmp(p, "pt_force=", 9)) {
> +			iommu_pass_through = 1;
> +			iommu_pt_force_domain = simple_strtol(p+9, &end, 0);
> +			iommu_pt_force_bus = simple_strtol(end+1, NULL, 0);
> +		}
> 
>  		gart_parse_options(p);
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d1f5caa..08eb5a0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2705,6 +2705,48 @@ static int __init
> iommu_prepare_static_identity_mapping(int hw)
>  				return ret;
>  		}
> 
> +	/* We found some strange devices in HP c7000 and other platforms, they
> +	 * can not be enumerated by OS, and they did DMA read/write without
> +	 * driver management. if we open iommu in these platforms, the DMA
> read/write
> +	 * will be blocked by IOMMU hardware. Currently, we only create identity
> mapping
> +	 * for the devices in OS. To fix this, add iommu=pt_force=segment:busnum
> to
> +	 * force to do identity mapping for the specific bus.
> +	 */
> +	if (iommu_pt_force_bus >= 0 && iommu_pt_force_bus >= 0) {

iommu_pt_force_bus twice?

Thanks
-Bharat

> +		int found = 0;
> +
> +		iommu = NULL;
> +		for_each_active_iommu(iommu, drhd) {
> +			if (iommu_pt_force_domain != drhd->segment)
> +				continue;
> +
> +			for_each_active_dev_scope(drhd->devices, drhd->devices_cnt,
> i, dev) {
> +				if (!dev_is_pci(dev))
> +					continue;
> +
> +				pdev = to_pci_dev(dev);
> +				if (pdev->bus->number == iommu_pt_force_bus ||
> +						(pdev->subordinate
> +						 && pdev->subordinate->number <=
> iommu_pt_force_bus
> +						 && pdev->subordinate->busn_res.end >=
> iommu_pt_force_bus)) {
> +					found = 1;
> +					break;
> +				}
> +			}
> +
> +			if (drhd->include_all) {
> +				found = 1;
> +				break;
> +			}
> +		}
> +
> +		if (found && iommu)
> +			for (i = 0; i < 256; i++)
> +				domain_context_mapping_one(si_domain, iommu,
> iommu_pt_force_bus,
> +						i,  hw ? CONTEXT_TT_PASS_THROUGH :
> +						CONTEXT_TT_MULTI_LEVEL);
> +	}
> +
>  	return 0;
>  }
> 
> --
> 1.7.1
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
