From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: request pcie devices to enable ACS
Date: Mon, 13 Jun 2016 12:18:50 +0100
Message-ID: <575E969A.6070400@arm.com>
References: <1465809617-13003-1-git-send-email-Wei.Chen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465809617-13003-1-git-send-email-Wei.Chen-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wei Chen <Wei.Chen-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, steve.capper-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/06/16 10:20, Wei Chen wrote:
> The PCIe ACS capability will affect the layout of iommu groups.
> Generally speaking, if the path from root port to the PCIe device
> is ACS enabled, the iommu will create a single iommu group for this
> PCIe device. If all PCIe devices on the path are ACS enabled then
> Linux can determine this path is ACS enabled.
>
> Linux use two PCIe configuration registers to determine the ACS
> status of PCIe devices:
> ACS Capability Register and ACS Control Register.
>
> The first register is used to check the implementation of ACS function
> of a PCIe device, the second register is used to check the enable status
> of ACS function. If one PCIe device has implemented and enabled the ACS
> function then Linux will determine this PCIe device enabled ACS.
>
>  From the Chapter:6.12 of PCI Express Base Specification Revision 3.1a,
> we can find that when a PCIe device implements ACS function, the enable
> status is set to disabled by default and can be enabled by ACS-aware
> software.
>
> ACS will affect the iommu groups topology, so, the iommu driver is
> ACS-aware software. This patch adds a call to pci_request_acs() to the
> arm-smmu driver to enable the ACS function in PCIe devices that support
> it.
>
> Signed-off-by: Wei Chen <Wei.Chen-5wv7dgnIgG8@public.gmane.org>

Makes sense to me:

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

p.s. The confidential disclaimer is a good way to get patches ignored 
here on the lists - please check with Steve about getting set up on the 
appropriate SMTP server.

Robin.

> ---
>   drivers/iommu/arm-smmu-v3.c | 2 ++
>   drivers/iommu/arm-smmu.c    | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 94b6821..30ea899 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2686,6 +2686,8 @@ static int __init arm_smmu_init(void)
>          if (ret)
>                  return ret;
>
> +       pci_request_acs();
> +
>          return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>   }
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9345a3f..ab365ec 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2096,8 +2096,10 @@ static int __init arm_smmu_init(void)
>   #endif
>
>   #ifdef CONFIG_PCI
> -       if (!iommu_present(&pci_bus_type))
> +       if (!iommu_present(&pci_bus_type)) {
> +               pci_request_acs();
>                  bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
> +       }
>   #endif
>
>          return 0;
> --
> 2.7.4
>
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
