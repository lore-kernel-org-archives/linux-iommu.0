From: Scott Branden via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v5] vfio: platform: reset: Add Broadcom FlexRM reset module
Date: Tue, 22 Aug 2017 11:47:52 -0700
Message-ID: <ffcc2283-506f-6849-16e7-b0f0e618cd84@broadcom.com>
References: <1503396041-19485-1-git-send-email-anup.patel@broadcom.com>
	<1503396041-19485-2-git-send-email-anup.patel@broadcom.com>
Reply-To: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503396041-19485-2-git-send-email-anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Anup,

We should add default (as below).


On 17-08-22 03:00 AM, Anup Patel wrote:
> This patch adds Broadcom FlexRM low-level reset for
> VFIO platform.
>
> It will do the following:
> 1. Disable/Deactivate each FlexRM ring
> 2. Flush each FlexRM ring
>
> The cleanup sequence for FlexRM rings is adapted from
> Broadcom FlexRM mailbox driver.
>
> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/vfio/platform/reset/Kconfig                |   8 ++
>   drivers/vfio/platform/reset/Makefile               |   1 +
>   .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 100 +++++++++++++++++++++
>   3 files changed, 109 insertions(+)
>   create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>
> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
> index 70cccc5..8833805 100644
> --- a/drivers/vfio/platform/reset/Kconfig
> +++ b/drivers/vfio/platform/reset/Kconfig
> @@ -13,3 +13,11 @@ config VFIO_PLATFORM_AMDXGBE_RESET
>   	  Enables the VFIO platform driver to handle reset for AMD XGBE
>   
>   	  If you don't know what to do here, say N.
> +
> +config VFIO_PLATFORM_BCMFLEXRM_RESET
> +	tristate "VFIO support for Broadcom FlexRM reset"
> +	depends on VFIO_PLATFORM && (ARCH_BCM_IPROC || COMPILE_TEST)
default ARCH_BCM_IPROC
> +	help
> +	  Enables the VFIO platform driver to handle reset for Broadcom FlexRM
> +
> +	  If you don't know what to do here, say N.
>
