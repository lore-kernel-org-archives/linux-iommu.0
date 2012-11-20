From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4] intel-iommu: Prevent devices with RMRRs from being
	placed into SI Domain
Date: Tue, 20 Nov 2012 15:37:58 -0500
Message-ID: <50ABEA26.6090500@redhat.com>
References: <20120917082234.22091.84161.sendpatchset@RHEL63BL460c>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120917082234.22091.84161.sendpatchset@RHEL63BL460c>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tom Mingarelli <thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/20/2012 02:43 PM, Tom Mingarelli wrote:
> This patch is to prevent non-USB devices that have RMRRs associated with them from
> being placed into the SI Domain during init. This fixes the issue where the RMRR info
> for devices being placed in and out of the SI Domain gets lost.
>
> Signed-off-by: Thomas Mingarelli<thomas.mingarelli-VXdhtT5mjnY@public.gmane.org>
> Tested-by: Shuah Khan<shuah.khan-VXdhtT5mjnY@public.gmane.org>
> ---
> PATCH v1: https://lkml.org/lkml/2012/6/15/204
> PATCH v2: https://lkml.org/lkml/2012/9/18/354
> PATCH v3: https://lkml.org/lkml/2012/10/16/375
>
>   drivers/iommu/intel-iommu.c |   31 +++++++++++++++++++++++++++++++
>   1 files changed, 31 insertions(+), 0 deletions(-)
>
Thanks for the efforts in getting this completed.
Looks good to me.

Reviewed-by: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d4a4cd4..8c064df 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2320,8 +2320,39 @@ static int domain_add_dev_info(struct dmar_domain *domain,
>   	return 0;
>   }
>
> +static bool device_has_rmrr(struct pci_dev *dev)
> +{
> +	struct dmar_rmrr_unit *rmrr;
> +	int i;
> +
> +	for_each_rmrr_units(rmrr) {
> +		for (i = 0; i<  rmrr->devices_cnt; i++) {
> +			/*
> +			 * Return TRUE if this RMRR contains the device that
> +			 * is passed in.
> +			 */
> +			if (rmrr->devices[i] == dev)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +
>   static int iommu_should_identity_map(struct pci_dev *pdev, int startup)
>   {
> +
> +	/*
> +	 * We want to prevent any device associated with an RMRR from
> +	 * getting placed into the SI Domain. This is done because
> +	 * problems exist when devices are moved in and out of domains
> +	 * and their respective RMRR info is lost. We exempt USB devices
> +	 * from this process due to their usage of RMRRs that are known
> +	 * to not be needed after BIOS hand-off to OS.
> +	 */
> +	if (device_has_rmrr(pdev)&&
> +	    (pdev->class>>  8) != PCI_CLASS_SERIAL_USB)
> +		return 0;
> +
>   	if ((iommu_identity_mapping&  IDENTMAP_AZALIA)&&  IS_AZALIA(pdev))
>   		return 1;
>
